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

function PLUGIN:SetNickName(client, nickname)
    if (nickname) then
        if string.len(nickname) <= 1 then
            client:Notify("This nickname is too short!")
            return
        end

        if string.len(nickname) > ix.config.Get("maxNicknameLength", 40) then
            client:Notify("This nickname is too long!")
            return
        end
    end

    local target = client:GetEyeTraceNoCursor().Entity
    if (!IsValid(target) or !(target:IsPlayer() or target:GetClass() == "prop_ragdoll")) then
        client:Notify("You must be looking at a valid target!")
        return
    end

    if target:GetNetVar("ixMaskEquipped") then
        client:Notify("You cannot assign nicknames to masked individuals!")
        return false
    end

    if target:GetNetVar("combineMaskEquipped") then
        client:Notify("You cannot assign nicknames to masked individuals!")
        return false
    end

    local localChar = client:GetCharacter()
    local targCharacter = (target.GetCharacter and target:GetCharacter() or false)
    if !targCharacter or !localChar then return false end

    local targetCharID = targCharacter:GetID()
    local nickNames = localChar:GetNickNames()
    nickNames[targetCharID] = nickname
    localChar:SetNickNames(nickNames)
    
    client:Notify((nickname and "Assigned" or "Removed").." nickname "..(!nickname and "" or "'"..nickname.."'")..(nickname and " to" or "from").." this character.")
end