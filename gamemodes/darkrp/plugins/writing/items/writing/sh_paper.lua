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

ITEM.functions.zTear = { -- I want it to be last
	name = "Déchirer",
	icon = "icon16/textfield_delete.png",
	OnRun = function(item)
		local client = item.player

		client:RequestConfirmation("Déchirer", "Etes-vous sûrs de déchirer ce papier ?", function(confirmation)
			if (!confirmation) then return end
			
			client:Notify("Vous avez déchiré le papier.")
			item:Remove()
		end)

		return false
	end,
	OnCanRun = function(item)
		return !item.entity or !IsValid(item.entity)
	end
}
