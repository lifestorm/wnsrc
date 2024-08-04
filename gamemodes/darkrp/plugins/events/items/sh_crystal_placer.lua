--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "xen_crystal"
ITEM.name = "Xen Kristali"
ITEM.description = "Komşu XMZ'nin derinliklerinden gelen bir Xen Kristali, kayda değer bir parıltıya ve sessiz bir uğultuya sahip. Sağlam bir his veriyor; muhtemelen güçlü darbelere dayanabilecek kapasitede. Seni daha güçlü kılacak özel bir güce sahip."
ITEM.model = Model("models/vj_hlr/hl1/crystal.mdl")
ITEM.noBusiness = true
ITEM.width = 2
ITEM.height = 2

ITEM.functions.place = {
    name = "Yerleştir",
	tip = "Kristali Yerleştir",
	icon = "icon16/brick_add.png",
	OnRun = function(item)
        local client = item.player

        if (!client:Alive()) then return false end

        client.previousWep = client:GetActiveWeapon():GetClass()
        client:Give("weapon_crystal_placer")
       	client:SelectWeapon("weapon_crystal_placer")

        return true
    end,
    OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}