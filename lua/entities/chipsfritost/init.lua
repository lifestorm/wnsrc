--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction( ply, tr )
	
	if !tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 1

	local ent = ents.Create( "ChipsFritosT" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self.Entity:SetModel("models/FoodNHouseholdItems/chipsfritostwists.mdl")
 
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	
	self.Index = self.Entity:EntIndex()
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use(activator)
	activator:SetHealth(activator:Health()+20)
	self.Entity:Remove()
	activator:EmitSound("eating_and_drinking/chips.wav", 50, 100)

end
