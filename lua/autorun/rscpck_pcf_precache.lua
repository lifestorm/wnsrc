--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Dark Souls --
game.AddParticles("particles/Dark_Souls/ds3_sister_friede.pcf")
game.AddParticles("particles/Dark_Souls/ds_artorias_fx.pcf")
game.AddParticles("particles/Dark_Souls/ds_ornstein_fx.pcf")
game.AddParticles("particles/Dark_Souls/ds3_fx.pcf")
game.AddParticles("particles/Dark_Souls/abyss_watcher.pcf")
game.AddParticles("particles/Dark_Souls/cinder_fx_ds3.pcf")
game.AddParticles("particles/Dark_Souls/danksouls.pcf")
game.AddParticles("particles/Dark_Souls/ds3_bosssteps.pcf")
game.AddParticles("particles/Dark_Souls/gael.pcf")
game.AddParticles("particles/Dark_Souls/gael_smoke.pcf")
game.AddParticles("particles/Dark_Souls/gael_dirt2.pcf")
game.AddParticles("particles/Dark_Souls/nking_1.pcf")
game.AddParticles("particles/Dark_Souls/nking_2.pcf")
game.AddParticles("particles/Dark_Souls/nking_3.pcf")

-- Day of Infamy --
game.AddParticles("particles/Day_Of_Infamy/doi_destructible_fx.pcf")
game.AddParticles("particles/Day_Of_Infamy/doi_explosion_fx.pcf")
game.AddParticles("particles/Day_Of_Infamy/doi_explosion_fx_b.pcf")
game.AddParticles("particles/Day_Of_Infamy/doi_explosion_fx_c.pcf")
game.AddParticles("particles/Day_Of_Infamy/doi_explosion_fx_grenade.pcf")
game.AddParticles("particles/Day_Of_Infamy/doi_explosion_fx_new.pcf")
game.AddParticles("particles/Day_Of_Infamy/doi_explosions_smoke.pcf")
game.AddParticles("particles/Day_Of_Infamy/doi_impact_fx.pcf")
game.AddParticles("particles/Day_Of_Infamy/doi_weapon_fx.pcf")

-- Insurgency --
game.AddParticles("particles/Insurgency/ammo_cache_ins.pcf")
game.AddParticles("particles/Insurgency/blood_fx.pcf")
game.AddParticles("particles/Insurgency/footstep_fx.pcf")
game.AddParticles("particles/Insurgency/ins_burning_fx.pcf")
game.AddParticles("particles/Insurgency/ins_rockettrail.pcf")
game.AddParticles("particles/Insurgency/ins_smokegrenade.pcf")
game.AddParticles("particles/Insurgency/weapon_fx_ins.pcf")
game.AddParticles("particles/Insurgency/weapon_fx_ins_b.pcf")
game.AddParticles("particles/Insurgency/world_fx_ins.pcf")

-- CoD --
game.AddParticles("particles/CoD/blackops3zombies_fx.pcf")
game.AddParticles("particles/CoD/hound.pcf")

-- Half-Life Alyx --
game.AddParticles("particles/Half-Life_Alyx/hla_antlion_blue_fx.pcf")
game.AddParticles("particles/Half-Life_Alyx/hla_antlion_orange_fx.pcf")
game.AddParticles("particles/Half-Life_Alyx/AntlionFX.pcf")

-- Horror --
game.AddParticles("particles/Horror/bloodsplosion.pcf")

-- Doom 3 --
game.AddParticles("particles/DOOM/doom_fx.pcf")

-- Armor --
game.AddParticles( "particles/npcarmor.pcf" )
PrecacheParticleSystem( "npcarmor_break" )
PrecacheParticleSystem( "npcarmor_hit" )
PrecacheParticleSystem( "eml_generic_shock" )

-- Starship Troopers --
game.AddParticles("particles/Starship_Troopers/arach_drool.pcf")
game.AddParticles("particles/Starship_Troopers/sst_acidbug_fx.pcf")

-- Fallout --
game.AddParticles("particles/Fallout/centaur_spit.pcf")
game.AddParticles("particles/Fallout/glowingone.pcf")
game.AddParticles("particles/Fallout/goregrenade.pcf")
game.AddParticles("particles/Fallout/magmalurk_flame.pcf")
game.AddParticles("particles/Fallout/fo3_radiation_shockwave.pcf")
game.AddParticles("particles/Fallout/spore1.pcf")
game.AddParticles("particles/Fallout/sporecarrier_glow.pcf")
game.AddParticles("particles/Fallout/sporecarrier_radiation.pcf")
game.AddParticles("particles/Fallout/fo3_fx.pcf")

-- Halo --
game.AddParticles("particles/Halo/main_effects.pcf")
game.AddParticles("particles/Halo/halo_beam.pcf")
game.AddParticles("particles/FlexParticles.pcf")

-- Monster Hunter --
game.AddParticles("particles/mh_scream.pcf")

-- Mass Effect --
game.AddParticles("particles/Mass_Effect/thresher_fx.pcf")
local particlename = {
------------------------------------------------------------------------------------------------------------------------------------
--// Dark Souls Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Friede Particle Effects --
-- phase 2 --
"ds3_friede_bf_flameblast",			-- Single
"ds3_friede_bf_scythe",				-- Continuous
"ds3_friede_bf_super",				-- Single

-- phase 1 --
"ds3_friede_icecast",				-- Single
"ds3_friede_icecastlarge",			-- Single
"ds3_friede_icewave_base",			-- Single
"ds3_friede_icecrystal_spawn",		-- Single
"ds3_friede_icewave_flareup",		-- Single
"ds3_friede_jump",
"ds3_friede_leftdodge",
"ds3_friede_rightdodge",
"ds3_friede_leftcloak",
"ds3_friede_rightcloak",
"ds3_friede_scythe_charge",			-- Continuous
"ds3_friede_scythe_charged",		-- Single
"ds3_friede_scythe_hit",			-- Single
"ds3_friede_scythe_metalhit",		-- Single
"ds3_friede_scythe_idle",			-- Continuous
"ds3_friede_scythe_scrape",			-- Continuous
"ds3_friede_scythe_slam",			-- Single
"ds3_friede_scythe_swing",			-- Continuous
"ds3_friede_sprint",
---------------------------------
-- Shared Particle Effects --
"dskart_death",
"ds3_basil_breath",
"ds3_basil_hit",
"ds3_dw_mist",
"ds3_dw_mist_a",
"ds3_boss_dissolve",
"ds3_boss_dissolve_cheap",
"ds3_gundyr_eyes",
"ds3_eyes_red",
"ds3_eyes_blue",
"ds3_eyes_gold",
"dsorn_electric",
"ornstein_hit",
"ornstein_tracer",
"ds3_bloodsword_swing_left",
"ds3_bloodsword_swing_right",
"ds3_bloodsword_left_em",
"ds3_bloodsword_right_em",
"ds3_bs_left_em_med",
"ds3_bs_right_em_med",
"ds3_bs_left_em_lrg",
"ds3_bs_right_em_lrg",
"ds3_bs_swing_left_med",
"ds3_bs_swing_right_med",
"ds3_bs_swing_left_lrg",
"ds3_bs_swing_right_lrg",
"ds3_maria_fire_impact",
"ds3_maria_impact",
"ds3_maria_blood",
"ds3_flamesword_swing",
"ds3_flamesword_swing_left",
"ds3_flamesword_swing_right",
---------------------------------
-- Footstep Particle Effects --
"ds3_bossfs_land",
"ds3_bossfs_water",
"ds3_bossfs_water_nowarp",
---------------------------------
-- Abyss Watcher Particle Effects --
"ds3_watcher_dirt_circular",
"ds3_watcher_dirt_kickup",
"ds3_watcher_fire_circular",
"ds3_watcher_fire_impact",
"ds3_watcher_fire_pillar",
"ds3_watcher_impact",
"ds3_watcher_sword_flame",
"ds3_watcher_thrust",
---------------------------------
-- Soul of Cinder Particle Effects --
"ds3_cinder_bless",
"ds3_cinder_bless_cast",
"ds3_cinder_buffedaura",
"ds3_cinder_buffedblast",
"ds3_cinder_buffedsword",
"ds3_cinder_death",
"ds3_cinder_heal",
"ds3_cinder_heal_aura",
"ds3_cinder_heal_cast",
"ds3_cinder_innerpower",
"ds3_cinder_magicblast_trail",
"ds3_cinder_magicbolt_hit",
"ds3_cinder_magicbolt_trail",
"ds3_cinder_poisonbreath",
"ds3_poison_mist_cloud",
"ds3_cinder_power_aura",
"ds3_cinder_power_cast",
"ds3_cinder_spear_bigasslightning",
"ds3_cinder_spear_core",
"ds3_cinder_spear_hit",
"ds3_cinder_spear_impact",
"ds3_cinder_spear_lightning",
"ds3_cinder_spear_trail",
"soc_sword_embers",
---------------------------------
-- Gael Particle Effects --
"gael_sword_skulls",
"gael_dirt_kickup",
"gael_dirt_kickup_dir_bck",
"gael_dirt_kickup_dir_fwd",
"gael_dirt_kickup_dir_lft",
"gael_dirt_kickup_dir_rit",
"gael_dirt_land",
"gael_smoke_impact_small",
"gael_smoke_impact_large",
"gael_smoke_impact_continuous",
"gael_sword_impact_att10",
"gael_sword_impact_large",
"gael_sword_impact_small",

------------------------------------------------------------------------------------------------------------------------------------
--// Day Of Infamy Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
"doi_artillery_explosion_OLD",
"doi_grenade_explosionOLD",
"doi_WParty_explosion",
"doi_WPgrenade_explosion",
"doi_WProcket_explosion",
"doi_generic_crater_smoke",
"doi_generic_crater_smoke_big",
"doi_compB_explosionOLD",
"doi_frag_explosionOLD",
"doi_mortar_explosionOLD",
"doi_flak88_explosion",
"doi_petrol_explosion",
"doi_petrol_leak",
"doi_ceilingDust_large",
"doi_ceilingDust_small",
"doi_frag_explosion",
"doi_grenade_explosion",
"doi_mortar_explosion",
"doi_splinter_explosion",
"doi_artillery_explosion",
"doi_compB_explosion",
"doi_gunrun_impact",
"doi_stuka_explosion",
"doi_smoke_artillery",
"doi_muzzleflash_bar_3p",
"doi_muzzleflash_garand_3p",
"doi_muzzleflash_ithica_3p",
"doi_muzzleflash_k98_3p",
"doi_muzzleflash_mg42_3p",
"doi_muzzleflash_mp40_3p",
"doi_muzzleflash_smoke_large_linger",
"doi_muzzleflash_smoke_medium_linger",
"doi_muzzleflash_smoke_medium_variant_1",
"doi_muzzleflash_smoke_small_variant_1",
"doi_muzzleflash_smoke_small_variant_2",
"doi_muzzleflash_smoke_small_variant_3",
"doi_muzzleflash_smoke_small_variant_4",
"doi_muzzleflash_smoke_small_variant_5",
"doi_muzzleflash_smoke_tiny",
"doi_muzzleflash_sten_3p",
"doi_muzzleflash_stg44_3p",
"doi_muzzleflash_thompson_3p",
"doi_weapon_compB_fuse",
"doi_weapon_muzzle_smoke",

------------------------------------------------------------------------------------------------------------------------------------
--// Insurgency Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
"ins_blood_dismember_limb",
"ins_blood_impact_generic",
"ins_blood_impact_headshot",
"ins_blood_incapacitated",
"ins_footstep_dirt",
"ins_footstep_grass",
"ins_footstep_mud",
"ins_footstep_puddle",
"ins_footstep_wet",
"ins_slide_dirt",
"ins_burning_character_large",
"ins_burning_character",
"ins_rockettrail",
"ins_m203_smokegrenade",
"ins_smokegrenade",
"ins_weapon_at4_frontblast",
"ins_weapon_rpg_backblast",
"ins_weapon_rpg_frontblast",
"ins_molotov_rag",
"ins_molotov_lighter",
"ins_molotov_trail",
"ins_muzzleflash_akm_3rd",
"ins_muzzleflash_fal_3rd",
"ins_muzzleflash_m14_3rd",
"ins_muzzleflash_m16_3rd",
"ins_muzzleflash_m249_3rd",
"ins_muzzleflash_m590_3rd",
"ins_muzzleflash_m9_3rd",
"ins_muzzleflash_makarov_3rd",
"ins_muzzleflash_mp40_3rd",
"ins_muzzleflash_mp5_3rd",
"ins_muzzleflash_sks_3rd",
"ins_muzzleflash_toz_3rd",
"ins_muzzleflash_ump_3rd",
"ins_muzzleflash_ak74_3rd",
"ins_flame_jet",
"ins_sprinkler",
"ins_steam_spray",
"ins_water_spray",
"ins_water_spray_impact",
"ins_water_spray_big",
"ins_water_spray_big_impact",
"ins_whirlwind",

------------------------------------------------------------------------------------------------------------------------------------
--// Black Ops 3 Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Cosmonaut FX --
"bo3_astronaut_incoming",
"bo3_astronaut_pulse",
---------------------------------
-- Hellhound FX --
"bo3_hellhound_aura",
---------------------------------
-- RAZ Unit FX --
"bo3_mangler_blast",
"bo3_mangler_charge",
"bo3_mangler_pulse",
---------------------------------
-- Margwa FX --
"bo3_margwa_death",
"bo3_margwa_slam",
---------------------------------
-- Nova 6 Crawler FX --
"bo3_n6crawler_aura",
---------------------------------
-- Napalm Zombie FX --
"bo3_napalm_explosion",
"bo3_napalm_fs",
---------------------------------
-- Panzer FX --
"bo3_panzer_elec_blast",
"bo3_panzer_elec_nade",
"bo3_panzer_engine",
"bo3_panzer_explosion",
"bo3_panzer_flame",
"bo3_panzer_landing",
---------------------------------
-- Shrieker FX --
"bo3_shrieker_scream",
---------------------------------
-- Spider FX --
"bo3_spider_impact",
"bo3_spider_projectile",
"bo3_spider_spit",
---------------------------------
-- Thrasher FX --
"bo3_thrasher_aura",
"bo3_thrasher_blood",
---------------------------------
-- Base Zombie FX --
"bo3_zombie_spawn",
"bo3_zombie_eyeglow_orange",
"bo3_zombie_eyeglow_red",
"bo3_zombie_eyeglow_white",

------------------------------------------------------------------------------------------------------------------------------------
--// Half-Life: Alyx - Antlion Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Antlion FX Orange --
"spit_impact_orange",
"spit_trail_orange",
"splat_orange",
"splat_nophys_orange",
---------------------------------
-- Antlion FX Blue --
"spit_impact_blue",
"spit_trail_blue",
"splat_blue",
"splat_nophys_blue",
---------------------------------
-- Antlion FX --
"AntlionFX_UnBurrow",
"AntlionFX_Burrow",
"AntlionFX_UndGroundMov",

------------------------------------------------------------------------------------------------------------------------------------
--// Horror Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Horror Death FX --
"horror_bloodgibs",
"horror_bloodsplosion",

------------------------------------------------------------------------------------------------------------------------------------
--// Doom 3 Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Shared --
"doom_dissolve",
"doom_dissolve_flameburst",
"doom_hellunit_aura",
"doom_hellunit_spawn_large",
"doom_hellunit_spawn_medium",
"doom_hellunit_spawn_small",
---------------------------------
-- BFG --
"doom_bfg_explosion",
"doom_bfg_explosion_hq",
"doom_bfg_projectile",
"doom_bfg_projectile_hq",
---------------------------------
-- Arch Vile --
"doom_avile_hand",
"doom_avile_blast",
"doom_avile_wave",
"doom_avile_spitfire",
---------------------------------
-- Caco Demon --
"doom_caco_blast",
"doom_caco_blaze",
"doom_caco_nade",
---------------------------------
-- Cyber Demon --
"doom_cyberdemon_breath",
"doom_cyberdemon_jet",
---------------------------------
-- Hellknight --
"doom_hknight_blast",
"doom_hknight_pball",
---------------------------------
-- Imp --
"doom_imp_fireball",
"doom_imp_fireball_cheap",
"doom_imp_fireblast",
---------------------------------
-- Lost Soul --
"doom_lostsoul",
"doom_lostsoul_death",
---------------------------------
-- Mancubus --
"doom_mancu_blast",
"doom_mancu_muzzle",
"doom_mancu_nade",
---------------------------------
-- Revenant --
"doom_rev_missile_blast",
"doom_rev_missile_trail",
"doom_rev_muzzle",
---------------------------------
-- Wraith --
"doom_wraith_postdeath_mist",
"doom_wraith_teleport",

------------------------------------------------------------------------------------------------------------------------------------
--// Arachnid Remade Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Shared FX --
"arach_drool_lower",
"arach_drool_upper",
---------------------------------
-- Acid FX --
"acidbug_spit_impact",
"acidbug_spit_impact_lowperf",
"acidbug_spit_trail",
"acidbug_splat",
"acidbug_splat_nophys",

------------------------------------------------------------------------------------------------------------------------------------
--// Fallout Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Centaur --
"centaur_spit",
---------------------------------
-- Feral Ghoul --
"glowingone_testA",
"glowingone_testB",
"glowingone_testC",
"goregrenade_splash",
"radiation_shockwave",
"radiation_shockwave_debris",
"radiation_shockwave_ring",
"radswave",
---------------------------------
-- Mirelurk --
"magmalurk_flame",
"magmalurk_flame_pilot",
"fo3_mirelurk_charge",
"fo3_mirelurk_pulse",
"fo3_mirelurk_hybrid",
---------------------------------
-- Spore Carrier --
"spore_splash",
"spore_splash_02",
"spore_splash_03",
"spore_splash_05",
"spore_splash_player",
"spore_splash_player_splat",
"spore_trail",
"sporecarrier_glow",
"sporecarrier_radiation",
"sporecarrier_radiation_debris",
"sporecarrier_radiation_ring",
------------------------------------------------------------------------------------------------------------------------------------
--// Thresher Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
"tm_ground",
"tm_ground_inf",

------------------------------------------------------------------------------------------------------------------------------------
--// Halo Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Shield FX --
"hcea_shield_impact",
"hcea_shield_recharged",
"hcea_shield_enabled",
"hcea_shield_disperse",
---------------------------------
-- Hunter AB FX --
"hcea_hunter_ab_charge",
"hcea_hunter_ab_explode",
"hcea_hunter_ab_muzzle",
"hcea_hunter_ab_proj",
---------------------------------
-- Hunter FRG FX --
"hcea_hunter_frg_charge",
"hcea_hunter_frg_explode",
"hcea_hunter_frg_muzzle",
"hcea_hunter_frg_proj",
"hcea_hunter_frg_proj_lightning_trcr_e",
---------------------------------
-- Hunter Shade Cannon FX --
"hcea_hunter_shade_cannon_trigger_muzzle",
"hcea_hunter_shade_cannon_proj",
"hcea_hunter_shade_cannon_explode_ground",
"hcea_hunter_shade_cannon_explode_air",
---------------------------------
-- Hunter Canister FX --
"hcea_hunter_canister_green",
"hcea_hunter_canister_purple",
"hcea_hunter_canister_orange",
---------------------------------
-- Flood FX --
"hcea_flood_carrier_death",
"hcea_flood_infected_death",
"hcea_flood_runner_death",
---------------------------------
-- Hunter FX --
"hcea_hunter_particle_carbine",
"hcea_hunter_particle_carbine_impact",
"hcea_hunter_needler_muzzle",
"hcea_hunter_needler_proj",
"hcea_hunter_needler_pistol_impact",
"hcea_hunter_plasma_rifle_fire",
"hcea_hunter_plasma_rifle_proj",
"hcea_hunter_plasma_rifle_impact",
"hcea_hunter_plasma_pistol_fire",
"hcea_hunter_plasma_pistol_proj",
"hcea_hunter_plasma_pistol_impact",
---------------------------------
-- Beam FX --
"halo_beam_main",
"halo_beam_trail_1",
"halo_beam_trail_2",
"halo_beam_trail_3",
"halo_beam_trail_glow_1",
"halo_beam_trail_glow_2",
"halo_beam_trail_glow_3",
---------------------------------
-- Flood FX --
"hcea_flood_car_death",
"hcea_flood_car_death_core",
"hcea_flood_car_death_dirt",
"hcea_flood_car_death_frag",
"hcea_flood_car_death_frag_2",
"hcea_flood_car_death_gibs",
"hcea_flood_car_death_smoke",
"hcea_flood_car_death_smoke_2",
"hcea_flood_car_death_splat",
"hcea_flood_car_death_splat_2",
"hcea_flood_car_death_splatter",
"hcea_flood_car_death_swave_xy",
"hcea_flood_car_death_swave_xz",
"hcea_flood_inf_death",
"hcea_flood_inf_death_core",
"hcea_flood_inf_death_gibs",
"hcea_flood_inf_death_largesplat",
---------------------------------
-- Hunter Shared FX --
"hcea_gold_hunter_charge",
"hcea_red_hunter_charge",
"hcea_purple_hunter_charge",
"hcea_hunter_charge",
"hcea_hunter_frnade_hit",
"hcea_hunter_frnade_nade",
"hcea_red_hunter_nade",
"hcea_hunter_cannister",
"hcea_gold_hunter_cannister",
"hcea_red_hunter_cannister",
"hcea_purple_hunter_cannister",
"hcea_hunter_impact_generic",
"hcea_red_hunter_muzzle",
"hcea_gold_hunter_muzzle",
"hcea_red_hunter_hit",
"hcea_gold_hunter_hit",
---------------------------------
-- Plasma Pistol FX --
"hcea_t25p_charge",
"hcea_t25p_charge_core",
"hcea_t25p_charge_glow",
"hcea_t25p_hit",
"hcea_t25p_hit_blitz",
"hcea_t25p_hit_collide",
"hcea_t25p_hit_flicker",
"hcea_t25p_hit_glow",
"hcea_t25p_muzzle",
"hcea_t25p_muzzle_charged",
"hcea_t25p_muzzle_charged_core",
"hcea_t25p_muzzle_core",
"hcea_t25p_muzzle_core_2",
"hcea_t25p_muzzle_embers",
"hcea_t25p_muzzle_flames",
"hcea_t25p_muzzle_glow",
"hcea_t25p_muzzle_heat",
"hcea_t25p_muzzle_lghtning",
"hcea_t25p_tracer",
"hcea_t25p_tracer_charged",
"hcea_t25p_tracer_charged_fadeglow",
"hcea_t25p_tracer_charged_sparks",
"hcea_t25p_tracer_fadeglow",
"hcea_t25p_tracer_line",
---------------------------------
-- Plasma Rifle FX --
"hcea_t25r_core",
"hcea_t25r_core_2",
"hcea_t25r_embers",
"hcea_t25r_flames",
"hcea_t25r_flames_0a",
"hcea_t25r_flames_2",
"hcea_t25r_glow",
"hcea_t25r_lghtning",
"hcea_t25r_muzzle",
"hcea_t25r_tracer",
"hcea_t25r_tracer_fadeglow",
"hcea_t25r_tracer_halo_nopunintended",
"hcea_t25r_tracer_line",
------------------------------------------------------------------------------------------------------------------------------------
--// Monster Hunter Particle FX \\--
------------------------------------------------------------------------------------------------------------------------------------
-- Roar --
"mh_monster_scream_large",
}
for _,v in ipairs(particlename) do PrecacheParticleSystem(v) end