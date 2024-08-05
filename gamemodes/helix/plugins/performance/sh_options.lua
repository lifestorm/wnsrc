--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.option.Add("gmod_mcore_test", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("gmod_mcore_test", value and 1 or 0)
	end
})

ix.option.Add("mat_queue_mode", ix.type.number, -1, {
	category = "performance",
	min = -1,
	max = 2,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("mat_queue_mode", value)
	end
})

ix.option.Add("cl_threaded_bone_setup", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("cl_threaded_bone_setup", value and 1 or 0)
	end
})

ix.option.Add("r_decals", ix.type.number, 2048, {
	category = "performance",
	min = 0,
	max = 10000,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_decals", value)
	end
})

ix.option.Add("r_drawmodeldecals", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_drawmodeldecals", value and 1 or 0)
	end
})

ix.option.Add("r_maxmodeldecal", ix.type.number, 50, {
	category = "performance",
	min = 0,
	max = 1000,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_maxmodeldecal", value)
	end
})

ix.option.Add("cl_ragdoll_collide", ix.type.bool, false, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("cl_ragdoll_collide", value and 1 or 0)
	end
})

ix.option.Add("r_WaterDrawReflection", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_WaterDrawReflection", value and 1 or 0)
	end
})

ix.option.Add("r_WaterDrawRefraction", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_WaterDrawRefraction", value and 1 or 0)
	end
})

ix.option.Add("r_shadows", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_shadows", value and 1 or 0)
	end
})

ix.option.Add("mat_mipmaptextures", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("mat_mipmaptextures", value and 1 or 0)
	end
})

ix.option.Add("mat_filtertextures", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("mat_filtertextures", value and 1 or 0)
	end
})

ix.option.Add("mat_envmapsize", ix.type.number, 128, {
	category = "performance",
	min = 0,
	max = 1000,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("mat_envmapsize", value)
	end
})

ix.option.Add("cl_phys_props_enable", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("cl_phys_props_enable", value and 1 or 0)
	end
})

ix.option.Add("cl_ejectbrass", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("cl_ejectbrass", value and 1 or 0)
	end
})

ix.option.Add("mat_filterlightmaps", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("mat_filterlightmaps", value and 1 or 0)
	end
})

ix.option.Add("muzzleflash_light", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("muzzleflash_light", value and 1 or 0)
	end
})

ix.option.Add("props_break_max_pieces", ix.type.number, -1, {
	category = "performance",
	min = -1,
	max = 50,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("props_break_max_pieces", value)
	end
})

ix.option.Add("r_3dsky", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_3dsky", value and 1 or 0)
	end
})

ix.option.Add("r_maxdlights", ix.type.number, 32, {
	category = "performance",
	min = 0,
	max = 100,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_maxdlights", value)
	end
})

ix.option.Add("r_eyemove", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_eyemove", value and 1 or 0)
	end
})

ix.option.Add("r_eyes", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_eyes", value and 1 or 0)
	end
})

ix.option.Add("r_teeth", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_teeth", value and 1 or 0)
	end
})

ix.option.Add("r_radiosity", ix.type.number, 3, {
	category = "performance",
	min = 1,
	max = 3,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_radiosity", value)
	end
})

ix.option.Add("r_worldlights", ix.type.number, 4, {
	category = "performance",
	min = 0,
	max = 4,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_worldlights", value)
	end
})

ix.option.Add("rope_averagelight", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("rope_averagelight", value and 1 or 0)
	end
})

ix.option.Add("rope_collide", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("rope_collide", value and 1 or 0)
	end
})

ix.option.Add("rope_rendersolid", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("rope_rendersolid", value and 1 or 0)
	end
})

ix.option.Add("rope_smooth", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("rope_smooth", value and 1 or 0)
	end
})

ix.option.Add("rope_subdiv", ix.type.number, 2, {
	category = "performance",
	min = 0,
	max = 8,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("rope_subdiv", value)
	end
})

ix.option.Add("violence_ablood", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("violence_ablood", value and 1 or 0)
	end
})

ix.option.Add("violence_agibs", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("violence_agibs", value and 1 or 0)
	end
})

ix.option.Add("violence_hblood", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("violence_hblood", value and 1 or 0)
	end
})

ix.option.Add("violence_hgibs", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("violence_hgibs", value and 1 or 0)
	end
})

ix.option.Add("ai_expression_optimization", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("ai_expression_optimization", value and 1 or 0)
	end
})

ix.option.Add("cl_detaildist", ix.type.number, 1200, {
	category = "performance",
	min = 0,
	max = 10000,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("cl_detaildist", value)
	end
})

ix.option.Add("cl_detailfade", ix.type.number, 400, {
	category = "performance",
	min = 0,
	max = 10000,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("cl_detailfade", value)
	end
})

ix.option.Add("r_fastzreject", ix.type.number, -1, {
	category = "performance",
	min = -1,
	max = 1,
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_fastzreject", value)
	end
})

ix.option.Add("cl_show_splashes", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("cl_show_splashes", value and 1 or 0)
	end
})

ix.option.Add("r_drawflecks", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_drawflecks", value and 1 or 0)
	end
})

ix.option.Add("r_threaded_particles", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_threaded_particles", value and 1 or 0)
	end
})

ix.option.Add("snd_mix_async", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("snd_mix_async", value and 1 or 0)
	end
})

ix.option.Add("r_threaded_renderables", ix.type.bool, true, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("r_threaded_renderables", value and 1 or 0)
	end
})

ix.option.Add("cl_forcepreload", ix.type.bool, false, {
	category = "performance",
	OnChanged = function(oldValue, value)
		RunConsoleCommand("cl_forcepreload", value and 1 or 0)
	end
})
