--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Priorytetowa racja żywnościowa Lojalisty"
ITEM.model = Model("models/willardnetworks/food/ration_box.mdl")
ITEM.skin = 2
ITEM.description = "Małe, kartonowe i ładnie wyglądające pudełko w którym znajduje się troche jedzenia. Oznakowane jest logiem Kombinatu, a na boku wypisany jest jakiś inspirujący cytat."
ITEM.items = {"luxury_choc", "proc_mush", "drink_sparkling_water", "coupon_priority"}
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