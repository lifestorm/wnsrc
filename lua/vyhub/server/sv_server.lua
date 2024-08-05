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

VyHub.Server = VyHub.Server or {}

VyHub.Server.extra_defaults = {
    res_slots = 0,
    res_slots_keep_free = false,
    res_slots_hide = false,
}

VyHub.Server.reserved_slot_plys = VyHub.Server.reserved_slot_plys or {}

function VyHub.Server:get_extra(key)
    if VyHub.server.extra != nil and VyHub.server.extra[key] != nil then
        return VyHub.server.extra[key]
    end

    return VyHub.Server.extra_defaults[key]
end

function VyHub.Server:update_status()
    local user_activities = {}

    for _, ply in ipairs(player.GetHumans()) do
        local id = ply:VyHubID()

        if id and string.len(id) == 36 then
            local tt = string.FormattedTime( ply:TimeConnected() )

            table.insert(user_activities, { user_id = id, extra = { 
                Score = ply:Frags(), 
                Deaths = ply:Deaths(), 
                Nickname = ply:Nick(),
                Playtime = f('%02d:%02d:%02d', tt.h, tt.m, tt.s), 
                Ping = f('%i ms', ply:Ping()),
            }})
        end
    end

    local data = {
        users_max = VyHub.Server.max_slots_visible,
        users_current = #player.GetAll(),
        map = game.GetMap(),
        is_alive = true,
        user_activities = user_activities,
    }

    VyHub:msg(f("Updating status: %s", json.encode(data)), "debug")

    VyHub.API:patch(
        '/server/%s',
        {VyHub.server.id},
        data,
        function ()
            hook.Run("vyhub_dashboard_data_changed") 
        end,
        function ()
            VyHub:msg("Could not update server status.", "error")
        end
    )
end

function VyHub.Server:update_max_slots()
	RunConsoleCommand("sv_visiblemaxplayers", VyHub.Server.max_slots_visible)
end

function VyHub.Server:init_slots()
    VyHub.Server.max_slots = game.MaxPlayers() - VyHub.Server:get_extra("res_slots")
    VyHub.Server.max_slots_visible = VyHub.Server.max_slots

    if VyHub.Server:get_extra("res_slots_hide") then
		VyHub.Server:update_max_slots()

		hook.Add("PlayerDisconnected", "vyhub_server_PlayerDisconnected", function(ply)
			timer.Create("vyhub_slots", 0.5, 20, function()
				if not IsValid(ply) then
					timer.Remove("vyhub_slots")
					VyHub.Server:update_max_slots()
				end
			end)
		end)
	else
		VyHub.Server.max_slots_visible = game.MaxPlayers()
	end
end

function VyHub.Server:can_use_rslot(ply)
    if not IsValid(ply) or ply:IsBot() then
        return false
    end

    if table.HasValue(VyHub.Server.reserved_slot_plys, ply:SteamID64()) then
        return true
    end

    local group = VyHub.Player:get_group(ply)

    if group != nil then
        if group.properties.reserved_slot_use != nil then
            return group.properties.reserved_slot_use.granted
        end
    end

    return false
end

function VyHub.Server:handle_ply_connect(ply)
    if IsValid(ply) then
        if #player.GetHumans() > VyHub.Server.max_slots then
			if VyHub.Server:can_use_rslot(ply) then
				if VyHub.Server:get_extra("res_slots_keep_free") then
					local tokick = nil

					for _, v in ipairs(player.GetHumans()) do
						if v:SteamID64() != ply:SteamID64() and not VyHub.Server:can_use_rslot(v) then
							if tokick == nil or (IsValid(tokick) and v:TimeConnected() < tokick:TimeConnected()) then
								tokick = v
							end
						end
					end

					if tokick and IsValid(tokick) then
						tokick:Kick(VyHub.lang.rslots.kick)
					else
                        ply:Kick(VyHub.lang.rslots.full)
					end
				end
			else
				ply:Kick(VyHub.lang.rslots.full_no_slot)
			end
		end
    end
end

hook.Add("vyhub_ready", "vyhub_server_vyhub_ready", function ()
    VyHub.Server:init_slots()
    VyHub.Server:update_status()

    timer.Create("vyhub_status_update", 60, 0, function ()
        VyHub.Server:update_status()
    end)

    hook.Add("vyhub_reward_post_connect", "vyhub_server_vyhub_reward_post_connect", function (ply)
        VyHub.Server:handle_ply_connect(ply)
    end)
end)