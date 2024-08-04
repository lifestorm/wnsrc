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

function PLUGIN:PopulateImportantCharacterInfo(targClient, targCharacter, container)
	local nicknameText = self:GetTargClientNickname(targClient)

	if (nicknameText) then
		local nickname = container:AddRow("nicknameText")
		nickname:SetText("Nickname: "..nicknameText)
		nickname:SetBackgroundColor(Color(150, 150, 150, 255))
		nickname:SizeToContents()
	end
end

function PLUGIN:GetTargClientNickname(targClient)
    local nickNames = LocalPlayer():GetCharacter():GetNickNames()
    if !nickNames or (nickNames and !istable(nickNames)) then return false end
	local targChar = targClient:GetCharacter()
    local targCharID = targChar:GetID()
    if !targCharID then return false end
    if targClient:GetNetVar("ixMaskEquipped") then
        return false
    end

    if targClient:GetNetVar("combineMaskEquipped") then
        return false
    end
    
    if nickNames[targChar:GetID()] then
        return nickNames[targChar:GetID()]
    else
        return false
    end
end