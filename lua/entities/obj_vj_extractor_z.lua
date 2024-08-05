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

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_grenade"
ENT.PrintName		= "Extractor"
ENT.Author 			= "Zippy"
ENT.Spawnable = false

ENT.Model = {"models/weapons/w_npcnade.mdl"}

ENT.RadiusDamageRadius = 325 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 50 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy

ENT.FussTime = 4.5
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

	self.StartTime = CurTime()
	self.NextBlip = CurTime()

	local light = ents.Create( "env_sprite" )
	light:SetKeyValue( "model","sprites/blueflare1.spr" )
	light:SetKeyValue( "rendercolor","255 0 0" )
	light:SetPos( self:GetAttachment(1).Pos )
	light:SetParent( self, 1 )
	light:SetKeyValue( "scale","0.12" )
	light:SetKeyValue( "rendermode","9" )
	light:Spawn()
	self:DeleteOnRemove(light)

	local dynlight = ents.Create( "light_dynamic" )
	dynlight:SetKeyValue("brightness", "0.5")
	dynlight:SetKeyValue("distance", "150")
	dynlight:SetKeyValue("style", "4")
	dynlight:SetPos( self:GetAttachment(1).Pos )
	dynlight:Fire("Color", "255 0 0")
	dynlight:Spawn()
	dynlight:SetParent( self, 1 )
	dynlight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(dynlight)

	util.SpriteTrail(self, 1, Color(255,0,0), true, 10, 0, 1.5, 0.2, "trails/laser")

	timer.Simple(self.FussTime,function() if IsValid(self) then self:DeathEffects() end end)
	timer.Create("VJ_Z_ExtractorBlipTimer", 0.4, 0, function() self:EmitSound("weapons/grenade/tick1.wav", 85, math.random(90, 110)) end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	timer.Remove("VJ_Z_ExtractorBlipTimer")
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------