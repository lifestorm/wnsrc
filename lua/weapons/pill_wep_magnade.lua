--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

//SWEP.base = "weapon_base"

AddCSLuaFile()

SWEP.ViewModel = "models/weapons/v_magnade.mdl"
SWEP.WorldModel = ""

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"//"Grenade"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Magnades"
SWEP.Category = "Pill Pack Weapons"
SWEP.Slot=4

function SWEP:Initialize()
	self:SetHoldType("grenade")
end

function SWEP:PrimaryAttack()
	//if self:Ammo1()==0 then return end
	if CLIENT then return end
	local g = ents.Create("pill_proj_magnade")
	g:SetPos(self.Owner:EyePos()+self.Owner:EyeAngles():Forward()*100)
	g:SetVelocity(self.Owner:EyeAngles():Forward()*100)
	g:Spawn()
	g.attacker=self.Owner
	g:GetPhysicsObject():SetVelocity(self.Owner:EyeAngles():Forward()*800)

	self:SendWeaponAnim(ACT_VM_THROW)
	timer.Simple(.5,function() if !IsValid(self) then return end self:SendWeaponAnim(ACT_VM_DRAW) end)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	self:SetNextPrimaryFire(CurTime() + 1.5)
end

function SWEP:SecondaryAttack()
end