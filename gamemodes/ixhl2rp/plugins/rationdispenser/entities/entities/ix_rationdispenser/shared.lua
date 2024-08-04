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

ENT.Type = "anim"
ENT.PrintName = "Ration Dispenser"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

ENT.canMalfunction = true

ENT.Displays = {
	[1] = {"WŁÓŻ CID", color_white, true},
	[2] = {"SKAN CID", Color(255, 200, 0)},
	[3] = {"WYDAWANIE", Color(0, 255, 0)},
	[4] = {"LIMIT CZAS.", Color(255, 0, 0)},
	[5] = {"OCZEKUJ", Color(255, 200, 0)},
	[6] = {"OFFLINE", Color(255, 0, 0), true},
	[7] = {"WŁÓŻ CID", Color(255, 0, 0)},
	[8] = {"WYDAWANIE", Color(0, 255, 0)},
	[9] = {"BŁĘDNY CID", Color(255, 0, 0)},
	[10] = {"WYDANO", Color(0, 255, 0)},
	[11] = {"BRAK ŚRODKÓW", Color(255, 0, 0), true},
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
	self:NetworkVar("Bool", 1, "Enabled")
end