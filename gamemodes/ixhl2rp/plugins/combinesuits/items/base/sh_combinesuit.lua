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
local string = string
local hook = hook
local math = math
local table = table
local ipairs = ipairs
local IsValid = IsValid
local ix = ix
local CAMI = CAMI
local Derma_StringRequest = Derma_StringRequest
local net = net


ITEM.base = "base_outfit"
ITEM.name = "Combine Suit Base"
ITEM.description = "A base for Combine Suit functionality"
ITEM.category = "Combine"

ITEM.maxArmor = 50
ITEM.repairItem = "tool_repair"

ITEM.isRadio = true

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		end

		if (item:GetData("suitActive")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		local panel = tooltip:AddRowAfter("name", "armor")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText("Armor: " .. (self:GetData("equip") and LocalPlayer():Armor() or self:GetData("armor", self.maxArmor)))
		panel:SizeToContents()

		panel = tooltip:AddRowAfter("armor", "name")
		panel:SetBackgroundColor(derma.GetColor("info", tooltip))
		panel:SetText("Name: " .. self:GetData("ownerName", "UNKNOWN"))
		panel:SizeToContents()
	end
end

function ITEM:GetChannels(bForce)
	if ((bForce or self:GetData("suitActive") != false) and self.channels) then
		return self.channels
	else
		return {}
	end
end

function ITEM:CanEquipOutfit(client)
	local player = self.player or client
	local suit = player:GetCharacter():GetCombineSuit()
    if (suit and ix.item.instances[suit] and ix.item.instances[suit] != self) then
		return false
	end

	return true
end

function ITEM:OnGetReplacement(client)
	local player = self.player or client
    if (self.replacement) then
        return self.replacement
    elseif (self.replacementString) then
        local model = "models/"..self.replacementString..string.match(player:GetModel(), "/%a+_?%d%d%.mdl$")
		if (string.find(model, "/male%d%d")) then
			model = string.gsub(model, "/male[01]", {["/male0"] = "/male_0", ["/male_1"] = "/male_1"}, 1)
		end
		return model
    end
end

function ITEM:OnEquipped(client)
	local character = client:GetCharacter()
	client:SetArmor(self:GetData("armor", self.maxArmor))
	character:SetCombineSuit(self:GetID())

    if (!self:GetData("ownerID")) then
        self:SetData("ownerID", character:GetID())
        self:SetData("ownerName", client:Name())
    elseif (self:GetData("ownerID") == character:GetID()) then
        self:SetData("ownerName", client:Name())
		if (self:GetData("trackingActive")) then
			self:SetData("suitActive", true)
		end
    elseif (self:GetData("trackingActive")) then
        ix.combineNotify:AddImportantNotification("WRN:// " .. self:GetData("ownerName") .. " uniform biosignal mismatch detected", nil, client, client:GetPos(), nil)
    end

	local hairBGIndex = client:FindBodygroupByName("hair")
	local hairData = character:GetHair()
	if hairBGIndex != -1 then
		local groups = character:GetData("groups", {})
		groups[hairBGIndex] = hairData.hair or 0
		character:SetData("groups", groups)

		client:SetBodygroup(hairBGIndex, hairData.hair or 0)
	end

	if client and IsValid(client) then
		local replacements = self:OnGetReplacement(client) or self.replacement or client:GetModel()
		local skin = self.newSkin or client:GetSkin()
		local bodygroups = client:GetBodyGroups()

		net.Start("ixRefreshBodygroupsInventoryModel")
			net.WriteString(replacements)
			net.WriteUInt(skin, 5)
			net.WriteTable(bodygroups)
		net.Send(client)
	end

	hook.Run("OnPlayerCombineSuitChange", client, true, self:GetData("suitActive"), self)
end

function ITEM:OnUnequipped(client)
	self:SetData("armor", math.Clamp(client:Armor(), 0, self.maxArmor))
	client:SetArmor(0)
	client:GetCharacter():SetCombineSuit(0)

	if client and IsValid(client) then
		local replacements = client:GetModel()
		local skin = client:GetSkin()
		local bodygroups = client:GetBodyGroups()

		net.Start("ixRefreshBodygroupsInventoryModel")
			net.WriteString(replacements)
			net.WriteUInt(skin, 5)
			net.WriteTable(bodygroups)
		net.Send(client)

		local hairBGIndex = client:FindBodygroupByName("hair")
		local character = client:GetCharacter()
		local hairData = character:GetHair()
		if hairBGIndex != -1 then
			local groups = character:GetData("groups", {})
			groups[hairBGIndex] = hairData.hair or 0
			character:SetData("groups", groups)
	
			client:SetBodygroup(hairBGIndex, hairData.hair or 0)
		end
	end
	
	hook.Run("OnPlayerCombineSuitChange", client, false, false, self)
end

function ITEM:OnDoDeathDrop(client)
	self:SetData("suitActive", false)
end

function ITEM:OnInstanced()
    self:SetData("armor", self.maxArmor)
    self:SetData("suitActive", true)
    self:SetData("trackingActive", true)
	self:SetData("ownerName", "UNKNOWN")
	self.bodyGroups = table.Copy(ix.item.list[self.uniqueID].bodyGroups or {})
end

function ITEM:OnLoadout()
    if (!self:CanEquipOutfit()) then
        self:SetData("equip", false)
    elseif (self:GetData("equip")) then
		self.player:SetArmor(self:GetData("armor", self.maxArmor))
		self.player:GetCharacter():SetCombineSuit(self:GetID())

		hook.Run("OnPlayerCombineSuitChange", self.player, true, self:GetData("suitActive"), self, true)
	end

	self.bodyGroups = table.Copy(ix.item.list[self.uniqueID].bodyGroups or {})
	self.bodyGroups.Pants = self:GetData("Pants")
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

function ITEM:OnRemoved()
	self:SetData("suitActive", false)

	local owner = self:GetOwner()
	if (owner) then
		for _, v in ipairs(self:GetChannels(true)) do
			ix.radio:RemoveListenerFromChannel(owner, v)
		end
	end
end

function ITEM:Repair(client, amount)
	amount = amount or self.maxArmor
	local repairItem = client:GetCharacter():GetInventory():HasItem(self.repairItem)

	if (repairItem) then
		if (repairItem.isTool) then
			repairItem:DamageDurability(1)
		else
			repairItem:Remove()
		end
		self:SetData("armor", math.Clamp(self:GetData("armor") + amount, 0, self.maxArmor))
	end
end

ITEM.functions.Repair = {
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
		if (IsValid(item.entity) or !IsValid(item.player)) then return false end
		if (item:GetData("equip") == true) then return false end
		if (item.repairItem == nil) then return false end
		if (item:GetData("armor") == item.maxArmor) then return false end

		if timer.Exists("combattimer" .. item.player:SteamID64()) then
			item.player:Notify("You cannot use this item while in combat.")
			return false
		end

		return item.player:GetCharacter():GetInventory():HasItem(item.repairItem)
	end
}

ITEM.functions.AdmActivate = {
	name = "(ADM) Activate Suit",
	icon = "icon16/connect.png",
	OnRun = function(item)
		item:SetData("suitActive", true)
		ix.log.Add(item.player, "combineSuitsAdminActivate", item)

		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		if (item:GetData("equip") == true) then return false end
		if (item:GetData("suitActive") == true) then return false end

		local client = item.player
		if (client:GetMoveType() != MOVETYPE_NOCLIP or client:InVehicle()) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Combine Suit Admin Control")
	end
}

ITEM.functions.AdmActivateDe = {
	name = "(ADM) Deactivate Suit",
	icon = "icon16/disconnect.png",
	OnRun = function(item)
		item:SetData("suitActive", false)
		ix.log.Add(item.player, "combineSuitsAdminActivate", item, true)

		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		if (item:GetData("equip") == true) then return false end
		if (item:GetData("suitActive") != true) then return false end

		local client = item.player
		if (client:GetMoveType() != MOVETYPE_NOCLIP or client:InVehicle()) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Combine Suit Admin Control")
	end
}

ITEM.functions.AdmTracker = {
	name = "(ADM) Activate Tracker",
	icon = "icon16/map_add.png",
	OnRun = function(item)
		item:SetData("trackingActive", true)
		ix.log.Add(item.player, "combineSuitsAdminTracking", item)

		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		if (item:GetData("equip") == true) then return false end
		if (item:GetData("trackingActive") == true) then return false end

		local client = item.player
		if (client:GetMoveType() != MOVETYPE_NOCLIP or client:InVehicle()) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Combine Suit Admin Control")
	end
}

ITEM.functions.AdmTrackerDe = {
	name = "(ADM) Deactivate Tracker",
	icon = "icon16/map_delete.png",
	OnRun = function(item)
		item:SetData("trackingActive", false)
		ix.log.Add(item.player, "combineSuitsAdminTracking", item, true)

		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		if (item:GetData("equip") == true) then return false end
		if (item:GetData("trackingActive") != true) then return false end

		local client = item.player
		if (client:GetMoveType() != MOVETYPE_NOCLIP or client:InVehicle()) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Combine Suit Admin Control")
	end
}

ITEM.functions.AdmOwnerDisable = {
	name = "(ADM) Disable Owner",
	icon = "icon16/user_delete.png",
	OnRun = function(item)
		item:SetData("ownerID", -1)
		ix.log.Add(item.player, "combineSuitsAdminOwner", item)

		if (item:GetData("trackingActive")) then
			item.player:NotifyLocalized("suitDisableTracker")
		end

		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		if (item:GetData("ownerID") == -1) then return false end

		local client = item.player
		if (client:GetMoveType() != MOVETYPE_NOCLIP or client:InVehicle()) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Combine Suit Admin Control")
	end
}

ITEM.functions.AdmOwnerClear = {
	name = "(ADM) Clear Owner",
	icon = "icon16/user_edit.png",
	OnRun = function(item)
		item:SetData("ownerID")
		ix.log.Add(item.player, "combineSuitsAdminOwnerClear", item)

		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		if (item:GetData("ownerID") == nil) then return false end

		local client = item.player
		if (client:GetMoveType() != MOVETYPE_NOCLIP or client:InVehicle()) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Combine Suit Admin Control")
	end
}


ITEM.functions.AdmSetName = {
	name = "(ADM) Set Name",
	icon = "icon16/vcard_edit.png",
	OnRun = function(item, data)
		if (data[1] == "") then return end

		item:SetData("ownerName", data[1])
		ix.log.Add(item.player, "combineSuitsAdminName", item)

		return false
	end,
	OnClick = function(item)
		Derma_StringRequest("Set Name", "Set the name stored on this suit:", item:GetData("ownerName"), function(text)
			if (text == "") then return end

			net.Start("ixInventoryAction")
				net.WriteString("AdmSetName")
				net.WriteUInt(item.id, 32)
				net.WriteUInt(item.invID, 32)
				net.WriteTable({text})
			net.SendToServer()
		end)

		return false
	end,
	OnCanRun = function(item)
		if (IsValid(item.entity)) then return false end
		if (item:GetData("equip") == true) then return false end
		if (item:GetData("ownerID") == nil) then return false end

		local client = item.player
		if (client:GetMoveType() != MOVETYPE_NOCLIP or client:InVehicle()) then return false end

		local inventory = ix.item.inventories[item.invID]
		if (inventory and inventory.owner == item:GetData("ownerID")) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Combine Suit Admin Control")
	end
}

ITEM.functions.Pants = {
	name = "Change Boots",
	tip = "repairTip",
	icon = "icon16/user_suit.png",
	OnRun = function(item)
		local originalItem = ix.item.list[item.uniqueID]
		local actual = originalItem.bodyGroups.Pants or 0
		if (item.bodyGroups.Pants != actual) then
			item.bodyGroups.Pants = actual
			item:SetData("Pants", actual)
			item.player:Notify("Normal boots set.")
		else
			item.bodyGroups.Pants = 1
			item:SetData("Pants", 1)
			item.player:Notify("Combat boots set.")
		end
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return item.isCP != nil and item:GetData("equip") == false and
            !IsValid(item.entity) and IsValid(client)
	end
}
