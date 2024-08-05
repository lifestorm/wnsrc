--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local pcall = pcall
local util = util
local ix = ix
local string = string
local net = net
local ipairs = ipairs
local IsValid = IsValid
local os = os
local L = L
local math = math
local table = table
local pairs = pairs
local print = print
local CHTTP = CHTTP
local player = player
local CAMI = CAMI

if (!CHTTP) then
    pcall(require, "chttp")
end

local PLUGIN = PLUGIN
PLUGIN.TYPE_UNKNOWN = 1
PLUGIN.TYPE_KNOWN = 2

local COOKIE_KEY = "qvFT4QSSST8K4tZF"

local fileChecks = {
    {"hl2_misc_001.vpk", "hl2"},
    {"ep2_pak_008.vpk", "ep2"},
    {"cstrike_pak_003.vpk", "css", "cstrike"},
    {"bin/client_panorama.dll", "csgo"},
    {"detail.vbsp", "gmod", "garrysmod"}
}

util.AddNetworkString("RecieveDupe")

ix.util.Include("sv_antialt_db.lua")

ix.lang.AddTable("english", {
    altSignupProxy = "You are trying to join Willard Networks as a new user while using a proxy or VPN. To combat alt accounts, we do not allow this.\n\nPlease turn off your proxy/VPN and rejoin the server. After you successfully joined the server once, you can turn on your proxy/VPN again for future visits.\n\nIf you are not using a proxy or VPN, please contact the community management on our forums or discord"
})

ix.log.AddType("altNewClient", function(client)
    return string.format("[AltChecker] %s joined for the first time, generating new cookie.", client:SteamName())
end)
ix.log.AddType("altKnownNewCookie", function(client)
    return string.format("[AltChecker] %s joined with unknown installation, generating new cookie.", client:SteamName())
end)
ix.log.AddType("altKnownCookieMatched", function(client, matched, total)
    return string.format("[AltChecker] %s joined without a cookie, but matched installation with existing cookie. Certainty %d/%d", client:SteamName(), matched, total)
end)

hook.Add("PlayerInitialSpawn", "bastionAntiAlt", function(client)
    if (client:IsBot()) then return end

    client.ixAltData = {
        checks = 4 + #fileChecks,
        altLogging = 0,
        error = false,
        received = false,
        checkComplete = false,
        newAltFound = false,

        mode = 0,
        localCookie = "",
        cookies = false,
        ip = false,
        timestamps = false,

        otherCookies = {},
        otherIPs = {},
        otherTimestamps = {},
        otherTimestampsNZ = {},
        otherTimeMatches = {},

        discordAlert = {
            cookies = {},
            timestamps = {},
            ips = {},
            altIDs = {}
        }
    }

    -- Lookup user data
    PLUGIN:AltLoadUserData(client)

    if (PLUGIN.API_KEY) then
    -- Lookup user IP
        PLUGIN:AltLookupIP(client)
    else
        client.ixAltData.checkes = client.ixAltData.checks - 1
    end

    -- Check for IP matches
    PLUGIN:AltLookupIPMatches(client)

    -- Request cookie and install timestamps
    PLUGIN:RequestClientData(client)
end)

function PLUGIN:RequestClientData(client)
    net.Start("RecieveDupe")
    net.WriteUInt(1, 3)
    net.WriteString(COOKIE_KEY)
    for _, v in ipairs(fileChecks) do
        net.WriteString(v[1])
        net.WriteString(v[3] or v[2])
    end
    net.Send(client)
end

net.Receive("RecieveDupe", function(len, client)
    if (!IsValid(client) or !client.ixAltData or client.ixAltData.received) then return end

    local data = client.ixAltData
    data.received = true
    -- set cookie
    data.localCookie = net.ReadString()
    -- set file timestamps
    data.timestamps = {}
    for i = 1, #fileChecks do
        data.timestamps[i] = net.ReadUInt(32)
    end

    -- Check for cookie matches
    if (data.localCookie != "") then
        PLUGIN:AltLookupCookieMatches(client, data)
    else
        PLUGIN:AltPreFinalChecking(client)
    end

    -- Check for install timestamp matches
    data.otherTimestamps = {}
    data.otherTimestampsNZ = {}
    for i = 1, #fileChecks do
        PLUGIN:AltLookupTimestampMatches(client, data, fileChecks[i][2], data.timestamps[i])
    end
end)

function PLUGIN:AltPreFinalChecking(client)
    if (!IsValid(client)) then return end

    local data = client.ixAltData
    -- if we errored, don't do anything
    -- check will be reexecuted when the client rejoins
    if (data.error) then return end

    -- check if all queries finished
    data.checks = data.checks - 1
    if (data.checks != 0) then return end

    -- cookie matches (STRONG)
    if (#data.otherCookies > 0) then
        for _, v in ipairs(data.otherCookies) do
            self:AltFound(client, v[2], "cookie", "cookie")
            data.discordAlert.cookies[#data.discordAlert.cookies + 1] = (v[2] or "").." ("..(v[1] or "")..")"
            data.discordAlert.altIDs[v[2]] = true
        end
    end

    -- IP (WEAK)
    if (#data.otherIPs > 0) then
        for _, v in ipairs(data.otherIPs) do
            data.discordAlert.ips[#data.discordAlert.ips + 1] = v[2]
            data.discordAlert.altIDs[v[2]] = true
        end
    end

    -- time matches (STRONG-MEDIUM)
    self:AggregateTimestampMatches(data)

    -- If no local cookie and player is known, check if a known cookie was time-matched
    if (data.localCookie == "" and data.mode == self.TYPE_KNOWN) then
        self:FindMatchingCookie(client, data)
    end

    if (#data.otherTimeMatches > 0) then
        -- go looking for the other clients that own our matched timestamps
        self:AltLookupCookieForTimestamps(client, data, #fileChecks)
    else
        -- else we don't need to wait for the lookup above
        data.checkComplete = true
        self:AltFinalChecking(client)
    end
end

function PLUGIN:AltFinalChecking(client)
    if (!IsValid(client)) then return end

    local data = client.ixAltData
    if (!data.checkComplete or data.altLogging != 0) then return end

    self:DiscordAlert(client)

    -- update IP list
    local steamID = client:SteamID64()
    local ip = self.GetIPAddress(client)
    local query = mysql:Select("bastion_antialt_userips")
        query:Where("steamid", steamID)
        query:Where("ip", ip)
        query:Callback(function(result)
            if (!result or #result == 0) then
                local query2 = mysql:Insert("bastion_antialt_userips")
                    query2:Insert("steamid", steamID)
                    query2:Insert("ip", ip)
                    query2:Insert("last_seen", os.time())
                query2:Execute()
            else
                local query2 = mysql:Update("bastion_antialt_userips")
                    query2:Where("id", result[1].id)
                    query2:Update("last_seen", os.time())
                query2:Execute()
            end
        end)
    query:Execute()

    -- Kick if new player on proxy/vpn
    if (data.mode == self.TYPE_UNKNOWN) then
        if (self.API_KEY and (data.ip.proxy == "yes" or (data.ip.risk or 0) > 60)) then
            if (ix.config.Get("VPNKick")) then
                self:ProxyAlert(client)
                client:Kick(L("altSignupProxy", client))
            else
                if (!self:NotifyProxyJoin(client) or ix.config.Get("ProxyAlwaysAlert")) then
                    self:ProxyAlert(client)
                end
            end
        elseif (data.localCookie == "") then
            ix.log.Add(client, "altNewClient")
            self:GenerateCookie(client, data)
        else
            -- Update the cookie's timestamps
            self:StoreCookieInfo(data, fileChecks)
            -- Add this cookie to client as well so it can be time matched/timestamps updated
            self:StoreClientCookie(client, data)
        end
    elseif (data.localCookie == "") then
        ix.log.Add(client, "altKnownNewCookie")
        self:GenerateCookie(client, data)
    else
        -- Update the cookie's timestamps
        self:StoreCookieInfo(data, fileChecks)
        -- Add this cookie to client as well so it can be time matched/timestamps updated
        self:StoreClientCookie(client, data)
    end

    if (sam) then
        timer.Simple(3, function()
            if (!IsValid(client)) then return end
            local query1 = mysql:Select("bastion_antialt_alts")
                query1:Where("steamid", client:SteamID64())
                query1:Select("alt_id")
                query1:Callback(function(result)
                    if (!IsValid(client)) then return end
                    if (!result or #result == 0) then return end
                    local query2 = mysql:Select("bastion_antialt_alts")
                        query2:Where("alt_id", result[1].alt_id)
                        query2:WhereNotEqual("steamid", client:SteamID64())
                        query2:Select("steamid")
                        query2:Callback(function(result2)
                            if (!IsValid(client)) then return end
                            if (!result2 or #result2 == 0) then return end

                            for k, v in ipairs(result2) do
                                sam.player.is_banned(util.SteamIDFrom64(v.steamid), function(banned)
                                    if (!banned or !IsValid(client)) then return end
                                    client:Kick("You have a banned alt account.")
                                    return
                                end)
                            end
                        end)
                    query2:Execute()
                end)
            query1:Execute()
        end)
    end
end

--[[
    COOKIE STUFF
]]
function PLUGIN:WhitelistPlayer(client)
    local data = client.ixAltData
    if (!data) then return end

    if (data.localCookie) then
        ix.log.Add(client, "altNewClient")
        self:GenerateCookie(client, data)

        return true
    end
end

function PLUGIN.RandomString()
    local result = {} -- The empty table we start with
    while (#result != 64) do
        local char = string.char(math.random(32, 126))
        if (string.find(char, "%w")) then
            result[#result + 1] = char
        end
    end

    return table.concat(result)
end

function PLUGIN:GenerateCookie(client, data)
    local cookie = self.RandomString()
    self:UpdateLocalCookie(client, data, cookie)

    local query = mysql:Insert("bastion_antialt_users")
        query:Insert("steamid", client:SteamID64())
        query:Insert("steam_name", client:SteamName())
        query:Insert("cookie", cookie)
    query:Execute()
end

function PLUGIN:UpdateLocalCookie(client, data, cookie)
    data.localCookie = cookie

    net.Start("RecieveDupe")
        net.WriteUInt(2, 3)
        net.WriteString(COOKIE_KEY)
        net.WriteString(cookie)
    net.Send(client)

    self:StoreCookieInfo(data, fileChecks)
end

function PLUGIN:FindMatchingCookie(client, data)
    for _, v in ipairs(data.otherTimeMatches) do
        for _, v1 in ipairs(data.cookies) do
            if (v1.cookie == v[1]) then
                -- found a timestamp match belonging to the client, restore cookie
                -- in case of e.g. gmod reinstall
                ix.log.Add(client, "altKnownCookieMatched", v[2], #fileChecks)
                self:UpdateLocalCookie(client, data, v[1])
                return
            end
        end
    end
end

--[[
    LOGGING AND ALERTING
]]
local ALT_OFFSET = 0
function PLUGIN:AltFound(client, steamid, type, info)
    local ids = {client:SteamID64(), steamid}
    local data = client.ixAltData

    data.altLogging = data.altLogging + 1

    local query = mysql:Select("bastion_antialt_alts")
        query:WhereIn("steamid", ids)
        query:Callback(function(result)
            if (!result or #result == 0) then
                local alt_id = os.time() + ALT_OFFSET
                ALT_OFFSET = ALT_OFFSET + 1

                local text = table.concat(ids,"+")..": "..info.." (alt-id: "..alt_id..")"
                self:InsertNewAlt(ids[1], alt_id, type, text)
                self:InsertNewAlt(steamid, alt_id, type, text)

                data.newAltFound = true
            elseif (#result == 1) then
                self:InsertNewAlt(
                    result[1].steamid == steamid and ids[1] or steamid,
                    result[1].alt_id,
                    type,
                    table.concat(ids,"+")..": "..info.." (alt-id: "..result[1].alt_id..")"
                )

                data.newAltFound = true
            elseif (result[2].alt_id != result[1].alt_id) then
                self:MergeAlts(
                    result[2].alt_id,
                    result[1].alt_id,
                    table.concat(ids,"+")..": "..info.." (alt-id: "..result[1].alt_id..")"
                )

                data.newAltFound = true
            end

            data.altLogging = data.altLogging - 1
            self:AltFinalChecking(client)
        end)
    query:Execute()
end

function PLUGIN:DiscordAlert(client)
    if (!self.DISCORD_WEBHOOK_ALTS or self.DISCORD_WEBHOOK_ALTS == "") then return end

    local data = client.ixAltData
    if (!data.newAltFound) then return end

    local tbl = {
        embeds = {{
            title = "Alt found for "..client:SteamName(),
            description = "An alt account match was found for **"..client:SteamName().."** (*"..client:SteamID64().."*)\n\n__COOKIE__: 99.99% certainty via installed cookie\nShown as 'SteamID64 (SteamName)'\n__TIMESTAMP__: check via installation date/time or absense of mounted games (hl2,ep2,css,csgo,gmod)\nMore matches = more certainty, especially if all/most are installed\nShown as 'SteamID64 (SteamName; date/time matches - installed matches)'\n__IP__: users that connected from the same IP address at any point\nShown as 'SteamID64'",
            color = 13632027,
            timestamp = os.date("%Y-%m-%d %X%z"),
            footer = {
                text = "Bastion Alt Checker for GMod by Gr4Ss"
            },
            author = {
                name = "Bastion Alt Checker"
            },
            fields = {
            }
        }}
    }

    if (data.discordAlert.cookies and #data.discordAlert.cookies > 0) then
        table.insert(tbl.embeds[1].fields, {name = "COOKIE", value = table.concat(data.discordAlert.cookies, "\n")})
    end
    if (data.discordAlert.timestamps and #data.discordAlert.timestamps > 0) then
        table.insert(tbl.embeds[1].fields, {name = "TIMESTAMP", value = table.concat(data.discordAlert.timestamps, "\n")})
    end
    if (data.discordAlert.ips and #data.discordAlert.ips > 0) then
        table.insert(tbl.embeds[1].fields, {
            name = "IP",
            value = string.format("Address: [%s](https://proxycheck.io/threats/%s)\n", data.ipAddress, data.ipAddress)..
                table.concat(data.discordAlert.ips, "\n")
        })
    end
    local ipLinks = {"["..client:SteamID64().."](https://steamidfinder.com/lookup/"..client:SteamID64().."/)"}
    for k in pairs(data.discordAlert.altIDs) do
        ipLinks[#ipLinks + 1] = "["..k.."](https://steamidfinder.com/lookup/"..k.."/)"
    end
    table.insert(tbl.embeds[1].fields, {
        name = "SteamID Finder Links",
        value = table.concat(ipLinks,"\n")
    })

    for _, field in ipairs(tbl.embeds[1].fields) do
        if (string.len(field.value) > 1024) then
            field.value = string.sub(field.value, 1, 1024)
        end
    end

    local request = {
        failed = function(error) print("discord error", error) end,
        success = function(code, body, headers)
            if (code != 200) then print("discord error", code, body) end
        end,
        method = "post",
        url = self.DISCORD_WEBHOOK_ALTS,
        body = util.TableToJSON(tbl),
        type = "application/json; charset=utf-8"
    }

    CHTTP(request)
end

function PLUGIN:ProxyAlert(client)
    if (!self.DISCORD_WEBHOOK_ALTS or self.DISCORD_WEBHOOK_ALTS == "") then return end

    local ip, steamID = client.ixAltData.ipAddress, client:SteamID64()
    local tbl = {
        embeds = {{
            title = "New player using VPN - "..client:SteamName(),
            description = client:SteamName().." joined WN for the first time, but was using a proxy/VPN. They have been kicked.\n\n"..
            string.format("More info: [%s](https://proxycheck.io/threats/%s) & [%s](https://steamidfinder.com/lookup/%s/)", ip, ip, steamID, steamID),
            color = 16312092,
            timestamp = os.date("%Y-%m-%d %X%z"),
            footer = {
                text = "Bastion Alt Checker for GMod by Gr4Ss"
            },
            author = {
                name = "Bastion Alt Checker"
            }
        }}
    }

    local request = {
        failed = function(error) print("discord error", error) end,
        method = "post",
        url = self.DISCORD_WEBHOOK_ALTS,
        body = util.TableToJSON(tbl),
        type = "application/json; charset=utf-8"
    }

    CHTTP(request)
end

function PLUGIN:NotifyProxyJoin(client)
    local bSend = false
    for _, v in ipairs(player.GetAll()) do
        if (CAMI.PlayerHasAccess(v, "Helix - Proxy Notify")) then
            bSend = true
            v:NotifyLocalized("bastionProxyNotify", client:SteamName())
        end
    end

    return bSend
end