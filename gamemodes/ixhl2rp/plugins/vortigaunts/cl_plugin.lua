--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

function PLUGIN:RenderESPNames(minDist, maxDist)
    local right = LocalPlayer():GetRight() * 25
    local scrW, scrH = ScrW(), ScrH()
    local marginX, marginY = scrH * .1, scrH * .1

    for _, v in ipairs(self.names) do
        local ply, distance = v[1], math.Clamp(v[2], minDist, maxDist)
        local plyPos = ply:GetPos()
        local character = ply:GetCharacter()

        local min, max = ply:GetModelRenderBounds()
        min = min + plyPos + right
        max = max + plyPos + right

        local barMin = Vector((min.x + max.x) / 2, (min.y + max.y) / 2, min.z):ToScreen()
        local barMax = Vector((min.x + max.x) / 2, (min.y + max.y) / 2, max.z):ToScreen()
        local eyePos = ply:EyePos():ToScreen()
        local rightS = math.min(math.max(barMin.x, barMax.x), eyePos.x + 150)

        local barWidth = math.Remap(distance, minDist, maxDist, 120, 75)
        local barHeight = math.abs(barMax.y - barMin.y)
        local barX, barY = math.Clamp(rightS, marginX, scrW - marginX - barWidth),  math.Clamp(barMin.y - barHeight + 18, marginY, scrH - marginY)

        surface.SetFont("ixGenericFont")
        local width, height = surface.GetTextSize(!character:GetConterminous() and ply:Name() or "Vortigaunt")

        surface.SetDrawColor(0, 0, 0, math.Remap(distance, minDist, maxDist, 175, 50))
        surface.DrawRect(barX - 5, barY - 13 - height / 2, width + 10, height + 2)
        ix.util.DrawText(!character:GetConterminous() and ply:Name() or "Vortigaunt", barX, barY - 13, Color(138, 181, 40, math.Remap(distance, minDist, maxDist, 255, 50)), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, "ixGenericFont", 255)
    end
end