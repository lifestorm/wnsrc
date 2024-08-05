--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

eProtect = eProtect or {}

eProtect.config = eProtect.config or {}

eProtect.config["language"] = "en"

eProtect.config["prefix"] = "[eProtect] "

eProtect.config["storage_type"] = "mysql"-- (sql_local or mysql)

eProtect.config["disablehttplogging"] = false -- If a DRM is ran after eProtect it could break if they check for HTTP modifications! If so make this true.

eProtect.config["ignoreDRM"] = false

eProtect.config["punishMaliciousIntent"] = true

eProtect.config["disabledModules"] = {
    ["identifier"] = false,
    ["detection_log"] = false,
    ["net_limiter"] = false,
    ["net_logger"] = false,
    ["exploit_patcher"] = false,
    ["exploit_finder"] = false,
    ["fake_exploits"] = false,
    ["data_snooper"] = false
}

eProtect.config["permission"] = {
    ["owner"] = true,
    ["superadmin"] = true,
    ["community_manager"] = true,
    ["headofstaff"] = true
}