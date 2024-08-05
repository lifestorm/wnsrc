--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local function handleIPLoggin(ply, ip)
    local sid64 = ply:SteamID64()
    http.Fetch("http://ip-api.com/json/"..ip, function(json)
        json = util.JSONToTable(json)
        local result = json["countryCode"]

        if !result then result = "N/A" end

        eProtect.registerIP(sid64, ip, result)
    end, function()
        eProtect.registerIP(sid64, ip, "N/A")
    end)
end

hook.Add("PlayerInitialSpawn", "eP:IPLogging", function(ply)
    if ply:IsBot() or eProtect.config["disabledModules"]["identifier"] then return end
    local ip = ""
    
    for k,v in ipairs(string.ToTable(ply:IPAddress())) do
        if v == ":" then break end

        ip = ip..v
    end

    handleIPLoggin(ply, ip)
end)