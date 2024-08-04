--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

PLUGIN.minDist = 500 * 500
PLUGIN.maxDist = 1000 * 1000
PLUGIN.newOverlay = ix.util.GetMaterial("effects/combine_mockup5")
PLUGIN.traceFilter = {false, false}

local COMMAND_PREFIX = "/"
local validBeeps = {
	["w"] = true,
	["y"] = true,
}

function PLUGIN:GetHookCallPriority(hook)
	if (hook == "GetCharacterName") then
		return 1100
	end
end

function PLUGIN:GetAdminESPTargets()
	local client = LocalPlayer()
	if (client:IsDispatch()) then
		local targets = {}
		for _ , v in ipairs(player.GetAll()) do
			if (v == client) then continue end
			if (!IsValid(v) or !v:Alive()) then continue end
			if (v:GetNetVar("combineSuitTracked") or v:IsDispatch()) then
				targets[#targets + 1] = v
			end
		end

		return targets
	end
end

function PLUGIN:GetCharacterName(client, chatType)
	if (!client) then return end
	if (LocalPlayer():HasActiveCombineMask() and client:GetNetVar("combineMaskEquipped") and client:GetNetVar("combineSuitName")) then
		return client:GetNetVar("combineSuitName")
	end
end

function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
	if (client:GetNetVar("combineSuitActive") and client:GetNetVar("combineSuitType") != 0) then
		local faction = ix.faction.Get(client:GetNetVar("combineSuitType"))
		if (!faction) then return end

		local name = tooltip:GetRow("name")
		name:SetBackgroundColor(faction.color)
	end
end

function PLUGIN:RenderScreenspaceEffects()
	if (LocalPlayer():HasActiveCombineMask()) then
		if (ix.option.Get("ColorModify", true)) then
			local colorModify = {}
			colorModify["$pp_colour_colour"] = 0.5 + ix.option.Get("ColorSaturation", 0)
			if (system.IsWindows()) then
				colorModify["$pp_colour_brightness"] = -0.02
				colorModify["$pp_colour_contrast"] = 1.2
			end
			DrawColorModify(colorModify)
		end

		render.UpdateScreenEffectTexture()
		self.newOverlay:SetFloat("$alpha", ix.option.Get("CPGUIAlpha") / 100)
		self.newOverlay:SetInt("$ignorez", 1)
		render.SetMaterial(self.newOverlay)
		render.DrawScreenQuad()
	end
end

function PLUGIN:IsPlayerRecognized(client)
	if ((LocalPlayer():HasActiveCombineMask() or LocalPlayer():IsDispatch()) and client:GetNetVar("combineSuitActive")) then
		return true
	end

	if (LocalPlayer():IsDispatch() and (client:IsOTA() or client:IsCP() or client:IsDispatch())) then
		return true
	end
end

function PLUGIN:InitializedPlugins()
	if (!IsValid(ix.gui.combine)) then
		vgui.Create("ixCombineDisplay")
	end

	if (!IsValid(ix.gui.visor)) then
		vgui.Create("ixVisorScroller")
	end
end

function PLUGIN:ChatTextChanged(text)
	local client = LocalPlayer()

	if (!client:HasActiveCombineMask() or (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle())) then return end

	local isTyping = text != ""

	-- If it's starting with slash, it's a command
	if (text:utf8sub(1, 1) == COMMAND_PREFIX) then
		isTyping = false
		local start, _, commandTxt = text:find("/(%w+)%s")
		local command = ix.command.list[commandTxt]

		-- If the command has the "combineBeep" property, we consider it as if the user is typing
		if (start == 1 and ((command and command.combineBeep) or validBeeps[commandTxt])) then
			isTyping = true
		end
	end

	if (self.lastTypingState != isTyping) then
		self.lastTypingState = isTyping
		net.Start("ixTypingBeep")
		net.WriteBool(isTyping)
		net.SendToServer()
	end
end

function PLUGIN:FinishChat()
	if (self.lastTypingState != false) then
		self.lastTypingState = false
		net.Start("ixTypingBeep")
		net.WriteBool(false)
		net.SendToServer()
	end
end

local mat1 = CreateMaterial("GA0249aSFJ3","VertexLitGeneric",{
	["$basetexture"] = "models/debug/debugwhite",
	["$model"] = 1,
	["$translucent"] = 1,
	["$alpha"] = 1,
	["$nocull"] = 1,
	["$ignorez"] = 1
})

function PLUGIN:HUDPaint()
	if (!ix.option.Get("CombineHud") or ix.config.Get("suitsNoConnection")) then return end

	local client = LocalPlayer()
	local isDispatch = client:IsDispatch()

	if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle() and !isDispatch) then return end
	if (!client:GetCharacter()) then return end

	if (client:HasActiveCombineMask() or isDispatch) then
		local item = ix.item.instances[client:GetCharacter():GetCombineSuit()]

		-- If the client it's dispatch then we don't care about the item at all
		-- the item must be a valid ota or cp suit
		if (!isDispatch and (!item or !item.isOTA and !item.isCP)) then return end

		self.aimPoints = {}
		self.names = {}

		cam.Start3D()
			local pos = client:EyePos()
			self.traceFilter[1] = client

			for _ , p in ipairs(player.GetAll()) do
				if (p == client) then continue end
				if (!IsValid(p) or !p:Alive() or (p:GetMoveType() == MOVETYPE_NOCLIP and !p:InVehicle())) then continue end

				local vEyePos = p:EyePos()
				local dist = vEyePos:DistToSqr(pos)
				local cAngle = client:GetAngles().y
				local pAngle = (p:GetPos() - client:GetPos()):Angle().y
				local angDiff = math.AngleDifference(cAngle, pAngle)
				local angCheck = 60

				if (dist < self.maxDist and p:GetNetVar("combineSuitTracked") and client:IsLineOfSightClear(p:LocalToWorld(p:OBBCenter())) and math.abs(angDiff) <= angCheck) then
					local isOTA = p:GetNetVar("combineSuitType") == FACTION_OTA
					local isCP = p:GetNetVar("combineSuitType") == FACTION_CP

					if (!isOTA and !isCP) then return end

					local name = p:GetNetVar("combineSuitActive") and p:GetNetVar("combineSuitName") or "UNKNOWN"

					if ((item and item.isOTA or isDispatch) and ix.option.Get("OTAESP")) then
						render.SuppressEngineLighting(true)
							render.SetColorModulation(isOTA and 255 or 0, 0, isCP and 255 or 0)

							self.traceFilter[2] = p
							if (util.QuickTrace(pos, vEyePos - pos, self.traceFilter).Fraction < 0.95 or client:FlashlightIsOn()) then
								render.SetBlend(math.Remap(math.max(dist, self.minDist), self.minDist, self.maxDist, 1, 0))
							else
								render.SetBlend(math.Remap(math.max(dist, self.minDist), self.minDist, self.maxDist, 0.01, 0))
							end
							render.MaterialOverride(mat1)
							p:DrawModel()

							render.MaterialOverride()
						render.SuppressEngineLighting(false)

						if (isOTA and p:IsWepRaised()) then
							local trace2 = p:GetEyeTraceNoCursor()

							local onScreen = trace2.HitPos:ToScreen()
							local x, y = onScreen.x, onScreen.y
							self.aimPoints[#self.aimPoints + 1] = {x, y, client:IsLineOfSightClear(trace2.HitPos), name}
						end
					end

					self.names[#self.names + 1] = {p, isOTA, isCP, dist}
				end
			end
		cam.End3D()

		self:RenderESPNames(item and item.isOTA or isDispatch)

		if (item and item.isOTA or isDispatch) then
			self:RenderESPAimpoints()
		end
	end
end
