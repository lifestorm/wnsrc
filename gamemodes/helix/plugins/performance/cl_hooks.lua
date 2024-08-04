--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- I really should've made like a table to be able to loop though, oh well.
function PLUGIN:InitPostEntity()
	RunConsoleCommand("gmod_mcore_test", ix.option.Get("gmod_mcore_test", true) and 1 or 0)
	RunConsoleCommand("mat_queue_mode", ix.option.Get("mat_queue_mode", -1))
	RunConsoleCommand("cl_threaded_bone_setup", ix.option.Get("cl_threaded_bone_setup", true) and 1 or 0)
	RunConsoleCommand("r_decals", ix.option.Get("r_decals", 2048))
	RunConsoleCommand("r_drawmodeldecals", ix.option.Get("r_drawmodeldecals", true) and 1 or 0)
	RunConsoleCommand("r_maxmodeldecal", ix.option.Get("r_maxmodeldecal", 50))
	RunConsoleCommand("cl_ragdoll_collide", ix.option.Get("cl_ragdoll_collide", false) and 1 or 0)
	RunConsoleCommand("r_WaterDrawReflection", ix.option.Get("r_WaterDrawReflection", true) and 1 or 0)
	RunConsoleCommand("r_shadows", ix.option.Get("r_shadows", true) and 1 or 0)
	RunConsoleCommand("mat_mipmaptextures", ix.option.Get("mat_mipmaptextures", true) and 1 or 0)
	RunConsoleCommand("mat_envmapsize", ix.option.Get("mat_envmapsize", 128))
	RunConsoleCommand("cl_phys_props_enable", ix.option.Get("cl_phys_props_enable", true) and 1 or 0)
	RunConsoleCommand("cl_ejectbrass", ix.option.Get("cl_ejectbrass", true) and 1 or 0)
	RunConsoleCommand("mat_filterlightmaps", ix.option.Get("mat_filterlightmaps", true) and 1 or 0)
	RunConsoleCommand("muzzleflash_light", ix.option.Get("muzzleflash_light", true) and 1 or 0)
	RunConsoleCommand("props_break_max_pieces", ix.option.Get("props_break_max_pieces", -1))
	RunConsoleCommand("r_3dsky", ix.option.Get("r_3dsky", true) and 1 or 0)
	RunConsoleCommand("r_maxdlights", ix.option.Get("r_maxdlights", 32))
	RunConsoleCommand("r_eyemove", ix.option.Get("r_eyemove", true) and 1 or 0)
	RunConsoleCommand("r_eyes", ix.option.Get("r_eyes", true) and 1 or 0)
	RunConsoleCommand("r_teeth", ix.option.Get("r_teeth", true) and 1 or 0)
	RunConsoleCommand("r_radiosity", ix.option.Get("r_radiosity", 3))
	RunConsoleCommand("r_worldlights", ix.option.Get("r_worldlights", 4))
	RunConsoleCommand("rope_averagelight", ix.option.Get("rope_averagelight", true) and 1 or 0)
	RunConsoleCommand("rope_collide", ix.option.Get("rope_collide", true) and 1 or 0)
	RunConsoleCommand("rope_rendersolid", ix.option.Get("rope_rendersolid", true) and 1 or 0)
	RunConsoleCommand("rope_smooth", ix.option.Get("rope_smooth", true) and 1 or 0)
	RunConsoleCommand("rope_subdiv", ix.option.Get("rope_subdiv", 2))
	RunConsoleCommand("violence_ablood", ix.option.Get("violence_ablood", true) and 1 or 0)
	RunConsoleCommand("violence_agibs", ix.option.Get("violence_agibs", true) and 1 or 0)
	RunConsoleCommand("violence_hblood", ix.option.Get("violence_hblood", true) and 1 or 0)
	RunConsoleCommand("violence_hgibs", ix.option.Get("violence_hgibs", true) and 1 or 0)
	RunConsoleCommand("ai_expression_optimization", ix.option.Get("ai_expression_optimization", true) and 1 or 0)
	RunConsoleCommand("cl_detaildist", ix.option.Get("cl_detaildist", 1200))
	RunConsoleCommand("cl_detailfade", ix.option.Get("cl_detailfade", 400))
	RunConsoleCommand("r_fastzreject", ix.option.Get("r_fastzreject", -1))
	RunConsoleCommand("cl_show_splashes", ix.option.Get("cl_show_splashes", true) and 1 or 0)
	RunConsoleCommand("r_drawflecks", ix.option.Get("r_drawflecks", true) and 1 or 0)
	RunConsoleCommand("r_threaded_particles", ix.option.Get("r_threaded_particles", true) and 1 or 0)
	RunConsoleCommand("snd_mix_async", ix.option.Get("snd_mix_async", true) and 1 or 0)
	RunConsoleCommand("r_threaded_renderables", ix.option.Get("r_threaded_renderables", true) and 1 or 0)
	RunConsoleCommand("cl_forcepreload", ix.option.Get("cl_forcepreload", false) and 1 or 0)
end
