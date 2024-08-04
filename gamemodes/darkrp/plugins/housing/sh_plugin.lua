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

ix.config.Add("housingCheckInteractionAndRentTimer", 20, "Le temps en minutes pour vérifier si le loyer est dû et si les gens ont interagi avec leur appartement.", PLUGIN.UpdateInteractionTimer, {
	data = {min = 1, max = 120},
	category = "Logements"
})

ix.config.Add("costForAnApartment", 35, "Le nombre de crédits nécessaires pour demander un appartement.", nil, {
	data = {min = 1, max = 100},
	category = "Logements"
})

ix.config.Add("tenantDoorInteractionCheckWeeks", 2, "Le nombre de semaines que les citoyens peuvent passer sans utiliser une porte avant d'être renvoyés comme locataire.", nil, {
	data = {min = 1, max = 10},
	category = "Logements"
})

ix.config.Add("housingRentDueInWeeks", 1, "Le nombre de semaines avant l'échéance du loyer pour les sessions de location d'appartement.", nil, {
	data = {min = 1, max = 10},
	category = "Logements"
})

ix.config.Add("shouldLockDoorsAfterRestart", true, "Détermine si les portes affectées à un appartement doivent être verrouillées après le redémarrage.", nil, {
	category = "Logements"
})

ix.config.Add("shouldCreateNonExistingApartment", true, "Détermine si les appartements doivent être automatiquement créés s'ils n'existent pas lors de l'utilisation de la commande /SetApartmentDoor.", nil, {
	category = "Logements"
})

ix.config.Add("housingTesterMode", false, "Active le mode test, de sorte que le loyer soit dû toutes les 10 secondes (pour les nouveaux appartements).", function(_, newValue)
	if (CLIENT) then return end

	if ix.config.Get("housingTesterMode", false) then
		return timer.Adjust("ixHousingCheckInteractionAndRent", 10)
	else
		return timer.Adjust("ixHousingCheckInteractionAndRent", ix.config.Get("housingCheckInteractionAndRentTimer", 20) * 60)
	end
end, {
	category = "Logements"
})

ix.config.Add("housingFirstDouble", false, "Préférer assigner les gens dans des appartements avec un locataire avant de leur assigner un appartement vide.", nil, {
	category = "Logements"
})

ix.config.Add("housingFirstFull", false, "Préférer affecter les personnes dans l'appartement le plus plein en premier, puis presque plein, etc. Les appartements vides ne seront remplis que s'il n'y a pas de place ailleurs",nil, {
	category = "Logements"
})

ix.config.Add("housingMaxTenants", 3, "Combien de personnes doivent être affectées à un appartement ?", nil, {
	data = {min = 2, max = 10},
	category = "Logements"
})

ix.config.Add("priorityHousingTierNeeded", "Collaborateur de Rang 1 (VERT)", "Détermine le niveau nécessaire pour que le logement prioritaire soit disponible.", nil, {
	type = ix.type.array,
	category = "Logements",
	populate = function()
		local entries = {}

		for _, v in SortedPairs({"Collaborateur de Rang 1 (VERT)", "Collaborateur de Rang 2 (BLEU CLAIR)", "Collaborateur de Rang 3 (BLEU FONCÉE)","Haut Collaborateur de Rang 1 (ROUGE)","Haut Collaborateur de Rang 2 (MAUVE)","Haut Collaborateur de Rang 3 (BLANC)", "H.A.A"}) do
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