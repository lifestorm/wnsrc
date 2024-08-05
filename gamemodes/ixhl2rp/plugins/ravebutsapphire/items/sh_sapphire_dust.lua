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
-- This is a copy of Rave renamed by Hayden with no other noteworthy edits.

ITEM.name = "Star Dust" -- Name was originally Sapphire Dust, changed to Star Dust.
ITEM.model = Model("models/willardnetworks/food/xen_extract.mdl")
ITEM.description = "A hallucinogenic drug that inexplicably heightens your senses, making you more perceptive and wiser. It takes the shape of dark blue dust"
ITEM.category = "Drugs"

ITEM.colorAppendix = {["red"] = "EPILEPSY WARNING! Lots of flashing colors upon using this."}

local PLUGIN = PLUGIN
ITEM.functions.Consume = {
	OnRun = function (item)
		PLUGIN:Apply(item.player)
	end
}