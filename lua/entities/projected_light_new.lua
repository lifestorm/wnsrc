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

ENT.PrintName =	"Projected Light (new)"
ENT.Category =	"Render"

function ENT:SetupDataTables()

	self:NetworkVar( "Bool",	0,	"ActiveState",		{ KeyName = "activestate",	Edit = { type = "Boolean",					title = "Enable",		order = 1,	category = "Main" } } )
	self:NetworkVar( "Bool",	1,	"DrawHelper",		{ KeyName = "drawhelper",	Edit = { type = "Boolean",					title = "Draw Helper",		order = 15,	category = "Render" } } )
	self:NetworkVar( "Bool",	2,	"DrawSprite",		{ KeyName = "drawsprite",	Edit = { type = "Boolean",					title = "Draw Sprite",		order = 14,	category = "Render" } } )
	self:NetworkVar( "Bool",	3,	"Orthographic",		{ KeyName = "orthographic",	Edit = { type = "Boolean",					title = "Orthographic",		order = 7,	category = "Light" } } )
	self:NetworkVar( "Bool",	4,	"Shadows",		{ KeyName = "shadows",		Edit = { type = "Boolean",					title = "Shadows",		order = 13,	category = "Effect" } } )
	self:NetworkVar( "Float",	0,	"Brightness",		{ KeyName = "brightness",	Edit = { type = "Float",	min = 0.01,	max = 15,	title = "Brightness",		order = 4,	category = "Light" } } )
	self:NetworkVar( "Float",	1,	"FarZ",			{ KeyName = "farz",		Edit = { type = "Float",	min = 32,	max = 2048,	title = "Far Z",		order = 6,	category = "Light" } } )
	self:NetworkVar( "Float",	2,	"LightFOV",		{ KeyName = "lightfov",		Edit = { type = "Float",	min = 1,	max = 179,	title = "FOV",			order = 12,	category = "Light" } } )
	self:NetworkVar( "Float",	3,	"NearZ",		{ KeyName = "nearz",		Edit = { type = "Float",	min = 2,	max = 16,	title = "Near Z",		order = 5,	category = "Light" } } )
	self:NetworkVar( "Float",	4,	"OrthoBottom",		{ KeyName = "orthobottom",	Edit = { type = "Float",	min = 1,	max = 1024,	title = "Bottom Plane",		order = 11,	category = "Light" } } )
	self:NetworkVar( "Float",	5,	"OrthoLeft",		{ KeyName = "ortholeft",	Edit = { type = "Float",	min = 1,	max = 1024,	title = "Left Plane",		order = 8,	category = "Light" } } )
	self:NetworkVar( "Float",	6,	"OrthoRight",		{ KeyName = "orthoright",	Edit = { type = "Float",	min = 1,	max = 1024,	title = "Right Plane",		order = 9,	category = "Light" } } )
	self:NetworkVar( "Float",	7,	"OrthoTop",		{ KeyName = "orthotop",		Edit = { type = "Float",	min = 1,	max = 1024,	title = "Top Plane",		order = 10,	category = "Light" } } )
	self:NetworkVar( "String",	0,	"LightTexture",		{ KeyName = "lighttexture",	Edit = { type = "Generic",	waitforenter = true,		title = "Texture",		order = 2,	category = "Light" } } )
	self:NetworkVar( "Vector",	0,	"LightColor",		{ KeyName = "lightcolor",	Edit = { type = "RGBColor",					title = "Color",		order = 3,	category = "Light" } } )

	if ( SERVER ) then

		self:SetActiveState( true )
		self:SetDrawHelper( true )
		self:SetDrawSprite( true )
		self:SetOrthographic( false )
		self:SetShadows( true )
		self:SetBrightness( 1 )
		self:SetFarZ( 1024 )
		self:SetLightFOV( 90 )
		self:SetNearZ( 4 )
		self:SetOrthoBottom( 128 )
		self:SetOrthoLeft( 128 )
		self:SetOrthoRight( 128 )
		self:SetOrthoTop( 128 )
		self:SetLightTexture( "effects/flashlight001" )
		self:SetLightColor( Vector( 255, 255, 255 ) )

	end

end

if ( SERVER ) then

	function ENT:Initialize()

		BaseClass.Initialize( self )

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

	duplicator.RegisterEntityClass( "projected_light_new", function( ply, data )

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

	function ENT:UpdateProjectedTexture( L )

		L:SetPos( self:GetPos() )
		L:SetAngles( self:GetAngles() )
		L:SetEnableShadows( self:GetShadows() )
		L:SetFarZ( self:GetFarZ() )
		L:SetNearZ( self:GetNearZ() )
		L:SetFOV( self:GetLightFOV() )
		L:SetOrthographic( self:GetOrthographic(), self:GetOrthoLeft(), self:GetOrthoTop(), self:GetOrthoRight(), self:GetOrthoBottom() )
		L:SetColor( self:VectorToColor( self:GetLightColor() ) )
		L:SetBrightness( self:GetBrightness() )
		L:SetTexture( self:GetLightTexture() )

		L:Update()

	end

	function ENT:Initialize()

		self.PixVis = util.GetPixelVisibleHandle()

		if ( self:GetActiveState() ) then

			self.WasActive = true

			local L = ProjectedTexture()

			if ( IsValid( L ) ) then

				self.PT = L

				self:UpdateProjectedTexture( L )

			end

		else

			self.WasActive = false

		end

	end

	function ENT:Think()

		if ( self:GetActiveState() ) then

			if ( self.WasActive ) then

				local L = self.PT

				if ( IsValid( L ) ) then

					self:UpdateProjectedTexture( L )

				end

			else

				self.WasActive = true

				local L = ProjectedTexture()

				if ( IsValid( L ) ) then

					self.PT = L

					self:UpdateProjectedTexture( L )

				end

			end

		elseif ( self.WasActive ) then

			self.WasActive = false

			local L = self.PT

			if ( IsValid( L ) ) then

				L:Remove()

				self.PT = NULL

			end

		end

	end

	function ENT:OnRemove()

		local L = self.PT

		if ( IsValid( L ) ) then

			L:Remove()

			self.PT = NULL

		end

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

					local s = i ^ 0.5 * 128
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
