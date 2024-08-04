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

CLASS.name = "Headcrab"
CLASS.faction = FACTION_HEADCRAB
CLASS.isDefault = true

function CLASS:OnSet(client)
	client:SetWalkSpeed(ix.config.Get("walkSpeed") * 0.5)
	client:SetRunSpeed(ix.config.Get("walkSpeed"))
	client:SetModel("models/headcrabclassic.mdl")
	client:SetBodygroup(0, 1)
end

CLASS_HEADCRAB = CLASS.index
