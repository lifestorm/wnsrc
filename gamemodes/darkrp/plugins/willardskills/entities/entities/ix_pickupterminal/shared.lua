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
ENT.PrintName		= "Terminal de dépôt"
ENT.Author			= "Fruity"
ENT.Contact			= "Willard Networks"
ENT.Purpose			= "Ramasser les objets achetés avec certaines compétences."
ENT.Instructions	= "Pressez E"
ENT.Category = "HL2 RP"

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

ENT.Displays = {
	[1] = {"EN ATTENTE DU CID", Color( 255, 255, 180 ), true},
	[2] = {"VÉRIFICATION", Color(255, 200, 0)},
	[3] = {"DISTRIBUTION", Color(0, 255, 0)},
	[4] = {"RECHARGEMENT", Color(255, 200, 0)},
	[5] = {"HORS-LIGNE", Color(255, 0, 0), true},
	[6] = {"EN ATTENTE DU CID", Color( 255, 255, 180 )},
	[7] = {"PRÉPARATION", Color(0, 255, 0)},
	[8] = {"AUCUN ARTICLE ACHETÉ", Color(0, 255, 0)},
	[9] = {"CID INVALIDE", Color(255, 0, 0)},
	[10] = {"OBJET AJOUTÉ", Color(0, 255, 0)},
	[11] = {"OBJET RETIRÉ", Color(255, 0, 0), true},
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
end