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

ENT.Spawnable       = false
ENT.AdminSpawnable  = false

if CLIENT then
	local Mat = CreateMaterial("simfphysdamage", "VertexLitGeneric", {["$basetexture"] = "models/player/player_chrome1"})
	
	function ENT:Draw()
		self:DrawModel()
		
		render.ModelMaterialOverride( Mat )
		render.SetBlend( 0.8 )
		self:DrawModel()
		
		render.ModelMaterialOverride()
		render.SetBlend(1)
	end
end

if SERVER then
	function ENT:Initialize()
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		if not IsValid( self:GetPhysicsObject() ) then
			self.RemoveTimer = 0
			
			self:Remove()
			return
		end

		local PhysObj = self:GetPhysicsObject()

		PhysObj:EnableMotion(true)
		PhysObj:Wake()

		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS ) 
		self:SetRenderMode( RENDERMODE_TRANSALPHA )
		
		local fxPos = self:LocalToWorld( self:OBBCenter() )

		timer.Simple( 0.05, function()
			if not IsValid( self ) then return end
			if self.MakeSound == true then
				self:Ignite( 30 )
			else
				local GibDir = Vector( math.Rand(-1,1), math.Rand(-1,1), 1.5 ):GetNormalized()
				PhysObj:SetVelocityInstantaneous( GibDir * math.random(800,1300)  )

				local effectdata = EffectData()
					effectdata:SetOrigin( fxPos )
					effectdata:SetStart( PhysObj:GetMassCenter() )
					effectdata:SetEntity( self )
					effectdata:SetScale( math.Rand(0.3,0.7) )
					effectdata:SetMagnitude( math.Rand(0.5,2.5) )
				util.Effect( "lvs_firetrail", effectdata )
			end
			
		end)

		self.RemoveDis = GetConVar("sv_simfphys_gib_lifetime"):GetFloat()

		self.RemoveTimer = CurTime() + self.RemoveDis
	end

	function ENT:Think()	
		if self.RemoveTimer < CurTime() then
			if self.RemoveDis > 0 then
				self:Remove()
			end
		end
		
		self:NextThink( CurTime() + 0.2 )
		return true
	end

	function ENT:OnRemove()
		if self.FireSound then
			self.FireSound:Stop()
		end
	end

	function ENT:OnTakeDamage( dmginfo )
		self:TakePhysicsDamage( dmginfo )
	end

	function ENT:PhysicsCollide( data, physobj )
	end
end