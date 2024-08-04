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
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Half-Life: Alyx SNPCs"
local AddonName = "HL:A SNPCs"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_hla_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Half-Life: Alyx" -- Category, you can also set a category individually by replacing the vCat with a string value
	
	VJ.AddCategoryInfo(vCat, {Icon = "vgui/hla_icon.png"})
	list.Set( "ContentCategoryIcons", vCat, "vgui/hla_icon.png" )
	
	/* -- Comment box start
	NOTE: The following code is commented out so the game doesn't run it! When copying one of the options below, make sure to put it outside of the comment box!
	
	VJ.AddNPC("Dummy SNPC","npc_vj_dum_dummy",vCat) -- Adds a NPC to the spawnmenu
		-- Parameters:
			-- First is the name, second is the class name
			-- Third is the category that it should be in
			-- Fourth is optional, which is a boolean that defines whether or not it's an admin-only entity
	VJ.AddNPC_HUMAN("Dummy Human SNPC","npc_vj_dum_dummy",{"weapon_vj_dummy"},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
		-- Parameters:
			-- First is the name, second is the class name
			-- Third is a table of weapon, the base will pick a random one from the table and give it to the SNPC when "Default Weapon" is selected
			-- Fourth is the category that it should be in
			-- Fifth is optional, which is a boolean that defines whether or not it's an admin-only entity
	VJ.AddWeapon("Dummy Weapon","weapon_vj_dummy",false,vCat) -- Adds a weapon to the spawnmenu
		-- Parameters:
			-- First is the name, second is the class name
			-- Third is a boolean that defines whether or not it's an admin-only entity
			-- And the last parameter is the category that it should be in
	VJ.AddNPCWeapon("VJ_Dummy", "weapon_vj_dummy") -- Adds a weapon to the NPC weapon list
		-- Parameters:
			-- First is the name, second is the class name
	VJ.AddEntity("Dummy Kit","sent_vj_dummykit","Author Name",false,0,true,vCat) -- Adds an entity to the spawnmenu
		-- Parameters: 
			-- First is the name, second is the class name and the third is its class name	
			-- Fourth is a boolean that defines whether or not it's an admin-only entity
			-- Fifth is an integer that defines the offset of the entity (When it spawns)
			-- Sixth is a boolean that defines whether or not it should drop to the floor when it spawns
			-- And the last parameter is the category that it should be in

	-- Particles --
	VJ.AddParticle("particles/example_particle.pcf",{
		"example_particle_name1",
		"example_particle_name2",
	})
	
	-- Precache Models --
	util.PrecacheModel("models/example_model.mdl")
	
	-- ConVars --
	VJ.AddConVar("vj_dum_dummy_h",100) -- Example 1
	VJ.AddConVar("vj_dum_dummy_d",20) -- Example 2
	
	*/  -- Comment box end
	
	VJ.AddNPC("April 2020 Era Headcrab","npc_vj_hla_ocrab",vCat)
	VJ.AddNPC("Headcrab","npc_vj_hla_hcrab",vCat)
	VJ.AddNPC("Armored Headcrab","npc_vj_hla_ahcrab",vCat)
	VJ.AddNPC("Poison Headcrab","npc_vj_hla_bcrab",vCat)
	VJ.AddNPC("Fast Headcrab","npc_vj_hla_fcrab",vCat)
	VJ.AddNPC("Headcrab Reviver","npc_vj_hla_rcrab",vCat)
	VJ.AddNPC("HL2 Poison Headcrab","npc_vj_hla_bcrab_hl2",vCat)
	
	VJ.AddNPC("Zombie","npc_vj_hla_zombieclassic",vCat)
	VJ.AddNPC("Armored Zombie","npc_vj_hla_zombiearmored",vCat)
	VJ.AddNPC("Electric Zombie","npc_vj_hla_zombiereviver",vCat)
	VJ.AddNPC_HUMAN("Zombine Gunner","npc_vj_hla_zombiegunner",{"weapon_vj_hla_irifle_v2"},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
	VJ.AddNPC("Headcrab-less Zombie","npc_vj_hla_zombie",vCat)
	VJ.AddNPC("HL2 Zombie","npc_vj_hla_zombieclassic_hl2",vCat)
	VJ.AddNPC("HL2 Electric Zombie","npc_vj_hla_zombiereviver_hl2",vCat)
	VJ.AddNPC("Unused Zombie","npc_vj_hla_zombie_unused",vCat)
	VJ.AddNPC("Unused Zombie Torso","npc_vj_hla_zombie_torso_unused",vCat)
--	VJ.AddNPC("Armored Zombie Torso","npc_vj_hla_zombietorsoarmored",vCat)
--	VJ.AddNPC("Headcrab-less Zombie Torso","npc_vj_hla_zombietorso",vCat)
	
	VJ.AddNPC("Xen Grenade Plant","npc_vj_hla_xengp",vCat)
--	VJ.AddNPC("Xen Light Plant","npc_vj_hla_xenlp",vCat)
	
	VJ.AddNPC("Barnacle","npc_vj_hla_barnacle",vCat, false, function(x) x.OnCeiling = true x.Offset = 0 end)
	VJ.AddNPC("Snark","npc_vj_hla_snark",vCat)
	
	VJ.AddNPC("Jelly Blobber","npc_vj_hla_jellyb",vCat)
	
	VJ.AddWeapon("Snark","weapon_vj_hla_snark",false,vCat) -- Adds a weapon to the spawnmenu
	VJ.AddWeapon("Xen Grenade","weapon_vj_hla_xen_grenade",false,vCat) -- Adds a weapon to the spawnmenu
	
	VJ.AddNPCWeapon("VJ_HLA_IRIFLE_V2","weapon_vj_hla_irifle_v2")
	
--	VJ.AddEntity("Reviver Spit","obj_vj_reviver_spit","cc123",true,0,false,vCat) -- Adds an entity to the spawnmenu
		-- Parameters: 
			-- First is the name, second is the class name and the third is its class name	
			-- Fourth is a boolean that defines whether or not it's an admin-only entity
			-- Fifth is an integer that defines the offset of the entity (When it spawns)
			-- Sixth is a boolean that defines whether or not it should drop to the floor when it spawns
			-- And the last parameter is the category that it should be in
	
	-- Particles --
	VJ.AddParticle("particles/hla_reviver_particles.pcf",{
		"Weapon_Combine_Ion_Cannon_Explosion_Vilomah",
		"explosion_xen_grenade_1",
		"grenade_xen_b"
	})
	
	VJ.AddParticle("particles/reviver_particles.pcf",{
		"reviver_shockwave_tracer_glow",
		"reviver_spit_trail",
		"reviver_spit_projectile",
		"reviver_spit_splash",
		"reviver_nz_elec",
		"blood_impact_reviver_node_electrical",
		"reviver_node_zombie_fx_ab",
		"snark_eye2",
		"reviver_ambient",
		"reviver_smoke_bomb",
		"reviver_smoke_bomb_dazzle",
		"reviver_ambient_speks"
	})
	
	-- Precache Models --
	util.PrecacheModel("models/creatures/headcrabs/headcrab_classic_april2020.mdl")
	util.PrecacheModel("models/creatures/headcrabs/headcrab_classic.mdl")
	util.PrecacheModel("models/creatures/headcrabs/headcrab_armored.mdl")
	util.PrecacheModel("models/creatures/headcrabs/headcrab_black.mdl")
	util.PrecacheModel("models/creatures/headcrabs/headcrab_reviver.mdl")
	util.PrecacheModel("models/creatures/headcrabs/headcrab.mdl")
	util.PrecacheModel("models/creatures/headcrabs/node_headcrab.mdl")
	util.PrecacheModel("models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib01.mdl")
	util.PrecacheModel("models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib02.mdl")
	util.PrecacheModel("models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib03.mdl")
	util.PrecacheModel("models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib04.mdl")
	util.PrecacheModel("models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib05.mdl")
	util.PrecacheModel("models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib06.mdl")
	util.PrecacheModel("models/creatures/headcrabs/gibs/headcrab_armored/shell.mdl")
	util.PrecacheModel("models/creatures/headcrabs/gibs/headcrab_reviver/reviver_heart.mdl")
	
	util.PrecacheModel("models/creatures/zombies/zombie_citizen.mdl")
	util.PrecacheModel("models/creatures/zombies/zombine.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_hazmat_worker_male.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_combine_worker.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_combine_worker_2.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_hazmat_worker_female.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_sweats_citizen.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_c17.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_zoo.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_security.mdl")
	util.PrecacheModel("models/creatures/zombies/zombine_gunner.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_classic.mdl")
	
	util.PrecacheModel("models/creatures/zombies/zombie_classic.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_classic_2.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_classic_3.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_classic_4.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_classic_5.mdl")
	
	util.PrecacheModel("models/creatures/zombies/zombie_citizen_reviver.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_hazmat_worker_male_reviver.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_combine_worker.mdl")
	util.PrecacheModel("models/creatures/zombies/zombie_c17_reviver.mdl")
	
	util.PrecacheModel("models/props/xen_infestation_v2/xen_v2_floater_jellybobber.mdl")
	
	util.PrecacheModel("models/weapons/w_vr_irifle.mdl")
	
	util.PrecacheModel("models/props/barnacle_debri/barnacle_debri_rib.mdl")
	util.PrecacheModel("models/props/barnacle_debri/barnacle_debri_scapula.mdl")
	util.PrecacheModel("models/props/barnacle_debri/barnacle_debri_skull.mdl")
	util.PrecacheModel("models/props/barnacle_debri/barnacle_debri_spine.mdl")
	
	util.PrecacheModel("models/particle/fluid_explosion.mdl")
	util.PrecacheModel("models/particle/fluid_splashes_stringy_1.mdl")
	util.PrecacheModel("models/particle/fluid_splashes_stringy_2.mdl")
	util.PrecacheModel("models/particle/fluid_splashes_stringy_3.mdl")
	
	VJ.AddConVar("vj_hla_ocrab_h",28)
	VJ.AddConVar("vj_hla_hcrab_h",20)
	VJ.AddConVar("vj_hla_hcrab_d",10)
	VJ.AddConVar("vj_hla_bcrab_h",50)
	VJ.AddConVar("vj_hla_rcrab_h",92)
	VJ.AddConVar("vj_hla_rcrab_d1",5)
	VJ.AddConVar("vj_hla_rcrab_d2",48)
	VJ.AddConVar("vj_hla_hzomb_h",45)
	VJ.AddConVar("vj_hla_hzomb_d",20)
	VJ.AddConVar("vj_hla_hzomb_d2",30)
	
	VJ.AddConVar("vj_hla_enable_headcrab_ragdolling",1)
	VJ.AddConVar("vj_hla_enable_zombie_bloaters",0)
	VJ.AddConVar("vj_hla_enable_hard_difficulty",0)
	VJ.AddConVar("vj_hla_enable_snark_dontdie",0)
	
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end