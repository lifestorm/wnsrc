--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

CLASS.name = "Overwatch"
CLASS.description = "An Overwatch AI, it utilises Combine technology."
CLASS.faction = FACTION_OVERWATCH

function CLASS:CanSwitchTo(client)
	return !Schema:IsCombineRank(client:Name(), "SCN") or !Schema:IsCombineRank(client:Name(), "Disp:AI")
end

CLASS_OW = CLASS.index
