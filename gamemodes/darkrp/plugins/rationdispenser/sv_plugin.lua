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

ix.log.AddType("rationsToggleDispenser", function(client, bOn)
	return string.format("%s a mis un distributeur de rations %s.", client:Name(), bOn and "actif" or "non-actif")
end)

ix.log.AddType("rationsCoupon", function(client, amount)
	return string.format("%s a utilisé un coupon dans un distributeur de rations, gagnant %d crédits.", client:Name(), amount)
end)

ix.log.AddType("rationsDispensing", function(client, amount, wages, ration)
	return string.format("%s a acquis sa ration, gagnant %d crédits, %d salaires et une %s ration.", client:Name(), amount, wages, ration)
end)

function PLUGIN:ClientNextUsageTick(client)
	local character = client:GetCharacter()
	if (!character) then return end
	if (client:IsAFK()) then return end

	for _, v in ipairs(character:GetInventory():GetItemsByUniqueID("id_card")) do
		if (v:GetData("active") == false) then continue end

		local progress = v:GetData("nextRationTime", 60 * ix.config.Get("rationInterval"))
		v:SetData("nextRationTime", progress + 1)
	end

	if (!client:IsVortigaunt()) then return end
	for _, v in pairs(character:GetInventory():GetItems()) do
		if (v.uniqueID != "vortigaunt_slave_collar" and v.uniqueID != "vortigaunt_slave_collar_fake") then continue end
		local progress = v:GetData("nextRationTime", 60 * ix.config.Get("rationInterval"))
		v:SetData("nextRationTime", progress + 1)
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	local uniqueID = "ixDispenserTimer" .. client:SteamID64()

	if timer.Exists(uniqueID) then
		timer.Remove(uniqueID)
	end

	timer.Create(uniqueID, PLUGIN.TIMER_DELAY, 0, function()
		if (IsValid(client)) then
			PLUGIN:ClientNextUsageTick(client)
		else
			timer.Remove(uniqueID)
		end
	end)
end