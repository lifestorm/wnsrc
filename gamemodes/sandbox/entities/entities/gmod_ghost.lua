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
DEFINE_BASECLASS( "base_gmodentity" )

ENT.Type = "anim"
ENT.PrintName = "Tool Ghost"

function ENT:Initialize()

	if ( SERVER ) then
		self:PhysicsInitBox( Vector( -4, -4, -4 ), Vector( 4, 4, 4 ) )
	end

end

function ENT:SetNetworkedBonePosition( i, Pos, Angle )

	self:SetNWVector( "Vector" .. i, Pos )
	self:SetNWAngle( "Angle" .. i, Angle )

end

function ENT:Draw( flags )

	-- Don't draw it if we're a ragdoll and haven't
	-- received all of the bone positions yet.
	if ( self:GetModelPhysBoneCount() > 1 and !self:GetNWVector( "Vector0", false ) ) then
		return
	end

	BaseClass.Draw( self, flags )

end
