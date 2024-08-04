--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

--Config GUI

local function tfaOptionServer(panel)
	--Here are whatever default categories you want.
	local tfaOptionSV = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_server"
	}

	tfaOptionSV.Options["#preset.default"] = {
		sv_tfa_ironsights_enabled = "1",
		sv_tfa_sprint_enabled = "1",
		sv_tfa_weapon_strip = "0",
		sv_tfa_allow_dryfire = "1",
		sv_tfa_damage_multiplier = "1",
		sv_tfa_damage_multiplier_npc = "1",
		sv_tfa_default_clip = "-1",
		sv_tfa_arrow_lifetime = "30",
		sv_tfa_force_multiplier = "1",
		sv_tfa_bullet_penetration_power_mul = "1",
		sv_tfa_dynamicaccuracy = "1",
		sv_tfa_range_modifier = "0.5",
		sv_tfa_spread_multiplier = "1",
		sv_tfa_bullet_penetration = "1",
		sv_tfa_bullet_ricochet = "0",
		sv_tfa_bullet_doordestruction = "1",
		sv_tfa_melee_doordestruction = "1",
		sv_tfa_bullet_randomseed = "0",
		sv_tfa_reloads_legacy = "0",
		sv_tfa_fixed_crosshair = "0",
		sv_tfa_cmenu = "1",
		sv_tfa_penetration_hardlimit = "100",
		sv_tfa_jamming = "1",
		sv_tfa_jamming_mult = "1",
		sv_tfa_jamming_factor = "1",
		sv_tfa_jamming_factor_inc = "1",
		sv_tfa_door_respawn = "-1"
	}

	tfaOptionSV.CVars = table.GetKeys(tfaOptionSV.Options["#preset.default"])

	panel:AddControl("ComboBox", tfaOptionSV)

	--These are the panel controls.  Adding these means that you don't have to go into the console.
	TFA.CheckBoxNet(panel, "#tfa.svsettings.dryfire", "sv_tfa_allow_dryfire")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.dynaccuracy", "sv_tfa_dynamicaccuracy")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.stripempty", "sv_tfa_weapon_strip")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.ironsight", "sv_tfa_ironsights_enabled")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.sprint", "sv_tfa_sprint_enabled")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.cmenu", "sv_tfa_cmenu")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.penetration", "sv_tfa_bullet_penetration")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.ricochet", "sv_tfa_bullet_ricochet")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.doorbust", "sv_tfa_bullet_doordestruction")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.doorbash", "sv_tfa_melee_doordestruction")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.jamming", "sv_tfa_jamming")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.nearlyempty", "sv_tfa_nearlyempty")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.legacyreloads", "sv_tfa_reloads_legacy")
	TFA.CheckBoxNet(panel, "#tfa.svsettings.fixedcrosshair", "sv_tfa_fixed_crosshair")

	TFA.CheckBoxNet(panel, "#tfa.svsettings.randomseed", "sv_tfa_bullet_randomseed")
	panel:Help("#tfa.svsettings.randomseed_tip")

	TFA.NumSliderNet(panel, "#tfa.svsettings.damagemult", "sv_tfa_damage_multiplier", 0, 10, 2)
	TFA.NumSliderNet(panel, "#tfa.svsettings.damagemultnpc", "sv_tfa_damage_multiplier_npc", 0, 10, 2)
	TFA.NumSliderNet(panel, "#tfa.svsettings.doorrespawntime", "sv_tfa_door_respawn", -1, 120, 0)

	TFA.NumSliderNet(panel, "#tfa.svsettings.jamchance", "sv_tfa_jamming_mult", 0.01, 10, 2)
	TFA.NumSliderNet(panel, "#tfa.svsettings.jamfactormult", "sv_tfa_jamming_factor", 0.01, 10, 2)
	TFA.NumSliderNet(panel, "#tfa.svsettings.jamfactorinc", "sv_tfa_jamming_factor_inc", 0.01, 10, 2)

	TFA.NumSliderNet(panel, "#tfa.svsettings.forcemult", "sv_tfa_force_multiplier", 0, 10, 2)
	TFA.NumSliderNet(panel, "#tfa.svsettings.penpowermul", "sv_tfa_bullet_penetration_power_mul", 0, 40, 2)
	TFA.NumSliderNet(panel, "#tfa.svsettings.spreadmult", "sv_tfa_spread_multiplier", 0, 10, 2)
	TFA.NumSliderNet(panel, "#tfa.svsettings.penetrationlimit", "sv_tfa_penetration_hardlimit", 0, 200)
	TFA.NumSliderNet(panel, "#tfa.svsettings.defaultclip", "sv_tfa_default_clip", -1, 10, 0)
	TFA.NumSliderNet(panel, "#tfa.svsettings.rangemod", "sv_tfa_range_modifier", 0, 1, 3)
end

local function tfaOptionSights(panel)
	--Here are whatever default categories you want.
	local tfaOptionCL = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_sights"
	}

	tfaOptionCL.Options["#preset.default"] = {
		cl_tfa_3dscope = "1",
		cl_tfa_3dscope_overlay = "1",
		cl_tfa_3dscope_quality = "0",
		cl_tfa_fx_rtscopeblur_passes = "3",
		cl_tfa_fx_rtscopeblur_intensity = "4",
		cl_tfa_fx_rtscopeblur_mode = "1",
		cl_tfa_scope_sensitivity_3d = "2",
		cl_tfa_scope_sensitivity_autoscale = "1",
		cl_tfa_scope_sensitivity = "100",
		cl_tfa_ironsights_toggle = "0",
		cl_tfa_ironsights_resight = "1",
		cl_tfa_ironsights_responsive = "0",
		cl_tfa_ironsights_responsive_timer = "0.175",
	}

	tfaOptionCL.CVars = table.GetKeys(tfaOptionCL.Options["#preset.default"])

	panel:AddControl("ComboBox", tfaOptionCL)

	panel:CheckBox("#tfa.sightsettings.3dscopes", "cl_tfa_3dscope")
	panel:CheckBox("#tfa.sightsettings.3dscopeshadows", "cl_tfa_3dscope_overlay")

	local tfaOption3DSM = {
		Options = {},
		CVars = {},
		Label = "#tfa.sightsettings.3dsm",
		MenuButton = "0",
		Folder = "TFA 3D Scope Sens."
	}

	tfaOption3DSM.Options["#tfa.sightsettings.3dsm.nc"] = {
		cl_tfa_scope_sensitivity_3d = "0"
	}

	tfaOption3DSM.Options["#tfa.sightsettings.3dsm.nc"] = {
		cl_tfa_scope_sensitivity_3d = "0"
	}

	tfaOption3DSM.Options["#tfa.sightsettings.3dsm.sc"] = {
		cl_tfa_scope_sensitivity_3d = "1"
	}

	tfaOption3DSM.Options["#tfa.sightsettings.3dsm.3d"] = {
		cl_tfa_scope_sensitivity_3d = "2"
	}

	tfaOption3DSM.Options["#tfa.sightsettings.3dsm.rt"] = {
		cl_tfa_scope_sensitivity_3d = "3"
	}

	tfaOption3DSM.CVars = table.GetKeys(tfaOption3DSM.Options["#tfa.sightsettings.3dsm.3d"])
	panel:AddControl("ComboBox", tfaOption3DSM)

	local tfaOption3DSQ = {
		Options = {},
		CVars = {},
		Label = "#tfa.sightsettings.3dsq",
		MenuButton = "0",
		Folder = "TFA 3D Scope Sens."
	}

	tfaOption3DSQ.Options["#tfa.sightsettings.3dsq.ul"] = {
		cl_tfa_3dscope_quality = "0"
	}

	tfaOption3DSQ.Options["#tfa.sightsettings.3dsq.hq"] = {
		cl_tfa_3dscope_quality = "1"
	}

	tfaOption3DSQ.Options["#tfa.sightsettings.3dsq.mq"] = {
		cl_tfa_3dscope_quality = "2"
	}

	tfaOption3DSQ.Options["#tfa.sightsettings.3dsq.lq"] = {
		cl_tfa_3dscope_quality = "3"
	}

	tfaOption3DSQ.CVars = table.GetKeys(tfaOption3DSQ.Options["#tfa.sightsettings.3dsq.ul"])
	panel:AddControl("ComboBox", tfaOption3DSQ)

	local tfaOption3DSB = {
		Options = {},
		CVars = {},
		Label = "#tfa.sightsettings.3dsb",
		MenuButton = "0",
		Folder = "TFA 3D Scope Blur."
	}

	tfaOption3DSB.Options["#tfa.sightsettings.3dsb.nb"] = {
		cl_tfa_fx_rtscopeblur_mode = "0"
	}

	tfaOption3DSB.Options["#tfa.sightsettings.3dsb.sb"] = {
		cl_tfa_fx_rtscopeblur_mode = "1"
	}

	tfaOption3DSB.Options["#tfa.sightsettings.3dsb.bb"] = {
		cl_tfa_fx_rtscopeblur_mode = "2"
	}

	tfaOption3DSB.CVars = table.GetKeys(tfaOption3DSB.Options["#tfa.sightsettings.3dsb.bb"])
	panel:AddControl("ComboBox", tfaOption3DSB)

	panel:NumSlider("#tfa.sightsettings.rtbgblurpasses", "cl_tfa_fx_rtscopeblur_passes", 1, 5, 0)
	panel:NumSlider("#tfa.sightsettings.rtbgblurintensity", "cl_tfa_fx_rtscopeblur_intensity", 0.01, 10, 2)
	panel:CheckBox("#tfa.sightsettings.adstoggle", "cl_tfa_ironsights_toggle")
	panel:CheckBox("#tfa.sightsettings.adsresight", "cl_tfa_ironsights_resight")
	panel:CheckBox("#tfa.sightsettings.responsive", "cl_tfa_ironsights_responsive")
	panel:NumSlider("#tfa.sightsettings.responsive_timer", "cl_tfa_ironsights_responsive_timer", 0.01, 2, 4)
	panel:CheckBox("#tfa.sightsettings.scopesensscale", "cl_tfa_scope_sensitivity_autoscale")
	panel:NumSlider("#tfa.sightsettings.scopesenspct", "cl_tfa_scope_sensitivity", 0.01, 100, 2)
end

local function tfaOptionVM(panel)
	--Here are whatever default categories you want.
	local tfaOptionCL = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_viewmodel"
	}

	tfaOptionCL.Options["#preset.default"] = {
		cl_tfa_viewbob_animated = "0",
		cl_tfa_viewbob_intensity = "1",
		cl_tfa_gunbob_intensity = "1",
		cl_tfa_gunbob_custom = "1",
		cl_tfa_viewmodel_offset_x = "0",
		cl_tfa_viewmodel_offset_y = "0",
		cl_tfa_viewmodel_offset_z = "0",
		cl_tfa_viewmodel_offset_fov = "0",
		cl_tfa_viewmodel_flip = "0",
		cl_tfa_viewmodel_centered = "0",
		cl_tfa_viewmodel_nearwall = "1",
		cl_tfa_laser_trails = "1"
	}

	tfaOptionCL.CVars = table.GetKeys(tfaOptionCL.Options["#preset.default"])
	panel:AddControl("ComboBox", tfaOptionCL)

	panel:CheckBox("#tfa.vmsettings.viewbobanim", "cl_tfa_viewbob_animated")
	panel:NumSlider("#tfa.vmsettings.viewbobmult", "cl_tfa_viewbob_intensity", 0, 2, 2)
	panel:CheckBox("#tfa.vmsettings.gunbobcustom", "cl_tfa_gunbob_custom")
	panel:NumSlider("#tfa.vmsettings.gunbobmult", "cl_tfa_gunbob_intensity", 0, 2, 2)

	panel:NumSlider("#tfa.vmsettings.offset.x", "cl_tfa_viewmodel_offset_x", -2, 2, 2)
	panel:NumSlider("#tfa.vmsettings.offset.y", "cl_tfa_viewmodel_offset_y", -2, 2, 2)
	panel:NumSlider("#tfa.vmsettings.offset.z", "cl_tfa_viewmodel_offset_z", -2, 2, 2)
	panel:NumSlider("#tfa.vmsettings.offset.fov", "cl_tfa_viewmodel_offset_fov", -5, 5, 2)

	panel:CheckBox("#tfa.vmsettings.centered", "cl_tfa_viewmodel_centered")
	panel:CheckBox("#tfa.vmsettings.flip", "cl_tfa_viewmodel_flip")

	panel:CheckBox("#tfa.vmsettings.laserdottrail", "cl_tfa_laser_trails")
	panel:CheckBox("#tfa.vmsettings.nearwall", "cl_tfa_viewmodel_nearwall")
end

local function tfaOptionPerformance(panel)
	--Here are whatever default categories you want.
	local tfaOptionPerf = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_performance"
	}

	tfaOptionPerf.Options["#preset.default"] = {
		sv_tfa_fx_penetration_decal = "1",
		cl_tfa_fx_impact_enabled = "1",
		cl_tfa_fx_impact_ricochet_enabled = "1",
		cl_tfa_fx_impact_ricochet_sparks = "20",
		cl_tfa_fx_impact_ricochet_sparklife = "2",
		cl_tfa_fx_gasblur = "1",
		cl_tfa_fx_muzzlesmoke = "1",
		cl_tfa_fx_muzzlesmoke_limited = "1",
		cl_tfa_fx_muzzleflashsmoke = "1",
		cl_tfa_fx_ejectionlife = "15",
		cl_tfa_legacy_shells = "0",
		cl_tfa_fx_ads_dof = "0",
		cl_tfa_fx_ads_dof_hd = "0"
	}

	tfaOptionPerf.CVars = table.GetKeys(tfaOptionPerf.Options["#preset.default"])
	panel:AddControl("ComboBox", tfaOptionPerf)

	panel:Help("#tfa.settings.client")
	panel:CheckBox("#tfa.perfsettings.gasblur", "cl_tfa_fx_gasblur")
	panel:CheckBox("#tfa.perfsettings.mzsmoke", "cl_tfa_fx_muzzleflashsmoke")
	panel:CheckBox("#tfa.perfsettings.mztrail", "cl_tfa_fx_muzzlesmoke")
	panel:CheckBox("#tfa.perfsettings.mztrail.limit", "cl_tfa_fx_muzzlesmoke_limited")
	panel:CheckBox("#tfa.perfsettings.ejsmoke", "cl_tfa_fx_ejectionsmoke")
	panel:CheckBox("#tfa.perfsettings.impactfx", "cl_tfa_fx_impact_enabled")
	panel:CheckBox("#tfa.perfsettings.ricochetfx", "cl_tfa_fx_impact_ricochet_enabled")

	panel:CheckBox("#tfa.perfsettings.oldshells", "cl_tfa_legacy_shells")

	panel:CheckBox("#tfa.perfsettings.adsdof", "cl_tfa_fx_ads_dof")
	panel:CheckBox("#tfa.perfsettings.adsdof.hd", "cl_tfa_fx_ads_dof_hd")

	panel:NumSlider("#tfa.perfsettings.ejlife", "cl_tfa_fx_ejectionlife", 0, 60, 0)

	panel:NumSlider("#tfa.perfsettings.ricochetspark.amount", "cl_tfa_fx_impact_ricochet_sparks", 0, 50, 0)
	panel:AddControl("Slider", {
		Label = "Ricochet Spark Amount",
		Command = "cl_tfa_fx_impact_ricochet_sparks",
		Type = "Integer",
		Min = "0",
		Max = "50"
	})

	panel:NumSlider("#tfa.perfsettings.ricochetspark.life", "cl_tfa_fx_impact_ricochet_sparklife", 0, 5, 2)

	panel:Help("#tfa.settings.server")
	TFA.CheckBoxNet(panel, "#tfa.perfsettings.penetrationdecal", "sv_tfa_fx_penetration_decal")
end

local function tfaOptionHUD(panel)
	--Here are whatever default categories you want.
	local tfaTBLOptionHUD = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_hud"
	}

	tfaTBLOptionHUD.Options["#preset.default"] = {
		cl_tfa_hud_crosshair_enable_custom = "1",
		cl_tfa_hud_crosshair_color_r = "225",
		cl_tfa_hud_crosshair_color_g = "225",
		cl_tfa_hud_crosshair_color_b = "225",
		cl_tfa_hud_crosshair_color_a = "225",
		cl_tfa_hud_crosshair_color_team = "1",
		cl_tfa_hud_crosshair_outline_color_r = "5",
		cl_tfa_hud_crosshair_outline_color_g = "5",
		cl_tfa_hud_crosshair_outline_color_b = "5",
		cl_tfa_hud_crosshair_outline_color_a = "225",
		cl_tfa_hud_enabled = "1",
		cl_tfa_hud_ammodata_fadein = "0.2",
		cl_tfa_hud_hangtime = "1",
		cl_tfa_hud_crosshair_length_use_pixels = "0",
		cl_tfa_hud_crosshair_length = "1",
		cl_tfa_hud_crosshair_width = "1",
		cl_tfa_hud_crosshair_gap_scale = "1",
		cl_tfa_hud_crosshair_outline_enabled = "1",
		cl_tfa_hud_crosshair_outline_width = "1",
		cl_tfa_hud_crosshair_dot = "0",
		cl_tfa_hud_crosshair_triangular = "0",
		cl_tfa_hud_crosshair_pump = "0",
		cl_tfa_hud_hitmarker_enabled = "1",
		cl_tfa_hud_hitmarker_3d_all = "0",
		cl_tfa_hud_hitmarker_3d_shotguns = "1",
		cl_tfa_hud_hitmarker_solidtime = "0.1",
		cl_tfa_hud_hitmarker_fadetime = "0.3",
		cl_tfa_hud_hitmarker_scale = "1",
		cl_tfa_hud_hitmarker_color_r = "225",
		cl_tfa_hud_hitmarker_color_g = "225",
		cl_tfa_hud_hitmarker_color_b = "225",
		cl_tfa_hud_hitmarker_color_a = "225",
		cl_tfa_hud_scale = "1"
	}

	tfaTBLOptionHUD.Options["#tfa.hudpreset.cross"] = {
		cl_tfa_hud_crosshair_enable_custom = "1",
		cl_tfa_hud_crosshair_color_r = "255",
		cl_tfa_hud_crosshair_color_g = "255",
		cl_tfa_hud_crosshair_color_b = "255",
		cl_tfa_hud_crosshair_color_a = "200",
		cl_tfa_hud_crosshair_color_team = "1",
		cl_tfa_hud_crosshair_outline_color_r = "154",
		cl_tfa_hud_crosshair_outline_color_g = "152",
		cl_tfa_hud_crosshair_outline_color_b = "175",
		cl_tfa_hud_crosshair_outline_color_a = "255",
		cl_tfa_hud_enabled = "1",
		cl_tfa_hud_ammodata_fadein = "0.2",
		cl_tfa_hud_hangtime = "1",
		cl_tfa_hud_crosshair_length_use_pixels = "0",
		cl_tfa_hud_crosshair_length = "0.75",
		cl_tfa_hud_crosshair_width = "1",
		cl_tfa_hud_crosshair_gap_scale = "0",
		cl_tfa_hud_crosshair_outline_enabled = "1",
		cl_tfa_hud_crosshair_outline_width = "1",
		cl_tfa_hud_crosshair_dot = "0",
		cl_tfa_hud_crosshair_triangular = "0",
		cl_tfa_hud_crosshair_pump = "0",
		cl_tfa_hud_hitmarker_enabled = "1",
		cl_tfa_hud_hitmarker_3d_all = "0",
		cl_tfa_hud_hitmarker_3d_shotguns = "1",
		cl_tfa_hud_hitmarker_solidtime = "0.1",
		cl_tfa_hud_hitmarker_fadetime = "0.3",
		cl_tfa_hud_hitmarker_scale = "1",
		cl_tfa_hud_hitmarker_color_r = "225",
		cl_tfa_hud_hitmarker_color_g = "225",
		cl_tfa_hud_hitmarker_color_b = "225",
		cl_tfa_hud_hitmarker_color_a = "225",
		cl_tfa_hud_scale = "1"
	}

	tfaTBLOptionHUD.Options["#tfa.hudpreset.dot"] = {
		cl_tfa_hud_crosshair_enable_custom = "1",
		cl_tfa_hud_crosshair_color_r = "72",
		cl_tfa_hud_crosshair_color_g = "72",
		cl_tfa_hud_crosshair_color_b = "72",
		cl_tfa_hud_crosshair_color_a = "85",
		cl_tfa_hud_crosshair_color_team = "1",
		cl_tfa_hud_crosshair_outline_color_r = "225",
		cl_tfa_hud_crosshair_outline_color_g = "225",
		cl_tfa_hud_crosshair_outline_color_b = "225",
		cl_tfa_hud_crosshair_outline_color_a = "85",
		cl_tfa_hud_enabled = "1",
		cl_tfa_hud_ammodata_fadein = "0.1",
		cl_tfa_hud_hangtime = "0.5",
		cl_tfa_hud_crosshair_length_use_pixels = "0",
		cl_tfa_hud_crosshair_length = "0",
		cl_tfa_hud_crosshair_width = "1",
		cl_tfa_hud_crosshair_gap_scale = "0",
		cl_tfa_hud_crosshair_outline_enabled = "1",
		cl_tfa_hud_crosshair_outline_width = "1",
		cl_tfa_hud_crosshair_dot = "0",
		cl_tfa_hud_crosshair_triangular = "0",
		cl_tfa_hud_crosshair_pump = "0",
		cl_tfa_hud_hitmarker_enabled = "0",
		cl_tfa_hud_hitmarker_3d_all = "0",
		cl_tfa_hud_hitmarker_3d_shotguns = "0",
		cl_tfa_hud_hitmarker_solidtime = "0.1",
		cl_tfa_hud_hitmarker_fadetime = "0.3",
		cl_tfa_hud_hitmarker_scale = "1",
		cl_tfa_hud_hitmarker_color_r = "225",
		cl_tfa_hud_hitmarker_color_g = "225",
		cl_tfa_hud_hitmarker_color_b = "225",
		cl_tfa_hud_hitmarker_color_a = "225",
		cl_tfa_hud_scale = "1"
	}

	tfaTBLOptionHUD.Options["#tfa.hudpreset.rockstar"] = {
		cl_tfa_hud_crosshair_enable_custom = "1",
		cl_tfa_hud_crosshair_color_r = "225",
		cl_tfa_hud_crosshair_color_g = "225",
		cl_tfa_hud_crosshair_color_b = "225",
		cl_tfa_hud_crosshair_color_a = "85",
		cl_tfa_hud_crosshair_color_team = "1",
		cl_tfa_hud_crosshair_outline_color_r = "30",
		cl_tfa_hud_crosshair_outline_color_g = "30",
		cl_tfa_hud_crosshair_outline_color_b = "30",
		cl_tfa_hud_crosshair_outline_color_a = "85",
		cl_tfa_hud_enabled = "1",
		cl_tfa_hud_ammodata_fadein = "0.1",
		cl_tfa_hud_hangtime = "0.5",
		cl_tfa_hud_crosshair_length_use_pixels = "0",
		cl_tfa_hud_crosshair_length = "0",
		cl_tfa_hud_crosshair_width = "2",
		cl_tfa_hud_crosshair_gap_scale = "0",
		cl_tfa_hud_crosshair_outline_enabled = "1",
		cl_tfa_hud_crosshair_outline_width = "1",
		cl_tfa_hud_crosshair_dot = "0",
		cl_tfa_hud_crosshair_triangular = "0",
		cl_tfa_hud_crosshair_pump = "0",
		cl_tfa_hud_hitmarker_enabled = "1",
		cl_tfa_hud_hitmarker_3d_all = "0",
		cl_tfa_hud_hitmarker_3d_shotguns = "0",
		cl_tfa_hud_hitmarker_solidtime = "0.1",
		cl_tfa_hud_hitmarker_fadetime = "0.3",
		cl_tfa_hud_hitmarker_scale = "1",
		cl_tfa_hud_hitmarker_color_r = "225",
		cl_tfa_hud_hitmarker_color_g = "225",
		cl_tfa_hud_hitmarker_color_b = "225",
		cl_tfa_hud_hitmarker_color_a = "8",
		cl_tfa_hud_scale = "1"
	}

	tfaTBLOptionHUD.Options["#tfa.hudpreset.hl2"] = {
		cl_tfa_hud_crosshair_enable_custom = "0",
		cl_tfa_hud_crosshair_color_r = "255",
		cl_tfa_hud_crosshair_color_g = "255",
		cl_tfa_hud_crosshair_color_b = "255",
		cl_tfa_hud_crosshair_color_a = "225",
		cl_tfa_hud_crosshair_color_team = "1",
		cl_tfa_hud_crosshair_outline_color_r = "5",
		cl_tfa_hud_crosshair_outline_color_g = "5",
		cl_tfa_hud_crosshair_outline_color_b = "5",
		cl_tfa_hud_crosshair_outline_color_a = "0",
		cl_tfa_hud_enabled = "1",
		cl_tfa_hud_ammodata_fadein = "0.01",
		cl_tfa_hud_hangtime = "0",
		cl_tfa_hud_crosshair_length_use_pixels = "1",
		cl_tfa_hud_crosshair_length = "0.5",
		cl_tfa_hud_crosshair_width = "1",
		cl_tfa_hud_crosshair_gap_scale = "1",
		cl_tfa_hud_crosshair_outline_enabled = "0",
		cl_tfa_hud_crosshair_outline_width = "0",
		cl_tfa_hud_crosshair_dot = "1",
		cl_tfa_hud_crosshair_triangular = "0",
		cl_tfa_hud_crosshair_pump = "0",
		cl_tfa_hud_hitmarker_enabled = "0",
		cl_tfa_hud_hitmarker_3d_all = "0",
		cl_tfa_hud_hitmarker_3d_shotguns = "0",
		cl_tfa_hud_hitmarker_solidtime = "0.1",
		cl_tfa_hud_hitmarker_fadetime = "0.3",
		cl_tfa_hud_hitmarker_scale = "1",
		cl_tfa_hud_hitmarker_color_r = "225",
		cl_tfa_hud_hitmarker_color_g = "225",
		cl_tfa_hud_hitmarker_color_b = "225",
		cl_tfa_hud_hitmarker_color_a = "225",
		cl_tfa_hud_scale = "1"
	}

	tfaTBLOptionHUD.Options["#tfa.hudpreset.hl2plus"] = {
		cl_tfa_hud_crosshair_enable_custom = "1",
		cl_tfa_hud_crosshair_color_r = "255",
		cl_tfa_hud_crosshair_color_g = "255",
		cl_tfa_hud_crosshair_color_b = "255",
		cl_tfa_hud_crosshair_color_a = "225",
		cl_tfa_hud_crosshair_color_team = "1",
		cl_tfa_hud_crosshair_outline_color_r = "5",
		cl_tfa_hud_crosshair_outline_color_g = "5",
		cl_tfa_hud_crosshair_outline_color_b = "5",
		cl_tfa_hud_crosshair_outline_color_a = "0",
		cl_tfa_hud_enabled = "1",
		cl_tfa_hud_ammodata_fadein = "0.2",
		cl_tfa_hud_hangtime = "1",
		cl_tfa_hud_crosshair_length_use_pixels = "1",
		cl_tfa_hud_crosshair_length = "0.5",
		cl_tfa_hud_crosshair_width = "1",
		cl_tfa_hud_crosshair_gap_scale = "1",
		cl_tfa_hud_crosshair_outline_enabled = "0",
		cl_tfa_hud_crosshair_outline_width = "0",
		cl_tfa_hud_crosshair_dot = "1",
		cl_tfa_hud_crosshair_triangular = "0",
		cl_tfa_hud_crosshair_pump = "0",
		cl_tfa_hud_hitmarker_enabled = "1",
		cl_tfa_hud_hitmarker_3d_all = "0",
		cl_tfa_hud_hitmarker_3d_shotguns = "1",
		cl_tfa_hud_hitmarker_solidtime = "0.1",
		cl_tfa_hud_hitmarker_fadetime = "0.3",
		cl_tfa_hud_hitmarker_scale = "1",
		cl_tfa_hud_hitmarker_color_r = "225",
		cl_tfa_hud_hitmarker_color_g = "225",
		cl_tfa_hud_hitmarker_color_b = "225",
		cl_tfa_hud_hitmarker_color_a = "225",
		cl_tfa_hud_scale = "1"
	}

	tfaTBLOptionHUD.Options["#tfa.hudpreset.crysis2"] = {
		cl_tfa_hud_crosshair_enable_custom = "1",
		cl_tfa_hud_crosshair_color_r = "231",
		cl_tfa_hud_crosshair_color_g = "255",
		cl_tfa_hud_crosshair_color_b = "255",
		cl_tfa_hud_crosshair_color_a = "255",
		cl_tfa_hud_crosshair_color_team = "0",
		cl_tfa_hud_crosshair_outline_color_r = "0",
		cl_tfa_hud_crosshair_outline_color_g = "0",
		cl_tfa_hud_crosshair_outline_color_b = "0",
		cl_tfa_hud_crosshair_outline_color_a = "0",
		cl_tfa_hud_enabled = "1",
		cl_tfa_hud_ammodata_fadein = "0.2",
		cl_tfa_hud_hangtime = "1",
		cl_tfa_hud_crosshair_length_use_pixels = "0",
		cl_tfa_hud_crosshair_length = "1",
		cl_tfa_hud_crosshair_width = "2",
		cl_tfa_hud_crosshair_gap_scale = "1",
		cl_tfa_hud_crosshair_outline_enabled = "0",
		cl_tfa_hud_crosshair_outline_width = "0",
		cl_tfa_hud_crosshair_dot = "0",
		cl_tfa_hud_crosshair_triangular = "1",
		cl_tfa_hud_crosshair_pump = "1",
		cl_tfa_hud_hitmarker_enabled = "1",
		cl_tfa_hud_hitmarker_3d_all = "0",
		cl_tfa_hud_hitmarker_3d_shotguns = "1",
		cl_tfa_hud_hitmarker_solidtime = "0.1",
		cl_tfa_hud_hitmarker_fadetime = "0.3",
		cl_tfa_hud_hitmarker_scale = "1.5",
		cl_tfa_hud_hitmarker_color_r = "231",
		cl_tfa_hud_hitmarker_color_g = "255",
		cl_tfa_hud_hitmarker_color_b = "255",
		cl_tfa_hud_hitmarker_color_a = "255",
		cl_tfa_hud_scale = "1"
	}

	tfaTBLOptionHUD.CVars = table.GetKeys(tfaTBLOptionHUD.Options["#preset.default"])
	panel:AddControl("ComboBox", tfaTBLOptionHUD)

	panel:CheckBox("#tfa.hudsettings.enabled", "cl_tfa_hud_enabled")
	panel:NumSlider("#tfa.hudsettings.fadein", "cl_tfa_hud_ammodata_fadein", 0.01, 1, 2)
	panel:NumSlider("#tfa.hudsettings.hangtime", "cl_tfa_hud_hangtime", 0, 5, 2)
	panel:NumSlider("#tfa.hudsettings.scalemul", "cl_tfa_hud_scale", 0.25, 4, 3)

	panel:CheckBox("#tfa.hudsettings.crosshair.enabled", "cl_tfa_hud_crosshair_enable_custom")
	panel:CheckBox("#tfa.hudsettings.crosshair.dot", "cl_tfa_hud_crosshair_dot")
	panel:CheckBox("#tfa.hudsettings.crosshair.triangular", "cl_tfa_hud_crosshair_triangular")
	panel:CheckBox("#tfa.hudsettings.crosshair.pump", "cl_tfa_hud_crosshair_pump")
	panel:NumSlider("#tfa.hudsettings.crosshair.length", "cl_tfa_hud_crosshair_length", 0, 10, 2)
	panel:CheckBox("#tfa.hudsettings.crosshair.length.usepixels", "cl_tfa_hud_crosshair_length_use_pixels")
	panel:NumSlider("#tfa.hudsettings.crosshair.gapscale", "cl_tfa_hud_crosshair_gap_scale", 0, 2, 2)
	panel:NumSlider("#tfa.hudsettings.crosshair.width", "cl_tfa_hud_crosshair_width", 0, 3, 0)
	panel:CheckBox("#tfa.hudsettings.crosshair.teamcolor", "cl_tfa_hud_crosshair_color_team")
	panel:AddControl("Color", {
		Label = "#tfa.hudsettings.crosshair.color",
		Red = "cl_tfa_hud_crosshair_color_r",
		Green = "cl_tfa_hud_crosshair_color_g",
		Blue = "cl_tfa_hud_crosshair_color_b",
		Alpha = "cl_tfa_hud_crosshair_color_a",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})

	panel:CheckBox("#tfa.hudsettings.crosshair.outline.enabled", "cl_tfa_hud_crosshair_outline_enabled")
	panel:NumSlider("#tfa.hudsettings.crosshair.outline.width", "cl_tfa_hud_crosshair_outline_width", 0, 3, 0)
	panel:AddControl("Color", {
		Label = "#tfa.hudsettings.crosshair.outline.color",
		Red = "cl_tfa_hud_crosshair_outline_color_r",
		Green = "cl_tfa_hud_crosshair_outline_color_g",
		Blue = "cl_tfa_hud_crosshair_outline_color_b",
		Alpha = "cl_tfa_hud_crosshair_outline_color_a",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})

	panel:CheckBox("#tfa.hudsettings.hitmarker.enabled", "cl_tfa_hud_hitmarker_enabled")
	panel:CheckBox("#tfa.hudsettings.hitmarker.3d.shotguns", "cl_tfa_hud_hitmarker_3d_shotguns")
	panel:CheckBox("#tfa.hudsettings.hitmarker.3d.all", "cl_tfa_hud_hitmarker_3d_all")
	panel:NumSlider("#tfa.hudsettings.hitmarker.solidtime", "cl_tfa_hud_hitmarker_solidtime", 0, 1, 2)
	panel:NumSlider("#tfa.hudsettings.hitmarker.fadetime", "cl_tfa_hud_hitmarker_fadetime", 0, 1, 2)
	panel:NumSlider("#tfa.hudsettings.hitmarker.scale", "cl_tfa_hud_hitmarker_scale", 0, 5, 2)
	panel:AddControl("Color", {
		Label = "#tfa.hudsettings.hitmarker.color",
		Red = "cl_tfa_hud_hitmarker_color_r",
		Green = "cl_tfa_hud_hitmarker_color_g",
		Blue = "cl_tfa_hud_hitmarker_color_b",
		Alpha = "cl_tfa_hud_hitmarker_color_a",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})
end

local function tfaOptionDeveloper(panel)
	--Here are whatever default categories you want.
	local tfaOptionPerf = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_debug"
	}

	tfaOptionPerf.Options["#preset.default"] = {
		["cl_tfa_debug_crosshair"] = 0,
		["cl_tfa_debug_animations"] = 0,
		["cl_tfa_debug_rt"] = 0,
		["cl_tfa_debug_cache"] = 0
	}

	tfaOptionPerf.CVars = table.GetKeys(tfaOptionPerf.Options["#preset.default"])
	panel:AddControl("ComboBox", tfaOptionPerf)

	panel:Help("#tfa.devsettings.adminonly")

	panel:CheckBox("#tfa.devsettings.debug.crosshair", "cl_tfa_debug_crosshair")
	panel:CheckBox("#tfa.devsettings.debug.animations", "cl_tfa_debug_animations")
	panel:CheckBox("#tfa.devsettings.debug.rtshadow", "cl_tfa_debug_rt")
	panel:CheckBox("#tfa.devsettings.debug.cache", "cl_tfa_debug_cache")
end

local function tfaOptionColors(panel)
	local tfaOptionCO = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_colors"
	}

	tfaOptionCO.Options["#preset.default"] = {
		cl_tfa_laser_color_r = "255",
		cl_tfa_laser_color_g = "0",
		cl_tfa_laser_color_b = "0",
		cl_tfa_reticule_color_r = "255",
		cl_tfa_reticule_color_g = "100",
		cl_tfa_reticule_color_b = "0"
	}

	tfaOptionCO.CVars = table.GetKeys(tfaOptionCO.Options["#preset.default"])
	panel:AddControl("ComboBox", tfaOptionCO)

	panel:AddControl("Color", {
		Label = "#tfa.colorsettings.laser",
		Red = "cl_tfa_laser_color_r",
		Green = "cl_tfa_laser_color_g",
		Blue = "cl_tfa_laser_color_b",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})

	panel:AddControl("Color", {
		Label = "#tfa.colorsettings.reticule",
		Red = "cl_tfa_reticule_color_r",
		Green = "cl_tfa_reticule_color_g",
		Blue = "cl_tfa_reticule_color_b",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})
end

local function tfaOptionBallistics(panel)
	--Here are whatever default categories you want.
	local tfaOptionPerf = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_ballistics"
	}

	tfaOptionPerf.Options["#preset.default"] = {
		["sv_tfa_ballistics_enabled"] = nil,
		["sv_tfa_ballistics_mindist"] = -1,
		["sv_tfa_ballistics_bullet_life"] = 10,
		["sv_tfa_ballistics_bullet_damping_air"] = 1,
		["sv_tfa_ballistics_bullet_damping_water"] = 3,
		["sv_tfa_ballistics_bullet_velocity"] = 1,
		["sv_tfa_ballistics_bullet_substeps"] = 3,
		["sv_tfa_ballistics_custom_gravity"] = 0,
		["sv_tfa_ballistics_custom_gravity_value"] = 0,
		["cl_tfa_ballistics_mp"] = 1,
		["cl_tfa_ballistics_fx_bullet"] = 1,
		["cl_tfa_ballistics_fx_tracers_style"] = 1,
		["cl_tfa_ballistics_fx_tracers_mp"] = 1,
		["cl_tfa_ballistics_fx_tracers_adv"] = 1
	}

	tfaOptionPerf.CVars = table.GetKeys(tfaOptionPerf.Options["#preset.default"])
	panel:AddControl("ComboBox", tfaOptionPerf)

	panel:Help("#tfa.settings.server")
	TFA.CheckBoxNet(panel, "#tfa.ballisticsettings.enabled", "sv_tfa_ballistics_enabled")
	TFA.NumSliderNet(panel, "#tfa.ballisticsettings.mindist", "sv_tfa_ballistics_mindist", -1, 100, 0)
	TFA.NumSliderNet(panel, "#tfa.ballisticsettings.bullet.life", "sv_tfa_ballistics_bullet_life", 0, 20, 2)
	TFA.NumSliderNet(panel, "#tfa.ballisticsettings.bullet.damping.air", "sv_tfa_ballistics_bullet_damping_air", 0, 10, 2)
	TFA.NumSliderNet(panel, "#tfa.ballisticsettings.bullet.damping.water", "sv_tfa_ballistics_bullet_damping_water", 0, 10, 2)
	TFA.NumSliderNet(panel, "#tfa.ballisticsettings.bullet.velocity", "sv_tfa_ballistics_bullet_velocity", 0, 2, 3)
	TFA.NumSliderNet(panel, "#tfa.ballisticsettings.substeps", "sv_tfa_ballistics_substeps", 1, 5, 0)
	TFA.CheckBoxNet(panel, "#tfa.ballisticsettings.customgravity", "sv_tfa_ballistics_custom_gravity")
	TFA.CheckBoxNet(panel, "#tfa.ballisticsettings.customgravityvalue", "sv_tfa_ballistics_custom_gravity_value")

	panel:Help("#tfa.settings.client")

	panel:CheckBox("#tfa.ballisticsettings.fx.bullet", "cl_tfa_ballistics_fx_bullet")
	panel:CheckBox("#tfa.ballisticsettings.fx.hq", "cl_tfa_ballistics_fx_tracers_adv")
	panel:CheckBox("#tfa.ballisticsettings.fx.mp", "cl_tfa_ballistics_mp")
	panel:CheckBox("#tfa.ballisticsettings.fx.mptracer", "cl_tfa_ballistics_fx_tracers_mp")

	local tfaOptionTracerStyle = {
		Options = {},
		CVars = {"cl_tfa_ballistics_fx_tracers_style"},
		Label = "#tfa.ballisticsettings.tracer",
		MenuButton = "1",
		Folder = "TFASSBallTracerStyle"
	}

	tfaOptionTracerStyle.Options["#tfa.ballisticsettings.tracer.di"] = {
		["cl_tfa_ballistics_fx_tracers_style"] = 0
	}

	tfaOptionTracerStyle.Options["#tfa.ballisticsettings.tracer.sm"] = {
		["cl_tfa_ballistics_fx_tracers_style"] = 1
	}

	tfaOptionTracerStyle.Options["#tfa.ballisticsettings.tracer.re"] = {
		["cl_tfa_ballistics_fx_tracers_style"] = 2
	}

	panel:AddControl("ComboBox", tfaOptionTracerStyle)
end

local function tfaOptionAbout(panel)
	panel:Help("TFA Base [Reduxed]")
	panel:Help(language.GetPhrase("tfa.about.version"):format(TFA_BASE_VERSION))
	panel:Help(language.GetPhrase("tfa.about.author"):format("TheForgottenArchitect"))
	panel:Help(language.GetPhrase("tfa.about.maintain"):format("YuRaNnNzZZ", "DBotThePony"))

	panel:Help("")

	panel:Help("#tfa.about.changelog.label")
	local btnGitLabChangelog = panel:Button("#tfa.about.changelog.btn.gitlab")
	btnGitLabChangelog.DoClick = function()
		gui.OpenURL("https://gitlab.com/tfa-devs/tfa-base/-/blob/master/CHANGELOG.md")
	end
	local btnSteamChangeNotes = panel:Button("#tfa.about.changelog.btn.steam")
	btnSteamChangeNotes.DoClick = function()
		gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/changelog/415143062")
	end

	panel:Help("")

	panel:Help("#tfa.about.help.label")
	local btnGitLabIssues = panel:Button("#tfa.about.help.btn.gitlab")
	btnGitLabIssues.DoClick = function()
		gui.OpenURL("https://gitlab.com/tfa-devs/tfa-base/-/issues")
	end
	local btnDiscordHelp = panel:Button("#tfa.about.help.btn.discord")
	btnDiscordHelp.DoClick = function()
		gui.OpenURL("https://discord.gg/U38pBcP")
	end
	local btnSteamGroupBugReport = panel:Button("#tfa.about.help.btn.steam")
	btnSteamGroupBugReport.DoClick = function()
		gui.OpenURL("https://steamcommunity.com/groups/tfa-mods/discussions/2/")
	end

	panel:Help("")

	panel:Help("#tfa.about.chat.label")
	local btnChatSteam = panel:Button("#tfa.about.chat.btn.steam")
	btnChatSteam.DoClick = function()
		gui.OpenURL("https://steamcommunity.com/groups/tfa-mods")
	end
	local btnChatDiscord = panel:Button("#tfa.about.chat.btn.discord")
	btnChatDiscord.DoClick = function()
		gui.OpenURL("https://discord.gg/Gxqx67n")
	end

	panel:Help("")

	panel:Help("#tfa.about.contrib.label")
	local btnGitLab = panel:Button("#tfa.about.contrib.btn.gitlab")
	btnGitLab.DoClick = function()
		gui.OpenURL("https://gitlab.com/tfa-devs/tfa-base")
	end
end

local function tfaOptionInspect(panel)
	local presetTable = {
		Options = {},
		CVars = {},
		MenuButton = "1",
		Folder = "tfa_base_inspect"
	}

	presetTable.Options["#preset.default"] = {
		cl_tfa_inspection_bokeh = "0",
		cl_tfa_inspection_bokeh_radius = "0.1",
		cl_tfa_inspect_hide = "0",
		cl_tfa_inspect_hide_hud = "0",
		cl_tfa_inspect_hide_in_screenshots = "0",
		cl_tfa_inspect_newbars = "0",
		cl_tfa_inspect_spreadinmoa = "0"
	}

	presetTable.CVars = table.GetKeys(presetTable.Options["#preset.default"])
	panel:AddControl("ComboBox", presetTable)

	panel:CheckBox("#tfa.inspectsettings.inspectdof.enabled", "cl_tfa_inspection_bokeh")
	panel:NumSlider("#tfa.inspectsettings.inspectdof.radius", "cl_tfa_inspection_bokeh_radius", 0.01, 1, 3)

	panel:CheckBox("#tfa.inspectsettings.hide", "cl_tfa_inspect_hide")
	if DLib then
		panel:CheckBox("#tfa.inspectsettings.hidehud", "cl_tfa_inspect_hide_hud")
	end
	panel:CheckBox("#tfa.inspectsettings.hideinscreenshots", "cl_tfa_inspect_hide_in_screenshots")
	panel:CheckBox("#tfa.inspectsettings.newbars", "cl_tfa_inspect_newbars")
	panel:CheckBox("#tfa.inspectsettings.spreadinmoa", "cl_tfa_inspect_spreadinmoa")
end

local function tfaAddOption()
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "tfaOptionVM", "#tfa.smsettings.viewmodel", "", "", tfaOptionVM)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "tfaOptionSights", "#tfa.smsettings.sights", "", "", tfaOptionSights)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "tfaOptionPerformance", "#tfa.smsettings.perf", "", "", tfaOptionPerformance)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseCrosshair", "#tfa.smsettings.hud", "", "", tfaOptionHUD)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseDeveloper", "#tfa.smsettings.dev", "", "", tfaOptionDeveloper)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseColor", "#tfa.smsettings.color", "", "", tfaOptionColors)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseBallistics", "#tfa.smsettings.ballistics", "", "", tfaOptionBallistics)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseServer", "#tfa.smsettings.server", "", "", tfaOptionServer)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseAbout", "#tfa.smsettings.about", "", "", tfaOptionAbout)
	spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseInspect", "#tfa.smsettings.inspect", "", "", tfaOptionInspect)
end

hook.Add("PopulateToolMenu", "tfaAddOption", tfaAddOption)
