--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Rasyon"
ITEM.model = Model("models/willardnetworks/rations/wn_new_ration.mdl")
ITEM.skin = 0
ITEM.description = "İçinde bir miktar yiyecek bulunan ambalajlı bir paket."
ITEM.items = {"proc_paste", "drink_breen_water", "coupon_basic"}
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
ITEM.holdData = {
    vectorOffset = {
        right = -3.5,
        up = 0,
        forward = 1.5
    },
    angleOffset = {
        right = 180,
        up = 90,
        forward = -70
    },
}