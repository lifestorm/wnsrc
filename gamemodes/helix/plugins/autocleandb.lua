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

PLUGIN.name = "Database Cleaner"
PLUGIN.description = "Cleans up old logs and other database entries."
PLUGIN.author = "Votton"

ix.config.Add("cleanupInterval", 3, "The number of hours between database cleanups.", nil, {
    data = {min = 1, max = 24},
    category = "Database Cleanup"
})

ix.config.Add("logCleanupDays", 122, "The number of days to keep logs for.", nil, {
    data = {min = 1, max = 365},
    category = "Database Cleanup"
})

ix.config.Add("deletedEntityCleanupDays", 30, "The number of days to keep deleted entities for.", nil, {
    data = {min = 1, max = 365},
    category = "Database Cleanup"
})

-- Cleans up logs that are older than the specified number of days.
function PLUGIN:cleanLogs()
    local cleanupDays = ix.config.Get("logCleanupDays")
    local cleanupTimestamp = os.time() - (cleanupDays * 24 * 60 * 60)

    local query = mysql:Delete("ix_logs")
    query:WhereLT("datetime", cleanupTimestamp)
    query:Execute(function(result)
        print("[Database Cleaner] is cleaning up logs older than " .. cleanupDays .. " days.")
        if result and result.affected > 0 then
            print("[Database Cleaner] Deleted " .. result.affected .. " logs.")
        else
            print("[Database Cleaner] No logs to clean up.")
        end
    end)
end

-- Cleans up deleted entities that are older than the specified number of days.
function PLUGIN:cleanDeletedEntities()
    local cleanupDays = ix.config.Get("deletedEntityCleanupDays")
    local cleanupTimestamp = os.time() - (cleanupDays * 24 * 60 * 60)

    local query = mysql:Delete("ix_saveents")
    query:WhereLT("deleted", cleanupTimestamp)
    query:WhereNotEqual("deleted", 0)
    query:Execute(function(result)
        print("[Database Cleaner] is cleaning up deleted entities older than " .. cleanupDays .. " days.")
        if result and result.affected > 0 then
            print("[Database Cleaner] Deleted " .. result.affected .. " entities.")
        else
            print("[Database Cleaner] No deleted entities to clean up.")
        end
    end)
end

-- Initialise the cleanup timer when the database is connected.
function PLUGIN:DatabaseConnected()
    local cleanupInterval = ix.config.Get("cleanupInterval")
    timer.Create("ixDatabaseCleaner", cleanupInterval * 60 * 60, 0, function()
        self:cleanLogs()
        self:cleanDeletedEntities()
    end)
end