--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Save Entities"
PLUGIN.description = "Saves entities into the database, creating a record per entity."
PLUGIN.author = "Gr4Ss"

ix.util.Include("sv_plugin.lua")

ix.config.Add("SaveEntsOldLoadingEnabled", false, "If the old (file-based) entity loading should be used, or the new (DB-based) loading.", nil, {
	category = "Autres"
})

CAMI.RegisterPrivilege({
	Name = "Helix - SaveEnts",
	MinAccess = "superadmin"
})


ix.command.Add("SaveEntsSave", {
	description = "Sauvegarde toutes les entités d'une classe spécifique (ou lance la sauvegarde automatique si aucune classe n'est fournie).",
	arguments = {
		bit.bor(ix.type.string, ix.type.optional)
	},
	privilege = "SaveEnts",
	OnRun = function(self, client, class)
		if (class) then
			if (!ix.saveEnts.storedTypes[class]) then
				return class.." n'est pas une classe saveEnts valide !"
			end

			ix.saveEnts:SaveClass(class)
			return "Sauvegarde de toutes les entités de la classe "..class.."!"
		else
			ix.saveEnts:SaveAll()
			return "Sauvegardé toutes les entités !"
		end
	end,
})

ix.command.Add("SaveEntsLoad", {
	description = "Charge toutes les entités d'une classe spécifique (ou exécute le chargement automatique si aucune classe n'est fournie). Les entités déjà chargées sont ignorées.",
	arguments = {
		bit.bor(ix.type.string, ix.type.optional)
	},
	privilege = "SaveEnts",
	OnRun = function(self, client, class)
		if (class) then
			if (!ix.saveEnts.storedTypes[class]) then
				return class.." n'est pas une classe saveEnts valide !"
			end

			ix.saveEnts:RestoreAll(class)
			return "Chargé toutes les entités de la classe "..class.."!"
		else
			ix.saveEnts:RestoreAll()
			return "Chargé toutes les entités !"
		end
	end,
})