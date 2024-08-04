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

ENT.Type            = "anim"

ENT.PrintName = "Tires"
ENT.Author = "Luna"
ENT.Information = "Fixes FakePhysics Wheels"
ENT.Category = "[LVS]"

ENT.Spawnable		= true
ENT.AdminOnly		= false

if SERVER then
	function ENT:SpawnFunction( ply, tr, ClassName )
		if not tr.Hit then return end

		local ent = ents.Create( ClassName )
		ent:SetPos( tr.HitPos + tr.HitNormal * 10 )
		ent:SetAngles( Angle(90,0,0) )
		ent:Spawn()
		ent:Activate()

		return ent
	end

	function ENT:OnTakeDamage( dmginfo )
	end

	function ENT:Initialize()	
		self:SetModel( "models/props_vehicles/tire001c_car.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:PhysWake()
	end

	function ENT:Fix( entity )
		if self.AlreadyUsed or not IsValid( entity ) then return end

		if entity:GetClass() ~= "gmod_sent_vehicle_fphysics_wheel" then return end

		local Damaged = entity:GetDamaged()

		if not Damaged then return end

		entity:FixTire()
		entity:EmitSound("npc/dog/dog_servo1.wav")

		self.AlreadyUsed = true

		SafeRemoveEntityDelayed( self, 0 )
	end

	function ENT:PhysicsCollide( data, physobj )
		self:Fix( data.HitEntity )
	end

	function ENT:Think()
		return false
	end

	return
end

function ENT:Draw( flags )
	self:DrawModel( flags )
end
