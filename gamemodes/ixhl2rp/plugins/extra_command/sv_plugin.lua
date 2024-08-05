--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function PLUGIN:GetContainerInteractionInfo(container, client)
    local conID = tostring(container:GetInventory():GetID())
    local targetCharInfo = {}
    local correctResult = {}
    local found = false
    local shouldContinue = true
    local query = mysql:Select("ix_logs")
    query:Where("log_type", "openContainer")
    query:Where("lookup2", conID)
    query:Callback(function(result)
        if (result and istable(result) and table.Count(result) > 0) then
            correctResult = result[#result]
            if ix.char.loaded[tonumber(correctResult.char_id)] then 
                targetCharInfo = {name = ix.char.loaded[tonumber(correctResult.char_id)].vars.name, id = ix.char.loaded[tonumber(correctResult.char_id)].id}
                found = true
            end       
        else
            client:NotifyLocalized("Seems like no one used this container before.")
            shouldContinue = false
            return
        end
    end)
    query:Execute()
    if !shouldContinue then return end
    if !found then
        local cQuery = mysql:Select("ix_characters")
        cQuery:Select("id")
        cQuery:Select("name")
        cQuery:WhereLike("id", tostring(correctResult.char_id))
        cQuery:Limit(1)
        cQuery:Callback(function(result)
            if (!result or !istable(result) or #result == 0) then
                client:Notify("Character not found in database!")
                return
            end

            if !result[1].id then return end
                        
            targetCharInfo = result[1]
        end)
        cQuery:Execute()      
    end
    client:NotifyLocalized(tostring(targetCharInfo.name) .. " opened this container last time. Character ID: " .. tostring(targetCharInfo.id))
end