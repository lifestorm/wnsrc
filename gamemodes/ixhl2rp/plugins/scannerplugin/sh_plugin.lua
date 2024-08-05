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
PLUGIN.description = "A conversion of the NS Scanner plugin to IX."

ix.config.Add("pictureDelay", 15, "How often scanners can take pictures.", nil, {
	category = PLUGIN.name,
	data = {min = 0, max = 60}
})

ix.lang.AddTable("english", {
	scannerPrepDownload = "Prepare to receive visual download..."
})

ix.lang.AddTable("spanish", {
	scannerPrepDownload = "Prepárate para recibir una descarga visual..."
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
