--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
game.AddParticles("particles/hunter_shield_impact.pcf")
game.AddParticles("particles/hunter_projectile.pcf")
game.AddParticles("particles/choreo_extract.pcf")
game.AddParticles("particles/choreo_gman.pcf")
game.AddParticles("particles/grenade_fx.pcf")
game.AddParticles("particles/explosion_ep2.pcf")
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !file.Exists("lua/autorun/vj_base_autorun.lua","GAME") then return end
include('autorun/vj_controls.lua')
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local AddonName = "Zippy's Combine SNPCs"
local Type = "SNPC"

VJ.AddAddonProperty(AddonName,Type)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddConVar("vj_zippycombines_dropship_snpcs", 0, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_dropship_fadetime", 20, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_mortarsynth_firealienprojectile", 0, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_scanner_mines", 3, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_chopper_hasmissiles", 1, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_flechettes_stick_to_anything", 1, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_soldier_turretchance", 5, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_soldier_showturret", 1, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_explosiveroller_red", 1, {FCVAR_ARCHIVE})
VJ.AddConVar("vj_zippycombines_nemez_metrocop_compatibility", 0, {FCVAR_ARCHIVE})

if CLIENT then
    hook.Add("PopulateToolMenu", "ZIPPY_COMBINE_MENU_STUFF", function()
        spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Zippy's Combine SNPCs", "Zippy's Combine SNPCs", "", "", function(Panel)
            Panel:ControlHelp("\nWhat SNPCs should the dropship deploy?")
            Panel:AddControl("Slider",{Label = "Dropship SNPCs",Command = "vj_zippycombines_dropship_snpcs",Min = 0,Max = 11})
            Panel:ControlHelp("0 = Random (any of the squads below)\n1 = Overwatch\n2 = Overwatch (with hunters)\n3 = Nova Prospekt\n4 = Civil Protection\n5 = Rollermines\n6 = Rollermines (explosive)\n7 = Vort Synths\n8 = Hunter Synths\n9 = Combine APC\n10 = Assassins\n11 = Strider Synth\n")

            Panel:AddControl("Slider",{Label = "Dropship Remove Time",Command = "vj_zippycombines_dropship_fadetime",Min = -1,Max = 60})
            Panel:ControlHelp("After how much time in seconds will the dropship fade and get removed when it has deployed all of its units? -1 = Never.\n")
            
            Panel:AddControl("Checkbox",{Label = "Mortar Synth Use Alternative Projectiles",Command = "vj_zippycombines_mortarsynth_firealienprojectile"})
            Panel:ControlHelp("Should the mortar synth fire weird alien projectiles instead of grenades?\n")

            Panel:AddControl("Slider",{Label = "Scanner Synth Mines",Command = "vj_zippycombines_scanner_mines",Min = 0,Max = 5})
            Panel:ControlHelp("How many mines should the scanner synth be able to carry?\n")

            Panel:AddControl("Checkbox",{Label = "Hunter Chopper Has Missiles",Command = "vj_zippycombines_chopper_hasmissiles"})
            Panel:ControlHelp("Should the hunter chopper be able to fire homing missiles?\n")

            Panel:AddControl("Checkbox",{Label = "Hunter Flechettes Can Stick To Anything",Command = "vj_zippycombines_flechettes_stick_to_anything"})
            Panel:ControlHelp("Should the hunter's flechettes stick to anything?\n")

            Panel:AddControl("Checkbox",{Label = "Soldier Show Turret",Command = "vj_zippycombines_soldier_showturret"})
            Panel:ControlHelp("Should turret carrying soldiers have visible turrets on their backs? Disable if you have a combine soldier model replacement that screws up the turrets position.\n")

            Panel:AddControl("Slider",{Label = "Soldier Turret Chance",Command = "vj_zippycombines_soldier_turretchance",Min = 0,Max = 10})
            Panel:ControlHelp("How often should combine soldiers carry turrets?\nExamples:\n0 = Never\n1 = Always\n2 = Sometimes (50 % chance)\n10 = Rarely (10% chance)\n")

            Panel:AddControl("Checkbox",{Label = "Red Explosive Rollermines",Command = "vj_zippycombines_explosiveroller_red"})
            Panel:ControlHelp("Should explosive rollermines be red?\n")
    
            Panel:AddControl("Checkbox",{Label = "Nemez's Metropolice Force Compatibility",Command = "vj_zippycombines_nemez_metrocop_compatibility"})
            Panel:ControlHelp("If you have Nemez's Metropolice Force replacements installed, medic metrocops will have their medic skins, and the elite police will have its model replaced as well.\n")
        end)
    end)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ZippyCombines_NPC_Weapons = {
    npc_vj_overwatch_soldier_z = {"weapon_vj_smg1","weapon_vj_smg1","weapon_vj_smg1","weapon_vj_ar2"},
    npc_vj_novaprospekt_soldier_z = {"weapon_vj_smg1","weapon_vj_smg1","weapon_vj_smg1","weapon_vj_ar2"},
    npc_vj_novaprospekt_shotgunner_z = {"weapon_vj_spas12_mk2_z"},
    npc_vj_overwatch_shotgunner_z = {"weapon_vj_spas12_mk2_z"},
    npc_vj_civil_protection_z = {"weapon_vj_9mmpistol","weapon_vj_9mmpistol","weapon_vj_9mmpistol","weapon_vj_smg1","weapon_vj_stunstick_z","weapon_vj_stunstick_z"},
    npc_vj_civil_protection_elite_z = {"weapon_vj_mp5k_z"},
    npc_vj_overwatch_sniper_z = {"weapon_vj_combine_sniper_rifle_z"},
    npc_vj_overwatch_elite_z = {"weapon_vj_ar2"},
    npc_vj_overwatch_assassin_z = {"weapon_vj_assassin_pistols_z"},
}

local vCat = "Zippy's Combines"
VJ.AddCategoryInfo(vCat, {Icon = "entities/combinelogo2.png"})

-- Synths
VJ.AddNPC("Hunter Synth","npc_vj_hunter2_z",vCat)
VJ.AddNPC("Mini Strider Synth","npc_vj_mini_strider_synth_z",vCat)
VJ.AddNPC("Combine Turret","npc_vj_combine_turret_z",vCat)
VJ.AddNPC("Mortar Synth","npc_vj_mortar_synth_z",vCat)
VJ.AddNPC("Scanner Synth","npc_vj_synth_scanner_z",vCat)
VJ.AddNPC("Crab Synth","npc_vj_crabsynth2_z",vCat)
VJ.AddNPC("Gunship Synth","npc_vj_gunship2_z",vCat)
VJ.AddNPC("Dropship Synth","npc_vj_dropship_z",vCat)
VJ.AddNPC("Vort Synth","npc_vj_vortigaunt_synth_z",vCat)
VJ.AddNPC("Cremator Synth","npc_vj_cremator_synth_z",vCat)
VJ.AddNPC("Assassin Synth","npc_vj_assassin_synth_z",vCat)
VJ.AddNPC("Strider Synth","npc_vj_strider_synth_z",vCat)

 -- things idfk
VJ.AddNPC("Combine APC","npc_vj_combine_apc_z",vCat)
VJ.AddNPC("Scanner","npc_vj_city_scanner_z",vCat)
VJ.AddNPC("Rollermine","npc_vj_rollermine_z",vCat)
VJ.AddNPC("Explosive Rollermine","npc_vj_rollermine_explosive_z",vCat)
VJ.AddNPC("Combine Helicopter","npc_vj_hunterchopper_z",vCat)
VJ.AddNPC("Hopper Mine","obj_vj_hopper_mine_z",vCat) -- Not an SNPC but whatever.

-- Weapons
VJ.AddNPCWeapon("VJ_CombineSniperRifle","weapon_vj_combine_sniper_rifle_z")
VJ.AddNPCWeapon("VJ_SPAS12_MK2","weapon_vj_spas12_mk2_z")
VJ.AddNPCWeapon("VJ_Stunstick","weapon_vj_stunstick_z")
VJ.AddNPCWeapon("VJ_CombineMP5K","weapon_vj_mp5k_z")

-- Homans
VJ.AddNPC("Combine Guard","npc_vj_combineguard_z",vCat)
VJ.AddNPC("Combine Stalker","npc_vj_stalker_z",vCat)

VJ.AddNPC_HUMAN("Civil Protection","npc_vj_civil_protection_z",ZippyCombines_NPC_Weapons["npc_vj_civil_protection_z"],vCat)
VJ.AddNPC_HUMAN("Civil Protection Elite","npc_vj_civil_protection_elite_z",ZippyCombines_NPC_Weapons["npc_vj_civil_protection_elite_z"],vCat)

VJ.AddNPC_HUMAN("Overwatch Soldier","npc_vj_overwatch_soldier_z",ZippyCombines_NPC_Weapons["npc_vj_overwatch_soldier_z"],vCat)
VJ.AddNPC_HUMAN("Overwatch Shotgunner","npc_vj_overwatch_shotgunner_z",ZippyCombines_NPC_Weapons["npc_vj_overwatch_shotgunner_z"],vCat)
VJ.AddNPC_HUMAN("Overwatch Sniper","npc_vj_overwatch_sniper_z",ZippyCombines_NPC_Weapons["npc_vj_overwatch_sniper_z"],vCat)
VJ.AddNPC_HUMAN("Overwatch Elite","npc_vj_overwatch_elite_z",ZippyCombines_NPC_Weapons["npc_vj_overwatch_elite_z"],vCat)
VJ.AddNPC_HUMAN("Overwatch Assassin","npc_vj_overwatch_assassin_z",ZippyCombines_NPC_Weapons["npc_vj_overwatch_assassin_z"],vCat)

VJ.AddNPC_HUMAN("Nova Prospekt Soldier","npc_vj_novaprospekt_soldier_z",ZippyCombines_NPC_Weapons["npc_vj_novaprospekt_soldier_z"],vCat)
VJ.AddNPC_HUMAN("Nova Prospekt Shotgunner","npc_vj_novaprospekt_shotgunner_z",ZippyCombines_NPC_Weapons["npc_vj_novaprospekt_shotgunner_z"],vCat)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ZIPPYCOMBINES_FadeAndRemove(ent,time)
    timer.Simple(time, function() if IsValid(ent) then

        local fadetime = 2
        local reps = 30
        local alpha = 255
        local timer_name = "ZIPPYCOMBINES_FadeAndRemove" .. ent:EntIndex()

        timer.Create(timer_name, fadetime/reps, reps, function()

            if IsValid(ent) then

                if alpha == 255 then
                    ent:SetRenderMode(RENDERMODE_TRANSALPHA)
                end

                alpha = alpha - (255/reps)
                ent:SetColor(Color(255,255,255,alpha))

                if timer.RepsLeft(timer_name) == 0 then
                    ent:Remove()
                end

            end

        end)

    end end)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------