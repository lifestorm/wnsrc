--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.HasShockAttack = false

ENT.HasItemDropsOnDeath = false
ENT.HasDeathRagdoll = false

ENT.HasExplosionAttack = true
ENT.ExplodeDist = 160
ENT.ExplodeDamage = 60


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RollerInit()
    if GetConVar("vj_zippycombines_explosiveroller_red"):GetInt() > 0 then
        self.MineColor = "255 0 0"
        self.MineSkin = 2
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("Hold W (forward key): Move")
    ply:ChatPrint("Hold MOUSE1 (primary attack key): Spikes (they don't do anything on the explosive rollermine)")
    ply:ChatPrint("Hold MOUSE2 (secondary attack key): Explode")
    ply:ChatPrint("Please don't use thirdperson, it's kinda broken.")

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)

    self:EmitSound("npc/roller/mine/rmine_explode_shock1.wav", 130, math.random(60, 70))

    local realisticRadius = true
    util.VJ_SphereDamage(self, self, self:GetPos(), self.ExplodeDist*2, self.ExplodeDamage, DMG_BLAST, true, realisticRadius)

    ParticleEffect("grenade_explosion_01", self:GetPos(), Angle(0,0,0), nil)
    ParticleEffect("Explosion_2_Chunks", self:GetPos(), Angle(0,0,0), nil)
	self:EmitSound( "Explo.ww2bomb", 130, 100)

    self:CreateGibEntity("obj_vj_gib","models/gibs/manhack_gib01.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/manhack_gib04.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/combine_turrets/floor_turret_gib2.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/scanner_gib02.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------