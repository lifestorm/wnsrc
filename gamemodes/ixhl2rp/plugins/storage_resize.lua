--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Storage Resize"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Resizes the storage containers."

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
	name = "Skrzynia",
	description = "Prosta, drewniana skrzynia.",
	width = 6,
	height = 6,
})

ix.container.Register("models/props_junk/wood_crate002a.mdl", {
	name = "Duża skrzynia",
	description = "Duża drewniana skrzynia.",
	width = 10,
	height = 10,
})

ix.container.Register("models/props_c17/lockers001a.mdl", {
	name = "Szafki",
	description = "Białe szafki.",
	width = 8,
	height = 8,
})

ix.container.Register("models/props_wasteland/controlroom_storagecloset001a.mdl", {
	name = "Duża metalowa szafa",
	description = "Zielona metalowa szafa.",
	width = 9,
	height = 9,
})

ix.container.Register("models/props_wasteland/controlroom_storagecloset001b.mdl", {
	name = "Duża metalowa szafa",
	description = "Zielona metalowa szafa.",
	width = 9,
	height = 9,
})

ix.container.Register("models/props_wasteland/controlroom_filecabinet001a.mdl", {
	name = "Szafka na dokumenty",
	description = "Metalowa szafka na dokumenty.",
	width = 5,
	height = 3
})

ix.container.Register("models/props_wasteland/controlroom_filecabinet002a.mdl", {
	name = "Wysoka szafka na dokumenty",
	description = "Metalowa szafka na dokumenty.",
	width = 5,
	height = 8,
})

ix.container.Register("models/props_lab/filecabinet02.mdl", {
	name = "Szafka na dokumenty",
	description = "Metalowa szafka na dokumenty.",
	width = 5,
	height = 3
})

ix.container.Register("models/props_c17/furniturefridge001a.mdl", {
	name = "Lodówka",
	description = "Metalowa lodówka stworzona do przechowywania jedzenia.",
	width = 6,
	height = 7,
})

ix.container.Register("models/props_wasteland/kitchen_fridge001a.mdl", {
	name = "Duża lodówka",
	description = "Duża metalowa lodówka stworzona do przechowywania jeszcze większej ilości jedzenia.",
	width = 9,
	height = 9,
})

ix.container.Register("models/props_junk/trashbin01a.mdl", {
	name = "Kosz na śmieci",
	description = "Myślisz, że coś tu znajdziesz?",
	width = 7,
	height = 3,
})

ix.container.Register("models/props_junk/trashdumpster01a.mdl", {
	name = "Śmietnik",
	description = "Śmietnik służący do przechowywania śmieci. Troche od niego śmierdzi.",
	width = 9,
	height = 9
})

ix.container.Register("models/items/ammocrate_smg1.mdl", {
	name = "Skrzynia z amunicją",
	description = "Ciężka skrzynia w której możesz przechowywać amunicje.",
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
	name = "Skrzynia z amunicją",
	description = "Ciężka skrzynia w której możesz przechowywać amunicje.",
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
	name = "Skrzynia z amunicją",
	description = "Ciężka skrzynia w której możesz przechowywać amunicje.",
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
	name = "Skrzynia z amunicją",
	description = "Ciężka skrzynia w której możesz przechowywać amunicje.",
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

ix.container.Register("models/props_forest/footlocker01_closed.mdl", {
	name = "Skrzynka",
	description = "Mała skrzynia w której możesz przechować swoje rzeczy.",
	width = 6,
	height = 5
})

ix.container.Register("models/items/item_item_crate.mdl", {
	name = "Skrzynia na przedmioty",
	description = "skrzynia w której możesz przechować swoje rzeczy.",
	width = 5,
	height = 4
})

ix.container.Register("models/props_c17/cashregister01a.mdl", {
	name = "Kasa",
	description = "Zwykła kasa.",
	width = 2,
	height = 2
})
