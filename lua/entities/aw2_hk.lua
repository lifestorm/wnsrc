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

ENT.Type 					= "anim"
ENT.Base 					= "base_gmodentity"

ENT.PrintName				= "Hunter Killer"
ENT.Category 				= "Airwatch 2"

ENT.Spawnable				= true
ENT.AdminOnly 				= true

ENT.AutomaticFrameAdvance 	= true

ENT.firstPersonOffset 		= Vector(155, 0, -65)
ENT.thirdPersonOffset		= Vector(-600, 0, 0)

ENT.pitchMultiplier 		= 1
ENT.rollMultiplier 			= 1.5

ENT.cannonMuzzle 			= 4
ENT.cannonPitch 			= 5
ENT.cannonYaw 				= 4

ENT.turretMuzzle1 			= 5
ENT.turretMuzzle2 			= 6
ENT.turretPitch 			= 7
ENT.turretYaw 				= 6

ENT.spotlightAttach1 		= 7
ENT.spotlightAttach2 		= 8
ENT.lightPitch 				= 9
ENT.lightYaw				= 8

ENT.pitchIndex 				= 5
ENT.yawIndex 				= 4

ENT.accuracy 				= 1
ENT.damage 					= 20
ENT.delay 					= 0.12

ENT.cannonDelay 			= 1.5

util.PrecacheSound("NPC_AttackHelicopter.Rotors")
util.PrecacheSound("NPC_AttackHelicopter.BadlyDamagedAlert")
util.PrecacheSound("NPC_AttackHelicopter.MegabombAlert")
util.PrecacheSound("NPC_AttackHelicopter.Crash")
util.PrecacheSound("NPC_Strider.Shoot")
util.PrecacheSound("hk/plasma.wav")

function ENT:SpawnFunction(ply, tr, className)
	if not tr.Hit then
		return
	end

	local spawnPos = tr.HitPos + tr.HitNormal * 120

	local ent = ents.Create(className)
	ent:Spawn()
	ent:Activate()

	ent:SetPos(spawnPos)

	ent.Owner = ply

	return ent
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "GunOperator")

	self:NetworkVar("Int", 0, "SpeedMult")
end

function ENT:Think()
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end

	if SERVER then
		self:aimCannon()
		self:aimTurrets()
		self:aimLights()
		self:weaponThink()

		local ply = self.driver

		if ply and ply:IsValid() or self.healthStatus == AW2_CRASHING or (GetConVar("aw2_alwayson"):GetBool() and self.healthStatus ~= AW2_DEAD) then
			if not self.isActive then
				self:enableEffects()
				self.isActive = true
			end
		else
			if self.isActive then
				self:disableEffects()
				self.isActive = false
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:hasLOS(origin)
	local ply = self:GetGunOperator()

	if ply and ply:IsValid() then
		local barrel

		if not origin then
			barrel = self:GetAttachment(self.turretMuzzle1)
		else
			barrel = self:GetAttachment(origin)
		end

		local hitpos = self:getHitpos(ply)
		local dot = barrel.Ang:Forward():Dot((hitpos - barrel.Pos):GetNormalized())

		if dot >= 0.95 then
			return true
		end
	end

	return false
end

function ENT:getViewData(ply)
	if not ply:IsValid() then
		return
	end

	local eyeAng = ply:EyeAngles()

	-- Hours wasted on trying to find what the issue was: 4.5
	-- Hours wasted on trying to fix the issue before finding out the fix was the issue: Too many
	if SERVER then
		eyeAng = self:WorldToLocalAngles(eyeAng) -- Note to self: NEVER subtract angles when you can WorldToLocal/LocalToWorld
	end

	local thirdperson = ply:GetVehicle():GetThirdPersonMode()

	local pos, ang

	if thirdperson then
		local trace = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() + eyeAng:Up() * self.thirdPersonOffset.z + eyeAng:Forward() * self.thirdPersonOffset.x,
			filter = {self},
			mask = MASK_SOLID_BRUSHONLY
		})

		pos = trace.HitPos + trace.HitNormal * 5
		ang = eyeAng
	else
		local entAng = self:GetAngles()

		entAng.p = 0
		entAng.r = 0

		local offset = self.firstPersonOffset

		if self.useGunner and self:GetGunOperator() == ply then
			offset = self.gunnerOffset
		end

		pos = self:LocalToWorld(offset)
		ang = eyeAng
	end

	return pos, ang
end

function ENT:getHitpos(ply)
	local pos, ang = self:getViewData(ply)

	return util.QuickTrace(pos, ang:Forward() * 10000, {self}).HitPos
end

function ENT:CanPhysgun(ply)
	if ply and ply:IsValid() then
		return ply:IsAdmin()
	end

	return false
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/inaki/props_vehicles/terminator_aerialhk.mdl")
		self:SetBodyGroups("1")
		self:ResetSequence("idle")

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		local phys = self:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMass(500000)
		end

		self.seatDriver = ents.Create("prop_vehicle_prisoner_pod")
		self.seatDriver:SetModel("models/props_lab/cactus.mdl")
		self.seatDriver:SetPos(self:GetPos())
		self.seatDriver:SetAngles(self:GetAngles())
		self.seatDriver:SetSolid(SOLID_NONE)
		self.seatDriver:SetKeyValue("limitview", 0, 0)
		self.seatDriver:SetNoDraw(true)
		self.seatDriver:Spawn()
		self.seatDriver:SetParent(self)
		self.seatDriver:SetNotSolid(true)

		self:DeleteOnRemove(self.seatDriver)

		self.seatDriver.aw2Ent = self

		if self.useGunner then
			self.seatGunner = ents.Create("prop_vehicle_prisoner_pod")
			self.seatGunner:SetModel("models/props_lab/cactus.mdl")
			self.seatGunner:SetPos(self:GetPos())
			self.seatGunner:SetAngles(self:GetAngles())
			self.seatGunner:SetSolid(SOLID_NONE)
			self.seatGunner:SetKeyValue("limitview", 0, 0)
			self.seatGunner:SetNoDraw(true)
			self.seatGunner:Spawn()
			self.seatGunner:SetParent(self)
			self.seatGunner:SetNotSolid(true)

			self:DeleteOnRemove(self.seatGunner)

			self.seatGunner.aw2Ent = self
		end

		self:initLights()

		self:StartMotionController()

		self:SetSubMaterial(1, "phoenix_storms/glass")
		self:SetPlaybackRate(0)

		self:SetMaxHealth(GetConVar("aw2_hk_health"):GetInt())
		self:SetHealth(self:GetMaxHealth())

		self.healthStatus = AW2_HEALTHY
		self.lastPercentage = 100

		self.driver, self.gunner = nil

		self.storedPos = Vector(0, 0, 0)
		self.storedVel = Vector(0, 0, 0)
		self.storedLocalVel = Vector(0, 0, 0)

		self.storedPitch = 0
		self.storedYaw = 0

		self.isActive = false

		self.bulletSide = false

		self.spotlightActive = false

		self.nextShot = 0
		self.nextCannon = 0

		self.passengers = {}

		self:SetSpeedMult(GetConVar("aw2_hk_speedmult"):GetInt())
	end

	function ENT:Use(ply)
		if self.healthStatus ~= AW2_HEALTHY then
			return
		end

		if not self.driver then
			ply:EnterVehicle(self.seatDriver)
			ply:SetNoDraw(true)

			self.driver = ply

			if not self.useGunner then
				self:SetGunOperator(ply)
			end

			ply.aw2Ent = self

			net.Start("aw2Enter")
				net.WriteEntity(self)
			net.Send(ply)
		elseif self.useGunner and not self.gunner then
			ply:EnterVehicle(self.seatGunner)
			ply:SetNoDraw(true)

			self.gunner = ply
			self:SetGunOperator(ply)

			ply.aw2Ent = self

			net.Start("aw2Enter")
				net.WriteEntity(self)
			net.Send(ply)
		else
			local seat = ents.Create("prop_vehicle_prisoner_pod")
			seat:SetModel("models/props_lab/cactus.mdl")
			seat:SetPos(self:GetPos())
			seat:SetAngles(self:GetAngles())
			seat:SetSolid(SOLID_NONE)
			seat:SetKeyValue("limitview", 0, 0)
			seat:SetNoDraw(true)
			seat:Spawn()
			seat:SetParent(self)
			seat:SetNotSolid(true)

			self:DeleteOnRemove(seat)

			seat.aw2Ent = self

			table.insert(self.passengers, seat)

			ply:EnterVehicle(seat)
			ply:SetNoDraw(true)

			ply.aw2Ent = self

			net.Start("aw2Enter")
				net.WriteEntity(self)
			net.Send(ply)
		end
	end

	function ENT:OnRemove()
		self:StopSound("NPC_AttackHelicopter.Rotors")
		self:StopSound("NPC_AttackHelicopter.Crash")
		self:StopSound("NPC_CombineDropship.FireLoop")

		self.spotlight1:SetParent()
		self.spotlight1:Fire("lightoff")
		self.spotlight1:Fire("kill",self.spotlight1, 0.5)

		self.spotlight2:SetParent()
		self.spotlight2:Fire("lightoff")
		self.spotlight2:Fire("kill",self.spotlight2, 0.5)
	end

	function ENT:enableEffects()
		self:SetPlaybackRate(1)

		self.wash = ents.Create("env_rotorwash_emitter")
		self.wash:SetPos(self:GetPos())
		self.wash:SetAngles(self:GetAngles())
		self.wash:SetParent(self)
		self.wash:Spawn()

		self:EmitSound("NPC_AttackHelicopter.Rotors")
	end

	function ENT:disableEffects()
		self:SetPlaybackRate(0)

		if self.wash and self.wash:IsValid() then
			self.wash:Remove()
		end

		self:StopSound("NPC_AttackHelicopter.Rotors")
	end

	function ENT:initLights()
		local spotlight1 = ents.Create("point_spotlight")

		spotlight1:SetPos(self:GetAttachment(self.spotlightAttach1).Pos)
		spotlight1:SetKeyValue("spotlightlength", "500")
		spotlight1:SetKeyValue("spotlightwidth", "45")
		spotlight1:SetKeyValue("spawnflags", 3)
		spotlight1:SetParent(self)
		spotlight1:Spawn()
		spotlight1:Activate()

		self.spotlight1 = spotlight1

		local spotlight2 = ents.Create("point_spotlight")

		spotlight2:SetPos(self:GetAttachment(self.spotlightAttach2).Pos)
		spotlight2:SetKeyValue("spotlightlength", "500")
		spotlight2:SetKeyValue("spotlightwidth", "45")
		spotlight2:SetKeyValue("spawnflags", 3)
		spotlight2:SetParent(self)
		spotlight2:Spawn()
		spotlight2:Activate()

		self.spotlight2 = spotlight2

		spotlight1:Fire("lightoff")
		spotlight2:Fire("lightoff")
	end

	function ENT:createBomb(vel)
		local bomb = ents.Create("grenade_helicopter")
		bomb:SetPos(self:GetAttachment(self.bombAttach).Pos)
		bomb:SetOwner(self)
		bomb:Spawn()

		bomb:GetPhysicsObject():SetVelocity(vel)
		bomb:GetPhysicsObject():SetBuoyancyRatio(1)

		return bomb
	end

	function ENT:weaponThink()
		if self.healthStatus ~= AW2_HEALTHY then
			return
		end

		local ply = self:GetGunOperator()

		if not IsValid(ply) then
			return
		end

		local fire = ply:KeyDown(IN_ATTACK) and not ply:KeyDown(IN_RELOAD)

		if fire and self:hasLOS() and self.nextShot <= CurTime() then
			self.nextShot = CurTime() + self.delay

			local attach = self.bulletSide and self.turretMuzzle1 or self.turretMuzzle2

			self.bulletSide = not self.bulletSide

			local spread = math.sin(self.accuracy * 0.5 * (math.pi / 180))
			local pos = self:GetAttachment(attach).Pos
			local bullet = {}

			bullet.Num = 1
			bullet.Src = pos
			bullet.Dir = (self:getHitpos(ply) - pos):Angle():Forward()
			bullet.Spread = Vector(spread, spread, 0)
			bullet.Tracer = 0
			bullet.Force = 20
			bullet.Damage = self.damage
			bullet.Attacker = ply
			bullet.Callback = function(attacker, trace, dmginfo)
				if not trace.HitPos or not trace.HitNormal then
					return
				end

				dmginfo:SetDamageType(DMG_AIRBOAT)

				local e = EffectData()
				e:SetOrigin(trace.HitPos)
				e:SetEntity(self)
				e:SetAttachment(attach)
				e:SetNormal(trace.HitNormal)
				e:SetScale(32)
				util.Effect("hk_laser", e)
			end

			self:FireBullets(bullet)

			self:EmitSound("hk/plasma.wav", 140)
		end

		local altFire = ply:KeyDown(IN_ATTACK2) and not ply:KeyDown(IN_RELOAD)

		if altFire and self.nextCannon <= CurTime() and self:hasLOS(self.cannonMuzzle) then
			self.nextCannon = CurTime() + self.cannonDelay

			local pos = self:GetAttachment(self.cannonMuzzle).Pos

			local bullet = {}
			bullet.Num = 1
			bullet.Src = pos
			bullet.Dir = (self:getHitpos(ply) - pos):GetNormalized():Angle():Forward()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force = 20
			bullet.Damage = 1000
			bullet.Attacker = ply
			bullet.Callback = function(attacker, trace, dmginfo)
				if not trace.HitPos or not trace.HitNormal then
					return
				end

				util.ParticleTracerEx("Weapon_Combine_Ion_Cannon", pos, trace.HitPos, true, self:EntIndex(), self.cannonMuzzle)

				local explosion = ents.Create("env_explosion")
				explosion:SetPos(trace.HitPos)
				explosion:SetKeyValue("iMagnitude", 120)
				explosion:Spawn()
				explosion:Activate()
				explosion:Fire("explode")
			end

			self:FireBullets(bullet)

			self:EmitSound("NPC_Strider.Shoot")
		end
	end

	function ENT:keyPress(ply, key)
		if ply:KeyDown(IN_RELOAD) and key == IN_ATTACK then
			if ply == self:GetGunOperator() then
				if self.spotlightActive then
					self.spotlight1:Fire("lightoff")
					self.spotlight2:Fire("lightoff")
					self.spotlightActive = false
				else
					self.spotlight1:Fire("lighton")
					self.spotlight2:Fire("lighton")
					self.spotlightActive = true
				end
			end

			ply:EmitSound("buttons/lightswitch2.wav")
		end
	end

	function ENT:aimTurrets()
		local ply = self:GetGunOperator()

		local pitch = 0
		local yaw = 0

		if IsValid(ply) and self.healthStatus == AW2_HEALTHY then
			local rad2deg = 180 / math.pi

			local turretMiddle = self:LocalToWorld(self:WorldToLocal(self:GetAttachment(self.turretMuzzle1).Pos) - self:WorldToLocal(self:GetAttachment(self.turretMuzzle2).Pos))

			local pos, _ = WorldToLocal(self:getHitpos(ply), self:GetAngles(), turretMiddle, self:GetAngles())
			local len = pos:Length()

			if len < 0.0000001000000 then
				pitch = 0
			else
				pitch = rad2deg * math.asin(pos.z / len)
			end

			yaw = rad2deg * math.atan2(pos.y, pos.x)
		end

		local pitchMin, pitchMax = self:GetPoseParameterRange(self.turretPitch)
		local yawMin, yawMax = self:GetPoseParameterRange(self.turretYaw)

		pitch = math.Clamp(pitch, pitchMin, pitchMax)
		yaw = math.Clamp(yaw, yawMin, yawMax)

		self:SetPoseParameter(self:GetPoseParameterName(self.turretPitch), -pitch)
		self:SetPoseParameter(self:GetPoseParameterName(self.turretYaw), -yaw)
	end

	function ENT:aimCannon()
		local ply = self:GetGunOperator()

		local pitch = 0
		local yaw = 0

		if IsValid(ply) and self.healthStatus == AW2_HEALTHY then
			local rad2deg = 180 / math.pi

			local pos, _ = WorldToLocal(self:getHitpos(ply), self:GetAngles(), self:GetAttachment(self.cannonMuzzle).Pos, self:GetAngles())
			local len = pos:Length()

			if len < 0.0000001000000 then
				pitch = 0
			else
				pitch = rad2deg * math.asin(pos.z / len)
			end

			yaw = rad2deg * math.atan2(pos.y, pos.x)
		end

		local pitchMin, pitchMax = self:GetPoseParameterRange(self.cannonPitch)
		local yawMin, yawMax = self:GetPoseParameterRange(self.cannonYaw)

		pitch = math.Clamp(pitch, pitchMin, pitchMax)
		yaw = math.Clamp(yaw, yawMin, yawMax)

		self:SetPoseParameter(self:GetPoseParameterName(self.cannonPitch), pitch)
		self:SetPoseParameter(self:GetPoseParameterName(self.cannonYaw), -yaw)
	end

	function ENT:aimLights()
		local ply = self:GetGunOperator()

		local pitch = 0
		local yaw = 0

		if IsValid(ply) and self.healthStatus == AW2_HEALTHY then
			local rad2deg = 180 / math.pi

			local lightMiddle = self:LocalToWorld(self:WorldToLocal(self:GetAttachment(self.spotlightAttach1).Pos) - self:WorldToLocal(self:GetAttachment(self.spotlightAttach2).Pos))

			local pos, _ = WorldToLocal(self:getHitpos(ply), self:GetAngles(), lightMiddle, self:GetAngles())
			local len = pos:Length()

			if len < 0.0000001000000 then
				pitch = 0
			else
				pitch = rad2deg * math.asin(pos.z / len)
			end

			yaw = rad2deg * math.atan2(pos.y, pos.x)
		end

		local pitchMin, pitchMax = self:GetPoseParameterRange(self.lightPitch)
		local yawMin, yawMax = self:GetPoseParameterRange(self.lightYaw)

		pitch = math.Clamp(pitch + 90, pitchMin, pitchMax + 35)

		yaw = math.Clamp(yaw, yawMin, yawMax)

		self:SetPoseParameter(self:GetPoseParameterName(self.lightPitch), -pitch)
		self:SetPoseParameter(self:GetPoseParameterName(self.lightYaw), -yaw)

		self.spotlight1:SetAngles(self:GetAngles() + Angle(-pitch + 90, yaw, 0))
		self.spotlight2:SetAngles(self:GetAngles() + Angle(-pitch + 90, yaw, 0))
	end

	function ENT:ejectPlayer(ply, vehicle)
		ply:SetNoDraw(false)

		ply.aw2Ent = nil

		net.Start("aw2Eject")
		net.Send(ply)

		if self.driver == ply then
			self.driver = nil

			if not self.useGunner then
				self:SetGunOperator(nil)
			end
		elseif self.gunner == ply then
			self.gunner = nil

			self:SetGunOperator(nil)
		else
			for k, v in pairs(self.passengers) do
				if v == vehicle then
					table.remove(self.passengers, k)
					vehicle:Remove()

					break
				end
			end
		end

		ply:SetVelocity(self:GetVelocity())
	end

	function ENT:OnTakeDamage(dmgInfo)
		local ply = self.driver

		if not ply or not ply:IsValid() then
			return
		end

		if self.healthStatus ~= AW2_HEALTHY then
			return
		end

		if GetConVar("aw2_hk_rocketonly"):GetBool() and not dmgInfo:IsDamageType(DMG_BLAST) and not dmgInfo:IsDamageType(DMG_AIRBOAT) then
			return
		end

		local health = self:Health()

		if health <= 0 then
			return
		end

		self:SetHealth(health - dmgInfo:GetDamage())

		health = self:Health()

		local percentage = (health / self:GetMaxHealth()) * 100
		local addSmoke = false
		local attachPoint = 0
		local doSound = ""

		if percentage <= 75 and self.lastPercentage > 75 then
			addSmoke = true
			attachPoint = 11
			doSound = "NPC_AttackHelicopter.BadlyDamagedAlert"
		elseif percentage <= 50 and self.lastPercentage > 50 then
			addSmoke = true
			attachPoint = 12
			doSound = "NPC_AttackHelicopter.BadlyDamagedAlert"
		elseif percentage <= 25 and self.lastPercentage > 25 then
			addSmoke = true
			attachPoint = 13
			doSound = "NPC_AttackHelicopter.BadlyDamagedAlert"
		elseif percentage <= 15 and self.lastPercentage > 15 then
			addSmoke = true
			attachPoint = 14
			doSound = "NPC_AttackHelicopter.MegabombAlert"
		end

		if health <= 0 then
			addSmoke = true
			attachPoint = 15

			self.healthStatus = AW2_CRASHING
			self:EmitSound("NPC_AttackHelicopter.CrashingAlarm1")
			self:StopSound("NPC_CombineDropship.FireLoop")
		end

		if addSmoke then
			local explosion = ents.Create("env_explosion")
				explosion:SetPos(self:GetAttachment(attachPoint).Pos)
				explosion:SetKeyValue("iMagnitude", 100)
				explosion:SetKeyValue("iRadiusOverride", 128)
				explosion:SetKeyValue("spawnflags", 1)
				explosion:SetParent(self)
				explosion:Spawn()
				explosion:Activate()
			explosion:Fire("explode")

			local smoke = ents.Create("env_smoketrail")
				smoke:SetPos(self:GetAttachment(attachPoint).Pos)
				smoke:SetKeyValue("opacity", 0.2)
				smoke:SetKeyValue("spawnrate", 48)
				smoke:SetKeyValue("lifetime", 0.5)
				smoke:SetKeyValue("minspeed", 16)
				smoke:SetKeyValue("maxspeed", 64)
				smoke:SetKeyValue("startcolor", "0.15 0.15 0.15")
				smoke:SetKeyValue("endcolor", "0 0 0")
				smoke:SetKeyValue("startsize", 16)
				smoke:SetKeyValue("endsize", 64)
				smoke:SetKeyValue("spawnradius", 8)
				smoke:SetParent(self)
				smoke:Spawn()
			smoke:Activate()

			local fire = ents.Create("env_fire_trail")
				fire:SetPos(self:GetAttachment(attachPoint).Pos)
				fire:SetParent(self)
				fire:Spawn()
			fire:Activate()

			self:EmitSound(doSound)
		end

		self.lastPercentage = percentage
	end

	function ENT:PhysicsCollide(colData, phys)
		if self.healthStatus == AW2_CRASHING then
			self.healthStatus = AW2_DEAD

			self:disableEffects()

			self:StopMotionController()

			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_PUSH)
			self:SetSolid(SOLID_VPHYSICS)

			self:SetPos(colData.HitPos - (colData.HitPos - self:GetPos()) * 0.25)

			self:StopSound("NPC_AttackHelicopter.CrashingAlarm1")

			self:EmitSound("NPC_AttackHelicopter.Crash")

			local effect = ents.Create("env_ar2explosion")
				effect:SetPos(colData.HitPos)
				effect:Spawn()
				effect:Activate()
			effect:Fire("explode")

			self.spotlight1:Fire("lightoff")
			self.spotlight2:Fire("lightoff")
		end
	end

	function ENT:PhysicsSimulate(phys, delta)
		local avel = phys:GetAngleVelocity()
		local lvel = WorldToLocal(phys:GetVelocity(), Angle(), Vector(), phys:GetAngles())
		local gvel = phys:GetVelocity()

		local desiredPitch = -(self.storedVel:Dot(self:GetForward()) - gvel:Dot(self:GetForward())) * self.pitchMultiplier
		local desiredRoll = -(self.storedVel:Dot(self:GetRight()) - gvel:Dot(self:GetRight())) * self.rollMultiplier

		local pLerp = 1 - math.sin(delta * math.pi * 0.5)

		desiredPitch = Lerp(pLerp * delta + delta, self.storedPitch, desiredPitch)

		self.storedPitch = desiredPitch
		self.storedVel = gvel

		if self.isActive then
			local paramL = self:GetPoseParameter("rotor_left")
			local paramR = self:GetPoseParameter("rotor_right")

			local accel = math.Remap(lvel.x - self.storedLocalVel.x, -15, 15, 90, -90)
			local vel = math.Remap(lvel.x, -2200, 2200, 90, -90)

			local rot = math.Clamp(avel:Dot(Vector(0, 0, 1)), -90, 90)

			local targetL = accel + vel + rot
			local targetR = accel + vel - rot

			paramL = math.Approach(paramL, targetL, (paramL - targetL) * FrameTime() * math.pi)
			paramR = math.Approach(paramR, targetR, (paramR - targetR) * FrameTime() * math.pi)

			self:SetPoseParameter("rotor_left", paramL)
			self:SetPoseParameter("rotor_right", paramR)

			local sway = math.Remap(lvel.y, -1600, 1600, -45, 45)

			self:SetPoseParameter("move_yaw", -sway)
		else
			self:SetPoseParameter("rotor_left", 0)
			self:SetPoseParameter("rotor_right", 0)

			self:SetPoseParameter("move_yaw", 0)
		end

		self.storedLocalVel = lvel

		local desiredPos = self:GetPos()
		local desiredYaw = self:GetAngles().y

		local ply = self.driver

		if ply and ply:IsValid() then
			local addPos = Vector(0, 0, 0)

			if ply:KeyDown(IN_FORWARD) then
				addPos.x = 0.7
			elseif ply:KeyDown(IN_BACK) then
				addPos.x = -0.7
			end

			if ply:KeyDown(IN_MOVELEFT) then
				addPos.y = 0.5
			elseif ply:KeyDown(IN_MOVERIGHT) then
				addPos.y = -0.5
			end

			if ply:KeyDown(IN_JUMP) then
				addPos.z = 0.3
			elseif ply:KeyDown(IN_SPEED) then
				addPos.z = -0.3
			end

			local ang = self:GetAngles()
			ang.r = 0
			ang.p = 0

			if ply:KeyDown(IN_WALK) then
				desiredYaw = self.storedYaw
			else
				desiredYaw = self:WorldToLocalAngles(ply:EyeAngles()).y
			end

			if ply:KeyDown(IN_WALK) then
				addPos:Rotate(Angle(0, self.storedYaw, 0))
			else
				addPos:Rotate(Angle(0, desiredYaw, 0))
				self.storedYaw = desiredYaw
			end

			local mult = self:GetSpeedMult()

			addPos:Mul(mult)

			local dist = math.Clamp(self.storedPos:Distance(addPos), 0, mult)
			local time = math.Remap(dist, 0, mult, 0, 1)

			local lerp = 1 - math.sin(time * math.pi * 0.5)

			addPos = LerpVector(lerp * delta + (delta * 0.4), self.storedPos, addPos)

			self.storedPos = addPos

			desiredPos = desiredPos + addPos
		end

		local randPos = Vector(math.sin(math.cos(CurTime())) * 10, math.sin(math.sin(CurTime())) * 10, 0)
		randPos:Rotate(self:GetAngles())

		desiredPos = desiredPos + randPos

		if self.healthStatus == AW2_CRASHING then
			desiredYaw = self:GetAngles().y + 90

			local vec = Vector(100, 0, 0)
			vec:Rotate(self:GetAngles())
			vec.z = -300

			desiredPos = desiredPos + vec
		end

		local move = {}
		move.secondstoarrive = 0.5
		move.pos = desiredPos
		move.angle = Angle(desiredPitch, desiredYaw, desiredRoll)
		move.maxangular	= 12000
		move.maxangulardamp	= 10000
		move.maxspeed = 12000
		move.maxspeeddamp = 10000
		move.dampfactor = 0.6
		move.teleportdistance = 0
		move.deltatime = delta

		if ply and ply:IsValid() or self.healthStatus == AW2_CRASHING or (GetConVar("aw2_alwayson"):GetBool() and self.healthStatus ~= AW2_DEAD) then
			phys:ComputeShadowControl(move)
		else
			self.storedPos = Vector(0, 0, 0)
		end
	end
end