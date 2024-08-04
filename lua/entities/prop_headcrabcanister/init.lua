--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self.Entity:SetModel("models/props_combine/headcrabcannister01b.mdl")

	self.Entity:SetCollisionBounds(Vector()*-2, Vector()*2)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WORLD )
	self.Entity:DrawShadow(true)
	self.Entity:SetColor( Color(255,255,255,150) )
	self.Entity:SetRenderMode( RENDERMODE_TRANSALPHA )
	local phys = self.Entity:GetPhysicsObject()
		if phys and phys:IsValid() then 
			phys:Sleep()
			phys:EnableCollisions(false)
			phys:EnableMotion(false)
			phys:EnableGravity(false)
		end
	constraint.NoCollide(self.Entity, game.GetWorld())
end

function ENT:Launch()
	local headcrabcanister = ents.Create("env_headcrabcanister")
		headcrabcanister:SetKeyValue( 'targetname', 'env_headcrabcanister' )
		headcrabcanister:SetKeyValue( 'angles', self:GetAngles().p, self:GetAngles().y, self:GetAngles().r )
		headcrabcanister:SetKeyValue( 'Damage', self.settings["damage"] )
		headcrabcanister:SetKeyValue( 'DamageRadius' , self.settings["damage_radius"] )
		headcrabcanister:SetKeyValue( 'FlightSpeed', self.settings["speed"] )
		headcrabcanister:SetKeyValue( 'FlightTime' , self.settings["flight_time"] )
		headcrabcanister:SetKeyValue( 'SmokeLifetime', self.settings["smoke"] )
		headcrabcanister:SetKeyValue( 'StartingHeight', self.settings["height"] )
		headcrabcanister:SetKeyValue( 'HeadcrabType', self.settings["headcrab_type"] )
		headcrabcanister:SetKeyValue( 'HeadcrabCount', self.settings["headcrab_count"] )
		headcrabcanister:Fire( "Spawnflags", "8192", 0)
		headcrabcanister:Fire( "AddOutput", "OnImpacted headcrabcanister Kill", "", 2, 1 )
		headcrabcanister:SetCollisionGroup(0)
		headcrabcanister:SetPos( self:GetPos() )
		self.Entity:DeleteOnRemove(headcrabcanister)
		headcrabcanister:Spawn()
		headcrabcanister:Activate()
		
	headcrabcanister:Fire( "FireCanister", "", 1 )
		
end