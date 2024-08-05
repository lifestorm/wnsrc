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
--Made by SkyLight http://steamcommunity.com/id/_I_I_I_I_I/, had to be indented manually because copy/pasta from github didn't.  Copy pastad of Parakeet's code.  
--Formatted and edited by Parakeet
SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.PrintName = "Professional Rifle"
SWEP.Category = "Pill Pack Weapons"
SWEP.Slot = 3

function SWEP:Initialize()
    self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    local bullet = {}
    bullet.Num = 1
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(.001, .001, 0)
    bullet.Tracer = 1
    bullet.TracerName = "Tracer"
    bullet.Force = 9001
    bullet.Damage = 9001
    self:ShootEffects()
    self.Owner:FireBullets(bullet)
    self.Owner:EmitSound("birdbrainswagtrain/pro" .. math.random(11) .. ".wav")
    self.Owner:EmitSound("weapons/awp/awp1.wav")
    self:TakePrimaryAmmo(1)
end

function SWEP:Reload()
    if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

    if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
        self:EmitSound("weapons/awp/awp_bolt.wav")
        self:DefaultReload(ACT_VM_RELOAD)
        self.ReloadingTime = CurTime() + 2
        self:SetNextPrimaryFire(CurTime() + 2)
    end
end
