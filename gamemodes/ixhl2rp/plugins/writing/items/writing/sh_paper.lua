--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Papier"
ITEM.model = "models/props_c17/paper01.mdl"
ITEM.identifier = "paper"
ITEM.holdData = {
    vectorOffset = {
        right = 0,
        up = -3,
        forward = 1
    },
    angleOffset = {
        right = -15,
        up = 90,
        forward = 90
    },
}   
ITEM.functions.zTear = { -- I want it to be last
	name = "Podrzyj",
	icon = "icon16/textfield_delete.png",
	OnRun = function(item)
		local client = item.player

		client:RequestConfirmation("Potwierdzenie podarcia", "Napewno chcesz podrzeć ten papier?", function(confirmation)
			if (!confirmation) then return end
			
			client:Notify("Podarłeś papier na strzępy.")
			item:Remove()
		end)

		return false
	end,
	OnCanRun = function(item)
		return !item.entity or !IsValid(item.entity)
	end
}