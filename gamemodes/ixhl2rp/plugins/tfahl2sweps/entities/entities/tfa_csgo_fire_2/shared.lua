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
ENT.Base = "base_anim"
ENT.Spawnable = false
ENT.AdminSpawnable = false


function ENT:Draw()
	
end

function ENT:Initialize()
	self:SetNWBool("extinguished",false)
	if SERVER then
		self:SetModel( "models/weapons/tfa_csgo/w_eq_incendiarygrenade_thrown.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_NONE )
		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		self:DrawShadow( false )
	end
	ParticleEffect( "molotov_explosion", self:GetPos(), self:GetAngles() )
	self:EmitSound( "TFA_CSGO_Inferno.Loop" )
end

function ENT:Think()
	if self:GetNWBool("extinguished",true) then
		//ParticleEffect( "extinguish_fire", self:GetPos(), self:GetAngles() )
		if SERVER then
			self:Remove()
		end
	end
end

function ENT:OnRemove()
	self:EmitSound( "TFA_CSGO_Inferno.FadeOut" )
    self:StopSound( "TFA_CSGO_Inferno.Loop" )
end
