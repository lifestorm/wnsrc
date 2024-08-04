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
ENT.AdminOnly =	false

ENT.PrintName =	"Projected Light"
ENT.Category =	"Render"

function ENT:SetupDataTables()

	self:NetworkVar( "Bool",	0,	"ActiveState",	{ KeyName = "activestate",	Edit = { type = "Boolean",					title = "Enable",		order = 1,	category = "Main" } } )
	self:NetworkVar( "Bool",	1,	"DrawHelper",	{ KeyName = "drawhelper",	Edit = { type = "Boolean",					title = "Draw Helper",		order = 11,	category = "Render" } } )
	self:NetworkVar( "Bool",	2,	"DrawSprite",	{ KeyName = "drawsprite",	Edit = { type = "Boolean",					title = "Draw Sprite",		order = 10,	category = "Render" } } )
	self:NetworkVar( "Bool",	3,	"LightWorld",	{ KeyName = "lightworld",	Edit = { type = "Boolean",					title = "Light World",		order = 9,	category = "Effect" } } )
	self:NetworkVar( "Bool",	4,	"Shadows",	{ KeyName = "shadows",		Edit = { type = "Boolean",					title = "Shadows",		order = 8,	category = "Effect" } } )
	self:NetworkVar( "Float",	0,	"Brightness",	{ KeyName = "brightness",	Edit = { type = "Float",	min = 0.01,	max = 40.95,	title = "Brightness",		order = 4,	category = "Light" } } )
	self:NetworkVar( "Float",	1,	"FarZ",		{ KeyName = "farz",		Edit = { type = "Float",	min = 32,	max = 2048,	title = "Far Z",		order = 6,	category = "Light" } } )
	self:NetworkVar( "Float",	2,	"LightFOV",	{ KeyName = "lightfov",		Edit = { type = "Float",	min = 1,	max = 179,	title = "FOV",			order = 7,	category = "Light" } } )
	self:NetworkVar( "Float",	3,	"NearZ",	{ KeyName = "nearz",		Edit = { type = "Float",	min = 2,	max = 16,	title = "Near Z",		order = 5,	category = "Light" } } )
	self:NetworkVar( "String",	0,	"LightTexture",	{ KeyName = "lighttexture",	Edit = { type = "Generic",	waitforenter = true,		title = "Texture",		order = 2,	category = "Light" } } )
	self:NetworkVar( "Vector",	0,	"LightColor",	{ KeyName = "lightcolor",	Edit = { type = "RGBColor",					title = "Color",		order = 3,	category = "Light" } } )

	if ( SERVER ) then

		self:SetActiveState( true )
		self:SetDrawHelper( true )
		self:SetDrawSprite( true )
		self:SetLightWorld( true )
		self:SetShadows( true )
		self:SetBrightness( 2.55 )
		self:SetFarZ( 1024 )
		self:SetLightFOV( 90 )
		self:SetNearZ( 4 )
		self:SetLightTexture( "effects/flashlight001" )
		self:SetLightColor( Vector( 255, 255, 255 ) )

		self:NetworkVarNotify( "ActiveState",	self.ActiveStateChanged )
		self:NetworkVarNotify( "LightWorld",	self.LightWorldChanged )
		self:NetworkVarNotify( "Shadows",	self.ShadowsChanged )
		self:NetworkVarNotify( "Brightness",	self.BrightnessChanged )
		self:NetworkVarNotify( "FarZ",		self.FarZChanged )
		self:NetworkVarNotify( "LightFOV",	self.LightFOVChanged )
		self:NetworkVarNotify( "NearZ",		self.NearZChanged )
		self:NetworkVarNotify( "LightTexture",	self.LightTextureChanged )
		self:NetworkVarNotify( "LightColor",	self.LightColorChanged )

	end

end

cleanup.Register( "advlights_projected_lights" )

if ( SERVER ) then

	function ENT:ActiveStateChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			if ( new ) then

				L:Input( "TurnOn", NULL, NULL, nil )

			else

				L:Input( "TurnOff", NULL, NULL, nil )

			end

		end

	end

	function ENT:LightWorldChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "lightworld", self:BoolToString( new ) )

		end

	end

	function ENT:ShadowsChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "enableshadows", self:BoolToString( new ) )

		end

	end

	function ENT:BrightnessChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "lightcolor", self:ColorIntensityToString( self:GetLightColor(), new * 100 ) )

		end

	end

	function ENT:FarZChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "farz", new )

		end

	end

	function ENT:LightFOVChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "lightfov", new )

		end

	end

	function ENT:NearZChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "nearz", new )

		end

	end

	function ENT:LightTextureChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:Input( "SpotlightTexture", NULL, NULL, new )

		end

	end

	function ENT:LightColorChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "lightcolor", self:ColorIntensityToString( new, self:GetBrightness() * 100 ) )

		end

	end

	function ENT:Initialize()

		BaseClass.Initialize( self )

		local L = ents.Create( "env_projectedtexture" )
		L:SetPos( self:GetPos() )
		L:SetAngles( self:GetAngles() )

		L:SetParent( self )

		L:SetKeyValue( "spawnflags", 2 )
		L:SetKeyValue( "enableshadows", self:BoolToString( self:GetShadows() ) )
		L:SetKeyValue( "shadowquality", 1 )
		L:SetKeyValue( "farz",	self:GetFarZ() )
		L:SetKeyValue( "nearz", self:GetNearZ() )
		L:SetKeyValue( "lightfov", self:GetLightFOV() )
		L:SetKeyValue( "lightcolor", self:ColorIntensityToString( self:GetLightColor(), self:GetBrightness() * 100 ) )
		L:SetKeyValue( "lightworld", self:BoolToString( self:GetLightWorld() ) )

		L:Spawn()

		L:Input( "SpotlightTexture", NULL, NULL, self:GetLightTexture() )
		L:Input( "Ambient", NULL, NULL, 1 )
		if ( not self:GetActiveState() ) then L:Input( "TurnOff", NULL, NULL, nil ) end

		self.PT = L

	end

	function ENT:SpawnedInSandbox( ply )

		ply:AddCleanup( "advlights_projected_lights", self )

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

	duplicator.RegisterEntityClass( "projected_light", function( ply, data )

		local ent = duplicator.GenericDuplicatorFunction( ply, data )

		if ( not IsValid( ent ) ) then return end

		ent:SpawnedInSandbox( ply )

		return ent

	end, "Data" )

	function ENT:CanTool( ply, trace, name )

		if ( name == "material" ) then

			self:material_tool( ply, trace )

			return false

		elseif ( name == "lamp" ) then

			self:lamp_tool( ply, trace )

			return false

		elseif ( name == "colour" ) then

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

	language.Add( "Cleanup_advlights_projected_lights", "AdvLights: Projected Lights" )
	language.Add( "Cleaned_advlights_projected_lights", "Cleaned up all Projected Lights" )

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

				local fw = self:GetAngles():Forward()
				local view = EyePos() - pos
				view:Normalize()
				local viewdot = view:Dot( fw )

				if ( viewdot > 0 ) then

					Visible = Visible * viewdot

					local c = self:GetLightColor()
					local i = self:GetBrightness()

					local s = ( i / 2.55 ) ^ 0.5 * 128
					s = s * Visible

					render.SetMaterial( spritemat )
					render.DrawSprite( pos, s, s, Color( self:ColorC( c.x ), self:ColorC( c.y ), self:ColorC( c.z ), math.Round( Visible * 255 ) ) )

				end

			end

		end

		if ( ( not self:Camera() ) and self:GetDrawHelper() ) then

			local pos = self:GetPos()
			local ang = self:GetAngles()

			local fw = ang:Forward()
			local ri = ang:Right()
			local up = ang:Up()

			render.SetMaterial( helpermat )
			render.DrawBeam( pos + ( fw * 2 ), pos + ( fw * 8 ), 0.5, 1, 0, self.c_r )
			render.DrawBeam( pos + ( fw * -2 ), pos + ( fw * -4 ), 0.5, 1, 0, self.c_c )
			render.DrawBeam( pos + ( ri * 2 ), pos + ( ri * 4 ), 0.5, 1, 0, self.c_g )
			render.DrawBeam( pos + ( ri * -2 ), pos + ( ri * -4 ), 0.5, 1, 0, self.c_m )
			render.DrawBeam( pos + ( up * 2 ), pos + ( up * 4 ), 0.5, 1, 0, self.c_b )
			render.DrawBeam( pos + ( up * -2 ), pos + ( up * -4 ), 0.5, 1, 0, self.c_y )

		end

	end

end
