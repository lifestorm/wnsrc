--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function PLUGIN:DatabaseConnected()
	local aQuery = mysql:Create("ix_citytypes")
		aQuery:Create("t_id", "INT UNSIGNED NOT NULL AUTO_INCREMENT")
		aQuery:Create("t_name", "TEXT")
		aQuery:Create("t_data", "TEXT")
		aQuery:PrimaryKey("t_id")
		aQuery:Callback(function()
			ix.city:LoadTypes()
		end)
	aQuery:Execute()

	local nQuery = mysql:Create("ix_cities")
	nQuery:Create("ct_id", "INT UNSIGNED NOT NULL")
		nQuery:Create("ct_credits", "TEXT")
		nQuery:Create("ct_type", "TEXT")
		nQuery:Create("ct_items", "LONGTEXT")
		nQuery:Create("ct_loan", "TEXT")
		nQuery:Create("ct_loanRate", "TEXT")
		nQuery:PrimaryKey("ct_id")
		nQuery:Callback(function()
			local fQuery = mysql:Select("ix_cities")
			fQuery:Where("ct_id", "1")
			fQuery:Callback(function(result)
				if (!istable(result) or #result == 0) then
					ix.city:InitializeMainCity()
					return
				end
				ix.city:LoadCities()
			end)
			fQuery:Execute()
		end)
	nQuery:Execute()
end

function PLUGIN:SetupProductionTimer()
	if timer.Exists("ixCityFund") then return end

	timer.Create("ixCityFund", ix.data.Get("cityFundTimer", 3600), 0, function()
		ix.city:UpdateCityFunds()
		timer.Adjust("ixCityFund", 3600)
	end)
end

ix.log.AddType("cityFundInteraction", function(client, operationType, creditAmount)
	return string.format("[CITY FUND] %s has %s %s credits.", client:Name(), operationType, isstring(creditAmount) and creditAmount or tostring(creditAmount))
end)

ix.log.AddType("factionBudget", function(client, faction, from, to)
	return string.format("[CITY FUND] %s has changed %s's budget from %s to %s credits.", client:Name(), faction, isstring(from) and from or tostring(from), isstring(to) and to or tostring(to))
end)

ix.log.AddType("factionBudgetCWU", function(client, operationType, creditAmount, faction)
	return string.format("[CITY FUND] %s has %s %s credits from/in %s's budget.", client:Name(), operationType, isstring(creditAmount) and creditAmount or tostring(creditAmount), faction)
end)

ix.log.AddType("marketInteraction", function(client, interactionType, amount, item, credAmount)
	return string.format("[CITY FUND] %s has %s %s item(s): %s for %s credits.", client:Name(), interactionType, isstring(amount) and amount or tostring(amount), item, isstring(credAmount) and credAmount or tostring(credAmount))
end)

ix.log.AddType("stockInteraction", function(client, item)
	return string.format("[CITY FUND] %s took %s from city stock.", client:Name(), item)
end)