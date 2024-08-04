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

function PLUGIN:AdjustStaminaOffset(client, offset)
	if (offset > 0 and client:Team() == FACTION_HEADCRAB and client:GetCharacter():GetClass() == CLASS_FASTHEADCRAB
	and client:GetCharacter():GetClass() == CLASS_POISONHEADCRAB) then
		return offset * 2
	end
end

function PLUGIN:InitializedPlugins()
	if (ix.plugin.list.inventoryslosts and FACTION_HEADCRAB) then
		ix.plugin.list.inventoryslots.noEquipFactions[FACTION_HEADCRAB] = true
	end
end