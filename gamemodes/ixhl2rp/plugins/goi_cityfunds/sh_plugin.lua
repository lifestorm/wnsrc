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
PLUGIN.name = "City Funds"
PLUGIN.author = "Naast"
PLUGIN.description = "Adds city funds. Yeah."

CAMI.RegisterPrivilege({
	Name = "Helix - Manage City Fund",
	MinAccess = "superadmin"
})

ix.util.IncludeDir(PLUGIN.folder .. "/meta", true)
ix.util.IncludeDir(PLUGIN.folder .. "/nets", true)

ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_stock_disallowments.lua")
ix.util.Include("sv_stock_restrictions.lua")

ix.config.Add("loanPercent", 2, "The amount of credits in percents that should be taken from city fund every day if it has a loan.", nil, {
	data = {min = 0, max = 100},
	category = "City Fund"
})

ix.config.Add("transactionVatPercent", 2, "The amount of credits in percents that should from player's transactions.", nil, {
	data = {min = 0, max = 100},
	category = "City Fund"
})

ix.config.Add("minusCityCap", 1000, "The maximum cap of negative balance of our city.", nil, {
	data = {min = 0, max = 10000},
	category = "City Fund"
})

ix.config.Add("mainCityNumber", 24, "Number of main (current playable) city.", nil, {
	data = {min = 1, max = 99},
	category = "City Fund"
})

ix.config.Add("averageItemProductionMaxRange", 15, "Max amount of average production items after rate time passes.", nil, {
	data = {min = 10, max = 100},
	category = "City Fund"
})

ix.config.Add("averageItemProductionMinRange", 5, "Min amount of average production items after rate time passes.", nil, {
	data = {min = 1, max = 9},
	category = "City Fund"
})

ix.config.Add("lowItemProductionMinRange", 5, "Min amount of low production items after rate time passes.", nil, {
	data = {min = 1, max = 9},
	category = "City Fund"
})

ix.config.Add("lowItemProductionMaxRange", 15, "Max amount of low production items after rate time passes.", nil, {
	data = {min = 10, max = 100},
	category = "City Fund"
})

ix.config.Add("highItemProductionMinRange", 5, "Min amount of high production items after rate time passes.", nil, {
	data = {min = 1, max = 9},
	category = "City Fund"
})

ix.config.Add("highItemProductionMaxRange", 15, "Max amount of high production items after rate time passes.", nil, {
	data = {min = 10, max = 100},
	category = "City Fund"
})

ix.config.Add("randItemDeletions", 3, "How much random item types (this can be one item multiple times) should be taken from every non-main city every hour.", nil, {
	data = {min = 1, max = 100},
	category = "City Fund"
})

ix.config.Add("randItemDeletionAmountRangeMin", 1, "Min range for taking one single item type from every non-main city every hour.", nil, {
	data = {min = 1, max = 9},
	category = "City Fund"
})

ix.config.Add("randItemDeletionAmountRangeMax", 15, "Min range for taking one single item type from every non-main city every hour.", nil, {
	data = {min = 10, max = 100},
	category = "City Fund"
})

ix.command.Add("CityFundEditor", {
	description = "Manage and create cities.",
	privilege = "Manage City Fund",
	OnRun = function(self, client)
		net.Start("ix.city.CreateCFEditor")
		net.Send(client)
	end
})

ix.command.Add("SimulateGOItime", {
	description = "Updates city funds by forcing cities to handle their production functions.",
	privilege = "Manage City Fund",
	arguments = ix.type.number,
	OnRun = function(self, client, time)
		if time > 20 then return client:NotifyLocalized("Time is too high!") end

		for i = 1, time do
			ix.city:UpdateCityFunds()
		end
	end
})

if CLIENT then
	ix.factionBudget:InitializeFactionBudgets()
end