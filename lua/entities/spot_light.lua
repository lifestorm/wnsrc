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

ENT.PrintName =	"Spot Light"
ENT.Category =	"Render"

function ENT:SetupDataTables()

	self:NetworkVar( "Bool",	0,	"ActiveState",	{ KeyName = "activestate",	Edit = { type = "Boolean",					title = "Enable",	order = 1,	category = "Main" } } )
	self:NetworkVar( "Bool",	1,	"DrawHelper",	{ KeyName = "drawhelper",	Edit = { type = "Boolean",					title = "Draw Helper",	order = 12,	category = "Render" } } )
	self:NetworkVar( "Bool",	2,	"DrawSprite",	{ KeyName = "drawsprite",	Edit = { type = "Boolean",					title = "Draw Sprite",	order = 11,	category = "Render" } } )
	self:NetworkVar( "Bool",	3,	"LightModels",	{ KeyName = "lightmodels",	Edit = { type = "Boolean",					title = "Light Models",	order = 8,	category = "Effect" } } )
	self:NetworkVar( "Bool",	4,	"LightWorld",	{ KeyName = "lightworld",	Edit = { type = "Boolean",					title = "Light World",	order = 9,	category = "Effect" } } )
	self:NetworkVar( "Float",	0,	"Distance",	{ KeyName = "distance",		Edit = { type = "Float",	min = 4,	max = 2048,	title = "Distance",	order = 4,	category = "Light" } } )
	self:NetworkVar( "Float",	1,	"InnerFOV",	{ KeyName = "innerfov",		Edit = { type = "Float",	min = 1,	max = 179,	title = "Inner Angle",	order = 6,	category = "Light" } } )
	self:NetworkVar( "Float",	2,	"OuterFOV",	{ KeyName = "outerfov",		Edit = { type = "Float",	min = 1,	max = 179,	title = "Outer Angle",	order = 7,	category = "Light" } } )
	self:NetworkVar( "Float",	3,	"Radius",	{ KeyName = "radius",		Edit = { type = "Float",	min = 1,	max = 2048,	title = "Radius",	order = 5,	category = "Light" } } )
	self:NetworkVar( "Int",		0,	"Brightness",	{ KeyName = "brightness",	Edit = { type = "Int",		min = -12,	max = 12,	title = "Brightness",	order = 3,	category = "Light" } } )
	self:NetworkVar( "Int",		1,	"LightStyle",	{ KeyName = "lightstyle",	Edit = { type = "Combo",	values = {
																		 [ "Normal" ] =				0,
																		 [ "Fluorescent flicker" ] =		10,
																		 [ "Slow, strong pulse" ] =		2,
																		 [ "Slow pulse, noblack" ] =		11,
																		 [ "Gentle pulse" ] =			5,
																		 [ "Flicker A" ] =			1,
																		 [ "Flicker B" ] =			6,
																		 [ "Candle A" ] =			3,
																		 [ "Candle B" ] =			7,
																		 [ "Candle C" ] =			8,
																		 [ "Fast strobe" ] =			4,
																		 [ "Slow strobe" ] =			9,
																		 [ "Underwater light mutation" ] =	12
																	 },			title = "Style Preset",	order = 10,	category = "Light" } } )
	self:NetworkVar( "Vector",	0,	"LightColor",	{ KeyName = "lightcolor",	Edit = { type = "RGBColor",					title = "Color",	order = 2,	category = "Light" } } )

	if ( SERVER ) then

		self:SetActiveState( true )
		self:SetDrawHelper( true )
		self:SetDrawSprite( true )
		self:SetLightModels( true )
		self:SetLightWorld( true )
		self:SetDistance( 1024 )
		self:SetInnerFOV( 30 )
		self:SetOuterFOV( 45 )
		self:SetRadius( 512 )
		self:SetBrightness( 0 )
		self:SetLightStyle( 0 )
		self:SetLightColor( Vector( 255, 255, 255 ) )

		self:NetworkVarNotify( "ActiveState",	self.ActiveStateChanged )
		self:NetworkVarNotify( "LightModels",	self.LightModelsChanged )
		self:NetworkVarNotify( "LightWorld",	self.LightWorldChanged )
		self:NetworkVarNotify( "Distance",	self.DistanceChanged )
		self:NetworkVarNotify( "InnerFOV",	self.InnerFOVChanged )
		self:NetworkVarNotify( "OuterFOV",	self.OuterFOVChanged )
		self:NetworkVarNotify( "Radius",	self.RadiusChanged )
		self:NetworkVarNotify( "Brightness",	self.BrightnessChanged )
		self:NetworkVarNotify( "LightStyle",	self.LightStyleChanged )
		self:NetworkVarNotify( "LightColor",	self.LightColorChanged )

	end

end

cleanup.Register( "advlights_spot_lights" )

if ( SERVER ) then

	local function SetSpawnflags( L, LightModels, LightWorld )

		local fl = 0

		if ( not LightWorld ) then fl = fl + 1 end
		if ( not LightModels ) then fl = fl + 2 end

		L:SetKeyValue( "spawnflags", fl )

	end

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

	function ENT:LightModelsChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			SetSpawnflags( L, new, self:GetLightWorld() )

		end

	end

	function ENT:LightWorldChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			SetSpawnflags( L, self:GetLightModels(), new )

		end

	end

	function ENT:DistanceChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "distance", new )

		end

	end

	function ENT:InnerFOVChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "_inner_cone", new )

		end

	end

	function ENT:OuterFOVChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "_cone", new )

		end

	end

	function ENT:RadiusChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "spotlight_radius", new )

		end

	end

	function ENT:BrightnessChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "brightness", new )

		end

	end

	function ENT:LightStyleChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:SetKeyValue( "style", new )

		end

	end

	function ENT:LightColorChanged( name, old, new )

		local L = self.PT

		if ( IsValid( L ) ) then

			L:Input( "Color", NULL, NULL, self:ColorToString( new ) )

		end

	end

	----------------------------------------------------------------

	function ENT:Initialize()

		BaseClass.Initialize( self )

		local L = ents.Create( "light_dynamic" )
		L:SetPos( self:GetPos() )
		L:SetAngles( self:GetAngles() )

		L:SetParent( self )

		SetSpawnflags( L, self:GetLightModels(), self:GetLightWorld() )
		L:SetKeyValue( "distance", self:GetDistance() )
		L:SetKeyValue( "_inner_cone", self:GetInnerFOV() )
		L:SetKeyValue( "_cone", self:GetOuterFOV() )
		L:SetKeyValue( "brightness", self:GetBrightness() )
		L:SetKeyValue( "spotlight_radius", self:GetRadius() )
		L:SetKeyValue( "style", self:GetLightStyle() )

		L:Spawn()

		L:Input( "Color", NULL, NULL, self:ColorToString( self:GetLightColor() ) )
		if ( not self:GetActiveState() ) then L:Input( "TurnOff", NULL, NULL, nil ) end

		self.PT = L

	end

	function ENT:SpawnedInSandbox( ply )

		ply:AddCleanup( "advlights_spot_lights", self )

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

	duplicator.RegisterEntityClass( "spot_light", function( ply, data )

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

	language.Add( "Cleanup_advlights_spot_lights", "AdvLights: Spot Lights" )
	language.Add( "Cleaned_advlights_spot_lights", "Cleaned up all Spot Lights" )

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

					local s = ( ( i + 13 ) / 13 ) ^ 0.5 * 128
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
