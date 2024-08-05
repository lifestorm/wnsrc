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

function PLUGIN:HUDPaint()
    if (ix.config.Get("SmugglingShowWaypoints")) then
        local waypoints = LocalPlayer().ixStashWaypoints

        if (waypoints and !table.IsEmpty(waypoints)) then
            for k, v in pairs(waypoints) do
                local screenPos = v.pos:ToScreen()
                local x, y = screenPos.x, screenPos.y
                local text = v.name

                surface.SetFont("BudgetLabel")
                local width = surface.GetTextSize(text)
                surface.SetTextColor(color_white)
                surface.SetTextPos(x - width / 2, y - 17)
                surface.DrawText(text)
            end
        end
    end
end

function PLUGIN:PreDrawHalos()
    if (ix.config.Get("SmugglingShowWaypoints")) then
        local stashEntities = LocalPlayer().ixStashEntities
        if (!stashEntities or table.IsEmpty(stashEntities)) then return end

        local entities = {}
        for k, v in ipairs(stashEntities) do
            if (IsValid(Entity(v)) and Entity(v):GetClass() == "ix_pickupcache") then
                entities[#entities + 1] = Entity(v)
            end
        end

        if (entities and !table.IsEmpty(entities)) then
            halo.Add(entities, color_white)
        end
    end
end
