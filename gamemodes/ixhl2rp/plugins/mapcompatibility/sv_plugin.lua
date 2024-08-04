--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.log.AddType("mapButtonPressed", function(client, ...)
	local arguments = {...}

    return Format("%s has pressed the \"%s\" map button.", client:Name(), arguments[1])
end)
