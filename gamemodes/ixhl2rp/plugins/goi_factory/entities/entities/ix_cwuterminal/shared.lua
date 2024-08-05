--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ENT.Type = "anim"
ENT.PrintName = "CWU Terminal"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "UsedBy")
	self:NetworkVar("Int", 1, "CID")
	self:NetworkVar("Int", 2, "CWUCard")
end

function ENT:CIDInsert(entity)
	entity:SetPos(self:LocalToWorld(self.localizedCIDTransform.vec))
	entity:SetAngles(self:LocalToWorldAngles(self.localizedCIDTransform.ang))
	entity:SetParent(self)

	self.attachedCID = entity
	entity.attached = self

	self:SetCID(entity.ixItemID)
	self:OnCIDInsert()
end

function ENT:CWUInsert(entity)
	entity:SetPos(self:LocalToWorld(self.localizedCWUCardTransform.vec))
	entity:SetAngles(self:LocalToWorldAngles(self.localizedCWUCardTransform.ang))
	entity:SetParent(self)

	self.attachedCWUCard = entity
	entity.attached = self

	self:SetCWUCard(entity.ixItemID)
	self:OnCWUCardInsert()
end