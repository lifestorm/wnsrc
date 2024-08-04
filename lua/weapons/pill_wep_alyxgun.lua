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
SWEP.WorldModel = "models/weapons/w_alyx_gun.mdl"
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.PrintName = "Alyx's Gun"
SWEP.Category = "Pill Pack Weapons"
SWEP.Slot = 1

function SWEP:SetupDataTables()
    self:NetworkVar("Int", 0, "Mode")
end

function SWEP:Initialize()
    self:SetHoldType("pistol")
    self:SetMode(0)
end

function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    local spread = .01

    if self:GetMode() == 0 then
        spread = .02
    elseif self:GetMode() == 1 then
        spread = .06
    end

    local bullet = {}
    bullet.Num = 1
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(spread, spread, 0)
    bullet.Tracer = 1
    bullet.TracerName = "Tracer"
    bullet.Force = 5

    if self:GetMode() == 0 then
        bullet.Damage = 10
    elseif self:GetMode() == 1 then
        bullet.Damage = 5
    else
        bullet.Damage = 50
    end

    self:ShootEffects()
    self.Owner:FireBullets(bullet)

    if SERVER then
        sound.Play("npc/sniper/echo1.wav", self:GetPos(), 100, 100, 1)

        if self:GetMode() == 0 then
            sound.Play("weapons/pistol/pistol_fire2.wav", self:GetPos(), 100, 100, 1)
        elseif self:GetMode() == 1 then
            sound.Play("weapons/smg1/smg1_fireburst1.wav", self:GetPos(), 100, 100, 1)
        else
            sound.Play("weapons/357/357_fire2.wav", self:GetPos(), 100, 100, 1)
        end
    end

    self:TakePrimaryAmmo(1)
    local delay = 1

    if self:GetMode() == 0 then
        delay = .3
    elseif self:GetMode() == 1 then
        delay = .1
    end

    self:SetNextPrimaryFire(CurTime() + delay)
end

function SWEP:SecondaryAttack()
    if CLIENT then return end

    if self:GetMode() < 2 then
        self:SetMode(self:GetMode() + 1)
    else
        self:SetMode(0)
    end

    if self:GetMode() == 0 then
        self.Owner:ChatPrint("Pistol Mode")
        self:SetHoldType("pistol")
        self:PillAnim("weapon_pistol")
    elseif self:GetMode() == 1 then
        self.Owner:ChatPrint("SMG Mode")
        self:SetHoldType("smg")
        self:PillAnim("weapon_smg")
    elseif self:GetMode() == 2 then
        self.Owner:ChatPrint("Rifle Mode")
        self:SetHoldType("ar2")
        self:PillAnim("weapon_rifle")
    end

    self.Owner:EmitSound("weapons/smg1/switch_single.wav")
end

function SWEP:Reload()
    if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

    if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
        self:EmitSound("weapons/pistol/pistol_reload1.wav")
        self:DefaultReload(ACT_VM_RELOAD)
        self.ReloadingTime = CurTime() + 1
        self:SetNextPrimaryFire(CurTime() + 1)
    end
end

function SWEP:PillAnim(anim)
    if IsValid(self.pill_proxy) then
        self.pill_proxy:ResetSequence(self.pill_proxy:LookupSequence(anim))
    end
end
