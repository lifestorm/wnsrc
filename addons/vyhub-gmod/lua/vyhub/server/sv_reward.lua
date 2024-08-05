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

VyHub.Reward = VyHub.Reward or {}
VyHub.Reward.executed_rewards_queue = VyHub.Reward.executed_rewards_queue or {}
VyHub.Reward.executed_rewards = VyHub.Reward.executed_rewards or {}
VyHub.rewards = VyHub.rewards or {}

local RewardEvent = {
    DIRECT = "DIRECT",
    CONNECT = "CONNECT",
    SPAWN = "SPAWN",
    DEATH = "DEATH",
    DISCONNECT = "DISCONNECT",
    DISABLE = "DISABLE",
}

local RewardType = {
    COMMAND = "COMMAND",
    SCRIPT = "SCRIPT",
    CREDITS = "CREDITS",
    MEMBERSHIP = "MEMBERSHIP",
}

function VyHub.Reward:refresh(callback, limit_players, err)
    local user_ids = ""
    local players = limit_players or player.GetHumans()

    for _, ply in ipairs(players) do
        if IsValid(ply) then
            local id = ply:VyHubID()

            if id and string.len(id) == 36 then
                local glue = '&'

                if user_ids == "" then
                    glue = '?'
                end

                user_ids = user_ids .. glue .. 'user_id=' .. id
            end
        end
    end

    if user_ids == "" then
        VyHub.rewards = {}
    else
        local query = f("%s&active=true&serverbundle_id=%s&status=OPEN&for_server_id=%s&foreign_ids=true", user_ids, VyHub.server.serverbundle.id, VyHub.server.id)

        VyHub.API:get('/packet/reward/applied/user' .. query, nil,  nil, 
        function(code, result)
            if limit_players == nil then
                VyHub.rewards = result
                VyHub:msg(f("Found %i users with open rewards.", table.Count(result)), "debug")
            else
                for steamid, arewards in pairs(result) do
                    VyHub.rewards[steamid] = arewards
                end
            end

            if callback then
                callback()
            end
        end, function (code, reason)
            if err then
                err()
            end
        end)
    end
end

function VyHub.Reward:set_executed(areward_id)
    VyHub.Reward.executed_rewards_queue[areward_id] = true
    table.insert(VyHub.Reward.executed_rewards, areward_id)

    VyHub.Reward:save_executed()
end

function VyHub.Reward:save_executed()
    VyHub.Cache:save("executed_rewards_queue", VyHub.Reward.executed_rewards_queue)
end

function VyHub.Reward:send_executed()
    for areward_id, val in pairs(VyHub.Reward.executed_rewards_queue) do
        if val != nil then
            VyHub.API:patch('/packet/reward/applied/%s', { areward_id }, { executed_on = { VyHub.server.id } }, function (code, result)
                VyHub.Reward.executed_rewards_queue[areward_id] = nil
                VyHub.Reward:save_executed()
            end, function (code, reason)
                if code >= 400 and code < 500 then
                    VyHub:msg(f("Could not mark reward %s as executed. Aborting.", areward_id), "error")
                    VyHub.Reward.executed_rewards_queue[areward_id] = nil
                    VyHub.Reward:save_executed()
                end
            end)
        end
    end
end

function VyHub.Reward:exec_rewards(event, steamid)
    steamid = steamid or nil

    local allowed_events = { event }

    local rewards_by_player = VyHub.rewards

    if steamid != nil then
        rewards_by_player = {}
        rewards_by_player[steamid] = VyHub.rewards[steamid]
    else
        if event != RewardEvent.DIRECT then
            return
        end
    end

    if event == RewardEvent.DIRECT then
        table.insert(allowed_events, RewardEvent.DISABLE)
    end

    for steamid, arewards in pairs(rewards_by_player) do
        local ply = player.GetBySteamID64(steamid)

        if not IsValid(ply) then
            VyHub:msg(f("Player %s not valid, skipping.", steamid), "debug")
            continue 
        end

        for _, areward in ipairs(arewards) do
            local se = true
            local reward = areward.reward

            if not table.HasValue(allowed_events, reward.on_event) then
                continue
            end

            if table.HasValue(VyHub.Reward.executed_rewards, areward.id) then
                VyHub:msg(f("Skipped reward %s, because it already has been executed.", areward.id), "debug")
                continue
            end

            local data = reward.data

            if reward.type == RewardType.COMMAND then
                if data.command != nil then
                    local cmd = VyHub.Reward:do_string_replacements(data.command, ply, areward)

                    if VyHub.Config.reward_command_whitelist and #VyHub.Config.reward_command_whitelist > 0 then
                        local matched = false

                        for _, cmd_pattern in ipairs(VyHub.Config.reward_command_whitelist) do
                            if string.match(cmd, cmd_pattern) != nil then
                                matched = true
                                break
                            end    
                        end

                        if not matched then
                            VyHub:msg(f("Failed to execute reward '%s': Command '%s' does not match a command on the whitelist.", reward.name, cmd), "error")
                            continue  
                        end
                    end

                    game.ConsoleCommand(cmd.. "\n")
                end
            elseif reward.type == RewardType.SCRIPT then
                if VyHub.Config.reward_disable_scripts then
                    VyHub:msg(f("Failed to execute reward '%s': Scripts are not allowed on this server. You can enable scripts in sv_config.lua or by entering 'vh_config reward_disable_scripts false' in the server console.", reward.name), "error")
                    continue 
                end

                local lua_str = data.script

                if lua_str != nil then
                    lua_str = VyHub.Reward:do_string_replacements(lua_str, ply, areward)

                    RunString("local PLAYER = player.GetBySteamID64(\"" .. steamid .. "\") " .. lua_str, "vyhub_reward_script")
                end
            else
                VyHub:msg(f("No implementation for reward type %s", reward.type) "warning")
            end

            VyHub:msg(f("Executed reward %s for user %s (%s): %s", reward.type, ply:Nick(), ply:SteamID64(), json.encode(data)))

            if se and reward.once then
                VyHub.Reward:set_executed(areward.id)
            end
        end
    end

    VyHub.Reward:send_executed()
end

function VyHub.Reward:do_string_replacements(inp_str, ply, areward)
    local purchase_amount = "-"

    if areward.applied_packet.purchase != nil then
        purchase_amount = areward.applied_packet.purchase.amount_text
    end

    local replacements = {
        ["user_id"] = ply:VyHubID(), 
        ["nick"] = ply:Nick(), 
        ["steamid64"] = ply:SteamID64(), 
        ["steamid32"] = ply:SteamID(), 
        ["uniqueid"] = ply:UniqueID(), 
        ["applied_packet_id"] = areward.applied_packet_id,
        ["packet_title"] = areward.applied_packet.packet.title,
        ["purchase_amount"] = purchase_amount,
    }

    for k, v in pairs(replacements) do
        inp_str = string.Replace(tostring(inp_str), "%" .. tostring(k) .. "%", tostring(v))
    end

    return inp_str
end

hook.Add("vyhub_ready", "vyhub_reward_vyhub_ready", function ()
    VyHub.Reward.executed_rewards_queue = VyHub.Cache:get("executed_rewards_queue") or {}

    VyHub.Reward:refresh(function ()
        VyHub.Reward:exec_rewards(RewardEvent.DIRECT)
    end)

    timer.Create("vyhub_reward_refresh", 60, 0, function ()
        VyHub.Reward:refresh(function ()
            VyHub.Reward:exec_rewards(RewardEvent.DIRECT)
        end)
    end)

    hook.Add("vyhub_ply_initialized", "vyhub_reward_vyhub_ply_initialized", function(ply)
        local function exec_ply_rewards()
            VyHub.Reward:exec_rewards(RewardEvent.CONNECT, tostring(ply:SteamID64()))
		    hook.Run("vyhub_reward_post_connect", ply)
        end

        VyHub.Reward:refresh(exec_ply_rewards, { ply }, exec_ply_rewards)
	end)

	hook.Add("PlayerSpawn", "vyhub_reward_PlayerSpawn", function(ply) 
		if ply:Alive() then
			VyHub.Reward:exec_rewards(RewardEvent.SPAWN, tostring(ply:SteamID64()))
		end
	end)

    hook.Add("PostPlayerDeath", "vyhub_reward_PostPlayerDeath", function(ply)
        VyHub.Reward:exec_rewards(RewardEvent.DEATH, tostring(ply:SteamID64()))
	end)

    -- Does not work
    hook.Add("PlayerDisconnect", "vyhub_reward_PlayerDisconnect", function(ply)
		if IsValid(ply) then
			VyHub.Reward:exec_rewards(RewardEvent.Disconnect, tostring(ply:SteamID64()))
		end
	end)
end)