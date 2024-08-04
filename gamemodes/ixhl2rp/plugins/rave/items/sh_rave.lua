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
ITEM.description = "Halucynogenny narkotyk imprezowy stworzony do wywołania silnego wrażenia bycia w rave."
ITEM.category = "Drugs"

ITEM.colorAppendix = {["red"] = "OSTRZEŻENIE O EPILEPSJI! Po zażyciu narkotyku występuje dużo migających świateł."}

local PLUGIN = PLUGIN
ITEM.functions.Consume = {
	OnRun = function (item)
		PLUGIN:Apply(item.player)
	end
}