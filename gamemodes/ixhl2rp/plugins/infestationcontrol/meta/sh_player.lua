--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local playerMeta = FindMetaTable("Player")
local protectiveItems = {
	["yellow_hazmat_uniform"] = true,
	["orange_hazmat_uniform"] = true,
	["white_hazmat_uniform"] = true,
	["hands_gloves"] = true
}

local protectedFactions = {
	[FACTION_VORT] = true,
	[FACTION_CP] = true,
	[FACTION_HEADCRAB] = true,
	[FACTION_OTA] = true,
}

function playerMeta:IsInfestationProtected()
	local items = self:GetCharacter():GetInventory():GetItems()

	if (self:HasActiveCombineSuit()) then return true end
	
	if (protectedFactions[self:Team()]) then return true end

	for _, v in pairs(items) do
		local itemTable = ix.item.instances[v.id]

		if (itemTable:GetData("equip") and protectiveItems[itemTable.uniqueID]) then
			return true
		end
	end

	return false
end
