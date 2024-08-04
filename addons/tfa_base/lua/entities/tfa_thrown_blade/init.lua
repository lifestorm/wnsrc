--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	local mdl = self:GetModel()

	if not mdl or mdl == "" or string.find(mdl, "error") then
		self:SetModel("models/weapons/w_knife_t.mdl")
	end

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	self:NextThink(CurTime() + 1)

	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(10)
	end

	for _, v in pairs(self.HitSounds) do
		for _, o in pairs(v) do
			util.PrecacheSound(o)
		end
	end

	local bounds = self:OBBMaxs() - self:OBBMins()

	if bounds.z > bounds.x and bounds.z > bounds.y then
		self.up = true
	elseif bounds.y > bounds.x and bounds.y > bounds.z then
		self.right = true
	end

	self:SetUseType(SIMPLE_USE)

	self.mydamage = self.mydamage or 40

	self.DestroyTime = CurTime() + 30
end

function ENT:Think()
	if CurTime() > self.DestroyTime then
		self:Remove()
	end
end

function ENT:Stick()
	self.DestroyTime = CurTime() + 60
	timer.Simple(0,function()
		if IsValid(self) then
			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			self:GetPhysicsObject():EnableMotion(false)
		end
	end)
end

function ENT:PhysicsCollide(data, phys)
	timer.Simple(0,function()
		if not IsValid(self) then return end
		local owner = self:GetOwner()
		self:SetOwner(nil)
		local fwdang = self:GetAngles()
		local fwdvec

		if self.up then
			fwdvec = fwdang:Up()
		elseif self.right then
			fwdvec = fwdang:Right()
		else
			fwdvec = fwdang:Forward()
		end

		local ent = data.HitEntity
		if not IsValid(ent) and not (ent and ent:IsWorld()) then return end
		local dmg = self.mydamage * math.sqrt(data.Speed / 1500)

		if dmg > 5 and ent and not ent:IsWorld() then
			local dmginfo = DamageInfo()
			dmginfo:SetDamage(dmg)
			dmginfo:SetDamagePosition(data.HitPos)
			dmginfo:SetDamageForce(data.OurOldVelocity)
			dmginfo:SetInflictor(self)
			dmginfo:SetDamageType(DMG_SLASH)
			local att = self:GetPhysicsAttacker()

			if not IsValid(att) then
				att = owner
			end

			if not IsValid(att) then
				att = self
			end

			dmginfo:SetAttacker(att)
			ent:TakeDamageInfo(dmginfo)
		end

		local traceres = util.QuickTrace(self:GetPos(), data.OurOldVelocity, self)
		if not traceres.HitPos then return end

		if data.Speed > 50 then
			local soundtbl

			if self.HitSounds[traceres.MatType] then
				soundtbl = self.HitSounds[traceres.MatType]
			else
				soundtbl = self.HitSounds[MAT_DIRT]
			end

			local snd = soundtbl[math.random(1, #soundtbl)]
			self:EmitSound(snd)
		end

		local dp = traceres.HitNormal:Dot(fwdvec)

		if dp >= -0.3 then
			local fx = EffectData()
			fx:SetOrigin(data.HitPos)
			fx:SetMagnitude(1)
			fx:SetScale((data.Speed / 1500 * (dp + 0.6)) / 5)
			util.Effect("Sparks", fx)
		end

		local canstick = data.Speed > 250 and dp < (-1 + data.Speed / 1000 * 0.3)

		if ent:IsWorld() and canstick then
			util.Decal("ManhackCut", traceres.HitPos + traceres.HitNormal, traceres.HitPos - traceres.HitNormal)
			self:EmitSound(self.ImpactSound)
			self:SetPos(traceres.HitPos + traceres.HitNormal * 12)
			local tmpang = data.HitNormal:Angle()
			tmpang:RotateAroundAxis(tmpang:Right(), 270)
			--self:SetAngles(tmpang)
			local fx = EffectData()
			fx:SetOrigin(data.HitPos)
			fx:SetMagnitude(2)
			fx:SetScale(0.1)
			util.Effect("Sparks", fx)
			self:Stick()
		elseif IsValid(ent) then
			if not (ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll") then
				if canstick then
					util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
				end

				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			else
				local fx = EffectData()
				fx:SetOrigin(data.HitPos)
				util.Effect("BloodImpact", fx)
				self:GetPhysicsObject():SetVelocity(-(data.OurOldVelocity / 8))
			end
			if IsValid(self) then
				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end
		end

		if canstick then
			self:GetPhysicsObject():SetVelocity(-(data.OurOldVelocity / 16))
		end

		self:GetPhysicsObject():AddAngleVelocity(-self:GetPhysicsObject():GetAngleVelocity() / 3)
	end)
end

function ENT:Use(ply, caller)
	local classname = self:GetNW2String("ClassName")
	if not classname or classname == "" then return end

	if ply:IsPlayer() and ply:GetWeapon(classname) == NULL then
		ply:Give(classname)
		self:Remove()
	end
end