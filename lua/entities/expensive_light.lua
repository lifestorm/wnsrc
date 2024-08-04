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

DEFINE_BASECLASS( "base_light" )

ENT.Spawnable =	true
ENT.AdminOnly =	true

ENT.PrintName =	"Expensive Light"
ENT.Category =	"Render"

function ENT:SetupDataTables()

	self:NetworkVar( "Bool",	0,	"ActiveState",	{ KeyName = "activestate",	Edit = { type = "Boolean",					title = "Enable",	order = 1,	category = "Main" } } )
	self:NetworkVar( "Bool",	1,	"DrawHelper",	{ KeyName = "drawhelper",	Edit = { type = "Boolean",					title = "Draw Helper",	order = 9,	category = "Render" } } )
	self:NetworkVar( "Bool",	2,	"DrawSprite",	{ KeyName = "drawsprite",	Edit = { type = "Boolean",					title = "Draw Sprite",	order = 8,	category = "Render" } } )
	self:NetworkVar( "Bool",	3,	"LightWorld",	{ KeyName = "lightworld",	Edit = { type = "Boolean",					title = "Light World",	order = 6,	category = "Effect" } } )
	self:NetworkVar( "Bool",	4,	"Shadows",	{ KeyName = "shadows",		Edit = { type = "Boolean",					title = "Shadows",	order = 7,	category = "Effect" } } )
	self:NetworkVar( "Float",	0,	"Brightness",	{ KeyName = "brightness",	Edit = { type = "Float",	min = 0.01,	max = 40.95,	title = "Brightness",	order = 3,	category = "Light" } } )
	self:NetworkVar( "Float",	1,	"FarZ",		{ KeyName = "farz",		Edit = { type = "Float",	min = 32,	max = 2048,	title = "Size",		order = 5,	category = "Light" } } )
	self:NetworkVar( "Float",	2,	"NearZ",	{ KeyName = "nearz",		Edit = { type = "Float",	min = 2,	max = 16,	title = "Near Z",	order = 4,	category = "Light" } } )
	self:NetworkVar( "Vector",	0,	"LightColor",	{ KeyName = "lightcolor",	Edit = { type = "RGBColor",					title = "Color",	order = 2,	category = "Light" } } )

	if ( SERVER ) then

		self:SetActiveState( true )
		self:SetDrawHelper( true )
		self:SetDrawSprite( true )
		self:SetLightWorld( true )
		self:SetShadows( true )
		self:SetBrightness( 0.63 )
		self:SetFarZ( 512 )
		self:SetNearZ( 4 )
		self:SetLightColor( Vector( 255, 255, 255 ) )

		self:NetworkVarNotify( "ActiveState",	self.ActiveStateChanged )
		self:NetworkVarNotify( "LightWorld",	self.LightWorldChanged )
		self:NetworkVarNotify( "Shadows",	self.ShadowsChanged )
		self:NetworkVarNotify( "Brightness",	self.BrightnessChanged )
		self:NetworkVarNotify( "FarZ",		self.FarZChanged )
		self:NetworkVarNotify( "NearZ",		self.NearZChanged )
		self:NetworkVarNotify( "LightColor",	self.LightColorChanged )

	end

end

cleanup.Register( "advlights_expensive_lights" )

if ( SERVER ) then

	local function UpdateActiveState( L, new )

		if ( new ) then

			L:Input( "TurnOn", NULL, NULL, nil )

		else

			L:Input( "TurnOff", NULL, NULL, nil )

		end

	end

	function ENT:ActiveStateChanged( name, old, new )

		local L = self.FR

		if ( IsValid( L ) ) then

			UpdateActiveState( L, new )

		end

		L = self.BK

		if ( IsValid( L ) ) then

			UpdateActiveState( L, new )

		end

		L = self.RI

		if ( IsValid( L ) ) then

			UpdateActiveState( L, new )

		end

		L = self.LF

		if ( IsValid( L ) ) then

			UpdateActiveState( L, new )

		end

		L = self.UP

		if ( IsValid( L ) ) then

			UpdateActiveState( L, new )

		end

		L = self.DN

		if ( IsValid( L ) ) then

			UpdateActiveState( L, new )

		end

	end

	local function UpdateLightWorld( L, new )

		L:SetKeyValue( "lightworld", new )

	end

	function ENT:LightWorldChanged( name, old, new )

		new = self:BoolToString( new )

		local L = self.FR

		if ( IsValid( L ) ) then

			UpdateLightWorld( L, new )

		end

		L = self.BK

		if ( IsValid( L ) ) then

			UpdateLightWorld( L, new )

		end

		L = self.RI

		if ( IsValid( L ) ) then

			UpdateLightWorld( L, new )

		end

		L = self.LF

		if ( IsValid( L ) ) then

			UpdateLightWorld( L, new )

		end

		L = self.UP

		if ( IsValid( L ) ) then

			UpdateLightWorld( L, new )

		end

		L = self.DN

		if ( IsValid( L ) ) then

			UpdateLightWorld( L, new )

		end

	end

	local function UpdateShadows( L, new )

		L:SetKeyValue( "enableshadows", new )

	end

	function ENT:ShadowsChanged( name, old, new )

		new = self:BoolToString( new )

		local L = self.FR

		if ( IsValid( L ) ) then

			UpdateShadows( L, new )

		end

		L = self.BK

		if ( IsValid( L ) ) then

			UpdateShadows( L, new )

		end

		L = self.RI

		if ( IsValid( L ) ) then

			UpdateShadows( L, new )

		end

		L = self.LF

		if ( IsValid( L ) ) then

			UpdateShadows( L, new )

		end

		L = self.UP

		if ( IsValid( L ) ) then

			UpdateShadows( L, new )

		end

		L = self.DN

		if ( IsValid( L ) ) then

			UpdateShadows( L, new )

		end

	end

	local function UpdateBrightness( L, new )

		L:SetKeyValue( "lightcolor", new )

	end

	function ENT:BrightnessChanged( name, old, new )

		new = self:ColorIntensityToString( self:GetLightColor(), new * 100 )

		local L = self.FR

		if ( IsValid( L ) ) then

			UpdateBrightness( L, new )

		end

		L = self.BK

		if ( IsValid( L ) ) then

			UpdateBrightness( L, new )

		end

		L = self.RI

		if ( IsValid( L ) ) then

			UpdateBrightness( L, new )

		end

		L = self.LF

		if ( IsValid( L ) ) then

			UpdateBrightness( L, new )

		end

		L = self.UP

		if ( IsValid( L ) ) then

			UpdateBrightness( L, new )

		end

		L = self.DN

		if ( IsValid( L ) ) then

			UpdateBrightness( L, new )

		end

	end

	local function UpdateFarZ( L, new )

		L:SetKeyValue( "farz", new )

	end

	function ENT:FarZChanged( name, old, new )

		local L = self.FR

		if ( IsValid( L ) ) then

			UpdateFarZ( L, new )

		end

		L = self.BK

		if ( IsValid( L ) ) then

			UpdateFarZ( L, new )

		end

		L = self.RI

		if ( IsValid( L ) ) then

			UpdateFarZ( L, new )

		end

		L = self.LF

		if ( IsValid( L ) ) then

			UpdateFarZ( L, new )

		end

		L = self.UP

		if ( IsValid( L ) ) then

			UpdateFarZ( L, new )

		end

		L = self.DN

		if ( IsValid( L ) ) then

			UpdateFarZ( L, new )

		end

	end

	local function UpdateNearZ( L, new )

		L:SetKeyValue( "nearz", new )

	end

	function ENT:NearZChanged( name, old, new )

		local L = self.FR

		if ( IsValid( L ) ) then

			UpdateNearZ( L, new )

		end

		L = self.BK

		if ( IsValid( L ) ) then

			UpdateNearZ( L, new )

		end

		L = self.RI

		if ( IsValid( L ) ) then

			UpdateNearZ( L, new )

		end

		L = self.LF

		if ( IsValid( L ) ) then

			UpdateNearZ( L, new )

		end

		L = self.UP

		if ( IsValid( L ) ) then

			UpdateNearZ( L, new )

		end

		L = self.DN

		if ( IsValid( L ) ) then

			UpdateNearZ( L, new )

		end

	end

	local function UpdateLightColor( L, new )

		L:SetKeyValue( "lightcolor", new )

	end

	function ENT:LightColorChanged( name, old, new )

		new = self:ColorIntensityToString( new, self:GetBrightness() * 100 )

		local L = self.FR

		if ( IsValid( L ) ) then

			UpdateLightColor( L, new )

		end

		L = self.BK

		if ( IsValid( L ) ) then

			UpdateLightColor( L, new )

		end

		L = self.RI

		if ( IsValid( L ) ) then

			UpdateLightColor( L, new )

		end

		L = self.LF

		if ( IsValid( L ) ) then

			UpdateLightColor( L, new )

		end

		L = self.UP

		if ( IsValid( L ) ) then

			UpdateLightColor( L, new )

		end

		L = self.DN

		if ( IsValid( L ) ) then

			UpdateLightColor( L, new )

		end

	end

	local fov = math.deg( math.atan( 512 / 511 ) ) * 2
	local lx = "effects/lx"

	function ENT:UpdateProjectedTexture( L, pos, ang, Shadows, FarZ, NearZ, LightColor, LightWorld, Disable )

		L:SetPos( pos )
		L:SetAngles( ang )

		L:SetParent( self )

		L:SetKeyValue( "spawnflags", 2 )
		L:SetKeyValue( "enableshadows", Shadows )
		L:SetKeyValue( "shadowquality", 1 )
		L:SetKeyValue( "farz",	FarZ )
		L:SetKeyValue( "nearz", NearZ )
		L:SetKeyValue( "lightfov", fov )
		L:SetKeyValue( "lightcolor", LightColor )
		L:SetKeyValue( "lightworld", LightWorld )

		L:Spawn()

		L:Input( "SpotlightTexture", NULL, NULL, lx )
		L:Input( "Ambient", NULL, NULL, 1 )
		if ( Disable ) then L:Input( "TurnOff", NULL, NULL, nil ) end

	end

	local EMPTY_ANG = Angle( 0, 0, 0 )

	function ENT:Initialize()

		BaseClass.Initialize( self )

		local Shadows = self:BoolToString( self:GetShadows() )
		local FarZ = self:GetFarZ()
		local NearZ = self:GetNearZ()
		local LightColor = self:ColorIntensityToString( self:GetLightColor(), self:GetBrightness() * 100 )
		local LightWorld = self:BoolToString( self:GetLightWorld() )
		local Disable = ( not self:GetActiveState() )

		local pos = self:GetPos()
		local ang = self:GetAngles()

		local L = ents.Create( "env_projectedtexture" )

		if ( IsValid( L ) ) then

			self.FR = L

			self:UpdateProjectedTexture( L, pos, ang, Shadows, FarZ, NearZ, LightColor, LightWorld, Disable )

		end

		local up = ang:Up()

		EMPTY_ANG:Set( ang )
		EMPTY_ANG:RotateAroundAxis( up, 180 )

		L = ents.Create( "env_projectedtexture" )

		if ( IsValid( L ) ) then

			self.BK = L

			self:UpdateProjectedTexture( L, pos, EMPTY_ANG, Shadows, FarZ, NearZ, LightColor, LightWorld, Disable )

		end

		EMPTY_ANG:Set( ang )
		EMPTY_ANG:RotateAroundAxis( up, 90 )

		L = ents.Create( "env_projectedtexture" )

		if ( IsValid( L ) ) then

			self.RI = L

			self:UpdateProjectedTexture( L, pos, EMPTY_ANG, Shadows, FarZ, NearZ, LightColor, LightWorld, Disable )

		end

		EMPTY_ANG:Set( ang )
		EMPTY_ANG:RotateAroundAxis( up, 270 )

		L = ents.Create( "env_projectedtexture" )

		if ( IsValid( L ) ) then

			self.LF = L

			self:UpdateProjectedTexture( L, pos, EMPTY_ANG, Shadows, FarZ, NearZ, LightColor, LightWorld, Disable )

		end

		local ri = ang:Right()

		EMPTY_ANG:Set( ang )
		EMPTY_ANG:RotateAroundAxis( ri, 90 )

		L = ents.Create( "env_projectedtexture" )

		if ( IsValid( L ) ) then

			self.UP = L

			self:UpdateProjectedTexture( L, pos, EMPTY_ANG, Shadows, FarZ, NearZ, LightColor, LightWorld, Disable )

		end

		EMPTY_ANG:Set( ang )
		EMPTY_ANG:RotateAroundAxis( ri, 270 )

		L = ents.Create( "env_projectedtexture" )

		if ( IsValid( L ) ) then

			self.DN = L

			self:UpdateProjectedTexture( L, pos, EMPTY_ANG, Shadows, FarZ, NearZ, LightColor, LightWorld, Disable )

		end

	end

	function ENT:SpawnedInSandbox( ply )

		ply:AddCleanup( "advlights_expensive_lights", self )

	end

	function ENT:SpawnFunction( ply, tr, ClassName )

		if ( not tr.Hit ) then return end

		local ent = ents.Create( ClassName )
		ent:SetPos( tr.HitPos + ( tr.HitNormal * 32 ) )
		ent:Spawn()
		ent:Activate()

		ent:SpawnedInSandbox( ply )

		return ent

	end

	duplicator.RegisterEntityClass( "expensive_light", function( ply, data )

		local ent = duplicator.GenericDuplicatorFunction( ply, data )

		if ( not IsValid( ent ) ) then return end

		ent:SpawnedInSandbox( ply )

		return ent

	end, "Data" )

	function ENT:CanTool( ply, trace, name )

		if ( name == "colour" ) then

			self:colour_tool( ply, trace )

			return false

		elseif ( name == "light" ) then

			self:light_tool( ply, trace )

			return false

		end

		return true

	end

end

if ( CLIENT ) then

	language.Add( "Cleanup_advlights_expensive_lights", "AdvLights: Expensive Lights" )
	language.Add( "Cleaned_advlights_expensive_lights", "Cleaned up all Expensive Lights" )

	function ENT:Initialize()

		self.PixVis = util.GetPixelVisibleHandle()

	end

	local spritemat = Material( "sprites/light_ignorez" )
	local helpermat = Material( "sprites/helper_tri" )

	function ENT:Draw()

		if ( ( halo.RenderedEntity() ~= self ) and self:GetActiveState() and self:GetDrawSprite() ) then

			local pos = self:GetPos()

			local Visible = util.PixelVisible( pos, 4, self.PixVis )

			if ( ( Visible ) and ( Visible > 0.1 ) ) then

				local c = self:GetLightColor()
				local i = self:GetBrightness()

				local s = ( i / 0.63 ) ^ 0.5 * 32
				s = s * Visible

				render.SetMaterial( spritemat )
				render.DrawSprite( pos, s, s, Color( self:ColorC( c.x ), self:ColorC( c.y ), self:ColorC( c.z ), math.Round( Visible * 255 ) ) )

			end

		end

		if ( ( not self:Camera() ) and self:GetDrawHelper() ) then

			local pos = self:GetPos()
			local ang = self:GetAngles()

			local fw = ang:Forward()
			local ri = ang:Right()
			local up = ang:Up()

			render.SetMaterial( helpermat )
			render.DrawBeam( pos + ( fw * 2 ), pos + ( fw * 4 ), 0.5, 1, 0, self.c_r )
			render.DrawBeam( pos + ( fw * -2 ), pos + ( fw * -4 ), 0.5, 1, 0, self.c_c )
			render.DrawBeam( pos + ( ri * 2 ), pos + ( ri * 4 ), 0.5, 1, 0, self.c_g )
			render.DrawBeam( pos + ( ri * -2 ), pos + ( ri * -4 ), 0.5, 1, 0, self.c_m )
			render.DrawBeam( pos + ( up * 2 ), pos + ( up * 4 ), 0.5, 1, 0, self.c_b )
			render.DrawBeam( pos + ( up * -2 ), pos + ( up * -4 ), 0.5, 1, 0, self.c_y )

		end

	end

end
