--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

CLASS.name = "Commandant de la Protection Civile"
CLASS.faction = FACTION_CP

function CLASS:CanSwitchTo(client)
    return Schema:IsCombineRank(client:Name(), "CmD")
end

--luacheck: globals CLASS_OWS
CLASS_CP_CMD = CLASS.index