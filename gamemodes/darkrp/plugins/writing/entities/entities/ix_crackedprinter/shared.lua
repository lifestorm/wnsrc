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
ENT.PrintName = "Imprimante crackée"
ENT.Base = "ix_newspaperprinter"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true
ENT.cracked = true

ENT.Displays = {
	[1] = {"EN ATTENTE D'UN UTILISATEUR", Color( 255, 255, 180 ), true},
	[2] = {"RÉCUPÉRATION DES INFORMATIONS", Color(0, 255, 0)},
	[3] = {"PAS DE PAPIER/ENCRE", Color(255, 0, 0)},
	[4] = {"PAS DE PAPIER", Color(255, 0, 0)},
	[5] = {"PAS D'ENCRE", Color(255, 0, 0)},
	[6] = {"RECHARGEMENT", Color(255, 200, 0)},
	[7] = {"EN ATTENTE", Color(255, 255, 180), true},
	[8] = {"IMPRESSION", Color( 0, 255, 0 ), true},
	[9] = {"AUCUN PERMIS", Color(255, 0, 0)},
	[10] = {"PAS DE CID REQUIS", Color(0, 255, 0)},
	[11] = {"LE PAPIER EST ÉPUISÉ", Color(0, 255, 0)},
	[12] = {"ENCRE MAXIMALE", Color(0, 255, 0)},
	[13] = {"CID INVALIDE", Color(255, 0, 0)}
}
