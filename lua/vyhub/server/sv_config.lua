--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local f = string.format

function VyHub.Config:load_cache_config()
    local ccfg = VyHub.Cache:get("config")

    if ccfg != nil and #table.GetKeys(ccfg) > 0 then
        VyHub.Config = table.Merge(VyHub.Config, ccfg)
        VyHub:msg(f("Loaded cache config values: %s", table.concat(table.GetKeys(ccfg), ', ')))
    end
end

concommand.Add("vh_setup", function (ply, _, args)
    if not VyHub.Util:is_server(ply) then return end

    if not args[1] or not args[2] or not args[3] then return end

    local ccfg = VyHub.Cache:get("config")

    if not istable(ccfg) then
        ccfg = {}
    end

    ccfg["api_key"] = args[1]
    ccfg["api_url"] = args[2]
    ccfg["server_id"] = args[3]

    VyHub.Cache:save("config", ccfg)

    for key, value in pairs(ccfg) do
        VyHub.Config[key] = value
    end

    VyHub:msg(f("Successfully set initial config, please wait up to one minute for VyHub to initialize (%s, %s, %s)", args[1], args[2], args[3]))
end)

concommand.Add("vh_config", function (ply, _, args)
    if not VyHub.Util:is_server(ply) then return end

    local ccfg = VyHub.Cache:get("config")

    if not args[1] or not args[2] then 
        if istable(ccfg) then
            VyHub:msg("Additional config options:")
            PrintTable(ccfg)
        else
            VyHub:msg("No additional config options set.")
        end
        return
    end

    local key = args[1]
    local value = args[2]

    if not istable(ccfg) then
        ccfg = {}
    end

    if value == "false" then
        value = false
    elseif value == "true" then
        value = true
    end

    ccfg[key] = value
    VyHub.Cache:save("config", ccfg)

    VyHub.Config[key] = value

    VyHub:msg(f("Successfully set config value %s.", key))
end)

concommand.Add("vh_config_reset", function (ply)
    if not VyHub.Util:is_server(ply) then return end

    VyHub.Cache:save("config", {})

    VyHub:msg(f("Successfully cleared additional config.", key))
end)