--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Stackable Base"
ITEM.description = "Makes items stackable."
ITEM.category = "Base"

ITEM.maxStackSize = 1
ITEM.bInstanceMaxstack = false
ITEM.bNoSplit = false

do
    local META = ix.meta.inventory
    function META:GetItemCount(uniqueID, onlyMain)
        local i = 0

        for _, v in pairs(self:GetItems(onlyMain)) do
            if (v.uniqueID == uniqueID) then
                i = i + v:GetStackSize()
            end
        end

        return i
    end
end

do
    -- Define this on all items to make life easier
    local ITEM = ix.meta.item or {}
    function ITEM:GetStackSize()
        return self:GetData("stack", self.bInstanceMaxstack and self.maxStackSize or 1)
    end

    function ITEM:IsSingleItem()
        return self:GetStackSize() <= 1
    end

    function ITEM:IsFullStack()
        return self:GetStackSize() == (self.maxStackSize or 1)
    end
end

hook.Add("CanPlayerInteractItem", "ixStackableItemBase", function(client, action, item, data)
    if (!isentity(item) or !IsValid(item)) then return end

    if (action == "take") then return end

    local itemID = item.ixItemID
    if (!itemID) then return end

    item = ix.item.instances[itemID]
    if (!item) then
        return
    end

    if (item and item.maxStackSize and item.maxStackSize > 1 and !item:IsSingleItem()) then
        return false
    end
end)

hook.Add("InventoryItemAdded", "ixStackableItemInvAdd", function(oldInv, newInv, item)
    if (oldInv != nil or !item.maxStackSize or item.maxStackSize == 1) then return end
    if (item:IsFullStack() or item:GetData("bIsSplit")) then
        item:SetData("bIsSplit", nil)
        return
    end

    local items = newInv:GetItemsByUniqueID(item.uniqueID, true)
    local id = item:GetID()
    for _, v in ipairs(items) do
        if (v:GetID() == id) then continue end

        local totalSize = item:GetStackSize()
        if (v:GetStackSize() < v.maxStackSize) then
            local toMove = math.min(v.maxStackSize - v:GetStackSize(), totalSize)
            v:AddStack(toMove)
            totalSize = totalSize - toMove

            if (totalSize == 0) then
                return ix.meta.item.Remove(item)
            end
        end

        item:SetData("stack", totalSize)
    end
end)

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (!item:IsSingleItem()) then
            draw.SimpleText(
                item:GetStackSize(), "DermaDefault", w - 5, h - 5,
                color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black
            )
        end

        if (item.outlineColor) then
            surface.SetDrawColor(item.outlineColor)
		    surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
        end
	end
else
    function ITEM:Remove(bNoReplication, bNoDelete)
        return self:RemoveStack(1, bNoReplication, bNoDelete)
    end

    function ITEM:AddStack(amount)
        local stack = self:GetData("stack")
        if (stack) then
            return self:SetStack(stack + amount)
        end
    end

    function ITEM:RemoveStack(amount, bNoReplication, bNoDelete)
        local stack = self:GetData("stack")
        if (stack) then
            return self:SetStack(stack - amount)
        end
    end

    function ITEM:SetStack(amount, bNoReplication, bNoDelete)
        self:SetData("stack", math.Clamp(amount, 0, self.maxStackSize))
        if (self:GetStackSize() == 0) then
            return ix.meta.item.Remove(self, bNoReplication, bNoDelete)
        end

        return true
    end
end

function ITEM:OnInstanced()
	if (!self:GetData("stack")) then
        self:SetStack(self:GetStackSize())
    end
end

ITEM.functions.combine = {
	OnRun = function(item, data)
        local other = ix.item.instances[data[1]]
		if (other:GetStackSize() + item:GetStackSize() > item.maxStackSize) then
            local added = item.maxStackSize - item:GetStackSize()
            item:AddStack(added) -- set to max stack size
            other:RemoveStack(added)
        else
            item:AddStack(other:GetStackSize())
            other:RemoveStack(other:GetStackSize())
			if (item.junk) then
				if (!item.player:GetCharacter():GetInventory():Add(item.junk)) then
					ix.item.Spawn(item.junk, item.player)
				end
			end
        end

		return false
	end,
	OnCanRun = function(item, data)
        if (!item.maxStackSize or item.maxStackSize < 2) then return false end

		local other = ix.item.instances[data[1]]
        if (!other or other.uniqueID != item.uniqueID) then
            return false
        end
	end
}

ITEM.functions.split = {
	name = "Split Stack",
	isMulti = true,
	multiOptions = function(item, player)
		local options = {{name = "1", data = {1}}}

        for i = 5, item:GetStackSize() - 1, 5 do
            options[#options + 1] = {name = tostring(i), data = {i}}
        end

        if (item:GetStackSize() > 2) then
            options[#options + 1] = {name = "other", data = {-1}, OnClick = function(itemTable)
                Derma_StringRequest("Split Stack", "How many items do you wish to move to a new stack?", LocalPlayer().ixLastStackSize or "", function(text)
                    local amount = tonumber(text)
                    if (!amount or amount <= 0 or amount >= itemTable:GetStackSize()) then return end

                    LocalPlayer().ixLastStackSize = amount

                    net.Start("ixInventoryAction")
                        net.WriteString("split")
                        net.WriteUInt(itemTable.id, 32)
                        net.WriteUInt(itemTable.invID, 32)
                        net.WriteTable({amount})
                    net.SendToServer()
                end)

                return false
            end}
        end

        return options
	end,
	OnRun = function(item, data)
        local amount = math.floor(tonumber(data and data[1] or 1) or 0)
        if (!amount or amount <= 0 or amount >= item:GetStackSize()) then return false end

        local inventory = ix.item.inventories[item.invID]
        if (item.junk) then
            local junk = inventory:HasItem(item.junk)
            if (junk) then
                junk:Remove()
            end
        end

        inventory:Add(item.uniqueID, 1, {stack = amount, bIsSplit = true})
        item:RemoveStack(amount)

		return false
	end,
	OnCanRun = function(item)
        if (IsValid(item.entity)) then return false end

        if (!item.maxStackSize or item.maxStackSize < 2 or item.bNoSplit == true) then return false end

        local inventory = ix.item.inventories[item.invID]
        if (item.junk and !inventory:HasItem(item.junk)) then return false end

		return !IsValid(item.entity) and !item:IsSingleItem() and inventory:FindEmptySlot(item.width, item.height) != nil
	end
}