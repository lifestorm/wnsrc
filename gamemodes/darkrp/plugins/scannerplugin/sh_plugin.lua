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

PLUGIN.name = "Scanner Conversion"
PLUGIN.author = "Madeon | Chessnut"
PLUGIN.description = "Une conversion du plugin NS Scanner en IX."

ix.config.Add("pictureDelay", 15, "Intervalle de temps entre les photos des scanners.", nil, {
	category = PLUGIN.name,
	data = {min = 0, max = 60}
})

ix.lang.AddTable("english", {
	scannerPrepDownload = "Préparez-vous à recevoir le téléchargement visuel..."
})

ix.lang.AddTable("french", {
	scannerPrepDownload = "Préparez-vous à recevoir le téléchargement visuel..."
})

ix.lang.AddTable("spanish", {
	scannerPrepDownload = "Préparez-vous à recevoir le téléchargement visuel..."
})

local playerMeta = FindMetaTable("Player")

function playerMeta:IsScanner()
	return IsValid(self.ixScanner)
end

if (CLIENT) then
	PLUGIN.PICTURE_WIDTH = 580
	PLUGIN.PICTURE_HEIGHT = 420
end

ix.util.Include("sv_photos.lua")
ix.util.Include("cl_photos.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("cl_hooks.lua")
