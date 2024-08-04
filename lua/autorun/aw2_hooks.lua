--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AW2_HEALTHY 	= 0
AW2_CRASHING 	= 1
AW2_DEAD 		= 2

hook.Add("Initialize", "aw2_setup", function()
	CreateConVar("aw2_chopper_health", 2500, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines the amount of HP the hunter chopper has when spawned, only applies to newly spawned instances")
	CreateConVar("aw2_chopper_speedmult", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines how fast the hunter chopper moves, only applies to newly spawned instances")
	CreateConVar("aw2_chopper_rocketonly", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Whether or not the chopper only takes damage from explosives")

	CreateConVar("aw2_gunship_health", 2500, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines the amount of HP the gunship has when spawned, only applies to newly spawned instances")
	CreateConVar("aw2_gunship_speedmult", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines how fast the hunter chopper moves, only applies to newly spawned instances")
	CreateConVar("aw2_gunship_rocketonly", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Whether or not the gunship only takes damage from explosives")

	CreateConVar("aw2_hk_health", 2500, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines the amount of HP the gunship has when spawned, only applies to newly spawned instances")
	CreateConVar("aw2_hk_speedmult", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines how fast the hunter chopper moves, only applies to newly spawned instances")
	CreateConVar("aw2_hk_rocketonly", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Whether or not the HK-Aerial only takes damage from explosives")

	CreateConVar("aw2_dropship_speedmult", 1000, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines how fast the hunter chopper moves, only applies to newly spawned instances")

	CreateConVar("aw2_manhack_health", 100, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines the amount of HP the manhack has when spawned, only applies to newly spawned instances")
	CreateConVar("aw2_manhack_speedmult", 300, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Determines how fast the hunter chopper moves, only applies to newly spawned instances")

	CreateConVar("aw2_alwayson", 0, {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Whether or not entities remain 'on' when empty")
end)



if SERVER then
	hook.Add("PlayerLeaveVehicle", "aw2_eject", function(ply, vehicle)
		if vehicle.aw2Ent and vehicle.aw2Ent:IsValid() then
			vehicle.aw2Ent:ejectPlayer(ply, vehicle)
		end
	end)

	hook.Add("KeyPress", "aw2_keypress", function(ply, key)
		local ent = ply.aw2Ent

		if ent and ent:IsValid() then
			ent:keyPress(ply, key)
		end
	end)
end

if CLIENT then
	hook.Add("CalcView", "aw2_calcview", function(ply, pos, ang, fov)
		local ent = ply.aw2Ent
		local vehicle = ply:GetVehicle()

		if not vehicle or not vehicle:IsValid() then
			return
		end

		if ply:GetViewEntity() ~= ply then
			return
		end

		if ent and ent:IsValid() then
			local view = {}

			view.origin, view.angles = ent:getViewData(ply)

			return view
		end
	end)

	hook.Add("HUDPaint", "aw2_crosshair", function()
		local ply = LocalPlayer()
		local ent = ply.aw2Ent

		if not IsValid(ent) or not ent.GetGunOperator then
			return
		end

		local gunner = ent:GetGunOperator()

		if ply == gunner then
			local x = ScrW() / 2
			local y = ScrH() / 2

			local gap = 5
			local len = gap + 5

			local col = Color(255, 0, 0)

			if ent:hasLOS() then
				col = Color(0, 255, 0)
			end

			surface.SetDrawColor(col)

			surface.DrawLine(x - len, y, x - gap, y)
			surface.DrawLine(x + len, y, x + gap, y)
			surface.DrawLine(x, y - len, x, y - gap)
			surface.DrawLine(x, y + len, x, y + gap)

			if ent.GetWeaponMode then
				local mode = ent:GetWeaponMode()
				local fancyMode = ""

				if mode == WEAPON_BOMBSINGLE then
					fancyMode = "1"
				elseif mode == WEAPON_BOMBCARPET then
					fancyMode = "3"
				elseif mode == WEAPON_ROCKET then
					fancyMode = "R"
				end

				surface.SetFont("Default")
				surface.SetTextColor(col)
				surface.SetTextPos(x + 5, y + 2)
				surface.DrawText(fancyMode)
			end
		end
	end)
end