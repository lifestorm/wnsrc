--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local IsValid = IsValid
local LocalPlayer = LocalPlayer
local DynamicLight = DynamicLight
local math = math
local CurTime = CurTime
local ix = ix
local hook = hook
local CAMI = CAMI
local ScrW = ScrW
local ScrH = ScrH
local pairs = pairs
local ents = ents
local string = string
local ipairs = ipairs
local surface = surface
local ColorAlpha = ColorAlpha
local table = table
local Color = Color

local PLUGIN = PLUGIN

PLUGIN.dimDistance = 1024

net.Receive("ixObserverFlashlight", function(len, ply)
	LocalPlayer():EmitSound("buttons/lightswitch2.wav")
end)

function PLUGIN:ShouldPopulateEntityInfo(entity)
	if (IsValid(entity) and
		(entity:IsPlayer() or IsValid(entity:GetNetVar("player"))) and
		(entity:GetMoveType() == MOVETYPE_NOCLIP and !entity:InVehicle())) then
		return false
	end
end

function PLUGIN:DrawPhysgunBeam(client, physgun, enabled, target, bone, hitPos)
	if (client != LocalPlayer() and client:GetMoveType() == MOVETYPE_NOCLIP) then
		return false
	end
end

function PLUGIN:PrePlayerDraw(client)
	if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then
		return true
	end
end

function PLUGIN:Think()
	if (!LocalPlayer():GetLocalVar("observerLight") or ix.option.Get("observerFullBright", false)) then return end

	local dlight = DynamicLight(LocalPlayer():EntIndex())
	if (dlight) then
		local trace = LocalPlayer():GetEyeTraceNoCursor()
		dlight.pos = LocalPlayer():GetShootPos() + LocalPlayer():EyeAngles():Forward() * -100
		dlight.r = 255
		dlight.g = 255
		dlight.b = 255
		dlight.brightness = math.Remap(math.Clamp(trace.HitPos:DistToSqr(LocalPlayer():EyePos()), 100, 10000), 100, 10000, 0.01, 1)
		dlight.Decay = 20000
		dlight.Size = 2000
		dlight.DieTime = CurTime() + 0.1
	end
end

function PLUGIN:ThirdPersonToggled(oldValue, value)
	if (value and LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and !LocalPlayer():InVehicle()) then
		ix.option.Set("thirdpersonEnabled", false)
	end
end

function PLUGIN:HUDPaint()
	local client = LocalPlayer()

	local drawESP = hook.Run("ShouldDrawAdminESP")
	if (drawESP == nil) then
		drawESP = ix.option.Get("observerESP", true) and client:GetMoveType() == MOVETYPE_NOCLIP and
		!client:InVehicle() and CAMI.PlayerHasAccess(client, "Helix - Observer", nil)
	end

	if (drawESP) then
		local scrW, scrH = ScrW(), ScrH()
		local marginX, marginY = scrH * .1, scrH * .1
		self:DrawPlayerESP(client, scrW, scrH)

		if (ix.observer:ShouldRenderAnyTypes() and CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer Extra ESP", nil)) then
			for _, ent in pairs(ents.GetAll()) do
				if (!IsValid(ent)) then continue end

				local class = string.lower(ent:GetClass())
				if (ix.observer.types[class] and ix.option.Get(ix.observer.types[class][1])) then
					local screenPosition = ent:GetPos():ToScreen()
					local x, y = math.Clamp(screenPosition.x, marginX, scrW - marginX), math.Clamp(screenPosition.y, marginY, scrH - marginY)
					if ((x != screenPosition.x or screenPosition.y != y) and !ix.observer.types[class][3]) then
						continue
					end

					local distance = client:GetPos():Distance(ent:GetPos())
					local factor = 1 - math.Clamp(distance / self.dimDistance, 0, 1)
					ix.observer.types[class][2](client, ent, x, y, factor, distance)
				end
			end
		end

		local points = {}
		hook.Run("DrawPointESP", points)
		for _, v in ipairs(points) do
			local screenPosition = v[1]:ToScreen()
			local x, y = math.Clamp(screenPosition.x, marginX, scrW - marginX), math.Clamp(screenPosition.y, marginY, scrH - marginY)

			local distance = client:GetPos():Distance(v[1])
			local alpha = math.Remap(math.Clamp(distance, v[4] or 1500, v[5] or 2000), v[4] or 1500, v[4] or 2000, 255, v[6] or 0)
			local size = math.Remap(math.Clamp(distance, 0, v[5] or 2000), v[4] or 1500, v[4] or 2000, 10, 2)
			local drawColor = v[3] or color_white

			surface.SetDrawColor(drawColor.r, drawColor.g, drawColor.b, alpha)
			surface.SetFont("ixGenericFont")
			surface.DrawRect(x - size / 2, y - size / 2, size, size)
			ix.util.DrawText(v[2], x, y - (size + 5), ColorAlpha(drawColor, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
		end
	end
end

function PLUGIN:DrawPointESP(points)
	if (ix.option.Get("mapscenesESP")) then
		local scenes = hook.Run("GetMapscenes")

		if (scenes and !table.IsEmpty(scenes)) then
			for k, v in pairs(scenes) do
				points[#points + 1] = {v[1],  "Mapscene #"..k..", "..v[3], Color(50, 191, 179)}
			end
		end
	end
end

local blacklist = {
	["ix_hands"] = true,
	["ix_keys"] = true,
	["gmod_tool"] = true,
	["weapon_physgun"] = true,
}

function PLUGIN:GetPlayerESPText(client, toDraw, distance, alphaFar, alphaMid, alphaClose)
	toDraw[#toDraw + 1] = {alpha = alphaMid, priority = 11, text = client:SteamName()}

	local weapon = client:GetActiveWeapon()
	if (IsValid(weapon) and !blacklist[weapon:GetClass()]) then
		toDraw[#toDraw + 1] = {alpha = alphaMid, priority = 15, text = "Weapon: "..weapon:GetClass()}
	end
end

function PLUGIN:PreRender()
	if (LocalPlayer():GetLocalVar("observerLight") and ix.option.Get("observerFullBright", false)) then
		render.SetLightingMode(1)
	end
end

function PLUGIN:PreDrawHUD()
	if (LocalPlayer():GetLocalVar("observerLight") and ix.option.Get("observerFullBright", false)) then
		render.SetLightingMode(0)
	end
end

-- Overriding the SF2 PostDraw2DSkyBox hook otherwise fullbright doesn't work.
hook.Add("PostDraw2DSkyBox", "StormFox2.SkyBoxRender", function()
	if (LocalPlayer():GetLocalVar("observerLight") and ix.option.Get("observerFullBright", false)) then return end

	if (!StormFox2 or !StormFox2.Loaded or !StormFox2.Setting.SFEnabled()) then return end
	if (!StormFox2.util or !StormFox2.Sun or !StormFox2.Moon or !StormFox2.Moon.GetAngle) then return end

	local c_pos = StormFox2.util.RenderPos()
	local sky = StormFox2.Setting.GetCache("enable_skybox", true)
	local use_2d = StormFox2.Setting.GetCache("use_2dskybox",false)
	cam.Start3D(Vector(0, 0, 0), EyeAngles(), nil, nil, nil, nil, nil, 1, 32000)  -- 2d maps fix
		render.OverrideDepthEnable(false,false)
		render.SuppressEngineLighting(true)
		render.SetLightingMode(2)
		if (!use_2d or !sky) then
			hook.Run("StormFox2.2DSkybox.StarRender", c_pos)

			-- hook.Run("StormFox2.2DSkybox.BlockStarRender",c_pos)
			hook.Run("StormFox2.2DSkybox.SunRender", c_pos) -- No need to block, shrink the sun.

			hook.Run("StormFox2.2DSkybox.Moon", c_pos)
		end
		hook.Run("StormFox2.2DSkybox.CloudBox", c_pos)
		hook.Run("StormFox2.2DSkybox.CloudLayer", c_pos)
		hook.Run("StormFox2.2DSkybox.FogLayer",	c_pos)
		render.SuppressEngineLighting(false)
		render.SetLightingMode(0)
		render.OverrideDepthEnable( false, false )
	cam.End3D()

	render.SetColorMaterial()
end)