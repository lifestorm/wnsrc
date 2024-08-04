--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


if (SERVER) then
	util.AddNetworkString("ixRefreshBodygroupsInventoryModel")
else
	net.Receive("ixRefreshBodygroupsInventoryModel", function()
		local replacements = net.ReadString()
		local skin = net.ReadUInt(5)
		local bodygroups = net.ReadTable()

		if ix.gui.inventoryModel and IsValid(ix.gui.inventoryModel) then
			ix.gui.inventoryModel:SetModel(replacements, skin, false)

			if ix.gui.inventoryModel.Entity and ix.gui.inventoryModel.Entity.SetBodygroup then
				for _, v in ipairs(bodygroups or {}) do
					ix.gui.inventoryModel.Entity:SetBodygroup(v.id, LocalPlayer():GetBodygroup(v.id))
				end
			end
		end
	end)
end

ITEM.name = "Outfit"
ITEM.description = "A Outfit Base."
ITEM.category = "Outfit"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "model"
ITEM.pacData = {}

--[[
-- This will change a player's skin after changing the model. Keep in mind it starts at 0.
ITEM.newSkin = 1
-- This will change a certain part of the model.
ITEM.replacements = {"group01", "group02"}
-- This will change the player's model completely.
ITEM.replacements = "models/manhack.mdl"
-- This will have multiple replacements.
ITEM.replacements = {
	{"male", "female"},
	{"group01", "group02"}
}

-- This will apply body groups.
ITEM.bodyGroups = {
	["blade"] = 1,
	["bladeblur"] = 1
}
]]--

-- Inventory drawing
if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		end
	end
end

function ITEM:AddOutfit(client)
	local character = client:GetCharacter()

	self:SetData("equip", true)

	local groups = character:GetData("groups", {})

	-- remove original bodygroups
	if (!table.IsEmpty(groups)) then
		character:SetData("oldGroups" .. self.outfitCategory, groups)
		character:SetData("groups", {})

		client:ResetBodygroups()
	end

	if (isfunction(self.OnGetReplacement)) then
		character:SetData("oldModel" .. self.outfitCategory,
			character:GetData("oldModel" .. self.outfitCategory, client:GetModel()))
		character:SetModel(self:OnGetReplacement(client))
	elseif (self.replacement or self.replacements) then
		character:SetData("oldModel" .. self.outfitCategory,
			character:GetData("oldModel" .. self.outfitCategory, client:GetModel()))

		if (istable(self.replacements)) then
			if (#self.replacements == 2 and isstring(self.replacements[1])) then
				character:SetModel(client:GetModel():gsub(self.replacements[1], self.replacements[2]))
			else
				for _, v in ipairs(self.replacements) do
					character:SetModel(client:GetModel():gsub(v[1], v[2]))
				end
			end
		else
			character:SetModel(self.replacement or self.replacements)
		end
	end

	if (self.newSkin) then
		character:SetData("oldSkin" .. self.outfitCategory, client:GetSkin())
		client:SetSkin(self.newSkin)
	end

	-- get outfit saved bodygroups
	groups = self:GetData("groups", {})

	-- restore bodygroups saved to the item
	if (!table.IsEmpty(groups) and self:ShouldRestoreBodygroups()) then
		for k, v in pairs(groups) do
			client:SetBodygroup(k, v)
		end
	-- apply default item bodygroups if none are saved
	elseif (istable(self.bodyGroups)) then
		for k, v in pairs(self.bodyGroups) do
			local index = client:FindBodygroupByName(k)

			if (index > -1) then
				client:SetBodygroup(index, v)
			end
		end
	end

	local materials  = self:GetData("submaterial", {})

	if (!table.IsEmpty(materials) and self:ShouldRestoreSubMaterials()) then
		for k, v in pairs(materials) do
			if (!isnumber(k) or !isstring(v)) then
				continue
			end

			client:SetSubMaterial(k - 1, v)
		end
	end

	if (istable(self.attribBoosts)) then
		for k, v in pairs(self.attribBoosts) do
			character:AddBoost(self.uniqueID, k, v)
		end
	end

	self:OnEquipped(client)
end

local function ResetSubMaterials(client)
	for k, _ in ipairs(client:GetMaterials()) do
		if (client:GetSubMaterial(k - 1) != "") then
			client:SetSubMaterial(k - 1)
		end
	end
end

function ITEM:RemoveOutfit(client)
	local character = client:GetCharacter()

	self:SetData("equip", false)

	local materials = {}

	for k, _ in ipairs(client:GetMaterials()) do
		if (client:GetSubMaterial(k - 1) != "") then
			materials[k] = client:GetSubMaterial(k - 1)
		end
	end

	-- save outfit submaterials
	if (!table.IsEmpty(materials)) then
		self:SetData("submaterial", materials)
	end

	-- remove outfit submaterials
	ResetSubMaterials(client)

	local groups = {}

	for i = 0, (client:GetNumBodyGroups() - 1) do
		local bodygroup = client:GetBodygroup(i)

		if (bodygroup > 0) then
			groups[i] = bodygroup
		end
	end

	-- save outfit bodygroups
	if (!table.IsEmpty(groups)) then
		self:SetData("groups", groups)
	end

	-- remove outfit bodygroups
	client:ResetBodygroups()

	-- restore the original player model
	if (character:GetData("oldModel" .. self.outfitCategory)) then
		character:SetModel(character:GetData("oldModel" .. self.outfitCategory))
		character:SetData("oldModel" .. self.outfitCategory, nil)
	end

	-- restore the original player model skin
	if (self.newSkin) then
		if (character:GetData("oldSkin" .. self.outfitCategory)) then
			client:SetSkin(character:GetData("oldSkin" .. self.outfitCategory))
			character:SetData("oldSkin" .. self.outfitCategory, nil)
		else
			client:SetSkin(0)
		end
	end

	-- get character original bodygroups
	groups = character:GetData("oldGroups" .. self.outfitCategory, {})

	-- restore original bodygroups
	if (!table.IsEmpty(groups)) then
		for k, v in pairs(groups) do
			client:SetBodygroup(k, v)
		end

		character:SetData("groups", character:GetData("oldGroups" .. self.outfitCategory, {}))
		character:SetData("oldGroups" .. self.outfitCategory, nil)
	end

	if (istable(self.attribBoosts)) then
		for k, _ in pairs(self.attribBoosts) do
			character:RemoveBoost(self.uniqueID, k)
		end
	end

	for k, _ in pairs(self:GetData("outfitAttachments", {})) do
		self:RemoveAttachment(k, client)
	end

	self:OnUnequipped(client)
end

-- makes another outfit depend on this outfit in terms of requiring this item to be equipped in order to equip the attachment
-- also unequips the attachment if this item is dropped
function ITEM:AddAttachment(id)
	local attachments = self:GetData("outfitAttachments", {})
	attachments[id] = true

	self:SetData("outfitAttachments", attachments)
end

function ITEM:RemoveAttachment(id, client)
	local item = ix.item.instances[id]
	local attachments = self:GetData("outfitAttachments", {})

	if (item and attachments[id]) then
		item:OnDetached(client)
	end

	attachments[id] = nil
	self:SetData("outfitAttachments", attachments)
end

ITEM:Hook("drop", function(item)
	local character = ix.char.loaded[item.owner]
	local client = character and character:GetPlayer() or item:GetOwner()

	if hook.Run("CanPlayerUnequipItem", client, item) == false then
		return
	end

	if (item:GetData("equip")) then
		item.player = client
		item:RemoveOutfit(item:GetOwner())
	end
end)

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	OnRun = function(item, creationClient)
		local client = item.player or creationClient

		item:RemoveOutfit(client)
		return false
	end,
	OnCanRun = function(item, creationClient)
		local client = item.player or creationClient

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item, creationClient)
		local client = item.player or creationClient
		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (itemTable.pacData and v.outfitCategory == item.outfitCategory and itemTable:GetData("equip")) then
					client:NotifyLocalized(item.equippedNotify or "outfitAlreadyEquipped")
					return false
				end
			end
		end

		item:AddOutfit(client)
		return false
	end,
	OnCanRun = function(item, creationClient)
		local client = item.player or creationClient

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and item:CanEquipOutfit(client) and
			hook.Run("CanPlayerEquipItem", client, item) != false
	end
}

function ITEM:CanTransfer(oldInventory, newInventory)
	if (hook.Run("CanTransferBGClothes", oldInventory, newInventory) != false) then
		return true
	end

	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnRemoved()
	if (self.invID != 0 and self:GetData("equip")) then
		self.player = self:GetOwner()
			self:RemoveOutfit(self.player)
		self.player = nil
	end
end

function ITEM:OnEquipped(client)
	if client and IsValid(client) then
		local replacements = self.replacement or client:GetModel()
		local skin = self.newSkin or client:GetSkin()
		local bodygroups = client:GetBodyGroups()

		net.Start("ixRefreshBodygroupsInventoryModel")
			net.WriteString(replacements)
			net.WriteUInt(skin, 5)
			net.WriteTable(bodygroups)
		net.Send(client)
	end
end

function ITEM:OnUnequipped(client)
	if client and IsValid(client) then
		local replacements = client:GetModel()
		local skin = client:GetSkin()
		local bodygroups = client:GetBodyGroups()

		net.Start("ixRefreshBodygroupsInventoryModel")
			net.WriteString(replacements)
			net.WriteUInt(skin, 5)
			net.WriteTable(bodygroups)
		net.Send(client)
	end
end

function ITEM:CanEquipOutfit()
	return true
end

function ITEM:ShouldRestoreBodygroups()
	return true
end

function ITEM:ShouldRestoreSubMaterials()
	return true
end
