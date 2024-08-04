--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Called after a player has loaded a character.
function PLUGIN:PlayerLoadedCharacter(client, character, currentChar)
	client:SetNetVar("characterMood", nil)
end

-- Called after the player's model has changed.
function PLUGIN:PlayerModelChanged(client, model)
	client:SetNetVar("characterMood", nil)
end
