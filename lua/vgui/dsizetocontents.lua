--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PANEL = {}
AccessorFunc( PANEL, "m_bSizeX", "SizeX", FORCE_BOOL )
AccessorFunc( PANEL, "m_bSizeY", "SizeY", FORCE_BOOL )

function PANEL:Init()

	self:SetMouseInputEnabled( true )

	self:SetSizeX( true )
	self:SetSizeY( true )

end

function PANEL:PerformLayout()

	self:SizeToChildren( self.m_bSizeX, self.m_bSizeY )

end

derma.DefineControl( "DSizeToContents", "", PANEL, "Panel" )
