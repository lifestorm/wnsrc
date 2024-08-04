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
ENT.Author = "Fruity"
ENT.PrintName = "Ordinateur de Médecin"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

ENT.Displays = {
	[1] = {"EN ATTENTE", Color( 255, 255, 180 ), true},
	[2] = {"RÉCUPÉRATION INFO.", Color(0, 255, 0)},
	[3] = {"RECHARGEMENT", Color(255, 200, 0)},
	[4] = {"HORS-LIGNE", Color(255, 0, 0), true}
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
end