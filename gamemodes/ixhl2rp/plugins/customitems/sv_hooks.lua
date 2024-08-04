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
	local files, _ = file.Find("customitems/*", "DATA")

	for _, item in ipairs(files) do
		item = util.JSONToTable(file.Read("customitems/" .. item, "DATA"))

		local base = item.base
		local iconCam = item.iconCam

		if (item.base == "No Base") then
			base = nil
		end

		if (item.iconCam == "") then
			iconCam = nil
		else
			iconCam = util.JSONToTable(iconCam)
		end

		item.uniqueID = string.Replace(item.uniqueID, " ", "_")

		local ITEM = ix.item.Register(item.uniqueID, base, false, nil, true)
		ITEM.name = item.name
		ITEM.description = item.description
		ITEM.model = item.model
		ITEM.skin = item.skin
		ITEM.category = item.category
		ITEM.iconCam = iconCam
		ITEM.material = item.material
		ITEM.width = item.width
		ITEM.height = item.height
		ITEM.color = item.color
		ITEM.rotate = item.rotate
		ITEM.maxStackSize = item.maxStackSize
		ITEM.hunger = item.hunger
		ITEM.thirst = item.thirst
		ITEM.spoilTime = item.spoilTime
		ITEM.damage = item.damage
		ITEM.health = item.health
		ITEM.amount = item.amount -- Credits. lol
		ITEM.customItem = true
	end
end
