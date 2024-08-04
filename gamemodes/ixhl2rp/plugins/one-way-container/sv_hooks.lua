--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:CanTransferItem(item, srcInv, dstInv)
    if (srcInv.vars and srcInv.vars.isContainer) then
        local entity = srcInv.storageInfo.entity
        
        if (entity:GetNetVar("isOneWay", false)) then
            -- If dstInv is zeroInv then it'll not have the method GetOwner
            if (!dstInv.GetOwner) then return false end
            local character = dstInv:GetOwner():GetCharacter()

            if (entity:GetLocked() and !entity.keypad and !entity.Sessions[character:GetID()]) then
                net.Start("ixContainerPassword")
                    net.WriteEntity(entity)
                net.Send(dstInv:GetOwner())

                return false
            end
        end
    end
end

function PLUGIN:CanTakeMoney(client, entity, amount)
    local character = client:GetCharacter()
    if (entity:GetNetVar("isOneWay", false) and entity:GetLocked() and !entity.keypad and !entity.Sessions[character:GetID()]) then
        net.Start("ixContainerPassword")
            net.WriteEntity(entity)
        net.Send(client)

        return false
    end
end