--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--[[--------------------------------------------------------------------------
-- 	Namespace Tables
--------------------------------------------------------------------------]]--

local PANEL = {}

--[[--------------------------------------------------------------------------
--	Namespace Functions
--------------------------------------------------------------------------]]--

--[[--------------------------------------------------------------------------
--
--	PANEL:OpenPresetEditor()
--
--]]--
function PANEL:OpenPresetEditor()
	if ( not self.m_strPreset ) then return end
	self.Window = vgui.Create( "StackerPresetEditor" )
	self.Window:MakePopup()
	self.Window:Center()
	self.Window:SetType( self.m_strPreset )
	self.Window:SetConVars( self.ConVars )
	self.Window:SetPresetControl( self )
end

vgui.Register( "StackerControlPresets", PANEL, "ControlPresets" )