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
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.PrintName = "Translocator"
SWEP.Category = "Pill Pack Weapons"
SWEP.Slot = 3

function SWEP:SetupDataTables()
    self:NetworkVar("Entity", 1, "Target")
end

function SWEP:Initialize()
    self:SetHoldType("ar2")
end

function SWEP:PrimaryAttack()
    if CLIENT or not IsValid(self:GetTarget()) then return end
    local tr = self.Owner:GetEyeTrace()
    self:GetTarget():SetPos(tr.HitPos + tr.HitNormal * self:GetTarget():BoundingRadius())

    if self:GetTarget():GetPhysicsObjectCount() > 0 then
        self:GetTarget():PhysWake()
    end

    if self:GetTarget():IsPlayer() then
        self:GetTarget():SetMoveType(MOVETYPE_WALK)
    end

    self:GetTarget():EmitSound("beams/beamstart5.wav")
    self.Owner:EmitSound("npc/roller/mine/rmine_taunt1.wav")
    self:SetNextPrimaryFire(CurTime() + 1)
end

function SWEP:SecondaryAttack()
    if CLIENT then return end
    local tr = self.Owner:GetEyeTrace()

    if not tr.Entity or tr.Entity:IsWorld() or not hook.Call("PhysgunPickup", GAMEMODE, self.Owner, tr.Entity) then
        self.Owner:EmitSound("buttons/button10.wav")
        self:SetTarget(nil)

        return
    end

    self:EmitSound("buttons/blip1.wav")
    self:SetTarget(tr.Entity)
end

function SWEP:DrawHUD()
    if not IsValid(self:GetTarget()) then return end

    halo.Render{
        Ents = {self:GetTarget()},
        Color = Color(0, 255, 255),
        BlurX = 10,
        BlurY = 10,
        DrawPasses = 2,
        IgnoreZ = true
    }
end
