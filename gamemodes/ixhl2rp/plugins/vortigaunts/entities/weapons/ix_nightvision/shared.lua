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
	SWEP.Slot = 1
	SWEP.SlotPos = 5
	SWEP.DrawAmmo = false
	SWEP.PrintName = "Vortilight"
	SWEP.DrawCrosshair = true
end

SWEP.Purpose = "Allows you to create green light around your character."
SWEP.Contact = ""
SWEP.Author	= "Adolphus"

SWEP.WorldModel = ""
SWEP.HoldType = "fist"

SWEP.Category = "Vort Swep"

SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = ""

SWEP.Spawnable     			= true
SWEP.AdminSpawnable			= false

SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Ammo	= ""

SWEP.ViewModelFOV = 110
SWEP.ViewModel 				= Model("models/willardnetworks/c_arms_vortigaunt.mdl")
SWEP.IsAlwaysRaised = true
SWEP.vePerUse = 1

if CLIENT then
	SWEP.NextAllowedPlayRateChange = 0
end

function SWEP:Initialize()
end

function SWEP:Deploy()
	if (!IsValid(self:GetOwner())) then
		return
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

-- A function to set whether the SWEP is activated.
function SWEP:SetActivated(bActivated)
	self.Activated = bActivated
end

-- A function to get whether the SWEP is activated.
function SWEP:IsActivated()
	return self.Activated
end

-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack()
	if (SERVER) then
		local ent = ents.Create("ix_nvlight")

		if (!self.Activated) then
			local percentage = self.vePerUse / 100
			if !self:GetOwner():HasVortalEnergy(self.vePerUse + (percentage * self:GetOwner():Armor())) then
				return
			end
			self:GetOwner():TakeVortalEnergy(self.vePerUse + (percentage * self:GetOwner():Armor()))
			self:GetOwner():EmitSound("npc/vort/health_charge.wav")
			self.Activated = true

			ent:SetOwner(self:GetOwner())
			ent:SetParent(self:GetOwner())
			ent:SetPos(self:GetOwner():GetPos())
			ent:SetOwnerVariable(self:GetOwner())
		else
			self:GetOwner():EmitSound("npc/vort/health_charge.wav")
			self.Activated = false
			ent:RemoveLight(self:GetOwner())
		end

	end

	self:SetNextPrimaryFire(CurTime() + 4)

	return false
end

function SWEP:OnRemove()
	if (CLIENT or !IsValid(self:GetOwner())) then return end

	local worldmodel = ents.FindInSphere(self:GetOwner():GetPos(), 1);

	for _, v in pairs(worldmodel) do
		if (v:GetClass() == "ix_nvlight" and v:GetOwner() == self:GetOwner()) then
			v:Remove()
		end
	end
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

-- Called when the player attempts to secondary fire.
function SWEP:SecondaryAttack() end