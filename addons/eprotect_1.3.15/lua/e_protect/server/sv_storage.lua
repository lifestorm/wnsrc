--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local query, db
local escape_str = function(str) return SQLStr(str, true) end

local create_queries = {
    [1] = [[CREATE TABLE IF NOT EXISTS eprotect_ips(
        id INTEGER PRIMARY KEY %s,
        sid64 CHAR(17),
        ip CHAR(15),
        country CHAR(3),
        logged_time INTEGER DEFAULT 0
    )]],
    [2] = [[CREATE TABLE IF NOT EXISTS eprotect_detections(
        id INTEGER PRIMARY KEY %s,
        name CHAR(32),
        sid64 CHAR(17),
        reason CHAR(32),
        info CHAR(32),
        type INTEGER DEFAULT 0,
        logged_time INTEGER DEFAULT 0
    )]],
    [3] = [[CREATE TABLE IF NOT EXISTS eprotect_http(
        id INTEGER PRIMARY KEY %s,
        link CHAR(64),
        type CHAR(6),
        called INTEGER DEFAULT 0
    )]]
}

local function makeTables()
    for i = 1, #create_queries do
        query(string.format(create_queries[i], eProtect.config["storage_type"] == "sql_local" and "AUTOINCREMENT" or "AUTO_INCREMENT"))
    end
end

if eProtect.config["storage_type"] == "mysql" then
    require("mysqloo")

    query = function() end

    local dbinfo = eProtect.config["mysql_info"]

    db = mysqloo.connect(dbinfo.host, dbinfo.username, dbinfo.password, dbinfo.database, dbinfo.port)

    function db:onConnected()
        print(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "mysql_successfull"))

        query = function(str, func)
            local q = db:query(str)
            q.onSuccess = function(_, data)
                if func then
                    func(data)
                end
            end

            q.onError = function(_, err) end

            q:start()
        end

        escape_str = function(str) return db:escape(tostring(str)) end

        makeTables()

        hook.Run("eP:SQLConnected")
    end

    function db:onConnectionFailed(err)
        print(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "mysql_failed"))
        print( "Error:", err )
    end

    db:connect()
else
    local oldFunc = sql.Query
    query = function(str, func)
        local result = oldFunc(str)

        if func then
            func(result)
        end
    end

    makeTables()
end

local function handleCallbacksCorrelation(parent_tbl, correlated, callback)
    for k,v in ipairs(parent_tbl) do
        if !v then return end
    end
    
    if !callback then return end
    callback(correlated or {})
end

eProtect.correlateIP = function(target, callback)
    if !IsValid(target) then return end

    local sid64 = target:SteamID64()
    local tbl = {}
    query("SELECT * FROM eprotect_ips WHERE sid64 = '"..sid64.."'", function(result)
        if result and result[1] then
            local parent_tbl = {}
            for k, v in ipairs(result) do
                parent_tbl[k] = false
            end

            for key, plydata in ipairs(result) do
                query("SELECT * FROM eprotect_ips WHERE ip = '"..(plydata.ip).."'", function(result)
                    if result and result[1] then
                        for k,v in ipairs(result) do
                            if v.sid64 == sid64 then continue end
                            table.insert(tbl, {sid64 = v.sid64, ip = v.ip})
                        end
                    end

                    parent_tbl[key] = true

                    handleCallbacksCorrelation(parent_tbl, tbl, callback)
                end)
            end
        end
    end)
end

eProtect.showIPs = function(target, ply)
    local sid64 = target:SteamID64()

    query("SELECT * FROM eprotect_ips WHERE sid64 = '"..sid64.."'", function(result)
        if !IsValid(target) or !IsValid(ply) or !result or !result[1] then return end

        result = util.TableToJSON(result)
        result = util.Base64Encode(result)

        net.Start("eP:Handeler")
        net.WriteUInt(4,3)
        net.WriteUInt(target:EntIndex(), 14)
        net.WriteString(result)
        net.WriteBit(0)
        net.Send(ply)
    end)
end

eProtect.registerIP = function(sid64, ip, country, time)
    query("SELECT * FROM eprotect_ips WHERE ip = '"..ip.."' AND sid64 = '"..sid64.."'", function(result)
        if result and result[1] then return end
        query(string.format("INSERT INTO eprotect_ips(ip, sid64, country, logged_time) VALUES('%s', %s, '%s', %s)", escape_str(ip), sid64, escape_str(country), time or os.time()))
    end)
end

eProtect.logDetection = function(name, sid64, reason, info, type)
    query(string.format("INSERT INTO eprotect_detections(name, sid64, reason, info, type, logged_time) VALUES('%s', '%s', '%s', '%s', '%s', %s)", escape_str(name), escape_str(sid64), escape_str(reason), escape_str(info), escape_str(type), os.time()))
end

eProtect.logHTTP = function(link, type, called)
    link = escape_str(link)

    query("SELECT * FROM eprotect_http WHERE link = '"..link.."'", function(result)
        if result and result[1] then
            query("UPDATE eprotect_http SET called = "..(result[1].called + 1).." WHERE link = '"..link.."'")
        return end

        query(string.format("INSERT INTO eprotect_http(link, type, called) VALUES('%s', '%s', "..(tonumber(called) or 1)..")", link, escape_str(type)))
    end)
end

local function networkData(ply, data, id)
    local compressed = util.Compress(util.TableToJSON(data))

    net.Start("eP:Handeler")
    net.WriteUInt(5, 3)
    net.WriteUInt(id, 1)
    net.WriteUInt(#compressed, 32)
    net.WriteData(compressed, #compressed)
    net.Send(ply)
end

local http_cd, detection_cd = {}, {}

eProtect.requestHTTPLog = function(ply, page, search)
    if http_cd[ply] and http_cd[ply] > CurTime() then return end
    http_cd[ply] = CurTime() + .1

    search = search ~= "" and escape_str(search) or nil
    
    local perpage, pageCount = 20, 1
    local start = perpage * ((tonumber(page) or 1) - 1)
    local data = {}

    local search_str = search and " WHERE (link LIKE '%"..search.."%')" or ""

    query("SELECT COUNT(id) FROM eprotect_http"..search_str, function(pageresult)
        if pageresult and pageresult[1] and pageresult[1]["COUNT(id)"] then
            data.pageCount = math.max(math.ceil((pageresult[1]["COUNT(id)"] or 0) / perpage), 1)
        end

        data.page = page
        
        query("SELECT * FROM eprotect_http "..search_str.." LIMIT "..start..", "..perpage, function(result)
            data.result = result

            networkData(ply, data, 0)
        end)
    end)
end

eProtect.requestDetectionLog = function(ply, page, search)
    if detection_cd[ply] and detection_cd[ply] > CurTime() then return end
    detection_cd[ply] = CurTime() + .1

    search = search ~= "" and escape_str(search) or nil
    
    local perpage, pageCount = 20, 1
    local start = perpage * ((tonumber(page) or 1) - 1)
    local data = {}

    local search_str = search and " WHERE (sid64 LIKE '%"..search.."%' OR name LIKE '%"..search.."%') " or ""

    query("SELECT COUNT(id) FROM eprotect_detections"..search_str, function(pageresult)
        if pageresult and pageresult[1] and pageresult[1]["COUNT(id)"] then
            data.pageCount = math.max(math.ceil((pageresult[1]["COUNT(id)"] or 0) / perpage), 1)
        end

        data.page = page

        query("SELECT * FROM eprotect_detections"..search_str.." ORDER BY id DESC LIMIT "..start..", "..perpage, function(result)
            data.result = result

            networkData(ply, data, 1)
        end)
    end)
end

if eProtect.config["storage_type"] == "sql_local" then
    hook.Run("eP:SQLConnected")
end