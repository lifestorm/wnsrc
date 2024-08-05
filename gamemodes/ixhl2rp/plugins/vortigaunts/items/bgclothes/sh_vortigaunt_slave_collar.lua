--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Vortigaunt Collar"
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

function ITEM:GetColorAppendix()
	return {
		["red"] = "Collar ID: " .. self:GetData("collarID", "UNKNOWN")
	}
end

function ITEM:OnInstanced()
	self:SetData("Locked", false)
end

function ITEM:OnEquip(client)
	local vortPlugin = ix.plugin.Get("vortigaunts")
	local character = client:GetCharacter()
	local genericdata = character:GetGenericdata()

	if character:GetFaction() != FACTION_VORT then return end

	if self:GetData("collarID") == nil then
		self:SetData("collarID", tostring(vortPlugin:GenerateCollarID(character.id)))
	end

	self:SetData("Locked", true)

	character:SetCollarID(self:GetData("collarID"))
	character:SetCollarItemID(self:GetID())

	if genericdata and genericdata.collarID == "N/A" then
		genericdata.collarID = character:GetCollarID()

		character:SetGenericdata(genericdata)
		character:Save()
	end

	if client:HasWeapon("ix_nightvision") then
		client:StripWeapon( "ix_nightvision" )
	end

	if client:HasWeapon("ix_vortbeam") then
		client:StripWeapon( "ix_vortbeam" )
	end

	if client:HasWeapon("ix_vortheal") then
		client:StripWeapon( "ix_vortheal" )
	end

	if client:HasWeapon("ix_vshield") then
		client:StripWeapon( "ix_vshield" )
	end

	if client:HasWeapon("ix_vmelee") then
		client:StripWeapon("ix_vmelee")
	end

	if client:HasWeapon("ix_vortpyro") then
		client:StripWeapon( "ix_vortpyro" )
	end

	if client:HasWeapon("ix_vortslam") then
		client:StripWeapon( "ix_vortslam" )
	end

	if client:HasWeapon("ix_vortadvancedbeam") then
		client:StripWeapon( "ix_vortadvancedbeam" )
	end

	client:Give("ix_vortsweep")

	if (character:GetBackground() != "Collaborator") then
		character:SetBackground("Biotic")
	end

	local worldmodel = ents.FindInSphere(client:GetPos(), 1);

	for _, v in pairs(worldmodel) do
		if (v:GetClass() == "ix_nvlight" and v:GetOwner() == client) then
			v:Remove()
		end
	end
end

function ITEM:OnLoadout()
	if (self:GetData("equip")) then
		local client = self.player
		local character = client:GetCharacter()
		character:SetCollarID(self:GetData("collarID"))
		character:SetCollarItemID(self:GetID())
	end
end

function ITEM:OnUnEquip(client)
	local character = client:GetCharacter()

	if character:GetFaction() != FACTION_VORT then return end

	self:SetData("Locked", false)

	character:SetCollarID(nil)
	character:SetCollarItemID(nil)

	if client:HasWeapon("ix_vortsweep") then
		client:StripWeapon( "ix_vortsweep" )

		if client.broomModel then
			client.broomModel:Remove()
		end
	end

	client:Give("ix_nightvision")
	client:Give("ix_vortbeam")
	client:Give("ix_vortheal")
	client:Give("ix_vshield")
	client:Give("ix_vortslam")

	if (character:GetBackground() != "Collaborator") then
		character:SetBackground("Liberated")
	end
end

function ITEM:CanEquipOutfit(client)
	local player = self.player or client
	local bgItems = player:GetCharacter():GetInventory():GetItemsByBase("base_bgclothes", true)
	for _, v in ipairs(bgItems) do
		if (v:GetData("equip") and v.maxArmor) then
			return false
		end
	end

	if !player:HasWhitelist(ix.faction.teams["vortigaunt"].index) then
		player:NotifyLocalized("You are not whitelisted for the vortigaunt faction, so this is unuseable to you!")
		return false
	end

	return true
end

ITEM:Hook("drop", function(item)
	if item:GetData("Locked") == true then
		item.player:NotifyLocalized("Your collar is locked so you cannot drop it!")
		return false
	end

	if (item:GetData("equip")) then
		item:OnUnEquip(item.player)
		item:RemoveOutfit(item:GetOwner())
	end
end)
