--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PrecacheParticleSystem("cmb_tracer")
PrecacheParticleSystem("ar2_combineball")

if CLIENT then
	game.AddParticles("particles/cmb_tracers_rework.pcf")
	CreateClientConVar("cmb_tracers_energyball", 1)
end

if SERVER then
	game.AddParticles("particles/cmb_tracers_rework.pcf")
end