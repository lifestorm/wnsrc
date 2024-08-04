--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local IsValid = IsValid
local string = string
local os = os
local print = print
local util = util
local CHTTP = CHTTP
local ipairs = ipairs
local table = table
local pairs = pairs
local netstream = netstream
local SortedPairsByMemberValue = SortedPairsByMemberValue

local PLUGIN = PLUGIN

local MAX_CACHE_AGE = 7 * 24 * 3600 -- 7 days
PLUGIN.ipCache = {}

hook.Add("DatabaseConnected", "bastionAntiAlt", function()
    local query = mysql:Create("bastion_antialt_users")
        query:Create("id", "INT UNSIGNED NOT NULL AUTO_INCREMENT")
        query:Create("steamid", "VARCHAR(20) NOT NULL")
        query:Create("steam_name", "VARCHAR(128) NOT NULL")
        query:Create("cookie", "VARCHAR(64) NOT NULL")
        query:PrimaryKey("id")
    query:Execute()

    query = mysql:Create("bastion_antialt_cookies")
        query:Create("cookie", "VARCHAR(64) NOT NULL")
        query:Create("ts_hl2", "INT(11) UNSIGNED DEFAULT NULL")
        query:Create("ts_ep2", "INT(11) UNSIGNED DEFAULT NULL")
        query:Create("ts_css", "INT(11) UNSIGNED DEFAULT NULL")
        query:Create("ts_csgo", "INT(11) UNSIGNED DEFAULT NULL")
        query:Create("ts_gmod", "INT(11) UNSIGNED DEFAULT NULL")
        query:PrimaryKey("cookie")
    query:Execute()

    query = mysql:Create("bastion_antialt_userips")
        query:Create("id", "INT UNSIGNED NOT NULL AUTO_INCREMENT")
        query:Create("steamid", "VARCHAR(20) NOT NULL")
        query:Create("ip", "VARCHAR(15) NOT NULL")
        query:Create("last_seen", "INT(11) UNSIGNED NOT NULL")
        query:PrimaryKey("id")
    query:Execute()

    query = mysql:Create("bastion_antialt_ip")
        query:Create("ip", "VARCHAR(15) NOT NULL")
        query:Create("updated", "INT(11) UNSIGNED NOT NULL")
        query:Create("asn", "VARCHAR(12) NOT NULL")
        query:Create("provider", "VARCHAR(128) NOT NULL")
        query:Create("isocode", "VARCHAR(2) NOT NULL")
        query:Create("proxy", "TINYINT(1) UNSIGNED DEFAULT 0")
        query:Create("type", "VARCHAR(32) NOT NULL")
        query:Create("risk", "INT UNSIGNED NOT NULL")
        query:Create("attack_count", "INT UNSIGNED DEFAULT NULL")
        query:Create("attack_history", "TEXT DEFAULT NULL")
        query:PrimaryKey("ip")
    query:Execute()

    query = mysql:Create("bastion_antialt_alts")
        query:Create("steamid", "VARCHAR(20) NOT NULL")
        query:Create("alt_id", "INT UNSIGNED NOT NULL")
        query:Create("type", "VARCHAR(10) NOT NULL")
        query:Create("info", "TEXT NOT NULL")
        query:PrimaryKey("steamid")
    query:Execute()
end)

function PLUGIN:AltLoadUserData(client)
    local query = mysql:Select("bastion_antialt_users")
    query:Where("steamid", client:SteamID64())
    query:Callback(function(result)
        if (!IsValid(client)) then return end

        if (!result or #result == 0) then
            client.ixAltData.mode = self.TYPE_UNKNOWN
        else
            client.ixAltData.mode = self.TYPE_KNOWN
            client.ixAltData.cookies = result
        end

        self:AltPreFinalChecking(client)
    end)
    query:Execute()
end

function PLUGIN.GetIPAddress(client)
    local ip = client:IPAddress()

    return string.gsub(ip, ":%d+$", "", 1)
end

function PLUGIN:AltLookupIP(client)
    local ip = self.GetIPAddress(client)

    client.ixAltData.ipAddress = ip

    if (self.ipCache[ip]) then
        -- ip address still in cache
        client.ixAltData.ip = self.ipCache[ip]
        self:AltPreFinalChecking(client)
    else
        -- lookup address
        local query = mysql:Select("bastion_antialt_ip")
            query:Where("ip", ip)
            query:Callback(function(result)
                if (!result or #result == 0 or (result[1].updated < (os.time() - MAX_CACHE_AGE))) then
                    self:AltFetchIP(client, ip, !result or #result == 0)
                else
                    -- load in data from the DB
                    if (result[1].proxy == 1) then
                        result[1].proxy = "yes"
                    else
                        result[1].proxy = "no"
                    end
                    client.ixAltData.ip = result[1]
                    self:AltPreFinalChecking(client)
                end
            end)
        query:Execute()
    end
end

function PLUGIN:AltFetchIP(client, ip, bCreateNew)
    -- address not found or record too old, look it up
    local url = string.format("https://proxycheck.io/v2/%s?key=%s&vpn=1&asn=1&risk=1", ip, self.API_KEY)
    local request = {
        failed = function(error)
            -- error stop matching
            print("[BASTION] Alt check IP API call failed with error: "..error)
            print("[BASTION] Client: "..client:SteamName().."; ip: "..ip)
            client.ixAltData.error = true
        end,
        success = function(code, body, headers)
            if (!IsValid(client)) then return end

            local httpResult = util.JSONToTable(body)
            if (!httpResult) then
                -- error stop matching
                print("[BASTION] Alt check IP API call failed to parse httpResult.")
                client.ixAltData.error = true
                return
            end

            local status = httpResult.status
            if (status == "denied" or status == "error" or status == "warning") then
                print("[BASTION] Alt check IP API call failed. Status: "..status.."; Message: "..(httpResult.message or "no message").."\n")
                if (status != "warning") then
                    -- error stop matching
                    client.ixAltData.error = true
                    return
                end
            end

            -- we got the data
            local lookup = httpResult[ip]
            self:StoreIPLookup(ip, lookup, bCreateNew)

            client.ixAltData.ip = lookup
            self:AltPreFinalChecking(client)
        end,
        url = url,
        method = "GET"
    }

    CHTTP(request)
end

function PLUGIN:AltLookupCookieMatches(client, data)
    local query = mysql:Select("bastion_antialt_users")
        query:Where("cookie", data.localCookie)
        query:WhereNotEqual("steamid", client:SteamID64())
        query:Callback(function(result)
            -- we found other cookies
            if (result and #result > 0) then
                for k, v in ipairs(result) do
                    data.otherCookies[k] = {v.steam_name, v.steamid}
                end
            end

            self:AltPreFinalChecking(client)
        end)
    query:Execute()
end

function PLUGIN:AltLookupIPMatches(client)
    local query = mysql:Select("bastion_antialt_userips")
        query:Where("ip", PLUGIN.GetIPAddress(client))
        query:WhereNotEqual("steamid", client:SteamID64())
        query:Callback(function(result)
            if (!IsValid(client)) then return end

            if (result and #result > 0) then
                for k, v in ipairs(result) do
                    client.ixAltData.otherIPs[k] = {v.ip, v.steamid}
                end
            end

            self:AltPreFinalChecking(client)
        end)
    query:Execute()
end

function PLUGIN:AltLookupTimestampMatches(client, data, game, timestamp)
    local query = mysql:Select("bastion_antialt_cookies")
        query:Where("ts_"..game, timestamp)
        if (data.localCookie != "") then
            -- not interested in timestamps that we know for this client
            query:WhereNotEqual("cookie", data.localCookie)
        end
        query:Callback(function(result)
            if (result and #result > 0) then
                for _, v in ipairs(result) do
                    data.otherTimestamps[v.cookie] = data.otherTimestamps[v.cookie] or {}
                    table.insert(data.otherTimestamps[v.cookie], game)
                    -- track timestamp matches
                    -- non-zero timestamps are worth a lot more, so tracked separately too
                    if (timestamp != 0) then
                        data.otherTimestampsNZ[v.cookie] = data.otherTimestampsNZ[v.cookie] or {}
                        data.otherTimestampsNZ[v.cookie][game] = true
                    end
                end
            end

            self:AltPreFinalChecking(client)
        end)
    query:Execute()
end

function PLUGIN:AggregateTimestampMatches(data)
    data.otherTimeMatches = {}
    for cookie, matches in pairs(data.otherTimestamps) do
        if (#matches == 1) then continue end

        data.otherTimeMatches[#data.otherTimeMatches + 1] = {cookie, #matches}
    end
    table.SortByMember(data.otherTimeMatches, 2, false)
end

function PLUGIN:AltLookupCookieForTimestamps(client, data, maxMatches)
    local cookies = {}
    for cookie, matches in pairs(data.otherTimestamps) do
        -- only find cookies if at least 2 matches of which one is non-zero
        if (#matches >= 2 and data.otherTimestampsNZ[cookie]) then
            cookies[#cookies + 1] = cookie
        end
    end

    if (#cookies == 0) then
        data.checkComplete = true
        self:AltFinalChecking(client)
        return
    end

    local query = mysql:Select("bastion_antialt_users")
        query:WhereNotEqual("steamid", client:SteamID64())
        query:WhereIn("cookie", cookies)
        query:Callback(function(result)
            if (!IsValid(client)) then return end

            if (result and #result > 0) then
                for _, v in ipairs(result) do
                    local installed = table.GetKeys(data.otherTimestampsNZ[v.cookie])
                    local text = string.format("%d/%d matches - installed: %s)",
                        #data.otherTimestamps[v.cookie],
                        maxMatches,
                        table.concat(installed, "+")
                    )
                    self:AltFound(client, v.steamid, "timestamp", text)

                    data.discordAlert.timestamps[# data.discordAlert.timestamps + 1] = v.steamid.." ("..v.steam_name.."; "..text..")"
                    data.discordAlert.altIDs[v.steamid] = true
                end
            end

            data.checkComplete = true
            self:AltFinalChecking(client)
        end)
    query:Execute()
end

function PLUGIN:StoreCookieInfo(data, fileChecks)
    local query = mysql:Select("bastion_antialt_cookies")
        query:Where("cookie", data.localCookie)
        query:Callback(function(result)
            if (!result or #result == 0) then
                local queryInsert = mysql:Insert("bastion_antialt_cookies")
                    queryInsert:Insert("cookie", data.localCookie)
                    for k, v in ipairs(fileChecks) do
                        queryInsert:Insert("ts_"..v[2], data.timestamps[k])
                    end
                queryInsert:Execute()
            else
                local queryUpdate = mysql:Update("bastion_antialt_cookies")
                    queryUpdate:Where("cookie", data.localCookie)
                    for k, v in ipairs(fileChecks) do
                        queryUpdate:Update("ts_"..v[2], data.timestamps[k])
                    end
                queryUpdate:Execute()
            end
        end)
    query:Execute()
end

function PLUGIN:StoreClientCookie(client, data)
    local query = mysql:Select("bastion_antialt_users")
        query:Where("cookie", data.localCookie)
        query:Where("steamid", client:SteamID64())
        query:Callback(function(result)
            if (!IsValid(client)) then return end

            if (!result or #result == 0) then
                local queryInsert = mysql:Insert("bastion_antialt_users")
                    queryInsert:Insert("steamid", client:SteamID64())
                    queryInsert:Insert("steam_name", client:SteamName())
                    queryInsert:Insert("cookie", data.localCookie)
                queryInsert:Execute()
            end
        end)
    query:Execute()
end

function PLUGIN:StoreIPLookup(ip, httpResult, bNewEntry)
    if (!bNewEntry) then
        local query = mysql:Update("bastion_antialt_ip")
            query:Where("ip", ip)
            query:Update("updated", os.time())
            query:Update("asn", httpResult.asn)
            query:Update("provider", httpResult.provider)
            query:Update("isocode", httpResult.isocode)
            query:Update("proxy", httpResult.proxy == "yes" and 1 or 0)
            query:Update("type", httpResult.type)
            query:Update("risk", httpResult.risk or 0)
            if (httpResult["attack history"]) then
                query:Update("attack_count", httpResult["attack history"].Total)
                query:Update("attack_history", util.TableToJSON(httpResult["attack history"]))
            end
        query:Execute()
    else
        local query = mysql:Insert("bastion_antialt_ip")
            query:Insert("ip", ip)
            query:Insert("updated", os.time())
            query:Insert("asn", httpResult.asn)
            query:Insert("provider", httpResult.provider)
            query:Insert("isocode", httpResult.isocode)
            query:Insert("proxy", httpResult.proxy == "yes" and 1 or 0)
            query:Insert("type", httpResult.type)
            query:Insert("risk", httpResult.risk or 0)
            if (httpResult["attack history"]) then
                query:Insert("attack_count", httpResult["attack history"].Total)
                query:Insert("attack_history", util.TableToJSON(httpResult["attack history"]))
            end
        query:Execute()
    end
end

function PLUGIN:InsertNewAlt(steamid, alt_id, type, text)
    local query = mysql:Insert("bastion_antialt_alts")
        query:Insert("steamid", steamid)
        query:Insert("alt_id", alt_id)
        query:Insert("type", type)
        query:Insert("info", text)
    query:Execute()
end

function PLUGIN:MergeAlts(old_id, new_id, text)
    local query = mysql:Select("bastion_antialt_alts")
        query:Where("alt_id", old_id)
        query:Callback(function(result2)
            for _, v in ipairs(result2) do
                local queryUpdate = mysql:Update("bastion_antialt_alts")
                    queryUpdate:Where("steamid", v.steamid)
                    queryUpdate:Update("alt_id", new_id)
                    queryUpdate:Update("info", v.info.." - "..text)
                queryUpdate:Execute()
            end
        end)
    query:Execute()
end

function PLUGIN:LookupSteamID(client, steamid)
    if (string.find(steamid, "^STEAM_")) then
        steamid = util.SteamIDTo64()
    end

    local query = mysql:Select("bastion_antialt_alts")
        query:Where("steamid", steamid)
        query:Callback(function(result)
            if (!IsValid(client)) then return end
            if (!result or #result == 0) then
                client:NotifyLocalized("bastionNoRecordFound", steamid)
                return
            end

            local querySelect = mysql:Select("bastion_antialt_alts")
                querySelect:Where("alt_id", result[1].alt_id)
                querySelect:Callback(function(finalResult)
                    if (!IsValid(client)) then return end

                    local toReturn = {"Alts for "..steamid..":", "(SteamID64) - (detection trigger type) - (info)"}
                    for _, v in ipairs(finalResult) do
                        toReturn[#toReturn + 1] = v.steamid.." - "..v.type.." - info: "..v.info
                    end

                    netstream.Start(client, "PrintInfoList", toReturn)
                    client:NotifyLocalized("bastionResultsPrinted")
                end)
            querySelect:Execute()
        end)
    query:Execute()
end

function PLUGIN:LookupIPUsers(client, steamid)
    if (string.find(steamid, "^STEAM_")) then
        steamid = util.SteamIDTo64(steamid)
    end

    local query = mysql:query("bastion_antialt_userips")
        query:Where("steamid", steamid)
        query:Callback(function(result)
            if (!IsValid(client)) then return end
            if (!result or #result == 0) then
                client:NotifyLocalized("bastionNoRecordFound", steamid)
                return
            end

            local list = {}
            for k, v in ipairs(result) do
                list[k] = v.ip
            end

            local querySelect = mysql:query("bastion_antialt_userips")
                querySelect:WhereIn("ip", list)
                querySelect:WhereNotEqual("steamid", steamid)
                querySelect:Callback(function(finalResult)
                    if (!IsValid(client)) then return end
                    if (!result or #result == 0) then
                        client:NotifyLocalized("bastionNoRecordFound", steamid)
                        return
                    end

                    local toReturn = {"Other users on same IP as "..steamid, "(SteamID64) - (ip) - (last seen on this ip)"}
                    for _, v in SortedPairsByMemberValue(finalResult, "steamid") do
                        toReturn[#toReturn + 1] = v.steamid.." - "..v.ip.." - "..os.date("%Y-%m-%d", v.last_seen)
                    end
                    netstream.Start(client, "PrintInfoList", toReturn)
                    client:NotifyLocalized("bastionResultsPrinted")
                end)
            querySelect:Execute()
        end)
    query:Execute()
end