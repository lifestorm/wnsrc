--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local chatTypeWhitelist = {
	["scoreboard"] = true,
	["radio"] = true
}

function PLUGIN:GetHookCallPriority(hook)
	if (hook == "GetCharacterName" or hook == "PopulateCharacterInfo") then
		return 1500
	end
end

function PLUGIN:GetCharacterName(client, chatType)
	if (!IsValid(client)) then return end
	if (LocalPlayer():IsCombine() or chatTypeWhitelist[chatType]) then return end

	if (LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and !LocalPlayer():InVehicle()) then return end
	if (ix.faction.Get(LocalPlayer():Team()).recogniseAll) then return end
	
	if (client:Team() == FACTION_OTA) then
		return client:GetCharacter():GetClass() == CLASS_EOW and "Soldat d'Élite de l'Overwatch" or "Soldat de l'Overwatch"
	elseif (client:GetNetVar("combineMaskEquipped")) then
		return "Officier de la Protection Civile"
	end
end

function PLUGIN:PopulateCharacterInfo(client, character, container)
	if (LocalPlayer():IsCombine() or !client:GetNetVar("combineMaskEquipped") and client:Team() != FACTION_OTA) then return end

	timer.Simple(0.1, function()
		local description =  container:GetRow("description")

		if (IsValid(description)) then
			description:Remove()
		end

		local geneticDesc = container:GetRow("geneticDesc")

		if (IsValid(geneticDesc)) then
			local height = character:GetHeight()

			geneticDesc:SetText(height .. " ")
		end
	end)
end
