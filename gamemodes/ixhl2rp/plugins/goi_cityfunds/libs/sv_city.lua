--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local isstring = isstring
local setmetatable = setmetatable
local isnumber = isnumber
local tostring = tostring
local util = util
local table = table
local pairs = pairs
local ents = ents
local net = net
local istable = istable
local tonumber = tonumber

ix.city.disallowments = ix.city.disallowments or {}
ix.city.combineRestrictions = ix.city.combineRestrictions or {}

function ix.city:UpdateCityFunds()
	for index, city in pairs(ix.city.list) do
		if city:IsMain() then
			city:IncrementLoanProgress()
		end
		if !city.type then continue end
		city:HandleItemConsumption()
		city:IncrementProductionProgress()
		city:IncrementIncomeProgress()
	end
end

function ix.city:AddDisallowment(itemID)
	if !isstring(itemID) then return end

	ix.city.disallowments[itemID] = true
end

function ix.city:IsDisallowment(itemID)
	return ix.city.disallowments[itemID] or false
end

function ix.city:AddCombineRestriction(itemID)
	if !isstring(itemID) then return end

	ix.city.combineRestrictions[itemID] = true
end

function ix.city:IsCombineRestricted(itemID)
	return ix.city.combineRestrictions[itemID] or false
end


function ix.city:InitializeMainCity()
	local city = setmetatable({
		id = "1",
		credits = 0,
		type = {},
		items = {},
		loan = 0,
		loanRate = 0
	}, ix.meta.city)
	ix.city.main = city

	ix.city:AddCityData("1", city)

	return city
end

function ix.city:CreateCity(id, type)
	if isnumber(id) then id = tostring(id) end
	if !ix.city.types.list[type] then return end
	if ix.city.list[id] or ix.city.main:GetID() == id then return end
	type = ix.city.types.list[type]

	local city = setmetatable({
		id = id,
		credits = 0,
		type = type or {},
		items = {},
		loan = 0,
		loanRate = 0
	}, ix.meta.city)
	city:OnCreated()
	ix.city.list[id] = city


	ix.city:AddCityData(id, city)

	return city
end

function ix.city:LoadType(name, data)
	ix.city.types.list[name] = {
		name = name,
		itemsHighRate = data.itemsHighRate,
		itemsLowRate = data.itemsLowRate,
		itemsAverageRate = data.itemsAverageRate,
		highRateProduction = data.highRateProduction,
		lowRateProduction = data.lowRateProduction,
		averageRateProduction = data.averageRateProduction,
		passiveIncome = data.passiveIncome,
		passiveIncomeRate = data.passiveIncomeRate
	}

	return ix.city.types.list[name]
end

function ix.city:LoadCity(id, tbl)
	if isnumber(id) then id = tostring(id) end

	local city = setmetatable({
		id = id,
		credits = tbl.credits,
		type = tbl.type,
		items = tbl.items,
		loan = tbl.loan
	}, ix.meta.city)
	ix.city.list[id] = city

	return city
end

function ix.city:LoadMainCity(tbl)
	local mainCity = ix.city.main and ix.city.main or setmetatable({
		id = "1",
		credits = tbl.credits,
		type = {},
		items = tbl.items,
		loan = tbl.loan
	}, ix.meta.city)
	ix.city.main = mainCity

	return mainCity
end

function ix.city:GetCity(id)
	return id != "1" and ix.city.list[id] or ix.city:GetMainCity()
end

function ix.city:Remove(id)
	if ix.city.list[id] then ix.city.list[id] = nil end

	ix.city:DeleteCity(id)
end

function ix.city:IsMain(city)
	if isstring(city) and city == "1" or city == ix.city.main then
		return true
	end
	return false
end

function ix.city:GetMainCity()
	return ix.city.main
end

function ix.city.types:RegisterType(name, tbl)
	if ix.city.types.list[name] then return end

	-- Rates here stands for time in hours.
	local type = {
		name = name,
		itemsHighRate = tbl.itemsHighRate,
		itemsLowRate = tbl.itemsLowRate,
		itemsAverageRate = tbl.itemsAverageRate,
		highRateProduction = tbl.highRateProduction,
		lowRateProduction = tbl.lowRateProduction,
		averageRateProduction = tbl.averageRateProduction,
		passiveIncome = tbl.passiveIncome,
		passiveIncomeRate = tbl.passiveIncomeRate
	}
	ix.city.types.list[name] = type

	ix.city:AddTypeData(name, type)
end

function ix.city:AddCityData(id, city)
	local queryAdd = mysql:Insert("ix_cities")
		queryAdd:Insert("ct_id", id)
		queryAdd:Insert("ct_credits", city:GetCredits())
		queryAdd:Insert("ct_type", util.TableToJSON(city:GetType()))
		queryAdd:Insert("ct_items", util.TableToJSON(city.items))
		queryAdd:Insert("ct_loan", city:GetLoan())
		queryAdd:Insert("ct_loanRate", city.loanRate)
	queryAdd:Execute()
end

function ix.city:UpdateCity(id)
	if !isstring(id) then id = id:GetID() end
	local city = id != "1" and ix.city.list[id] or ix.city.main

	local queryUpdate = mysql:Update("ix_cities")
		queryUpdate:Where("ct_id", id)
		queryUpdate:Update("ct_credits", city:GetCredits())
		queryUpdate:Update("ct_type", util.TableToJSON(city:GetType() or {}))
		queryUpdate:Update("ct_items", util.TableToJSON(city.items))
		queryUpdate:Update("ct_loan", city:GetLoan())
		queryUpdate:Update("ct_loanRate", city.loanRate)
	queryUpdate:Execute()

	-- update main city on all terminals (main cities are refreshing automatically)
	if id == "1" then
		ix.city:UpdateCWUTerminals()
	end
end

function ix.city:UpdateCWUTerminals()
	local dataToSend = table.Copy(ix.city.main)
	dataToSend.factionBudgets = ix.factionBudget.list

	for _, terminal in pairs(ents.FindByClass("ix_cwuterminal")) do

		local client = terminal:GetUsedBy()

		if client and client:IsPlayer() and terminal.curGenData then
			net.Start("ix.terminal.UpdateCWUTerminals")
				net.WriteString(util.TableToJSON(dataToSend))
				net.WriteEntity(terminal)
			net.Send(terminal:GetUsedBy())
		end

	end
end

-- debug function
function ix.city:LoadCityData(id)
	if !isstring(id) then id = id:GetID() end
	local queryLoad = mysql:Select("ix_cities")
	queryLoad:Where("ct_id", id)
	queryLoad:Callback(function(dataSelectResult)
		if (!istable(dataSelectResult) or #dataSelectResult == 0) then
			return
		end
		print(id .. ": DATA SELECT RESULT")
		PrintTable(dataSelectResult)
		return dataSelectResult
	end)
	queryLoad:Execute()
end

function ix.city:DeleteCity(id)
	if !isstring(id) then id = id:GetID() end
	local queryDelete = mysql:Delete("ix_cities")
	queryDelete:Where("ct_id", id)
	queryDelete:Execute()
end

-- for debug and develop only
function ix.city:PurgeCities()
	local queryPurge = mysql:Drop("ix_cities")
	queryPurge:Execute()
end

function ix.city:LoadTypes()
	local queryLoad = mysql:Select("ix_citytypes")
	queryLoad:Callback(function(dataSelectResult)
		if (!istable(dataSelectResult) or #dataSelectResult == 0) then
			return
		end
		return ix.city:InitializeTypes(dataSelectResult)
	end)
	queryLoad:Execute()
end

function ix.city:LoadCities()
	local queryLoad = mysql:Select("ix_cities")
	queryLoad:Callback(function(dataSelectResult)
		if (!istable(dataSelectResult) or #dataSelectResult == 0) then
			return
		end
		return ix.city:InitializeCities(dataSelectResult)
	end)
	queryLoad:Execute()
end

function ix.city:InitializeCities(cities)
	for _, city in pairs(cities) do
		local cityData = {}
		cityData.id = isstring(city["ct_id"]) and city["ct_id"] or tostring(city["ct_id"])
		cityData.items = util.JSONToTable(city["ct_items"]) or {}
		cityData.type = util.JSONToTable(city["ct_type"]) or {}
		cityData.credits = tonumber(city["ct_credits"])
		cityData.loan = tonumber(city["ct_loan"])
		cityData.loanRate = tonumber(city["ct_loanRate"])

		if cityData.id == "1" then
			ix.city:LoadMainCity(cityData)
		else
			ix.city:LoadCity(cityData.id, cityData)
		end
	end
end

function ix.city:AddTypeData(name, typeData)
	local queryAdd = mysql:Insert("ix_citytypes")
		queryAdd:Insert("t_name", name)
		queryAdd:Insert("t_data", util.TableToJSON(typeData))
	queryAdd:Execute()
end

function ix.city:UpdateType(name)
	if !isstring(name) then name = tostring(name) end

	local queryUpdate = mysql:Update("ix_citytypes")
		queryUpdate:Where("t_name", name)
		queryUpdate:Update("t_data", util.TableToJSON(ix.city.types.list[name]))
	queryUpdate:Execute()
end

-- make sure to include data / metaobject in global table later
function ix.city:LoadTypeData(name)
	local queryLoad = mysql:Select("ix_citytypes")
	queryLoad:Where("t_name", name)
	queryLoad:Callback(function(dataSelectResult)
		if (!istable(dataSelectResult) or #dataSelectResult == 0) then
			return
		end
		return dataSelectResult
	end)
	queryLoad:Execute()
end

function ix.city:DeleteType(name)
	local queryDelete = mysql:Delete("ix_citytypes")
	queryDelete:Where("t_name", name)
	queryDelete:Execute()
end

function ix.city:InitializeTypes(types)
	for _, type in pairs(types) do
		local typeData = {}
		typeData.name = type["t_name"]
		typeData.data = util.JSONToTable(type["t_data"]) or {}
		ix.city:LoadType(typeData.name, typeData.data)
	end
end

-- for debug and develop only
function ix.city:PurgeTypes()
	local queryPurge = mysql:Drop("ix_citytypes")
	queryPurge:Execute()
end

-- cwu terminal related
function ix.city:IsAuthorized(client, ent)
	if ent and (ent:GetUsedBy() == client and ent.curGenData and ent:IsFullyAuthed() and (client:EyePos():DistToSqr(ent:GetPos()) < 10000)) then
		return true
	end

	return false
end