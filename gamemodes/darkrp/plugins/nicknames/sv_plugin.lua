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
            client:Notify("Ce surnom est trop court !")
            return
        end

        if string.len(nickname) > ix.config.Get("maxNicknameLength", 40) then
            client:Notify("Ce surnom est trop long !")
            return
        end
    end

    local target = client:GetEyeTraceNoCursor().Entity
    if (!IsValid(target) or !(target:IsPlayer() or target:GetClass() == "prop_ragdoll")) then
        client:Notify("Vous devez regarder une cible valide !")
        return
    end

    if target:GetNetVar("ixMaskEquipped") then
        client:Notify("Vous ne pouvez pas attribuer de surnoms à des personnes masquées !")
        return false
    end

    if target:GetNetVar("combineMaskEquipped") then
        client:Notify("Vous ne pouvez pas attribuer de surnoms à des personnes masquées !")
        return false
    end

    local localChar = client:GetCharacter()
    local targCharacter = (target.GetCharacter and target:GetCharacter() or false)
    if !targCharacter or !localChar then return false end

    local targetCharID = targCharacter:GetID()
    local nickNames = localChar:GetNickNames()
    nickNames[targetCharID] = nickname
    localChar:SetNickNames(nickNames)
    
    client:Notify((nickname and "Attribué" or "Supprimé").." surnom "..(!nickname and "" or "'"..nickname.."'")..(nickname and " pour" or "de").." ce personnage.")
end