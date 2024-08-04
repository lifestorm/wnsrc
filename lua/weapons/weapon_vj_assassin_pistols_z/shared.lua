--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_vj_9mmpistol"
SWEP.PrintName = "Assassin Pistol"
SWEP.Author = "Zippy"
SWEP.Category = "VJ Base"

SWEP.MadeForNPCsOnly = true
SWEP.NPC_NextPrimaryFire 		= 0.13 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 1 -- This is added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy

SWEP.Primary.Damage = 5 -- Damage
SWEP.Primary.ClipSize			= 42 -- Max amount of bullets per clip
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
    self:SetNoDraw(true)

    local own = self:GetOwner()
    if IsValid(own) && own:GetClass() == "npc_vj_overwatch_assassin_z" then
        own:SetBodygroup(1, 1)
    end

    self.ShootAttachment = 4
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttackEffects() -- Return false to disable the base effects
	local own = self:GetOwner()
	
	if GetConVar("vj_wep_nomuszzleflash"):GetInt() == 0 then
        ParticleEffectAttach(VJ_PICK(self.PrimaryEffects_MuzzleParticles), PATTACH_POINT_FOLLOW, own, self.ShootAttachment)
    end

    if SERVER && GetConVar("vj_wep_nomuszzleflash_dynamiclight"):GetInt() == 0 then
        local muzzlelight = ents.Create("light_dynamic")
        muzzlelight:SetKeyValue("brightness", self.PrimaryEffects_DynamicLightBrightness)
        muzzlelight:SetKeyValue("distance", self.PrimaryEffects_DynamicLightDistance)
        muzzlelight:SetLocalAngles(own:GetAngles())
        muzzlelight:SetLocalPos( own:GetAttachment(self.ShootAttachment).Pos )
        muzzlelight:Fire("Color", self.PrimaryEffects_DynamicLightColor.r.." "..self.PrimaryEffects_DynamicLightColor.g.." "..self.PrimaryEffects_DynamicLightColor.b)
        muzzlelight:Spawn()
        muzzlelight:Activate()
        muzzlelight:Fire("TurnOn", "", 0)
        muzzlelight:Fire("Kill", "", 0.07)
        self:DeleteOnRemove(muzzlelight)
    end

	-- if GetConVar("vj_wep_nobulletshells"):GetInt() == 0 then
	-- 	local shelleffect = EffectData()
	-- 	shelleffect:SetEntity(own)
	-- 	shelleffect:SetStart()
    --     shelleffect:SetNormal(own:GetAimVector())
	-- 	shelleffect:SetAttachment(self.ShootAttachment)
	-- 	util.Effect(self.PrimaryEffects_ShellType, shelleffect)
	-- end

    return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_AfterShoot()
    if self.ShootAttachment == 3 then
        self.ShootAttachment = 4
    elseif self.ShootAttachment == 4 then
        self.ShootAttachment = 3
    end

    self:SetClip1(self.Primary.ClipSize)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomBulletSpawnPosition() -- Return a position to override the bullet spawn position
    return self:GetOwner():GetAttachment(self.ShootAttachment).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------