--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "entity_tank_rocket"
ENT.Spawnable = false
ENT.AdminOnly = false

if(SERVER) then
	function ENT:Initialize()
		self.Target = nil
		self.Owner = nil
		self.TargetDir = nil
		self.GraceTime = 0.3
		self.GraceTimer = 0
		self.OldAng = self:GetAngles()
		self.NewAng = self:GetAngles()
		self.Snd = CreateSound(self, "weapons/rpg/rocket1.wav")
		self.Snd:Play()

		self.Offset = Vector(0, 0, 0)

		self:SetModel("models/weapons/w_missile_closed.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)	

		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end

		self.Trail = ents.Create("env_rockettrail")
		self.Trail:SetPos(self:GetPos())
		self.Trail:SetAngles(self:GetAngles())
		self.Trail:SetParent(self)
		self.Trail:Spawn()
	end

	function ENT:Think()
		if(self.TargetAng == nil && !IsValid(self.Target)) then self:Remove() return false end

		local ang

		if(IsValid(self.Target)) then
			ang = ( (self.Target:GetPos() + self.Offset) - self:GetPos()):Angle()
		else
			ang = self.TargetAng
		end

		if(self.GraceTimer < CurTime()) then
			self.OldAng = self.NewAng
			self.NewAng = ang

			self.GraceTimer = CurTime() + self.GraceTime
		end

		self.NewAng = self.NewAng + AngleRand() * 0.01

		self:GetPhysicsObject():SetVelocity(self:GetForward() * 1500)
		self:SetAngles(LerpAngle((self.GraceTimer - CurTime()) / self.GraceTime, self.NewAng, self.OldAng))

		self:NextThink(CurTime() + 0.05)

		return true
	end

	function ENT:PhysicsCollide(data, collider)
		if(data.HitNormal:Dot(self:GetForward()) > 0.2 && data.HitEntity:GetClass() != self:GetClass()) then
			if(data.HitEntity != self.Owner) then
				self:Explode(data.HitNormal)
			end
		end
	end

	function ENT:Explode(hitnormal)
		local ent = ents.Create("env_explosion")
		ent:SetPos(self:GetPos())
		ent:SetKeyValue("iMagnitude", 70)
		ent:Spawn()
		ent:SetOwner(self.Owner)
		ent:Fire("Explode", "", 0)

		/*for i = 1, math.random(1, 1) do
			local gib = ents.Create("prop_physics")
			gib:SetModel("models/gibs/metal_gib" .. math.random(1, 5) .. ".mdl")
			gib:SetPos(self:GetPos() + hitnormal * 100 + VectorRand())
			gib:Spawn()
			gib:GetPhysicsObject():ApplyForceCenter(VectorRand() * 0.1)
			//gib:SetLocalAngularVelocity(AngleRand())
			gib:Ignite(1, 2)
			gib:Fire("Kill", "", 5)
		end*/

		self:Remove()
	end

	function ENT:OnRemove()
		self.Snd:Stop()
	end
end