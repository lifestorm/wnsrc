--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix

function PLUGIN:CanPlayerEquipItem(client, item)
	if (item.isGasmask and client:HasGasmask()) then
		return false
	end
end

function PLUGIN:CanPlayerUnequipItem(client, item)
	if (item.isGasmask and client:GetFilterItem() != nil and client:GetFilterItem() != item) then
		return false
	end
end

function PLUGIN:SetupAreaProperties()
	ix.area.AddType("gas")
end