--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


DEFINE_BASECLASS( "DProperty_Generic" )

local PANEL = {}

function PANEL:Init()
end

function PANEL:ValueChanged( newval, bForce )

	BaseClass.ValueChanged( self, newval, bForce )

	self.VectorValue = Vector( newval )

end

function PANEL:Setup( vars )

	vars = vars or {}

	self:Clear()

	local text = self:Add( "DTextEntry" )
	if ( not vars.waitforenter ) then text:SetUpdateOnType( true ) end
	text:SetDrawBackground( false )
	text:Dock( FILL )

	self.IsEditing = function( self )

		return text:IsEditing()

	end

	text.OnValueChange = function( text, newval )

		self:ValueChanged( newval )

	end

	local btn = self:Add( "DButton" )
	btn:Dock( LEFT )
	btn:DockMargin( 0, 2, 4, 2 )
	btn:SetWide( 20 - 4 )
	btn:SetText( "" )

	btn.Paint = function( btn, w, h )

		local veccol = self.VectorValue

		if ( veccol ) then

			surface.SetDrawColor( veccol.r, veccol.g, veccol.b, 255 )
			surface.DrawRect( 2, 2, w - 4, h - 4 )

		end

		surface.SetDrawColor( 0, 0, 0, 150 )
		surface.DrawOutlinedRect( 0, 0, w, h )

	end

	btn.DoClick = function()

		local color = vgui.Create( "DColorCombo", self )
		color:SetupCloseButton( function() CloseDermaMenus() end )

		color.OnValueChanged = function( color, newcol )

			self:ValueChanged( tostring( newcol.r ).." "..tostring( newcol.g ).." "..tostring( newcol.b ), true )

		end

		local veccol = self.VectorValue

		color:SetColor( Color( veccol.r, veccol.g, veccol.b, 255 ) )

		local menu = DermaMenu()
			menu:AddPanel( color )
			menu:SetDrawBackground( false )
		menu:Open( gui.MouseX() + 8, gui.MouseY() + 10 )

	end

	self.SetValue = function( self, val )

		text:SetText( tostring( math.Round( val.r ) ).." "..tostring( math.Round( val.g ) ).." "..tostring( math.Round( val.b ) ) )
		self.VectorValue = val

	end

end

derma.DefineControl( "DProperty_RGBColor", "", PANEL, "DProperty_Generic" )
