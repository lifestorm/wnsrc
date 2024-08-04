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
SWEP.ViewModel = "models/weapons/c_toolgun.mdl"
SWEP.WorldModel = "models/weapons/w_toolgun.mdl"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.PrintName = "Morph Gun"

function SWEP:SetupDataTables()
    self:NetworkVar("String", 1, "Form")
    self:NetworkVar("Int", 1, "Mode")
end

function SWEP:Initialize()
    self:SetHoldType("pistol")
    self.nextreload = 0
end

function SWEP:PrimaryAttack()
    if SERVER and self.Owner:IsAdmin() then
        local ply = self.Owner:GetEyeTrace().Entity

        if ply:GetClass() == "pill_ent_phys" then
            ply:EmitSound("npc/manhack/bat_away.wav")
            ply = ply:GetPillUser()
        elseif not ply:IsPlayer() then
            return
        else
            ply:EmitSound("npc/manhack/bat_away.wav")
        end

        local mode = self:GetMode()

        if mode == 0 then
            mode = "force"
        elseif mode == 1 then
            mode = "lock-life"
        elseif mode == 2 then
            mode = "lock-map"
        elseif mode == 3 then
            mode = "lock-perma"
        end

        pk_pills.apply(ply, self:GetForm(), mode)
        self.Owner:EmitSound("weapons/airboat/airboat_gun_energy2.wav")
    end
end

function SWEP:SecondaryAttack()
    if SERVER and self.Owner:IsAdmin() then
        local ply = self.Owner:GetEyeTrace().Entity

        if ply:GetClass() == "pill_ent_phys" then
            ply:EmitSound("npc/manhack/bat_away.wav")
            ply = ply:GetPillUser()
        elseif not ply:IsPlayer() then
            return
        else
            ply:EmitSound("npc/manhack/bat_away.wav")
        end

        pk_pills.restore(ply, true)
        self.Owner:EmitSound("weapons/airboat/airboat_gun_energy2.wav")
    end
end

function SWEP:Reload()
    if SERVER and self.Owner:IsAdmin() and CurTime() > self.nextreload then
        local n = self:GetMode()

        if n < 3 then
            n = n + 1
        else
            n = 0
        end

        if n == 0 then
            self.Owner:ChatPrint("FORCE MODE: Players will be forced to morph but can still change back.")
        elseif n == 1 then
            self.Owner:ChatPrint("LIFELOCK MODE: The player will be locked in the pill until they die.")
        elseif n == 2 then
            self.Owner:ChatPrint("MAPLOCK MODE: The player will be locked in the pill until the map changes.")
        elseif n == 3 then
            self.Owner:ChatPrint("PERMALOCK MODE: Players will be locked in the pill forever.")
        end

        self:SetMode(n)
        self.nextreload = CurTime() + 1
        self.Owner:EmitSound("weapons/slam/mine_mode.wav")
    end
end

function SWEP:OnDrop()
    self:Remove()
end

if CLIENT then
    local matScreen = Material("models/weapons/v_toolgun/screen")

    function SWEP:ViewModelDrawn(ent)
        local matBg = Material("pills/" .. self:GetForm() .. ".png")
        matScreen:SetTexture("$basetexture", matBg:GetTexture("$basetexture"))
        local n = self:GetMode()
        local color

        if n == 0 then
            color = Color(0, 255, 0)
        elseif n == 1 then
            color = Color(255, 255, 0)
        elseif n == 2 then
            color = Color(255, 150, 0)
        elseif n == 3 then
            color = Color(255, 0, 0)
        end

        local ap = ent:GetAttachment(ent:LookupAttachment("muzzle"))
        cam.Start3D(EyePos(), EyeAngles())
        render.SetMaterial(Material("sprites/light_glow02_add"))
        render.DrawSprite(ap.Pos, 20, 20, color)
        cam.End3D()
    end
end
