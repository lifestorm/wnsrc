--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if slib and slib.loadFolder then slib.loadFolder("e_protect/", true) end
hook.Add("slib:loadedUtils", "eP:Initialize", function() slib.loadFolder("e_protect/", true) end)