--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Breen'in Suyu"
ITEM.description = "Küresel rejimi simgeleyen bir su kabı, tuhaf bir metalik tat ile geliyor."
ITEM.category = "Food"
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(509.64, 427.61, 310.24),
	ang = Angle(25.01, 220.01, 0),
	fov = 0.6
}
ITEM.thirst = 20
ITEM.spoil = true
ITEM.spoilTime = 2
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_can"
ITEM.boosts = {
    perception = -1,
    intelligence = -2
}
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
