--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

require("pk_pills")

AddCSLuaFile()

if SERVER then
    resource.AddWorkshop("106427033")
    include("ppp_include/drivemodes.lua")
end

game.AddParticles("particles/Vortigaunt_FX.pcf")
PrecacheParticleSystem("vortigaunt_beam")
PrecacheParticleSystem("vortigaunt_beam_b")

include("ppp_include/vox_lists.lua")

pk_pills.packStart("Half-Life 2","base","games/16/hl2.png")

include("ppp_include/pill_combine_soldiers.lua")
include("ppp_include/pill_combine_phys_small.lua")
include("ppp_include/pill_combine_phys_large.lua")
include("ppp_include/pill_combine_misc.lua")
include("ppp_include/pill_combine_new.lua")

include("ppp_include/pill_headcrabs.lua")
include("ppp_include/pill_zombies.lua")

include("ppp_include/pill_antlions.lua")
include("ppp_include/pill_wild.lua")

include("ppp_include/pill_resistance_heros.lua")
include("ppp_include/pill_resistance.lua")
include("ppp_include/pill_vorts.lua")

include("ppp_include/pill_birds.lua")

pk_pills.packStart("Fun","fun","icon16/rainbow.png")

include("ppp_include/pill_fun.lua")
include("ppp_include/pill_fun2.lua")
include("ppp_include/pill_fun3.lua")
include("ppp_include/pill_360_noscope.lua")

pk_pills.packStart("Jake","jake","icon16/box.png")

include("ppp_include/pill_jake.lua")
