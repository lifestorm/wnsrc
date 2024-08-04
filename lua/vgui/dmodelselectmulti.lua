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

function PANEL:Init()

	self.ModelPanels = {}
	self:SetHeight( 2 )

end

function PANEL:SetHeight( numHeight )

	self:SetTall( 66 * ( numHeight or 2 ) + 26 )

end

function PANEL:AddModelList( name, modelList, conVar, dontSort, dontCallListConVars )

	local ModelSelect = vgui.Create( "DModelSelect", self )

	ModelSelect:SetModelList( modelList, conVar, dontSort, dontCallListConVars )

	self:AddSheet( name, ModelSelect )

	self.ModelPanels[ name ] = ModelSelect

	return ModelSelect

end

derma.DefineControl( "DModelSelectMulti", "", PANEL, "DPropertySheet" )
