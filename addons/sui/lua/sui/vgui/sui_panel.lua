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

sui.scaling_functions(PANEL)

function PANEL:Init()
	self:ScaleInit()
end

sui.register("Panel", PANEL, "Panel")