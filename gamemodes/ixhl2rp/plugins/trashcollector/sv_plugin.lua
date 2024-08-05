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
	ix.saveEnts:RegisterEntity("ix_trashcollector", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles + Angle(0, 180, 0), motion = false}
		end,
	})
end

function PLUGIN:SaveTrashCollectors()
    local trashcollectors = {}

    for _, v in pairs(ents.FindByClass("ix_trashcollector")) do
        trashcollectors[#trashcollectors + 1] = {
            angles = v:GetAngles(),
            position = v:GetPos()
        }
    end

    ix.data.Set("trashcollectors", trashcollectors)
end

function PLUGIN:LoadTrashCollectors()
    if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

    local trashcollectors = ix.data.Get("trashcollectors")
    if trashcollectors then
        for _, v in pairs(trashcollectors) do
            local entity = ents.Create("ix_trashcollector")
            entity:SetAngles(v.angles + Angle(0, 180, 0))
            entity:SetPos(v.position)
            entity:Spawn()
        end
    end
end

function PLUGIN:SaveData()
    self:SaveTrashCollectors()
end

function PLUGIN:InitPostEntity()
    self:LoadTrashCollectors()
end