--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.phone = ix.phone or {}
ix.phone.switch = ix.phone.switch or {}

local PLUGIN = PLUGIN

function PLUGIN:RegisterSaveEnts()
    ix.saveEnts:RegisterEntity("landline_phone", true, true, true, {
        OnSave = function(entity, data) --OnSave
            data.endpointID = entity.endpointID
            data.extension  = entity.currentExtension
            data.exchange   = entity.currentPBX
            data.name       = entity.currentName
        end,
        OnRestore = function(entity, data) --OnRestore
            local exID      = tonumber(data.exchange)
            local ext       = tonumber(data.extension)
            local name      = data.name
            if (!exID or !ext) then
                ErrorNoHalt("Landline save data missing endpoint or extension. Ext: "..tostring(ext).." Pbx: "..tostring(exID))
                return
            end

            local newEndID = ix.phone.switch.endpoints:Register(entity)
            if (!newEndID) then
                -- ent exists already as an endpoint
                ErrorNoHalt("Landline multiply registered as endpoint! EndID: "..tostring(newEndID))
                return
            end
            entity.endpointID = newEndID

            ix.phone.switch:AddExchange(exID)
            ix.phone.switch:AddDest(exID, ext, name, newEndID)

            entity.currentExtension = ext
            entity.currentPBX = exID
            entity.currentName = name
        end
    })
end
