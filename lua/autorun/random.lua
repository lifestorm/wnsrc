--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local INTENSE_WHITE = Color(255,255,255)
local PEPPER_WHITE = Color(243,227,219)
local WHITE = Color(240,240,240)
local SILVER = Color(183,208,211)
local LIGHT_LIGHT_GREY = Color(200,200,200)
local LIGHT_GREY = Color(160,160,160)
local GREY = Color(120,120,120)
local THUNDER_GREY = Color(68,71,77)
local DARK_GREY = Color(70,70,70)
local BLACK = Color(24,24,24)
local VERY_BLACK = Color(0,0,0)

local RED_RACE = Color(255,37,37)
local RED = Color(156,25,25)
local INTENSE_RED = Color(255,0,0)
local DARK_RED = Color(122,14,14)
local BURGUNDY = Color(41,3,3)
local PINK = Color(225,14,185)
local BEIGE = Color(245,245,220)

local CREAM = Color(255,255,204)
local DARK_CREAM = Color(85,85,62)
local YELLOW = Color(225,195,0)
local INTENSE_YELLOW = Color(255,255,0)
local NEON_YELLOW = Color(195,255,0)
local GOLDEN = Color(130,116,24)
local ORANGE = Color(229,136,37)
local SOLARIS_ORANGE = Color(255,97,0)
local INTENSE_ORANGE = Color(255,131,0)

local GREEN = Color(12,127,12)
local DARK_GREEN = Color(22,80,22)
local LIME = Color(39,190,52)
local EMERALD = Color(21,132,84)
local SWAMP = Color(13,61,48)
local INTENSE_GREEN = Color(0,255,0)

local DARK_DARK_BLUE = Color(0,3,15)
local DARK_BLUE = Color(13,14,75)
local BLUE = Color(10,41,95)
local LIGHT_BLUE = Color(3,119,177)
local INTENSE_LIGHT_BLUE = Color(0,255,255)
local INTENSE_BLUE = Color(0,0,255)
local ICE = Color(130,233,238)
local ICE2 = Color(0,151,182)
local TURQUOISE = Color(45,201,186)

local PURPLE = Color(54,10,90)
local DARK_PURPLE = Color(29,15,59)
local MAGENTA = Color(111,25,209)
local INTENSE_PURPLE = Color(255,0,255)

local MIDGET_GREEN = Color(159,203,153)
local MIDGET_BLUE = Color(85,163,211)

local GM_MEDIUM_BLUE = Color(94,115,156)
local GM_LIGHT_DRIFTWOOD = Color(169,158,136)
local GM_DARK_CARMINE_RED = Color(88,14,12)
local GM_NIGHTMIST_AUBURN = Color(75,51,53)
local GM_DARK_JADE_GREEN = Color(9,54,60)
local GM_TORCH_RED = Color(194,33,26)

local LIGHT_SADDLE = Color(216,200,188)
local MEDIUM_BERRY = Color(99,39,60)
local IVORY = Color(223,190,157)
local MEDIUM_WILLOW = Color(49,75,87)
local LIGHT_WILLOW = Color(135,168,180)
local SILVER_FROST = Color(172,186,197)

CreateConVar( "ctv_selective_color_enabled", 1, FCVAR_ARCHIVE, "", 0, 1)
CreateConVar( "ctv_random_skin_enabled", 1, FCVAR_ARCHIVE, "", 0, 1)
CreateConVar( "ctv_random_bg_enabled", 1, FCVAR_ARCHIVE, "", 0, 1)
CreateConVar( "ctv_usestormfoxtime", 1, FCVAR_ARCHIVE, "", 0, 1)

local function GetAllSkins(path)
    local skinss = file.Find("materials/models/ctvehicles/" .. path .. "*.vmt", "GAME")

    for k,v in pairs(skinss) do
        skinss[k] = tonumber(string.match(skinss[k] , "%d+"))
        if skinss[k] == nil then skinss[k] = 0 end
    end
    return skinss
end

local colors = {["models/ctvehicles/chevrolet/corvette_c8.mdl"]={BLUE, RED, ORANGE, LIGHT_BLUE, WHITE, BLACK, GREY, YELLOW},
                ["models/ctvehicles/bmw/m8_f92.mdl"]={BLUE, BURGUNDY, BLACK, WHITE, RED, EMERALD, ORANGE, LIGHT_GREY, DARK_GREEN},
                ["models/ctvehicles/mclaren/speedtail.mdl"]={ICE, SILVER, LIGHT_GREY, LIGHT_LIGHT_GREY, BLACK, DARK_BLUE, BLUE, RED_RACE, PURPLE, ORANGE},
                ["models/ctvehicles/rolls_royce/cullinan.mdl"]={RED, ORANGE, BLACK, SILVER, GREY, LIGHT_GREY, DARK_GREY, WHITE, BLUE, DARK_BLUE},
                ["models/ctvehicles/alfa_romeo/carabo_concept.mdl"]={INTENSE_PURPLE, MAGENTA, INTENSE_LIGHT_BLUE, INTENSE_BLUE, INTENSE_GREEN, INTENSE_ORANGE, NEON_YELLOW, INTENSE_YELLOW, INTENSE_RED, INTENSE_WHITE},
                ["models/ctvehicles/cadillac/one.mdl"]={VERY_BLACK},
                ["models/ctvehicles/gaz/13.mdl"]={VERY_BLACK, WHITE, RED, CREAM, BLUE},
                ["models/ctvehicles/gaz/13b.mdl"]={VERY_BLACK, WHITE, RED, CREAM, BLUE},
                ["models/ctvehicles/buick/1957_roadmaster.mdl"]={VERY_BLACK, WHITE, RED, CREAM, BLUE, LIGHT_BLUE, BEIGE, TURQUOISE, ORANGE, DARK_BLUE, EMERALD, GREEN},
                ["models/ctvehicles/pontiac/1958_bonneville_coupe.mdl"]={VERY_BLACK, WHITE, RED, CREAM, BLUE, LIGHT_BLUE, BEIGE, TURQUOISE, ORANGE, DARK_BLUE, EMERALD, GREEN},
                ["models/ctvehicles/pontiac/1958_bonneville_convertible.mdl"]={VERY_BLACK, WHITE, RED, CREAM, BLUE, LIGHT_BLUE, BEIGE, TURQUOISE, ORANGE, DARK_BLUE, EMERALD, GREEN},
                ["models/ctvehicles/fallout/station_wagon.mdl"]={VERY_BLACK, WHITE, RED, ICE2, BLUE, YELLOW},
                ["models/ctvehicles/daihatsu/midget_mp5.mdl"]={MIDGET_GREEN, WHITE, MIDGET_BLUE},
                ["models/ctvehicles/chevrolet/colorado_zr2.mdl"]={RED_RACE, RED, GREY, LIGHT_GREY, DARK_GREY, SILVER, WHITE, DARK_BLUE},
                ["models/ctvehicles/mini/hatch_jcw_convertible.mdl"]={TURQUOISE, SWAMP, THUNDER_GREY, SILVER, BLACK, DARK_CREAM, SOLARIS_ORANGE, GREY, DARK_BLUE, RED, DARK_DARK_BLUE, PEPPER_WHITE},
                ["models/ctvehicles/lancia/stratos_zero.mdl"]={SOLARIS_ORANGE, LIGHT_GREY},
                ["models/ctvehicles/chevrolet/impala_2000.mdl"]={LIGHT_LIGHT_GREY, WHITE, GM_MEDIUM_BLUE, DARK_BLUE, GM_LIGHT_DRIFTWOOD, VERY_BLACK, GM_DARK_CARMINE_RED, GM_NIGHTMIST_AUBURN, GM_DARK_JADE_GREEN, GM_TORCH_RED},
                ["models/ctvehicles/ford/crown_vic_1996.mdl"]={LIGHT_SADDLE, MEDIUM_BERRY, DARK_RED, IVORY, MEDIUM_WILLOW, LIGHT_WILLOW, SILVER_FROST, VERY_BLACK, WHITE, DARK_GREY},
                [""]={},}

local skins = {["models/ctvehicles/alfa_romeo/carabo_concept.mdl"] = GetAllSkins("alfa_romeo/carabo_concept/skin"),
               ["models/ctvehicles/monster_jam/grave_digger.mdl"] = GetAllSkins("monster_jam/grave_digger/skin"),
	       ["models/ctvehicles/cadillac/one.mdl"] = GetAllSkins("cadillac/one/national_flags"),
               ["models/ctvehicles/buick/1957_roadmaster.mdl"] = GetAllSkins("buick/1957_roadmaster/skin"),
               ["models/ctvehicles/pontiac/1958_bonneville_coupe.mdl"] = GetAllSkins("pontiac/1958_bonneville/skin"),
               ["models/ctvehicles/pontiac/1958_bonneville_convertible.mdl"] = GetAllSkins("pontiac/1958_bonneville/skin"),
               ["models/ctvehicles/batman/tumbler.mdl"] = GetAllSkins("batman/tumbler/skin"),
               ["models/ctvehicles/shelby/daytona_coupe.mdl"] = GetAllSkins("shelby/daytona_coupe/skin"),
               ["models/ctvehicles/chevrolet/corvette_c1_1960.mdl"] = GetAllSkins("chevrolet/corvette_c1_1960/skin"),
               ["models/ctvehicles/minecraft/minecart.mdl"] = GetAllSkins("minecraft/minecart/skin"),
               ["models/ctvehicles/spania_gta/spano_2012.mdl"] = GetAllSkins("spania_gta/spano_2012/skin"),
               ["models/ctvehicles/amc/gremlin_x.mdl"] = GetAllSkins("amc/gremlin_x/skin"),
               ["models/ctvehicles/tf2/civilian_limousine.mdl"] = GetAllSkins("tf2/civilian_limousine/skin"),
               ["models/ctvehicles/tf2/civilian_limousine_modified.mdl"] = GetAllSkins("tf2/civilian_limousine_modified/skin"),
               [""] = GetAllSkins(""),}

local bodygroups = {["models/ctvehicles/chevrolet/corvette_c8.mdl"] = {0,0,0,0,0,0,0,0,0,2,1,1,0,0,0,1},
                    ["models/ctvehicles/monster_jam/grave_digger.mdl"] = {0,0,3},
                    ["models/ctvehicles/chevrolet/colorado_zr2.mdl"] = {0,0,0,0,0,1,1,1,1,3,3,5,3},
                    ["models/ctvehicles/fleetwood/bounder.mdl"] = {0,0,0,0,1,0,0,0,0,0,0,0,1},
                    ["models/ctvehicles/pontiac/1958_bonneville_convertible.mdl"] = {0,1},
                    ["models/ctvehicles/chevrolet/impala_2000.mdl"] = {0,0,0,0,0,0,0,1,1,1,1,0,0,3},
                    ["models/ctvehicles/amc/gremlin_x.mdl"] = {0,0,0,0,0,0,0,1,1,1,2,3},
                    ["models/ctvehicles/ford/crown_vic_1996.mdl"] = {1,1,0,0,0,0,0,0,0,0,0,1,2},
                    ["models/ctvehicles/tf2/civilian_limousine.mdl"] = {0,0,0,1},
                    ["models/ctvehicles/tf2/civilian_limousine_modified.mdl"] = {0,0,0,1,0,2},
                    [""] = {},}

if SERVER then
    local model
    hook.Add( "PlayerSpawnedVehicle", "CTV_Randomness",
		function(ply, ent)
			timer.Simple(.1,
				function()
                    if IsValid(ent) then
                        model = ent:GetModel()
                        if colors[model] ~= nil and GetConVarNumber("ctv_selective_color_enabled") == 1 then
                            ent:SetColor(colors[model][math.random(#colors[model])])
                        end
                        if skins[model] ~= nil and GetConVarNumber("ctv_random_skin_enabled") == 1 then
                            ent:SetSkin(skins[model][math.random(#skins[model])])
                        end
                        if bodygroups[model] ~= nil and GetConVarNumber("ctv_random_bg_enabled") == 1 then
                            for k, v in pairs(bodygroups[model]) do
        						ent:SetBodygroup(k, math.random(0,v))
        					end
                        end
                    end
				end
			)
		end
	)
end
