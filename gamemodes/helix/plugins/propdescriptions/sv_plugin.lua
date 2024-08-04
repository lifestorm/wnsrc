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
	return string.format("%s a défini une description de props : '%s' - '%s'.", client:GetName(), title, description)
end)

ix.log.AddType("propDescriptionRemoved", function(client)
	return string.format("%s a supprimé une description de props :", client:GetName())
end)
