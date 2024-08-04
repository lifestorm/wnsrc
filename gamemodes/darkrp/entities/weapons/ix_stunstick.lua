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

SWEP.ViewModel = Model("models/weapons/c_stunstick.mdl")
SWEP.WorldModel = Model("models/weapons/w_stunbaton.mdl")

SWEP.UseHands = true
SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.FireWhenLowered = true

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function SWEP:Precache()
	util.PrecacheSound("physics/wood/wood_crate_impact_hard3.wav")
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:OnRaised()
	self.lastRaiseTime = CurTime()
end

function SWEP:OnLowered()
	self:SetActivated(false)
end

function SWEP:Holster(nextWep)
	self:OnLowered()

	return true
end

local STUNSTICK_GLOW_MATERIAL2 = Material("effects/blueflare1")
local STUNSTICK_GLOW_MATERIAL_NOZ = Material("sprites/light_glow02_add_noz")

function SWEP:DrawWorldModel()
	self:DrawModel()

	if (self:GetActivated()) then
		local size = math.Rand(4.0, 6.0)
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

		local attachment = viewModel:GetAttachment(viewModel:LookupAttachment(BEAM_ATTACH_CORE_NAME))

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

		return
	end


	local result = hook.Run("CanDoMeleeAttack", self)
	if (result == false) then
		return
	end

	self:EmitSound("Weapon_StunStick.Swing")
	self:SendWeaponAnim(ACT_VM_HITCENTER)

	local damage = self.Primary.Damage

	if (self:GetActivated()) then
		damage = 10
	end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:GetOwner():ViewPunch(Angle(1, 0, 0.125))

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

		self:GetOwner():EmitSound("Weapon_StunStick.Melee_HitWorld")

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
