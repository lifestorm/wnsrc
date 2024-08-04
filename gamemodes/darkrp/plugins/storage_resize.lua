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
	name = "Kutu",
	description = "Basit bir tahta kutu.",
	width = 6,
	height = 6,
})

ix.container.Register("models/props_junk/wood_crate002a.mdl", {
	name = "Büyük Kutu",
	description = "Büyük bir tahta kutu.",
	width = 10,
	height = 10,
})

ix.container.Register("models/props_c17/lockers001a.mdl", {
	name = "Dolap",
	description = "Beyaz bir dolap.",
	width = 8,
	height = 8,
})

ix.container.Register("models/props_wasteland/controlroom_storagecloset001a.mdl", {
	name = "Büyük Metal Dolap",
	description = "Yeşil metal bir dolap.",
	width = 9,
	height = 9,
})

ix.container.Register("models/props_wasteland/controlroom_storagecloset001b.mdl", {
	name = "Büyük Metal Dolap",
	description = "Yeşil metal bir dolap.",
	width = 9,
	height = 9,
})

ix.container.Register("models/props_wasteland/controlroom_filecabinet001a.mdl", {
	name = "Dosya Dolabı",
	description = "Metal bir dosya dolabı.",
	width = 5,
	height = 3
})

ix.container.Register("models/props_wasteland/controlroom_filecabinet002a.mdl", {
	name = "Orta Dosya Dolabı",
	description = "Metal bir dosya dolabı.",
	width = 5,
	height = 8,
})

ix.container.Register("models/props_lab/filecabinet02.mdl", {
	name = "Dosya Dolabı",
	description = "Metal bir dosya dolabı.",
	width = 5,
	height = 3
})

ix.container.Register("models/props_c17/furniturefridge001a.mdl", {
	name = "Buzdolabı",
	description = "Yiyecekleri saklamak için metal bir kutu.",
	width = 6,
	height = 7,
})

ix.container.Register("models/props_wasteland/kitchen_fridge001a.mdl", {
	name = "Büyük Buzdolabı",
	description = "Daha fazla yiyeceği saklamak için büyük bir metal kutu.",
	width = 9,
	height = 9,
})

ix.container.Register("models/props_junk/trashbin01a.mdl", {
	name = "Çöp Kutusu",
	description = "Burada ne bulmayı umuyorsun?",
	width = 7,
	height = 3,
})

ix.container.Register("models/props_junk/trashdumpster01a.mdl", {
	name = "Çöp Konteyneri",
	description = "Çöpü saklamak için yapılmış bir konteyner. Hoş olmayan bir koku yayıyor.",
	width = 9,
	height = 9
})

ix.container.Register("models/items/ammocrate_smg1.mdl", {
	name = "Cephane Kutusu",
	description = "Cephane depolayan ağır bir kutu.",
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
	name = "Cephane Kutusu",
	description = "Cephane depolayan ağır bir kutu.",
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
	name = "Cephane Kutusu",
	description = "Cephane depolayan ağır bir kutu.",
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
	name = "Cephane Kutusu",
	description = "Cephane depolayan ağır bir kutu.",
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

ix.container.Register("models/mosi/fallout4/props/fortifications/woodencrate03.mdl", {
	name = "Sandık",
	description = "Eşyaları saklamak için küçük bir sandık.",
	width = 6,
	height = 5
})

ix.container.Register("models/items/item_item_crate.mdl", {
	name = "Eşya Kutusu",
	description = "Bazı eşyaları saklamak için bir kutu.",
	width = 5,
	height = 4
})

ix.container.Register("models/props_c17/cashregister01a.mdl", {
	name = "Yazar Kasa",
	description = "Bazı düğmelerin ve çekmecenin bulunduğu bir kasa.",
	width = 2,
	height = 2
})
