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
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.Slot = 0
	SWEP.SlotPos = 5
	SWEP.DrawAmmo = false
	SWEP.PrintName = "Vortibeam Advanced"
	SWEP.DrawCrosshair = true

	game.AddParticles("particles/Vortigaunt_FX.pcf")
end

PrecacheParticleSystem("wn_vortigaunt_beam_colored")
PrecacheParticleSystem("wn_vortigaunt_beam_charge_colored")
PrecacheParticleSystem("wn_vortigaunt_hand_glow_colored")

SWEP.Instructions = "Primary Fire: Fire your beam."
SWEP.Purpose = "Immediately kills the target that you fire it at."
SWEP.Contact = ""
SWEP.Author	= "RJ"
SWEP.Category = "Vort Swep"

player_manager.AddValidModel("vortigaunt_arms2", "models/willardnetworks/vortigaunt.mdl")
player_manager.AddValidHands("vortigaunt_arms2", "models/willardnetworks/c_arms_vortigaunt.mdl", 1, "0000000")

SWEP.ViewModel 				= Model("models/willardnetworks/c_arms_vortigaunt.mdl")
SWEP.ViewModelFOV = 110
SWEP.WorldModel = ""

SWEP.Spawnable     			= true
SWEP.AdminSpawnable			= false

SWEP.Primary.IsAlwaysRaised = true
SWEP.IsAlwaysRaised = true
SWEP.HoldType = "pistol"

SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 40
SWEP.Primary.Delay = 3
SWEP.Primary.Ammo = ""

SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 0
SWEP.Secondary.Ammo	= ""

SWEP.vePerShot = 100
SWEP.aoeRadius = 90

if CLIENT then
	SWEP.NextAllowedPlayRateChange = 0
end

-- Called when the SWEP is deployed.
function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)

	local viewModel = self:GetOwner():GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end
end

-- Called when the SWEP is holstered.
function SWEP:Holster(switchingTo)
	self:SendWeaponAnim(ACT_VM_HOLSTER)

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

function SWEP:OnRemove()
	if (SERVER) then
		if self:GetOwner() then
			if self:GetOwner().DrawViewModel then
				self:GetOwner():DrawViewModel(true)
			end
		end
	end

	if (self:GetOwner().broomModel) then
		if (self:GetOwner().broomModel:IsValid()) then
			self:GetOwner().broomModel:Remove()
		end
	end

	return true
end

-- Called when the SWEP is initialized.
function SWEP:Initialize()
	self.Primary.Damage = ix.config.Get("advancedBeamDamage", 200)
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:CanPrimaryAttack()
	local v = hook.Run("TFA_CanSecondaryAttack", self)
	if v ~= nil then
		return v
	end

	if !self:GetOwner():HasVortalEnergy(self.vePerShot) then
		return false
	end

	if (!self:GetOwner():GetCharacter():CanDoAction("vort_beam_shoot")) then
		return false
	end

	if (!self:GetOwner():OnGround()) then
		return false
	end

	return true
end

-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack()
	if (self.bIsFiring or !self:CanPrimaryAttack()) then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.bIsFiring = true

	if (CLIENT) then
		-- Adjust these variables to move the viewmodel's position
		self.IronSightsPos  = Vector(-10, -5, -70)
		self.IronSightsAng  = Vector(-5, 100, 10)
	end

	self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	local chargeSound = CreateSound(self:GetOwner(), "npc/vort/attack_charge.wav")
	chargeSound:SetSoundLevel( 60 )
	chargeSound:Play()

	ParticleEffectAttach("wn_vortigaunt_hand_glow_colored", PATTACH_POINT_FOLLOW, self:GetOwner(), self:GetOwner():LookupAttachment("leftclaw"))
	ParticleEffectAttach("wn_vortigaunt_hand_glow_colored", PATTACH_POINT_FOLLOW, self:GetOwner(), self:GetOwner():LookupAttachment("rightclaw"))
	util.ScreenShake( self:GetOwner():GetPos(), 8, 15, 1, 1000 )
	timer.Simple(0.6, function()
		chargeSound:Stop()

		if (!IsValid(self)) then return end

		if (!IsValid(self:GetOwner())) then
			self.bIsFiring = false
			return
		end

		local v = hook.Run("TFA_CanSecondaryAttack", self)
		if v ~= nil then
			self.bIsFiring = false
			return v
		end
		self:GetOwner():EmitSound("npc/vort/attack_shoot.wav", 40)

		local forward = self:GetOwner():EyeAngles():Forward()
		local tr = util.QuickTrace(self:GetOwner():EyePos(), (forward + VectorRand(-0.005, 0.005)) * 5000, self:GetOwner())

		self:GetOwner():StopParticles()

		local leftClaw = self:GetOwner():LookupAttachment("leftclaw")

		if (leftClaw) then
			util.ParticleTracerEx(
				"wn_vortigaunt_beam_colored", self:GetOwner():GetAttachment(leftClaw).Pos, tr.HitPos, true, self:GetOwner():EntIndex(), leftClaw
			)
		end

		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos + Vector(0, 0, 50) )
		util.Effect( "vortibeam_explosion", effectdata )

		if SERVER then
			self:GetOwner():TakeVortalEnergy(self.vePerShot)
		end

		if (SERVER) then
			local damage = self:GetOwner():GetCharacter():GetSkillScale("vort_beam") + self.Primary.Damage
			local damageInfo = DamageInfo()
			if self:GetOwner():GetNetVar("ixVortExtract") then
				damage = 999
			end
			damageInfo:SetAttacker(self:GetOwner())
			damageInfo:SetInflictor(self)
			damageInfo:SetDamage(damage)
			damageInfo:SetDamageForce(forward * damage)
			damageInfo:SetReportedPosition(leftClaw and self:GetOwner():GetAttachment(leftClaw).Pos or self:GetOwner():EyePos())
			damageInfo:SetDamagePosition(tr.HitPos)
			damageInfo:SetDamageType(DMG_SHOCK)
			for k, target in pairs(ents.FindInSphere(tr.HitPos, self.aoeRadius)) do
				if target != self:GetOwner() and
				target:IsPlayer() or
				target:IsNextBot() or
				target:IsNPC() or
				target:IsVehicle() then
					if !target:IsLineOfSightClear(tr.HitPos) then
						continue
					end

					if (damageInfo:GetDamage() >= 1) then
						target:TakeDamageInfo(damageInfo)
					end

					if (target:IsPlayer()) then
						hook.Run("PostCalculatePlayerDamage", target, damageInfo, HITGROUP_GENERIC)

						ix.log.AddRaw("[VORT] ".. self:GetOwner():Name() .." has damaged " .. target:Name() .. " dealing " .. damage .. " with vortadvancedbeam")

						ix.chat.Send(self:GetOwner(), "vortbeam", "has damaged " .. target:Name() .. ", dealing " .. damage .. " points of damage", false, attacker)
					end

					if (target:IsNPC()) then
						ix.log.AddRaw("[VORT] ".. self:GetOwner():Name() .." has damaged " .. target:GetClass() .. ", dealing " .. damage .. " with vortadvancedbeam")
					end

					if (target:IsNPC() or target:IsPlayer()) then
						self:GetOwner():GetCharacter():DoAction("vort_beam_shoot")
					end
				end
			end
		end

		if (CLIENT) then
			for k, target in pairs(ents.FindInSphere(tr.HitPos, self.aoeRadius)) do
				if target != self:GetOwner() and
				target:IsPlayer() or
				target:IsNextBot() or
				target:IsNPC() or
				target:IsVehicle() then
					if !target:IsLineOfSightClear(tr.HitPos) then
						continue
					end

					if (target:IsPlayer()) then
						--chat.AddText(Color(217, 83, 83), "You have damaged " .. target:Name() .. ", dealing " .. self:GetOwner():GetCharacter():GetSkillScale("vort_beam") + self.Primary.Damage .. " points of damage.")
					end

					if (target:IsNPC()) then
						--chat.AddText(Color(217, 83, 83), "You have damaged " .. target:GetClass() .. ", dealing " .. self:GetOwner():GetCharacter():GetSkillScale("vort_beam") + self.Primary.Damage .. " points of damage.")
					end
				end
			end
		end

		local viewModel = self:GetOwner():GetViewModel()
		timer.Simple(1, function()
			if (IsValid(viewModel)) then
				viewModel:SetPlaybackRate(1)
				viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
				if CLIENT then
					self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
				end

				self.IronSightsPos  = Vector(-5, -5, -105)
				self.IronSightsAng  = Vector(35, 15, 10)
			end
		end)

		timer.Simple(2, function()
			-- Adjust these variables to move the viewmodel's position
			self.IronSightsPos  = Vector(-5, -5, -55)
		end)

		hook.Run("TFA_PostSecondaryAttack", self)

		if (SERVER) then
			self:GetOwner():GetCharacter():DoAction("vort_beam_practice")
		end

		self.bIsFiring = false
	end)
	hook.Run("TFA_PostSecondaryAttack", self, true)
end

function SWEP:SecondaryAttack()
	return false
end