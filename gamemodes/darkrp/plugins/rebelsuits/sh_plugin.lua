--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local ix = ix
local CAMI = CAMI
local player_manager = player_manager
local LocalPlayer = LocalPlayer
local bit = bit
local string = string
local SetNetVar = SetNetVar
local net = net
local pairs = pairs

local PLUGIN = PLUGIN

PLUGIN.name = "Rebel Suits"
PLUGIN.author = "Gr4Ss -- Modified by Hayden"
PLUGIN.description = "Adds rebel suits and stuff."

-- Hand fixes by M!NT
for i = 1, 9 do
	player_manager.AddValidModel("CPModel", "models/wn7new/metropolice/male_0"..i..".mdl")
end
for i = 1, 7 do
	player_manager.AddValidModel("CPModel", "models/wn7new/metropolice/female_0"..i..".mdl")
end
for i = 1, 9 do
	player_manager.AddValidModel("CPModel", "models/wn7new/metropolice_c8/male_0"..i..".mdl")
end
for i = 1, 7 do
	player_manager.AddValidModel("CPModel", "models/wn7new/metropolice_c8/female_0"..i..".mdl")
end
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/ordinal.mdl")
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/soldier.mdl")
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/suppressor.mdl")
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/charger.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_commander.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_elite.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_elite_summit.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_shotgunner.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_soldier.mdl")
player_manager.AddValidModel("CPModel", "models/combine_super_soldier.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_skylegion.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ordinal.mdl")
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/antibody.mdl")

player_manager.AddValidHands("CPModel", "models/weapons/c_arms_combine.mdl", 0, "00000000")
