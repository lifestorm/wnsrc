--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Barricade Placer"
ITEM.description = "A barricade placer kit."
ITEM.model = Model("models/props_combine/combine_barricade_short01a.mdl")
ITEM.noBusiness = true
ITEM.width = 2
ITEM.height = 2

ITEM.functions.place = {
    name = "Place",
	tip = "Place a barricade",
	icon = "icon16/brick_add.png",
	OnRun = function(item)
        local client = item.player

        if (!client:Alive()) then return false end
        client:EmitSound("physics/cardboard/cardboard_box_break3.wav")

        client.previousWep = client:GetActiveWeapon():GetClass()
        client:Give("weapon_barricade_placer")
       	client:SelectWeapon("weapon_barricade_placer")

        return true
    end,
    OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
