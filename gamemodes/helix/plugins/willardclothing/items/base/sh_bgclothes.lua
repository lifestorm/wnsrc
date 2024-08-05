--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Bodygroup Clothing"
ITEM.model = Model("models/props_c17/BriefCase001a.mdl")
ITEM.description = "A generic piece of clothing."

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

		if (self.maxArmor) then
			local panel = tooltip:AddRowAfter("name", "armor")
			panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
			panel:SetText("Armor: " .. (self:GetData("equip") and LocalPlayer():Armor() or self:GetData("armor", self.maxArmor)))
			panel:SizeToContents()
		end
	end
end

function ITEM:RemoveOutfit(client)
	local char = client.GetCharacter and client:GetCharacter()

	self:SetData("equip", false)
	if (self.maxArmor) then
		self:SetData("armor", math.Clamp(client:Armor(), 0, self.maxArmor))
		client:SetArmor(0)
	end

	local groups = char:GetData("groups", {})

	if self.bodyGroups then
		for k in pairs(self.bodyGroups) do
			local index = client:FindBodygroupByName(k)

			if (index > -1) then
				groups[index] = 0
				char:SetData("groups", groups)
				client:SetBodygroup(index, 0)

				netstream.Start(client, "ItemEquipBodygroups", index, 0)
			end
		end
	end

	if self.outfitCategory == "Head" then
		local hairIndex = client:FindBodygroupByName("hair")
		local hair = char.GetHair and char:GetHair() or {}
		local curHair = hair.hair or false

		if curHair then
			if char then
				groups[hairIndex] = curHair
				char:SetData("groups", groups)
			end

			client:SetBodygroup(hairIndex, curHair)
			netstream.Start(client, "ItemEquipBodygroups", hairIndex, curHair)
		end
	end

	if (self.proxy) then
		local charProxies = char and char:GetProxyColors() or {}

		for proxy, _ in pairs(self.proxy) do
			if charProxies[proxy] then
				charProxies[proxy] = nil
			end
		end

		char:SetProxyColors(charProxies)
	end
end

ITEM:Hook("drop", function(item)
	if (item.isGasmask and item.player:GetFilterItem()) then
		return false
	end

	if (item:GetData("equip")) then
		item:RemoveOutfit(item:GetOwner())
	end
end)

ITEM.functions.Repair = { -- sorry, for name order.
	name = "Repair",
	tip = "repairTip",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local item = item
		local player = item.player

		player:Freeze(true)
        player:SetAction("Repairing Armor...", 5, function()
			if !IsValid(player) then return end
			player:Freeze(false)
			item:Repair(player)
		end)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		if timer.Exists("combattimer" .. item.player:SteamID64()) then
			item.player:Notify("You cannot use this item while in combat.")
			return false
		end

		return (item.maxArmor != nil and item:GetData("equip") == false and !IsValid(item.entity)
		and IsValid(client) and client:GetCharacter():GetInventory():HasItem("tool_repair") and item:GetData("armor") < item.maxArmor
		and (client.nextRepair or 0) <= CurTime())
	end
}

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "unequipTip",
	icon = "icon16/cross.png",
	OnRun = function(item, creationClient)
		local client = item.player or creationClient

		if (client) then
			item:RemoveOutfit(client)

			client:UpdateLegs()

			if item.OnUnEquip then
				item:OnUnEquip(client)
			end
		else
			item:SetData("equip", false)

			client:UpdateLegs()

			if item.OnUnEquip then
				item:OnUnEquip(client)
			end
		end
		return false
	end,
	OnCanRun = function(item, creationClient)
		local client = item.player or creationClient

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item:CanUnequipOutfit(client)
	end
}

function ITEM:OnEquip(client)
	if !client or client and !IsValid(client) then return end
	if !client.GetNumBodyGroups then return end
	if !client.GetModel then return end
	local model = client:GetModel()
	local model1, model2 = "models/willardnetworks/citizens/", "wn7new/metropolice"
	if !model:find(model1) and !model:find(model2) then return end

	local hairBG = client:FindBodygroupByName( "hair" )
	local toFind = model:find(model1) and "headwear" or "cp_Head"
	local curHeadwearBG = client:GetBodygroup(client:FindBodygroupByName( toFind ))
	local curHairBG = client:GetBodygroup(hairBG)

	local hairBgLength = 0
	for _, v in pairs(client:GetBodyGroups()) do
		if v.name  != "hair" then continue end
		if !v.submodels then continue end
		if !istable(v.submodels) then continue end

		hairBgLength =  #v.submodels
		break
	end

	if (curHeadwearBG != 0) then
		if curHairBG != 0 or model:find(model2) then
			local char = client.GetCharacter and client:GetCharacter()
			if char then
				local groups = char:GetData("groups", {})
				groups[hairBG] = hairBgLength
				char:SetData("groups", groups)
			end

			client:SetBodygroup(hairBG, hairBgLength)
			netstream.Start(client, "ItemEquipBodygroups", hairBG, hairBgLength)
		end
	end
end

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item, creationClient)
		local client = item.player or creationClient
		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()
		local groups = char:GetData("groups", {})

		-- Checks if any [Torso] is already equipped.
		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (v.outfitCategory == item.outfitCategory and itemTable:GetData("equip")) then
					client:NotifyLocalized(item.equippedNotify or "outfitAlreadyEquipped")
					return false
				end
			end
		end

		if (item.maxArmor) then
			client:SetArmor(item:GetData("armor", item.maxArmor))
		end

		item:SetData("equip", true)

		if (item.proxy) then
			local charProxies = char:GetProxyColors() or {}

			for proxy, color in pairs(item.proxy) do
				charProxies[proxy] = color
			end

			char:SetProxyColors(charProxies)
		end

		client:UpdateLegs()

		if (item.bodyGroups) then
			for k, value in pairs(item.bodyGroups) do
				local index = client:FindBodygroupByName(k)

				if (index > -1) then
					groups[index] = value
					char:SetData("groups", groups)
					client:SetBodygroup(index, value)

					netstream.Start(client, "ItemEquipBodygroups", index, value)

					if item.OnEquip then
						item:OnEquip(client)
					end
				end
			end
		end

		return false
	end,
	OnCanRun = function(item, creationClient)
		local client = item.player or creationClient

		if (item.factionList and !table.HasValue(item.factionList, client:GetCharacter():GetFaction())) then
			return false
		end

		-- I shouldn't hardcode this but I can't think of any other instance where we'd need this, so meh.
		-- luacheck: ignore 1
		if (client:Team() == FACTION_VORT and (!item.factionList or !table.HasValue(item.factionList, FACTION_VORT))) then
			return false
		end

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true
		and hook.Run("CanPlayerEquipItem", client, item) != false and item:CanEquipOutfit(client)
	end
}

function ITEM:Repair(client, amount)
	local repairItem = client:GetCharacter():GetInventory():HasItem("tool_repair")

	if (repairItem) then
		amount = amount or self.maxArmor

		if (repairItem.isTool) then
			repairItem:DamageDurability(1)
		end

		client.nextRepair = CurTime() + 20

		self:SetData("armor", math.Clamp(self:GetData("armor") + amount, 0, self.maxArmor))
	end
end

function ITEM:CanTransfer(oldInventory, newInventory)
	if (hook.Run("CanTransferBGClothes", oldInventory, newInventory) != false) then
		return true
	end

	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnInstanced()
	if (self.maxArmor) then
		self:SetData("armor", self.maxArmor)
	end
end

function ITEM:GetProxyColors()
	return self.proxy
end

function ITEM:OnInventoryDraw(entity, proxyList)
	if !entity or entity and !IsValid(entity) then return end

    entity.GetProxyColors = function()
		if !self.proxy then return end

		local colors = {}

		if proxyList then
			for proxy, color in pairs(proxyList) do
				colors[proxy] = color
			end
		else
			for proxy, color in pairs(self.proxy) do
				if colors[proxy] then continue end

				colors[proxy] = color
			end
		end

        return colors
    end
end

function ITEM:OnRemoved()
	if (self.invID != 0 and self:GetData("equip")) then
		self.player = self:GetOwner()
		self:RemoveOutfit(self.player)

		if self.OnUnEquip then
			self:OnUnEquip()
		end

		self.player = nil
	end
end

function ITEM:OnLoadout()
	if (self.maxArmor and self:GetData("equip")) then
		self.player:SetArmor(self:GetData("armor", self.maxArmor))
	end
end

function ITEM:OnSave()
	if (self:GetData("equip") and self.maxArmor) then
		local armor = math.Clamp(self.player:Armor(), 0, self.maxArmor)
		self:SetData("armor", armor)
		if (armor != self.player:Armor()) then
			self.player:SetArmor(armor)
		end
	end
end

function ITEM:CanEquipOutfit(client)
	local player = self.player or client
	if (self.maxArmor) then
		local bgItems = player:GetCharacter():GetInventory():GetItemsByBase("base_bgclothes", true)
		for _, v in pairs(bgItems) do
			if (v:GetData("equip") and v.maxArmor) then
				return false
			end
		end
	end

	return true
end

function ITEM:CanUnequipOutfit()
	return true
end
