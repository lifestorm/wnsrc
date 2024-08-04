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

ENT.Type = "anim"
ENT.PrintName = "World Anchor"

if ( CLIENT ) then return end

function ENT:Initialize()

	self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )

	self:SetNotSolid( true )
	self:SetNoDraw( true )
	self:DrawShadow( false )

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:EnableMotion( false )
		phys:EnableCollisions( false )
	end

	self:SetUnFreezable( true )

end
