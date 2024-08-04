--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type      = "anim"
ENT.Spawnable = false

ENT.FindRadius = 250

ENT.Model = "models/weapons/tfa_csgo/w_eq_sensorgrenade_thrown.mdl"

function ENT:Initialize()
	if SERVER then
		self:SetModel(self.Model)

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:DrawShadow( false )

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
		end
	end

	self:EmitSound("TFA_CSGO_HEGrenade.Throw")
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end
