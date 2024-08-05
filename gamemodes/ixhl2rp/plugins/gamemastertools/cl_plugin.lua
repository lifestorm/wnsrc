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

--luacheck: ignore 431 432
netstream.Hook("OpenGMInfo", function(targetPlayer, data)
	local gamemastertools = vgui.Create("GamemasterTools")
	gamemastertools:Update(targetPlayer, data)
end)