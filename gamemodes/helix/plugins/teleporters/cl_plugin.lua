--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.teleporters = ix.teleporters or {}
ix.teleporters.selected = ix.teleporters.selected or {}
ix.teleporters.data = ix.teleporters.data or {}

function ix.teleporters:RetrieveData(entity)
    if (entity and isentity(entity) and ix.teleporters.data and !table.IsEmpty(ix.teleporters.data)) then
        for k, v in ipairs(ix.teleporters.data) do
            if (v["id"] == entity:EntIndex()) then
                return v
            end
        end
    end
end
