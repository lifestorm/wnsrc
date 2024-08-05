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
local json = VyHub.Lib.json

VyHub.Statistic = VyHub.Statistic or {}
VyHub.Statistic.playtime = VyHub.Statistic.playtime or {}
VyHub.Statistic.attr_def = VyHub.Statistic.attr_def or nil

function VyHub.Statistic:save_playtime()
    VyHub:msg(f("Saved playtime statistics: %s", json.encode(VyHub.Statistic.playtime)), "debug")

    VyHub.Cache:save("playtime", VyHub.Statistic.playtime)
end

function VyHub.Statistic:add_one_minute()
    for _, ply in ipairs(player.GetHumans()) do
        local steamid = ply:SteamID64()
        ply:VyHubID(function (user_id)
            if user_id == nil or string.len(user_id) < 10 then
                VyHub:msg(f("Could not add playtime for user %s", steamid))
                return
            end

            VyHub.Statistic.playtime[user_id] = VyHub.Statistic.playtime[user_id] or 0
            VyHub.Statistic.playtime[user_id] = VyHub.Statistic.playtime[user_id] + 60
        end)
    end

    VyHub.Statistic:save_playtime()
end

function VyHub.Statistic:send_playtime()
    VyHub.Statistic:get_or_create_attr_definition(function (attr_def)
        if attr_def == nil then
            VyHub:msg("Could not send playtime statistics to API.", "warning")
            return
        end

        local user_ids = table.GetKeys(VyHub.Statistic.playtime)
            
        timer.Create("vyhub_send_stats", 0.3, table.Count(user_ids), function ()
            local i =  table.Count(user_ids)
            local user_id = user_ids[i]

            if user_id != nil then
                local seconds = VyHub.Statistic.playtime[user_id]
                table.remove(user_ids, i)

                if seconds != nil and seconds > 0 then
                    local hours = math.Round(seconds / 60 / 60, 2)

                    if hours > 0 then
                        if string.len(user_id) < 10 then
                            VyHub.Statistic.playtime[user_id] = nil
                            return
                        end

                        VyHub.API:post("/user/attribute/", nil, {
                            definition_id = attr_def.id,
                            user_id = user_id,
                            serverbundle_id = VyHub.server.serverbundle.id,
                            value = tostring(hours),
                        }, function (code, result)
                            VyHub.Statistic.playtime[user_id] = nil
                            VyHub.Statistic:save_playtime()
                        end, function (code, reason)
                            if code == 404 then
                                VyHub.Statistic.playtime[user_id] = nil
                                VyHub.Statistic:save_playtime()
                            end
                            
                            VyHub:msg(f("Could not send %s seconds playtime of %s to API.", seconds, user_id), "warning")
                        end)
                    end
                else
                    VyHub.Statistic.playtime[user_id] = nil
                end
            end
        end)
    end)
end

function VyHub.Statistic:get_or_create_attr_definition(callback)
    local function cb_wrapper(attr_def)
        VyHub.Statistic.attr_def = attr_def

        callback(attr_def)
    end

    if VyHub.Statistic.attr_def != nil then
        callback(VyHub.Statistic.attr_def)
        return
    end

    VyHub.API:get("/user/attribute/definition/%s", { "playtime" }, nil, function (code, result)
        VyHub.Cache:save("playtime_attr_def", result)
        cb_wrapper(result)
    end, function (code, reason)
        if code != 404 then
            local attr_def = VyHub.Cache:get("playtime_attr_def")

            cb_wrapper(attr_def)
        else
            VyHub.API:post("/user/attribute/definition/", nil, {
                name = "playtime",
                title = "Play Time",
                unit = "Hours",
                type = "ACCUMULATED",
                accumulation_interval = "day",
                unspecific = "true",
            }, function (code, result)
                VyHub.Cache:save("playtime_attr_def", result)
                cb_wrapper(result)
            end, function (code, reason)
                cb_wrapper(nil)
            end)
        end
    end)
end


hook.Add("vyhub_ready", "vyhub_statistic_vyhub_ready", function ()
    VyHub.Statistic.playtime = VyHub.Cache:get("playtime") or {}

    VyHub.Statistic:send_playtime()

    timer.Create("vyhub_statistic_playtime_tick", 60, 0, function ()
        VyHub.Statistic:add_one_minute()
    end)

    timer.Create("vyhub_statistic_send_playtime", 3600, 0, function ()
        VyHub.Statistic:send_playtime()
    end)
end)