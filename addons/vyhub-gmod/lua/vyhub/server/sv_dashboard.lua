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

VyHub.Dashboard = VyHub.Dashboard or {}
VyHub.Dashboard.last_update = VyHub.Dashboard.last_update or {}
VyHub.Dashboard.data = VyHub.Dashboard.data or {}

util.AddNetworkString("vyhub_dashboard")
util.AddNetworkString("vyhub_dashboard_reload")

function VyHub.Dashboard:reset()
    VyHub.Dashboard.data = {}
    VyHub.Dashboard.last_update = {}
    net.Start("vyhub_dashboard_reload")
    net.Broadcast()
end

function VyHub.Dashboard:fetch_data(user_id, callback)
    VyHub.API:get("/server/%s/user-activity?morph_user_id=%s", {VyHub.server.id, user_id}, nil, function(code, result)
        callback(result)
    end)
end

function VyHub.Dashboard:get_data(steamid64, callback)
    if VyHub.Dashboard.data[steamid64] == nil or VyHub.Dashboard.last_update[steamid64] == nil or os.time() - VyHub.Dashboard.last_update[steamid64] > 30 then
        VyHub.Player:get(steamid64, function (user)
            if user then
                VyHub.Dashboard:fetch_data(user.id, function (data)
                    VyHub.Dashboard.data[steamid64] = data
                    VyHub.Dashboard.last_update[steamid64] = os.time()

                    callback(VyHub.Dashboard.data[steamid64])
                end)
            end
        end)
    else
        callback(VyHub.Dashboard.data[steamid64])
    end
end


function VyHub.Dashboard:get_permissions(ply)
    return {
        warning_show = VyHub.Player:check_property(ply, 'warning_show'),
        warning_edit = VyHub.Player:check_property(ply, 'warning_edit'),
        warning_delete = VyHub.Player:check_property(ply, 'warning_delete'),
        ban_show = VyHub.Player:check_property(ply, 'ban_show'),
        ban_edit = VyHub.Player:check_property(ply, 'ban_edit'),
    }
end

net.Receive("vyhub_dashboard", function(_, ply)
    if not IsValid(ply) then return end

    VyHub.Dashboard:get_data(ply:SteamID64(), function (users)
        local users_json = json.encode(users)
        local users_json_compressed = util.Compress(users_json)
        local users_json_compressed_len = #users_json_compressed
        local perms = VyHub.Dashboard:get_permissions(ply)
        local perms_json = json.encode(perms)

        net.Start("vyhub_dashboard")
            net.WriteUInt(users_json_compressed_len, 16)
            net.WriteData(users_json_compressed, users_json_compressed_len)
            net.WriteString(perms_json)
	    net.Send(ply)
    end)
end)

local function open_dashboard(ply, args)
    if ply and IsValid(ply) then
        ply:ConCommand("vh_dashboard")
    end
end


hook.Add("vyhub_ready", "vyhub_dashboard_vyhub_ready", function ()
    for _, cmd in ipairs(VyHub.Config.commands_dashboard) do
        VyHub.Util:register_chat_command(cmd, open_dashboard)
    end
end)

hook.Add("vyhub_dashboard_data_changed", "vyhub_dahboard_vyhub_dashboard_data_changed", function ()
    VyHub.Dashboard:reset()
end)