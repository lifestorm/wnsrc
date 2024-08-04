--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ration - Protection civile"
ITEM.model = Model("models/willardnetworks/rations/wn_new_ration.mdl")
ITEM.skin = 4
ITEM.description = "Un paquet sous film rétractable contenant de la nourriture et de l'eau. Elle est fabriquée par le Cartel."
ITEM.items = {"metropolicesupplements", "nutrientdrink", "coupon_medium"}
ITEM.category = "Combine"
ITEM.iconCam = {
	pos = Vector(-509.64, -427.61, 310.24),
	ang = Angle(25, 400.56, 0),
	fov = 1.27
}
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
