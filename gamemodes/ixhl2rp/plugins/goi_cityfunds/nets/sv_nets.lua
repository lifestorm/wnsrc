--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local util = util
local net = net
local ix = ix
local tonumber = tonumber
local istable = istable
local isnumber = isnumber
local pairs = pairs
local CAMI = CAMI

-- one day i definitely should re-do the networking here..

util.AddNetworkString("ix.city.CreateCFEditor")
util.AddNetworkString("ix.city.SyncCityStock")
util.AddNetworkString("ix.city.PopulateFunds")
util.AddNetworkString("ix.city.RequestTypes")
util.AddNetworkString("ix.city.RequestUpdateTypes")
util.AddNetworkString("ix.city.RequestUpdateCities")
util.AddNetworkString("ix.city.CreateType")
util.AddNetworkString("ix.city.CreateCity")
util.AddNetworkString("ix.city.UpdateType")
util.AddNetworkString("ix.city.UpdateCity")
util.AddNetworkString("ix.city.RemoveType")
util.AddNetworkString("ix.city.RemoveCity")
util.AddNetworkString("ix.city.Autosell")
util.AddNetworkString("ix.city.Sell")
util.AddNetworkString("ix.city.TakeItem")
util.AddNetworkString("ix.city.BuyCart")
util.AddNetworkString("ix.city.WithdrawCredits")
util.AddNetworkString("ix.city.DepositCredits")
util.AddNetworkString("ix.city.PayLoan")
util.AddNetworkString("ix.city.TakeLoan")
util.AddNetworkString("ix.city.SetFactionBudget")
util.AddNetworkString("ix.city.WithdrawFactionBudget")
util.AddNetworkString("ix.city.DepositFactionBudget")

net.Receive("ix.city.SyncCityStock", function(len, client)
	ix.city:SyncCityStock(client)
end)

net.Receive("ix.city.DepositFactionBudget", function(len, client)
	local budgetID = net.ReadString()
	local credits = net.ReadInt(15)
	local ent = net.ReadEntity()

	if !ent then return end
	if !credits then return end
	if !budgetID then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "budgetInteraction") and !ent.curGenData.isCCA) then
		return client:NotifyLocalized("No access.")
	end

	local fName = ix.factionBudget.list[budgetID].name
	local idCard = ix.item.instances[ent:GetCID()]
	if idCard:HasCredits(credits) then
		ix.factionBudget:AddFBCredits(budgetID, credits)
		idCard:TakeCredits(credits, "CWU terminal", "Credits deposited in faction budget: "..fName)
	else
		return client:NotifyLocalized("You don't have this amount of credits.")
	end

	ix.factionBudget:SaveBudgets()
	client:NotifyLocalized("Success!")
	ix.log.Add(client, "factionBudgetCWU", "deposited", credits, fName)
end)

net.Receive("ix.city.WithdrawFactionBudget", function(len, client)
	local budgetID = net.ReadString()
	local credits = net.ReadInt(15)
	local ent = net.ReadEntity()

	if !ent then return end
	if !credits then return end
	if !budgetID then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "budgetInteraction") and !ent.curGenData.isCCA) then
		return client:NotifyLocalized("No access.")
	end

	local fName = ix.factionBudget.list[budgetID].name
	local idCard = ix.item.instances[ent:GetCID()]
	if ix.factionBudget:HasCredits(budgetID, credits) then
		ix.factionBudget:TakeFBCredits(budgetID, credits)
		idCard:GiveCredits(credits, "CWU terminal", "Credits withdrawen from faction budget: "..fName)
	else
		return client:NotifyLocalized("Faction budget don't have this amount of credits.")
	end

	ix.factionBudget:SaveBudgets()
	client:NotifyLocalized("Success!")
	ix.log.Add(client, "factionBudgetCWU", "withdrew", credits, fName)
end)

net.Receive("ix.city.TakeItem", function(len, client)
	local incomingData = net.ReadString()
	local itemTbl = ix.item.list[incomingData]
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!itemTbl) then
		ix.city.main.items[incomingData] = nil
		return
	end
	if (ix.city:IsCombineRestricted(incomingData) or ix.city:IsCombineRestricted(itemTbl.category)) and (!isCombine) then
		return client:NotifyLocalized("You are not allowed to take this item out of stock.")
	end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "stockInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	if ix.city.main:HasItem(incomingData) then
		local charID = ent.curGenData.id
		local char = ix.char.loaded[ent.curGenData.id]
		local charName = ent.curGenData.name
		if char then
			char:SetPurchasedItems(incomingData, 1)
		else
			local dataSelect = mysql:Select("ix_characters_data")
			dataSelect:Where("id", tonumber(charID))
			dataSelect:WhereIn("key", "purchasedItems")
			dataSelect:Callback(function(dataSelectResult)
				if (!istable(dataSelectResult) or #dataSelectResult == 0) then
					return
				end

				local purchasedItems = util.JSONToTable(dataSelectResult[1].data)
				if !purchasedItems then return end

				if purchasedItems[incomingData] then
					purchasedItems[incomingData] = purchasedItems[incomingData] + 1
				else
					purchasedItems[incomingData] = 1
				end

				local updateQuery = mysql:Update("ix_characters_data")
				updateQuery:Update("data", util.TableToJSON(purchasedItems))
				updateQuery:Where("id", tonumber(charID))
				updateQuery:Where("key", "purchasedItems")
				updateQuery:Execute()
			end)
			dataSelect:Execute()
		end
		ix.city.main:TakeItem(incomingData)

		client:NotifyLocalized("Item added to pickup terminal.")
		ix.log.Add(client, "stockInteraction", incomingData)
		ix.combineNotify:AddNotification("FND:// ".. charName .. " took "..ix.item.list[incomingData].name.." from city stock", nil, client)
	end
end)

net.Receive("ix.city.Autosell", function(len, client)
	local incomingData = net.ReadString()
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "marketInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	local charName = ent.curGenData.name
	local item = util.JSONToTable(incomingData)
	local successCheck = ix.city.main:AutoSell(item.itemID, item.amount)
	if successCheck and !isnumber(successCheck) then
		client:NotifyLocalized("Can't find any city to sell this item.")
	else
		ix.combineNotify:AddNotification("FND:// ".. charName .. " has sold 1 items(s) from city stock: "..ix.item.list[item.itemID].name, nil, client)
		ix.log.Add(client, "marketInteraction", "sold", 1, item.itemID, successCheck)
	end
end)

net.Receive("ix.city.Sell", function(len, client)
	local incomingData = net.ReadString()
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "marketInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	local charName = ent.curGenData.name
	local data = util.JSONToTable(incomingData)
	local successCheck = ix.city.main:SellItems(data.itemID, ix.city.list[data.cityID], data.amount)
	if successCheck and !isnumber(successCheck) then
		client:NotifyLocalized(successCheck)
	else
		client:NotifyLocalized("Success!")
		ix.combineNotify:AddNotification("FND:// ".. charName .. " has sold "..data.amount.." items(s) from city stock: "..ix.item.list[data.itemID].name, nil, client)
		ix.log.Add(client, "marketInteraction", "sold", data.amount, data.itemID, successCheck)
	end
end)

net.Receive("ix.city.BuyCart", function(len, client)
	local incomingData = net.ReadString()
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "marketInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	local charName = ent.curGenData.name
	local cart = util.JSONToTable(incomingData)
	local successCheck
	for _, cartSlot in pairs(cart) do
		local item = cartSlot.itemData.id
		local itemAmount = cartSlot.amount
		local city = ix.city.list[cartSlot.city]

		successCheck = city:SellItems(item, ix.city.main, itemAmount)
		if successCheck and !isnumber(successCheck) then
			client:NotifyLocalized(successCheck)
		else
			ix.combineNotify:AddNotification("FND:// ".. charName .. " has sold "..itemAmount.." items(s) from city stock: "..ix.item.list[item].name, nil, client)
			ix.log.Add(client, "marketInteraction", "bought", itemAmount, item, successCheck)
		end
	end

	if !successCheck or isnumber(successCheck) then
		client:NotifyLocalized("Purchase successful!")
	end
end)

net.Receive("ix.city.WithdrawCredits", function(len, client)
	local incomingData = net.ReadInt(15)
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "creditInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	if ix.city.main:HasCredits(incomingData) then
		local charName = ent.curGenData.name
		local idCard = ix.item.instances[ent:GetCID()]
		idCard:GiveCredits(incomingData, "CWU terminal", "Credits withdrawen from city fund.")
		ix.city.main:TakeCredits(incomingData)

		ix.combineNotify:AddNotification("FND:// ".. charName .. " withdrew " .. incomingData .. " credits from city fund", color_red, client)
		ix.log.Add(client, "cityFundInteraction", "withdrew", incomingData)
	else
		return client:NotifyLocalized("City don't have enough credits.")
	end
end)

net.Receive("ix.city.DepositCredits", function(len, client)
	local incomingData = net.ReadInt(15)
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "creditInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	local idCard = ix.item.instances[ent:GetCID()]
	if idCard:HasCredits(incomingData) then
		local charName = ent.curGenData.name
		idCard:TakeCredits(incomingData, "CWU terminal", "Credits deposited in city fund.")
		ix.city.main:AddCredits(incomingData)

		ix.combineNotify:AddNotification("FND:// ".. charName .. " deposited " .. incomingData .. " credits in city fund", color_green, client)
		ix.log.Add(client, "cityFundInteraction", "deposited", incomingData)
	else
		return client:NotifyLocalized("You don't have enough credits.")
	end
end)

net.Receive("ix.city.PayLoan", function(len, client)
	local incomingData = net.ReadInt(15)
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "creditInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	if ix.city.main:HasCredits(incomingData) then
		local charName = ent.curGenData.name
		ix.city.main:PayLoan(incomingData)

		ix.combineNotify:AddNotification("FND:// ".. charName .. " paid loan with " .. incomingData .. " credits taken from city fund", color_green, client)
		ix.log.Add(client, "cityFundInteraction", "paid loan with", incomingData)
	else
		return client:NotifyLocalized("City don't have enough credits.")
	end
end)

net.Receive("ix.city.TakeLoan", function(len, client)
	local incomingData = net.ReadInt(15)
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "creditInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	local charName = ent.curGenData.name
	ix.city.main:AddLoan(incomingData)
	ix.combineNotify:AddNotification("FND:// ".. charName .. " took out a " .. incomingData .. " credits loan", color_red, client)
	ix.log.Add(client, "cityFundInteraction", "took out loan: ", incomingData)
end)

net.Receive("ix.city.SetFactionBudget", function(len, client)
	local incomingData = net.ReadString()
	local ent = net.ReadEntity()
	local isCombine = ent.curGenData and ent.curGenData.combine or false

	if !ent then return end
	if !incomingData then return end
	if !ent.curGenData then return end
	if (!ix.city:IsAuthorized(client, ent)) then return end
	if (!isCombine) then
		if (!ix.city:IsAccessable(ix.item.instances[ent:GetCWUCard()], "creditInteraction") and !ent.curGenData.isCCA) then
			return client:NotifyLocalized("No access.")
		end
	end

	incomingData = util.JSONToTable(incomingData)

	local budget = ix.factionBudget:GetFB(incomingData.budgetID)
	local budgetName = budget.name
	local newBudget = incomingData.newBudget
	local oldBudget = budget.credits
	local remains = oldBudget - newBudget

	if remains < 0 and !ix.city.main:HasCredits(-remains) then return "No credits" end

	budget.credits = newBudget
	ix.factionBudget:SaveBudgets()

	if remains > 0 then
		ix.city.main:AddCredits(remains)
	else
		ix.city.main:TakeCredits(-remains)
	end

	ix.log.Add(client, "factionBudget", budgetName, oldBudget, newBudget)
end)

net.Receive("ix.city.RequestUpdateTypes", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end

	net.Start("ix.city.RequestUpdateTypes")
		net.WriteString(util.TableToJSON(ix.city.types.list))
	net.Send(client)
end)

net.Receive("ix.city.RequestUpdateCities", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end

	local cityTbl = {}
	for index, city in pairs(ix.city.list) do
		cityTbl[index] = city
	end
	cityTbl["1"] = ix.city.main

	net.Start("ix.city.RequestUpdateCities")
		net.WriteString(util.TableToJSON(cityTbl))
	net.Send(client)
end)

net.Receive("ix.city.RemoveType", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end
	local tID = net.ReadString()

	if (ix.city.types.list[tID]) then
		ix.city.types.list[tID] = nil
		ix.city:DeleteType(tID)

		for cityID, city in pairs(ix.city.list) do
			if city.type.name == tID then
				city.type = false
				ix.city:UpdateCity(cityID)
			end
		end
	end
end)

net.Receive("ix.city.RemoveCity", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end
	local cID = net.ReadString()

	if (ix.city.list[cID]) then
		ix.city.list[cID] = nil
		ix.city:DeleteCity(cID)
	end
end)

net.Receive("ix.city.CreateType", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end
	local tID = net.ReadString()

	if (!ix.city.types.list[tID]) then
		ix.city.types:RegisterType(tID, {
			name = tID,
			itemsHighRate = {},
			itemsLowRate = {},
			itemsAverageRate = {},
			highRateProduction = 1,
			lowRateProduction = 3,
			averageRateProduction = 2,
			passiveIncome = 100,
			passiveIncomeRate = 1
		})
	end
end)

net.Receive("ix.city.CreateCity", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end

	local cityID = net.ReadString()
	local cityType = net.ReadString()

	ix.city:CreateCity(cityID, cityType)
end)

local function CheckItemRates(actualTD)
	if actualTD.highRateProduction < actualTD.averageRateProduction and
	actualTD.highRateProduction < actualTD.lowRateProduction and
	actualTD.averageRateProduction < actualTD.lowRateProduction then
		return true
	end

	return false
end

net.Receive("ix.city.UpdateType", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end

	local incomingData = net.ReadString()

	local tTbl = util.JSONToTable(incomingData)

	if !CheckItemRates(tTbl) then
		return
	end

	if ix.city.types.list[tTbl.name] then
		ix.city.types.list[tTbl.name].itemsHighRate = tTbl.itemsHighRate or {}
		ix.city.types.list[tTbl.name].itemsLowRate = tTbl.itemsLowRate or {}
		ix.city.types.list[tTbl.name].itemsAverageRate = tTbl.itemsAverageRate or {}
		ix.city.types.list[tTbl.name].highRateProduction = tTbl.highRateProduction or 1
		ix.city.types.list[tTbl.name].lowRateProduction = tTbl.lowRateProduction or 3
		ix.city.types.list[tTbl.name].averageRateProduction = tTbl.averageRateProduction or 2
		ix.city.types.list[tTbl.name].passiveIncome = tTbl.passiveIncome or 100
		ix.city.types.list[tTbl.name].passiveIncomeRate = tTbl.passiveIncomeRate or 1
	end

	ix.city:UpdateType(tTbl.name)
end)

local function ValidateCityData(cTbl, client)
	for item, itemData in pairs(cTbl.items) do
		itemData.amount = isnumber(itemData.amount) and itemData.amount or tonumber(itemData.amount) or 1
		itemData.price = isnumber(itemData.price) and itemData.price or tonumber(itemData.price) or 50
		itemData.priceDiv = isnumber(itemData.priceDiv) and itemData.priceDiv or tonumber(itemData.priceDiv) or 2
		itemData.priceMul = isnumber(itemData.priceMul) and itemData.priceMul or tonumber(itemData.priceMul) or 2
		itemData.priceMulptiplicationTD = isnumber(itemData.priceMulptiplicationTD) and itemData.priceMulptiplicationTD or tonumber(itemData.priceMulptiplicationTD) or 10
		itemData.priceReductionTD = isnumber(itemData.priceReductionTD) and itemData.priceReductionTD or tonumber(itemData.priceReductionTD) or 90
	end
end

net.Receive("ix.city.UpdateCity", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end

	local incomingData = net.ReadString()
	local isMain = net.ReadBool()

	local cTbl = util.JSONToTable(incomingData)
	ValidateCityData(cTbl, client)

	for item, itemData in pairs(cTbl.items) do
		itemData.amount = itemData.amount or 0
		itemData.price = itemData.price or 0
		itemData.priceDiv = itemData.priceDiv or 2
		itemData.priceMul = itemData.priceMul or 2
		itemData.priceMulptiplicationTD = itemData.priceMulptiplicationTD or 10
		itemData.priceReductionTD = itemData.priceReductionTD or 90
	end

	if ix.city.list[cTbl.id] and !isMain then
		ix.city.list[cTbl.id].credits = tonumber(cTbl.credits) or 0
		ix.city.list[cTbl.id].items = cTbl.items or {}
		ix.city.list[cTbl.id].loan = tonumber(cTbl.loan) or 0
		if ix.city.types.list[cTbl.type.name] then
			ix.city.list[cTbl.id].type = cTbl.type or {}
		end
		ix.city:UpdateCity(cTbl.id)
	elseif isMain then
		if istable(cTbl.items) then
			for itemID, item in pairs(cTbl.items) do
				cTbl.items[itemID] = {amount = item.amount}
			end

			ix.city.main.items = cTbl.items
		end
		ix.city.main.credits = tonumber(cTbl.credits)
		ix.city.main.loan = tonumber(cTbl.loan)

		ix.city:UpdateCity(cTbl.id)
	end
end)

net.Receive("ix.city.PopulateFunds", function(len, client)
	if (!CAMI.PlayerHasAccess(client, "Helix - Manage City Fund")) then return end

	local cityTbl = {}
	for index, city in pairs(ix.city.list) do
		cityTbl[index] = city
	end
	cityTbl["1"] = ix.city.main

	local typeTbl = {}
	for index, type in pairs(ix.city.types.list) do
		typeTbl[index] = type
	end

	local cityData = util.TableToJSON(cityTbl)
	local typeData = util.TableToJSON(typeTbl)

	net.Start("ix.city.RequestTypes")
		net.WriteString(typeData)
	net.Send(client)

	net.Start("ix.city.PopulateFunds")
		net.WriteString(cityData)
	net.Send(client)
end)