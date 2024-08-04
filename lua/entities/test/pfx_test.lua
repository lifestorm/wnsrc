--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- CAT** PlaceableFX::[Fire, Smoke, Weather, Tech, Nature, Other]
-- ENT** PFX:[*]
AddCSLuaFile()     
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "PFX:Test"
ENT.Author			= "npc_teslacybertruck_driver"
ENT.Information		= ""
ENT.Category		= "PlaceableFX::Test"
ENT.Spawnable		= true
ENT.AdminOnly		= false
if SERVER then
    function ENT:Initialize()
	    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	    self:SetNoDraw(true)
	    self:DrawShadow(false)
	    self:PhysicsInit( SOLID_VPHYSICS )
	    self:SetMoveType( MOVETYPE_VPHYSICS )
	    self:SetSolid( SOLID_VPHYSICS )
        ParticleEffectAttach( "[1]pfx_test", 1, self, 1 )
    end
end


