--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ATTRIBUTE.name = "Stamina"
ATTRIBUTE.description = "Affecte la vitesse à laquelle vous pouvez courir."

function ATTRIBUTE:OnSetup(client, value)
	client:SetRunSpeed(ix.config.Get("runSpeed") + value)
end
