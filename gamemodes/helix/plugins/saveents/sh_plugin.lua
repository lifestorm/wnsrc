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
	category = "Other"
})

CAMI.RegisterPrivilege({
	Name = "Helix - SaveEnts",
	MinAccess = "superadmin"
})


ix.command.Add("SaveEntsSave", {
	description = "Saves all entities of a specific class (or runs the auto-save if no class is provided).",
	arguments = {
		bit.bor(ix.type.string, ix.type.optional)
	},
	privilege = "SaveEnts",
	OnRun = function(self, client, class)
		if (class) then
			if (!ix.saveEnts.storedTypes[class]) then
				return class.." is not a valid saveEnts class!"
			end

			ix.saveEnts:SaveClass(class)
			return "Saved all entities of class "..class.."!"
		else
			ix.saveEnts:SaveAll()
			return "Saved all entities!"
		end
	end,
})

ix.command.Add("SaveEntsLoad", {
	description = "Loads all entities of a specific class (or runs the auto-load if no class is provided). Already loaded entities are ignored.",
	arguments = {
		bit.bor(ix.type.string, ix.type.optional)
	},
	privilege = "SaveEnts",
	OnRun = function(self, client, class)
		if (class) then
			if (!ix.saveEnts.storedTypes[class]) then
				return class.." is not a valid saveEnts class!"
			end

			ix.saveEnts:RestoreAll(class)
			return "Loaded all entities of class "..class.."!"
		else
			ix.saveEnts:RestoreAll()
			return "Loaded all entities!"
		end
	end,
})