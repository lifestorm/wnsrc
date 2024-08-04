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
ENT.PrintName = "Distributeur de rations"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

ENT.Displays = {
	[1] = {"INSERER CID", color_white, true},
	[2] = {"VÉRIFICATION", Color(255, 200, 0)},
	[3] = {"DISTRIBUTION", Color(0, 255, 0)},
	[4] = {"FREQ. LIMITE", Color(255, 0, 0)},
	[5] = {"ATTENDEZ", Color(255, 200, 0)},
	[6] = {"HORS LIGNE", Color(255, 0, 0), true},
	[7] = {"INSERER CID", Color(255, 0, 0)},
	[8] = {"PRÉPARATION", Color(0, 255, 0)},
	[9] = {"CID INVALIDE", Color(255, 0, 0)},
	[10] = {"COMPLÉTÉ", Color(0, 255, 0)},
	[11] = {"PAS DE CRÉDITS", Color(255, 0, 0), true},
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
	self:NetworkVar("Bool", 1, "Enabled")
end