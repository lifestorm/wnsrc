--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local hook = hook
local ix = ix
local util = util

local PLUGIN = PLUGIN

PLUGIN.permaBan = {
    -- Crazyman (~Atle/Gr4Ss), code stealing
    ["STEAM_0:1:120921609"] = true,
    ["2.73.226.221"] = true,
    ["2.72.176.41"] = true,
    ["2.132.96.235"] = true,
    ["2.132.103.122"] = true,
    ["2.132.147.172"] = true,
    ["2.132.150.162"] = true,
    ["95.57.132.81"] = true,
    -- carlsmei (~Atle/Gr4Ss), code stealing
    ["STEAM_0:0:216726444"] = true,
    -- Schwarz Kruppzo (~Atle/Gr4Ss), code stealing
    ["STEAM_0:1:44629398"] = true,
    -- KoC (~Atle/Gr4Ss), toxic, ban evasion
    ["76561198017957016"] = true,
    ["76561199123547331"] = true,
    ["73.121.218.83"] = true,
    ["136.144.43.116"] = true,
    ["136.144.43.63"] = true,
    -- Kalingi (Staff vote, Hiros/Gr4Ss), toxic, threatening hacks & blackmail
    ["76561198066620287"] = true,
    ["STEAM_0:1:53177279"] = true,
    ["24.197.171.2"] = true,
    -- Brando (~Atle/Gr4Ss), pedo
    ["STEAM_0:1:54660756"] = true,
    -- Walter (~Atle/Gr4Ss), none
    ["STEAM_0:1:43085888"] = true,
    -- PrplSckz/The Enemy (~Rad/Gr4Ss), forum DDoS
    ["STEAM_0:1:68538156"] = true,
    -- Hackers (~Gr4Ss)
    ["STEAM_0:1:13809165"] = true,
    ["STEAM_0:1:4916602"] = true,
    ["STEAM_0:1:517232907"] = true,
    ["STEAM_0:1:17046093"] = true,
    -- Exploiters
    ["STEAM_0:0:549109050"] = true,
    ["76561199131288084"] = true,
    ["76561199087140341"] = true,
    ["76561199206105794"] = true,
    ["76561198874018211"] = true,
    ["109.252.109.68"] = true,
    ["76561199121843993"] = true,
	-- Zeroday / Newport Gaming - Sketchy dude + some hacking & exploiting (~M!NT/RAD)
	["172.82.32.147"] = true,
	["76561199441966033"] = true,
    -- Cazo
    ["82.0.106.136"] = true,
    ["76561199150421701"] = true,
    -- lqut (Translating ISIS Propaganda) (~M!NT/RAD)
    ["STEAM_0:0:173208852"] = true,
	["5.30.219.71"] = true,
	["76561198306683432"] = true,
	-- madbluntz (doxxing, minging, ddosing, etc etc) (~M!NT)
    ["176.117.229.107"] = true,
    ["176.117.229.107"] = true,
    ["178.214.250.178"] = true,
    ["46.191.232.69"] = true,
    ["178.168.94.11"] = true,
	["163.182.82.195"] = true,
	["104.231.185.125"] = true,
	["STEAM_0:0:763201893"] = true,
	["STEAM_0:0:629741416"] = true,
	["STEAM_0:1:764405213"] = true,
	["STEAM_0:1:817531224"] = true,
    ["STEAM_0:0:785033797"] = true,
    ["STEAM_0:1:421783352"] = true,
    ["STEAM_0:1:78544439"] = true,
    ["STEAM_0:1:178702634"] = true,
    ["STEAM_0:0:627119036"] = true,
    ["STEAM_0:0:585787645"] = true,
    ["STEAM_0:1:43085888"] = true,
}

hook.Add("CheckPassword", "bastionBanList", function(steamid, networkid)
    if (PLUGIN.permaBan[steamid] or PLUGIN.permaBan[util.SteamIDFrom64(steamid)] or PLUGIN.permaBan[networkid]) then
        ix.log.AddRaw("[BANS] "..steamid.." ("..networkid..") tried to connect but is hard-banned.")
        return false
    end
end)
