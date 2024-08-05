--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Draw String Canvas Bag"
ITEM.description = "A draw string canvas bag that is the perfect size for putting over someone's head."
ITEM.price = 8
ITEM.model = "models/props_junk/garbage_bag001a.mdl" -- < the "real" models dont have proper collisions
ITEM.maxStackSize = 10
ITEM.functions.Use = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:GetCharacter() and target:IsRestricted()) then
			itemTable.bBeingUsed = true

			client:SetAction("Slipping on bag...", 2)

			client:DoStaredAction(target, function()
				target:NotifyLocalized("A bag has been placed over your head!")

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
            client:NotifyLocalized("Character should be tied up first")
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
