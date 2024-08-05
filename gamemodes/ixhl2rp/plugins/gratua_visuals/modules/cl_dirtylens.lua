--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local dl_blurrange = CreateClientConVar("pp_dlens_blurrange", "10", true, false)
local dl_blurpasses = CreateClientConVar("pp_dlens_blurpasses", "30", true, false)
local dl_multiply = CreateClientConVar("pp_dlens_multiply", "1", true, false)
local dl_darken = CreateClientConVar("pp_dlens_darken", "0.30", true, false)
local dl_texture = CreateClientConVar("pp_dlens_texture", "dlenstexture/dlensdefault", true, false)
local dl_sunenable = CreateClientConVar("pp_dlens_sun", "1", true, false)
local dl_sunmultiply = CreateClientConVar("pp_dlens_sunmultiply", "2", true, false)
local dl_suninterpolation = CreateClientConVar("pp_dlens_suninterpolation", "6", true, false)

local mat_Downsample = Material("pp/downsample")
local mat_Bloom = Material("dlenstexture/dlensmat")
local OldRT = render.GetRenderTarget()	
local tex_Bloom0 = render.GetBloomTex0()
local w, h = ScrW(), ScrH()
local targetMultiply = 1
local multiply = 1

hook.Add("RenderScreenspaceEffects", "DrawDirtLens", function()
	if not ix.option.Get("enableDirtyLens", false) then return end

	if not render.SupportsPixelShaders_2_0() then return end
	
	local blur = dl_blurrange:GetFloat()
	local passes = dl_blurpasses:GetFloat()
	local darken = dl_darken:GetFloat()
	local lens_texture = dl_texture:GetString()
	local SunMultiply = dl_sunmultiply:GetFloat()
	local SunInterpolation = dl_suninterpolation:GetInt()

	if dl_sunenable:GetBool() then
		local sun = util.GetSunInfo()
		if sun then
			if ( sun.obstruction ~= 0 ) then
				targetMultiply = dl_multiply:GetFloat() + SunMultiply
			else
				targetMultiply = dl_multiply:GetFloat()
			end	
		else
			targetMultiply = dl_multiply:GetFloat()
		end
		multiply = Lerp(FrameTime() * SunInterpolation, multiply, targetMultiply)
	else
		multiply = dl_multiply:GetFloat()
	end
	
	mat_Downsample:SetFloat("$multiply", multiply)	
	mat_Downsample:SetFloat("$darken", darken)
	mat_Downsample:SetTexture("$fbtexture", render.GetScreenEffectTexture())

	render.SetViewPort(0, 0, w, h)
	render.SetRenderTarget(tex_Bloom0)
		render.SetBlend(1)
		render.SetMaterial(mat_Downsample)
		render.DrawScreenQuad()
		render.BlurRenderTarget(tex_Bloom0, blur, blur, passes)
		render.ClearDepth()
	render.SetRenderTarget(OldRT)

	mat_Bloom:SetFloat("$levelr", 1)
	mat_Bloom:SetFloat("$levelg", 1)
	mat_Bloom:SetFloat("$levelb", 1)
	mat_Bloom:SetFloat("$colormul", 16)

	mat_Bloom:SetTexture("$basetexture", lens_texture)
	mat_Bloom:SetTexture("$dudvmap", lens_texture)
	mat_Bloom:SetTexture("$normalmap", lens_texture)
	mat_Bloom:SetTexture("$refracttinttexture", tex_Bloom0)

	render.SetMaterial(mat_Bloom)
	render.DrawScreenQuad()
end)