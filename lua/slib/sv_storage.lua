--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

slib = slib or {}

local existSQLChecked = {}

local query, db = sql.Query
local dbconnected = false

local verified = {}

local function verifySQL(id, type)
    if verified[id] and verified[id][type] then return end
    if type == "sql_local" then
        query("CREATE TABLE IF NOT EXISTS "..id.."_data(id VARCHAR(19), data TEXT)")
    elseif type == "mysql" then
        require( "mysqloo" )

        local dbinfo = _G[id].config["mysql_info"]
        db = mysqloo.connect(dbinfo.host, dbinfo.username, dbinfo.password, dbinfo.database, dbinfo.port)

        function db:onConnected()
            print("slib: Successfully made SQL Connection for "..id)
            dbconnected = true
            hook.Run("slib:MySQLConnected")
        end

        function db:onConnectionFailed(err)
            print("slib: Failed to make SQL Connection for "..id)
            print( "Error:", err )
        end

        db:query("CREATE TABLE IF NOT EXISTS "..id.."_data(id VARCHAR(19), data TEXT)"):start()

        db:connect()
    end

    verified[id] = verified[id] or {}
    verified[id][type] = true
end

slib.syncData = function(id, type, str)
    verifySQL(id, type)

    local data

    if type == "file" then
        local sid64
        if string.find(str, "STEAM") then
            sid64 = util.SteamIDTo64(str)
        end

        data = file.Read(id.."/data/"..(sid64 or str)..".json", "DATA")        
    elseif type == "sql_local" then
        data = query("SELECT data FROM "..id.."_data WHERE id = '"..str.."'")

        if data then
            data = data[1].data
        end
    elseif type == "mysql" then
        local q = db:query("SELECT data FROM "..id.."_data WHERE id = '"..str.."'")
        function q:onSuccess(res)
            if table.IsEmpty(res) then
                q:onError()
            else
                if res[1] then
                    data = res[1].data
                    data = data and util.JSONToTable(data)
                end

                hook.Run("slib:SyncedData", id, str, data and data or false)
            end
        end

        function q:onError(err, sql)
            hook.Run("slib:SyncedData", id, str, false)
        end

        q:start()
        return
    end

    data = data and util.JSONToTable(data)

    hook.Run("slib:SyncedData", id, str, data and data or false)
end

slib.saveData = function(id, type, str, data)
    verifySQL(id, type)

    if istable(data) then
        data = util.TableToJSON(data)
    end

    if type == "file" then
        if string.find(str, "STEAM") then
            str = util.SteamIDTo64(str)
        end

        file.CreateDir(id.."/data")
        file.Write(id.."/data/"..str..".json", data)
    elseif type == "sql_local" then
        if !existSQLChecked[str] then
            if !(query("SELECT * FROM "..id.."_data WHERE id = '"..str.."'")) then
                query("INSERT INTO "..id.."_data (id, data) VALUES('"..str.."','"..data.."')")
            end
            existSQLChecked[str] = true

            return
        end

        query("UPDATE "..id.."_data SET data='"..data.."' WHERE id = '"..str.."'")
    elseif type == "mysql" then
        if !dbconnected then return end
        if !existSQLChecked[str] then
            local q = db:query("SELECT * FROM "..id.."_data WHERE id = '"..str.."'")
            function q:onSuccess(res)
                if !res or !res[1] then
                    local q = db:query("INSERT INTO "..id.."_data (id, data) VALUES('"..str.."','"..data.."')")
                    q:start()
                return else
                    existSQLChecked[str] = true
                end
            end

            q:start()
        end

        local q = db:query("UPDATE "..id.."_data SET data='"..data.."' WHERE id = '"..str.."'")

        q:start()
    end
end