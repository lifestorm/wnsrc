--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]



if ( SERVER ) then return end


function ScreenScale( width )
	return width * ( ScrW() / 640.0 )
end

function ScreenScaleH( height )
	return height * ( ScrH() / 480.0 )
end

SScale = ScreenScale
