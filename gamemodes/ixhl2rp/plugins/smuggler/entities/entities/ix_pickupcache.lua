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

AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.PrintName = "Pickup Cache"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.bNoPersist = true
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DisplayName")
	self:NetworkVar("String", 1, "LocationId")
end

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/items/item_item_crate.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		self.uniqueID = ""
	end

	function ENT:Use(activator, caller)
		if (self.uniqueID == "") then return end

		if (IsValid(caller) and caller:IsPlayer() and caller:GetCharacter()) then
			local pickupItems = caller:GetCharacter():GetSmugglingPickupItems()

			if (pickupItems["__invalid_cache"]) then
				pickupItems[self.uniqueID] = pickupItems[self.uniqueID] or {}
				for k, v in pairs(pickupItems["__invalid_cache"]) do
					pickupItems[self.uniqueID][k] = (pickupItems[self.uniqueID][k] or 0) + v
				end
				pickupItems["__invalid_cache"] = nil

				caller:GetCharacter().vars.smugglingPickupItems = pickupItems
			end

			if (pickupItems[self.uniqueID]) then
				caller.ixPickupCache = self
				netstream.Start(caller, "ixSmugglingPickupItems", pickupItems[self.uniqueID])
			else
				caller:NotifyLocalized("smugglerNoPickupItems")
			end
		end
	end

	function ENT:SetNewModel(model)
		self:SetModel(model)
		self:PhysicsInit(SOLID_BBOX)
		self:SetSolid(SOLID_BBOX)
	end

	function ENT:UpdateUniqueID(uniqueID)
		uniqueID = string.gsub(string.Trim(string.utf8lower(uniqueID)), "%s", "_")

		if (uniqueID == self.uniqueID) then return end

		local oldID = self.uniqueID
		self.uniqueID = uniqueID

		PLUGIN:UpdateCacheID(self, uniqueID, oldID)
	end
else
	function ENT:Draw()
		self:DrawModel()
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText(self:GetDisplayName())
		name:SizeToContents()
	end
end
