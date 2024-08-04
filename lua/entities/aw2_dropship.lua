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

ENT.PrintName				= "Combine Dropship"
ENT.Category 				= "Airwatch 2"

ENT.Spawnable				= true
ENT.AdminOnly 				= true

ENT.AutomaticFrameAdvance 	= true

ENT.useGunner 				= false

ENT.firstPersonOffset 		= Vector(110, 50, 40)
ENT.thirdPersonOffset		= Vector(-800, 0, 100)

ENT.baseAttach 				= 1
ENT.barrelAttach 			= 2

ENT.pitchIndex 				= 0
ENT.yawIndex 				= 1

ENT.accuracy 				= 0.02
ENT.damage 					= 15
ENT.delay 					= 0.1

util.PrecacheSound("NPC_CombineDropship.NearRotorLoop")
util.PrecacheSound("NPC_CombineDropship.OnGroundRotorLoop")
util.PrecacheSound("NPC_CombineDropship.DescendingWarningLoop")
util.PrecacheSound("NPC_CombineDropship.FireLoop")

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
	self:NetworkVar("Entity", 1, "Pod")

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

		if ply and ply:IsValid() or GetConVar("aw2_alwayson"):GetBool() then
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

		local barrel = self:GetPod():GetAttachment(self.barrelAttach)

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
			filter = {self, self:GetPod()},
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

	return util.QuickTrace(pos, ang:Forward() * 10000, {self, self:GetPod()}).HitPos
end

function ENT:CanPhysgun(ply)
	if ply and ply:IsValid() then
		return ply:IsAdmin()
	end

	return false
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/Combine_dropship.mdl")
		self:ResetSequence("cargo_hover")

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		local phys = self:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMass(500000)
		end

		local pod = ents.Create("prop_dynamic")
		pod:SetModel("models/combine_dropship_container.mdl")
		pod:SetPos(self:GetPos())
		pod:SetAngles(self:GetAngles())
		pod:SetParent(self)
		pod:Spawn()
		pod:Activate()

		self:DeleteOnRemove(pod)

		self:SetPod(pod)

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

		self:StartMotionController()

		self:SetPlaybackRate(0)

		self:SetBodygroup(1, 1)

		self.driver, self.gunner = nil

		self.storedPos = Vector(0, 0, 0)
		self.storedVel = Vector(0, 0, 0)

		self.storedPitch = 0
		self.storedYaw = 0

		self.isActive = false
		self.isFiring = false

		self.nextShot = 0

		self.passengers = {}

		self:SetSpeedMult(GetConVar("aw2_dropship_speedmult"):GetInt())
	end

	function ENT:Use(ply)
		local sequence = self:GetPod():GetSequenceName(self:GetPod():GetSequence())

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
		elseif sequence == "open_idle" then
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
		self:StopSound("NPC_CombineDropship.NearRotorLoop")
		self:StopSound("NPC_CombineDropship.OnGroundRotorLoop")
		self:StopSound("NPC_CombineDropship.DescendingWarningLoop")
		self:StopSound("NPC_CombineDropship.FireLoop")
	end

	function ENT:enableEffects()
		self.wash = ents.Create("env_rotorwash_emitter")
		self.wash:SetPos(self:GetPos())
		self.wash:SetAngles(self:GetAngles())
		self.wash:SetParent(self)
		self.wash:Spawn()

		self:EmitSound("NPC_CombineDropship.OnGroundRotorLoop")
		self:EmitSound("NPC_CombineDropship.NearRotorLoop")

		self:ResetSequence("cargo_idle")
		self:SetPlaybackRate(1)

		self:SetBodygroup(1, 0)
	end

	function ENT:disableEffects()
		if self.wash and self.wash:IsValid() then
			self.wash:Remove()
		end

		self:GetPod():ResetSequence("idle")
		self:StopSound("NPC_CombineDropship.DescendingWarningLoop")

		self:StopSound("NPC_CombineDropship.OnGroundRotorLoop")
		self:StopSound("NPC_CombineDropship.NearRotorLoop")

		self:ResetSequence("cargo_hover")
		self:SetPlaybackRate(0)

		self:SetBodygroup(1, 1)
	end

	function ENT:weaponThink()
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
				bullet.Src = self:GetPod():GetAttachment(self.barrelAttach).Pos
				bullet.Dir = (self:getHitpos(ply) - self:GetPod():GetAttachment(self.barrelAttach).Pos):GetNormalized():Angle():Forward()
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

				self:GetPod():FireBullets(bullet)

				local effectData = EffectData()
				effectData:SetOrigin(self:GetPod():GetAttachment(self.barrelAttach).Pos)
				effectData:SetAngles(self:GetPod():GetAttachment(self.barrelAttach).Ang)
				effectData:SetEntity(self:GetPod())

				util.Effect("ChopperMuzzleFlash", effectData)

				if not self.isFiring then
					self:EmitSound("NPC_CombineDropship.FireLoop")

					self.isFiring = true
				end
			end
		elseif self.isFiring then
			self:StopSound("NPC_CombineDropship.FireLoop")

			self.isFiring = false
		end
	end

	function ENT:keyPress(ply, key)
		if ply == self.driver and key == IN_RELOAD then
			local pod = self:GetPod()

			local sequence = pod:GetSequenceName(pod:GetSequence())

			if sequence == "idle" then
				pod:ResetSequence("open_idle")
				self:EmitSound("NPC_CombineDropship.DescendingWarningLoop")
			else
				pod:ResetSequence("idle")
				self:StopSound("NPC_CombineDropship.DescendingWarningLoop")
			end
		end
	end

	function ENT:aimGun()
		local ply = self:GetGunOperator()
		local pod = self:GetPod()

		local pitch = 0
		local yaw = 0

		if ply and ply:IsValid() then
			-- Thanks wiremod
			local rad2deg = 180 / math.pi

			local pos, _ = WorldToLocal(self:getHitpos(ply), self:GetAngles(), pod:GetAttachment(self.baseAttach).Pos, self:GetAngles())
			local len = pos:Length()

			if len < 0.0000001000000 then
				pitch = 0
			else
				pitch = rad2deg * math.asin(pos.z / len)
			end

			yaw = rad2deg * math.atan2(pos.y, pos.x)
		end

		local pitchMin, pitchMax = pod:GetPoseParameterRange(self.pitchIndex)
		local yawMin, yawMax = pod:GetPoseParameterRange(self.yawIndex)

		pitch = math.Clamp(pitch, pitchMin, pitchMax)
		yaw = math.Clamp(yaw, yawMin, yawMax)

		pod:SetPoseParameter("weapon_pitch", pitch)
		pod:SetPoseParameter("weapon_yaw", yaw)
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

		local ang = Angle(0, self:GetAngles().y, 0)

		ply:SetEyeAngles(ang)
		ply:SetPos(self:LocalToWorld(Vector(170, 0, -50)))
		ply:SetVelocity(self:GetVelocity())
	end

	function ENT:PhysicsSimulate(phys, delta)
		local vel = phys:GetVelocity()

		local localVel = WorldToLocal(phys:GetVelocity(), Angle(), Vector(), phys:GetAngles())

		if self.isActive then
			local accel = self:GetPoseParameter("cargo_body_accel")
			accel = math.Approach(accel, math.Remap(localVel.x, 0, 1600, -0.7, 1), 0.04)

			self:SetPoseParameter("cargo_body_accel", accel)

			local sway = math.Remap(localVel.y, -800, 800, -1, 1)

			self:SetPoseParameter("cargo_body_sway", -sway)
		else
			self:SetPoseParameter("cargo_body_accel", 0)
			self:SetPoseParameter("cargo_body_sway", 0)
		end

		local desiredPitch = -(self.storedVel:Dot(self:GetForward()) - vel:Dot(self:GetForward())) * 3
		local desiredRoll = -(self.storedVel:Dot(self:GetRight()) - vel:Dot(self:GetRight())) * 3

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
				addPos.x = -0.2
			end

			if ply:KeyDown(IN_MOVELEFT) then
				addPos.y = 0.2
			elseif ply:KeyDown(IN_MOVERIGHT) then
				addPos.y = -0.2
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

		if ply and ply:IsValid() or GetConVar("aw2_alwayson"):GetBool() then
			phys:ComputeShadowControl(move)
		else
			self.storedPos = Vector(0, 0, 0)
		end
	end
end