--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- VyHub Server Config
-- BEWARE: Additional config values can be set in data/vyhub/config.json with the `vh_config <key> <value>` console command.
--         The configuration in this file is overwritten by the configuration in data/vyhub/config.json

-- ONLY SET THE 3 FOLLOWING OPTIONS IF YOU KNOW WHAT YOU ARE DOING!
-- PLEASE FOLLOW THE INSTALLATION INSTRUCTIONS HERE: https://docs.vyhub.net/latest/game/gmod/#installation
VyHub.Config.api_url = "" -- https://api.vyhub.app/<name>/v1
VyHub.Config.api_key = "" -- Admin -> Settings -> Server -> Setup
VyHub.Config.server_id = "" -- Admin -> Settings -> Server -> Setup

-- Prevent script execution as reward
-- Rewards that want to execute a script will not work if this is enabled.
VyHub.Config.reward_disable_scripts = false 
-- Whitelsit for executed reward commands 
-- If this table has entries, only commands matching the given patterns are executed
-- Patterns: https://wiki.facepunch.com/gmod/Patterns
-- Example: { "^ulx adduser %l+ %l+$" } -> Allows a command like "ulx adduser username groupname"
VyHub.Config.reward_command_whitelist = {}

-- Player groups are checked every X seconds
VyHub.Config.player_refresh_time = 120
-- Groups are refreshed every X seconds
VyHub.Config.group_refresh_time = 300
-- Every X seconds, an advert message is shown.
VyHub.Config.advert_interval = 180 

-- Printed before every advert line
VyHub.Config.advert_prefix = "[★] " 

-- Disable group sync
VyHub.Config.group_disable_sync = false 

-- Disable override of admin mod bans (ULX, SAM, ServerGuard, xAdmin, ...)
VyHub.Config.ban_disable_sync = false
-- Replace ULib ban list with VyHub bans
VyHub.Config.replace_ulib_bans = false

-- Commands that open the shop page
VyHub.Config.commands_shop = { '!shop' }
-- Commands that open the bans page
VyHub.Config.commands_bans = { '!bans' }
-- Commands that open the warnings page
VyHub.Config.commands_warnings = { '!warnings' }
-- Commands that open the news page
VyHub.Config.commands_news = { '!news' }
-- Commands that open the profile page of a user (Usage: !user <user>)
VyHub.Config.commands_profile = { '!user' }
-- Commands to warn a user (Usage: !warn <user> <reason>)
VyHub.Config.commands_warn = { '!warn' }
-- Commands to open the dashboard
VyHub.Config.commands_dashboard = { '!dashboard' }

-- Customize the ban message that banned players see when trying to connect
VyHub.Config.ban_message = ">>> Ban Message <<<" .. "\n\n"
.. VyHub.lang.other.reason .. ": %reason%" .. "\n" 
.. VyHub.lang.other.ban_date .. ": %ban_date%" .. "\n" 
.. VyHub.lang.other.unban_date .. ": %unban_date%" .. "\n" 
.. VyHub.lang.other.admin .. ": %admin%" .. "\n" 
.. VyHub.lang.other.id .. ": %id%" .. "\n\n" 
.. VyHub.lang.other.unban_url .. ": %unban_url%" .. "\n\n" 