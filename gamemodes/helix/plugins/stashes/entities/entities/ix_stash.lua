--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Stash"
ENT.Category = "Helix"
ENT.Spawnable = false
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DisplayName")
end

if (SERVER) then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.receivers = {}

		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:EnableMotion()
			physObj:Sleep()
		end
	end

	function ENT:Use(activator)
		local character = activator:GetCharacter()
		if (!character) then
			return
		end

		local invID = activator:GetCharacter():GetStashInventory()
		if (invID == 0) then
			return
		end

		local inventory = ix.item.inventories[invID]
		if (inventory and (activator.ixNextOpen or 0) < CurTime()) then
			local stashName = character:GetStashName()
			if (stashName != "" and string.utf8lower(stashName) != string.utf8lower(self:GetDisplayName()) and (inventory:GetFilledSlotCount() != 0 or character:GetStashMoney() != 0)) then
				activator:NotifyLocalized("stashesOtherInUse")
				return
			end

			character:SetStashName(self:GetDisplayName())
			PLUGIN:OpenInventory(activator, character, self, inventory)
			activator.ixNextOpen = CurTime() + 1
		end
	end
else
	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText(self:GetDisplayName())
		title:SetBackgroundColor(ix.config.Get("color"))
		title:SizeToContents()

		local desc = tooltip:AddRowAfter("name", "description")
		local currStash = LocalPlayer():GetCharacter():GetStashName()
		if (currStash == "") then
			desc:SetText(L("stashStartUsing"))
		elseif (currStash != self:GetDisplayName()) then
			desc:SetText(L("stashOtherInUse", currStash))
		else
			desc:SetText(L("stashHasItems"))
		end
		desc:SizeToContents()
	end
end
