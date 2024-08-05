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
ITEM.name = "Bob Water Original"
ITEM.description = "The soft welcoming and mild original taste of Bob Water. Warning: May cause severe intestinal bleeding and mild eye strain."
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
	name = "Convert",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()

		inventory:Add("crafting_water", 1, {original = item.uniqueID, spoilTime = item:GetData("spoilTime")})

		client:Notify("You have converted the " .. item.name .. " into a Crafting Water.")
	end
}
