--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local vector_origin = Vector()

local att, angpos, attname, elemname, targetent
SWEP.FlashlightDistance = 12 * 50 -- default 50 feet
SWEP.FlashlightAttachment = 0
SWEP.FlashlightBrightness = 1
SWEP.FlashlightFOV = 60

local Material = Material
local ProjectedTexture = ProjectedTexture
local math = math

local function IsHolstering(wep)
	if IsValid(wep) and TFA.Enum.HolsterStatus[wep:GetStatus()] then return true end

	return false
end

-- TODO: This seems to be *extremely* similar to drawlaser
-- Should we merge them?
function SWEP:DrawFlashlight(is_vm)
	local self2 = self:GetTable()

	if not self2.FlashlightDotMaterial then
		self2.FlashlightDotMaterial = Material(self2.GetStatL(self, "FlashlightMaterial") or "effects/flashlight001")
	end

	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not self:GetFlashlightEnabled() then
		self:CleanFlashlight()

		return
	end

	if is_vm then
		if not self:VMIV() then
			self:CleanFlashlight()

			return
		end

		targetent = ply:GetViewModel()
		elemname = self2.GetStatL(self, "Flashlight_VElement", self2.GetStatL(self, "Flashlight_Element"))

		local ViewModelElements = self:GetStatRaw("ViewModelElements", TFA.LatestDataVersion)

		if elemname and ViewModelElements[elemname] and IsValid(ViewModelElements[elemname].curmodel) then
			targetent = ViewModelElements[elemname].curmodel
		end

		att = self2.GetStatL(self, "FlashlightAttachment")

		attname = self2.GetStatL(self, "FlashlightAttachmentName")

		if attname then
			att = targetent:LookupAttachment(attname)
		end

		if (not att) or att <= 0 then
			self:CleanFlashlight()

			return
		end

		angpos = targetent:GetAttachment(att)

		if not angpos then
			self:CleanFlashlight()

			return
		end

		if self2.FlashlightISMovement and self2.CLIronSightsProgress > 0 then
			local isang = self2.GetStatL(self, "IronSightsAngle")
			angpos.Ang:RotateAroundAxis(angpos.Ang:Right(), isang.y * (self2.ViewModelFlip and -1 or 1) * self2.CLIronSightsProgress)
			angpos.Ang:RotateAroundAxis(angpos.Ang:Up(), -isang.x * self2.CLIronSightsProgress)
		end

		local localProjAng = select(2, WorldToLocal(vector_origin, angpos.Ang, vector_origin, EyeAngles()))
		localProjAng.p = localProjAng.p * ply:GetFOV() / self2.ViewModelFOV
		localProjAng.y = localProjAng.y * ply:GetFOV() / self2.ViewModelFOV
		local wsProjAng = select(2, LocalToWorld(vector_origin, localProjAng, vector_origin, EyeAngles())) --reprojection for view angle

		if not IsValid(ply.TFAFlashlightGun) and not IsHolstering(self) then
			local lamp = ProjectedTexture()
			ply.TFAFlashlightGun = lamp
			lamp:SetTexture(self2.FlashlightDotMaterial:GetString("$basetexture"))
			lamp:SetFarZ(self2.GetStatL(self, "FlashlightDistance")) -- How far the light should shine
			lamp:SetFOV(self2.GetStatL(self, "FlashlightFOV"))
			lamp:SetPos(angpos.Pos)
			lamp:SetAngles(angpos.Ang)
			lamp:SetBrightness(self2.GetStatL(self, "FlashlightBrightness") * (0.9  + 0.1 * math.max(math.sin(CurTime() * 120), math.cos(CurTime() * 40))))
			lamp:SetNearZ(1)
			lamp:SetColor(color_white)
			lamp:SetEnableShadows(true)
			lamp:Update()
		end

		local lamp = ply.TFAFlashlightGun

		if IsValid(lamp) then
			lamp:SetPos(angpos.Pos)
			lamp:SetAngles(wsProjAng)
			lamp:SetBrightness(1.4 + 0.1 * math.max(math.sin(CurTime() * 120), math.cos(CurTime() * 40)))
			lamp:Update()
		end

		return
	end

	targetent = self

	elemname = self2.GetStatL(self, "Flashlight_WElement", self2.GetStatL(self, "Flashlight_Element"))

	local WorldModelElements = self:GetStatRaw("WorldModelElements", TFA.LatestDataVersion)

	if elemname and WorldModelElements[elemname] and IsValid(WorldModelElements[elemname].curmodel) then
		targetent = WorldModelElements[elemname].curmodel
	end

	att = self2.GetStatL(self, "FlashlightAttachmentWorld", self2.GetStatL(self, "FlashlightAttachment"))

	attname = self2.GetStatL(self, "FlashlightAttachmentNameWorld", self2.GetStatL(self, "FlashlightAttachmentName"))

	if attname then
		att = targetent:LookupAttachment(attname)
	end

	if (not att) or att <= 0 then
		self:CleanFlashlight()

		return
	end

	angpos = targetent:GetAttachment(att)

	if not angpos then
		angpos = targetent:GetAttachment(1)
	end

	if not angpos then
		self:CleanFlashlight()

		return
	end

	if not IsValid(ply.TFAFlashlightGun) and not IsHolstering(self) then
		local lamp = ProjectedTexture()
		ply.TFAFlashlightGun = lamp
		lamp:SetTexture(self2.FlashlightDotMaterial:GetString("$basetexture"))
		lamp:SetFarZ(self2.GetStatL(self, "FlashlightDistance")) -- How far the light should shine
		lamp:SetFOV(self2.GetStatL(self, "FlashlightFOV"))
		lamp:SetPos(angpos.Pos)
		lamp:SetAngles(angpos.Ang)
		lamp:SetBrightness(self2.GetStatL(self, "FlashlightBrightness") * (0.9  + 0.1 * math.max(math.sin(CurTime() * 120), math.cos(CurTime() * 40))))
		lamp:SetNearZ(1)
		lamp:SetColor(color_white)
		lamp:SetEnableShadows(false)
		lamp:Update()
	end

	local lamp = ply.TFAFlashlightGun

	if IsValid(lamp) then
		local lamppos = angpos.Pos
		local ang = angpos.Ang
		lamp:SetPos(lamppos)
		lamp:SetAngles(ang)
		lamp:SetBrightness(self2.GetStatL(self, "FlashlightBrightness") * (0.9  + 0.1 * math.max(math.sin(CurTime() * 120), math.cos(CurTime() * 40))))
		lamp:Update()
	end
end

function SWEP:CleanFlashlight()
	local ply = self:GetOwner()

	if IsValid(ply) and IsValid(ply.TFAFlashlightGun) then
		ply.TFAFlashlightGun:Remove()
	end
end