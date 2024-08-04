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

local FT = FrameTime

local tfablurintensity = 0

local cv_3dscopes = GetConVar("cl_tfa_3dscope")

local cv_mode = CreateClientConVar("cl_tfa_fx_rtscopeblur_mode", "1", true, false)
local funcs = {}

local cv_blur_passes = CreateClientConVar("cl_tfa_fx_rtscopeblur_passes", "3", true, false)
local cv_blur_intensity = CreateClientConVar("cl_tfa_fx_rtscopeblur_intensity", "4", true, false)
local blurTex = Material("pp/blurscreen")
funcs[1] = function()
	surface.SetDrawColor(color_white)
	render.SetMaterial(blurTex)
	local passes = cv_blur_passes:GetInt()

	for _ = 1, passes do
		render.UpdateScreenEffectTexture()

		blurTex:SetFloat("$blur", tfablurintensity * cv_blur_intensity:GetFloat() / math.sqrt(passes) )
		blurTex:Recompute()

		render.DrawScreenQuad()
	end
end

local blur_mat = Material("pp/bokehblur")
funcs[2] = function()
	render.UpdateScreenEffectTexture()
	render.UpdateFullScreenDepthTexture()

	blur_mat:SetTexture("$BASETEXTURE", render.GetScreenEffectTexture())
	blur_mat:SetTexture("$DEPTHTEXTURE", render.GetResolvedFullFrameDepth())

	blur_mat:SetFloat("$size", tfablurintensity * cv_blur_intensity:GetFloat() * 1.5 )
	blur_mat:SetFloat("$focus", 0)
	blur_mat:SetFloat("$focusradius", 0.25)

	render.SetMaterial(blur_mat)
	render.DrawScreenQuad()
end

hook.Add("PostDrawTranslucentRenderables", "tfa_draw_rt_blur", function()
	if TFA.DrawingRenderTarget then return end

	if not cv_3dscopes:GetBool() then return end

	local mode = cv_mode:GetInt()
	if not isfunction(funcs[mode]) then return end

	local ply = LocalPlayer()
	if not IsValid(ply) or ply:ShouldDrawLocalPlayer() then return end

	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) or not wep.IsTFAWeapon or not wep.GetStat then return end
	if not wep:GetStatL("RTBGBlur") then return end
	if not wep:GetStatL("RTDrawEnabled") and not wep:GetStatL("RTMaterialOverride") and not wep.RTCode then return end

	if wep.GLDeployed and wep:GLDeployed() then
		tfablurintensity = Lerp(FT() * 12.5, tfablurintensity, 0)
	else
		local progress = math.Clamp(wep.CLIronSightsProgress or 0, 0, 1)
		tfablurintensity = Lerp(FT() * 25, tfablurintensity, progress)
	end

	if tfablurintensity > 0.05 then
		funcs[mode]()
	end
end)

hook.Add("NeedsDepthPass", "aaaaaaaaaaaaaaaaaaNeedsDepthPass_TJA_IronSight", function()
	if tfablurintensity > 0.05 and cv_mode:GetInt() == 2 then
		if not cv_3dscopes:GetBool() then return end

		DOFModeHack(true)

		return true
	end
end)