--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


DEFINE_BASECLASS("DModelPanel")

local PANEL = {}
local MODEL_ANGLE = Angle(0, 45, 0)

function PANEL:Init()
	self.brightness = 1
	self:SetCursor("none")
end

function PANEL:SetModel(model, skin, bodygroups)
	if (IsValid(self.Entity)) then
		self.Entity:Remove()
		self.Entity = nil
	end

	if (!ClientsideModel) then
		return
	end

	local entity = ClientsideModel(model, RENDERGROUP_OPAQUE)

	if (!IsValid(entity)) then
		return
	end

	entity:SetNoDraw(true)
	entity:SetIK(false)

	if (skin) then
		entity:SetSkin(skin)
	end

	if bodygroups == true then
		for _, v in ipairs(LocalPlayer():GetBodyGroups() or {}) do
			entity:SetBodygroup(v.id, LocalPlayer():GetBodygroup(v.id))
		end
	end

	local sequence = entity:LookupSequence("idle_unarmed")

	if (sequence <= 0) then
		sequence = entity:SelectWeightedSequence(ACT_IDLE)
	end

	if (sequence > 0) then
		entity:ResetSequence(sequence)
	else
		local found = false

		for _, v in ipairs(entity:GetSequenceList()) do
			if ((v:utf8lower():find("idle") or v:utf8lower():find("fly")) and v != "idlenoise") then
				entity:ResetSequence(v)
				found = true

				break
			end
		end

		if (!found) then
			entity:ResetSequence(4)
		end
	end

	entity.GetProxyColors = function()
		local char = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()
		local proxyColors = char and char.GetProxyColors and char:GetProxyColors() or {}

		if self.overrideProxyColors and istable(self.overrideProxyColors) then
			proxyColors = self.overrideProxyColors
		end

		return proxyColors
	end

	entity:SetAngles(MODEL_ANGLE)

	self.Entity = entity
end

function PANEL:SetCorrectHair(oldHair)
	if !self.Entity or self.Entity and !IsValid(self.Entity) then return end
	if !self.Entity.GetNumBodyGroups then return end
	if !self.Entity.GetModel then return end
	if !self.Entity:GetModel():find("models/willardnetworks/citizens/") then return end

	local hairBG = self.Entity:FindBodygroupByName( "hair" )
	local curHeadwearBG = self.Entity:GetBodygroup(self.Entity:FindBodygroupByName( "headwear" ))
	local curHairBG = self.Entity:GetBodygroup(hairBG)

	local hairBgLength = 0
	for _, v in pairs(self.Entity:GetBodyGroups()) do
		if v.name  != "hair" then continue end
		if !v.submodels then continue end
		if !istable(v.submodels) then continue end

		hairBgLength =  #v.submodels
		break
	end

	if (curHeadwearBG != 0) then
		if curHairBG != 0 then
			self.Entity:SetBodygroup(hairBG, hairBgLength)
		end
	else
		if oldHair then
			self.Entity:SetBodygroup(hairBG, oldHair)
		end
	end
end

function PANEL:LayoutEntity()
	local scrW, scrH = ScrW(), ScrH()
	local xRatio = gui.MouseX() / scrW
	local yRatio = gui.MouseY() / scrH
	local x, _ = self:LocalToScreen(self:GetWide() / 2)
	local xRatio2 = x / scrW
	local entity = self.Entity

	entity:SetPoseParameter("head_pitch", yRatio*90 - 30)
	entity:SetPoseParameter("head_yaw", (xRatio - xRatio2)*90 - 5)
	entity:SetIK(false)

	if (self.copyLocalSequence) then
		entity:SetSequence(LocalPlayer():GetSequence())
		entity:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
	end

	self:RunAnimation()

	local character = LocalPlayer():GetCharacter()
	if (character) then
		local otherbone = hook.Run("CharacterAdjustModelPanelLookupBone", character)
		if otherbone and entity:LookupBone(otherbone) then
			local headpos = entity:GetBonePosition(entity:LookupBone(otherbone))
			entity:SetEyeTarget(headpos-Vector(-15, 0, 0))
			return
		end
	end

	for i = 2, 7 do
		entity:SetFlexWeight( i, 0 )
	end

	for i = 0, 1 do
		entity:SetFlexWeight( i, 1 )
	end
end

function PANEL:DrawModel()
	local brightness = self.brightness * 0.4
	local brightness2 = self.brightness * 1.5

	render.SetStencilEnable(false)
	render.SetColorMaterial()
	render.SetColorModulation(1, 1, 1)
	render.SetModelLighting(0, brightness2, brightness2, brightness2)

	for i = 1, 4 do
		render.SetModelLighting(i, brightness, brightness, brightness)
	end

	local fraction = (brightness / 1) * 0.1

	render.SetModelLighting(5, fraction, fraction, fraction)

	-- Excecute Some stuffs
	if (self.enableHook) then
		hook.Run("DrawHelixModelView", self, self.Entity)
	end

	self.Entity:DrawModel()
end

function PANEL:OnMousePressed()
end

vgui.Register("ixModelPanel", PANEL, "DModelPanel")
