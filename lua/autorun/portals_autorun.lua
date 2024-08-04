--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if SERVER then
	resource.AddWorkshop("2841352626")
end

CreateConVar("portals_allow_custom_colors", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether players should be able to change portal colors.", 0, 1)
CreateConVar("portals_allow_custom_sounds", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether players should be able to change portal sounds.", 0, 1)

CreateConVar("portals_default_sound", "beams/beamstart5.wav", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The default sound that is used for portal effects.")

CreateConVar("portals_extended_whitelist", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether portals should teleport non-player, non-npc entities.")

if CLIENT then
	CreateClientConVar("portals_lights_enabled", 1, true, false, "Whether portals should emit light.", 0, 1)
	CreateClientConVar("portals_lights_range", 1024, true, false, "The range at which portals emit light.", 0)
end
