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

PLUGIN.name = "Gathering System"
PLUGIN.description = "A system that allows you to gather materials and refine them!"
PLUGIN.author = "gb"
PLUGIN.version = 0.1 

ix.util.Include("sv_plugin.lua")


ix.config.Add("Ore Respawn Timer", 60, "On average, how many minutes there should be in between ore spawns.", nil,
    {
        data = {min = 1, max = 240},
        category = "Gathering"
    }
)

ix.config.Add("Ore Respawn Variation", 30, "How many minutes of variation there should be in the spawning.", nil,
    {
        data = {min = 1, max = 240},
        category = "Gathering"
    }
)

ix.config.Add("Ore Spawn Chance Coal", 50, "Chance percentage for spawning coal.", nil, {
    data = {min = 0, max = 100},
    category = "Gathering"
})

ix.config.Add("Ore Spawn Chance Iron", 30, "Chance percentage for spawning iron.", nil, {
    data = {min = 0, max = 100},
    category = "Gathering"
})

ix.config.Add("Ore Spawn Chance Gold", 20, "Chance percentage for spawning gold.", nil, {
    data = {min = 0, max = 100},
    category = "Gathering"
})


if (CLIENT) then
    function PLUGIN:InitializedPlugins()
        local color = Color(120,0,240)
        local function drawOreEsp(client, entity, x, y, factor)
            local text = ""
            local nextSpawn = entity:GetNetVar("ixNextOreSpawn")
            local oreSpawn = entity:GetNetVar("ixSelectedOre")
            if (nextSpawn) then
                if (nextSpawn == -1) then
                    text = " (x)" .. oreSpawn
                elseif (nextSpawn > 0) then
                    local timeLeft = nextSpawn - CurTime()
                    if (timeLeft <= 60) then
                        text = " (<1m)" .. oreSpawn
                    else
                        text = " ("..math.Round(timeLeft / 60).."m)" .. oreSpawn
                    end
                end
            end

            ix.util.DrawText("Ore Spawner"..text, x, y - math.max(10, 32 * factor), color,
                TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, math.max(255 * factor, 80))
        end

        ix.observer:RegisterESPType("ix_ore_spawner", drawOreEsp, "ore")
    end
end
