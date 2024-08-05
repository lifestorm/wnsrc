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

if GetConVar("cl_tfa_inspection_bokeh") == nil then
	CreateClientConVar("cl_tfa_inspection_bokeh", 0, true, false, "Enable inspection bokeh DOF")
end

if GetConVar("cl_tfa_inspection_bokeh_radius") == nil then
	CreateClientConVar("cl_tfa_inspection_bokeh_radius", 0.1, true, false, "Inspection bokeh DOF radius", 0.01, 1)
end

if GetConVar("cl_tfa_inspect_hide_in_screenshots") == nil then
	CreateClientConVar("cl_tfa_inspect_hide_in_screenshots", 0, true, false, "Hide inspection panel in screenshots")
end

if GetConVar("cl_tfa_inspect_hide") == nil then
	CreateClientConVar("cl_tfa_inspect_hide", 0, true, false, "Hide inspection panel")
end

if GetConVar("cl_tfa_inspect_hide_hud") == nil then
	CreateClientConVar("cl_tfa_inspect_hide_hud", 0, true, false, "Hide HUD when inspecting weapon (DLib required)")
end

if GetConVar("cl_tfa_inspect_newbars") == nil then
	CreateClientConVar("cl_tfa_inspect_newbars", 0, true, false, "Use new stat bars in inspection screen")
end

if GetConVar("cl_tfa_inspect_spreadinmoa") == nil then
	CreateClientConVar("cl_tfa_inspect_spreadinmoa", 0, true, false, "Show accuracy in MOA instead of degrees on inspection screen")
end

if GetConVar("cl_tfa_viewbob_intensity") == nil then
	CreateClientConVar("cl_tfa_viewbob_intensity", 1, true, false, "View bob intensity multiplier")
end

if GetConVar("cl_tfa_gunbob_intensity") == nil then
	CreateClientConVar("cl_tfa_gunbob_intensity", 1, true, false, "Gun bob intensity multiplier")
end

if GetConVar("cl_tfa_gunbob_custom") == nil then
	CreateClientConVar("cl_tfa_gunbob_custom", 1, true, false, "Use custom gun bob")
end

if GetConVar("cl_tfa_3dscope_quality") == nil then
	CreateClientConVar("cl_tfa_3dscope_quality", -1, true, true, "3D scope quality (0 to 3)")
end

if GetConVar("cl_tfa_3dscope") == nil then
	CreateClientConVar("cl_tfa_3dscope", 1, true, true, "Enable 3D scopes?")
else
	cvars.RemoveChangeCallback( "cl_tfa_3dscope", "3DScopeEnabledCB" )
end

cvars.AddChangeCallback("cl_tfa_3dscope",function(cv,old,new)
	local lply = LocalPlayer()
	if lply:IsValid() and IsValid(lply:GetActiveWeapon()) then
		local wep = lply:GetActiveWeapon()
		if wep.UpdateScopeType then
			wep:UpdateScopeType( true )
		end
	end
end,"3DScopeEnabledCB")

if GetConVar("cl_tfa_scope_sensitivity_3d") == nil then
	CreateClientConVar("cl_tfa_scope_sensitivity_3d", 2, true, true) --0 = no sensitivity mod, 1 = scaled to 2D sensitivity, 2 = compensated, 3 = RT FOV compensated
else
	cvars.RemoveChangeCallback( "cl_tfa_scope_sensitivity_3d", "3DScopeModeCB" )
end

cvars.AddChangeCallback("cl_tfa_scope_sensitivity_3d",function(cv,old,new)
	local lply = LocalPlayer()
	if lply:IsValid() and IsValid(lply:GetActiveWeapon()) then
		local wep = lply:GetActiveWeapon()
		if wep.UpdateScopeType then
			wep:UpdateScopeType( true )
		end
	end
end,"3DScopeModeCB")

if GetConVar("cl_tfa_3dscope_overlay") == nil then
	CreateClientConVar("cl_tfa_3dscope_overlay", 0, true, true, "Enable 3D scope shadows?")
end

if GetConVar("cl_tfa_scope_sensitivity_autoscale") == nil then
	CreateClientConVar("cl_tfa_scope_sensitivity_autoscale", 100, true, true, "Compensate sensitivity for FOV?")
end

if GetConVar("cl_tfa_scope_sensitivity") == nil then
	CreateClientConVar("cl_tfa_scope_sensitivity", 100, true, true)
end

if GetConVar("cl_tfa_ironsights_toggle") == nil then
	CreateClientConVar("cl_tfa_ironsights_toggle", 1, true, true, "Toggle ironsights?")
end

if GetConVar("cl_tfa_ironsights_resight") == nil then
	CreateClientConVar("cl_tfa_ironsights_resight", 1, true, true, "Keep ironsights after reload or sprint?")
end

if GetConVar("cl_tfa_ironsights_responsive") == nil then
	CreateClientConVar("cl_tfa_ironsights_responsive", 0, true, true, "Allow both toggle and held down iron sights")
end

if GetConVar("cl_tfa_ironsights_responsive_timer") == nil then
	CreateClientConVar("cl_tfa_ironsights_responsive_timer", 0.175, true, true, "Time in seconds to determine responsivness time")
end

if GetConVar("cl_tfa_laser_trails") == nil then
	CreateClientConVar("cl_tfa_laser_trails", 1, true, true, "Enable laser dot trails?")
end

--Crosshair Params
if GetConVar("cl_tfa_hud_crosshair_length") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_length", 1, true, false, "Crosshair length")
end

if GetConVar("cl_tfa_hud_crosshair_length_use_pixels") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_length_use_pixels", 0, true, false, "Should crosshair length use pixels?")
end

if GetConVar("cl_tfa_hud_crosshair_width") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_width", 1, true, false, "Crosshair width")
end

if GetConVar("cl_tfa_hud_crosshair_enable_custom") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_enable_custom", 1, true, false, "Enable custom crosshair?")
end

if GetConVar("cl_tfa_hud_crosshair_gap_scale") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_gap_scale", 1, true, false, "Crosshair gap scale")
end

if GetConVar("cl_tfa_hud_crosshair_dot") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_dot", 0, true, false, "Enable crosshair dot?")
end

--Crosshair Color
if GetConVar("cl_tfa_hud_crosshair_color_r") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_color_r", 225, true, false)
end

if GetConVar("cl_tfa_hud_crosshair_color_g") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_color_g", 225, true, false)
end

if GetConVar("cl_tfa_hud_crosshair_color_b") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_color_b", 225, true, false)
end

if GetConVar("cl_tfa_hud_crosshair_color_a") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_color_a", 200, true, false)
end

if GetConVar("cl_tfa_hud_crosshair_color_team") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_color_team", 1, true, false, "Should crosshair use team color of entity being aimed at?")
end

--Crosshair Outline
if GetConVar("cl_tfa_hud_crosshair_outline_color_r") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_outline_color_r", 5, true, false)
end

if GetConVar("cl_tfa_hud_crosshair_outline_color_g") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_outline_color_g", 5, true, false)
end

if GetConVar("cl_tfa_hud_crosshair_outline_color_b") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_outline_color_b", 5, true, false)
end

if GetConVar("cl_tfa_hud_crosshair_outline_color_a") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_outline_color_a", 200, true, false)
end

if GetConVar("cl_tfa_hud_crosshair_outline_width") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_outline_width", 1, true, false, "Crosshair outline width")
end

if GetConVar("cl_tfa_hud_crosshair_outline_enabled") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_outline_enabled", 1, true, false, "Enable crosshair outline?")
end

if GetConVar("cl_tfa_hud_crosshair_triangular") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_triangular", 0, true, false, "Enable triangular Crysis-like crosshair?")
end

if GetConVar("cl_tfa_hud_crosshair_pump") == nil then
	CreateClientConVar("cl_tfa_hud_crosshair_pump", 0, true, false, "Enable pump feedback on crosshair?")
end

if GetConVar("cl_tfa_hud_hitmarker_enabled") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_enabled", 1, true, false, "Enable hit marker?")
end

if GetConVar("cl_tfa_hud_hitmarker_fadetime") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_fadetime", 0.3, true, false, "Hit marker fade time (in seconds)")
end

if GetConVar("cl_tfa_hud_hitmarker_solidtime") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_solidtime", 0.1, true, false)
end

if GetConVar("cl_tfa_hud_hitmarker_scale") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_scale", 1, true, false, "Hit marker scale")
end

if GetConVar("cl_tfa_hud_hitmarker_color_r") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_color_r", 225, true, false)
end

if GetConVar("cl_tfa_hud_hitmarker_color_g") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_color_g", 225, true, false)
end

if GetConVar("cl_tfa_hud_hitmarker_color_b") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_color_b", 225, true, false)
end

if GetConVar("cl_tfa_hud_hitmarker_color_a") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_color_a", 200, true, false)
end

if GetConVar("cl_tfa_hud_hitmarker_3d_all") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_3d_all", 0, true, true)
end

if GetConVar("cl_tfa_hud_hitmarker_3d_shotguns") == nil then
	CreateClientConVar("cl_tfa_hud_hitmarker_3d_shotguns", 1, true, true)
end

--Other stuff
if GetConVar("cl_tfa_hud_ammodata_fadein") == nil then
	CreateClientConVar("cl_tfa_hud_ammodata_fadein", 0.2, true, false)
end

if GetConVar("cl_tfa_hud_hangtime") == nil then
	CreateClientConVar("cl_tfa_hud_hangtime", 1, true, true)
end

if GetConVar("cl_tfa_hud_enabled") == nil then
	CreateClientConVar("cl_tfa_hud_enabled", 1, true, false, "Enable 3D2D hud?")
end

if GetConVar("cl_tfa_hud_scale") == nil then
	CreateClientConVar("cl_tfa_hud_scale", 1, true, false, "Size multiplier of HUD elements", .25, 4)
end

if GetConVar("cl_tfa_fx_gasblur") == nil then
	CreateClientConVar("cl_tfa_fx_gasblur", 0, true, true, "Enable muzzle gas blur?")
end

if GetConVar("cl_tfa_fx_muzzlesmoke") == nil then
	CreateClientConVar("cl_tfa_fx_muzzlesmoke", 1, true, true, "Enable muzzle smoke trail?")
end

if GetConVar("cl_tfa_fx_muzzlesmoke_limited") == nil then
	CreateClientConVar("cl_tfa_fx_muzzlesmoke_limited", 1, true, true, "Limit muzzle smoke trails?")
end

if GetConVar("cl_tfa_fx_muzzleflashsmoke") == nil then
	CreateClientConVar("cl_tfa_fx_muzzleflashsmoke", 1, true, true, "Enable muzzleflash smoke?")
end

if GetConVar("cl_tfa_legacy_shells") == nil then
	CreateClientConVar("cl_tfa_legacy_shells", 0, true, true, "Use legacy shells?")
end

if GetConVar("cl_tfa_fx_ejectionsmoke") == nil then
	CreateClientConVar("cl_tfa_fx_ejectionsmoke", 1, true, true, "Enable shell ejection smoke?")
end

if GetConVar("cl_tfa_fx_ejectionlife") == nil then
	CreateClientConVar("cl_tfa_fx_ejectionlife", 15, true, true, "How long shells exist in the world")
end

if GetConVar("cl_tfa_fx_impact_enabled") == nil then
	CreateClientConVar("cl_tfa_fx_impact_enabled", 1, true, true, "Enable custom bullet impact effects?")
end

if GetConVar("cl_tfa_fx_impact_ricochet_enabled") == nil then
	CreateClientConVar("cl_tfa_fx_impact_ricochet_enabled", 1, true, true, "Enable bullet ricochet effect?")
end

if GetConVar("cl_tfa_fx_impact_ricochet_sparks") == nil then
	CreateClientConVar("cl_tfa_fx_impact_ricochet_sparks", 6, true, true, "Enable bullet ricochet sparks?")
end

if GetConVar("cl_tfa_fx_impact_ricochet_sparklife") == nil then
	CreateClientConVar("cl_tfa_fx_impact_ricochet_sparklife", 2, true, true)
end

if GetConVar("cl_tfa_fx_ads_dof") == nil then
	CreateClientConVar("cl_tfa_fx_ads_dof", 0, true, true, "Enable iron sights DoF (Depth of Field)")
end

if GetConVar("cl_tfa_fx_ads_dof_hd") == nil then
	CreateClientConVar("cl_tfa_fx_ads_dof_hd", 0, true, true, "Enable better quality for DoF")
end

--viewbob

if GetConVar("cl_tfa_viewbob_animated") == nil then
	CreateClientConVar("cl_tfa_viewbob_animated", 1, true, false, "Use animated viewbob?")
end

--Viewmodel Mods
if GetConVar("cl_tfa_viewmodel_offset_x") == nil then
	CreateClientConVar("cl_tfa_viewmodel_offset_x", 0, true, false)
end

if GetConVar("cl_tfa_viewmodel_offset_y") == nil then
	CreateClientConVar("cl_tfa_viewmodel_offset_y", 0, true, false)
end

if GetConVar("cl_tfa_viewmodel_offset_z") == nil then
	CreateClientConVar("cl_tfa_viewmodel_offset_z", 0, true, false)
end

if GetConVar("cl_tfa_viewmodel_offset_fov") == nil then
	CreateClientConVar("cl_tfa_viewmodel_offset_fov", 0, true, false)
end

if GetConVar("cl_tfa_viewmodel_multiplier_fov") == nil then
	CreateClientConVar("cl_tfa_viewmodel_multiplier_fov", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_flip") == nil then
	CreateClientConVar("cl_tfa_viewmodel_flip", 0, true, false)
end

if GetConVar("cl_tfa_viewmodel_centered") == nil then
	CreateClientConVar("cl_tfa_viewmodel_centered", 0, true, false)
end

if GetConVar("cl_tfa_viewmodel_nearwall") == nil then
	CreateClientConVar("cl_tfa_viewmodel_nearwall", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_enabled") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_enabled", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_pitch") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_pitch", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_pitch_is") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_pitch_is", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_vertical") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_vertical", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_vertical_is") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_vertical_is", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_max_vertical") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_max_vertical", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_max_vertical_is") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_max_vertical_is", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_yaw") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_yaw", 1, true, false)
end

if GetConVar("cl_tfa_viewmodel_vp_yaw_is") == nil then
	CreateClientConVar("cl_tfa_viewmodel_vp_yaw_is", 1, true, false)
end

if GetConVar("cl_tfa_debug_crosshair") == nil then
	CreateClientConVar("cl_tfa_debug_crosshair", 0, false, false, "Debug crosshair (Admin only)")
end

if GetConVar("cl_tfa_debug_animations") == nil then
	CreateClientConVar("cl_tfa_debug_animations", 0, false, false, "Debug animations (Admin only)")
end

if GetConVar("cl_tfa_debug_rt") == nil then
	CreateClientConVar("cl_tfa_debug_rt", 0, false, false, "Debug RT scopes (Admin only)")
end

if GetConVar("cl_tfa_debug_cache") == nil then
	CreateClientConVar("cl_tfa_debug_cache", 0, false, false, "Disable stat caching (may cause heavy performance impact!)")
end

local function UpdateColorCVars()
	RunConsoleCommand("sv_tfa_apply_player_colors")
end

--Reticule Color
if GetConVar("cl_tfa_reticule_color_r") == nil then
	CreateClientConVar("cl_tfa_reticule_color_r", 255, true, true)
	cvars.AddChangeCallback("cl_tfa_reticule_color_r", UpdateColorCVars, "TFANetworkPlayerColors")
end

if GetConVar("cl_tfa_reticule_color_g") == nil then
	CreateClientConVar("cl_tfa_reticule_color_g", 100, true, true)
	cvars.AddChangeCallback("cl_tfa_reticule_color_g", UpdateColorCVars, "TFANetworkPlayerColors")
end

if GetConVar("cl_tfa_reticule_color_b") == nil then
	CreateClientConVar("cl_tfa_reticule_color_b", 0, true, true)
	cvars.AddChangeCallback("cl_tfa_reticule_color_b", UpdateColorCVars, "TFANetworkPlayerColors")
end

--Laser Color
if GetConVar("cl_tfa_laser_color_r") == nil then
	CreateClientConVar("cl_tfa_laser_color_r", 255, true, true)
	cvars.AddChangeCallback("cl_tfa_laser_color_r", UpdateColorCVars, "TFANetworkPlayerColors")
end

if GetConVar("cl_tfa_laser_color_g") == nil then
	CreateClientConVar("cl_tfa_laser_color_g", 0, true, true)
	cvars.AddChangeCallback("cl_tfa_laser_color_g", UpdateColorCVars, "TFANetworkPlayerColors")
end

if GetConVar("cl_tfa_laser_color_b") == nil then
	CreateClientConVar("cl_tfa_laser_color_b", 0, true, true)
	cvars.AddChangeCallback("cl_tfa_laser_color_b", UpdateColorCVars, "TFANetworkPlayerColors")
end
