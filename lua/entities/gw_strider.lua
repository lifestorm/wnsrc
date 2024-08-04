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

ENT.PrintName				= "Strider"
ENT.Category 				= "Groundwatch"

ENT.Spawnable				= true
ENT.AdminOnly 				= true

ENT.AutomaticFrameAdvance 	= true

ENT.TPOffset				= Vector(-600, 0, 0)

function ENT:SpawnFunction(ply, tr, className)
	if not tr.Hit then
		return
	end

	local spawnPos = tr.HitPos + tr.HitNormal * 500

	local ent = ents.Create(className)
	ent:Spawn()
	ent:Activate()

	ent:SetPos(spawnPos)

	ent.Owner = ply

	return ent
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/Combine_Strider.mdl")

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		self:PrecacheGibs()

		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(500000)
		end

		self.Driver = ents.Create("prop_vehicle_prisoner_pod")
		self.Driver:SetModel("models/props_lab/cactus.mdl")
		self.Driver:SetPos(self:GetPos())
		self.Driver:SetAngles(self:GetAngles())
		self.Driver:SetSolid(SOLID_NONE)
		self.Driver:SetKeyValue("limitview", 0, 0)
		self.Driver:SetNoDraw(true)
		self.Driver:Spawn()
		self.Driver:SetParent(self)
		self.Driver:SetNotSolid(true)
		self.Driver:SetNWEntity("GWEnt", self)

		self:SetDriver(self.Driver)

		self:DeleteOnRemove(self.Driver)

		self:StartMotionController()

		self:SetMaxHealth(GetConVar("gw_strider_health"):GetInt())
		self:SetHealth(self:GetMaxHealth())

		self:SetPoseParameter("body_height", 500)

		self.StoredYaw = 0
		self.StoredPose = 0

		self.NextShot = 0
		self.NextCannon = 0

		self.NextSound = 0

		self.LastPercentage = 100
	end

	if CLIENT then
		self.LastStep = 0
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Driver")
end

function ENT:Think()
	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end


	if CLIENT then
		local sequence = self:GetSequence()

		if sequence == self:LookupSequence("walk_all") or sequence == self:LookupSequence("fastwalk_all") then
			self:HandleStep()
		end
	end

	if SERVER then
		self:AimGun()
		self:WeaponThink()
	end

	self:NextThink(CurTime())
	return true
end

function ENT:HasLOS()
	local ent = self:GetDriver()

	if not IsValid(ent) then
		return
	end

	local ply

	if CLIENT then
		ply = LocalPlayer()
	else
		ply = ent:GetDriver()
	end

	if IsValid(ply) then
		local hitpos = self:GetHitpos(ply)
		local barrel = self:GetAttachment(10)

		local dot = barrel.Ang:Forward():Dot((hitpos - barrel.Pos):GetNormalized())

		if dot >= 0.9 then
			return true
		end
	end

	return false
end

function ENT:GetViewData(ply)
	if not IsValid(ply) then
		return
	end

	local eye = ply:EyeAngles()

	-- Hours wasted on trying to find what the issue was: 4.5
	-- Hours wasted on trying to fix the issue before finding out the fix was the issue: Too many
	if SERVER then
		eye = self:WorldToLocalAngles(eye) -- Note to self: NEVER subtract angles when you can WorldToLocal/LocalToWorld
	end

	local thirdperson = ply:GetVehicle():GetThirdPersonMode()

	local pos, ang

	if thirdperson then
		-- TODO: Attach camera to attachment point
		local trace = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() + eye:Up() * self.TPOffset.z + eye:Forward() * self.TPOffset.x,
			mask = MASK_SOLID_BRUSHONLY
		})

		pos = trace.HitPos + trace.HitNormal * 5
		ang = eye
	else
		local entAng = self:GetAngles()

		entAng.p = 0
		entAng.r = 0

		pos = self:GetAttachment(11).Pos
		ang = eye
	end

	return pos, ang
end

function ENT:GetHitpos(ply)
	local pos, ang = self:GetViewData(ply)

	return util.QuickTrace(pos, ang:Forward() * 10000, {self}).HitPos
end

function ENT:CanPhysgun(ply)
	if ply and ply:IsValid() then
		return ply:IsAdmin()
	end

	return false
end

if CLIENT then
	function ENT:HandleStep()
		local cycle = self:GetCycle()

		if self.LastStep == 0 and cycle > 1 / 3 or
			self.LastStep == 1 and cycle > 2 / 3 or
			self.LastStep == 2 and cycle < 2 / 3 then

			self.LastStep = self.LastStep + 1

			if self.LastStep > 2 then
				self.LastStep = 0
			end

			self:EmitSound("NPC_Strider.Footstep")
		end
	end

	function ENT:Draw()
		self:DrawModel()
	end
end

if SERVER then
	function ENT:Use(ply)
		if IsValid(self.Driver:GetDriver()) then
			return
		end

		ply:EnterVehicle(self.Driver)
		ply:SetNoDraw(true)
	end

	function ENT:Eject(ply)
		ply:SetNoDraw(false)
	end

	function ENT:KeyPress(ply, key)
		if key == IN_ATTACK2 and self:HasLOS() and self.NextCannon <= CurTime() then
			self.NextCannon = CurTime() + 4

			self:EmitSound("NPC_Strider.Charge")

			-- Note: SoundDuration() doesn't like to play along on servers
			timer.Simple(1.254, function()
				if not IsValid(self) then
					return
				end

				local pos = self:GetAttachment(9).Pos

				local bullet = {}
				bullet.Num = 1
				bullet.Src = pos
				bullet.Dir = (self:GetHitpos(ply) - pos):GetNormalized():Angle():Forward()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force = 20
				bullet.Damage = 1000
				bullet.Attacker = ply
				bullet.Callback = function(attacker, trace, dmginfo)
					if not trace.HitPos or not trace.HitNormal then
						return
					end

					util.BlastDamage(self, self, trace.HitPos, 512, 120)

					util.ParticleTracerEx("Weapon_Combine_Ion_Cannon", pos, trace.HitPos, true, self:EntIndex(), 9)
					ParticleEffect("striderbuster_explode_core", trace.HitPos, Angle())
				end

				self:FireBullets(bullet)

				self:EmitSound("NPC_Strider.Shoot")
			end)
		elseif key == IN_RELOAD and self.NextSound <= CurTime() then
			self.NextSound = CurTime() + 2

			self:EmitSound("NPC_Strider.Alert")
		end
	end

	function ENT:EasySetSequence(sequence)
		if self:GetSequence() != self:LookupSequence(sequence) then
			self:SetCycle(0)
			self:ResetSequence(sequence)
		end
	end

	function ENT:AimGun()
		local ply = self.Driver:GetDriver()

		local pitch = -30
		local yaw = 0

		if IsValid(ply) then
			-- Thanks wiremod
			local rad2deg = 180 / math.pi

			local pos, _ = WorldToLocal(self:GetHitpos(ply), self:GetAngles(), self:GetAttachment(11).Pos, self:GetAngles())
			local len = pos:Length()

			if len < 0.0000001000000 then
				pitch = 0
			else
				pitch = rad2deg * math.asin(pos.z / len)
			end

			yaw = rad2deg * math.atan2(pos.y, pos.x)
		end

		local pitchMin, pitchMax = self:GetPoseParameterRange(5)
		local yawMin, yawMax = self:GetPoseParameterRange(4)

		pitch = math.Clamp(pitch, pitchMin, pitchMax)
		yaw = math.Clamp(yaw, yawMin, yawMax)

		self:SetPoseParameter("minigunPitch", -pitch - 40)
		self:SetPoseParameter("minigunYaw", -yaw)
	end

	function ENT:WeaponThink()
		local ply = self.Driver:GetDriver()

		if not IsValid(ply) then
			return
		end

		if ply:KeyDown(IN_ATTACK) and self:HasLOS() and self.NextShot <= CurTime() then
			self.NextShot = CurTime() + 0.2

			local pos = self:GetAttachment(10).Pos

			local bullet = {}
			bullet.Num = 1
			bullet.Src = pos
			bullet.Dir = (self:GetHitpos(ply) - pos):GetNormalized():Angle():Forward()
			bullet.Spread = Vector(0.01, 0.01, 0)
			bullet.Tracer = 0
			bullet.Force = 20
			bullet.Damage = 50
			bullet.Attacker = ply
			bullet.Callback = function(attacker, trace, dmginfo)
				if not trace.HitPos or not trace.HitNormal then
					return
				end

				local tracer = EffectData()
					tracer:SetEntity(self)
					tracer:SetAttachment(10)
					tracer:SetOrigin(trace.HitPos)
					tracer:SetNormal(trace.HitNormal)
					tracer:SetMagnitude(100)
					tracer:SetStart(pos)
					tracer:SetScale(10000)
				util.Effect("HelicopterTracer", tracer)

				dmginfo:SetDamageType(DMG_AIRBOAT)

				local impact = EffectData()
					impact:SetOrigin(trace.HitPos)
					impact:SetNormal(trace.HitNormal)
				util.Effect("AR2Impact", impact)
			end

			self:FireBullets(bullet)

			local effectData = EffectData()
			effectData:SetAttachment(10)
			effectData:SetEntity(self)

			util.Effect("StriderMuzzleFlash", effectData)

			self:EmitSound("NPC_Strider.FireMinigun")
		end
	end

	function ENT:OnTakeDamage(dmgInfo)
		local ply = self.Driver:GetDriver()

		if not IsValid(ply) then
			return
		end

		if not dmgInfo:IsDamageType(DMG_BLAST) and not dmgInfo:IsDamageType(DMG_AIRBOAT) then
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

		if percentage <= 75 and self.LastPercentage > 75 then
			doSound = "NPC_Strider.Pain"
		elseif percentage <= 50 and self.LastPercentage > 50 then
			doSound = "NPC_Strider.Pain"
		elseif percentage <= 25 and self.LastPercentage > 25 then
			doSound = "NPC_Strider.Pain"
		end

		if health <= 0 then
			self:EmitSound("NPC_Strider.Death")

			local explosion = ents.Create("env_explosion")
			explosion:SetPos(self:GetAttachment(12).Pos)
			explosion:SetKeyValue("iMagnitude", 100)
			explosion:SetKeyValue("iRadiusOverride", 128)
			explosion:SetKeyValue("spawnflags", 1)
			explosion:SetParent(self)
			explosion:Spawn()
			explosion:Activate()
			explosion:Fire("explode")

			-- Does not work when running on a server
			-- self:GibBreakServer(Vector())

			-- TODO: Figure out a way to sync the bones with that of the strider itself
			local ragdoll = ents.Create("prop_ragdoll")
			ragdoll:SetModel(self:GetModel())
			ragdoll:SetPos(self:GetPos())
			ragdoll:SetAngles(self:GetAngles())
			ragdoll:Spawn()
			ragdoll:Activate()
			ragdoll:GetPhysicsObject():SetVelocity(self:GetVelocity())

			ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

			self:Remove()

			return
		end

		if #doSound > 0 then
			local explosion = ents.Create("env_explosion")
			explosion:SetPos(self:GetAttachment(12).Pos)
			explosion:SetKeyValue("iMagnitude", 100)
			explosion:SetKeyValue("iRadiusOverride", 128)
			explosion:SetKeyValue("spawnflags", 1)
			explosion:SetParent(self)
			explosion:Spawn()
			explosion:Activate()
			explosion:Fire("explode")

			self:EmitSound(doSound)
		end

		self.LastPercentage = percentage
	end

	function ENT:PhysicsSimulate(phys, delta)
		local trace = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() - (Vector(0, 0, 1) * 10000),
			filter = table.Add({self}, player.GetAll())
		})

		local ply = self.Driver:GetDriver()

		local vec = Vector()
		local ang = Angle()

		local speed = 50

		if IsValid(ply) then
			if ply:KeyDown(IN_FORWARD) then
				vec = vec + Vector(1, 0, 0)
			end

			if ply:KeyDown(IN_BACK) then
				vec = vec + Vector(-1, 0, 0)
			end

			if ply:KeyDown(IN_MOVELEFT) then
				vec = vec + Vector(0, 1, 0)
			end

			if ply:KeyDown(IN_MOVERIGHT) then
				vec = vec + Vector(0, -1, 0)
			end

			if ply:KeyDown(IN_WALK) then
				ang.y = self.StoredYaw
			else
				ang.y = self:WorldToLocalAngles(ply:EyeAngles()).y
				self.StoredYaw = ang.y
			end

			if ply:KeyDown(IN_SPEED) then
				speed = 75
			end
		else
			ang.y = self.StoredYaw
		end

		if self.AnimOverride then
			speed = 0
		end

		vec = vec:GetNormalized() * speed
		vec:Rotate(ang)

		if vec:Length() > 0 then
			if ply:KeyDown(IN_SPEED) then
				self:EasySetSequence("fastwalk_all")
			else
				self:EasySetSequence("walk_all")
			end
		else
			if self.AnimOverride then
				if self.AnimEnd then
					if self.AnimEnd < CurTime() then
						self.AnimOverride = nil
						self.AnimEnd = nil
					end
				else
					self:EasySetSequence(self.AnimOverride)
					self.AnimEnd = CurTime() + self:SequenceDuration(self.AnimOverride)
				end
			else
				self:EasySetSequence("idle01")
			end
		end

		self:SetPoseParameter("move_yaw", math.NormalizeAngle(vec:Angle().y - self:GetAngles().y))

		local move = {}
		move.secondstoarrive = 0.5
		move.pos = trace.HitPos + Vector(0, 0, 490) + vec
		move.angle = ang
		move.maxangular	= 12000
		move.maxangulardamp	= 10000
		move.maxspeed = 12000
		move.maxspeeddamp = 10000
		move.dampfactor = 0.8
		move.teleportdistance = 0
		move.deltatime = delta

		phys:ComputeShadowControl(move)
	end
end