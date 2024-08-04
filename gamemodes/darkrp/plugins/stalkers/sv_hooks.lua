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

function PLUGIN:PlayerTick(client)
    if (client:Team() == FACTION_STALKER) then
        if (!client.nextSound or (CurTime() >= client.nextSound)) then
            client.nextSound = CurTime() + math.random(60, 180)
            client:EmitSound("npc/stalker/breathing3.wav", 65)
        end
    end
end

function PLUGIN:GetPlayerPainSound(client)
    if (client:Team() == FACTION_STALKER) then
        return ""
    end
end

function PLUGIN:GetPlayerDeathSound(client)
    if (client:Team() == FACTION_STALKER) then
        return ""
    end
end
