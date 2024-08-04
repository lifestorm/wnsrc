--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

resource.AddFile( "resource/fonts/v-fjallaone-regular.ttf" ) -- should overwrite wn content pack fjalla one as it doesnt pl chars
local PLUGIN = PLUGIN

PLUGIN.name = "Writing Essentials"
PLUGIN.author = "Fruity"
PLUGIN.description = "Newspapers, notepads, papers."

PLUGIN.cachedNewspapers = PLUGIN.cachedNewspapers or {}
PLUGIN.cachedNotepads = PLUGIN.cachedNotepads or {}
PLUGIN.cachedPapers = PLUGIN.cachedPapers or {}
PLUGIN.cachedBooks = PLUGIN.cachedBooks or {}

PLUGIN.identifiers = {"newspaper", "paper", "notepad", "book", "unionnewspaper"}

PLUGIN.validHandwriting = {
	BookCaveat = "Caveat",
	BookKalam = "Kalam",
	BookDancing = "Dancing Script",
	BookCourgette = "Courgette",
	BookAmita = "Amita",
	BookTimes = "Times New Roman",
	BookCourier = "Courier Prime"
}

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

ix.char.RegisterVar("handwriting", {
	field = "handwriting",
	fieldType = ix.type.string,
	default = "",
	isLocal = true,
	bNoDisplay = true
})

ix.command.Add("CharSetHandwriting", {
	description = "@cmdCharSetHandwriting",
	adminOnly = true,
	argumentNames = {"target", "Caveat | Kalam | Dancing | Courgette | Amita | Times | Courier"},
	arguments = {ix.type.character, ix.type.text},
	OnRun = function(self, client, target, font)
        if (CLIENT) then return end

		font = "Book" .. font

        PLUGIN:SetHandwriting(client, target, font)
	end
})

ix.command.Add("ChangeHandwriting", {
	description = "Change your character's handwriting.",
	OnRun = function(self, client)
		netstream.Start(client, "ixWritingOpenHandWritingSelector")
	end
})

do
	for _, identifier in pairs(PLUGIN.identifiers) do
		if identifier == "newspaper" then continue end
		ix.config.Add("maxEditTimes"..Schema:FirstToUpper(identifier), 3, "The max edit times of a "..identifier..".", nil, {
			data = {min = 1, max = 20},
			category = "Writing"
		})
	end
end