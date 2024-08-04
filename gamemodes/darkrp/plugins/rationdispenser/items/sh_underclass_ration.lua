--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ration - Indésirable"
ITEM.model = Model("models/willardnetworks/rations/wn_new_ration.mdl")
ITEM.description = "Un paquet plastifié déchiré et usé contenant de la nourriture... si on peut même l'appeler ainsi."
ITEM.skin = 3
ITEM.items = {"proc_paste", "drink_breen_water"}
ITEM.category = "Combine"
ITEM.functions.Open = {
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
