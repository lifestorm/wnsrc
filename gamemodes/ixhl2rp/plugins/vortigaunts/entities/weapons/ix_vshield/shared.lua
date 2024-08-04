--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.Slot          = 1
	SWEP.SlotPos       = 5
	SWEP.DrawAmmo      = false
	SWEP.PrintName	   = "Vortishield"
	SWEP.DrawCrosshair = true
end

SWEP.Purpose    = "Allows you to create a shield from Vortal Energies"
SWEP.Contact    = ""
SWEP.Author     = "Adolphus (& M!NT)"
SWEP.WorldModel = ""
SWEP.HoldType   = "fist"
SWEP.Category   = "Vort Swep"

SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic   = false
SWEP.Primary.ClipSize    = -1
SWEP.Primary.Ammo        = ""
SWEP.Spawnable     		 = true
SWEP.AdminSpawnable		 = false

SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic   = false
SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.Ammo	       = ""

SWEP.ViewModelFOV   = 110
SWEP.ViewModel 	    = Model("models/willardnetworks/c_arms_vortigaunt.mdl")
SWEP.IsAlwaysRaised = true

SWEP.vePerUse = 20

if CLIENT then
	SWEP.NextAllowedPlayRateChange = 0
end

function SWEP:Initialize()
	return
end

function SWEP:Deploy()
	local owner = self:GetOwner()
	if (!IsValid(owner)) then
		return
	end

	local viewModel = owner:GetViewModel()

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
		local owner = self:GetOwner()
		if (self.vSHIELD and !IsValid(owner)) then
			self.vSHIELD:Remove()
			return
		end

		local viewModel = owner:GetViewModel()

		if (IsValid(viewModel) and self.NextAllowedPlayRateChange < CurTime()) then
			viewModel:SetPlaybackRate(1)
		end
	end
end

function SWEP:Holster()
	local owner = self:GetOwner()
	if (!IsValid(owner)) then
		return
	end

	local viewModel = owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_HOLSTER)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end
 
	return true
end

function SWEP:ValidateShield()
	for _, shield in ipairs(ents.FindByClass("ix_vortshield")) do
		if shield:GetOwner() == self:GetOwner() then
			shield:Remove()
		end
	end
end
-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack()
	local owner = self:GetOwner()

	if (!owner:GetCharacter():HasFlags("q")) then
		if CLIENT then
		 	owner:NotifyLocalized("You do not have the required (q) flag!")
		end
		return
	end

	local percentage = self.vePerUse / 100
	percentage = percentage * ix.config.Get("additionalVortalEnergyDrainPerPointOfArmor", 1)
	if !self.Owner:HasVortalEnergy(self.vePerUse + (percentage * self.Owner:Armor())) then
		return
	end

	if (SERVER) then
		if (!IsValid(self.vSHIELD)) then
			self:SetNextPrimaryFire(CurTime() + ix.config.Get("VortShieldRecharge", 20))

			self.Owner:TakeVortalEnergy(self.vePerUse + (percentage * self.Owner:Armor()))

			self:ValidateShield()

			self.vSHIELD = ents.Create("ix_vortshield")
			self.vSHIELD:SetPos(owner:GetPos() + owner:GetUp()*45)
			self.vSHIELD:Spawn()
			self.vSHIELD:Activate() 
			self.vSHIELD:SetOwner(owner)
			self.vSHIELD:FollowBone(owner, 11)
			self.vSHIELD:SetLocalAngles(Angle(0, 0, -90))
			self.vSHIELD:SetLocalPos(Vector(-20, 10, 0))
			owner:EmitSound("npc/vort/health_charge.wav")
		end
	end

	return false
end
function SWEP:SecondaryAttack()
	if (SERVER) then
		if IsValid(self.vSHIELD) then
			self:GetOwner():EmitSound("npc/vort/health_charge.wav")
			self.vSHIELD:Remove()
		end
		self:SetNextSecondaryFire(CurTime() + 4)
	end
	return false
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
