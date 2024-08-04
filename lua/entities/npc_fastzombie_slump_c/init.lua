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

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	if fastzombie_sleeping_a_max_count and fastzombie_sleeping_a_max_count >= 4 then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_fastzombie_slump_a" )
	self:SetModel( "models/hunter/plates/plate.mdl" )
	ent:SetPos( SpawnPos )
	ent:SetModel( "" )
	ent:SetColor( 255, 255, 255, 0 )
	ent:Spawn()
	ent:Activate()
	
	if !fastzombie_sleeping_a_max_count then
		fastzombie_sleeping_a_max_count = 1
	else
		fastzombie_sleeping_a_max_count = fastzombie_sleeping_a_max_count +1
	end

	return ent
end

function ENT:Initialize()
	self.fastzombie = ents.Create( "npc_fastzombie" )
	self.fastzombie:SetPos( self:GetPos() )
	self.fastzombie:SetKeyValue( "spawnflags", "646" )
	self.fastzombie:Spawn()
	self.fastzombie:Activate()
	local fastzombie_name = "fastzombie" .. self.fastzombie:EntIndex()
	self.fastzombie:SetName( fastzombie_name )
	self.fastzombie:Fire( "AddOutput", "OnDamaged " .. fastzombie_name .. "_wake_seq:BeginSequence::0:1", 0 )
	
	self.fastzombie_seq = ents.Create( "scripted_sequence" )
	self.fastzombie_seq:SetName( fastzombie_name .. "_wake_seq" )
	self.fastzombie_seq:SetKeyValue( "spawnflags", "624" )
	self.fastzombie_seq:SetKeyValue( "m_iszEntity", fastzombie_name )
	self.fastzombie_seq:SetKeyValue( "m_iszIdle", "slump_a" )
	self.fastzombie_seq:SetKeyValue( "m_fMoveTo", "4" )
	self.fastzombie_seq:SetKeyValue( "m_iszPlay", "slumprise_c" )

	self.fastzombie_seq:SetPos( self:GetPos() )
	self.fastzombie_seq:Spawn()
	self.fastzombie_seq:Activate()
	self.fastzombie_seq:SetParent( self.fastzombie )
end

function ENT:Think()
	if !IsValid( self.fastzombie ) or self.fastzombie:Health() <= 0 then
		self:Remove()
	end

	if !IsValid(self.fastzombie_seq) or self.animation_played then return end
	for k, v in pairs( ents.FindInSphere( self.fastzombie:GetPos(), 64 ) ) do
		if v and IsValid( v ) and v:IsPlayer() then
			self.fastzombie_seq:Fire( "BeginSequence", "", 0 )
			local rand = math.random( 1, 2 )
			if rand == 1 then
				self.fastzombie:EmitSound( "npc/fast_zombie/fz_alert_close1.wav", 100, 100 )
			else
				self.fastzombie:EmitSound( "npc/fast_zombie/fz_scream1.wav", 100, 100 )
			end
			self.animation_played = true
		end
	end
end

function ENT:OnTakeDamage()
end

/*---------------------------------------------------------
Name: OnRemove
Desc: Called just before entity is deleted
//-------------------------------------------------------*/
function ENT:OnRemove()
	if IsValid( self.fastzombie ) then
		self.fastzombie:Remove()
	end
	if IsValid( self.fastzombie_seq ) then
		self.fastzombie_seq:Remove()
	end

end