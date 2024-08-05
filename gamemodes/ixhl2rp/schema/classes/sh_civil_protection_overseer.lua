--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

CLASS.name = "Overseer"
CLASS.faction = FACTION_OTA

function CLASS:CanSwitchTo(client)
    return string.find(client:Name(), "^Overseer ")
end

--luacheck: globals CLASS_OWS
CLASS_OVERSEER = CLASS.index