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

if (CLIENT) then
	SWEP.PrintName = "CV-2000 Stun Baton"
	SWEP.Slot = 0
	SWEP.SlotPos = 5
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Category = "HL2 RP"
SWEP.Author = "Chessnut"
SWEP.Instructions = "Primary Fire: Stun.\nALT + Primary Fire: Toggle stun.\nSecondary Fire: Push/Knock."
SWEP.Purpose = "Hitting things and knocking on doors."
SWEP.Drop = false

SWEP.HoldType = "melee"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.ViewModelFOV = 47
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "melee"

SWEP.ViewTranslation = 4

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.7

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = Model("models/weapons/c_wn_stunstick.mdl")
SWEP.WorldModel = Model("models/weapons/w_wn_stunbaton.mdl")

SWEP.UseHands = true
SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.FireWhenLowered = true

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVarNotify( "Activated", self.OnActiveToggle )
end

function SWEP:Precache()
	util.PrecacheSound("physics/wood/wood_crate_impact_hard3.wav")
end

function SWEP:StartStunstickSound()
	if (SERVER) then
		local client = self:GetOwner()

		self.patch1 = CreateSound(client, "wn_stunstick/stunstick_idle_"..math.random(1, 4)..".wav")
		self.patch1:SetSoundLevel(40)
		self.patch1:Play()

		self:SoundTimer()
	end
end

function SWEP:StopStunstickSound()
	if (SERVER) then
		local patchToStop
		if (self.patch1 and self.patch1:IsPlaying()) then
			patchToStop = self.patch1
		else
			patchToStop = self.patch2
		end

		if (!patchToStop) then return end

		patchToStop:FadeOut(1)
	end
end

-- for when someone primary fires or w/e
function SWEP:DuckStunstickSound(vol, delta)
	if (SERVER) then
		if (!delta) then
			delta = 0.5
		end

		if (!vol) then
			vol = 0.25
		end

		local patchToDuck = self.patch1 and self.patch1:IsPlaying() and self.patch1 or self.patch2
		if (!patchToDuck) then return end

		patchToDuck:ChangeVolume(vol, delta)
		timer.Simple(delta + 0.1, function()
			patchToDuck:ChangeVolume(1, delta)
		end)
	end
end



function SWEP:OnActiveToggle(name, old, new)
	if (new) then
		self:StartStunstickSound()
	else
		self:StopStunstickSound()
	end
end

function SWEP:SoundTimer()
	if (SERVER) then
		local client = self:GetOwner()

		local tName = "stunstick_idle_"..client:SteamID64().."_timer"

		if timer.Exists(tName) then timer.Remove(tName) end

		timer.Create(tName, 12, 0, function()
			if (!IsValid(client)) then
				timer.Remove(tName)
				return
			end

			if (!IsValid(self) or !self:GetActivated()) then
				return
			end

			local patchToStart
			local patchToStop
			if (self.patch1 and self.patch1:IsPlaying()) then
				patchToStart = self.patch2
				patchToStop = self.patch1
			else
				patchToStart = self.patch1
				patchToStop = self.patch2
			end

			if (!patchToStop) then
				timer.Remove(tName)
				return
			end

			patchToStop:FadeOut(1)

			patchToStart = CreateSound(client, "wn_stunstick/stunstick_idle_"..math.random(1, 4)..".wav")
			patchToStart:SetSoundLevel(40) -- maybe make this configurable idk
			patchToStart:Play()
			patchToStart:ChangeVolume( 0.1, 0 )
			patchToStart:ChangeVolume(1, 1)

			if (self.patch1 and self.patch1:IsPlaying()) then
				self.patch2 = patchToStart
			else
				self.patch1 = patchToStart
			end
		end)
	end
end

function SWEP:CreateWMParticle()
	if self.particle and self.particle:IsValid() then
		self.particle:StopEmissionAndDestroyImmediately()
	end

	self.particle = CreateParticleSystem(self, "wn_stunstick_fx", PATTACH_POINT_FOLLOW, 1, Vector(0, 0, 0))
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:OnRaised()
	self.lastRaiseTime = CurTime()
end

function SWEP:OnLowered()
	self:SetActivated(false)

	if (CLIENT) then
		if (self.particle and IsValid(self.particle)) then
			self.particle:StopEmissionAndDestroyImmediately()
		end
	end
end

function SWEP:Holster(nextWep)
	if self.patch1 and self.patch1:IsPlaying() or self.patch2 and self.patch2:IsPlaying() then
		self:StopStunstickSound()
	end

	self:OnLowered()

	return true
end

local STUNSTICK_GLOW_MATERIAL2 = Material("effects/blueflare1")
local STUNSTICK_GLOW_MATERIAL_NOZ = Material("sprites/light_glow02_add_noz")

function SWEP:DrawWorldModel()
	self:DrawModel()

	if (!self.particle or self.particle and !self.particle:IsValid()) then
		if self:GetActivated() then
			self:CreateWMParticle()
		end
	elseif (self.particle and self.particle:IsValid()) then
		if !self:GetActivated() then
			self.particle:StopEmissionAndDestroyImmediately()
		end
	end

	if (self:GetActivated()) then
		local size = math.Rand(2.0, 6.0)
		local glow = math.Rand(0.6, 0.8) * 255
		local color = Color(glow / 2, glow / 1.5, glow / 1.1)
		local attachment = self:GetAttachment(1)

		if (attachment) then
			local position = attachment.Pos

			render.SetMaterial(STUNSTICK_GLOW_MATERIAL2)
			render.DrawSprite(position, size * 2, size * 2, color)
		end
	end
end

local NUM_BEAM_ATTACHEMENTS = 9
local BEAM_ATTACH_CORE_NAME	= "sparkrear"

SWEP.nextSpark = 0

function SWEP:PostDrawViewModel()
	if (!self:GetActivated()) then
		return
	end

	local viewModel = LocalPlayer():GetViewModel()

	if (!IsValid(viewModel)) then
		return
	end

	cam.Start3D(EyePos(), EyeAngles())
		local size = math.Rand(3.0, 4.0)
		local color = Color(75, 100, 150, 50 + math.sin(RealTime() * 2)*20)

		STUNSTICK_GLOW_MATERIAL_NOZ:SetFloat("$alpha", color.a / 255)

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL_NOZ)

		local attachment = viewModel:GetAttachment(1)

		if (attachment) then
			render.DrawSprite(attachment.Pos, size * 10, size * 15, color)
		end

		for i = 1, NUM_BEAM_ATTACHEMENTS do
			attachment = viewModel:GetAttachment(viewModel:LookupAttachment("spark"..i.."a"))
			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end

			attachment = viewModel:GetAttachment(viewModel:LookupAttachment("spark"..i.."b"))
			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end
		end
	cam.End3D()

	local sparkAttachment = viewModel:GetAttachment(1)

	if self.nextSpark <= CurTime() then
		self.nextSpark = CurTime() + math.random(1, 10)

		local ef = EffectData()
		ef:SetOrigin(sparkAttachment.Pos)
		ef:SetMagnitude(math.random(1, 2))
		ef:SetScale(0.1)
		util.Effect("ElectricSpark", ef)

		self:EmitSound("wn_stunstick/spark".. math.random(1, 4) ..".wav", nil, math.random(80, 120))
	end

	if (self.particle and self.particle:IsValid() and self:GetActivated()) then
		self.particle:StopEmissionAndDestroyImmediately()
	end
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if (!self:GetOwner():IsWepRaised()) then
		return
	end

	if (self:GetOwner():KeyDown(IN_WALK)) then
		if (SERVER) then
			self:SetActivated(!self:GetActivated())

			local state = self:GetActivated()

			if (state) then
				self:GetOwner():EmitSound("Weapon_StunStick.Activate")
			else
				self:GetOwner():EmitSound("Weapon_StunStick.Deactivate")
			end

			local model = string.lower(self:GetOwner():GetModel())

			if (ix.anim.GetModelClass(model) == "metrocop") then
				self:GetOwner():ForceSequence(state and "activatebaton" or "deactivatebaton", nil, nil, true)
			end
		end

		if (CLIENT) then
			timer.Simple(0, function()
				if !(IsValid(self)) then return end
				if (self:GetActivated()) then
					self:CreateWMParticle()
				else
					if (self.particle and self.particle:IsValid()) then
						self.particle:StopEmissionAndDestroyImmediately()
					end
				end
			end)
		end

		return
	end


	local result = hook.Run("CanDoMeleeAttack", self)
	if (result == false) then
		return
	end

	if (self:GetActivated()) then
		self:DuckStunstickSound()
	end

	self:EmitSound("wn_stunstick/stunstick_swing".. math.random(1, 3) ..".wav")
	self:SendWeaponAnim(ACT_VM_HITCENTER)

	local damage = self.Primary.Damage

	if (self:GetActivated()) then
		damage = 10
	end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:GetOwner():ViewPunch(Angle(1, 0, 0.125))

	timer.Simple(0.1, function()
		if !IsValid(self) then return end
		self:GetOwner():LagCompensation(true)
			local data = {}
				data.start = self:GetOwner():GetShootPos()
				data.endpos = data.start + self:GetOwner():GetAimVector()*72
				data.filter = self:GetOwner()
			local trace = util.TraceLine(data)
		self:GetOwner():LagCompensation(false)

		if (SERVER and trace.Hit) then
			if (self:GetActivated()) then
				local effect = EffectData()
					effect:SetStart(trace.HitPos)
					effect:SetNormal(trace.HitNormal)
					effect:SetOrigin(trace.HitPos)
				util.Effect("StunstickImpact", effect, true, true)
			end

			self:GetOwner():EmitSound("wn_stunstick/stunstick_fleshhit".. math.random(1, 3) ..".wav")

			local entity = trace.Entity

			if (IsValid(entity)) then
				if (entity:IsPlayer()) then
					if (self:GetActivated()) then
						entity.ixStuns = (entity.ixStuns or 0) + 1

						timer.Simple(10, function()
							if (!entity.ixStuns) then return end
							entity.ixStuns = math.max(entity.ixStuns - 1, 0)
						end)
					end

					entity:ViewPunch(Angle(-20, math.random(-15, 15), math.random(-10, 10)))

					if (self:GetActivated() and entity.ixStuns > 2) then
						entity:SetRagdolled(true, 60)
						ix.log.Add(entity, "knockedOut", "hit by stunstick owned by "..self:GetOwner():GetName())
						entity.ixStuns = 0

						return
					end
				elseif (entity:IsRagdoll()) then
					damage = self:GetActivated() and 2 or 10
				end

				local damageInfo = DamageInfo()
					damageInfo:SetAttacker(self:GetOwner())
					damageInfo:SetInflictor(self)
					damageInfo:SetDamage(damage)
					damageInfo:SetDamageType(DMG_CLUB)
					damageInfo:SetDamagePosition(trace.HitPos)
					damageInfo:SetDamageForce(self:GetOwner():GetAimVector() * 10000)
				entity:DispatchTraceAttack(damageInfo, data.start, data.endpos)


			end
		end
	end)
end

function SWEP:SecondaryAttack()
	self:GetOwner():LagCompensation(true)
		local data = {}
			data.start = self:GetOwner():GetShootPos()
			data.endpos = data.start + self:GetOwner():GetAimVector()*72
			data.filter = self:GetOwner()
			data.mins = Vector(-8, -8, -30)
			data.maxs = Vector(8, 8, 10)
		local trace = util.TraceHull(data)
		local entity = trace.Entity
	self:GetOwner():LagCompensation(false)

	if (SERVER and IsValid(entity)) then
		local bPushed = false

		if (entity:IsDoor()) then
			if (hook.Run("PlayerCanKnockOnDoor", self:GetOwner(), entity) == false) then
				return
			end

			self:GetOwner():ViewPunch(Angle(-1.3, 1.8, 0))
			self:GetOwner():EmitSound("physics/wood/wood_crate_impact_hard3.wav")
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)

			self:SetNextSecondaryFire(CurTime() + 0.4)
			self:SetNextPrimaryFire(CurTime() + 1)
		elseif (entity:IsPlayer()) then
			local direction = self:GetOwner():GetAimVector() * (300 + (self:GetOwner():GetCharacter():GetAttribute("str", 0) * 3))
				direction.z = 0
			entity:SetVelocity(direction)

			hook.Run("PlayerPushedPlayer", self:GetOwner(), entity)

			bPushed = true
		else
			local physObj = entity:GetPhysicsObject()

			if (IsValid(physObj)) then
				physObj:SetVelocity(self:GetOwner():GetAimVector() * 180)
			end

			bPushed = true
		end

		if (bPushed) then
			self:SetNextSecondaryFire(CurTime() + 1.5)
			self:SetNextPrimaryFire(CurTime() + 1.5)
			self:GetOwner():EmitSound("Weapon_Crossbow.BoltHitBody")

			local model = string.lower(self:GetOwner():GetModel())

			if (ix.anim.GetModelClass(model) == "metrocop") then
				self:GetOwner():ForceSequence("pushplayer")
			end
		end
	end
end
