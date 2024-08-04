--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if CLIENT then


//GLOW

presets.Add( "glow", "Campfire", {

	glow_color_r		= "255",
	glow_color_g		= "187",
	glow_color_b		= "142",
	glow_verticalsize		= "32",
	glow_horizontalsize		= "32",
	glow_mindist		= "0",
	glow_maxdist		= "64",
	glow_outermaxdist		= "16384",

} )

presets.Add( "glow", "Close-up Bloom", {

	glow_color_r		= "120",
	glow_color_g		= "120",
	glow_color_b		= "120",
	glow_verticalsize		= "32",
	glow_horizontalsize		= "32",
	glow_mindist		= "4",
	glow_maxdist		= "64",
	glow_outermaxdist		= "512",

} )

presets.Add( "glow", "Distant Glow", {

	glow_color_r		= "210",
	glow_color_g		= "210",
	glow_color_b		= "210",
	glow_verticalsize		= "16",
	glow_horizontalsize		= "16",
	glow_mindist		= "64",
	glow_maxdist		= "1024",
	glow_outermaxdist		= "8192",

} )

presets.Add( "glow", "GMod Lamp", {

	glow_color_r		= "255",
	glow_color_g		= "255",
	glow_color_b		= "255",
	glow_verticalsize		= "16",
	glow_horizontalsize		= "16",
	glow_mindist		= "0",
	glow_maxdist		= "32",
	glow_outermaxdist		= "16384",

} )

presets.Add( "glow", "Mild Outline", {

	glow_color_r		= "152",
	glow_color_g		= "152",
	glow_color_b		= "152",
	glow_verticalsize		= "8",
	glow_horizontalsize		= "8",
	glow_mindist		= "128",
	glow_maxdist		= "2048",
	glow_outermaxdist		= "16384",

} )

//SMOKE

presets.Add( "smoke", "Cigarette", {

	smoke_color_r 		= "162",
	smoke_color_g		= "162",
	smoke_color_b 		= "162",
	smoke_color_a 		= "100",
	smoke_material 		= "particle/smokesprites_0001.vmt",
	smoke_spreadbase		= "0",
	smoke_spreadspeed		= "0",
	smoke_speed 		= "8",
	smoke_startsize 		= "0",
	smoke_endsize 		= "1",
	smoke_roll 		= "32",
	smoke_numparticles		= "32",
	smoke_jetlength		= "21",
	smoke_twist 		= "12",

} )

presets.Add( "smoke", "Dark Cloud", {

	smoke_color_r 		= "62",
	smoke_color_g		= "62",
	smoke_color_b 		= "62",
	smoke_color_a 		= "100",
	smoke_material 		= "particle/smokesprites_0001.vmt",
	smoke_spreadbase		= "128",
	smoke_spreadspeed		= "1024",
	smoke_speed 		= "512",
	smoke_startsize 		= "128",
	smoke_endsize 		= "512",
	smoke_roll 		= "128",
	smoke_numparticles		= "64",
	smoke_jetlength		= "2048",
	smoke_twist 		= "128",

} )

presets.Add( "smoke", "Eye of the Tornado", {

	smoke_color_r 		= "255",
	smoke_color_g		= "255",
	smoke_color_b 		= "255",
	smoke_color_a 		= "255",
	smoke_material 		= "particle/particle_smokegrenade.vmt",
	smoke_spreadbase		= "1024",
	smoke_spreadspeed		= "1024",
	smoke_speed 		= "512",
	smoke_startsize 		= "512",
	smoke_endsize 		= "1024",
	smoke_roll 		= "64",
	smoke_numparticles		= "64",
	smoke_jetlength		= "2048",
	smoke_twist 		= "128",

} )

presets.Add( "smoke", "Landing Zone", {

	smoke_color_r 		= "172",
	smoke_color_g		= "172",
	smoke_color_b 		= "172",
	smoke_color_a 		= "255",
	smoke_material 		= "particle/particle_smokegrenade.vmt",
	smoke_spreadbase		= "16",
	smoke_spreadspeed		= "2048",
	smoke_speed 		= "256",
	smoke_startsize 		= "16",
	smoke_endsize 		= "512",
	smoke_roll 		= "16",
	smoke_numparticles		= "32",
	smoke_jetlength		= "128",
	smoke_twist 		= "32",

} )

presets.Add( "smoke", "Poison Gas", {

	smoke_color_r 		= "255",
	smoke_color_g		= "210",
	smoke_color_b 		= "12",
	smoke_color_a 		= "255",
	smoke_material 		= "particle/smokesprites_0001.vmt",
	smoke_spreadbase		= "64",
	smoke_spreadspeed		= "64",
	smoke_speed 		= "128",
	smoke_startsize 		= "32",
	smoke_endsize 		= "256",
	smoke_roll 		= "32",
	smoke_numparticles		= "16",
	smoke_jetlength		= "256",
	smoke_twist 		= "32",

} )

presets.Add( "smoke", "Smoke Cloud", {

	smoke_color_r 		= "120",
	smoke_color_g		= "120",
	smoke_color_b 		= "120",
	smoke_color_a 		= "62",
	smoke_material 		= "particle/particle_smokegrenade.vmt",
	smoke_spreadbase		= "64",
	smoke_spreadspeed		= "128",
	smoke_speed 		= "8",
	smoke_startsize 		= "256",
	smoke_endsize 		= "32",
	smoke_roll 		= "16",
	smoke_numparticles		= "32",
	smoke_jetlength		= "64",
	smoke_twist 		= "2",

} )

presets.Add( "smoke", "Smokestack", {

	smoke_color_r 		= "62",
	smoke_color_g		= "62",
	smoke_color_b 		= "62",
	smoke_color_a 		= "100",
	smoke_material 		= "particle/smokesprites_0001.vmt",
	smoke_spreadbase		= "32",
	smoke_spreadspeed		= "16",
	smoke_speed 		= "64",
	smoke_startsize 		= "32",
	smoke_endsize 		= "256",
	smoke_roll 		= "16",
	smoke_numparticles		= "12",
	smoke_jetlength		= "1024",
	smoke_twist 		= "12",

} )

presets.Add( "smoke", "Desert Dust", {

	smoke_color_r 		= "210",
	smoke_color_g		= "182",
	smoke_color_b 		= "128",
	smoke_color_a 		= "92",
	smoke_material 		= "particle/particle_smokegrenade.vmt",
	smoke_spreadbase		= "128",
	smoke_spreadspeed		= "192",
	smoke_speed 		= "18",
	smoke_startsize 		= "128",
	smoke_endsize 		= "320",
	smoke_roll 		= "10",
	smoke_numparticles		= "32",
	smoke_jetlength		= "172",
	smoke_twist 		= "18",

} )

//SMOKE TRAIL

presets.Add( "smoke_trail", "Rocket Exhaust", {

	smoke_trail_color_r 		= "255",
	smoke_trail_color_g			= "255",
	smoke_trail_color_b 		= "255",
	smoke_trail_color_a 		= "210",
	smoke_trail_spawnradius 		= "32",
	smoke_trail_lifetime 		= "8",
	smoke_trail_startsize 		= "64",
	smoke_trail_endsize 		= "128",
	smoke_trail_minspeed 		= "16",
	smoke_trail_maxspeed 		= "32",
	smoke_trail_mindirectedspeed 	= "128",
	smoke_trail_maxdirectedspeed 	= "256",
	smoke_trail_spawnrate 		= "128",

} )

//SPARKS

presets.Add( "sparks", "Cartoon", {

	sparks_maxdelay		= "1",
	sparks_magnitude		= "1",
	sparks_traillength		= "6",
	sparks_glow		= "1",
	sparks_makesound		= "1",

} )

presets.Add( "sparks", "Weld", {

	sparks_maxdelay		= "0.05",
	sparks_magnitude		= "0.5",
	sparks_traillength		= "0.5",
	sparks_glow		= "0",
	sparks_makesound		= "0",

} )

presets.Add( "sparks", "Fireworks", {

	sparks_maxdelay		= "0.1",
	sparks_magnitude		= "8",
	sparks_traillength		= "3.2",
	sparks_glow		= "0",
	sparks_makesound		= "0",

} )

//STEAM

presets.Add( "steam", "Dust Kick-up", {

	steam_color_r 		= "255",
	steam_color_g		= "255",
	steam_color_b 		= "255",
	steam_color_a 		= "255",
	steam_jetlength 		= "256",
	steam_spreadspeed		= "32",
	steam_speed 		= "256",
	steam_startsize 		= "16",
	steam_endsize 		= "64",
	steam_rate 		= "32",
	steam_rollspeed 		= "8",
	steam_emissive		= "0",
	steam_heatwave		= "0",
	steam_makesound 		= "0",

} )

presets.Add( "steam", "Jet Turbine", {

	steam_color_r 		= "81",
	steam_color_g		= "81",
	steam_color_b 		= "81",
	steam_color_a 		= "255",
	steam_jetlength 		= "128",
	steam_spreadspeed		= "100",
	steam_speed 		= "472",
	steam_startsize 		= "32",
	steam_endsize 		= "192",
	steam_rate 		= "32",
	steam_rollspeed 		= "4",
	steam_emissive		= "1",
	steam_heatwave		= "0",
	steam_makesound 		= "0",

} )

presets.Add( "steam", "Smoke Machine", {

	steam_color_r 		= "255",
	steam_color_g		= "255",
	steam_color_b 		= "255",
	steam_color_a 		= "255",
	steam_jetlength 		= "256",
	steam_spreadspeed		= "32",
	steam_speed 		= "120",
	steam_startsize 		= "32",
	steam_endsize 		= "82",
	steam_rate 		= "24",
	steam_rollspeed 		= "2",
	steam_emissive		= "1",
	steam_heatwave		= "0",
	steam_makesound 		= "0",

} )

presets.Add( "steam", "Vapour Jet (Small)", {

	steam_color_r 		= "255",
	steam_color_g		= "255",
	steam_color_b 		= "255",
	steam_color_a 		= "255",
	steam_jetlength 		= "64",
	steam_spreadspeed		= "12",
	steam_speed 		= "150",
	steam_startsize 		= "6",
	steam_endsize 		= "16",
	steam_rate 		= "64",
	steam_rollspeed 		= "12",
	steam_emissive		= "1",
	steam_heatwave		= "0",
	steam_makesound 		= "1",

} )

presets.Add( "steam", "Vapour Jet (Medium)", {

	steam_color_r 		= "255",
	steam_color_g		= "255",
	steam_color_b 		= "255",
	steam_color_a 		= "255",
	steam_jetlength 		= "128",
	steam_spreadspeed		= "21",
	steam_speed 		= "140",
	steam_startsize 		= "12",
	steam_endsize 		= "42",
	steam_rate 		= "32",
	steam_rollspeed 		= "10",
	steam_emissive		= "1",
	steam_heatwave		= "0",
	steam_makesound 		= "1",

} )

presets.Add( "steam", "Vapour Jet (Big)", {

	steam_color_r 		= "255",
	steam_color_g		= "255",
	steam_color_b 		= "255",
	steam_color_a 		= "255",
	steam_jetlength 		= "256",
	steam_spreadspeed		= "21",
	steam_speed 		= "160",
	steam_startsize 		= "16",
	steam_endsize 		= "52",
	steam_rate 		= "32",
	steam_rollspeed 		= "8",
	steam_emissive		= "1",
	steam_heatwave		= "0",
	steam_makesound 		= "1",

} )

presets.Add( "steam", "Mist", {

	steam_color_r 		= "255",
	steam_color_g		= "255",
	steam_color_b 		= "255",
	steam_color_a 		= "42",
	steam_jetlength 		= "256",
	steam_spreadspeed		= "128",
	steam_speed 		= "82",
	steam_startsize 		= "64",
	steam_endsize 		= "92",
	steam_rate 		= "16",
	steam_rollspeed 		= "2",
	steam_emissive		= "1",
	steam_heatwave		= "0",
	steam_makesound 		= "0",

} )

//TESLA

presets.Add( "tesla", "Disco", {

	tesla_dischargeradius	= "1024",
	tesla_dischargeinterval	= "0.5",
	tesla_beamcount		= "12",
	tesla_beamthickness	= "10",
	tesla_beamlifetime		= "2.1",
	tesla_sound		= "0",

} )

presets.Add( "tesla", "Local Spark", {

	tesla_dischargeradius	= "128",
	tesla_dischargeinterval	= "1.12",
	tesla_beamcount		= "12",
	tesla_beamthickness	= "6",
	tesla_beamlifetime		= "0.12",
	tesla_sound		= "1",

} )

presets.Add( "tesla", "Single Powerful Discharge", {

	tesla_dischargeradius	= "2048",
	tesla_dischargeinterval	= "2.1",
	tesla_beamcount		= "2",
	tesla_beamthickness	= "16",
	tesla_beamlifetime		= "0.12",
	tesla_sound		= "0",

} )


end

//Make sure all clients download default presets
if SERVER then
AddCSLuaFile("autorun/default_sfx_presets_d2k.lua")
end