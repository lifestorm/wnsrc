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
end

function PANEL:OnMousePressed()

	self:GetParent():Grip( 1 )

end

function PANEL:Paint( w, h )

	derma.SkinHook( "Paint", "ScrollBarGrip", self, w, h )
	return true

end

derma.DefineControl( "DScrollBarGrip", "A Scrollbar Grip", PANEL, "DPanel" )
