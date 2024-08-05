--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Suitcase"
ITEM.description = "A small suitcase ready to carry everything you'd rather not be."
ITEM.model = Model("models/weapons/w_suitcase_passenger.mdl")

if (CLIENT) then
    function ITEM:PaintOver(item, w, h)
        if (item:GetData("equip")) then
            surface.SetDrawColor(110, 255, 110, 100)
            surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
        end
    end
end

ITEM.functions.Equip = {
    name = "Equip",
    tip = "equipTip",
    icon = "icon16/tick.png",
    OnRun = function(item)
        local client = item.player
        if client then
            client:Give("ix_suitcase")
        end
        item:SetData("equip", true)
        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        local character = client:GetCharacter()
        local characterInv = character:GetInventory()
        if client then
            if client:HasWeapon("ix_suitcase") then
                return false
            end
            if character and characterInv then
                if characterInv:HasItem(item.uniqueID) then
                    return true
                end
            end
        end
        return false
    end
}

ITEM.functions.EquipUn = {
    name = "Unequip",
    tip = "unequipTip",
    icon = "icon16/cross.png",
    OnRun = function(item)
        local client = item.player
        if client then
            client:StripWeapon("ix_suitcase")
        end
        item:SetData("equip", false)
        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        if client then
            if client:HasWeapon("ix_suitcase") then
                return true
            end
        end
        return false
    end
}

function ITEM:CanTransfer(oldInventory, newInventory)
    if (newInventory and self:GetData("equip")) then
        return false
    end

    local index = self:GetData("id")
	if (newInventory) then
		if (newInventory.vars and newInventory.vars.isBag and !newInventory.vars.isContainer) then
			return false
		end

		local index2 = newInventory:GetID()

		if (index == index2) then
			return false
		end

		for _, v in pairs(self:GetInventory():GetItems()) do
			if (v:GetData("id") == index2) then
				return false
			end
		end

		if index2 and newInventory.vars then
			for _, v in pairs(newInventory:GetItems()) do
				if v.name == self.name then
					if newInventory:GetOwner() then
						if v.name == "Suitcase" then
							newInventory:GetOwner():NotifyLocalized("You can't carry more than one suitcase!")
						else
							newInventory:GetOwner():NotifyLocalized("You can't carry more than one of this bag!")
						end
					end

					return false
				end
			end
		end
	end

	return !newInventory or newInventory:GetID() != oldInventory:GetID() or newInventory.vars.isBag
end

function ITEM:OnRemoved()
	local inventory = ix.item.inventories[self.invID]
    local owner = inventory.GetOwner and inventory:GetOwner()

    if (IsValid(owner) and owner:IsPlayer()) then
		local weapon = owner:GetWeapon("ix_suitcase")

		if (IsValid(weapon)) then
			owner:StripWeapon("ix_suitcase")
        end
    end

    local index = self:GetData("id")
	if (index) then
		local query = mysql:Delete("ix_items")
			query:Where("inventory_id", index)
		query:Execute()

		query = mysql:Delete("ix_inventories")
			query:Where("inventory_id", index)
		query:Execute()
	end
end