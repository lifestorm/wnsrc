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

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_ore_spawner", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})
end

-- Called just after data should be saved.
function PLUGIN:SaveData()
    local oreSpawns = {}

    local entities = ents.GetAll()
    for i = 1, #entities do
        if (entities[i]:GetClass() != "ix_ore_spawner") then continue end
        local v = entities[i]
        oreSpawns[#oreSpawns + 1] = {
            angles = v:GetAngles(),
            position = v:GetPos(),
        }
    end

    ix.data.Set("oreSpawns", oreSpawns)
end

-- Called when Helix has loaded all of the entities.
function PLUGIN:InitPostEntity()
    if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

    local oreSpawns = ix.data.Get("oreSpawns")
    if oreSpawns then
        for _, v in pairs(oreSpawns) do
            local entity = ents.Create("ix_ore_spawner")
            entity:SetAngles(v.angles)
            entity:SetPos(v.position)
            entity:Spawn()
        end
    end
end
