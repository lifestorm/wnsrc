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
PLUGIN.description = "Implements nicknames possible for unmasked/unhidden individuals."

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

ix.char.RegisterVar("nickNames", {
    field = "nickNames",
	default = {},
    isLocal = true,
	bNoDisplay = true
})

ix.config.Add("maxNicknameLength", 40, "The max amount of characters for an assigned nickname.", nil,
    {data = {min = 1, max = 60}, category = "Nicknames"}
)

ix.command.Add("SetNickname", {
	description = "Set a nickname to an unmasked individual.",
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
	description = "Removes a nickname added to an unmasked individual.",
	OnRun = function(self, client)
		if (SERVER) then
			PLUGIN:SetNickName(client, nil)
		end
	end
})