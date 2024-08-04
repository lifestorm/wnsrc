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
	[1] = {"ID TAKIN", color_white, true},
	[2] = {"KONTROL", Color(255, 200, 0)},
	[3] = {"VERILIYOR", Color(0, 255, 0)},
	[4] = {"FREK. LIMITI", Color(255, 0, 0)},
	[5] = {"BEKLE", Color(255, 200, 0)},
	[6] = {"KAPALI", Color(255, 0, 0), true},
	[7] = {"ID TAKIN", Color(255, 0, 0)},
	[8] = {"HAZIRLANIYOR", Color(0, 255, 0)},
	[9] = {"GECERSIZ CID", Color(255, 0, 0)},
	[10] = {"TAMAMLANDI", Color(0, 255, 0)},
	[11] = {"YETERSIZ KREDI", Color(255, 0, 0), true},
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
	self:NetworkVar("Bool", 1, "Enabled")
end