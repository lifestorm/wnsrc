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

ITEM.name = "Vortigaunt Collar (fake)"
ITEM.description = "A heavy, metallic collar with borderline alien technology inside. Completely neutralizes a vortigaunt's ability to manipulate energies around them. Once worn, it cannot be removed without the proper tools."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/vortigaunt_collar.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "Face"
ITEM.factionList = {FACTION_VORT}
ITEM.KeepOnDeath = true

ITEM.bodyGroups = {
    ["collar"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

if (CLIENT) then
	function ITEM:GetName()
		if LocalPlayer():GetCharacter() then
			if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP or LocalPlayer():GetCharacter():GetFaction() == FACTION_VORT then
				return self.name
			end
		end

		return string.sub( self.name, 1, string.len(self.name) - 7 )
	end
end

function ITEM:GetColorAppendix()
	return {
		["red"] = "Collar ID: " .. self:GetData("collarID", "UNKNOWN")
	}
end

function ITEM:OnInstanced()
	self:SetData("Locked", false)
end

function ITEM:OnEquip(client)
	local character = client:GetCharacter()

	if (character:GetFaction() != FACTION_VORT) then
		return
	end

	if (!self:GetData("collarOriginalOwnerCharacterID", nil) or self:GetData("collarID", nil) != character:GetCollarID() and self:GetData("collarOriginalOwnerCharacterID", nil)) then
		if (!self:GetData("collarID", nil)) then
			self:SetData("collarID", tostring(PLUGIN:GenerateCollarID(character.id)))
			self:SetData("collarOriginalOwnerCharacterID", character.id)
		elseif (character:GetData("CanResetFakeCollarDatafile") != false) then
			ix.plugin.list.combineutilities:CreateDatafile(client)

			character:SetCollarID(self:GetData("collarID"))
			character:SetCollarItemID(self:GetID())

			character:SetData("CanResetFakeCollarDatafile", false)

			client:Notify("Previous datafile information wiped, generating new data...")
		end
	end
end

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
		local client = self:GetOwner()
		local character = client:GetCharacter()

		if (character:GetFaction() != FACTION_VORT) then return end

		if (self:GetData("collarID", nil) and character:GetCollarID() != self:GetData("collarID") and character:GetData("CanResetFakeCollarDatafile") != false) then
			character:SetCollarID(self:GetData("collarID"))
			character:SetCollarItemID(self:GetID())
		end

		self:Unequip(self:GetOwner())
	end
end

function ITEM:CanEquipOutfit(client)
	local character = client:GetCharacter()

	if (client:Team() != FACTION_VORT) then
		client:NotifyLocalized("You are not whitelisted for the vortigaunt faction, so this is unuseable to you!")
		return false
	elseif (self:GetData("collarID", "N/A") != character:GetCollarID() and character:GetData("CanResetFakeCollarDatafile") == false) then
		client:Notify("You equip a different fake collar, but datafile information is not regenerated.")
	end

	return true
end

function ITEM:OnUnEquip(client)
end

ITEM:Hook("drop", function(item)
	local owner = item:GetOwner()

	if (item:GetData("equip")) then
		item:OnUnEquip(owner)
		item:RemoveOutfit(owner)
	end
end)