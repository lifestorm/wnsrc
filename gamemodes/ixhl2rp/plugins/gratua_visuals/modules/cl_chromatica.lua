--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local addonName = "Simple Chromatic Aberration Filter"

-- https://wiki.facepunch.com/gmod/Global.CreateClientConVar
local pp_scaf_intensity = CreateClientConVar( "pp_scaf_intensity", "3", true, false, "How intense the chromatic aberration will be.", 0, 100 )

-- https://i.imgur.com/8B3KakB.png
local pp_scaf_redx = CreateClientConVar( "pp_scaf_redx", "8", true, false, "Mixing of chromatic aberrations in the red channel along the X-axis.", 0, 128 )
local pp_scaf_redy = CreateClientConVar( "pp_scaf_redy", "4", true, false, "Mixing of chromatic aberrations in the red channel along the Y-axis.", 0, 128 )

local pp_scaf_greenx = CreateClientConVar( "pp_scaf_greenx", "4", true, false, "Mixing of chromatic aberrations in the green channel along the X-axis.", 0, 128 )
local pp_scaf_greeny = CreateClientConVar( "pp_scaf_greeny", "2", true, false, "Mixing of chromatic aberrations in the green channel along the Y-axis.", 0, 128 )

local pp_scaf_bluex = CreateClientConVar( "pp_scaf_bluex", "0", true, false, "Mixing of chromatic aberrations in the blue channel along the X-axis.", 0, 128 )
local pp_scaf_bluey = CreateClientConVar( "pp_scaf_bluey", "0", true, false, "Mixing of chromatic aberrations in the blue channel along the Y-axis.", 0, 128 )

local redX, greenX, blueX = 0, 0, 0
local redY, greenY, blueY = 0, 0, 0
local floor = math.floor
local intensity = 0

hook.Add( "Think", addonName, function()
	intensity = pp_scaf_intensity:GetFloat()
	redX, greenX, blueX = floor( pp_scaf_redx:GetInt() * intensity ), floor( pp_scaf_greenx:GetInt() * intensity ), floor( pp_scaf_bluex:GetInt() * intensity )
	redY, greenY, blueY = floor( pp_scaf_redy:GetInt() * intensity ), floor( pp_scaf_greeny:GetInt() * intensity ), floor( pp_scaf_bluey:GetInt() * intensity )
end )

-- https://wiki.facepunch.com/gmod/GM:OnScreenSizeChanged
local width, height = ScrW(), ScrH()
hook.Add( "OnScreenSizeChanged", addonName, function()
	width, height = ScrW(), ScrH()
end )

-- https://gitspartv.github.io/LuaJIT-Benchmarks/#test1
local SetMaterial, DrawScreenQuad, DrawScreenQuadEx, UpdateScreenEffectTexture = render.SetMaterial, render.DrawScreenQuad, render.DrawScreenQuadEx, render.UpdateScreenEffectTexture
local screenEffectTexture, black = render.GetScreenEffectTexture( 0 ), Material( "vgui/black" )

local red = Material( "color/red" )
red:SetTexture( "$basetexture", screenEffectTexture )

local green = Material( "color/green" )
green:SetTexture( "$basetexture", screenEffectTexture )

local blue = Material( "color/blue" )
blue:SetTexture( "$basetexture", screenEffectTexture )

hook.Add( "RenderScreenspaceEffects", addonName, function()
	if not ix.option.Get("enableChromaticAberration", false) then return end

	UpdateScreenEffectTexture()

	SetMaterial( black )
	DrawScreenQuad()

	SetMaterial( red )
	DrawScreenQuadEx( -redX / 2, -redY / 2, width + redX, height + redY )

	SetMaterial( green )
	DrawScreenQuadEx( -greenX / 2, -greenY / 2, width + greenX, height + greenY )

	SetMaterial( blue )
	DrawScreenQuadEx( -blueX / 2, -blueY / 2, width + blueX, height + blueY )
end )