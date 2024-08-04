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
ITEM.description = "A hallucinogenic party drug designed to induce the powerful sensation of being in a rave."
ITEM.category = "Drugs"

ITEM.colorAppendix = {["red"] = "EPILEPSY WARNING! Lots of flashing colors upon using this."}

local PLUGIN = PLUGIN
ITEM.functions.Consume = {
	OnRun = function (item)
		PLUGIN:Apply(item.player)
	end
}