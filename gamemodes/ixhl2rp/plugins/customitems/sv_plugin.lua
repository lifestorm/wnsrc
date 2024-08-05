--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

util.AddNetworkString("ixCreateCustomItem")
util.AddNetworkString("ixNetworkCustomItemCreation")
util.AddNetworkString("ixRequestCustomItems")
util.AddNetworkString("ixDeleteCustomItem")

function PLUGIN:DeleteItemFromDatabase(itemID)
    local query = mysql:Delete("ix_items")
    query:Where("unique_id", itemID)
    query:Execute()
end

net.Receive("ixCreateCustomItem", function(_, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Create Custom Script")) then return end

	local data = {
		base = net.ReadString(),
		uniqueID = net.ReadString(),
		name = net.ReadString(),
		description = net.ReadString(),
		model = net.ReadString(),
		skin = net.ReadUInt(5),
		category = net.ReadString(),
		iconCam = net.ReadString(),
		material = net.ReadString(),
		width = net.ReadUInt(5),
		height = net.ReadUInt(5),
		color = net.ReadColor(),
		rotate = net.ReadBool(),
		maxStackSize = net.ReadUInt(8),
		hunger = net.ReadUInt(8),
		thirst = net.ReadUInt(8),
		spoilTime = net.ReadUInt(6),
		damage = net.ReadUInt(8),
		health = net.ReadUInt(8),
		amount = net.ReadUInt(7)
	}

	for key, value in pairs(data) do
		if (!isstring(value)) then continue end
		
		data[key] = string.Trim(value)
	end
	
	if (data.uniqueID == "") then return end
	if (ix.item.list[data.uniqueID]) then return end

	local base = data.base
	local iconCam = data.iconCam

	if (data.base == "No Base") then
		base = nil
	end

	if (data.iconCam == "") then
		iconCam = nil
	else
		iconCam = util.JSONToTable(iconCam)
	end

	data.uniqueID = string.Replace(data.uniqueID, " ", "_")

	local ITEM = ix.item.Register(data.uniqueID, base, false, nil, true)
	ITEM.name = data.name
	ITEM.description = data.description
	ITEM.model = data.model
	ITEM.skin = data.skin
	ITEM.category = data.category
	ITEM.iconCam = iconCam
	ITEM.material = data.material
	ITEM.width = data.width
	ITEM.height = data.height
	ITEM.color = data.color
	ITEM.rotate = data.rotate
	ITEM.maxStackSize = data.maxStackSize
	ITEM.hunger = data.hunger
	ITEM.thirst = data.thirst
	ITEM.spoilTime = data.spoilTime
	ITEM.damage = data.damage
	ITEM.health = data.health
	ITEM.amount = data.amount -- Credits. lol
	ITEM.customItem = true

	net.Start("ixNetworkCustomItemCreation")
		net.WriteString(data.base)
		net.WriteString(data.uniqueID)
		net.WriteString(data.name)
		net.WriteString(data.description)
		net.WriteString(data.model)
		net.WriteUInt(data.skin, 5)
		net.WriteString(data.category)
		net.WriteString(data.iconCam)
		net.WriteString(data.material)
		net.WriteUInt(data.width, 5)
		net.WriteUInt(data.height, 5)
		net.WriteColor(data.color)
		net.WriteBool(data.rotate)
		net.WriteUInt(data.maxStackSize, 8)
		net.WriteUInt(data.hunger, 8)
		net.WriteUInt(data.thirst, 8)
		net.WriteUInt(data.spoilTime, 6)
		net.WriteUInt(data.damage, 8)
		net.WriteUInt(data.health, 8)
		net.WriteUInt(data.amount, 7)
	net.Broadcast()

	file.CreateDir("customitems")
	file.Write("customitems/" .. data.uniqueID .. ".json", util.TableToJSON(data))

	-- Timer probably isn't needed, but I like to give it some space just in case.
	timer.Simple(1, function()
		if (!client:GetCharacter():GetInventory():Add(data.uniqueID)) then
			ix.item.Spawn(data.uniqueID, client)
		end
	end)

	client:Notify("\"" .. data.name .. "\" created succesfully. Refresh the Item Spawner to find it.")
end)

net.Receive("ixRequestCustomItems", function(_, client)
	if (client.receivedItems) then return end -- Avoid spam

	local files, _ = file.Find("customitems/*", "DATA")
	local itemList = {}

	for _, itemFile in ipairs(files) do
		local item = util.JSONToTable(file.Read("customitems/" .. itemFile, "DATA") or "")
		if (!item) then continue end

		itemList[#itemList + 1] = item
	end
	
	for k, data in ipairs(itemList) do
		timer.Simple(1 * k, function()
			net.Start("ixNetworkCustomItemCreation")
				net.WriteString(data.base)
				net.WriteString(data.uniqueID)
				net.WriteString(data.name)
				net.WriteString(data.description)
				net.WriteString(data.model)
				net.WriteUInt(data.skin, 5)
				net.WriteString(data.category)
				net.WriteString(data.iconCam)
				net.WriteString(data.material)
				net.WriteUInt(data.width, 5)
				net.WriteUInt(data.height, 5)
				net.WriteColor(IsColor(data.color) and data.color or istable(data.color) and Color(data.color.r, data.color.g, data.color.b) or Color(255, 255, 255))
				net.WriteBool(data.rotate)
				net.WriteUInt(data.maxStackSize, 8)
				net.WriteUInt(data.hunger, 8)
				net.WriteUInt(data.thirst, 8)
				net.WriteUInt(data.spoilTime, 6)
				net.WriteUInt(data.damage, 8)
				net.WriteUInt(data.health, 8)
				net.WriteUInt(data.amount, 7)
			net.Send(client)
		end)
	end

	client.receivedItems = true
end)

net.Receive("ixDeleteCustomItem", function(_, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Create Custom Script")) then return end

	local itemID = net.ReadString()
	local item = ix.item.list[itemID]

	if (!item) then return end
	if (!item.customItem) then
		client:Notify("That is not a custom item - it cannot be deleted!")

		return
	end

	if (!file.Exists("customitems/" .. itemID .. ".json", "DATA")) then
		client:Notify("This item does not exist. It may have already been marked for deletion!")

		return
	end

	file.Delete("customitems/" .. itemID .. ".json", "DATA")
	PLUGIN:DeleteItemFromDatabase(itemID) -- We remove the item from the database, so the inventory doesn't break due to null items.
	client:Notify("\"" .. item.name .. "\" marked for deletion. It will be removed on the next server restart.")
end)
