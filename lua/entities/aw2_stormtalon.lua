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

ENT.PrintName				= "Storm Talon"
ENT.Category 				= "Airwatch 2"

ENT.Spawnable				= false
ENT.AdminOnly 				= false

ENT.AutomaticFrameAdvance 	= true

ENT.firstPersonOffset 		= Vector(155, 0, 50)
ENT.thirdPersonOffset		= Vector(-600, 0, 100)

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
end

function ENT:Think()
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end

	if SERVER then
		self:aimTurrets()
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

	if IsValid(ply) then
		local pos, ang = self:GetBonePosition(7)

		ang = ang + Angle(0, self:GetManipulateBoneAngles(4).p, 0) + Angle(self:GetManipulateBoneAngles(7).r, 0, 0)

		local hitpos = self:getHitpos(ply)
		local dot = ang:Forward():Dot((hitpos - pos):GetNormalized())

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

function ENT:Initialize()
	self:SetModel("models/Joazzz/Warhammer40k/Spacemarines/Ultramarines/veh_stormtalon.mdl")
	self:SetBodyGroups("001")
	self:ResetSequence("idle")

	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local phys = self:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMass(500000)
		end

		self:SetUseType(SIMPLE_USE)

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

		self.driver = nil

		self.storedPos = Vector(0, 0, 0)
		self.storedVel = Vector(0, 0, 0)
		self.storedLocalVel = Vector(0, 0, 0)

		self.storedPitch = 0
		self.storedYaw = 0

		self.isActive = false

		self.nextShot = 0

		self.passengers = {}
	end
end

if SERVER then
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
		self:StopSound("NPC_AttackHelicopter.Rotors")
		self:StopSound("NPC_AttackHelicopter.Crash")
		self:StopSound("NPC_CombineDropship.FireLoop")
	end

	function ENT:enableEffects()
		self.wash = ents.Create("env_rotorwash_emitter")
		self.wash:SetPos(self:GetPos())
		self.wash:SetAngles(self:GetAngles())
		self.wash:SetParent(self)
		self.wash:Spawn()

		self:EmitSound("NPC_AttackHelicopter.Rotors")
	end

	function ENT:disableEffects()
		if IsValid(self.wash) then
			self.wash:Remove()
		end

		self:StopSound("NPC_AttackHelicopter.Rotors")
	end

	function ENT:weaponThink()
		local ply = self:GetGunOperator()

		if not IsValid(ply) then
			return
		end

		local fire = ply:KeyDown(IN_ATTACK) and not ply:KeyDown(IN_RELOAD)

		if fire and self:hasLOS() and self.nextShot <= CurTime() then
			self.nextShot = CurTime() + self.delay

			local spread = math.sin(self.accuracy * 0.5 * (math.pi / 180))
			local pos, ang = self:GetBonePosition(7)
			local bullet = {}

			ang = ang + Angle(0, self:GetManipulateBoneAngles(4).p, 0) + Angle(self:GetManipulateBoneAngles(7).r, 0, 0)

			bullet.Num = 1
			bullet.Src = pos
			bullet.Dir = ang:Forward()
			bullet.Spread = Vector(spread, spread, 0)
			bullet.Tracer = 1
			bullet.Force = 20
			bullet.Damage = self.damage
			bullet.Attacker = ply

			self:FireBullets(bullet)

			self:EmitSound("hk/plasma.wav", 140)
		end
	end

	function ENT:keyPress(ply, key)
	end

	function ENT:aimTurrets()
		local ply = self:GetGunOperator()

		local pitch = 0
		local yaw = 0

		if IsValid(ply) then
			local rad2deg = 180 / math.pi

			local turret = self:GetBonePosition(7)

			local pos, _ = WorldToLocal(self:getHitpos(ply), self:GetAngles(), turret, self:GetAngles())
			local len = pos:Length()

			if len < 0.0000001000000 then
				pitch = 0
			else
				pitch = rad2deg * math.asin(pos.z / len)
			end

			yaw = rad2deg * math.atan2(pos.y, pos.x)
		end

		pitch = math.Clamp(pitch, -50, 10)

		self:ManipulateBoneAngles(4, Angle(yaw, 0, 0))
		self:ManipulateBoneAngles(7, Angle(0, 0, -pitch))
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
			local paramL = self:GetManipulateBoneAngles(2).r
			local paramR = self:GetManipulateBoneAngles(3).r

			local vel = math.Remap(lvel.x, -2200, 2200, -180, 0)
			local rot = math.Clamp(avel:Dot(Vector(0, 0, 1)), -45, 45) * math.Remap(math.abs(lvel.x), 0, 2200, -1, 1)
			local vert = math.Remap(lvel.z, -1000, 1000, 45, -45) * math.Remap(lvel.x, -2200, 2200, -1, 1)

			local targetL = vel + rot + vert
			local targetR = vel - rot + vert

			paramL = math.Approach(paramL, targetL, (paramL - targetL) * FrameTime() * math.pi)
			paramR = math.Approach(paramR, targetR, (paramR - targetR) * FrameTime() * math.pi)

			self:ManipulateBoneAngles(2, Angle(0, 0, paramL))
			self:ManipulateBoneAngles(3, Angle(0, 0, paramR))
		else
			self:ManipulateBoneAngles(2, Angle(0, 0, -45))
			self:ManipulateBoneAngles(3, Angle(0, 0, -45))
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

			local mult = 1000

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
		move.dampfactor = 0.6
		move.teleportdistance = 0
		move.deltatime = delta

		if IsValid(ply) or GetConVar("aw2_alwayson"):GetBool() then
			phys:ComputeShadowControl(move)
		else
			self.storedPos = Vector(0, 0, 0)
		end
	end
end