--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- This is the default language! 76561198002319953
if CLIENT then
    slib.setLang("eprotect", "en", "sc-preview", "Screenshot Preview - ")
    slib.setLang("eprotect", "en", "net-info", "Net Info - ")
    slib.setLang("eprotect", "en", "ip-info", "IP Info - ")
    slib.setLang("eprotect", "en", "id-info", "ID Info - ")
    slib.setLang("eprotect", "en", "ip-correlation", "IP Correlation - ")
    slib.setLang("eprotect", "en", "table-viewer", "Table Viewer")

    slib.setLang("eprotect", "en", "tab-general", "General")
    slib.setLang("eprotect", "en", "tab-identifier", "Identifier")
    slib.setLang("eprotect", "en", "tab-detectionlog", "Detection Log")
    slib.setLang("eprotect", "en", "tab-netlimiter", "Net Limiter")
    slib.setLang("eprotect", "en", "tab-netlogger", "Net Logger")
    slib.setLang("eprotect", "en", "tab-httplogger", "HTTP Logger")
    slib.setLang("eprotect", "en", "tab-exploitpatcher", "Exploit Patcher")
    slib.setLang("eprotect", "en", "tab-exploitfinder", "Exploit Finder")
    slib.setLang("eprotect", "en", "tab-fakeexploits", "Fake Exploits")
    slib.setLang("eprotect", "en", "tab-datasnooper", "Data Snooper")

    slib.setLang("eprotect", "en", "player-list", "Player List")

    slib.setLang("eprotect", "en", "ratelimit", "Ratelimit")
    slib.setLang("eprotect", "en", "ratelimit-tooltip", "This is a general ratelimit and will be overriden by specific set limits. (Xs/Y)")

    slib.setLang("eprotect", "en", "timeout", "Timeout")
    slib.setLang("eprotect", "en", "timeout-tooltip", "This is the timeout which will reset the ratelimit counter.")
    
    slib.setLang("eprotect", "en", "overflowpunishment", "Overflow Punishment")
    slib.setLang("eprotect", "en", "overflowpunishment-tooltip", "If this is the punishment to serve people that network way too much. (1 = kick, 2 = ban, 3 = block)")

    slib.setLang("eprotect", "en", "whitelistergroup", "Whitelister Group")
    slib.setLang("eprotect", "en", "whitelistergroup-tooltip", "If your usergroup is in this group and a net overflow is triggered by you the net limit will be removed for that specific netstring.")

    slib.setLang("eprotect", "en", "bypass-vpn", "Bypass VPN")
    slib.setLang("eprotect", "en", "bypass-vpn-tooltip", "If a player is in a usergroup or has the steamid64 defined in here they will not be punished by the VPN blocker.")

    slib.setLang("eprotect", "en", "bypassgroup", "Bypass Group")
    slib.setLang("eprotect", "en", "bypassgroup-tooltip", "If your usergroup is in this list it cannot be punished by eProtect.")

    slib.setLang("eprotect", "en", "bypass_sids", "Bypass SteamID")
    slib.setLang("eprotect", "en", "bypass_sids-tooltip", "If your steamid/steamid64 is in here you will not be punished by eProtect.")

    slib.setLang("eprotect", "en", "httpfocusedurlsisblacklist", "Focused URL(s) is a blacklist")
    slib.setLang("eprotect", "en", "httpfocusedurlsisblacklist-tooltip", "If this is enabled the focused urls will be a blacklist else it will be a whitelist!")

    slib.setLang("eprotect", "en", "httpfocusedurls", "HTTP Focused URL(s)")
    slib.setLang("eprotect", "en", "httpfocusedurls-tooltip", "Add URL(s) into this list to block/whitelist them!")

    slib.setLang("eprotect", "en", "enable-networking", "Enable networking")
    slib.setLang("eprotect", "en", "disable-networking", "Disable networking")

    slib.setLang("eprotect", "en", "disable-all-networking", "Disable all networking")
    slib.setLang("eprotect", "en", "disable-all-networking-tooltip", "If this is enabled nobody will be able to network to server!")

    slib.setLang("eprotect", "en", "automatic-identifier", "Automatic identifier")
    slib.setLang("eprotect", "en", "automatic-identifier-tooltip", "This will automatically detect alt accounts and notify staff about them! (0 = Disabled, 1 = Notify Staff, [These two will only happend if they are banned] 2 = Kick, 3 = Ban)")

    slib.setLang("eprotect", "en", "block-vpn", "Block VPN")
    slib.setLang("eprotect", "en", "block-vpn-tooltip", "This will automatically detect and kick people who use VPNs")

    slib.setLang("eprotect", "en", "notification-groups", "Notification Groups")
    slib.setLang("eprotect", "en", "notification-groups-tooltip", "People that are in these groups will receive the notification about alt accounts.")

    slib.setLang("eprotect", "en", "player", "Player")
    slib.setLang("eprotect", "en", "net-string", "Net String")
    slib.setLang("eprotect", "en", "url", "URL")
    slib.setLang("eprotect", "en", "called", "Called")
    slib.setLang("eprotect", "en", "len", "Len")
    slib.setLang("eprotect", "en", "type", "Type")
    slib.setLang("eprotect", "en", "punishment", "Punishment")
    slib.setLang("eprotect", "en", "reason", "Reason")
    slib.setLang("eprotect", "en", "info", "Info")
    slib.setLang("eprotect", "en", "activated", "Activated")
    slib.setLang("eprotect", "en", "secure", "Secured")
    slib.setLang("eprotect", "en", "ip", "IP Adress")
    slib.setLang("eprotect", "en", "date", "Date")
    slib.setLang("eprotect", "en", "country-code", "Country code")
    slib.setLang("eprotect", "en", "status", "Status")

    slib.setLang("eprotect", "en", "unknown", "Unknown")
    slib.setLang("eprotect", "en", "secured", "Secured")

    slib.setLang("eprotect", "en", "check-ids", "Check ID(s)")
    slib.setLang("eprotect", "en", "correlate-ip", "Correlate IP(s)")
    slib.setLang("eprotect", "en", "family-share-check", "Check Family Share")

    slib.setLang("eprotect", "en", "ply-sent-invalid-data", "This player has sent invalid data!")
    slib.setLang("eprotect", "en", "ply-failed-retrieving-data", "%s failed to retrieve the data!")

    slib.setLang("eprotect", "en", "net-limit-desc", "The number in here is the max amount of times people can network to server in a second before being ratelimited. (0 = Use general limit, -1 = No limit)")

    slib.setLang("eprotect", "en", "capture", "Screenshot")
    slib.setLang("eprotect", "en", "check-ips", "Check IP(s)")
    slib.setLang("eprotect", "en", "fetch-data", "Fetch Data")
    
    slib.setLang("eprotect", "en", "patched-exploit", "Patched Exploit")
    slib.setLang("eprotect", "en", "fake-exploit", "Fake Exploit")
    slib.setLang("eprotect", "en", "net-overflow", "Net Overflow")
    slib.setLang("eprotect", "en", "exploit-menu", "Exploit Menu")
    slib.setLang("eprotect", "en", "alt-detection", "Alt Detection")

    slib.setLang("eprotect", "en", "banned", "Banned")
    slib.setLang("eprotect", "en", "kicked", "Kicked")
    slib.setLang("eprotect", "en", "notified", "Notified")

    slib.setLang("eprotect", "en", "copied_clipboard", "Copied to clipboard")

    slib.setLang("eprotect", "en", "page_of_page", "Page %s/%s")
    slib.setLang("eprotect", "en", "previous", "Previous")
    slib.setLang("eprotect", "en", "next", "Next")
elseif SERVER then
    slib.setLang("eprotect", "en", "correlated-ip", "Correlated IP")
    slib.setLang("eprotect", "en", "family-share", "Family Share")

    slib.setLang("eprotect", "en", "invalid-player", "This player is invalid!")
    slib.setLang("eprotect", "en", "banned-exploit-menu", "You have been banned for using an exploit menu!")
    slib.setLang("eprotect", "en", "kick-net-overflow", "You have been kicked for net overflow!")
    slib.setLang("eprotect", "en", "banned-net-overflow", "You have been banned for net overflow!")
    slib.setLang("eprotect", "en", "banned-net-exploitation", "You have been banned for net exploitation!")
    slib.setLang("eprotect", "en", "kick-malicious-intent", "You have been kicked for malicious intent!")
    slib.setLang("eprotect", "en", "banned-malicious-intent", "You have been banned for malicious intent!")

    slib.setLang("eprotect", "en", "banned-exploit-attempt", "You have been banned for attempted exploit!")

    slib.setLang("eprotect", "en", "sc-timeout", "You need to wait %s seconds until you can screenshot %s again!")
    slib.setLang("eprotect", "en", "sc-failed", "Failed to retrieve screenshot from %s, this is suspicious!")

    slib.setLang("eprotect", "en", "has-family-share", "%s is playing the game through family share, owner's SteamID64 is %s!")
    slib.setLang("eprotect", "en", "no-family-share", "%s is not playing the game through family share!")
    slib.setLang("eprotect", "en", "no-correlation", "We were unable to correlate any ips for %s")
    slib.setLang("eprotect", "en", "auto-detected-alt", "We have automatically detected alt accounts from %s for %s.")
    slib.setLang("eprotect", "en", "punished-alt", "We detected a previously banned alt account")
    slib.setLang("eprotect", "en", "vpn-blocked", "VPNs are blocked on this server")

    slib.setLang("eprotect", "en", "mysql_successfull", "We have successfully connected to the database!")
    slib.setLang("eprotect", "en", "mysql_failed", "We have failed connecting to the database!")
end