--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

PLUGIN.name = "Ration Dispenser Replacer"
PLUGIN.author = "Fruity"
PLUGIN.description = "Makes ration dispenser work the way we want."
PLUGIN.TIMER_DELAY = 60 -- tick every minute

ix.util.Include("sv_plugin.lua")

ix.lang.AddTable("english", {
	creditCapReached = "A ration coupon may be found in your ration.",
	creditCapWages = "You gained a coupon in your ration, and were given %d credits in wages."
})

ix.lang.AddTable("spanish", {
	creditCapReached = "Has alcanzado el límite de créditos, no se han dado créditos de ración.",
	creditCapWages = "Has alcanzado el límite de créditos, pero te han dado %d créditos por tu salario."
})