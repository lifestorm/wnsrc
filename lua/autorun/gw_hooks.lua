--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

hook.Add("Initialize", "gw_setup", function()
	CreateConVar("gw_strider_health", 700, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines the amount of HP the strider has when spawned, only applies to newly spawned instances")
	CreateConVar("gw_hunter_health", 2500, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines the amount of HP the hunter has when spawned, only applies to newly spawned instances")
	CreateConVar("gw_harvester_health", 700, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines the amount of HP the harvester has when spawned, only applies to newly spawned instances")
end)

GW = {}

function GW.GetStringAttachment(ent, attach)
	local id = ent:LookupAttachment(attach)
	return ent:GetAttachment(id)
end

if SERVER then
	hook.Add("PlayerLeaveVehicle", "gw_eject", function(ply, vehicle)
		local ent = vehicle:GetNWEntity("GWEnt")

		if IsValid(ent) then
			ent:Eject(ply)
		end
	end)

	hook.Add("KeyPress", "gw_keypress", function(ply, key)
		local vehicle = ply:GetVehicle()

		if not IsValid(vehicle) then
			return
		end

		local ent = vehicle:GetNWEntity("GWEnt")

		if IsValid(ent) then
			ent:KeyPress(ply, key)
		end
	end)
end

if CLIENT then
	hook.Add("CalcView", "gw_calcview", function(ply, pos, ang, fov)
		if ply:GetViewEntity() ~= ply then
			return
		end

		local vehicle = ply:GetVehicle()

		if not IsValid(vehicle) then
			return
		end

		local ent = vehicle:GetNWEntity("GWEnt")

		if not IsValid(ent) then
			return
		end

		local view = {}

		view.origin, view.angles = ent:GetViewData(ply)

		return view
	end)

	hook.Add("HUDPaint", "gw_crosshair", function()
		local ply = LocalPlayer()
		local vehicle = ply:GetVehicle()

		if not IsValid(vehicle) then
			return
		end

		local ent = vehicle:GetNWEntity("GWEnt")

		if not IsValid(ent) then
			return
		end

		local x = ScrW() / 2
		local y = ScrH() / 2

		local gap = 5
		local len = gap + 5

		local col = Color(255, 0, 0)

		if ent:HasLOS() then
			col = Color(0, 255, 0)
		end

		surface.SetDrawColor(col)

		surface.DrawLine(x - len, y, x - gap, y)
		surface.DrawLine(x + len, y, x + gap, y)
		surface.DrawLine(x, y - len, x, y - gap)
		surface.DrawLine(x, y + len, x, y + gap)
	end)
end
