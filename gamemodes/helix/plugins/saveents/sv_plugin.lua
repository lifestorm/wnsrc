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
local ix = ix

function PLUGIN:DatabaseConnected()
	local query = mysql:Create("ix_saveents")
		query:Create("id", "INT UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("class", "VARCHAR(255) NOT NULL")
		query:Create("map", "VARCHAR(255) NOT NULL")
		query:Create("data", "TEXT NOT NULL")
		query:Create("deleted", "INT(11) UNSIGNED DEFAULT NULL")
		query:PrimaryKey("id")
	query:Execute()

	ix.saveEnts.dbLoaded = true
	for k, v in ipairs(ix.saveEnts.cache) do
		ix.saveEnts:SaveEntity(v[1], v[2])
	end

	if (ix.config.Get("SaveEntsOldLoadingEnabled")) then
		local updateQuery = mysql:Update("ix_saveents")
			updateQuery:Where("deleted", 0)
			updateQuery:Where("map", game.GetMap())
			updateQuery:Update("deleted", os.time())
		updateQuery:Execute()
	end
end

function PLUGIN:SaveData()
	ix.saveEnts:SaveAll()
end

function PLUGIN:LoadData()
	if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then
		ix.saveEnts:RestoreAll()
	end
end

function PLUGIN:EntityRemoved(entity)
	if (ix.shuttingDown) then return end
	if (!entity.ixSaveEntsID and !entity.ixSaveEntsBeingCreated) then return end

	local class = entity:GetClass()
	if (ix.saveEnts.storedTypes[class] and ix.saveEnts.storedTypes[class].bDeleteOnRemove) then
		ix.saveEnts:DeleteEntity(entity)
	end
end

function PLUGIN:PhysgunDrop(client, entity)
	ix.saveEnts:SaveEntity(entity, true)
end

function PLUGIN:InitializedPlugins()
	hook.SafeRun("RegisterSaveEnts")
end

local persistWhitelist = {
    ["prop_physics"] = true,
	["prop_effect"] = true,
}
function PLUGIN:CanProperty(client, property, entity)
    if (property == "persist" and IsValid(entity) and ix.saveEnts.storedTypes[entity:GetClass()] and !persistWhitelist[entity:GetClass()]) then
        return false
    end
end

--[[
WHAT THIS DOES
This plugin saves and restores entities registered with it. Registering entities overal is easier than writing your own save/restore code, as a lot of stuff is already handled by the plugin. For most use cases, you only must tell the plugin what custom data you want to store and how it should be restored. Everything else is done by the plugin: grabbing generic data (position, angles, skin, material, frozen state), writing it into the DB, tracking entities, restoring them on load. The plugin will store the data entity per entity in the DB rather than using a big JSON table for all entities of the same class in a file. This is less risky for data to get lost: entities are only removed from the DB if they specifically get deleted - 'bad' saves aren't possible (e.g. in case of a bad load, causing the save file to be overwritten with an empty table) unless an entity is in a bad state.

You can also easily save entities proactively if your data on them changes by calling the SaveEntity function. This immediately updates the save for your entity, and means there is no risk of a desync in case of a crash before the next SaveData run. As the plugin can write into the DB per entity, this is much more efficient than helix's way of finding all entities of a class and writing a giant table into a file every time one little value changes.

The plugin itself is already proactive in saving an entity every time it is released by the physgun (assuming position or angles changed). Deleted entities also get their save automatically removed.

Further more there is an optimization: if no data changed, no write into the DB is done. This avoids hammering the DB updating 1000's of entities one by one when SaveData runs. A simple CRC check is used for this. This also means that proactively saving entities is good: it causes the save to happen before SaveData is run, helping spread out the load on the DB (better a write every second than 300 writes at the same time every 5 minutes). SaveData also checks entities in batches every 0.5 seconds, so you don't get a giant lag spike on the frame where the save happens.

tl;dr use this plugin, it is easier, better and more performant

HOW TO USE THIS

1) Register your entity class by calling: ix.saveEnts:RegisterEntity(class, bDeleteOnRemove, bAutoSave, bAutoRestore, funcs)
Easiest to do this in the RegisterSaveEnts hook to be sure this plugin has loaded, but do it before entities are restored.

MANDATORY
class: the class of your entity as a string

SEMI-OPTIONAL (defaults to false if not provided, you usually want them as true though)
bDeleteOnRemove: automatically deletes saved data if the entity is removed, preventing it from respawning
bAutoSave: include this entity in the periodic auto-save
bAutoRestore: automatically restore this class with all the other entities

OPTIONAL FIELDS, these all are in the 'funcs' argument
OnSave(entity, data): function to set data on save, either change the data table or return a new data table (overrides the passed data table, they do not get merged!). You can also edit some of the default data in here, or remove it if you do not wish for it to be automatically restored. Note that the library already takes care of pos, angles, skin & motion (clear these fields from the data if you don't want them saved)
OnRestore(entity, data): restore data on your entity using the data table
ShouldSave(entity): return nil/false if you do not wish to save your entity
ShouldRestore(data): return nil/false if you do not wish to restore this data
OnDelete(entity): called if an entity's saved data is deleted (this isn't necessarily when the entity is deleted, depending on how you use the save system)

Example for a simple entity:
ix.saveEnts:RegisterEntity("ix_example", true, true, true, {
	OnSave = function(entity, data)
		data.someField = entity.someField
	end,
	OnRestore = function(entity, data)
		entity:RestoreSomeField(data.someField)
	end
})

MAKE SURE THAT YOUR SAVE/RESTORE FUNCTIONS DO NOT ERROR! This prevents other stuff from saving/loading! Always test when you make changes or add stuff!!!

IF YOU MAKE CHANGES TO THESE FUNCTIONS, KEEP OnRestore BACKWARDS COMPATIBLE WITH THE DATA IN THE DB! Otherwise you get errors loading in your items, and this prevents the new OnSave from being run...

The above takes care of the vast majority of the work.

2) You have a more complex use case, you can manually call some functions (from your code, or using lua_run):
ix.saveEnts:SaveAll(): saves all entities as far as their classes are registered. This is done in batches and may need some time to run, calling it while it is still running has no effect
ix.saveEnts:SaveClass(class): saves all entities of the given class (assuming the class is registered with the plugin), if a class is given the bAutoRestore is ignored should it be nil/false
ix.saveEnts:SaveEntity(entity): creates the save for the entity or updates its existing save
ix.saveEnts:RestoreAll(class): restore all entities, shouldn't cause issues with already loaded entities. Class is optional to filter only to a class. Already restored entities that weren't removed won't be recreated.
ix.saveEnts:DeleteEntity(entity): deletes the saved data for the entity (does not remove the entity itself)
ix.saveEnts:DeleteEntityByID(id, class): manually deletes the saved data for an ID - USE WITH CAUTION (e.g. ensure there is no entity with the ixSaveEntsID left), doesn't call the OnDelete callback either, class is optional for extra safety


SOMETHING FUCKED UP AND YOU NEED TO RESTORE
-Entities were deleted:
	-Reset the 'deleted' column in the DB back to 0 (e.g. for a given time, interval or class) and do 'lua_run ix.saveEnts:RestoreAll()' or maprestart
	-Note that while ix is shutting down, entity deletion shouldn't happen in the DB for any reason
-An error caused entities to not restore:
	-Fix the error and maprestart, unless the entities were explicitly deleted, their data is still in the DB
-Saved data got corrupted:
	-You cannot recover this data except from a DB backup
	-Use ShouldSave hooks to ensure only correct data gets saved (e.g. do not save containers with inventory ID 0 as this is never correct)
-Entities loaded from another source and got duplicated:
	-You will manually have to delete the duplicate entities, or shut the server down and delete them from the DB (based on their ID for example)
	-If other sources load in entities on top of saveEnts loading them in, the saveEnts plugin considers these 'new entities' and makes a new additional save for them

KEEP IN MIND:
-Not restoring entities means they will stay in the DB! If an item shouldn't be restored, make sure to not save it... if it was saved anyway, delete it upon restoring it
--]]