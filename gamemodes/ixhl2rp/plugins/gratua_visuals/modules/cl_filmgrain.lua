--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local fg_alpha = CreateClientConVar("pp_filmgrain_alpha", "4", true, false)
local fg_addalpha = CreateClientConVar("pp_filmgrain_addalpha", "3", true, false)

local NoiseTexture = Material("filmgrain/noise")
local NoiseTexture2 = Material("filmgrain/noiseadd")
--[[local NoiseTexture = Material(fg_texture:GetString())
cvars.AddChangeCallback("pp_filmgrain_texture", function (_, __, ___)
    NoiseTexture:SetTexture("$basetexture", fg_texture:GetString())
end)]]

hook.Add("RenderScreenspaceEffects", "FilmGrain", function()
    if not ix.option.Get("enableFilmGrain", false) then return end

    surface.SetMaterial(NoiseTexture)
    surface.SetDrawColor(255, 255, 255, fg_alpha:GetInt())
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

    surface.SetMaterial(NoiseTexture2)
    surface.SetDrawColor(255, 255, 255, fg_addalpha:GetInt()*10)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
end)