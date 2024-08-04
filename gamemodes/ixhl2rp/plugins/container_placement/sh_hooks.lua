--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:InitializedPlugins()
	for model, data in pairs(ix.container.stored) do
		model = model:lower()
		local invType = "container:" .. model

		if (ix.item.inventoryTypes[invType]) then
			local uniqueID = string.Replace(data.name:lower(), " ", "_")
			ix.item.Register(uniqueID, "base_containers", false, nil, true)

			if (ix.item.list[uniqueID]) then
				ix.item.list[uniqueID].name = data.name
				ix.item.list[uniqueID].description = data.description
				ix.item.list[uniqueID].model = Model(model)
				ix.item.list[uniqueID].width = math.max(1, math.floor(data.width * 0.5))
				ix.item.list[uniqueID].height = math.max(1, math.floor(data.height * 0.5))

				ix.item.list[uniqueID].invType = invType
			end
		end
	end
end
