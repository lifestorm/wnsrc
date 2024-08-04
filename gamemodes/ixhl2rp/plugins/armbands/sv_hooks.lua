--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:CharacterLoaded(character)
	local client = character:GetPlayer()
	local items = character:GetInventory():GetItems()
	local armbands = {}

	for _, item in pairs(items) do
		if (item.base != "base_armbands" or !item:GetData("equip")) then continue end

		armbands[item.name[1]:lower() .. item.name:Right(#item.name - 1)] = item.color
	end

	client:SetNetVar("armbands", armbands)
end
