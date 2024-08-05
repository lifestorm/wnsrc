--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local mat_glow = Material( "models/mana/c_wirefade" )
local mat_wraith

local cmd_matproxy = GetConVar( "hl2_mana_matproxy" )
local cmd_matproxy_target = GetConVar( "hl2_mana_matproxy_target" )

EFFECT.FxMaterial = ""
EFFECT.Time = 1
EFFECT.Color = Vector( 5, 3, 54 )

function EFFECT:Init( data )

	if ( GetConVar( "mat_fillrate" ):GetBool() ) then return end

	self.LifeTime = CurTime() + self.Time
	
	local ent = data:GetEntity()
	
	if ( !IsValid( ent ) ) then return end
	if ( !ent:GetModel() ) then return end
	
	self.FxMaterial = mat_glow
			
	local pEntity = LocalPlayer()

	if ( ent == pEntity ) && ( !pEntity:ShouldDrawLocalPlayer() ) then
		self.ViewModel = true
		self.FxMaterial = Material( "models/mana/c_wirefade_noz" )
			
		ent = pEntity:GetHands()
	end
	
	self.ParentEntity = ent
	
	self:SetModel( ent:GetModel() )	
	self:SetPos( ent:GetPos() )
	self:SetAngles( ent:GetAngles() )
	self:SetParent( ent )
	
	self.ParentEntity.RenderOverride = self.RenderParent
	self.ParentEntity.SpawnEffect = self

end

function EFFECT:Think( )

	if ( !IsValid( self.ParentEntity ) ) then return false end
	
	local PPos = self.ParentEntity:GetPos()
	self:SetPos( PPos + (EyePos() - PPos):GetNormal() )
	
	if ( self.LifeTime > CurTime() ) then
		return true
	end
	
	self.ParentEntity.RenderOverride = nil
	self.ParentEntity.SpawnEffect = nil
			
	return false
	
end

function EFFECT:Render()

end

function EFFECT:RenderOverlay( entity )
		
	local fFraction = ( self.LifeTime - CurTime() ) / self.Time
	
	fFraction = math.Clamp( fFraction, 0, 1 )
	
	local origin = entity:GetPos()

	local EyeNormal = origin - EyePos()
	local Distance = EyeNormal:Length()
	EyeNormal:Normalize()
	
	local offset 
	
	if ( self.ViewModel ) then
		local iFov = 54
		local wEntity = LocalPlayer():GetActiveWeapon()
		if ( IsValid( wEntity ) && wEntity.ViewModelFOV ) then
			iFov = wEntity.ViewModelFOV
		end
		
		local add = -54 + iFov
		add = add * 0.3
		
		offset = EyeAngles():Forward() * ( 12 - add )
	else
		offset = EyeNormal * Distance * 0.01
	end
	
	local Pos = EyePos() + offset

	local clr = self.Color

	local fFlicker = math.sin( CurTime() * math.random( 16, 64 ) ) * fFraction
	local fStrength = fFraction * 2 ^ ( ( 1 - fFraction ) * 2 )
		
	local owner = entity
	local dlight = DynamicLight( owner:EntIndex() )
	if ( dlight ) then
		local vLightOrigin = owner:GetBonePosition( 1 )
		if ( !vLightOrigin ) then 
			vLightOrigin = owner:GetPos()
		end
		
		dlight.pos = vLightOrigin
		dlight.r = math.min( clr.r * 10, 255 )
		dlight.g = math.min( clr.g * 10, 255 )
		dlight.b = math.min( clr.b * 10, 255 )
		dlight.brightness = 6 * fFraction 
		dlight.Size = 140 * fFraction * fFlicker
		dlight.Decay = 768
		dlight.Style = 1
		dlight.DieTime = CurTime() + self.Time
	end

	self.FxMaterial:SetFloat( "$emissiveBlendStrength", fStrength )
	self.FxMaterial:SetVector( "$emissiveBlendTint", clr * fFlicker )
	self.FxMaterial:SetVector( "$emissiveBlendScrollVector", Vector( -2, 2 ) )
	self.FxMaterial:SetFloat( "$FleshBorderWidth", 3 + 2 * ( 1 - fStrength ) )
	
	cam.Start3D( Pos, EyeAngles() )
		render.MaterialOverride( self.FxMaterial )
		render.SetBlend( fFlicker * 0.1 )
		entity:DrawModel()
		render.MaterialOverride()
		render.SetColorModulation( 1, 1, 1 )
		render.SetBlend( 1 )
	cam.End3D()

end

function EFFECT:RenderParent()
	
	self:DrawModel()
	
	self.SpawnEffect:RenderOverlay( self )

end