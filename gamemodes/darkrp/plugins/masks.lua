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

PLUGIN.name = "Masks"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Allows certain items to hide character's identity."

ix.lang.AddTable("english", {
	maskedPerson = "Masked Person"
})

ix.lang.AddTable("french", {
	maskedPerson = "Personne Masquée"
})

ix.lang.AddTable("spanish", {
	maskedPerson = "Persona Enmascarada"
})

-- Use ITEM.isMask = true	in item file to mark it as a mask

function PLUGIN:GetHookCallPriority(hook)
	if (hook == "GetCharacterName") then
		return 900
	end
end

if (CLIENT) then
	-- Chat types where mask does not hides character's identity
	local chatTypes = {
		scoreboard = true,
		radio = true
	}

	function PLUGIN:GetCharacterName(client, chatType)
		if (!IsValid(client)) then return end
		local localClient = LocalPlayer()

		if (client == localClient) then return end
		if (chatTypes[chatType]) then return end
		if (localClient:GetMoveType() == MOVETYPE_NOCLIP and !localClient:InVehicle()) then return end
		if (ix.faction.Get(localClient:Team()).recogniseAll) then return end
		if (client:IsCombine()) then return end

		local id = client:GetNetVar("ixMaskEquipped", false)

		if (id and isnumber(id)) then
			return L("maskedPerson", id)
		end
	end
else
	function PLUGIN:PlayerInteractItem(client, action, item)
		if (item.isMask) then
			if (action == "Equip") then
				client:SetNetVar("ixMaskEquipped", tonumber(Schema:ZeroNumber(math.random(1, 999), 3)))
			elseif (action == "EquipUn") then
				client:SetNetVar("ixMaskEquipped", nil)
			end
		end
	end

	function PLUGIN:PostPlayerLoadout(client)
		local character = client:GetCharacter()

		if (character:GetInventory()) then
			for _, v in pairs(character:GetInventory():GetItems()) do
				if (v.isMask and v:GetData("equip")) then
					client:SetNetVar("ixMaskEquipped", tonumber(Schema:ZeroNumber(math.random(1, 999), 3)))
					
					return
				end
			end
		end

		client:SetNetVar("ixMaskEquipped", nil)
	end
end
