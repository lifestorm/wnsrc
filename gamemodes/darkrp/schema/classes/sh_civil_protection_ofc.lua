--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

CLASS.name = "Civil Protection Captain"
CLASS.faction = FACTION_CP

function CLASS:CanSwitchTo(client)
    if Schema:IsCombineRank(client:Name(), "CpT") or Schema:IsCombineRank(client:Name(), "ChF") then 
        return true 
    else 
        return false 
    end
end

--luacheck: globals CLASS_OWS
CLASS_CP_CPT = CLASS.index