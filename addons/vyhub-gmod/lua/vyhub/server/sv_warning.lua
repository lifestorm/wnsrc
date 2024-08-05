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

VyHub.Warning = VyHub.Warning or {}

function VyHub.Warning:create(steamid, reason, processor_steamid)
    processor_steamid = processor_steamid or nil

    VyHub.Player:get(steamid, function (user)
        if user == nil then
            VyHub.Util:print_chat_steamid(processor_steamid, f("<red>Cannot find VyHub user with SteamID %s.</red>", steamid))
            return 
        end

        VyHub.Player:get(processor_steamid, function (processor)
            if processor_steamid != nil and processor == nil then
                return
            end

            local url = '/warning/'

            if processor != nil then
                url = url .. f('?morph_user_id=%s', processor.id)
            end

            VyHub.API:post(url, nil, {
                reason = reason,
                serverbundle_id = VyHub.server.serverbundle.id,
                user_id = user.id
            }, function (code, result)
                VyHub.Ban:refresh()
                VyHub:msg(f("Added warning for player %s: %s", user.username, reason))
                VyHub.Util:print_chat_all(f(VyHub.lang.warning.user_warned, user.username, processor.username, reason))
                VyHub.Util:print_chat_steamid(steamid, f(VyHub.lang.warning.received, processor.username, reason))
                VyHub.Util:play_sound_steamid(steamid, "https://cdn.vyhub.net/sound/negativebeep.wav")
                hook.Run("vyhub_dashboard_data_changed")
            end, function (code, err_reason, _, err_text)
                VyHub:msg(f("Error while adding warning for player %s: %s", user.username, err_text), "error")
                VyHub.Util:print_chat_steamid(processor_steamid, f(VyHub.lang.warning.create_error, user.username, err_text))
            end)
        end)
    end)
end


function VyHub.Warning:delete(warning_id, processor_steamid)
    processor_steamid = processor_steamid or nil

    VyHub.Player:get(processor_steamid, function (processor)
        if not processor then return end

        local url = '/warning/%s'

        if processor != nil then
            url = url .. f('?morph_user_id=%s', processor.id)
        end

        VyHub.API:delete(url, { warning_id }, function (code, result)
            VyHub:msg(f("%s deleted warning %s.", processor.username, warning_id))
            VyHub.Util:print_chat_steamid(processor_steamid, f(VyHub.lang.warning.deleted))
            VyHub.Util:print_chat_steamid(steamid, VyHub.lang.warning.deleted_self)
            hook.Run("vyhub_dashboard_data_changed")
        end, function (code, err_reason, _, err_text)
            VyHub:msg(f("Error while deleteing warning %s: %s", warning_id, err_text), "error")
            VyHub.Util:print_chat_steamid(processor_steamid, f(VyHub.lang.other.error_api, err_text))
        end)
    end)
end

function VyHub.Warning:toggle(warning_id, processor_steamid)
    processor_steamid = processor_steamid or nil

    VyHub.Player:get(processor_steamid, function (processor)
        if not processor then return end

        local url = '/warning/%s/toggle'

        if processor != nil then
            url = url .. f('?morph_user_id=%s', processor.id)
        end

        VyHub.API:patch(url, { warning_id }, nil, function (code, result)
            VyHub:msg(f("%s toggled warning %s.", processor.username, warning_id))
            VyHub.Util:print_chat_steamid(processor_steamid, f(VyHub.lang.warning.toggled))
            VyHub.Util:print_chat_steamid(steamid, VyHub.lang.warning.toggled_self)
            hook.Run("vyhub_dashboard_data_changed")
        end, function (code, err_reason, _, err_text)
            VyHub:msg(f("Error while toggling status of warning %s: %s", warning_id, err_text), "error")
            VyHub.Util:print_chat_steamid(processor_steamid, f(VyHub.lang.other.error_api, err_text))
        end)
    end)
end

local function warn_command(ply, args)
    if not VyHub.Player:check_property(ply, "warning_edit") then
        VyHub.Util:print_chat(ply, VyHub.lang.ply.no_permissions)
        return
    end

    if args[1] and args[2] then 
        local reason = VyHub.Util:concat_args(args, 2)

        local target = VyHub.Util:get_player_by_nick(args[1])

        if target and IsValid(target) then
            local nickparts = string.Explode(' ', target:Nick())

            if #nickparts > 1 then
                nickparts = VyHub.Util:concat_args(nickparts, 2) .. ' '
                reason = string.Replace(reason, nickparts, '')
            end

            VyHub.Warning:create(target:SteamID64(), reason, ply:SteamID64())
        end
    end

    if IsValid(ply) then
        VyHub.Util:print_chat(ply, VyHub.lang.warning.cmd_help)
    end

    return false;
end

hook.Add("vyhub_ready", "vyhub_warning_vyhub_ready", function ()   
    concommand.Add("vh_warn", function(ply, _, args)
        if not args[1] or not args[2] then return end

        if VyHub.Util:is_server(ply) then
            VyHub.Warning:create(args[1], args[2])
        elseif IsValid(ply) then
            if VyHub.Player:check_property(ply, "warning_edit") then
                VyHub.Warning:create(args[1], args[2], ply:SteamID64())
            else
                VyHub.Util:print_chat(ply, VyHub.lang.ply.no_permissions)
            end
        end
    end)

    concommand.Add("vh_warning_toggle", function(ply, _, args)
        if not args[1] then return end

        local warning_id = args[1]

        if VyHub.Util:is_server(ply) then
            VyHub.Warning:toggle(warning_id)
        elseif IsValid(ply) then
            if VyHub.Player:check_property(ply, "warning_edit") then
                VyHub.Warning:toggle(warning_id, ply:SteamID64())
            else
                VyHub.Util:print_chat(ply, VyHub.lang.ply.no_permissions)
            end
        end
    end)

    concommand.Add("vh_warning_delete", function(ply, _, args)
        if not args[1] then return end

        local warning_id = args[1]

        if VyHub.Util:is_server(ply) then
            VyHub.Warning:delete(warning_id)
        elseif IsValid(ply) then
            if VyHub.Player:check_property(ply, "warning_delete") then
                VyHub.Warning:delete(warning_id, ply:SteamID64())
            else
                VyHub.Util:print_chat(ply, VyHub.lang.ply.no_permissions)
            end
        end
    end)

    for _, cmd in ipairs(VyHub.Config.commands_warn) do
        VyHub.Util:register_chat_command(cmd, warn_command)
    end
end)