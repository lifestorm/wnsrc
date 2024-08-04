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

EYES_OFF 		= 0
EYES_ON1 		= 1
EYES_ON2		= 2
EYES_STUNNED 	= 3
EYES_DEAD 		= 4

ENT.Type 					= "anim"
ENT.Base 					= "base_gmodentity"

ENT.PrintName				= "Manhack"
ENT.Category 				= "Airwatch 2"

ENT.Spawnable				= true
ENT.AdminOnly 				= true

ENT.AutomaticFrameAdvance 	= true

ENT.firstPersonOffset 		= Vector()
ENT.thirdPersonOffset		= Vector(-50, 0, 10)

ENT.pitchMultiplier 		= 0.05
ENT.rollMultiplier 			= 0.05

ENT.EventStartEngine 		= 50
ENT.EventDoneUnpacking 		= 51
ENT.EventOpenBlade 			= 52

ENT.PoseParameters 			= {
	"Panel1",
	"Panel2",
	"Panel3",
	"Panel4"
}

ENT.EyeSprite = "sprites/glow1.vmt"

util.PrecacheSound("NPC_Manhack.EngineSound1")
util.PrecacheSound("NPC_Manhack.BladeSound")

util.PrecacheSound("NPC_Manhack.ChargeAnnounce")
util.PrecacheSound("NPC_Manhack.ChargeEnd")

util.PrecacheSound("NPC_Manhack.Unpack")
util.PrecacheSound("NPC_Manhack.Grind")
util.PrecacheSound("NPC_Manhack.Slice")

util.PrecacheSound("NPC_Manhack.Stunned")
util.PrecacheSound("NPC_RollerMine.Reprogram")

function ENT:SpawnFunction(ply, tr, className)
	if not tr.Hit then
		return
	end

	local spawnPos = tr.HitPos + tr.HitNormal * 20

	local ent = ents.Create(className)
	ent:Spawn()
	ent:Activate()

	ent:SetPos(spawnPos)

	ent.Owner = ply

	return ent
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "SpeedMult")
end

function ENT:Think()
	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end

	if SERVER then
		if not self.Dead then
			if not IsValid(self.driver) and self.Active then
				self:TurnOff()
			end

			self:UpdatePoseParameters()
			self:UpdateMotor()
			self:UpdateSound()
			self:UpdateEyes()
		else
			self:DoSparks()
		end
	end

	self:NextThink(CurTime())

	return true
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

	local trace = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + eyeAng:Up() * self.thirdPersonOffset.z + eyeAng:Forward() * self.thirdPersonOffset.x,
		filter = {self},
		mask = MASK_SOLID_BRUSHONLY
	})

	local pos = trace.HitPos + trace.HitNormal * 5
	local ang = eyeAng

	return pos, ang
end

function ENT:CanPhysgun(ply)
	if ply and ply:IsValid() then
		return ply:IsAdmin()
	end

	return false
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/manhack.mdl")
		self:ResetSequence("idle")

		self:SetBodyGroups("000")

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		local phys = self:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMass(30)
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

		self:SetMaxHealth(GetConVar("aw2_manhack_health"):GetInt())
		self:SetHealth(self:GetMaxHealth())

		self.driver = nil

		self.storedPos = Vector(0, 0, 0)
		self.storedVel = Vector(0, 0, 0)

		self.storedPitch = 0
		self.storedYaw = 0

		self.Active = false
		self.Dead = false
		self.EyeState = EYES_OFF
		self.IdleState = false
		self.Friendly = false

		self.EnginePower = 0
		self.BladeSpeed = 0
		self.StallTime = 0
		self.SparkTime = 0

		local filter = RecipientFilter()
		filter:AddAllPlayers()

		self.EngineSound1 = CreateSound(self, "NPC_Manhack.EngineSound1", filter)
		self.EngineSound1:ChangeVolume(0.55)

		self:SetSpeedMult(GetConVar("aw2_manhack_speedmult"):GetInt())
	end

	function ENT:Stalled()
		return self.StallTime > CurTime()
	end

	function ENT:DoSparks()
		if self.SparkTime > CurTime() then
			return
		end

		local data = EffectData()

		data:SetOrigin(self:GetPos())
		data:SetAngles(self:GetAngles())
		data:SetNormal(VectorRand())

		util.Effect("ManhackSparks", data)

		self.SparkTime = CurTime() + math.Rand(0.5, 3)
	end

	function ENT:HandleAnimEvent(event)
		if event == self.EventStartEngine then
			self.Active = true

			self:EmitSound("NPC_Manhack.Unpack")
		elseif event == self.EventDoneUnpacking then
			self.EngineSound1:Play()
			self:ResetSequence("fly")
		elseif event == self.EventOpenBlade then
			self:SetBodyGroups("010")
		end
	end

	function ENT:FullyActive()
		return self.Active and self:GetSequenceName(self:GetSequence()) == "fly"
	end

	function ENT:TurnOff()
		self.Active = false
		self.IsHostile = false

		self:ResetSequence("idle")

		self.EngineSound1:Stop()

		self:StopSound("NPC_Manhack.BladeSound")
	end

	function ENT:IsIdle()
		return not self.Active or self:GetSequenceName(self:GetSequence()) == "idle"
	end

	function ENT:SetEyes(state)
		if self.EyeState == state and self.IdleState == self:IsIdle() then
			return
		end

		if state == EYES_OFF and not IsValid(self.EyeGlow) and not IsValid(self.LightGlow) then
			return
		end

		if not self.EyeGlow then
			local attach = self:LookupAttachment("Eye")

			self.EyeGlow = ents.Create("env_sprite")
			self.EyeGlow:SetPos(self:GetAttachment(attach).Pos)
			self.EyeGlow:SetKeyValue("rendermode", 9)
			self.EyeGlow:SetKeyValue("model", self.EyeSprite)
			self.EyeGlow:SetKeyValue("scale", 0.15)
			self.EyeGlow:SetParent(self, attach)

			self.EyeGlow:Spawn()
			self.EyeGlow:Activate()

			self:DeleteOnRemove(self.EyeGlow)
		end

		if not self.LightGlow then
			local attach = self:LookupAttachment("Light")

			self.LightGlow = ents.Create("env_sprite")
			self.LightGlow:SetPos(self:GetAttachment(attach).Pos)
			self.LightGlow:SetKeyValue("rendermode", 9)
			self.LightGlow:SetKeyValue("model", self.EyeSprite)
			self.LightGlow:SetKeyValue("scale", 0.15)
			self.LightGlow:SetParent(self, attach)

			self.LightGlow:Spawn()
			self.LightGlow:Activate()

			self:DeleteOnRemove(self.LightGlow)
		end

		self.EyeState = state
		self.IdleState = self:IsIdle()

		if state == EYES_OFF then
			self.EyeGlow:SetNoDraw(true)
			self.LightGlow:SetNoDraw(true)
		elseif state == EYES_ON1 then
			self.EyeGlow:SetNoDraw(false)
			self.EyeGlow:Fire("Color", "255 0 0")
			self.EyeGlow:SetKeyValue("renderfx", 0)

			self.LightGlow:SetNoDraw(false)
			self.LightGlow:Fire("Color", "255 0 0")
			self.LightGlow:SetKeyValue("renderfx", 0)
		elseif state == EYES_ON2 then
			self.EyeGlow:SetNoDraw(false)
			self.EyeGlow:Fire("Color", "0 255 0")
			self.EyeGlow:SetKeyValue("renderfx", 0)

			self.LightGlow:SetNoDraw(false)
			self.LightGlow:Fire("Color", "0 255 0")
			self.LightGlow:SetKeyValue("renderfx", 0)
		elseif state == EYES_STUNNED then
			self.EyeGlow:SetNoDraw(false)
			self.EyeGlow:Fire("Color", "255 128 0")
			self.EyeGlow:SetKeyValue("renderfx", 10)

			self.LightGlow:SetNoDraw(false)
			self.LightGlow:Fire("Color", "255 128 0")
			self.LightGlow:SetKeyValue("renderfx", 10)
		elseif state == EYES_DEAD then
			self.EyeGlow:SetNoDraw(false)
			self.EyeGlow:Fire("Color", "255 128 0")
			self.EyeGlow:SetKeyValue("renderfx", 9)

			self.LightGlow:SetNoDraw(false)
			self.LightGlow:Fire("Color", "255 128 0")
			self.LightGlow:SetKeyValue("renderfx", 9)
		end

		if self:IsIdle() then
			self.LightGlow:SetNoDraw(true)
		end
	end

	function ENT:UpdateEyes()
		if self:Stalled() then
			self:SetEyes(EYES_STUNNED)
		else
			self:SetEyes(self.Friendly and EYES_ON2 or EYES_ON1)
		end
	end

	function ENT:Use(ply)
		if not self.driver and not self.Dead then
			ply:EnterVehicle(self.seatDriver)
			ply:SetNoDraw(true)

			self.driver = ply

			ply.aw2Ent = self

			net.Start("aw2Enter")
				net.WriteEntity(self)
			net.Send(ply)
		end
	end

	function ENT:UpdatePoseParameters()
		local param = self:GetPoseParameter(self.PoseParameters[1])

		if not self.Active then
			param = 0
		elseif self.IsHostile then
			param = math.Approach(param, 90, 700 * FrameTime())
		else
			param = math.Approach(param, 0, 700 * FrameTime())
		end

		for _, v in pairs(self.PoseParameters) do
			self:SetPoseParameter(v, param)
		end
	end

	function ENT:UpdateSound()
		if not self.Active then
			return
		end

		local vel = math.abs(self:GetVelocity():Length())
		local pitch1 = math.Remap(vel, 0, 400, 100, 160)

		self.EngineSound1:ChangePitch(pitch1, 0.5)
	end

	function ENT:UpdateMotor()
		if not self.Active then
			self.EnginePower = 0
			self.BladeSpeed = 0

			self:SetBodyGroups("000")

			return
		end

		if self:WaterLevel() > 1 then
			self.EnginePower = 0.75
		elseif self.EnginePower < 1 and not self:Stalled() then
			self.EnginePower = math.Min(self.EnginePower + (1 * FrameTime()), 1)
		end

		if self:FullyActive() then
			if not self:Stalled() then
				if self.BladeSpeed < 10 then
					self.BladeSpeed = self.BladeSpeed * 2 + 1
				else
					self.BladeSpeed = math.Min(self.BladeSpeed + (80 * FrameTime()), 100)
				end
			end

			self:SetPlaybackRate(self.BladeSpeed * 0.01)
		else
			self:SetPlaybackRate(1)
		end

		if self.BladeSpeed < 20 then
			self:SetBodyGroups("010")
		elseif self.BladeSpeed < 40 then
			self:SetBodyGroups("011")
		else
			self:SetBodyGroups("001")
		end
	end

	function ENT:ShowHostile(state)
		if self.IsHostile == state then
			return
		end

		self.IsHostile = state

		if state then
			self:EmitSound("NPC_Manhack.ChargeAnnounce")
			self:EmitSound("NPC_Manhack.BladeSound")
		else
			self:EmitSound("NPC_Manhack.ChargeEnd")
			self:StopSound("NPC_Manhack.BladeSound")
		end
	end

	function ENT:OnRemove()
		self:TurnOff()
	end

	function ENT:keyPress(ply, key)
		if self.Dead then
			return
		end

		if key == IN_ATTACK then
			if not self.Active then
				self:ResetSequence("deploy")
				self:SetCycle(0)
			else
				self:ShowHostile(not self.IsHostile)
			end
		end

		if key == IN_ATTACK2 then
			self:Stall(true)
		end

		if key == IN_RELOAD then
			self.Friendly = not self.Friendly

			self:EmitSound("NPC_RollerMine.Reprogram")
		end
	end

	function ENT:ejectPlayer(ply, vehicle)
		ply:SetNoDraw(false)

		ply.aw2Ent = nil

		net.Start("aw2Eject")
		net.Send(ply)

		if self.driver == ply then
			self.driver = nil
		end

		ply:SetVelocity(self:GetVelocity())

		self.storedPos = Vector()
	end

	function ENT:OnTakeDamage(dmgInfo)
		local ply = self.driver

		if not IsValid(ply) then
			return
		end

		local scale = 1
		local dmg = dmgInfo:GetDamage()

		if dmgInfo:IsDamageType(DMG_CLUB) then
			scale = 1.5

			local dir = dmgInfo:GetDamageForce():GetNormalized()
			local force = dir * (dmg * scale) * 100

			self.storedPos = force
			self:Stall()
		end

		self:SetHealth(self:Health() - (dmg * scale))

		if self:Health() <= 0 then
			self:StopSound("NPC_Manhack.Stunned")
			self:Die()
		end
	end

	function ENT:Stall(force)
		if force then
			self.storedPos = VectorRand() * 100
			self:EmitSound("NPC_Manhack.Bat")
		end

		self.BladeSpeed = 10
		self.EnginePower = 0

		self.StallTime = CurTime() + 2

		self:ShowHostile(false)
		self:EmitSound("NPC_Manhack.Stunned")
	end

	function ENT:Die()
		self.Dead = true

		self:EmitSound("NPC_Manhack.Die")

		self:TurnOff()
		self:SetEyes(EYES_DEAD)

		self:SetBodyGroups("000")

		for _, v in pairs(self.PoseParameters) do
			self:SetPoseParameter(v, 0)
		end

		self:SetLocalAngularVelocity(AngleRand() * 100)

		self.Smoke = ents.Create("env_smoketrail")
		self.Smoke:SetPos(self:GetPos())
		self.Smoke:SetKeyValue("opacity", 0.2)
		self.Smoke:SetKeyValue("spawnrate", 20)
		self.Smoke:SetKeyValue("lifetime", 0.5)
		self.Smoke:SetKeyValue("minspeed", 15)
		self.Smoke:SetKeyValue("maxspeed", 12)
		self.Smoke:SetKeyValue("startcolor", "0.4 0.4 0.4")
		self.Smoke:SetKeyValue("endcolor", "0 0 0")
		self.Smoke:SetKeyValue("startsize", 8)
		self.Smoke:SetKeyValue("endsize", 32)
		self.Smoke:SetKeyValue("spawnradius", 5)
		self.Smoke:SetParent(self)
		self.Smoke:Spawn()
		self.Smoke:Activate()
	end

	function ENT:PhysicsCollide(colData, phys)
		if not self:FullyActive() then
			return
		end

		local ent = colData.HitEntity

		if ent:Health() > 0 then
			self:Slice(colData, phys)
		else
			self:Bump(colData, phys)
		end

		self.BladeSpeed = 20
	end

	function ENT:Slice(colData, phys)
		local ent = colData.HitEntity
		local damage = self.IsHostile and 30 or 5

		if ent:IsNPC() then
			damage = damage * 0.5
		elseif string.find(ent:GetClass(), "prop_*") and ent:Health() > 0 then
			damage = ent:Health() * 2
		end

		if ent:GetClass() != self:GetClass() then
			local info = DamageInfo()

			info:SetAttacker(self.driver or self)
			info:SetDamage(damage)
			info:SetDamageForce(colData.OurOldVelocity)
			info:SetDamagePosition(colData.HitPos)
			info:SetDamageType(DMG_SLASH)
			info:SetInflictor(self)
			info:SetReportedPosition(colData.HitPos)

			ent:TakeDamageInfo(info)
		end

		local blood = ent:GetBloodColor()

		if blood == DONT_BLEED or blood == nil then
			local vel = -self.storedPos:GetNormalized()
			local data = EffectData()

			data:SetOrigin(colData.HitPos)
			data:SetAngles(self:GetAngles())
			data:SetNormal((colData.HitNormal + vel) * 0.5)

			util.Effect("ManhackSparks", data)

			self:EmitSound("NPC_Manhack.Grind")
		else
			local env = ents.Create("env_blood")

			env:SetPos(colData.HitPos)
			env:SetKeyValue("spawnflags", 8)
			env:SetKeyValue("amount", 250)
			env:SetCollisionGroup(COLLISION_GROUP_WORLD)
			env:Spawn()
			env:Activate()
			env:Fire("EmitBlood")

			self:EmitSound("NPC_Manhack.Slice")
		end

		self:Rebound(ent)
		self:ShowHostile(false)
	end

	function ENT:Bump(colData, phys)
		local ent = colData.HitEntity

		if ent:GetMoveType() == MOVETYPE_VPHYSICS then
			self:HitPhysicsObject(phys, colData.HitObject)
		end

		if math.abs(self:GetUp():Dot(colData.HitNormal)) < 0.55 then
			local vel = -self.storedPos:GetNormalized()
			local data = EffectData()

			data:SetOrigin(colData.HitPos)
			data:SetAngles(self:GetAngles())
			data:SetNormal((colData.HitNormal + vel) * 0.5)

			util.Effect("ManhackSparks", data)

			self:EmitSound("NPC_Manhack.Grind")

			self:ShowHostile(false)
		end

		local dot = self.storedPos:Dot(colData.HitNormal) * colData.HitNormal
		local reflect = -2 * dot + self.storedPos

		self.storedPos = reflect * 0.5
	end

	function ENT:Rebound(ent)
		if ent:Health() > 0 and ent:GetClass() == "func_breakable_surf" then
			return
		end

		local dir = (self:WorldSpaceCenter() - ent:WorldSpaceCenter()):GetNormalized()

		dir = dir * 100
		dir.y = 0

		local phys = ent:GetPhysicsObject()

		if IsValid(phys) then
			phys:ApplyForceOffset(dir * 4, self:GetPos())
		end

		self.storedPos = dir
	end

	function ENT:HitPhysicsObject(phys, other)
		local pos = other:GetPos()
		local pos2 = phys:GetPos()

		local dir = (pos - pos2):GetNormalized()
		local cross = dir:Cross(Vector(0, 0, 1)):GetNormalized()

		other:ApplyForceOffset(cross * 30 * 100, pos)
	end

	function ENT:PhysicsSimulate(phys, delta)
		if not self.Active then
			return
		end

		local gvel = phys:GetVelocity()

		local desiredPitch = gvel:Dot(self:GetForward()) * self.pitchMultiplier
		local desiredRoll = gvel:Dot(self:GetRight()) * self.rollMultiplier

		local desiredPos = self:GetPos()
		local desiredYaw = self:GetAngles().y

		local ply = self.driver

		if IsValid(ply) and self:FullyActive() then
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

			local mult = self:GetSpeedMult() * math.max(0.01, self.EnginePower)

			addPos:Mul(mult)

			local dist = math.Clamp(self.storedPos:Distance(addPos), 0, mult)
			local time = math.Remap(dist, 0, mult, 0, 1)

			local lerp = 1 - math.sin(time * math.pi * 0.5)

			addPos = LerpVector(lerp * delta + (delta * 0.4), self.storedPos, addPos)

			self.storedPos = addPos

			desiredPos = desiredPos + addPos
		end

		local randPos = Vector(math.sin(math.cos(CurTime())) * 1, math.sin(math.sin(CurTime())) * 1, 0)
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

		if IsValid(ply) then
			phys:ComputeShadowControl(move)
		else
			self.storedPos = Vector(0, 0, 0)
		end
	end
end