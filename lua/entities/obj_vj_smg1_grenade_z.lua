--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_grenade_rifle"
ENT.PrintName		= "Rifle Grenade"
ENT.Author 			= "Zippy"
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.RadiusDamage = 40

local trail_lifetime = 1.5
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetNoDraw(true)

    self.grenadeprop = ents.Create("prop_dynamic")
    self.grenadeprop:SetModel("models/weapons/ar2_grenade.mdl")
    self.grenadeprop:SetPos(self:GetPos())
    self.grenadeprop:SetAngles(self:GetAngles())
    self.grenadeprop:SetParent(self)
    self.grenadeprop:Spawn()

    util.SpriteTrail(self.grenadeprop, 0, Color(50,50,50), true, 12, 0, trail_lifetime, 0.008, "sprites/xbeam2")
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
    self.grenadeprop:SetAngles(self:GetVelocity():Angle())
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects()
    self.grenadeprop:SetParent(nil)
    self.grenadeprop:SetPos(self:GetPos())
    self.grenadeprop:SetNoDraw(true)

    local grenprop = self.grenadeprop
    timer.Simple(trail_lifetime, function() if IsValid(grenprop) then grenprop:Remove() end end)

	local effectData = EffectData()
	effectData:SetOrigin(self:GetPos())
	util.Effect( "Explosion", effectData )

    ParticleEffect("vj_explosion1", self:GetPos(), Angle(0,0,0), nil)

	local ExplosionLight1 = ents.Create("light_dynamic")
	ExplosionLight1:SetKeyValue("brightness", "4")
	ExplosionLight1:SetKeyValue("distance", "300")
	ExplosionLight1:SetLocalPos(self:GetPos())
	ExplosionLight1:SetLocalAngles( self:GetAngles() )
	ExplosionLight1:Fire("Color", "255 150 0")
	ExplosionLight1:SetParent(self)
	ExplosionLight1:Spawn()
	ExplosionLight1:Activate()
	ExplosionLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(ExplosionLight1)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------