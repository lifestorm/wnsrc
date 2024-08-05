--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.uniqueID = "base_assembly"
ITEM.name = "Base Assembly Kit"
ITEM.description = "Alongside a set of instructions, this wooden package contains a high ordeal of different component pieces for Crafting apperatus."
ITEM.category = "Tools"
ITEM.width = 3
ITEM.height = 3
ITEM.model = "models/props_junk/wood_crate001a.mdl"
ITEM.useSound = "physics/metal/metal_box_break1.wav"
ITEM.openedItem = "tool_craftingbench"
ITEM.openRequirement = "tool_toolkit"

ITEM.functions.Assemble = {
	icon = "icon16/wrench.png",
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end,
	OnRun = function(item)
		local client = item.player
		
		if (client.CantPlace) then
			client:NotifyLocalized("assembleCant")

			return false
		end
		
		client.CantPlace = true
		
		timer.Simple(3, function()
			if (client) then
				client.CantPlace = false
			end
		end)
		
		local character = client:GetCharacter()
		local inventory = character:GetInventory()
		local requirementTable = ix.item.list[item.openRequirement]
		local requirementName = requirementTable.name or item.openRequirement
		local openerItem = inventory:HasItem(item.openRequirement)

		if (!openerItem) then
			client:NotifyLocalized("assembleMissingRequirement", requirementName)

			return false
		else
			if (item.openedItem) then
				local openedItemName = ix.item.list[item.openedItem].name or item.openedItem
				local openedItemWidth, openedItemHeight = ix.item.list[item.openedItem].width, ix.item.list[item.openedItem].height
				
				timer.Simple(0.25, function()
					if (inventory:FindEmptySlot(openedItemWidth, openedItemHeight)) then
						inventory:Add(item.openedItem)

						if (openerItem.isTool) then
							openerItem:DamageDurability(1)
						end

						client:EmitSound(item.useSound)

						client:NotifyLocalized("assembleSuccess", openedItemName)
					else
						client:NotifyLocalized("assembleNoSpace", openedItemWidth, openedItemHeight)
						
						inventory:Add(item.uniqueID)
					end
				end)
			else
				return false
			end
		end
	end
}
