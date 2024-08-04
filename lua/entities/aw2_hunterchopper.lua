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

WEAPON_BOMBSINGLE 			= 0
WEAPON_BOMBCARPET 			= 1
WEAPON_ROCKET 				= 2

ENT.Type 					= "anim"
ENT.Base 					= "base_gmodentity"

ENT.PrintName				= "Hunter Chopper"
ENT.Category 				= "Airwatch 2"

ENT.Spawnable				= true
ENT.AdminOnly 				= true

ENT.AutomaticFrameAdvance 	= true

ENT.useGunner 				= false

ENT.firstPersonOffset 		= Vector(142, 0, -11)
ENT.thirdPersonOffset		= Vector(-600, 0, 0)
ENT.gunnerOffset 			= Vector(155, 0, -8)

ENT.baseAttach 				= 1
ENT.bombAttach 				= 3
ENT.sprite1Attach 			= 9
ENT.sprite2Attach 			= 10
ENT.sprite3Attach 			= 11
ENT.spotlightAttach 		= 12

ENT.pitchIndex 				= 0
ENT.yawIndex 				= 2

ENT.accuracy 				= 10
ENT.damage 					= 10
ENT.delay 					= 0.01

ENT.bombDelay 				= 0.6
ENT.carpetBombDelay 		= 0.4
ENT.rocketDelay 			= 0.4

ENT.speakShort 				= 15
ENT.speakLong 				= 45

ENT.respondShort 			= 2.5
ENT.respondLong 			= 4

ENT.voiceQueries 			= {
	"COMBINE_LOST_LONG0", -- on1 targetblackout off1
	"COMBINE_LOST_LONG2", -- on1 motioncheckallradials off1
	"COMBINE_LOST_LONG4", -- on1 overwatch, teamdeployedandscanning off1
	"COMBINE_IDLE1", -- on1 overwatchreportspossiblehostiles off1
	"COMBINE_IDLE4", -- on1 V_MYNAMES V_MYNUMS standingby off1
	"COMBINE_QUEST0", -- on1 readyweaponshostilesinbound off1
	"COMBINE_QUEST1", -- on1 prepforcontact off3
	"COMBINE_QUEST2", -- on2 skyshieldreportslostcontact, readyweapons off1
	"COMBINE_QUEST3", -- on2 stayalert off3
	"COMBINE_QUEST4", -- on2 weaponsoffsafeprepforcontact off2
}

ENT.voiceResponses 			= {
	"COMBINE_ANSWER0", -- on1 affirmative off1
	"COMBINE_ANSWER1", -- on1 copy off1
	"COMBINE_ANSWER2", -- on2 copythat off3
	"COMBINE_ANSWER3", -- on1 affirmative2 off1
}

util.PrecacheSound("NPC_AttackHelicopter.Rotors")
util.PrecacheSound("NPC_AttackHelicopter.DropMine")
util.PrecacheSound("NPC_AttackHelicopter.BadlyDamagedAlert")
util.PrecacheSound("NPC_AttackHelicopter.MegabombAlert")
util.PrecacheSound("NPC_AttackHelicopter.Crash")
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

	self:NetworkVar("Int", 0, "WeaponMode")
	self:NetworkVar("Int", 1, "SpeedMult")
end

function ENT:Think()
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end

	self:soundThink()

	if SERVER then
		self:aimGun()
		self:weaponThink()

		self:voiceThink()

		local ply = self.driver

		if IsValid(ply) or self.healthStatus == AW2_CRASHING or (GetConVar("aw2_alwayson"):GetBool() and self.healthStatus ~= AW2_DEAD) then
			if not self.isActive then
				self:enableEffects()
			end
		else
			if self.isActive then
				self:disableEffects()
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:soundThink()
	if not self.rotorSound then
		if SERVER then
			local filter = RecipientFilter()
			filter:AddAllPlayers()
		end

		self.rotorSound = CreateSound(self, "NPC_AttackHelicopter.Rotors", filter)
		self.rotorSound:SetSoundLevel(105)
	end

	if self.isActive and not self.rotorSound:IsPlaying() then
		self.rotorSound:Play()
	elseif not self.isActive and self.rotorSound:IsPlaying() then
		self.rotorSound:Stop()
	end
end

function ENT:hasLOS()
	local ply = self:GetGunOperator()

	if ply and ply:IsValid() then
		local hitpos = self:getHitpos(ply)
		local barrel = self:GetAttachment(self:LookupAttachment("Muzzle"))
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
			--offset = self:WorldToLocal(self:GetAttachment(self.baseAttach).Pos)
			--offset = offset - Vector(10, 0, 20)
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
		self:SetModel("models/Combine_Helicopter.mdl")
		self:ResetSequence("idle")

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
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

		self:SetMaxHealth(GetConVar("aw2_chopper_health"):GetInt())
		self:SetHealth(self:GetMaxHealth())

		self.healthStatus = AW2_HEALTHY
		self.lastPercentage = 100

		self.driver, self.gunner = nil

		self.storedPos = Vector(0, 0, 0)
		self.storedVel = Vector(0, 0, 0)

		self.storedPitch = 0
		self.storedYaw = 0

		self.isActive = false
		self.isFiring = false

		self.spotlightActive = false

		self.nextShot = 0
		self.nextBomb = 0
		self.nextCarpetBomb = 0
		self.nextRocket = 0

		self.rocketSide = false

		self.nextVoice = 0
		self.nextResponse = false

		self.passengers = {}

		self:SetSpeedMult(GetConVar("aw2_chopper_speedmult"):GetInt())
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

		self.spotlight:SetParent()
		self.spotlight:Fire("lightoff")
		self.spotlight:Fire("kill",self.Spotlight, 0.5)
	end

	function ENT:enableEffects()
		self:SetPlaybackRate(1)

		self.wash = ents.Create("env_rotorwash_emitter")
		self.wash:SetPos(self:GetPos())
		self.wash:SetAngles(self:GetAngles())
		self.wash:SetParent(self)
		self.wash:Spawn()

		self.isActive = true
	end

	function ENT:disableEffects()
		self:SetPlaybackRate(0)

		if self.wash and self.wash:IsValid() then
			self.wash:Remove()
		end

		self.isActive = false
	end

	function ENT:initLights()
		local renderFX = 9
		local renderMode = 9
		local sprite = "sprites/redglow1.vmt"
		local scale = 1

		local sprite1 = ents.Create("env_sprite")
			sprite1:SetPos(self:GetAttachment(self.sprite1Attach).Pos)
			sprite1:SetKeyValue("renderfx", renderFX)
			sprite1:SetKeyValue("rendermode", renderMode)
			sprite1:SetKeyValue("model", sprite)
			sprite1:SetKeyValue("scale", scale)
			sprite1:SetParent(self)
		sprite1:Spawn()
		sprite1:Activate()

		self:DeleteOnRemove(sprite1)
		self.sprite1 = sprite1

		local sprite2 = ents.Create("env_sprite")
			sprite2:SetPos(self:GetAttachment(self.sprite2Attach).Pos)
			sprite2:SetKeyValue("renderfx", renderFX)
			sprite2:SetKeyValue("rendermode", renderMode)
			sprite2:SetKeyValue("model", sprite)
			sprite2:SetKeyValue("scale", scale)
			sprite2:SetParent(self)
		sprite2:Spawn()
		sprite1:Activate()

		self:DeleteOnRemove(sprite2)
		self.sprite2 = sprite2

		local sprite3 = ents.Create("env_sprite")
			sprite3:SetPos(self:GetAttachment(self.sprite3Attach).Pos)
			sprite3:SetKeyValue("renderfx", renderFX)
			sprite3:SetKeyValue("rendermode", renderMode)
			sprite3:SetKeyValue("model", sprite)
			sprite3:SetKeyValue("scale", scale)
			sprite3:SetParent(self)
		sprite3:Spawn()
		sprite1:Activate()

		self:DeleteOnRemove(sprite3)
		self.sprite3 = sprite3

		local spotlight = ents.Create("point_spotlight")
			spotlight:SetPos(self:GetAttachment(self.spotlightAttach).Pos)
			spotlight:SetKeyValue("spotlightlength", "500")
			spotlight:SetKeyValue("spotlightwidth", "45")
			spotlight:SetKeyValue("spawnflags", 3)
			spotlight:SetParent(self)
		spotlight:Spawn()
		spotlight:Activate()

		self.spotlight = spotlight

		sprite1:Fire("hidesprite")
		sprite2:Fire("hidesprite")
		sprite3:Fire("hidesprite")

		spotlight:Fire("lightoff")
	end

	function ENT:voiceThink()
		if self.healthStatus ~= AW2_HEALTHY then
			return
		end

		if self.nextVoice > CurTime() then
			return
		end

		local ply = self.driver

		if not ply or not ply:IsValid() then
			self.nextVoice = CurTime() + math.random(self.speakShort, self.speakLong)
		else
			local sentence

			if self.nextResponse then
				sentence = self.voiceResponses[math.random(1, #self.voiceResponses)]
				self.nextVoice = CurTime() + math.random(self.speakShort, self.speakLong)
			else
				sentence = self.voiceQueries[math.random(1, #self.voiceQueries)]
				self.nextVoice = CurTime() + math.random(self.respondShort, self.respondLong)
			end

			self.nextResponse = not self.nextResponse

			EmitSentence(sentence, ply:GetPos(), ply:EntIndex())
		end
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

		if fire then
			if self.isCharged and self:hasLOS() then
				if self.nextShot <= CurTime() then
					self.nextShot = CurTime() + self.delay

					local spread = math.sin(self.accuracy * 0.5 * (math.pi / 180))
					local attach = self:LookupAttachment("Muzzle")

					local bullet = {}
					bullet.Num = 1
					bullet.Src = self:GetAttachment(attach).Pos
					bullet.Dir = (self:getHitpos(ply) - self:GetAttachment(attach).Pos):Angle():Forward()
					bullet.Spread = Vector(spread, spread, 0)
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

					local effectData = EffectData()
					effectData:SetAttachment(attach)
					effectData:SetEntity(self)

					util.Effect("ChopperMuzzleFlash", effectData)

					if not self.isFiring then
						self:EmitSound("NPC_AttackHelicopter.FireGun")

						self.isFiring = true
					end
				end
			end

			if not self.isCharged and not self.isCharging then
				self.isCharging = true

				self:EmitSound("NPC_AttackHelicopter.ChargeGun")

				timer.Create("chopper_charge_" .. self:EntIndex(), 1.6, 1, function()
					if IsValid(self) then
						self.isCharging = false
						self.isCharged = true
					end
				end)
			end
		else
			if self.isCharged then
				self.isCharged = false
			end

			if self.isCharging then
				timer.Remove("chopper_charge_" .. self:EntIndex())

				self.isCharging = false

				self:StopSound("NPC_AttackHelicopter.ChargeGun")
			end
		end

		if self.isFiring and not fire or not self:hasLOS() or not self.isCharged then
			self:StopSound("NPC_AttackHelicopter.FireGun")

			self.isFiring = false
		end

		local altFire = ply:KeyDown(IN_ATTACK2) and not ply:KeyDown(IN_RELOAD)

		if altFire then
			if self:GetWeaponMode() == WEAPON_BOMBSINGLE and self.nextBomb <= CurTime() then
				self.nextBomb = CurTime() + self.bombDelay

				local vel = self:GetVelocity()
				local vecAcross = vel:Cross(Vector(0, 0, 1))

				vecAcross:Normalize()

				vecAcross = vecAcross * math.Rand(10, 30)

				if math.Rand(0, 1) > 0.5 then
					vecAcross = vecAcross * -1
				end

				if vel.z > 0 then
					vel.z = 0
				end

				vel = vel + vecAcross

				self:createBomb(vel)

				self:EmitSound("NPC_AttackHelicopter.DropMine")
			elseif self:GetWeaponMode() == WEAPON_BOMBCARPET and self.nextCarpetBomb <= CurTime() then
				self.nextCarpetBomb = CurTime() + self.carpetBombDelay

				local vel = self:GetVelocity()
				local vecAcross = self:GetForward():Cross(Vector(0, 0, 1))

				vecAcross:Normalize()

				vecAcross = vecAcross * math.Rand(300, 500)

				if vel.z > 0 then
					vel.z = 0
				end

				self:createBomb(vel)
				self:createBomb(vel + vecAcross)

				vecAcross = vecAcross * -1

				self:createBomb(vel + vecAcross)

				self:EmitSound("NPC_AttackHelicopter.DropMine")
			elseif self:GetWeaponMode() == WEAPON_ROCKET and self.nextRocket <= CurTime() and self:hasLOS() then
				self.nextRocket = CurTime() + self.rocketDelay
				local side = 80

				if self.rocketSide then
					side = -side
				end

				self.rocketSide = not self.rocketSide

				local pos = self:LocalToWorld(Vector(0, side, -80))
				local tpos = self:getHitpos(ply)

				local ang = (tpos - pos):Angle()

				local rocket = ents.Create("rpg_missile")
				rocket:SetPos(pos)
				rocket:SetAngles(ang)
				rocket:SetSaveValue("m_flDamage", 200)
				rocket:SetOwner(self)
				rocket:SetVelocity(self:GetVelocity())
				rocket:Spawn()

				ply:EmitSound("weapons/grenade_launcher1.wav")
			end
		end
	end

	function ENT:keyPress(ply, key)
		if ply:KeyDown(IN_RELOAD) then
			if key == IN_ATTACK then
				if ply == self:GetGunOperator() then
					if self.spotlightActive then
						self.spotlight:Fire("lightoff")
						self.spotlightActive = false
					else
						self.spotlight:Fire("lighton")
						self.spotlightActive = true
					end
				end

				if ply == self.driver then
					self.sprite1:Fire("togglesprite")
					self.sprite2:Fire("togglesprite")
					self.sprite3:Fire("togglesprite")
				end

				ply:EmitSound("buttons/lightswitch2.wav")
			elseif key == IN_ATTACK2 and ply == self:GetGunOperator() then
				local mode = self:GetWeaponMode() + 1

				if mode >= 3 then
					mode = 0
				end

				self:SetWeaponMode(mode)

				self:GetGunOperator():EmitSound("Buttons.snd27")
			end
		end
	end

	function ENT:aimGun()
		local ply = self:GetGunOperator()

		local pitch = 0
		local yaw = 0

		if ply and ply:IsValid() and self.healthStatus == AW2_HEALTHY then
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

		self:SetPoseParameter("weapon_pitch", pitch)
		self:SetPoseParameter("weapon_yaw", yaw)

		self.spotlight:SetAngles(self:GetAngles() + Angle(-pitch, yaw, 0))
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

		if GetConVar("aw2_chopper_rocketonly"):GetBool() and not dmgInfo:IsDamageType(DMG_BLAST) and not dmgInfo:IsDamageType(DMG_AIRBOAT) then
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
			attachPoint = 4
			doSound = "NPC_AttackHelicopter.BadlyDamagedAlert"
		elseif percentage <= 50 and self.lastPercentage > 50 then
			addSmoke = true
			attachPoint = 5
			doSound = "NPC_AttackHelicopter.BadlyDamagedAlert"
		elseif percentage <= 25 and self.lastPercentage > 25 then
			addSmoke = true
			attachPoint = 6
			doSound = "NPC_AttackHelicopter.BadlyDamagedAlert"
		elseif percentage <= 15 and self.lastPercentage > 15 then
			addSmoke = true
			attachPoint = 7
			doSound = "NPC_AttackHelicopter.MegabombAlert"
		end

		if health <= 0 then
			addSmoke = true
			attachPoint = 8

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

			self.spotlight:Fire("lightoff")
		end
	end

	function ENT:PhysicsSimulate(phys, delta)
		local avel = phys:GetAngleVelocity()
		local vel = phys:GetVelocity()

		local desiredPitch = -(self.storedVel:Dot(self:GetForward()) - vel:Dot(self:GetForward())) * 3
		local desiredRoll = -(self.storedVel:Dot(self:GetRight()) - vel:Dot(self:GetRight())) * 3

		local pLerp = 1 - math.sin(delta * math.pi * 0.5)

		desiredPitch = Lerp(pLerp * delta + delta, self.storedPitch, desiredPitch)

		self.storedPitch = desiredPitch
		self.storedVel = vel

		-- Update tail rudder based on angular velocity
		local clampedAngVel = math.Clamp(avel:Dot(self:GetUp()), -50, 50)
		local rudderAng = math.Remap(clampedAngVel, -50, 50, 40, -40)

		self:SetPoseParameter("rudder", rudderAng)

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
		move.dampfactor = 0.8
		move.teleportdistance = 0
		move.deltatime = delta

		if ply and ply:IsValid() or self.healthStatus == AW2_CRASHING or (GetConVar("aw2_alwayson"):GetBool() and self.healthStatus ~= AW2_DEAD) then
			phys:ComputeShadowControl(move)
		else
			self.storedPos = Vector(0, 0, 0)
		end
	end
end