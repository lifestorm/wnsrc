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

PLUGIN.name = "Housing"
PLUGIN.author = "Fruity"
PLUGIN.description = "A way for citizens to have housing assigned to them automatically via the citizen terminal."

ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_util.lua")

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Apartments Key",
	MinAccess = "superadmin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Apartments",
	MinAccess = "admin"
})

ix.config.Add("housingCheckInteractionAndRentTimer", 20, "The amount of time in minutes to check if rent is due and if people have interacted with their apartment.", PLUGIN.UpdateInteractionTimer, {
	data = {min = 1, max = 120},
	category = "Housing"
})

ix.config.Add("costForAnApartment", 35, "The amount of credits needed to request an apartment.", nil, {
	data = {min = 1, max = 100},
	category = "Housing"
})

ix.config.Add("tenantDoorInteractionCheckWeeks", 2, "The amount of weeks citizens can go without using a door before being removed as tenant.", nil, {
	data = {min = 1, max = 10},
	category = "Housing"
})

ix.config.Add("housingRentDueInWeeks", 1, "The amount of weeks before rent is due for apartment rent sessions.", nil, {
	data = {min = 1, max = 10},
	category = "Housing"
})

ix.config.Add("shouldLockDoorsAfterRestart", true, "Determines whether doors assigned to an apartment should be locked after restart.", nil, {
	category = "Housing"
})

ix.config.Add("shouldCreateNonExistingApartment", true, "Determines whether apartments should be automatically created if they do not exist when using the /SetApartmentDoor command.", nil, {
	category = "Housing"
})

ix.config.Add("housingTesterMode", false, "Enables tester mode, so that rent is due every 10 seconds instead (for new apartments).", function(_, newValue)
	if (CLIENT) then return end

	if ix.config.Get("housingTesterMode", false) then
		return timer.Adjust("ixHousingCheckInteractionAndRent", 10)
	else
		return timer.Adjust("ixHousingCheckInteractionAndRent", ix.config.Get("housingCheckInteractionAndRentTimer", 20) * 60)
	end
end, {
	category = "Housing"
})

ix.config.Add("housingFirstDouble", false, "Prefer assigning people into apartments with 1 tenant before they get assigned an empty apartment.", nil, {
	category = "Housing"
})

ix.config.Add("housingFirstFull", false, "Prefer to assign people into the fullest apartment first, then nearly full, etc. Empty apartments will only be filled if there is no room anywhere else.", nil, {
	category = "Housing"
})

ix.config.Add("housingMaxTenants", 3, "How many peole should be assigned into an apartment.", nil, {
	data = {min = 2, max = 10},
	category = "Housing"
})

ix.config.Add("priorityHousingTierNeeded", "POZIOM 4 (NIEBIESKI)", "Determines the tier needed for priority housing to be available.", nil, {
	type = ix.type.array,
	category = "Housing",
	populate = function()
		local entries = {}

		for _, v in SortedPairs({"POZIOM 4 (NIEBIESKI)", "POZIOM 5 (ZIELONY)", "POZIOM 6 (BIAŁY)", "CZŁONEK CAB"}) do
			local name = v
			local name2 = v:utf8sub(1, 1):utf8upper() .. v:utf8sub(2)

			if (name) then
				name = name
			else
				name = name2
			end

			entries[v] = name
		end

		return entries
	end
})

function PLUGIN:GetNumbersFromText(txt)
	local str = ""
	string.gsub(txt,"%d+",function(e)
		str = str .. e
	end)

	return str
end

function PLUGIN:GetRemainingRent(appTable)
	local rent = tonumber(appTable.rent)
	if !rent then return 0 end
	if !appTable.payments then return 0 end
	
	for _, tPaymentInfo in pairs(appTable.payments) do
		rent = tonumber(rent) - tonumber(tPaymentInfo.amount)
	end

	return math.max(0, tonumber(rent))
end