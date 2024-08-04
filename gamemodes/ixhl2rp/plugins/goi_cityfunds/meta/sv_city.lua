--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local math = math
local ix = ix
local pairs = pairs
local table = table
local istable = istable
local string = string

local CITY = ix.meta.city or {}
CITY.__index = CITY
CITY.id = 0
CITY.credits = 0
CITY.type = {}
CITY.items = {}
CITY.loan = 0
CITY.loanRate = 0

function CITY:__tostring()
	return "CITY-" .. self.id
end

function CITY:__eq(other)
	return self:GetID() == other:GetID()
end

function CITY:GetID()
	return self.id
end

function CITY:OnCreated()
	self:SetType(self.type, true)
end

function CITY:TakeCredits(amount)
	self.credits = math.Clamp(self.credits - amount, -ix.config.Get("minusCityCap", 0), 999999)

	ix.city:UpdateCity(self)
end

function CITY:AddCredits(amount)
	self.credits = math.Clamp(self.credits + amount, -ix.config.Get("minusCityCap", 0), 999999)

	ix.city:UpdateCity(self)
end

function CITY:SetCredits(amount)
	self.credits = math.Clamp(amount, -ix.config.Get("minusCityCap", 0), 999999)

	ix.city:UpdateCity(self)
end

function CITY:HasCredits(amount)
	local creditsToCheck = self.credits

	if creditsToCheck < 0 and creditsToCheck != -ix.config.Get("minusCityCap", 0) then
		creditsToCheck = ix.config.Get("minusCityCap", 0) + creditsToCheck
	end

	if creditsToCheck >= amount then
		return true
	end
	return false
end

function CITY:GetCredits()
	return self.credits
end

function CITY:GetLoan()
	return self.loan
end

function CITY:SetLoan(amount)
	self.loan =  math.Clamp(amount, 0, 999999)

	ix.city:UpdateCity(self)
end

function CITY:AddLoan(amount)
	self.loan = math.Clamp(self.loan + amount, 0, 999999)
	self:AddCredits(amount)

	ix.city:UpdateCity(self)
end

function CITY:TakeLoan(amount)
	self.loan = math.Clamp(self.loan - amount, 0, 999999)

	ix.city:UpdateCity(self)
end

function CITY:PayLoan(amount)
	if !self:HasCredits(amount) then return "Your city don't have enough credits." end

	self:TakeLoan(amount)
	self:TakeCredits(amount)
end

function CITY:IsMain()
	return self:GetID() == "1"
end

function CITY:AddItem(item, amount, price, priceMulptiplicationTD, priceReductionTD, priceMul, priceDiv)
	if self.items[item] then
		amount = self.items[item].amount + amount
	end

	if !self:IsMain() then
		self.items[item] = {
			amount = amount,
			price = price and price or self.items[item] and self.items[item].price and self.items[item].price or 0,
			priceMulptiplicationTD = priceMulptiplicationTD and priceMulptiplicationTD or self.items[item] and self.items[item].priceMulptiplicationTD or 10,
			priceReductionTD = priceReductionTD and priceReductionTD or self.items[item] and self.items[item].priceReductionTD or 90,
			priceMul = priceMul and priceMul or self.items[item] and self.items[item].priceMul or 2,
			priceDiv = priceDiv and priceDiv or self.items[item] and self.items[item].priceDiv or 2
		}
	else
		self.items[item] = {
			amount = amount
		}
	end

	ix.city:UpdateCity(self)
end

function CITY:HasItem(item)
	if self.items[item] and self.items[item].amount > 0 then
		return true
	end
	return false
end

function CITY:RemoveItem(item, amount)
	amount = amount or 1
	if self.items[item] and (self.items[item].amount - amount) >= 0 then
		self.items[item].amount = self.items[item].amount - amount
	end
end

function CITY:OnItemTaken(item) end

function CITY:TakeItem(item, amount)
	if self:HasItem(item) then
		self:RemoveItem(item, amount)
		self:OnItemTaken(item)
	end

	ix.city:UpdateCity(self)
end

function CITY:GetItemPrice(itemTbl)
	if itemTbl.priceMulptiplicationTD and itemTbl.amount <= itemTbl.priceMulptiplicationTD then
		return math.ceil(itemTbl.price * itemTbl.priceMul)
	elseif itemTbl.priceReductionTD and itemTbl.amount >= itemTbl.priceReductionTD then
		return math.ceil(itemTbl.price / itemTbl.priceDiv)
	else
		return itemTbl.price
	end
end

function CITY:SellItems(item, fund, amount)
	local itemTbl = self.items[item]
	local fundItem = fund.items[item]

	local cityStr = "CITY-" .. self.id
	local fundStr = "CITY-" .. fund.id

	if !itemTbl or itemTbl.amount <= 0 then
		return cityStr .. " don't have this: '" .. ix.item.list[item].name .. "' with amount of " .. amount
	end

	if fund.id != "1" and !fundItem then
		return fundStr .. " don't want to make any deals with this item."
	end

	local price = self.id != "1" and self:GetItemPrice(itemTbl) or fund:GetItemPrice(fundItem)

	if !fund:HasCredits(price * amount) then
		return fundStr .. " don't have enough credits. (Available at this moment: " .. fund:GetCredits() .. ")"
	end

	fund:AddItem(item, amount)
	fund:TakeCredits(price * amount)

	self:AddCredits(price * amount)
	self:TakeItem(item, amount)

	ix.city:UpdateCity(self)

	return price * amount
end

function CITY:AutoSell(item, amount)
	local citiesWithItem = {}
	local selectedCity = false

	for cityID, city in pairs(ix.city.list) do
		if city.items[item] then
			local itemPrice = self:GetItemPrice(city.items[item])

			if city:HasCredits(itemPrice) then
				citiesWithItem[#citiesWithItem + 1] = {
					price = itemPrice,
					cityID = cityID,
				}
			end
		end
	end

	table.sort( citiesWithItem, function(a, b) return a.price > b.price end )

	if #citiesWithItem != 0 and citiesWithItem[#citiesWithItem] then
		selectedCity = citiesWithItem[1].cityID
	else
		return "Can't find city to sell."
	end

	local sellItems = self:SellItems(item, ix.city.list[selectedCity], amount)

	return sellItems
end

function CITY:ExportItems(item, city, amount)

end

function CITY:GetItems()
	return self.items
end

function CITY:GetType()
	return self.type
end

function CITY:SetType(tbl, noUpdate)
	self.type = tbl
	self.type.cIncomeProgress = 0
	self.type.productionProgress = {
		lowRateProduction = 0,
		averageRateProduction = 0,
		highRateProduction = 0
	}

	if !noUpdate then
		ix.city:UpdateCity(self)
	end
end

function CITY:IncrementLoanProgress()
	if !self:IsMain() then return end
	if self:GetCredits() <= 0 then return end

	self.loanRate = self.loanRate + 1

	if self.loanRate >= 24 then
		local credPercent = self:GetCredits() / 100

		self:TakeCredits(math.Round(credPercent * ix.config.Get("loanPercent")))
		self.loanRate = 0
	end

	ix.city:UpdateCity(self)
end

function CITY:IncrementIncomeProgress()
	if !self.type or !istable(self.type) or table.IsEmpty(self.type) then return end

	self.type.cIncomeProgress = self.type.cIncomeProgress + 1

	if self.type.cIncomeProgress >= self.type.passiveIncomeRate then
		self:AddCredits(self.type.passiveIncome)
		self.type.cIncomeProgress = 0
	end

	ix.city:UpdateCity(self)
end

function CITY:IncrementProductionProgress()
	if !self.type or !istable(self.type) or table.IsEmpty(self.type) then return end

	for i, production in pairs(self.type.productionProgress) do
		self.type.productionProgress[i] = self.type.productionProgress[i] + 1

		if self.type.productionProgress[i] >= self.type[i] then
			self:HandleItemProduction(i)
			self.type.productionProgress[i] = 0
		end
	end

	ix.city:UpdateCity(self)
end

function CITY:HandleItemConsumption()
	if !self.type or !istable(self.type) or table.IsEmpty(self.type) then return end
	if table.IsEmpty(self.items) then return end

	local range = {ix.config.Get("randItemDeletionAmountRangeMin"), ix.config.Get("randItemDeletionAmountRangeMax")}
	local difItemsToTake = ix.config.Get("randItemDeletions")

	for i = 1, difItemsToTake do
		local itemsAmountToTake = math.random(range[1], range[2])
		local _, itemID = table.Random(self.items)

		self:TakeItem(itemID, itemsAmountToTake)
	end
end

function CITY:HandleItemProduction(rate)
	local itemTable
	local range
	if string.match(rate, "high") then
		itemTable = self.type.itemsHighRate
		range = {ix.config.Get("highItemProductionMinRange"), ix.config.Get("highItemProductionMaxRange")}
	elseif string.match(rate, "average") then
		itemTable = self.type.itemsAverageRate
		range = {ix.config.Get("averageItemProductionMinRange"), ix.config.Get("averageItemProductionMaxRange")}
	elseif string.match(rate, "low") then
		itemTable = self.type.itemsLowRate
		range = {ix.config.Get("lowItemProductionMinRange"), ix.config.Get("lowItemProductionMaxRange")}
	end

	if !istable(itemTable) or !range then return end

	local itemsProduced = math.random(range[1], range[2])
	for item, _ in pairs(itemTable) do
		if self.items[item] then
			self:AddItem(item, itemsProduced)
		end
	end
end

ix.meta.city = CITY