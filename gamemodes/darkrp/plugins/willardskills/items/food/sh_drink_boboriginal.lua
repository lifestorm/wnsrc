--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "drink_boboriginal"
ITEM.name = "Bob Water Orijinal"
ITEM.description = "Bob Water'ın yumuşak karşılaması ve hafif orijinal tadı. Uyarı: Şiddetli bağırsak kanamasına ve hafif göz yorgunluğuna neden olabilir."
ITEM.category = "Food"
ITEM.model = "models/willardnetworks/food/bobdrinks_can.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.skin = 4
ITEM.thirst = 25
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_canter"
ITEM.holdData = {
    vectorOffset = {
        right = 0,
        up = 0,
        forward = 0
    },
    angleOffset = {
        right = 0,
        up = 0,
        forward = 0
    },
}
ITEM.functions.Convert = {
	name = "Dönüştür",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		inventory:Add("crafting_water", 1, {original = item.uniqueID, spoilTime = item:GetData("spoilTime")})

		client:Notify(item.name .. " eşyasını üretim suyuna dönüştürdünüz.")
	end
}
