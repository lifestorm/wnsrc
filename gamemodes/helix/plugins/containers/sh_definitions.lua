--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--[[
	ix.container.Register(model, {
		name = "Crate",
		description = "A simple wooden create.",
		width = 4,
		height = 4,
		locksound = "",
		opensound = ""
	})
]]--

ix.container.Register("models/props_junk/wood_crate001a.mdl", {
	name = "Caisse en bois",
	description = "Une simple caisse en bois, pouvant stocker quelques objets.",
	width = 3,
	height = 3,
})

ix.container.Register("models/props_junk/wood_crate002a.mdl", {
	name = "Grosse caisse en bois",
	description = "Une simple caisse en bois, pouvant stocker des objets.",
	width = 5,
	height = 5,
})

ix.container.Register("models/props_c17/lockers001a.mdl", {
	name = "Vestaire",
	description = "Un vestiaire dans lequel vous pouvez stocker des objets.",
	width = 4,
	height = 4,
})

ix.container.Register("mode	ls/props_wasteland/controlroom_storagecloset001a.mdl", {
	name = "Grande Armoire",
	description = "A green metal cabinet.",
	width = 8,
	height = 3,
})

ix.container.Register("models/props_wasteland/controlroom_filecabinet001a.mdl", {
	name = "Armoire à dossiers",
	description = "Une armoire à dossier dans laquelle vous pouvez stocker quelques objets.",
	width = 3,
	height = 2
})

ix.container.Register("models/props_lab/filecabinet02.mdl", {
	name = "Armoire à dossiers",
	description = "Une armoire à dossier dans laquelle vous pouvez stocker quelques objets.",
	width = 3,
	height = 2
})

ix.container.Register("models/props_wasteland/controlroom_filecabinet002a.mdl", {
	name = "Armoire à dossiers moyenne",
	description = "Une armoire à dossier moyenne dans laquelle vous pouvez stocker quelques objets.",
	width = 2,
	height = 5
})

ix.container.Register("models/props_c17/furniturefridge001a.mdl", {
	name = "Réfrigirateur",
	description = "Un réfrigirateur dans lequel vous pouvez stocker des objets.",
	width = 3,
	height = 3,
})

ix.container.Register("models/props_wasteland/kitchen_fridge001a.mdl", {
	name = "Grand réfrigirateur",
	description = "Un grand réfrigirateur dans lequel vous pouvez stocker des objets.",
	width = 4,
	height = 4,
})

ix.container.Register("models/props_junk/trashbin01a.mdl", {
	name = "Poubelle",
	description = "Une poubelle pour jeter ses objets. Je pourrais peut-être trouvé des choses dedans...",
	width = 2,
	height = 2,
})

ix.container.Register("models/props_junk/trashdumpster01a.mdl", {
	name = "Benne",
	description = "Une benne de taille moyenne, dont une odeur nauséabonde se dégage.",
	width = 9,
	height = 9
})

ix.container.Register("models/props_forest/footlocker01_closed.mdl", {
	name = "Coffre",
	description = "Un coffre en bois pourri, dans lequel vous pouvez stocker des choses.",
	width = 5,
	height = 5
})

ix.container.Register("models/items/item_item_crate.mdl", {
	name = "Caisse de livraison",
	description = "Une caisse originalement utilisée pour livrer des objets aux commercants. ",
	width = 3,
	height = 3
})

ix.container.Register("models/props_junk/cardboard_box001a.mdl", {
	name = "Carton",
	description = "Un simple carton dans lequel vous pouvez stocker que peu de choses.",
	width = 2,
	height = 1
})

ix.container.Register("models/props_junk/cardboard_box002a.mdl", {
	name = "Carton",
	description = "Un simple carton dans lequel vous pouvez stocker que peu de choses.",
	width = 2,
	height = 1
})

ix.container.Register("models/props_junk/cardboard_box003a.mdl", {
	name = "Carton",
	description = "Un simple carton dans lequel vous pouvez stocker que peu de choses.",
	width = 2,
	height = 1
})

ix.container.Register("models/items/ammocrate_smg1.mdl", {
	name = "Caisse de munitions",
	description = "A heavy crate that stores ammo.",
	width = 8,
	height = 6,
	OnOpen = function(entity, activator)
		local closeSeq = entity:LookupSequence("Close")
		entity:ResetSequence(closeSeq)

		timer.Simple(2, function()
			if (entity and IsValid(entity)) then
				local openSeq = entity:LookupSequence("Open")
				entity:ResetSequence(openSeq)
			end
		end)
	end
})

ix.container.Register("models/items/ammocrate_rockets.mdl", {
	name = "Caisse de munitions",
	description = "A heavy crate that stores ammo.",
	width = 8,
	height = 6,
	OnOpen = function(entity, activator)
		local closeSeq = entity:LookupSequence("Close")
		entity:ResetSequence(closeSeq)

		timer.Simple(2, function()
			if (entity and IsValid(entity)) then
				local openSeq = entity:LookupSequence("Open")
				entity:ResetSequence(openSeq)
			end
		end)
	end
})

ix.container.Register("models/items/ammocrate_ar2.mdl", {
	name = "Caisse de munitions",
	description = "A heavy crate that stores ammo.",
	width = 8,
	height = 6,
	OnOpen = function(entity, activator)
		local closeSeq = entity:LookupSequence("Close")
		entity:ResetSequence(closeSeq)

		timer.Simple(2, function()
			if (entity and IsValid(entity)) then
				local openSeq = entity:LookupSequence("Open")
				entity:ResetSequence(openSeq)
			end
		end)
	end
})

ix.container.Register("models/items/ammocrate_grenade.mdl", {
	name = "Caisse de munitions",
	description = "A heavy crate that stores ammo.",
	width = 8,
	height = 6,
	OnOpen = function(entity, activator)
		local closeSeq = entity:LookupSequence("Close")
		entity:ResetSequence(closeSeq)

		timer.Simple(2, function()
			if (entity and IsValid(entity)) then
				local openSeq = entity:LookupSequence("Open")
				entity:ResetSequence(openSeq)
			end
		end)
	end
})

