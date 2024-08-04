--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Sac en toile à cordon de serrage"
ITEM.description = "Un sac en toile à cordon de serrage qui est la taille parfaite pour mettre sur la tête de quelqu'un."
ITEM.price = 8
ITEM.category = "Autres"
ITEM.model = "models/props_junk/garbage_bag001a.mdl" -- < the "real" models dont have proper collisions
ITEM.functions.Use = {
	name = "Utiliser",
	OnRun = function(itemTable)
		local client = itemTable.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter() and target:IsRestricted()) then
			itemTable.bBeingUsed = true

			client:SetAction("Glisser dans le sac...", 2)

			client:DoStaredAction(target, function()
				target:NotifyLocalized("Un sac a été placé sur votre tête !")

				itemTable:Remove()

				net.Start("WNBagEnter")
    				net.WriteString(target:SteamID64())
				net.Broadcast()

				target:SetNetVar("WNBagged", true)
			end, 3, function()
				client:SetAction()
				target:SetAction()
				target:SetNetVar("WNBagged", true)

				itemTable.bBeingUsed = false
			end)
        elseif (IsValid(target) and target:IsPlayer() and !target:IsRestricted()) then
            client:NotifyLocalized("Le personnage doit être attachée en premier")
		else
			client:NotifyLocalized("plyNotValid")
		end

		return false
	end,
	OnCanRun = function(itemTable)
		return !IsValid(itemTable.entity) or itemTable.bBeingUsed
	end
}

function ITEM:CanTransfer(inventory, newInventory)
	return !self.bBeingUsed
end
