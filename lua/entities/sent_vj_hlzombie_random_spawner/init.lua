--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/props_junk/popcan01a.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=50,vRight=0,vUp=0},Entities,Entities = {"npc_vj_zombiemutant","npc_vj_zombiegiant","npc_vj_zombiemultilated","npc_vj_zombiecivilian","npc_vj_toxiczombie","npc_vj_zombieassassin","npc_vj_zombiesci","npc_vj_zombiecop","npc_vj_zecu","npc_vj_zombiesci_original","npc_vj_zombiecop_original","npc_vj_zecu_original","npc_vj_gonomeoriginal","npc_vj_headcrab","npc_vj_zombiealpha","npc_vj_gonome","npc_vj_babyheadcrab","npc_vj_zombiearmor","npc_vj_zombiegrenade","npc_vj_zombieflame","npc_vj_gonomearmor"}},
	{EntityName = "NPC2",SpawnPosition = {vForward=0,vRight=50,vUp=0},Entities = {"npc_vj_zombiemutant","npc_vj_zombiegiant","npc_vj_zombiemultilated","npc_vj_zombiecivilian","npc_vj_zombieassassin","npc_vj_toxiczombie","npc_vj_zombiesci","npc_vj_zombiecop","npc_vj_zecu","npc_vj_zombiesci_original","npc_vj_zombiecop_original","npc_vj_zecu_original","npc_vj_gonomeoriginal","npc_vj_headcrab","npc_vj_zombiealpha","npc_vj_gonome","npc_vj_babyheadcrab","npc_vj_zombiearmor","npc_vj_zombiegrenade","npc_vj_zombieflame","npc_vj_gonomearmor"}},
	{EntityName = "NPC3",SpawnPosition = {vForward=100,vRight=50,vUp=0},Entities = {"npc_vj_zombiemutant","npc_vj_zombiegiant","npc_vj_zombiemultilated","npc_vj_zombiecivilian","npc_vj_zombieassassin","npc_vj_toxiczombie","npc_vj_zombiesci","npc_vj_zombiecop","npc_vj_zecu","npc_vj_zombiesci_original","npc_vj_zombiecop_original","npc_vj_zecu_original","npc_vj_gonomeoriginal","npc_vj_headcrab","npc_vj_zombiealpha","npc_vj_gonome","npc_vj_babyheadcrab","npc_vj_zombiearmor","npc_vj_zombiegrenade","npc_vj_zombieflame","npc_vj_gonomearmor"}},
	{EntityName = "NPC4",SpawnPosition = {vForward=100,vRight=-50,vUp=0},Entities = {"npc_vj_zombiemutant","npc_vj_zombiegiant","npc_vj_zombiemultilated","npc_vj_zombiecivilian","npc_vj_zombieassassin","npc_vj_toxiczombie","npc_vj_zombiesci","npc_vj_zombiecop","npc_vj_zecu","npc_vj_zombiesci_original","npc_vj_zombiecop_original","npc_vj_zecu_original","npc_vj_gonomeoriginal","npc_vj_headcrab","npc_vj_zombiealpha","npc_vj_gonome","npc_vj_babyheadcrab","npc_vj_zombiearmor","npc_vj_zombiegrenade","npc_vj_zombieflame","npc_vj_gonomearmor"}},
	{EntityName = "NPC5",SpawnPosition = {vForward=0,vRight=-50,vUp=0},Entities = {"npc_vj_zombiemutant","npc_vj_zombiegiant","npc_vj_zombiemultilated","npc_vj_zombiecivilian","npc_vj_zombieassassin","npc_vj_toxiczombie","npc_vj_zombiesci","npc_vj_zombiecop","npc_vj_zecu","npc_vj_zombiesci_original","npc_vj_zombiecop_original","npc_vj_zecu_original","npc_vj_gonomeoriginal","npc_vj_headcrab","npc_vj_zombiealpha","npc_vj_gonome","npc_vj_babyheadcrab","npc_vj_zombiearmor","npc_vj_zombiegrenade","npc_vj_zombieflame","npc_vj_gonomearmor"}},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/