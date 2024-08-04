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

PLUGIN.name = "Malfunctions"
PLUGIN.author = "Mango"
PLUGIN.description = "Allow certain entities to malfunction and be fixed."

ix.malfunctions = ix.malfunctions or {}

ix.config.Add("malfunctionTime", 150, "The time in which malfunction creation function will be called.", function()
        if (timer.Exists("ixMalfunctions")) then
            timer.Adjust("ixMalfunctions", ix.config.Get("malfunctionTime", 150), 0, function()
                for k, v in ipairs(ents.GetAll()) do
                    if (!v:IsPlayer() and !v:IsNPC() and math.random(1, 100) == 1 and !v:GetNetVar("isBroken", false)) then
                        ix.malfunctions:Break(v)
                    end
                end
            end)
        end
    end, {
    data = {min = 1, max = 2500},
    category = "Malfunctions"
})

ix.command.Add("MalfunctionBreak", {
    description = "Breaks the entity you are looking at.",
    adminOnly = true,
    OnRun = function(self, client)
        local ent = client:GetEyeTraceNoCursor().Entity

        ix.malfunctions:Break(ent)
    end
})

ix.command.Add("MalfunctionFix", {
    description = "Fixes the entity you are looking at.",
    adminOnly = true,
    OnRun = function(self, client)
        local entity = client:GetEyeTraceNoCursor().Entity

        ix.malfunctions:ForceFix(entity)
    end
})

ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")