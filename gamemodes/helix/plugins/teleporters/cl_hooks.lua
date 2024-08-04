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

ix.teleporters = ix.teleporters or {}
ix.teleporters.selected = ix.teleporters.selected or {}
ix.teleporters.data = ix.teleporters.data or {}

function PLUGIN:PlayerNoClip(ply, bool)
    if (bool) then
        if (!timer.Exists("ixTeleporterRetrieveData") and CAMI.PlayerHasAccess(ply, "Helix - Manage Teleporters", nil)) then
            timer.Create("ixTeleporterRetrieveData", 2, 0, function()
                netstream.Start("ixTeleportersGetData")
            end)
        end

        return
    end

    if (timer.Exists("ixTeleporterRetrieveData") and CAMI.PlayerHasAccess(ply, "Helix - Manage Teleporters", nil)) then
        timer.Remove("ixTeleporterRetrieveData")
    end
end

local function teleporterESP(client, entity, x, y, factor)
    local color = Color(0, 208, 255)
    ix.util.DrawText("Teleporter", x, y, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, factor)

    for _, v in pairs(ix.teleporters.data) do
        if (entity:EntIndex() == v["id"] or entity:EntIndex() == v["entIndex"]) then
            ix.util.DrawText("ID - " .. v["id"], x, y + 20, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, factor)
            ix.util.DrawText(v["mate"] and "Mate - " .. v["mate"] or "Mate - N/A", x, y + 40, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, factor)
            ix.util.DrawText(v["name"] != "Default" and "Name - " .. v["name"] or "Name - Default", x, y + 60, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, factor)
        end
    end
end

ix.observer:RegisterESPType("ix_teleporter", teleporterESP, "Teleporter")

netstream.Hook("ixTeleportersPassSelection", function(ID)
    if (!ix.teleporters or !ix.teleporters.selected) then
        ErrorNoHalt("Tried to reach invalid teleporter table")

        return
    end

    if (table.IsEmpty(ix.teleporters.selected)) then
        ix.teleporters.selected[1] = ID

        LocalPlayer():Notify("Teleporter one selected! The selection will reset in twenty seconds.")

        timer.Create("ixTeleportersResetSelection", 20, 1, function()
            LocalPlayer():Notify("Teleporter selection has been reset.")

            table.Empty(ix.teleporters.selected)
        end)
    elseif (!table.IsEmpty(ix.teleporters.selected) and isnumber(ix.teleporters.selected[1]) and ID != ix.teleporters.selected[1]) then
        ix.teleporters.selected[2] = ID

        if (timer.Exists("ixTeleportersResetSelection")) then
            timer.Remove("ixTeleportersResetSelection")
        end

        netstream.Start("ixTeleportersAssignMates", ix.teleporters.selected[1], ix.teleporters.selected[2])

        LocalPlayer():Notify("Teleporters linked successfully.")

        table.Empty(ix.teleporters.selected)
    end
end)

netstream.Hook("ixTeleportersSendData", function(data)
    ix.teleporters.data = data
end)

hook.Add("HUDPaint", "DrawImageOnEntity", function()
    local ply = LocalPlayer()
    local tr = ply:GetEyeTraceNoCursor()

    if (IsValid(tr.Entity) and tr.Entity:GetClass() == "ix_teleporter") then
        local maxDistance = 140
        local distance = ply:GetPos():Distance(tr.HitPos)

        if (distance <= maxDistance) then
            local imagePath = "willardnetworks/teleporters/teleporter.png"
            local pos = tr.HitPos:ToScreen()
            local imageSize = 100

            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material(imagePath))
            surface.DrawTexturedRect(pos.x - imageSize / 2, pos.y - imageSize / 2, imageSize, imageSize)

            ix.util.DrawText("ENTER", pos.x, pos.y + imageSize / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end)

