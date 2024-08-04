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

util.AddNetworkString("TFA_CSGO_SONAR_EXPLODE")

local function EntityFacingFactor(ent1, ent2)
	local dir       = ent2:EyeAngles():Forward()
	local facingdir = (ent1:GetPos() - (ent2.EyePos and ent2:EyePos() or ent2:GetPos())):GetNormalized()
	return (facingdir:Dot(dir) + 1) / 2
end

local tr = {}

function ENT:Detonate()
	local origin = self:GetPos()

	if IsValid(self.Owner) then
		local _ents = ents.FindInSphere(origin, self.FindRadius)
		local tab   = {}

		for _, v in ipairs(_ents) do
			if v:IsNPC() or v:IsPlayer() and v ~= self.Owner then
				table.insert(tab, v)
			end
		end

		if #tab <= 0 then return end

		net.Start("TFA_CSGO_SONAR_EXPLODE", true)
		net.WriteInt(#tab, 14)
		for i = 1, #tab do
			net.WriteEntity(tab[i])
		end
		net.Send(self.Owner)
	end

	tr.start = origin
	tr.mask  = MASK_SOLID

	for k, v in ipairs(player.GetAll()) do
		tr.endpos = v:EyePos()
		tr.filter = { self, v, v:GetActiveWeapon() }

		local trace = util.TraceLine(tr)
		if not trace.Hit or trace.Fraction >= 1 or trace.Fraction <= 0 then
			v:SetNWFloat("TFACSGO_LastFlash", CurTime() - 4)
			v:SetNWFloat("TFACSGO_FlashDistance", tr.endpos:Distance(origin))
			v:SetNWFloat("TFACSGO_FlashFactor", EntityFacingFactor(self, v) * 0.5)
		end
	end

	self:EmitSound("TFA_CSGO_Sensor.Detonate")

	local explode = ents.Create( "info_particle_system" )
	explode:SetKeyValue( "effect_name", "weapon_sensorgren_detonate" )
	explode:SetOwner( self.Owner )
	explode:SetPos( self:GetPos() )
	explode:Spawn()
	explode:Activate()
	explode:Fire( "start", "", 0 )
	explode:Fire( "kill", "", 30 )

	SafeRemoveEntity(self)
end

function ENT:Fuse(ent)
	if SERVER then
		self.WeldEnt = constraint.Weld(self, ent, 0, 0, 0, true, false)

		self:EmitSound("TFA_CSGO_Sensor.Activate")
		timer.Simple(3, function()
			if IsValid(self) then
				self:StopParticles()
				self:Detonate()
			end
		end)
	end
end

function ENT:PhysicsCollide(data, physObj)
	if not self:GetNWBool("Fused") then
		if data.HitEntity then
			if not (data.HitEntity:IsNPC() or data.HitEntity:IsPlayer()) then
				self:SetNWBool("Fused", true)

				timer.Simple(0, function()
					if IsValid(self) then
						self:EmitSound("TFA_CSGO_Sensor.Land")
						self:Fuse(data.HitEntity)
					end
				end)
			end
		end
	end
	orient_angles(physObj,data)
end

function ENT:OnRemove()
	if (timer.Exists("GrenadesCleanup"..self:EntIndex())) then
		timer.Remove("GrenadesCleanup"..self:EntIndex())
	end
end

function orient_angles(obj, data) --this function juts takes in the hitnormal of the collision and rotates the angles accordingly
	if data.HitNormal.z < -.5 then
		obj:SetAngles((data.HitNormal + Vector(0,90,0) ):Angle())
		return
	end
	if data.HitNormal.z > .5 then
		obj:SetAngles((data.HitNormal + Vector(-90,0,0) ):Angle())
		return
	end
	if data.HitNormal.y < -.5 then
		obj:SetAngles((data.HitNormal + Vector(0,0,90) ):Angle())
		return
	end
	if data.HitNormal.y > .5 then
		obj:SetAngles((data.HitNormal + Vector(0,0,90) ):Angle())
		return
	end
	if data.HitNormal.x < -.5 then
		obj:SetAngles((data.HitNormal + Vector(0,0,90) ):Angle())
		return
	end
	if data.HitNormal.x > .5 then
		obj:SetAngles((data.HitNormal + Vector(0,0,90) ):Angle())
		return
	end
end
