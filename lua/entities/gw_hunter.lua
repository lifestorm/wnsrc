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

ENT.PrintName				= "Hunter"
ENT.Category 				= "Groundwatch"

ENT.Spawnable				= true
ENT.AdminOnly 				= true

ENT.AutomaticFrameAdvance 	= true

ENT.TPOffset				= Vector(-300, 0, 0)

local MOVE_WALK 			= 0
local MOVE_RUN 				= 1

function ENT:SpawnFunction(ply, tr, className)
	if not tr.Hit then
		return
	end

	local spawnPos = tr.HitPos + tr.HitNormal

	local ent = ents.Create(className)
	ent:SetPos(spawnPos)
	ent:Spawn()
	ent:Activate()

	ent.Owner = ply

	return ent
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/hunter.mdl")

		self:PhysicsInitBox(Vector(-18, -18, 55), Vector(18, 18, 100))
		self:SetMoveType(MOVETYPE_VPHYSICS)

		self:SetCollisionGroup(COLLISION_GROUP_NPC)

		self:SetUseType(SIMPLE_USE)

		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(500000)
		end

		self.Driver = ents.Create("prop_vehicle_prisoner_pod")
		self.Driver:SetModel("models/props_lab/cactus.mdl")
		self.Driver:SetPos(self:GetAttachment(9).Pos)
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

		self:SetMaxHealth(GetConVar("gw_hunter_health"):GetInt())
		self:SetHealth(self:GetMaxHealth())

		self:SetOverride("drop_down")

		self.StoredYaw = self:GetAngles().y
		self.StoredAimYaw = 0

		self.NextShot = 0

		self.LastPercentage = 0
		self.BleedFromAnus = false

		self.HeadRadius = (GW.GetStringAttachment(self, "head_center").Pos - GW.GetStringAttachment(self, "head_radius_measure").Pos):Length()
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

	if SERVER then
		self:AimGun()
		self:WeaponThink()
		self:BleedThink()
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
		local barrel = self:GetAttachment(6)

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
		local center = self:GetAttachment(9).Pos

		local trace = util.TraceLine({
			start = center,
			endpos = center + eye:Up() * self.TPOffset.z + eye:Forward() * self.TPOffset.x,
			mask = MASK_SOLID_BRUSHONLY
		})

		pos = trace.HitPos + trace.HitNormal * 5
		ang = eye
	else
		local entAng = self:GetAngles()

		entAng.p = 0
		entAng.r = 0

		pos = self:GetAttachment(6).Pos
		ang = eye
	end

	return pos, ang
end

function ENT:GetHitpos(ply)
	local pos, ang = self:GetViewData(ply)
	local trace = {
		start = pos,
		endpos = pos + ang:Forward() * 10000,
		filter = {self},
		mask = MASK_SOLID_BRUSHONLY
	}

	return util.TraceLine(trace).HitPos
end

function ENT:CanPhysgun(ply)
	if ply and ply:IsValid() then
		return ply:IsAdmin()
	end

	return false
end

if CLIENT then
	function ENT:FireAnimationEvent(_, _, event)
		local sequence = self:GetSequenceName(self:GetSequence())

		if (sequence == "canter_all" or sequence == "walk_all") and (event == 6006 or event == 6007) then
			self:EmitSound("NPC_Hunter.Footstep")
		end
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
		if key == IN_RELOAD and not self.AnimEnd then
			-- Scan sounds don't have their own animation
			if ply:KeyDown(IN_WALK) then
				self:EmitSound("NPC_Hunter.Scan")

				return
			end

			local anims = {
				"hunter_call_1",
				"hunter_respond_1",
				"hunter_respond_3"
			}

			local anims_angry = {
				"hunter_angry",
				"hunter_angry_2"
			}

			local anim

			if ply:KeyDown(IN_SPEED) then
				anim = anims_angry[math.random(1, #anims_angry)]
			else
				anim = anims[math.random(1, #anims)]
			end

			self:SetOverride(anim)
		elseif key == IN_ATTACK2 and not self.AnimEnd then
			local anims = {
				"melee_02",
				"meleeleft",
				"meleert"
			}

			local anim = anims[math.random(1, #anims)]

			local time = self:SetOverride(anim)

			timer.Simple(time * 0.5, function()
				if not IsValid(ply) then
					return
				end

				local pos = self:GetAttachment(4).Pos
				local _, ang = self:GetViewData(ply)

				local trace = util.TraceHull({
					start = pos,
					endpos = pos + ang:Forward() * 100,
					filter = self,
					mins = Vector(-20, -20, -15),
					maxs = Vector(20, 20, 15),
					mask = MASK_SHOT_HULL
				})

				if IsValid(trace.Entity) and (trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:Health() > 0) then
					local info = DamageInfo()

					info:SetAttacker(ply)
					info:SetInflictor(self)

					info:SetDamageType(bit.bor(DMG_CLUB, DMG_SLASH))

					info:SetDamagePosition(trace.HitPos)

					if trace.Entity:IsNPC() then
						info:SetDamage(trace.Entity:Health())
					else
						info:SetDamage(120)
					end

					info:SetDamageForce(trace.Normal * 10000)

					trace.Entity:TakeDamageInfo(info)
				end
			end)

			self:EmitSound("NPC_Hunter.MeleeAnnounce")
		end
	end

	function ENT:SetOverride(sequence)
		local time = self:SequenceDuration(self:LookupSequence(sequence))

		if self:EasySetSequence(sequence) then
			self.AnimEnd = CurTime() + time
		end

		return time
	end

	function ENT:EasySetSequence(sequence)
		if self:GetSequence() != self:LookupSequence(sequence) then
			self:SetCycle(0)
			self:ResetSequence(sequence)

			return true
		end

		return false
	end

	function ENT:AimGun()
		local ply = self.Driver:GetDriver()

		local pitch = 0
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

		if yaw > 120 then
			yaw = yaw - 180
		elseif yaw < -120 then
			yaw = yaw + 180
		end

		yaw = math.Approach(self.StoredAimYaw, yaw, 10)

		pitch = math.Clamp(pitch, pitchMin, pitchMax)
		yaw = math.Clamp(yaw, yawMin, yawMax)

		self:SetPoseParameter("body_Pitch", -pitch)
		self:SetPoseParameter("body_yaw", yaw)

		self.StoredAimYaw = yaw
	end

	function ENT:WeaponThink()
		local ply = self.Driver:GetDriver()

		if not IsValid(ply) then
			return
		end

		if ply:KeyDown(IN_ATTACK) then
			if self.NextShot <= CurTime() and self:HasLOS() and self.IsPlanted and not self.AnimEnd then
				self.NextShot = CurTime() + 0.1

				self.Attach = not self.Attach

				local pos = self:GetAttachment(self.Attach and 4 or 5).Pos
				local ang = (self:GetHitpos(ply) - pos):GetNormalized():Angle()

				local ent = ents.Create("hunter_flechette")
				ent:SetPos(pos)
				ent:SetAngles(ang)
				ent:Spawn()
				ent:SetVelocity(ang:Forward() * 2000)
				ent:SetOwner(self)

				local effectdata = EffectData()
				effectdata:SetAttachment(self.Attach and 4 or 5)
				effectdata:SetEntity(self)

				ParticleEffect("hunter_muzzle_flash", pos, ang)
				util.Effect("HunterMuzzleFlash", effectdata)

				self:EmitSound("NPC_Hunter.FlechetteShoot")
			end

			if not self.IsPlanted and not self.AnimEnd then
				timer.Simple(self:SetOverride("plant"), function()
					if IsValid(self) then
						self.IsPlanted = true
					end
				end)
			end
		elseif self.IsPlanted then
			timer.Simple(self:SetOverride("unplant"), function()
				if IsValid(self) then
					self.IsPlanted = false
				end
			end)
		end
	end

	function ENT:BleedThink()
		if not self.BleedFromAnus or self.BleedFromAnus > CurTime() then
			return
		end

		local pos = GW.GetStringAttachment(self, "head_center").Pos

		local dir = VectorRand()
		dir:Normalize()

		local ang = dir:Angle()

		dir = dir * self.HeadRadius

		ParticleEffect("blood_spurt_synth_01", pos + dir, ang, self)

		self.BleedFromAnus = CurTime() + math.Rand(0.6, 1.5)
	end

	function ENT:OnTakeDamage(dmginfo)
		-- TODO: Scale down damage taken during certain animations?
		local ply = self.Driver:GetDriver()

		if not IsValid(ply) then
			return
		end

		local health = self:Health()
		local dmg = dmginfo:GetDamage()

		if self.IsPlanted or self.AnimEnd then
			dmg = dmg * 0.5
		end

		if health <= 0 then
			return
		end

		self:SetHealth(health - dmg)

		health = self:Health()

		local percentage = (health / self:GetMaxHealth()) * 100

		if percentage <= 30 and self.LastPercentage > 30 then
			self:EmitSound("NPC_Hunter.Pain")

			-- Start gushing blood from our... anus or something.
			ParticleEffectAttach("blood_drip_synth_01", PATTACH_POINT_FOLLOW, self, self:LookupAttachment("head_radius_measure"))

			self.BleedFromAnus = CurTime()
		end

		if health <= 0 then
			self:EmitSound("NPC_Hunter.Death")

			local ragdoll = ents.Create("prop_ragdoll")
			ragdoll:SetModel(self:GetModel())
			ragdoll:SetPos(self:GetPos())
			ragdoll:SetAngles(self:GetAngles())
			ragdoll:Spawn()
			ragdoll:Activate()
			ragdoll:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity())

			ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

			self:Remove()

			return
		end

		self.LastPercentage = percentage
	end

	function ENT:PhysicsSimulate(phys, delta)
		local trace = util.TraceHull({
			start = self:GetPos() + Vector(0, 0, 100),
			endpos = self:GetPos() - (Vector(0, 0, 1) * 100),
			filter = table.Add({self}, player.GetAll()),
			mins = Vector(-18, -18, 0),
			maxs = Vector(18, 18, 0)
		})

		local ply = self.Driver:GetDriver()

		local vec = Vector()
		local ang = Angle()

		local speed = MOVE_WALK

		if IsValid(ply) then
			if ply:KeyDown(IN_SPEED) then
				speed = MOVE_RUN
			end

			local dir = Vector()

			if ply:KeyDown(IN_FORWARD) then
				dir:Add(Vector(1, 0, 0))
			end

			if ply:KeyDown(IN_BACK) then
				dir:Add(Vector(-1, 0, 0))
			end

			if ply:KeyDown(IN_MOVELEFT) then
				dir:Add(Vector(0, 1, 0))
			end

			if ply:KeyDown(IN_MOVERIGHT) then
				dir:Add(Vector(0, -1, 0))
			end

			if dir:Length() > 0 then
				vec = Vector(1, 0, 0)
				ang.y = dir:Angle().y
			end

			if self.IsPlanted or ply:KeyDown(IN_WALK) then
				ang.y = self.StoredYaw
			else
				ang.y = ang.y + self:WorldToLocalAngles(ply:EyeAngles()).y
				self.StoredYaw = ang.y
			end
		else
			ang.y = self.StoredYaw
		end

		local mult = 20

		if speed == MOVE_RUN then
			mult = 30
		end

		vec = vec * mult
		vec:Rotate(self:GetAngles())

		if util.QuickTrace(self:GetAttachment(9).Pos + vec, Vector(), self).Fraction != 1 then
			vec = Vector()
		elseif self.AnimEnd or self.IsPlanted then
			vec = Vector()
		end

		if not trace.Hit then
			self:EasySetSequence("jump_idle")
		elseif self.AnimEnd then
			if self.AnimEnd <= CurTime() then
				self.AnimEnd = nil
			end
		elseif self.IsPlanted then
			if self:HasLOS() then
				self:EasySetSequence("shoot_minigun")
			else
				self:EasySetSequence("idle_planted")
			end
		elseif vec:Length() > 0 then
			if speed == MOVE_RUN then
				self:EasySetSequence("canter_all")
			else
				self:EasySetSequence("walk_all")
			end
		else
			self:EasySetSequence("idle_3")
		end

		self:SetPoseParameter("move_yaw", math.NormalizeAngle((vec:Angle().y - self:GetAngles().y) * 2))

		local move = {}
		move.secondstoarrive = 0.1
		move.pos = trace.HitPos + vec
		move.angle = ang
		move.maxangular	= math.Remap(self:GetVelocity():Length(), 10, 700, 300, 100)
		move.maxangulardamp	= 10000
		move.maxspeed = 12000
		move.maxspeeddamp = 10000
		move.dampfactor = 0.8
		move.teleportdistance = 0
		move.deltatime = delta

		if trace.Hit then
			phys:ComputeShadowControl(move)
		end

		self.LastHit = trace.Hit
	end
end