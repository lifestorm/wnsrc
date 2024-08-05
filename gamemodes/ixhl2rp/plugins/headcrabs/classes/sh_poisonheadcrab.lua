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

CLASS.name = "Poison Headcrab"
CLASS.faction = FACTION_HEADCRAB
CLASS.model = "models/headcrabblack.mdl"

function CLASS:OnSet(client)
	client:SetWalkSpeed(ix.config.Get("walkSpeed") * 0.3)
	client:SetRunSpeed(ix.config.Get("walkSpeed") * 0.5)
	client:SetModel("models/headcrabblack.mdl")
end

function CLASS:CanSwitchTo(client)
	return false
end

CLASS_POISONHEADCRAB = CLASS.index
