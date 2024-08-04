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

PLUGIN.name = "HideVoicePanels"
PLUGIN.author = "Kira"
PLUGIN.description = "Hide voice panels"

function PLUGIN:PlayerStartVoice()
	GM = GM or GAMEMODE
	function GM:PlayerStartVoice(ply)
		return
	end
end