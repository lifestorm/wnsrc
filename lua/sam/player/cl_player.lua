--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if SAM_LOADED then return end

local sam = sam
local netstream = sam.netstream

netstream.Hook("PlaySound", function(sound)
	surface.PlaySound(sound)
end)