--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.container.Register("models/props_junk/wood_crate001a.mdl", {
	name = "Kutu",
	description = "Basit bir tahta kutu.",
	width = 4,
	height = 4,
})

ix.container.Register("models/props_c17/lockers001a.mdl", {
	name = "Dolap",
	description = "Beyaz bir dolap.",
	width = 3,
	height = 5,
})

ix.container.Register("models/props_wasteland/controlroom_storagecloset001a.mdl", {
	name = "Metal Dolap",
	description = "Yeşil bir metal dolap.",
	width = 4,
	height = 5,
})

ix.container.Register("models/props_wasteland/controlroom_storagecloset001b.mdl", {
	name = "Metal Dolap",
	description = "Yeşil bir metal dolap.",
	width = 4,
	height = 5,
})

ix.container.Register("models/props_wasteland/controlroom_filecabinet001a.mdl", {
	name = "Dosya Dolabı",
	description = "Metal bir dosya dolabı.",
	width = 5,
	height = 3
})

ix.container.Register("models/props_wasteland/controlroom_filecabinet002a.mdl", {
	name = "Dosya Dolabı",
	description = "Metal bir dosya dolabı.",
	width = 3,
	height = 6,
})

ix.container.Register("models/props_lab/filecabinet02.mdl", {
	name = "Dosya Dolabı",
	description = "Metal bir dosya dolabı.",
	width = 5,
	height = 3
})

ix.container.Register("models/props_c17/furniturefridge001a.mdl", {
	name = "Buzdolabı",
	description = "Yiyecekleri saklamak için bir metal kutu.",
	width = 2,
	height = 3,
})

ix.container.Register("models/props_wasteland/kitchen_fridge001a.mdl", {
	name = "Büyük Buzdolabı",
	description = "Daha fazla yiyecek saklamak için büyük bir metal kutu.",
	width = 4,
	height = 5,
})

ix.container.Register("models/props_junk/trashbin01a.mdl", {
	name = "Çöp Kutusu",
	description = "Burada ne bulmayı bekliyorsunuz?",
	width = 2,
	height = 2,
})

ix.container.Register("models/props_junk/trashdumpster01a.mdl", {
	name = "Çöp Konteyneri",
	description = "Çöpü saklamak için yapılmış bir konteyner. Hoş olmayan bir koku yayıyor.",
	width = 6,
	height = 3
})

ix.container.Register("models/items/ammocrate_smg1.mdl", {
	name = "Cephane Kutusu",
	description = "Cephane saklayan ağır bir kutu.",
	width = 5,
	height = 3,
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
	name = "Ayakkabı Dolabı",
	description = "Eşyaları saklamak için küçük bir sandık.",
	width = 5,
	height = 3
})

ix.container.Register("models/Items/item_item_crate.mdl", {
	name = "Eşya Kutusu",
	description = "Bazı eşyaları saklamak için bir kutu.",
	width = 5,
	height = 3
})

ix.container.Register("models/props_c17/cashregister01a.mdl", {
	name = "Kasa Makinesi",
	description = "Bazı düğmeleri ve bir çekmeceyi içeren bir kasa.",
	width = 2,
	height = 1
})
