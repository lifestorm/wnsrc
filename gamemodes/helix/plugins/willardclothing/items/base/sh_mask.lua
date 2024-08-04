--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.base = "base_bgclothes"

ITEM.isGasmask = true
ITEM.isMask = true

ITEM.filterQuality = 0.1
ITEM.maxFilterValue = 30
ITEM.refillItem = nil
ITEM.filterDecayStart = 0.1

ITEM.noReplace = true
ITEM.noUseOutGas = true

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item.outlineColor and not item:GetData("equip")) then
            surface.SetDrawColor(item.outlineColor)
		    surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
        end
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
		panel:SetText("Integrity: "..math.Round(self:GetData("filterValue", self.maxFilterValue) * 100 / self.maxFilterValue, 1).."%\n"..
						"Quality: "..math.Round(self:GetFilterQuality() * 100, 1).."%")
		panel:SizeToContents()
	end
end

function ITEM:GetFilterQuality()
	local filterValue = self:GetData("filterValue", self.maxFilterValue)

    if (filterValue > self.maxFilterValue * self.filterDecayStart) then
        return self.filterQuality
    else
        return math.Remap(filterValue, 0, self.maxFilterValue * self.filterDecayStart, 0, self.filterQuality)
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
    if (item.isGasmask and item.player:GetFilterItem() == item:GetID()) then
		return false
	end

	if (item:GetData("equip")) then
		item:RemoveOutfit(item:GetOwner())
        item:RemoveFilter(item.player)
	end
end)

ITEM.functions.Clean = {
	name = "Clean",
	tip = "repairTip",
	icon = "icon16/wand.png",
	OnRun = function(item)
		item:Refill(item.player)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return item.refillItem != nil and item:GetData("equip") == false and
            !IsValid(item.entity) and IsValid(client) and
            item:GetData("filterValue") < item.maxFilterValue and
            client:GetCharacter():GetInventory():HasItem(item.refillItem)
	end
}

function ITEM:Refill(client, amount)
	amount = amount or self.maxFilterValue
	local refillItem = client:GetCharacter():GetInventory():HasItem(self.refillItem)

	if (refillItem) then
		refillItem:Remove()
		self:SetData("filterValue", math.Clamp(self:GetData("filterValue") + amount, 0, self.maxFilterValue))
	end
end

function ITEM:OnUnEquip(client)
	local player = client or self.player
    self:RemoveFilter(player)
end

function ITEM:OnEquip(client)
    client:GetCharacter():SetFilterItem(self:GetID())
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
        if (self.player.HasGasmask and !self.player:HasGasmask()) then
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

function ITEM:OnInstanced()
	self:SetData("filterValue", self.maxFilterValue)
end
