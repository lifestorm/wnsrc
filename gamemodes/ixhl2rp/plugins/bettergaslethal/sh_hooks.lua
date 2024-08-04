--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function PLUGIN:SetupAreaProperties()
	ix.area.AddType("lethal gas")
    ix.area.AddProperty("Severity", ix.type.number, 1)
end