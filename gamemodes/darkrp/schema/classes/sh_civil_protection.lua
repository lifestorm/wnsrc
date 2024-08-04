--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

CLASS.name = "Civil Protection Unit"
CLASS.faction = FACTION_CP

function CLASS:CanSwitchTo(client)
    return !Schema:IsCombineRank(client:Name(), "RL")
end

--luacheck: globals CLASS_OWS
CLASS_CP = CLASS.index