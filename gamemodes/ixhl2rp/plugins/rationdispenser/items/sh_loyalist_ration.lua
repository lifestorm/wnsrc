--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Loyalist Ration"
ITEM.model = Model("models/willardnetworks/food/ration_box.mdl")
ITEM.skin = 0
ITEM.description = "A small, blue ration box adorned with a red Combine logo, it contains a slightly more palatable portion of food, though still far from desirable."
ITEM.items = {"proc_mush", "fruit_apple", "drink_sparkling_water", "coupon_medium"}
ITEM.category = "Combine"
ITEM.iconCam = {
    pos = Vector(-113.45, -94.87, 73.82),
    ang = Angle(25, 400, 0),
    fov = 6.1
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
ITEM.holdData = {
    vectorOffset = {
        right = -4,
        up = 4,
        forward = 4
    },
    angleOffset = {
        right = 180,
        up = -90,
        forward = 0
    },
}