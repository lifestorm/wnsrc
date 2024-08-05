--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.log.AddType("propDescriptionAdded", function(client, title, description)
	return string.format("%s has set a prop description: '%s' - '%s'.", client:GetName(), title, description)
end)

ix.log.AddType("propDescriptionRemoved", function(client)
	return string.format("%s has removed a prop description.", client:GetName())
end)
