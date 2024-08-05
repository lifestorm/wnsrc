--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "drink_sparkling_water"
ITEM.name = "Sparkling Breen's Water"
ITEM.description = "A red can of water symbolic to the global regime, comes with a bit of a fiz to it and an artificial saccharine taste."
ITEM.category = "Food"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/breencan1.mdl"
ITEM.iconCam = {
		pos = Vector(509.64, 427.61, 310.24),
		ang = Angle(25.01, 220.01, 0),
		fov = 0.6
	}
ITEM.thirst = 25
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_water"
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
	name = "Convert",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		inventory:Add("crafting_water", 1, {original = item.uniqueID, spoilTime = item:GetData("spoilTime")})

		client:Notify("You have converted the " .. item.name .. " into a Crafting Water.")
	end
}
