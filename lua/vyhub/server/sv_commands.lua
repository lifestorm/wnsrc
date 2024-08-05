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

hook.Add("vyhub_ready", "vyhub_commands_vyhub_ready", function ()
    VyHub:get_frontend_url(function (url)
        -- !shop
        local function open_shop(ply, args)
            if IsValid(ply) then
                VyHub.Util:open_url(ply, f('%s/shop', url))
            end
        end

        for _, cmd in ipairs(VyHub.Config.commands_shop) do
            VyHub.Util:register_chat_command(cmd, open_shop)
        end

        -- !bans
        local function open_bans(ply, args)
            if IsValid(ply) then
                VyHub.Util:open_url(ply, f('%s/bans', url))
            end
        end

        for _, cmd in ipairs(VyHub.Config.commands_bans) do
            VyHub.Util:register_chat_command(cmd, open_bans)
        end

        -- !warnings
        local function open_warnings(ply, args)
            if IsValid(ply) then
                VyHub.Util:open_url(ply, f('%s/warnings', url))
            end
        end

        for _, cmd in ipairs(VyHub.Config.commands_warnings) do
            VyHub.Util:register_chat_command(cmd, open_warnings)
        end

        -- !news
        local function open_news(ply, args)
            if IsValid(ply) then
                VyHub.Util:open_url(ply, f('%s/', url))
            end
        end

        for _, cmd in ipairs(VyHub.Config.commands_news) do
            VyHub.Util:register_chat_command(cmd, open_news)
        end

        -- !user
        local function open_profile(ply, args)
            if IsValid(ply) and args[1] then
                other_ply = VyHub.Util:get_player_by_nick(args[1])

                if IsValid(other_ply) then
                    VyHub.Util:open_url(ply, f('%s/profile/steam/%s', url, other_ply:SteamID64()))
                end
            end
        end

        for _, cmd in ipairs(VyHub.Config.commands_profile) do
            VyHub.Util:register_chat_command(cmd, open_profile)
        end
    end)
end)

