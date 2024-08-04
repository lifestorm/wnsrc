--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

/*--------------------------------------------------
	=============== Dummy ConVars ===============
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to load ConVars for Dummy
--------------------------------------------------*/
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
-------------------------------------------------------------------
local AddConvars = {}
AddConvars["npc_vj_overwatch_soldier_h"] = 100
AddConvars["npc_vj_overwatch_elite_soldier_h"] = 120
AddConvars["npc_vj_metro-cop_h"] = 40
AddConvars["npc_vj_elite_metro-cop_h"] = 50
AddConvars["npc_vj_overwatch_soldier_d"] = 20

sound.Add( {
	name = "helicop_sound",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = 20,
	sound = "npc/attack_helicopter/aheli_rotor_loop1.wav"
} )
sound.Add( {
	name = "helicop2_sound",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 80,
	pitch = 20,
	sound = "npc/attack_helicopter/aheli_wash_loop3.wav"
} )
sound.Add( {
	name = "helicop3_sound",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = 100,
	sound = "npc/attack_helicopter/aheli_weapon_fire_loop3.wav"
} )
sound.Add( {
	name = "helicop4_sound",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = 100,
	sound = "npc/attack_helicopter/aheli_charge_up.wav"
} )
sound.Add( {
	name = "mh_sound",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/manhack/mh_engine_loop1.wav"
} )
sound.Add( {
	name = "mh_sound2",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/manhack/mh_engine_loop2.wav"
} )
sound.Add( {
	name = "mh_sound3",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/manhack/mh_blade_loop1.wav"
} )
sound.Add( {
	name = "sc_sound",
	channel = CHAN_STATIC,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "npc/scanner/cbot_fly_loop.wav"
} )
sound.Add( {
	name = "sc_sound2",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/scanner/scanner_combat_loop1.wav"
} )
sound.Add( {
	name = "sc_sound3",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/scanner/scanner_scan_loop1.wav"
} )
sound.Add( {
	name = "sc_sound4",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/scanner/scanner_scan_loop2.wav"
} )
sound.Add( {
	name = "stalker_laser",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/stalker/laser_burn.wav"
} )
sound.Add( {
	name = "gunship_sound",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = 100,
	sound = "npc/combine_gunship/gunship_weapon_fire_loop6.wav"
} )
sound.Add( {
	name = "gunship_sound2",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = 100,
	sound = "npc/combine_gunship/attack_stop2.wav"
} )

sound.Add( {
	name = "gunship_sound3",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = 20,
	sound = "npc/combine_gunship/engine_rotor_loop1.wav"
} )
sound.Add( {
	name = "gunship_sound4",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 80,
	pitch = 20,
	sound = "npc/combine_gunship/engine_whine_loop1.wav"
} )
sound.Add( {
	name = "roller_sound4",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/roller/mine/rmine_moveslow_loop1.wav"
} )
sound.Add( {
	name = "antlion_sound",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 75,
	pitch = 100,
	sound = "npc/antlion/fly1.wav"
} )
sound.Add( {
	name = "crab_sound",
	channel = CHAN_STATIC,
	volume = 1,
	level = 90,
	pitch = 100,
	sound = "npc/crabsynth/cs_minigun2.wav"
} )
for k, v in pairs(AddConvars) do
	if !ConVarExists( k ) then CreateConVar( k, v, {FCVAR_NONE} ) end
end

