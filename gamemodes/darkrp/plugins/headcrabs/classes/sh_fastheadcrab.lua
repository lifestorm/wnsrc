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

CLASS.name = "Fast Headcrab"
CLASS.faction = FACTION_HEADCRAB
CLASS.model = "models/headcrab.mdl"

function CLASS:OnSet(client)
	client:SetWalkSpeed(ix.config.Get("runSpeed"))
	client:SetRunSpeed(ix.config.Get("runSpeed") * 2)
	client:SetModel("models/headcrab.mdl")
end

function CLASS:CanSwitchTo(client)
	return false
end

CLASS_FASTHEADCRAB = CLASS.index
