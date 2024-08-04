--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local mat_stealth = Material( "models/mana/c_player_stealth" )
local stealth = "models/mana/c_player_stealth"

function EFFECT:Init( data )

	if ( GetConVar( "mat_fillrate" ):GetBool() ) then return end

	self.Time = 0.5
	self.LifeTime = CurTime() + self.Time
	
	local ent = data:GetEntity()
	
	if ( !IsValid( ent ) ) then return end
	if ( !ent:GetModel() ) then return end
	
	self.ParentEntity = ent
	
	self:SetModel( ent:GetModel() )	
	self:SetPos( ent:GetPos() )
	self:SetAngles( ent:GetAngles() )
	self:SetParent( ent )
	
	mat_old = self.ParentEntity:GetMaterial()

	self.ParentEntity.SpawnEffect = self
	
	if ( ent == LocalPlayer():GetHands() ) then
		self.ViewModel = true
	end
	
	self.ParentRenderMode = self.ParentEntity:GetRenderMode()
	
	self.ParentEntity:SetRenderMode( RENDERMODE_TRANSALPHADD )

end

local itFallBack = Material( "models/black" ):GetTexture( "$bumpmap" )

function EFFECT:Think( )

	if ( !IsValid( self.ParentEntity ) ) then return false end
	
	local PPos = self.ParentEntity:GetPos()
	self:SetPos( PPos + (EyePos() - PPos):GetNormal() )

	self:DrawModel()
	
	self.ParentEntity:SetMaterial( stealth )
	
	if ( self.LifeTime > CurTime() ) then
		return true
	end
	
	self.ParentEntity:SetMaterial( "" )
	
	self.ParentEntity:SetRenderMode( self.ParentRenderMode )

	self.ParentEntity.RenderOverride = nil
	self.ParentEntity.SpawnEffect = nil
	
	return false
	
end

function EFFECT:Render()

	self:RenderOverlay( self.ParentEntity )

end

function EFFECT:RenderOverlay( entity )

	if ( !IsValid( entity ) ) && !( self:IsPlayer() || self:GetOwner():IsPlayer() ) then return end

	local Fraction = ( self.LifeTime - 0.1 - CurTime() ) / self.Time
	Fraction = math.Clamp( Fraction, 0, 1 )

	local EyeNormal = entity:GetPos() - EyePos()
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local offset 
	
	if ( self.ViewModel ) then
		offset = EyeAngles():Forward() * 10
	else
		offset = EyeNormal * Distance * 0.001
	end
	
	local Pos = EyePos() + offset
	local amount = math.Clamp( 1 - Fraction, 0, 1 )
	local scale = 0 + amount

	render.SetBlend( scale, scale, scale )

	cam.Start3D( Pos, EyeAngles() )
		entity:SetMaterial("")
		entity:DrawModel()
	cam.End3D()

end