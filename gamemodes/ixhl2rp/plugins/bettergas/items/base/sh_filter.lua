--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local surface = surface
local derma = derma
local math = math
local IsValid = IsValid
local hook = hook
local table = table

ITEM.name = "Filter Base"
ITEM.model = Model("models/props_junk/TrafficCone001a.mdl")
ITEM.description = "A generic filter against smelly things and bad stuff in the air."

ITEM.filterQuality = 0.5 -- percentage protection
ITEM.maxFilterValue = 60 -- max duration in minutes
ITEM.refillItem = nil
ITEM.filterDecayStart = 0.1 -- percentage of filter value remaining where quality starts to drop linearly to 0

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		if (self:GetData("equip")) then
			local name = tooltip:GetRow("name")
			name:SetBackgroundColor(derma.GetColor("Success", tooltip))
		end

		local panel = tooltip:AddRowAfter("name", "integrity")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText("Integrity: "..math.Round(self:GetFilterValue() * 100 / self.maxFilterValue, 1).."%\n"..
						"Quality: "..math.Round(self:GetFilterQuality() * 100, 1).."%")
		panel:SizeToContents()
	end
end

function ITEM:GetFilterValue()
	return self:GetData("filterValue", self.maxFilterValue)
end

function ITEM:GetFilterQuality()
    if (self:GetFilterValue() > self.maxFilterValue * self.filterDecayStart) then
        return self.filterQuality
    else
        return math.Remap(self:GetFilterValue(), 0, self.maxFilterValue * self.filterDecayStart, 0, self.filterQuality)
    end
end

function ITEM:RemoveFilter(client)
	self:SetData("equip", false)

    local character = client:GetCharacter()
    if (character:GetFilterItem() == self:GetID()) then
        character:SetFilterItem(0)
    end
end

ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		item:RemoveFilter(item:GetOwner())
	end
end)

ITEM.functions.Refill = {
	name = "Refill",
	tip = "repairTip",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		item:Refill(item.player)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return item.refillItem != nil and item:GetData("equip") == false and
            !IsValid(item.entity) and IsValid(client) and
            item:GetFilterValue() < item.maxFilterValue and
            client:GetCharacter():GetInventory():HasItem(item.refillItem)
	end
}

function ITEM:Refill(client, amount)
	amount = amount or self.maxFilterValue
	local refillItem = client:GetCharacter():GetInventory():HasItem(self.refillItem)

	if (refillItem) then
		refillItem:Remove()
		self:SetData("filterValue", math.Clamp(self:GetFilterValue() + amount, 0, self.maxFilterValue))
	end
end

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "unequipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		if (item.player) then
			item:RemoveFilter(item.player)
		else
			item:SetData("equip", false)
		end
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}

ITEM.functions.Replace = {
	name = "Replace",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()

        local oldFilter = client:GetFilterItem()
        oldFilter:RemoveFilter(client)

		item:SetData("equip", true)
        character:SetFilterItem(item:GetID())

		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		if item.factionList and !table.HasValue(item.factionList, client:GetCharacter():GetFaction()) then
			return false
		end

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false and item:CanReplaceFilter()
	end
}

function ITEM:CanReplaceFilter()
    local filterItem = self.player:GetFilterItem()
	if (!filterItem or filterItem == self) then
        return false
    end

    if (!filterItem.RemoveFilter or filterItem.noReplace) then
        return false
    end

	if (!self.player:HasGasmask()) then
		return false
	end

	return true
end

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		local client = item.player
		local character = client:GetCharacter()

		item:SetData("equip", true)
        character:SetFilterItem(item:GetID())

		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		if item.factionList and !table.HasValue(item.factionList, client:GetCharacter():GetFaction()) then
			return false
		end

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false and item:CanEquipFilter()
	end
}

function ITEM:CanEquipFilter()
	if (self.player:GetFilterItem() != nil) then
        return false
    end

	if (!self.player:HasGasmask()) then
		return false
	end

	return true
end

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnInstanced()
	self:SetData("filterValue", self.maxFilterValue)
end

function ITEM:OnRemoved()
	if (self.invID != 0 and self:GetData("equip")) then
		self.player = self:GetOwner()
		self:RemoveFilter(self.player)

		if self.OnUnEquip then
			self:OnUnEquip()
		end

		self.player = nil
	end
end

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
        if (!self.player:HasGasmask()) then
            self:SetData("equip", false)
            return
        end

        local character = self.player:GetCharacter()
        if (character:GetFilterItem() != 0 and character:GetFilterItem() != self:GetID()) then
            self:SetData("equip", false)
        else
            character:SetFilterItem(self:GetID())
        end
	end
end