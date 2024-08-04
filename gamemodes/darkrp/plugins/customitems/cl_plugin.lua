--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


net.Receive("ixCreateCustomItem", function()
	vgui.Create("ixCustomItemCreator")
end)

net.Receive("ixNetworkCustomItemCreation", function()
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
end)
