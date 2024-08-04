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

PLUGIN.name = "Junk Items"
PLUGIN.author = "M!NT, Fruity"
PLUGIN.description = "Allow players to search trash for junk items."

ix.config.Add(
    "Trash Search Time",
    10,
    "The amount of seconds it takes for someone to search through garbage.",
    nil,
    {
	    data = {min = 1, max = 60},
	    category = "Trash"
    }
)

ix.config.Add("Trash Min Players", 10, "Chance someone has of finding something in trash piles", nil, {
        data = {min = 1, max = 20},
        category = "Trash"
    }
)
ix.config.Add("Trash Max Players", 40, "Chance someone has of finding something in trash piles", nil, {
    data = {min = 21, max = 100},
    category = "Trash"
}
)
ix.config.Add("Trash Min Chance", 40, "Chance someone has of finding something in trash piles", nil, {
    data = {min = 1, max = 100},
    category = "Trash"
}
)
ix.config.Add("Trash Max Chance", 80, "Chance someone has of finding something in trash piles", nil, {
    data = {min = 1, max = 100},
    category = "Trash"
}
)
ix.config.Add("Trash Cooldown Threshold", 5, "How many consecutive trash searches it requires until someone gets placed onto trash searching cooldown.", nil, {
    data = {min = 1, max = 100},
    category = "Trash"
}
)
ix.config.Add("Trash Cooldown Window", 240, "If someone searches x (threshold) amount of trash entities in this window (in seconds), they are put in cooldown.", nil, {
    data = {min = 1, max = 3600},
    category = "Trash"
}
)
ix.config.Add("Trash Cooldown Time", 3600, "How long (in seconds) someone is put on cooldown for", nil, {
    data = {min = 1, max = 7200},
    category = "Trash"
}
)
ix.config.Add(
    "Trash Search Multiplier",
    0.75,
    "Multiplies the chance of finding multiple items in the trash",
    nil,
    {
        data = {min = 0.0, max = 3.0, decimals = 2},
        category = "Trash"
    }
)
ix.config.Add(
    "Trash Search Max Items",
    3,
    "Maximum amount of items that can be found in the trash",
    nil,
    {
        data = {min = 1, max = 10},
        category = "Trash"
    }
)
ix.config.Add(
    "Trash Spawner Respawn Time",
    60,
    "On average, how many minutes there should be in between trash spawns.",
    nil,
    {
        data = {min = 1, max = 240},
        category = "Trash"
    }
)

ix.config.Add(
    "Trash Spawner Respawn Variation",
    30,
    "How many minutes of variation there should be in the spawning.",
    nil,
    {
        data = {min = 1, max = 240},
        category = "Trash"
    }
)

ix.util.Include("sv_plugin.lua")

ix.char.RegisterVar("trashCooldownWindowAttempts", {
	field = "trashCooldownWindowAttempts",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
	isLocal = true
})

ix.char.RegisterVar("trashCooldownTime", {
	field = "trashCooldownTime",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
	isLocal = true
})

if (CLIENT) then
    function PLUGIN:InitializedPlugins()
        local color = Color(120,0,240)
        local function drawTrashESP(client, entity, x, y, factor)
            local text = ""
            local nextSpawn = entity:GetNetVar("ixNextTrashSpawn")
            if (nextSpawn) then
                if (nextSpawn == -1) then
                    text = " (x)"
                elseif (nextSpawn > 0) then
                    local timeLeft = nextSpawn - CurTime()
                    if (timeLeft <= 60) then
                        text = " (<1m)"
                    else
                        text = " ("..math.Round(timeLeft / 60).."m)"
                    end
                end
            end

            ix.util.DrawText("Trash Spawner"..text, x, y - math.max(10, 32 * factor), color,
                TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, math.max(255 * factor, 80))
        end

        ix.observer:RegisterESPType("ix_trashspawner", drawTrashESP, "trash")
    end
end
