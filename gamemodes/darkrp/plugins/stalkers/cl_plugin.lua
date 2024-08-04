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

function PLUGIN:PlayerFootstep(client, position, foot, soundName, volume)
    if (client:Team() == FACTION_STALKER) then
        client:EmitSound("npc/stalker/stalker_footstep_" .. (foot == 0 and "left" or "right") .. math.random(1, 2) .. ".wav")
    end
end
