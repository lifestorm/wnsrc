--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Called after a player has loaded into a character
function PLUGIN:PlayerLoadedCharacter(client, character, oldChar)
	if (!client.hintsInitialized) then
		net.Start("ixInitializeHints")
		net.Send(client)

		client.hintsInitialized = true
	end
end
