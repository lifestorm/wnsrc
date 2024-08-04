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

PLUGIN.name = "Notes"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Ajoute des notes côté client pour les joueurs et des notes réservées aux administrateurs pour les personnages."

ix.config.Add("notesMaxLen", 2048, "Longueur maximale des notes", nil, {
	data = {min = 64, max = 5096},
	category = "Autres"
})

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

ix.char.RegisterVar("notes", {
	field = "notes",
	fieldType = ix.type.string,
	default = "",
	isLocal = true,
	bNoDisplay = true,
	bNetworked = true
})

ix.command.Add("CharNotes", {
	description = "Définissez les notes du personnage que seuls les administrateurs peuvent voir",
	privilege = "Helix - Basic Admin Commands",
	arguments = {
		ix.type.character
	},
	OnRun = function(self, client, target)
		netstream.Start(client, "ixNotes", target:GetID(), target:GetNotes())
	end
})
