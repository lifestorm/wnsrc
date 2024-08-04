--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "comp_wood"
ITEM.name = "Ahşap Talaşları"
ITEM.description = "Eşya yapmak için yeniden kullanılabilecek ahşap yongalardan oluşan bir koleksiyon."
ITEM.category = "Crafting"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/Gibs/wood_gib01a.mdl"
ITEM.colorAppendix = {["blue"] = "Bu öğeyi Zanaatkarlık becerisi Parçalama işleviyle veya çöp yığınlarını arayarak elde edebilirsiniz.", ["red"] = "Bu türden 8'den fazla eşya taşımak şüphelidir."}

ITEM.maxStackSize = 24

ITEM.functions.Breakdown = {
	icon = "icon16/link_break.png",
	OnRun = function(item)
		local client = item.player

		client:GetCharacter():GetInventory():Add("woodstick", 10)
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item.player:Team() == FACTION_BIRD
	end
}
