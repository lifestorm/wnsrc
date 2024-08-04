--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Kağıt"
ITEM.model = "models/props_c17/paper01.mdl"
ITEM.identifier = "paper"
ITEM.holdData = {
    vectorOffset = {
        right = 0.5,
        up = 0,
        forward = 1
    },
    angleOffset = {
        right = 0,
        up = 0,
        forward = -0
    },
}   
ITEM.functions.zTear = { -- I want it to be last
	name = "Yırt",
	icon = "icon16/textfield_delete.png",
	OnRun = function(item)
		local client = item.player

		client:RequestConfirmation("Yırtmayı Onayla", "Bu kağıdı yırtmak istediğinden emin misiniz?", function(confirmation)
			if (!confirmation) then return end
			
			client:Notify("Kağıdı yırttın.")
			item:Remove()
		end)

		return false
	end,
	OnCanRun = function(item)
		return !item.entity or !IsValid(item.entity)
	end
}
