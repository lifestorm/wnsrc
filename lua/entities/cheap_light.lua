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

ENT.PrintName =	"Light"
ENT.Category =	"Render"

function ENT:SetupDataTables()

	self:NetworkVar( "Bool",	0,	"ActiveState",	{ KeyName = "activestate",	Edit = { type = "Boolean",					title = "Enable",	order = 1,	category = "Main" } } )
	self:NetworkVar( "Bool",	1,	"DrawHelper",	{ KeyName = "drawhelper",	Edit = { type = "Boolean",					title = "Draw Helper",	order = 9,	category = "Render" } } )
	self:NetworkVar( "Bool",	2,	"DrawSprite",	{ KeyName = "drawsprite",	Edit = { type = "Boolean",					title = "Draw Sprite",	order = 8,	category = "Render" } } )
	self:NetworkVar( "Bool",	3,	"LightModels",	{ KeyName = "lightmodels",	Edit = { type = "Boolean",					title = "Light Models",	order = 6,	category = "Effect" } } )
	self:NetworkVar( "Bool",	4,	"LightWorld",	{ KeyName = "lightworld",	Edit = { type = "Boolean",					title = "Light World",	order = 7,	category = "Effect" } } )
	self:NetworkVar( "Float",	0,	"LightSize",	{ KeyName = "lightsize",	Edit = { type = "Float",	min = 0,	max = 1024,	title = "Size",		order = 4,	category = "Light" } } )
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
																	 },			title = "Style Preset",	order = 5,	category = "Light" } } )
	self:NetworkVar( "Vector",	0,	"LightColor",	{ KeyName = "lightcolor",	Edit = { type = "RGBColor",					title = "Color",	order = 2,	category = "Light" } } )

	if ( SERVER ) then

		self:SetActiveState( true )
		self:SetDrawHelper( true )
		self:SetDrawSprite( true )
		self:SetLightModels( true )
		self:SetLightWorld( true )
		self:SetBrightness( 0 )
		self:SetLightSize( 512 )
		self:SetLightStyle( 0 )
		self:SetLightColor( Vector( 255, 255, 255 ) )

	end

end

cleanup.Register( "advlights_cheap_lights" )

if ( SERVER ) then

	function ENT:Initialize()

		BaseClass.Initialize( self )

	end

	function ENT:SpawnedInSandbox( ply )

		ply:AddCleanup( "advlights_cheap_lights", self )

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

	duplicator.RegisterEntityClass( "cheap_light", function( ply, data )

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

	language.Add( "Cleanup_advlights_cheap_lights", "AdvLights: Lights" )
	language.Add( "Cleaned_advlights_cheap_lights", "Cleaned up all Lights" )

	function ENT:Initialize()

		self.PixVis = util.GetPixelVisibleHandle()

	end

	function ENT:Think()

		if ( not self:GetActiveState() ) then return end

		local dlight = DynamicLight( self:EntIndex() )

		if ( dlight ) then

			local c = self:GetLightColor()
			local s = self:GetLightSize()

			dlight.pos = self:GetPos()
			dlight.r = self:ColorC( c.x )
			dlight.g = self:ColorC( c.y )
			dlight.b = self:ColorC( c.z )
			dlight.brightness = self:GetBrightness()
			dlight.decay = s * 5
			dlight.size = s
			dlight.dietime = CurTime() + 1
			dlight.nomodel = ( not self:GetLightModels() )
			dlight.noworld = ( not self:GetLightWorld() )
			dlight.style = self:GetLightStyle()

		end

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

				local s = ( ( i + 13 ) / 13 ) ^ 2 * 32
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
