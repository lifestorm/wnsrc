--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if (CLIENT) then
	SWEP.Slot = 5
	SWEP.SlotPos = 5
	SWEP.DrawAmmo = false
	SWEP.PrintName = "Channel Energy"
	SWEP.DrawCrosshair = true
end

SWEP.Author					= "Fruity"
SWEP.Instructions 			= "Primary Fire: Heal/Overcharge Lock"
SWEP.Purpose 				= "To heal people or overcharge combine equipment."
SWEP.Contact 				= ""

SWEP.Primary.IsAlwaysRaised = true
SWEP.IsAlwaysRaised = true
SWEP.Category				= "Vort Swep"
SWEP.Slot					= 5
SWEP.SlotPos				= 5
SWEP.Weight					= 5
SWEP.Spawnable     			= true
SWEP.AdminSpawnable			= false
SWEP.ViewModel 				= Model("models/willardnetworks/c_arms_vortigaunt.mdl")
SWEP.ViewModelFOV = 110
SWEP.WorldModel 			= ""
SWEP.HoldType = "smg"

if CLIENT then
	SWEP.NextAllowedPlayRateChange = 0
end

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.vePerHP = 0.5

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end


function SWEP:Deploy()
	if (!IsValid(self:GetOwner())) then
		return
	end

	if (SERVER) then
		if (!self.HealSound) then
		self.HealSound = CreateSound( self.Weapon, "npc/vort/health_charge.wav" )
		end
	end

	local viewModel = self:GetOwner():GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end
end

if (CLIENT) then
	function SWEP:Think()
		if (!IsValid(self:GetOwner())) then
			return
		end

		local viewModel = self:GetOwner():GetViewModel()

		if (IsValid(viewModel) and self.NextAllowedPlayRateChange < CurTime()) then
			viewModel:SetPlaybackRate(1)
		end
	end
end

function SWEP:Holster()
	if (!IsValid(self:GetOwner())) then
		return
	end

	local viewModel = self:GetOwner():GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_HOLSTER)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end

	return true
end

if (CLIENT) then
	function SWEP:PreDrawViewModel(viewModel, weapon, client)
		local hands = player_manager.TranslatePlayerHands(player_manager.TranslateToPlayerModelName(client:GetModel()))

		if (hands and hands.model) then
			viewModel:SetModel(hands.model)
			viewModel:SetSkin(hands.skin)
			viewModel:SetBodyGroups(hands.body)
		end
	end

	function SWEP:DoDrawCrosshair(x, y)
		surface.SetDrawColor(255, 255, 255, 66)
		surface.DrawRect(x - 2, y - 2, 4, 4)
	end

	-- Adjust these variables to move the viewmodel's position
	SWEP.IronSightsPos  = Vector(-5, -5, -55)
	SWEP.IronSightsAng  = Vector(35, 15, 10)

	function SWEP:GetViewModelPosition(EyePos, EyeAng)
		local Mul = 1.0

		local Offset = self.IronSightsPos

		if (self.IronSightsAng) then
			EyeAng = EyeAng * 1

			EyeAng:RotateAroundAxis(EyeAng:Right(), 	self.IronSightsAng.x * Mul)
			EyeAng:RotateAroundAxis(EyeAng:Up(), 		self.IronSightsAng.y * Mul)
			EyeAng:RotateAroundAxis(EyeAng:Forward(),   self.IronSightsAng.z * Mul)
		end

		local Right 	= EyeAng:Right()
		local Up 		= EyeAng:Up()
		local Forward 	= EyeAng:Forward()

		EyePos = EyePos + Offset.x * Right * Mul
		EyePos = EyePos + Offset.y * Forward * Mul
		EyePos = EyePos + Offset.z * Up * Mul

		return EyePos, EyeAng
	end
end

function SWEP:DispatchEffect(EFFECTSTR)
	local pPlayer=self:GetOwner()
	if !pPlayer then return end
	local view
	if CLIENT then view=GetViewEntity() else view=pPlayer:GetViewEntity() end

	if ( !pPlayer:IsNPC() and view:IsPlayer() ) then
		ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer, pPlayer:LookupAttachment( "leftclaw" ) )
	else
		ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer, pPlayer:LookupAttachment( "leftclaw" ) )
	end
end


function SWEP:PrimaryAttack()
	if (!self:GetOwner():Alive()) then return false end
	if (!self:GetOwner():GetCharacter():IsVortigaunt()) then return false end

	if (!self:GetOwner():GetCharacter():CanDoAction("vort_channel")) then return false end

	local eye = self:GetOwner():GetEyeTrace()
	if (!eye.Entity:IsPlayer()) and (eye.Entity:GetClass() != "prop_ragdoll" and eye.Entity:GetClass() != "ix_combinelock" and eye.Entity:GetClass() != "ix_combinelock_cmru" and eye.Entity:GetClass() != "ix_combinelock_cwu" and eye.Entity:GetClass() != "ix_combinelock_dob" and eye.Entity:GetClass() != "ix_combinelock_moe") then return end
	if (eye.Entity:GetClass() == "prop_ragdoll" and !eye.Entity.ixPlayer) then return end

	local target = eye.Entity
	if (!IsValid(target)) then
		return false
	end

	if (self:GetOwner():Health() <= 50) then
		if (SERVER) then
			self:GetOwner():NotifyLocalized("You are too weak to channel your energy!")
		end

		return
	end

	if (IsValid(target.ixPlayer)) then
		target = target.ixPlayer
	end

	if (target:GetPos():DistToSqr(self:GetOwner():GetShootPos()) > 105 * 105) then return end

	if (target:IsPlayer()) then
		if (target:Health() >= target:GetMaxHealth()) then
			if (SERVER) then
				self:GetOwner():NotifyLocalized("The target is perfectly healthy!")
			end

			return
		end

		if (target:GetCharacter() and target:GetCharacter():GetBleedout()) then
			if target:GetCharacter().SetBleedout then
				target:GetCharacter():SetBleedout(-1)
			end
		end
	end

	self:SetNextPrimaryFire( 10 )
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )

	if (CLIENT) then
		-- Adjust these variables to move the viewmodel's position
		self.IronSightsPos  = Vector(0, -5, -55)
		self.IronSightsAng  = Vector(35, 15, 10)
	end
	local healAmount = self:GetOwner():GetCharacter():GetSkillScale("vort_heal_amount")
	local veToApply = healAmount * self.vePerHP
	local percentage = self.vePerHP / 100
	percentage = percentage * ix.config.Get("additionalVortalEnergyDrainPerPointOfArmor", 1)
	percentage = healAmount * percentage

	if !self:GetOwner():HasVortalEnergy(veToApply + (percentage * self:GetOwner():Armor())) then
		self:GetOwner():NotifyLocalized("You don't have enough vortal energy!")
		return
	end
	if (SERVER) then
		self:GetOwner():ForceSequence("heal_start", function()
			self:DispatchEffect("vortigaunt_charge_token")
			self:GetOwner():EmitSound( "npc/vort/health_charge.wav", 100, 150, 1, CHAN_AUTO )
			self:SendWeaponAnim( ACT_VM_RELOAD )
			self:GetOwner():ForceSequence("heal_cycle", function()
				if (!self:GetOwner():Alive()) then return end
				if (target:GetPos():DistToSqr(self:GetOwner():GetShootPos()) <= 105 * 105) then
					if (target:IsPlayer()) then
						self:GetOwner():TakeVortalEnergy(veToApply + (percentage * self:GetOwner():Armor()))
						target:SetHealth(math.Clamp(target:Health() + healAmount, 0, target:GetMaxHealth()))

						ix.log.AddRaw("[VORT] ".. self:GetOwner():Name() .." has healed " .. target:Name())
					else
						ix.combineNotify:AddNotification("LOG:// Bio-Restrictor " .. (target:GetLocked() and "unlocked" or "locked") .. " by %USER-ERROR%", nil, self:GetOwner())

						target:SetLocked(!target:GetLocked())

						self:GetOwner():GetCharacter():DoAction("vort_channel")
					end
				else
					self:GetOwner():StopSound("npc/vort/health_charge.wav")
				end

				self:GetOwner():StopParticles()
				self:SendWeaponAnim( ACT_VM_PULLBACK )
				self:GetOwner():ForceSequence("heal_end", function()
					self:SetNextPrimaryFire( 0 )
					self:GetOwner():StopSound("npc/vort/health_charge.wav")
					self:GetOwner():Freeze(false)

					self:GetOwner().lastVortHeal = CurTime() + 30

					local viewModel = self:GetOwner():GetViewModel()

					if (IsValid(viewModel)) then
						viewModel:SetPlaybackRate(1)
						viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
					end
				end)
			end)
		end)

		self:GetOwner():Freeze(true)
	end

	if (CLIENT) then
		timer.Simple(8, function()
		-- Adjust these variables to move the viewmodel's position
			self.IronSightsPos = Vector(-5, -5, -55)
			self.IronSightsAng = Vector(35, 15, 10)
		end)
	end
end

function SWEP:SecondaryAttack()
	return false
end