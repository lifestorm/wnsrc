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

game.AddParticles( "particles/Advisor_FX.pcf" )
game.AddParticles( "particles/advisor.pcf" )
game.AddParticles( "particles/hunter_flechette.pcf" )
game.AddParticles( "particles/hunter_intro.pcf" )
game.AddParticles( "particles/hunter_projectile.pcf" )
game.AddParticles( "particles/hunter_shield_impact.pcf" )
game.AddParticles( "particles/effect_hl2.pcf" )
game.AddParticles( "particles/mortar_fx.pcf" )
game.AddParticles( "particles/vorti_fx.pcf" )
VJ.AddParticle("particles/mortar_fx.pcf",{"striderbuster_break_lightnings1"}) -- Add a human SNPC to the spawnlist
VJ.AddParticle("particles/vorti_fx.pcf",{"striderbuster_break_lightnings2"}) -- Add a human SNPC to the spawnlist
local vCat = "HALF-LIFE 2" -- Category

VJ.AddNPC_HUMAN("Citizen Neutral","npc_vj_hl2_Citizen2",{"weapon_vj_pistol_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Refugee","npc_vj_hl2_Refugee",{"weapon_vj_pistol_hl2","weapon_vj_crowbar","weapon_vj_smg1_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC("Refugee Cowardly","npc_vj_hl2_Refugee2",vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Rebel","npc_vj_hl2_rebel",{"weapon_vj_spas12_hl2", "weapon_vj_smg1_hl2", "weapon_vj_smg1_hl2", "weapon_vj_arbalet_hl2", "weapon_vj_ar2_hl2", "weapon_vj_ar2_hl2", "weapon_vj_rpg_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Medic","npc_vj_hl2_medic",{"weapon_vj_smg1_hl2", "weapon_vj_ar2_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Wallace Breen","sent_vj_breen",{"weapon_vj_pistol_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Eli Vance","sent_vj_eli",{"weapon_vj_pistol_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Dr. Arne Magnussone","sent_vj_mag",{"weapon_vj_pistol_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Fisherman","npc_vj_hl2_fisherman",{"weapon_vj_hook_hl2","weapon_vj_smg1_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Dr. Judith Mossman","sent_vj_mossman",{"weapon_vj_pistol_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC("Combine APC","npc_vj_hl2_apc",vCat)

VJ.AddNPC("G-Man","npc_vj_hl2_gman",vCat)

VJ.AddNPC_HUMAN("Dr. Isaac Kleiner","sent_vj_Kleiner",{"weapon_vj_pistol_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Odessa Cubbage","npc_vj_hl2_odessa",{"weapon_vj_rpg_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Father Grigori","npc_vj_hl2_grisha",{"weapon_vj_annabelle_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Barney Calhoun","npc_vj_hl2_barney",{"weapon_vj_ar2_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Alyx Vance","npc_vj_hl2_alex",{"weapon_vj_alyxgun_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Rebel Recruiter","npc_vj_hl2_rebel3",{"weapon_vj_ar2_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC("Dog","npc_vj_hl2_dog",vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC("Citizen","npc_vj_hl2_Citizen",vCat)

VJ.AddNPC_HUMAN("Metrocop Neutral","npc_vj_hl2_Metrocop",{"weapon_vj_pistol_hl2", "weapon_vj_statick"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Combine Commander","npc_vj_hl2_Metrocop4",{"weapon_vj_ar3_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Combine Guard","npc_vj_hl2_Metrocop5",{"weapon_vj_smg1_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Metrocop Guard","npc_vj_hl2_Metrocop6",{"weapon_vj_smg1_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Metrocop","npc_vj_hl2_Metrocop2",{"weapon_vj_pistol_hl2", "weapon_vj_smg1_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Combine Recruiter","npc_vj_hl2_Metrocop3",{"weapon_vj_pistol_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Combine Soldier","npc_vj_hl2_Combine_soldier",{"weapon_vj_smg1_hl2", "weapon_vj_ar2_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Prison Guard","npc_vj_hl2_Combine_soldier_nova",{"weapon_vj_ar2_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Shotgun Soldier","npc_vj_hl2_Combine_shotguner",{"weapon_vj_spas12_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Prison Shotgun Guard","npc_vj_hl2_Combine_shotgun_nova",{"weapon_vj_spas12_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Combine Elite","npc_vj_hl2_Combine_elit",{"weapon_vj_ar2_hl2"},vCat) -- Add a human SNPC to the spawnlist

VJ.AddNPC_HUMAN("Combine Sniper","npc_vj_hl2_Combine_sniper",{"weapon_vj_csniper_hl2"},vCat) -- Add a human SNPC to the spawnlist


VJ.AddNPCWeapon("VJ Pistol HL2", "weapon_vj_pistol_hl2")



VJ.AddNPCWeapon("VJ Harpun HL2", "weapon_vj_hook_hl2")

VJ.AddNPCWeapon("VJ SMG HL2", "weapon_vj_smg1_hl2")

VJ.AddNPCWeapon("VJ Sniper HL2", "weapon_vj_csniper_hl2")

VJ.AddNPCWeapon("VJ AR2 HL2", "weapon_vj_ar2_hl2")


VJ.AddNPCWeapon("VJ Alyxgun HL2", "weapon_vj_alyxgun_hl2")

VJ.AddNPCWeapon("VJ AR3 HL2", "weapon_vj_ar3_hl2")

VJ.AddNPCWeapon("VJ Shotgun HL2", "weapon_vj_spas12_hl2")

VJ.AddNPCWeapon("VJ Annabelle HL2", "weapon_vj_annabelle_hl2")

VJ.AddNPCWeapon("VJ Crossbow HL2", "weapon_vj_arbalet_hl2")

VJ.AddNPCWeapon("VJ RPG HL2", "weapon_vj_rpg_hl2")
VJ.AddNPCWeapon("VJ Crowbar HL2", "weapon_vj_crowbar")
VJ.AddNPCWeapon("VJ Stun Baton HL2", "weapon_vj_statick")