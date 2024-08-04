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
	=============== Dummy Spawn ===============
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to load spawns for Dummy
--------------------------------------------------*/
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
include('autorun/vj_controls.lua')

local vCat = "Half-Life Zombies" -- Category

VJ.AddNPC("Gonome","npc_vj_gonome",vCat)

VJ.AddNPC("Gonome Security Guard","npc_vj_gonome_cop",vCat)

VJ.AddNPC("Gonome Marine","npc_vj_gonome_zecu",vCat)

VJ.AddNPC("Gonome (Remake)","npc_vj_gonome_remake",vCat)

VJ.AddNPC("Zombie Scientist","npc_vj_zombiesci",vCat)

VJ.AddNPC("Zombie Security Guard","npc_vj_zombiecop",vCat)

VJ.AddNPC("Zombie Marine","npc_vj_zecu",vCat)

VJ.AddNPC("Zombie Scientist(Original)","npc_vj_zombiesci_original",vCat)

VJ.AddNPC("Zombie Scientist(Dreamcast)","npc_vj_zombiesci_dc",vCat)

VJ.AddNPC("Zombie Security Guard(Original)","npc_vj_zombiecop_original",vCat)

VJ.AddNPC("Zombie Marine(Original)","npc_vj_zecu_original",vCat)

VJ.AddNPC("Gonome(Original)","npc_vj_gonomeoriginal",vCat)

VJ.AddNPC("Headcrab","npc_vj_headcrab",vCat)

VJ.AddNPC("Alpha Zombie","npc_vj_zombiealpha",vCat)

VJ.AddNPC("Random Zombie Spawner","sent_vj_hlzombie_random_spawner",vCat)

VJ.AddNPC("Baby Headcrab","npc_vj_babyheadcrab",vCat)

VJ.AddNPC("Grenade Zombie","npc_vj_zombiegrenade",vCat)

VJ.AddNPC("Zomnarch","npc_vj_zomnarch",vCat)

VJ.AddNPC("Flaming Zombie","npc_vj_zombieflame",vCat)

VJ.AddNPC("Armored Zombie","npc_vj_zombiearmor",vCat)

VJ.AddNPC("Armored Gonome","npc_vj_gonomearmor",vCat)

VJ.AddNPC("Zombie Assassin","npc_vj_zombieassassin",vCat)

VJ.AddNPC("Toxic Zombie","npc_vj_toxiczombie",vCat)

VJ.AddNPC("Zombie Civilian","npc_vj_zombiecivilian",vCat)

VJ.AddNPC("Multilated Zombie","npc_vj_zombiemultilated",vCat)

VJ.AddNPC("Giant Zombie","npc_vj_zombiegiant",vCat)

VJ.AddNPC("Mutant Zombie","npc_vj_zombiemutant",vCat)

VJ.AddNPC("Super Zombie","npc_vj_zombiesuper",vCat)

VJ.AddNPC("Crawling Zombie","npc_vj_zombiecrawl",vCat)


-- ConVars --
VJ.AddConVar("npc_vj_zombiesci_h",50)
VJ.AddConVar("npc_vj_zombiesci_d",10)

VJ.AddConVar("npc_vj_zombiecop_h",70)
VJ.AddConVar("npc_vj_zombiecop_d",15)

VJ.AddConVar("npc_vj_zecu_h",90)
VJ.AddConVar("npc_vj_zecu_d",15)

VJ.AddConVar("npc_vj_zombiealpha_h",50)
VJ.AddConVar("npc_vj_zombiealpha_d",10)

VJ.AddConVar("npc_vj_zombiesci_original_h",50)
VJ.AddConVar("npc_vj_zombiesci_original_d",10)

VJ.AddConVar("npc_vj_zombiecop_original_h",70)
VJ.AddConVar("npc_vj_zombiecop_original_d",15)

VJ.AddConVar("npc_vj_zecu_original_h",90)
VJ.AddConVar("npc_vj_zecu_original_d",15)

VJ.AddConVar("npc_vj_gonomeoriginal_h",300)
VJ.AddConVar("npc_vj_gonomeoriginal_d",45)
VJ.AddConVar("npc_vj_gonomeoriginal_d_leap",30)

VJ.AddConVar("npc_vj_gonome_h",300)
VJ.AddConVar("npc_vj_gonome_d",45)
VJ.AddConVar("npc_vj_gonome_d_leap",30)

VJ.AddConVar("npc_vj_headcrab_h",20)
VJ.AddConVar("npc_vj_headcrab_leap_d",10)
VJ.AddConVar("npc_vj_headcrab_d",10)

VJ.AddConVar("npc_vj_zomnarch_h",2000)
VJ.AddConVar("npc_vj_zomnarch_d",80)

VJ.AddConVar("npc_vj_zombiearmor_h",120)
VJ.AddConVar("npc_vj_zombiearmor_d",15)

VJ.AddConVar("npc_vj_zombiegrenade_h",90)
VJ.AddConVar("npc_vj_zombiegrenade_d",15)

VJ.AddConVar("npc_vj_gonomearmor_h",500)
VJ.AddConVar("npc_vj_gonomearmor_d",45)

VJ.AddConVar("npc_vj_zombieflame_h",50)
VJ.AddConVar("npc_vj_zombieflame_d",10)

VJ.AddConVar("npc_vj_toxiczombie_h",60)
VJ.AddConVar("npc_vj_toxiczombie_d",15)

VJ.AddConVar("npc_vj_zombieassassin_h",50)
VJ.AddConVar("npc_vj_zombieassassin_d",15)

VJ.AddConVar("npc_vj_zombiecivilian_h",50)
VJ.AddConVar("npc_vj_zombiecivilian_d",10)

VJ.AddConVar("npc_vj_zombiemultilated_h",80)
VJ.AddConVar("npc_vj_zombiemultilated_d",15)


VJ.AddConVar("npc_vj_zombiegiant_h",1000)
VJ.AddConVar("npc_vj_zombiegiant_d",80)

VJ.AddConVar("npc_vj_zombiemutant_h",450)
VJ.AddConVar("npc_vj_zombiemutant_d",30)

VJ.AddConVar("npc_vj_zombiesuper_h",4000)
VJ.AddConVar("npc_vj_zombiesuper_d",90)

VJ.AddConVar("npc_vj_zombiecrawl_h",150)
VJ.AddConVar("npc_vj_zombiecrawl_d",15)

