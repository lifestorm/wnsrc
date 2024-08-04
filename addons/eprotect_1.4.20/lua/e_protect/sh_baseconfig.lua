--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

------------------------------------------------------                                   
-- NO NOT TOUCH ANYTHING IN HERE!!!!!!!!!                                                  
------------------------------------------------------                  
              
eProtect = eProtect or {}

eProtect.BaseConfig = eProtect.BaseConfig or {}

eProtect.BaseConfig["disable-all-networking"] = {false, 1}

eProtect.BaseConfig["automatic-identifier"] = {1, 2, {min = 0, max = 3}}

eProtect.BaseConfig["block-vpn"] = {false, 3}

eProtect.BaseConfig["bypass-vpn"] = {{["76561198002319944"] = true}, 4, function()
    local list = {}

    for k,v in ipairs(player.GetAll()) do
        local sid64 = v:SteamID64()
        if !sid64 then continue end
        list[sid64] = true
    end

    if CAMI and CAMI.GetUsergroups then
        for k,v in pairs(CAMI.GetUsergroups()) do
            list[k] = true
        end
    end
    
    return list
end}


eProtect.BaseConfig["notification-groups"] = {{["superadmin"] = true}, 5, CAMI and CAMI.GetUsergroups and function() local tbl = {} for k,v in pairs(CAMI.GetUsergroups()) do tbl[k] = true end return tbl end or {}}

eProtect.BaseConfig["ratelimit"] = {500, 6, {min = -1, max = 100000}}

eProtect.BaseConfig["timeout"] = {3, 7, {min = 0, max = 5000}}

eProtect.BaseConfig["overflowpunishment"] = {2, 8, {min = 0, max = 3}}

eProtect.BaseConfig["whitelistergroup"] = {{}, 9, function()
    local list = {}

    if CAMI and CAMI.GetUsergroups then
        for k,v in pairs(CAMI.GetUsergroups()) do
            list[k] = true
        end
    end

    return list
end}

eProtect.BaseConfig["bypassgroup"] = {{}, 10, function()
    local list = {
        ["superadmin"] = true,
        ["owner"] = true
    }

    if CAMI and CAMI.GetUsergroups then
        for k,v in pairs(CAMI.GetUsergroups()) do
            list[k] = true
        end
    end

    return list
end}

eProtect.BaseConfig["bypass_sids"] = {{["76561198002319944"] = true}, 11, function()
    local list = {}

    for k,v in ipairs(player.GetAll()) do
        local sid64 = v:SteamID64()
        if !sid64 then continue end
        list[sid64] = true
    end

    return list
end}

eProtect.BaseConfig["httpfocusedurlsisblacklist"] = {true, 12}

eProtect.BaseConfig["httpfocusedurls"] = {{}, 13, function()
    local list = {}
    
    local tbl_http = eProtect.data["requestedHTTP"] and eProtect.data["requestedHTTP"].result or {}

    if tbl_http then
        for k,v in ipairs(tbl_http) do
            list[v.link] = true
        end
    end

    return list
end}

------------------------------------------------------           
-- NO NOT TOUCH ANYTHING IN HERE!!!!!!!!!                                                  
------------------------------------------------------76561198002319944