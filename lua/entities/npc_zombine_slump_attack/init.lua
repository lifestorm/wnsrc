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
	if zombine_sleeping_max_count and zombine_sleeping_max_count >= 4 then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_zombine_slump_attack" )
	ent:SetPos( SpawnPos )
	ent:SetModel( "" )
	ent:SetColor( 255, 255, 255, 0 )
	ent:Spawn()
	ent:Activate()
	
	if !zombine_sleeping_max_count then
		zombine_sleeping_max_count = 1
	else
		zombine_sleeping_max_count = zombine_sleeping_max_count +1
	end

	return ent
end

function ENT:Initialize()
	self.zombine = ents.Create( "npc_zombine" )
	self:SetModel( "models/hunter/plates/plate.mdl" )
	self.zombine:SetPos( self:GetPos() )
	self.zombine:SetKeyValue( "spawnflags", "644" )
	self.zombine:Spawn()
	self.zombine:Activate()
	local zombine_name = "zombine" .. self.zombine:EntIndex()
	self.zombine:SetName( zombine_name )
	self.zombine:Fire( "AddOutput", "OnDamaged " .. zombine_name .. "_wake_seq:BeginSequence::0:1", 0 )
	
	self.zombine_seq = ents.Create( "scripted_sequence" )
	self.zombine_seq:SetName( zombine_name .. "_wake_seq" )
	self.zombine_seq:SetKeyValue( "spawnflags", "624" )
	self.zombine_seq:SetKeyValue( "m_iszEntity", zombine_name )
	self.zombine_seq:SetKeyValue( "m_iszIdle", "slump_a" )
	self.zombine_seq:SetKeyValue( "m_fMoveTo", "4" )
	self.zombine_seq:SetKeyValue( "m_iszPlay", "slumprise_a_attack" )
	self.zombine_seq:SetPos( self:GetPos() )
	self.zombine_seq:Spawn()
	self.zombine_seq:Activate()
	self.zombine_seq:SetParent( self.zombine )
end

function ENT:Think()
	if !IsValid( self.zombine ) or self.zombine:Health() <= 0 then
		self:Remove()
	end

	if !IsValid(self.zombine_seq) or self.animation_played then return end
	for k, v in pairs( ents.FindInSphere( self.zombine:GetPos(), 64 ) ) do
		if v and IsValid( v ) and v:IsPlayer() then
			self.zombine_seq:Fire( "BeginSequence", "", 0 )
			self.zombine:EmitSound( "npc/zombine/zombine_alert" .. math.random(1,7) .. ".wav", 100, 100 )
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
	if IsValid( self.zombine ) then
		self.zombine:Remove()
	end
	if IsValid( self.zombine_seq ) then
		self.zombine_seq:Remove()
	end

end