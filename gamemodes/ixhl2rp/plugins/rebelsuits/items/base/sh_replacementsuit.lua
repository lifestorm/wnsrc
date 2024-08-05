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
ITEM.name = "Conscript Suit Base"
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

	end

	function ITEM:PopulateTooltip(tooltip)
		local panel = tooltip:AddRowAfter("name", "armor")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText("Armor: " .. (self:GetData("equip") and LocalPlayer():Armor() or self:GetData("armor", self.maxArmor)))
		panel:SizeToContents()

	end
end

function ITEM:GetChannels(bForce)
	if ((bForce != false) and self.channels) then
		return self.channels
	else
		return {}
	end
end

function ITEM:CanEquipOutfit(client)
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
end

function ITEM:OnUnequipped(client)
	self:SetData("armor", math.Clamp(client:Armor(), 0, self.maxArmor))
	client:SetArmor(0)

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
end

function ITEM:OnDoDeathDrop(client)
end

function ITEM:OnInstanced()
    self:SetData("armor", self.maxArmor)
end

function ITEM:OnLoadout()
    if (!self:CanEquipOutfit()) then
        self:SetData("equip", false)
    elseif (self:GetData("equip")) then
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

function ITEM:OnRemoved()

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
