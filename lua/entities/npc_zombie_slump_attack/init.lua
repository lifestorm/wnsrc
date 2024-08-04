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
	if zombie_sleeping_max_count and zombie_sleeping_max_count >= 4 then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_zombie_slump_attack" )
	ent:SetPos( SpawnPos )
	ent:SetModel( "" )
	ent:SetColor( 255, 255, 255, 0 )
	ent:Spawn()
	ent:Activate()
	
	if !zombie_sleeping_max_count then
		zombie_sleeping_max_count = 1
	else
		zombie_sleeping_max_count = zombie_sleeping_max_count +1
	end

	return ent
end

function ENT:Initialize()
	self.zombie = ents.Create( "npc_zombie" )
	self:SetModel( "models/hunter/plates/plate.mdl" )
	self.zombie:SetPos( self:GetPos() )
	self.zombie:SetKeyValue( "spawnflags", "644" )
	self.zombie:Spawn()
	self.zombie:Activate()
	local zombie_name = "zombie" .. self.zombie:EntIndex()
	self.zombie:SetName( zombie_name )
	self.zombie:Fire( "AddOutput", "OnDamaged " .. zombie_name .. "_wake_seq:BeginSequence::0:1", 0 )
	
	self.zombie_seq = ents.Create( "scripted_sequence" )
	self.zombie_seq:SetName( zombie_name .. "_wake_seq" )
	self.zombie_seq:SetKeyValue( "spawnflags", "624" )
	self.zombie_seq:SetKeyValue( "m_iszEntity", zombie_name )
	self.zombie_seq:SetKeyValue( "m_iszIdle", "slump_a" )
	self.zombie_seq:SetKeyValue( "m_fMoveTo", "4" )
	self.zombie_seq:SetKeyValue( "m_iszPlay", "slumprise_a_attack" )
	self.zombie_seq:SetPos( self:GetPos() )
	self.zombie_seq:Spawn()
	self.zombie_seq:Activate()
	self.zombie_seq:SetParent( self.zombie )
end

function ENT:Think()
	if !IsValid( self.zombie ) or self.zombie:Health() <= 0 then
		self:Remove()
	end

	if !IsValid(self.zombie_seq) or self.animation_played then return end
	for k, v in pairs( ents.FindInSphere( self.zombie:GetPos(), 64 ) ) do
		if v and IsValid( v ) and v:IsPlayer() then
			self.zombie_seq:Fire( "BeginSequence", "", 0 )
			self.zombie:EmitSound( "npc/zombie/zombie_alert" .. math.random(1,3) .. ".wav", 100, 100 )
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
	if IsValid( self.zombie ) then
		self.zombie:Remove()
	end
	if IsValid( self.zombie_seq ) then
		self.zombie_seq:Remove()
	end

end