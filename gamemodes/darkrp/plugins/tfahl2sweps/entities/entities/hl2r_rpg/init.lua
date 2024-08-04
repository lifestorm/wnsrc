--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Damage = 100
ENT.Prime = 0.03
ENT.Delay = 30
ENT.HideDelay = 0.0
function ENT:Initialize()
	local mdl = self:GetModel()

	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/weapons/tfa_hl2r/w_missile_launch.mdl")
	end

	self:PhysicsInit(SOLID_VPHYSICS)
	--self:PhysicsInitSphere((self:OBBMaxs() - self:OBBMins()):Length() / 4, "metal")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

	self:SetFriction(self.Delay)
	self.killtime = CurTime() + self.Delay
	self:DrawShadow(true)
	self.StartTime = CurTime()
	self:EmitSound( "TFA_HL2R_RPG.Loop" )
	self:SetUseType(SIMPLE_USE)
	self.HasIdle = true
	timer.Simple(0.1, function()
		if IsValid(self) then
			self:SetOwner()
		end
	end)
	self:SetNWFloat("HideTime",CurTime() + self.HideDelay )
	self.HP = math.random(30, 60)
end

function ENT:Think()
	if self.killtime < CurTime() then
		return false
	end

	self:NextThink(CurTime())

	return true
end

local effectdata, shake

function ENT:Explode()
	if not IsValid(self.Owner) then
		self:Remove()

		return
	end
	
	effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale(5)
	effectdata:SetMagnitude(5)
	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)
	self.Damage = self.mydamage or self.Damage
	util.BlastDamage(self, self.Owner, self:GetPos(), 512, self.Damage )
	shake = ents.Create("env_shake")
	shake:SetOwner(self.Owner)
	shake:SetPos(self:GetPos())
	shake:SetKeyValue("amplitude", tostring(self.Damage * 20)) -- Power of the shake
	shake:SetKeyValue("radius", tostring( 768  ) ) -- Radius of the shake
	shake:SetKeyValue("duration", tostring( self.Damage / 200 )) -- Time of shake
	shake:SetKeyValue("frequency", "255") -- How har should the screenshake be
	shake:SetKeyValue("spawnflags", "4") -- Spawnflags(In Air)
	shake:Spawn()
	shake:Activate()
	shake:Fire("StartShake", "", 0)
	self:EmitSound("TFA_INS2_RPG7.2")
	self:Remove()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 and CurTime() > self.StartTime + self.Prime then
		timer.Simple(0,function()
			if IsValid(self) then
				self:Explode()
			end
		end)
	else
		self.Prime = math.huge
		if self.HasIdle then
			self:StopSound("TFA_HL2R_RPG.Loop")
			self.HasIdle = false
			self:SetNWFloat("HideTime", -1 )
		end
	end
	--[[elseif self:GetOwner() ~= self then
		self.Prime = math.huge
		self:StopSound("TFA_INS2_RPG7.Loop")
		self:SetOwner(self)
	end
	]]--
end

function ENT:OnRemove()
	if self.HasIdle then
		self:StopSound("TFA_HL2R_RPG.Loop")
		self.HasIdle = false
	end
end

function ENT:Use(activator, caller)
	if activator:IsPlayer() and self.WeaponClass and activator:GetWeapon(self.WeaponClass) then
		activator:GiveAmmo(1, activator:GetWeapon(self.WeaponClass):GetPrimaryAmmoType(), false)
		self:Remove()
	end
end

function ENT:OnTakeDamage( dmg )
	if dmg:GetInflictor() == self or dmg:GetAttacker() == self then return end
	if self.Exploded then return end
	if self.HP > 0 and self.HP - dmg:GetDamage() <= 0 then
		self.Exploded = true
		self:Explode()
	end
	self.HP = self.HP - dmg:GetDamage()
	dmg:SetAttacker(self)
	dmg:SetInflictor(self)
	self:TakePhysicsDamage( dmg )
end