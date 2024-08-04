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

PLUGIN.name = "Nicknames"
PLUGIN.author = "Fruity"
PLUGIN.description = "Implémente les surnoms possibles pour les individus non masqués/non masqués."

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

ix.char.RegisterVar("nickNames", {
    field = "nickNames",
	default = {},
    isLocal = true,
	bNoDisplay = true
})

ix.config.Add("maxNicknameLength", 40, "Le nombre maximum de caractères pour un surnom attribué.", nil,
    {data = {min = 1, max = 60}, category = "Nicknames"}
)

ix.command.Add("SetNickname", {
	description = "Attribuez un surnom à une personne non masquée.",
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, nickname)
		if (SERVER) then
			PLUGIN:SetNickName(client, nickname)
		end
	end
})

ix.command.Add("RemoveNickname", {
	description = "Supprime un surnom ajouté à un individu non masqué.",
	OnRun = function(self, client)
		if (SERVER) then
			PLUGIN:SetNickName(client, nil)
		end
	end
})