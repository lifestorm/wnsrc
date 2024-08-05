--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- DEFAULTS
VyHub.Config.date_format = VyHub.Config.date_format or "%Y-%m-%d %H:%M:%S %z"

if SERVER then
    VyHub.Config.advert_interval = VyHub.Config.advert_interval or 180 
    VyHub.Config.advert_prefix = VyHub.Config.advert_prefix or "[★] " 

    -- Do not allow too small refresh intervals
    if VyHub.Config.player_refresh_time < 5 then
        VyHub.Config.player_refresh_time = 5
    end
    if VyHub.Config.group_refresh_time < 5 then
        VyHub.Config.group_refresh_time = 5
    end

    VyHub.Config.ban_message = VyHub.Config.ban_message or ">>> Ban Message <<<" .. "\n\n"
    .. VyHub.lang.other.reason .. ": %reason%" .. "\n" 
    .. VyHub.lang.other.ban_date .. ": %ban_date%" .. "\n" 
    .. VyHub.lang.other.unban_date .. ": %unban_date%" .. "\n" 
    .. VyHub.lang.other.admin .. ": %admin%" .. "\n" 
    .. VyHub.lang.other.id .. ": %id%" .. "\n\n" 
    .. VyHub.lang.other.unban_url .. ": %unban_url%" .. "\n\n" 

    VyHub.Config.commands_shop = VyHub.Config.commands_shop or { '!shop' }
    VyHub.Config.commands_bans = VyHub.Config.commands_bans or { '!bans' }
    VyHub.Config.commands_warnings = VyHub.Config.commands_warnings or { '!warnings' }
    VyHub.Config.commands_news = VyHub.Config.commands_news or { '!news' }
    VyHub.Config.commands_profile = VyHub.Config.commands_profile or { '!user' }
    VyHub.Config.commands_warn = VyHub.Config.commands_warn or { '!warn' }
    VyHub.Config.commands_dashboard = VyHub.Config.commands_dashboard or { '!dashboard' }

    VyHub.Config.strict_group_sync = VyHub.Config.strict_group_sync or false
end
