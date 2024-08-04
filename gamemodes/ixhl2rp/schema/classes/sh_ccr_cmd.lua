--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

CLASS.name = "CCR Command"
CLASS.faction = FACTION_CCR

function CLASS:CanSwitchTo(client)
    if client.GetCharacter():HasFlags("U") then 
        return true 
    else 
        return false 
    end
end

CLASS_CCR_CMD = CLASS.index