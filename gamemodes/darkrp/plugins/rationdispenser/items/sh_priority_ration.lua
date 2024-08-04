--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ration - Loyaliste prioritaire"
ITEM.model = Model("models/willardnetworks/food/ration_box.mdl")
ITEM.skin = 2
ITEM.description = "Une boîte en carton qui semble assez raffinée, transportant quelques fournitures. Elle comporte des logos combinés avec de petites citations inspirantes sur ses côtés."
ITEM.items = {"luxury_choc", "fruit_banana", "baking_bread", "drink_sparkling_water", "25_coupon" ,"5_coupon"}
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
