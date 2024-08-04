--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ration - Standard"
ITEM.model = Model("models/willardnetworks/rations/wn_new_ration.mdl")
ITEM.description = "Un paquet sous film rétractable contenant de la nourriture et de l'eau. Elle est fabriquée par l'Union."
ITEM.items = {"proc_paste", "drink_breen_water", "10_coupon", "5_coupon"}
ITEM.category = "Combine"
ITEM.functions.Open = {
name = "Diviser",
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()

		for _, v in ipairs(itemTable.items) do
			if (!character:GetInventory():Add(v)) then
				ix.item.Spawn(v, client)
			end
		end

		client:EmitSound("ambient/fire/mtov_flame2.wav", 75, math.random(160, 180), 0.35)
	end
}
