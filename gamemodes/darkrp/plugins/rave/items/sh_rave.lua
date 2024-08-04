--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Original item by Xalphox, used on HL2RP with his permission

ITEM.name = "RAVE"
ITEM.model = Model("models/willardnetworks/skills/medx.mdl")
ITEM.description = "Une drogue de fête hallucinogène conçue pour induire la sensation puissante d'être dans une rave."
ITEM.category = "Drogues"

ITEM.colorAppendix = {["red"] = "ATTENTION A L'EPILEPSIE ! Beaucoup de couleurs clignotantes lors de son utilisation."}

local PLUGIN = PLUGIN
ITEM.functions.Consume = {
	name = "Se piquer",
	OnRun = function (item)
		PLUGIN:Apply(item.player)
	end
}