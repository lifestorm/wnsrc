--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ration - Véritable loyaliste"
ITEM.model = Model("models/willardnetworks/food/ration_box.mdl")
ITEM.skin = 1
ITEM.description = "Une petite boîte en carton contenant de la nourriture. Elle arbore un élégant logo Combine. Pour une raison quelconque, elle semble plus luxueuse."
ITEM.items = {"luxury_choc", "baking_bread", "comfort_fish", "drink_sparkling_water", "25_coupon", "10_coupon"}
ITEM.category = "Combine"
ITEM.iconCam = {
  pos = Vector(-509.64, -427.61, 310.24),
  ang = Angle(25, 400.56, 0),
  fov = 1.27
}
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
