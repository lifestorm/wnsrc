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
SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.PrintName = "Annabelle"
SWEP.Category = "Pill Pack Weapons"
SWEP.Slot = 3

function SWEP:Initialize()
    self:SetHoldType("crossbow")
end

function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    local bullet = {}
    bullet.Num = 1
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(.01, .01, 0)
    bullet.Tracer = 1
    bullet.TracerName = "Tracer"
    bullet.Force = 5
    bullet.Damage = 50
    self:ShootEffects()
    self.Owner:FireBullets(bullet)
    self:EmitSound("weapons/shotgun/shotgun_fire6.wav")
    self:TakePrimaryAmmo(1)
    self:SetNextPrimaryFire(CurTime() + .5)
end

function SWEP:Reload()
    if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

    if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
        self:EmitSound("weapons/shotgun/shotgun_reload1.wav")
        self:DefaultReload(ACT_VM_RELOAD)
        self.ReloadingTime = CurTime() + 1
        self:SetNextPrimaryFire(CurTime() + 1)
    end
end
