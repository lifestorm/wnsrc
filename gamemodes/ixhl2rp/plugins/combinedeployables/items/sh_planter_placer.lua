--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Planter"
ITEM.description = "A deployable planter, how portable!"
ITEM.model = Model("models/wn7new/advcrates/n7_planter_wood.mdl")
ITEM.noBusiness = true
ITEM.category = "Farming"
ITEM.width = 4
ITEM.height = 2
ITEM.outlineColor = Color(255, 0, 0, 100)

ITEM.functions.place = {
    name = "Place",
	tip = "Place the planter",
	icon = "icon16/brick_add.png",
	OnRun = function(item)
        local client = item.player

        if (!client:Alive()) then return false end
        client:EmitSound("physics/cardboard/cardboard_box_break3.wav")

        client.previousWep = client:GetActiveWeapon():GetClass()
        client:Give("weapon_planter_placer")
       	client:SelectWeapon("weapon_planter_placer")

        return true
    end,
    OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
