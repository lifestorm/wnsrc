--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local Color = Color
local CreateMaterial = CreateMaterial
local net = net
local os = os
local cam = cam
local hook = hook
local player = player
local team = team
local Vector = Vector
local surface = surface
local table = table
local render = render
local util = util
local ix = ix
local math = math
local ipairs = ipairs

local PLUGIN = PLUGIN

PLUGIN.traceFilter = {nil, nil}

local extraColor = Color(200, 200, 200, 255)
local mat1 = CreateMaterial("GA0249aSFJ3","VertexLitGeneric",{
    ["$basetexture"] = "models/debug/debugwhite",
    ["$model"] = 1,
    ["$translucent"] = 1,
    ["$alpha"] = 1,
    ["$nocull"] = 1,
    ["$ignorez"] = 1
})

net.Receive("ixObserverDisableTP", function(len)
    if (ix.option.Get("thirdpersonEnabled")) then
        net.Start("ixObserverDisableTP")
        net.SendToServer()
    end
    ix.option.Set("thirdpersonEnabled", net.ReadBool())
end)

do
    local npcColor = Color(255, 0, 128)
    local espColor = Color(255,255,255,255)
    local espColors = {
        ["Weapons"] = Color(255,78,69),
        ["Ammunition"] = Color(255,78,69),
        ["Medical"] = Color(138,200,97),
        ["Crafting"] = Color(255,204,0)
    }
    local minAlpha = {
        ["Writing"] = 0,
        ["Workbenches"] = 0,
    }
    local function itemESP(client, entity, x, y, factor, distance)
        local itemTable = entity:GetItemTable()
        if (!itemTable) then return end
        local color = espColors[itemTable.category] or espColor
        local alpha = math.Remap(math.Clamp(distance, 1500, 2000), 1500, 2000, 255, minAlpha[itemTable.category] or 45)
        if (alpha == 0) then return end

        color.a = alpha

        ix.util.DrawText(itemTable.name .. " (#" .. entity:GetNetVar("itemID", "nil ID") .. ")", x, y + math.max(10, 32 * factor), color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)

        local owner = entity:GetNetVar("ownerName")
        if (owner) then
            local time = (entity:GetNetVar("spawnTime") and " - "..math.ceil((os.time() - entity:GetNetVar("spawnTime")) / 60).."m") or ""
            alpha = math.Remap(math.Clamp(distance, 400, 700), 400, 700, 255, 0)
            espColor.a = alpha
            ix.util.DrawText(owner..time, x, y + math.max(10, 32 * factor) + 20, espColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
        end
    end
    ix.observer:RegisterESPType("ix_item", itemESP, "item")

    local function npcESP(client, entity, x, y, factor)
        ix.util.DrawText(entity:GetClass(), x, y - math.max(10, 32 * factor), npcColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, math.max(255 * factor, 80))
    end
    ix.observer:RegisterESPType("ix_npc", npcESP, "npc", "Show NPC ESP", nil, true)

    if (CLIENT) then
        local function containerESP(client, entity, x, y, factor, distance)
            local color = espColor
            local alpha = math.Remap(math.Clamp(distance, 500, 1000), 500, 1000, 255, 30)
            color.a = alpha

            ix.util.DrawText("Container - "..entity:GetDisplayName().." #"..entity:EntIndex(), x, y - math.max(10, 32 * factor), color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
        end
        ix.observer:RegisterESPType("ix_container", containerESP, "container")
    end

    local function staticESP(client, entity, x, y, factor, distance)
        if (distance > 2500) then return end

        local alpha = math.Remap(math.Clamp(distance, 500, 2500), 500, 2500, 255, 45)
        espColor.a = alpha
        if (IsValid(entity) and entity:GetNetVar("Persistent", false)) then
            ix.util.DrawText(entity:GetModel(), x, y - math.max(10, 32 * factor), espColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
        end
    end
    ix.observer:RegisterESPType("prop_physics", staticESP, "static", "Show Static Prop ESP")
end

local function sortFunc(a, b)
    if (a.alpha != b.alpha) then
        return a.alpha > b.alpha
    elseif (a.priority != b.priority) then
        return a.priority < b.priority
    else
        return a.text < b.text
    end
end

function PLUGIN:DrawPlayerESP(client, scrW, scrH)
    local pos = client:EyePos()
    local marginX, marginY = scrW * .1, scrH * .1
    self.traceFilter[1] = client

    local names = {}
    cam.Start3D()
        local targets = hook.Run("GetAdminESPTargets") or player.GetAll()
        for _, v in ipairs(targets) do
            if (v == client or !v:GetCharacter() or client:GetAimVector():Dot((v:GetPos() - pos):GetNormal()) < 0.65) then
                continue
            end

            local bObserver = v:GetMoveType() == MOVETYPE_NOCLIP and !v:InVehicle()
            local teamColor = bObserver and Color(255, 85, 20, 255) or team.GetColor(v:Team())
            local vEyePos = v:EyePos()
            local distance = pos:Distance(vEyePos)

            if ix.option.Get("observerPlayerHighlight") then 
                self:RenderAdminESP(client, v, teamColor, pos, vEyePos, distance)
            end 
            
            names[#names + 1] = {v, teamColor, distance}
        end
    cam.End3D()

    local right = client:GetRight() * 25
    for _, info in ipairs(names) do
        local ply, teamColor, distance = info[1], info[2], info[3]
        local plyPos = ply:GetPos()

        local min, max = ply:GetModelRenderBounds()
        min = min + plyPos + right
        max = max + plyPos + right

        local barMin = Vector((min.x + max.x) / 2, (min.y + max.y) / 2, min.z):ToScreen()
        local barMax = Vector((min.x + max.x) / 2, (min.y + max.y) / 2, max.z):ToScreen()
        local eyePos = ply:EyePos():ToScreen()
        local rightS = math.min(math.max(barMin.x, barMax.x), eyePos.x + 150)

        local barWidth = math.Remap(math.Clamp(distance, 200, 2000), 500, 2000, 120, 75)
        local barHeight = math.abs(barMax.y - barMin.y)
        local barX, barY = math.Clamp(rightS, marginX, scrW - marginX - barWidth),  math.Clamp(barMin.y - barHeight + 18, marginY, scrH - marginY)

        local alphaFar = math.Remap(math.Clamp(distance, 1500, 2000), 1500, 2000, 255, 0)
        local alphaMid = math.Remap(math.Clamp(distance, 400, 700), 400, 700, 255, 0)
        local alphaClose = math.Remap(math.Clamp(distance, 200, 500), 200, 500, 255, 0)

        local bArmor = ply:Armor() > 0
        surface.SetDrawColor(40, 40, 40, 200 * alphaFar / 255)
        surface.DrawRect(barX - 1, barY - 1, barWidth + 2, 5)
        if (bArmor) then surface.DrawRect(barX - 1, barY + 9, barWidth + 2, 5)  end

        surface.SetDrawColor(teamColor.r * 1.6, teamColor.g * 1.6, teamColor.b * 1.6, alphaFar)
        surface.DrawRect(barX, barY, barWidth * math.Clamp(ply:Health() / ply:GetMaxHealth(), 0, 1), 3)

        local extraHeight = 0
        if (bArmor) then
            extraHeight = 10
            surface.SetDrawColor(255, 255, 255, alphaFar)
            surface.DrawRect(barX, barY + 10, barWidth * math.Clamp(ply:Armor() / 50, 0, 1), 3)
        end

        surface.SetFont("WNBackFontNoClamp")
        ix.util.DrawText(ply:Name(), barX, barY - 13, teamColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, nil, 255)

        if (ix.option.Get("steamESP")) then
            surface.SetFont("WNMenuFontNoClamp")
            local y = barY + extraHeight + 13
            local toDraw = {}
            hook.Run("GetPlayerESPText", ply, toDraw, distance, alphaFar, alphaMid, alphaClose)
            table.sort(toDraw, sortFunc)

            for _, v in ipairs(toDraw) do
                if (v.alpha <= 0) then continue end

                extraColor.a = v.alpha
                ix.util.DrawText(v.text, barX, y, v.color or extraColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, nil, v.alpha)

                local _, txtHeight = surface.GetTextSize(v.text)
                y = y + txtHeight
            end
        end
    end
end

function PLUGIN:RenderAdminESP(client, target, color, clientPos, targetEyePos, distance)
    render.SuppressEngineLighting(true)
    render.SetColorModulation(color.r / 255, color.g / 255, color.b / 255)

    self.traceFilter[2] = target
    if (ix.option.Get("cheapBlur", false) or util.QuickTrace(clientPos, targetEyePos - clientPos, self.traceFilter).Fraction < 0.95) then
        render.SetBlend(1)
    else
        render.SetBlend(math.Remap(math.Clamp(distance, 200, 4000), 200, 8000, 0.05, 1))
    end
    render.MaterialOverride(mat1)
    target:DrawModel()

    render.MaterialOverride()

    render.SuppressEngineLighting(false)
end
