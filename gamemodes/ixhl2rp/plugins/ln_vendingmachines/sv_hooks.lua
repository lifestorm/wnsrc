--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function PLUGIN:SaveData()
	self:SaveVendingMachines()
end

function PLUGIN:LoadData()
	if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end
	self:LoadVendingMachines()
end

-- Called to check if a player can transfer an item.
function PLUGIN:CanTransferItem(item, oldInv, newInv)
	if (newInv.vars and newInv.vars.isVendingMachine) then
		if (item.width > 1 or item.height > 1) then
			return false
		end
	end
end

-- Called after an item has been transferred.
function PLUGIN:OnItemTransferred(item, oldInv, newInv)
	if ((newInv.vars and newInv.vars.isVendingMachine) or (oldInv.vars and oldInv.vars.isVendingMachine)) then
		local vendingMachine

		for _, entity in ipairs(ents.FindByClass("ix_customvendingmachine")) do
			if (entity:GetID() == newInv:GetID() or entity:GetID() == oldInv:GetID()) then
				vendingMachine = entity

				break
			end
		end

		if (vendingMachine) then
			vendingMachine:UpdateStocks()
		end
	end
end

-- Called after an item has been moved in the same inventory.
function PLUGIN:OnItemMoved(item, inventory)
	if (inventory.vars.isVendingMachine) then
		local vendingMachine

		for _, entity in ipairs(ents.FindByClass("ix_customvendingmachine")) do
			if (entity:GetID() == inventory:GetID()) then
				vendingMachine = entity

				break
			end
		end

		if (vendingMachine) then
			vendingMachine:UpdateStocks()
		end
	end
end
