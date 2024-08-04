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

ENT.PrintName				= "Gunship"
ENT.Category 				= "Airwatch 2"

ENT.Spawnable				= true
ENT.AdminOnly 				= true

ENT.AutomaticFrameAdvance 	= true

ENT.firstPersonOffset 		= Vector(100, 0, -50)
ENT.thirdPersonOffset		= Vector(-600, 0, 0)

ENT.baseAttach 				= 1

ENT.pitchIndex 				= 0
ENT.yawIndex 				= 1

ENT.accuracy 				= 0.01
ENT.damage 					= 25
ENT.delay 					= 0.05

util.PrecacheSound("NPC_CombineGunship.RotorSound")
util.PrecacheSound("NPC_CombineGunship.ExhaustSound")
util.PrecacheSound("NPC_CombineGunship.RotorBlastSound")
util.PrecacheSound("NPC_CombineGunship.CannonSound")
util.PrecacheSound("NPC_CombineGunship.CannonStopSound")

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
		self:aimGun()
		self:weaponThink()

		local ply = self.driver

		if ply and ply:IsValid() or self.healthStatus == AW2_CRASHING or GetConVar("aw2_alwayson"):GetBool() then
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

function ENT:hasLOS()
	local ply = self:GetGunOperator()

	if ply and ply:IsValid() then
		local hitpos = self:getHitpos(ply)

		local barrel = self:GetAttachment(self.baseAttach)

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
		self:SetModel("models/gunship.mdl")
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

		self:StartMotionController()

		self:SetPlaybackRate(0)

		self:SetMaxHealth(GetConVar("aw2_gunship_health"):GetInt())
		self:SetHealth(self:GetMaxHealth())

		self.healthStatus = AW2_HEALTHY
		self.lastPercentage = 100

		self.driver = nil

		self.storedPos = Vector(0, 0, 0)
		self.storedVel = Vector(0, 0, 0)

		self.storedPitch = 0
		self.storedYaw = 0

		self.isActive = false
		self.isFiring = false

		self.nextShot = 0

		self.nextPing = 0

		self:SetSpeedMult(GetConVar("aw2_gunship_speedmult"):GetInt())
	end

	function ENT:Use(ply)
		if not self.driver then
			ply:EnterVehicle(self.seatDriver)
			ply:SetNoDraw(true)

			self.driver = ply
			self:SetGunOperator(ply)

			ply.aw2Ent = self

			net.Start("aw2Enter")
				net.WriteEntity(self)
			net.Send(ply)
		end
	end

	function ENT:OnRemove()
		self:StopSound("NPC_CombineGunship.RotorSound")
		self:StopSound("NPC_CombineGunship.ExhaustSound")
		self:StopSound("NPC_CombineGunship.RotorBlastSound")
		self:StopSound("NPC_CombineGunship.CannonSound")
		self:StopSound("NPC_CombineGunship.DyingSound")
	end

	function ENT:enableEffects()
		self:SetPlaybackRate(1)
		self:ResetSequence("prop_turn")

		self.wash = ents.Create("env_rotorwash_emitter")
		self.wash:SetPos(self:GetPos())
		self.wash:SetAngles(self:GetAngles())
		self.wash:SetParent(self)
		self.wash:Spawn()

		self:EmitSound("NPC_CombineGunship.RotorSound")
		self:EmitSound("NPC_CombineGunship.ExhaustSound")
		self:EmitSound("NPC_CombineGunship.RotorBlastSound")
	end

	function ENT:disableEffects()
		self:SetPlaybackRate(0)
		self:ResetSequence("idle")

		if self.wash and self.wash:IsValid() then
			self.wash:Remove()
		end

		self:StopSound("NPC_CombineGunship.RotorSound")
		self:StopSound("NPC_CombineGunship.ExhaustSound")
		self:StopSound("NPC_CombineGunship.RotorBlastSound")
	end

	function ENT:weaponThink()
		if self.healthStatus ~= AW2_HEALTHY then
			return
		end

		local ply = self:GetGunOperator()

		if not ply or not ply:IsValid() then
			return
		end

		local fire = ply:KeyDown(IN_ATTACK) and not ply:KeyDown(IN_RELOAD) and self:hasLOS()

		if fire then
			if self.nextShot <= CurTime() then
				self.nextShot = CurTime() + self.delay

				local bullet = {}
				bullet.Num = 1
				bullet.Src = self:GetAttachment(self.baseAttach).Pos
				bullet.Dir = (self:getHitpos(ply) - self:GetAttachment(self.baseAttach).Pos):GetNormalized():Angle():Forward()
				bullet.Spread = Vector(self.accuracy, self.accuracy, 0)
				bullet.Tracer = 1
				bullet.TracerName = "HelicopterTracer"
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
						e:SetNormal(trace.HitNormal)
					util.Effect("AR2Impact", e)
				end

				self:FireBullets(bullet)

				if not self.isFiring then
					self:EmitSound("NPC_CombineGunship.CannonSound")

					self.isFiring = true
				end
			end
		elseif self.isFiring then
			self:StopSound("NPC_CombineGunship.CannonSound")
			self:EmitSound("NPC_CombineGunship.CannonStopSound")

			self.isFiring = false
		end
	end

	function ENT:keyPress(ply, key)
		if key == IN_ATTACK2 and self.nextPing <= CurTime() then
			self:EmitSound("NPC_CombineGunship.SeeEnemy")

			self.nextPing = CurTime() + 4
		end
	end

	function ENT:aimGun()
		local ply = self:GetGunOperator()

		local pitch = 0
		local yaw = 0

		if ply and ply:IsValid() then
			-- Thanks wiremod
			local rad2deg = 180 / math.pi

			local pos, _ = WorldToLocal(self:getHitpos(ply), self:GetAngles(), self:GetAttachment(self.baseAttach).Pos, self:GetAngles())
			local len = pos:Length()

			if len < 0.0000001000000 then
				pitch = 0
			else
				pitch = rad2deg * math.asin(pos.z / len)
			end

			yaw = rad2deg * math.atan2(pos.y, pos.x)
		end

		local pitchMin, pitchMax = self:GetPoseParameterRange(self.pitchIndex)
		local yawMin, yawMax = self:GetPoseParameterRange(self.yawIndex)

		pitch = math.Clamp(pitch, pitchMin, pitchMax)
		yaw = math.Clamp(yaw, yawMin, yawMax)

		self:SetPoseParameter("flex_vert", -pitch)
		self:SetPoseParameter("flex_horz", yaw)
	end

	function ENT:ejectPlayer(ply, vehicle)
		ply:SetNoDraw(false)

		ply.aw2Ent = nil

		net.Start("aw2Eject")
		net.Send(ply)

		if self.driver == ply then
			self.driver = nil

			self:SetGunOperator(nil)
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

		if GetConVar("aw2_gunship_rocketonly"):GetBool() and not dmgInfo:IsDamageType(DMG_BLAST) and not dmgInfo:IsDamageType(DMG_AIRBOAT) then
			return
		end

		local health = self:Health()

		if health <= 0 then
			return
		end

		self:SetHealth(health - dmgInfo:GetDamage())

		health = self:Health()

		local percentage = (health / self:GetMaxHealth()) * 100
		local doSound = ""

		if percentage <= 75 and self.lastPercentage > 75 then
			doSound = "NPC_CombineGunship.Pain"
		elseif percentage <= 50 and self.lastPercentage > 50 then
			doSound = "NPC_CombineGunship.Pain"
		elseif percentage <= 25 and self.lastPercentage > 25 then
			doSound = "NPC_CombineGunship.Pain"
		elseif percentage <= 15 and self.lastPercentage > 15 then
			doSound = "NPC_CombineGunship.Pain"
		end

		if health <= 0 then
			self.healthStatus = AW2_CRASHING

			self.crashAng = self:GetAngles()

			self:StopSound("NPC_CombineGunship.RotorSound")
			self:StopSound("NPC_CombineGunship.ExhaustSound")
			self:StopSound("NPC_CombineGunship.RotorBlastSound")

			self:EmitSound("NPC_CombineGunship.DyingSound")
		end

		if #doSound > 0 then
			local attachment = math.random(2, 5)

			local explosion = ents.Create("env_explosion")
			explosion:SetPos(self:GetAttachment(attachment).Pos)
			explosion:SetKeyValue("iMagnitude", 100)
			explosion:SetKeyValue("iRadiusOverride", 128)
			explosion:SetKeyValue("spawnflags", 1)
			explosion:SetParent(self)
			explosion:Spawn()
			explosion:Activate()
			explosion:Fire("explode")

			self:EmitSound(doSound)
		end

		self.lastPercentage = percentage
	end

	function ENT:PhysicsCollide(colData, phys)
		if self.healthStatus == AW2_CRASHING then
			self:StopSound("NPC_CombineGunship.DyingSound")
			self:EmitSound("NPC_CombineGunship.Explode")

			local effect = ents.Create("env_ar2explosion")
			effect:SetPos(colData.HitPos)
			effect:Spawn()
			effect:Activate()
			effect:Fire("explode")

			local ragdoll = ents.Create("prop_ragdoll")
			ragdoll:SetModel(self:GetModel())
			ragdoll:SetPos(self:GetPos())
			ragdoll:SetAngles(self:GetAngles())
			ragdoll:Spawn()
			ragdoll:Activate()
			ragdoll:GetPhysicsObject():SetVelocity(colData.OurOldVelocity)

			ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

			self:Remove()
		end
	end

	function ENT:PhysicsSimulate(phys, delta)
		local vel = phys:GetVelocity()

		local desiredPitch = -(self.storedVel:Dot(self:GetForward()) - vel:Dot(self:GetForward())) * 3
		local desiredRoll = -(self.storedVel:Dot(self:GetRight()) - vel:Dot(self:GetRight())) * 3

		if self.isActive then
			local accel = self:GetPoseParameter("fin_accel")
			accel = math.Approach(accel, math.Remap(desiredPitch, -60, 60, -1, 1), delta)
			self:SetPoseParameter("fin_accel", accel)
			self:SetPoseParameter("antenna_accel", accel)

			local sway = self:GetPoseParameter("fin_sway")
			sway = math.Approach(sway, math.Remap(desiredRoll, -60, 60, -1, 1), delta)
			self:SetPoseParameter("fin_sway", sway)
			self:SetPoseParameter("antenna_sway", sway)
		else
			self:SetPoseParameter("fin_accel", -1)
			self:SetPoseParameter("fin_sway", 0)
			self:SetPoseParameter("antenna_accel", 1)
			self:SetPoseParameter("antenna_sway", 0)
		end

		local pLerp = 1 - math.sin(delta * math.pi * 0.5)

		desiredPitch = Lerp(pLerp * delta + delta, self.storedPitch, desiredPitch)

		self.storedPitch = desiredPitch
		self.storedVel = vel

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
				addPos.y = 0.7
			elseif ply:KeyDown(IN_MOVERIGHT) then
				addPos.y = -0.7
			end

			if ply:KeyDown(IN_JUMP) then
				addPos.z = 0.3
			elseif ply:KeyDown(IN_SPEED) then
				addPos.z = -0.3
			end

			local ang = self:GetAngles()
			ang.r = 0
			ang.p = 0

			desiredYaw = self:WorldToLocalAngles(ply:EyeAngles()).y

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
			local vec = Vector(300, 0, 0)
			vec:Rotate(self.crashAng)
			vec.z = -400

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
		move.dampfactor = 0.8
		move.teleportdistance = 0
		move.deltatime = delta

		if ply and ply:IsValid() or self.healthStatus == AW2_CRASHING or GetConVar("aw2_alwayson"):GetBool() then
			phys:ComputeShadowControl(move)
		else
			self.storedPos = Vector(0, 0, 0)
		end
	end
end