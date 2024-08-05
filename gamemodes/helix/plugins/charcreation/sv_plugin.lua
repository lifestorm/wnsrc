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

function PLUGIN:PlayerLoadedCharacter(client, character)
    if (character:GetGlasses() and !character:HasGlasses()) then
        timer.Simple(3, function()
            if (IsValid(client) and !character:HasGlasses()) then
                client:NotifyLocalized("I need my glasses on to see properly..")
            end
        end)
    end

    -- Beard stuff
    local uniqueID = "ixBeard" .. client:SteamID64()
    local gender = character:GetGender()
    if (gender == "male" and !ix.faction.Get(client:Team()).noBeard) then
        timer.Create(uniqueID, PLUGIN.TIMER_DELAY, 0, function()
            if (IsValid(client)) then
                PLUGIN:BeardPlayerTick(client)
            else
                timer.Remove(uniqueID)
            end
        end)
    else
        timer.Remove(uniqueID)
    end

    local hairTable = character.GetHair and character:GetHair() or {}
    if !table.IsEmpty(hairTable) then
        local color = hairTable.color
        local charProxies = character:GetProxyColors() or {}

        charProxies["HairColor"] = color

        character:SetProxyColors(charProxies)
    else
        client:Notify("We've added new hairs and hair colors, please select via the menu.")
        netstream.Start(client, "OpenBeardStyling")
    end

    local curModel = client:GetModel()
    if curModel:find("willardnetworks/citizens/male") and !curModel:find("willardnetworks/citizens/male_") then
        local beardIndex = client:FindBodygroupByName("beard")
        local curBeard = client:GetBodygroup(beardIndex)
        character:SetModel(string.gsub(curModel, "male", "male_"))

        for i = 0, client:GetNumBodyGroups() do
            client:SetBodygroup(i, 0)
        end

        timer.Simple(2, function()
            if !client or client and !IsValid(client) then return end
            if !character then return end

            local groups = {}
            if curBeard then
                groups[beardIndex] = curBeard
            end

            local hairIndex = client:FindBodygroupByName("hair")
            groups[hairIndex] = hairTable.hair
            character:SetData("groups", groups)

            if hairTable.hair then
                client:SetBodygroup(hairIndex, hairTable.hair)
            end

            if curBeard then
                client:SetBodygroup(beardIndex, curBeard)
            end
        end)
    end
end

function PLUGIN:AdjustCreationPayload(client, payload, newPayload)
    if (newPayload.data.glasses != nil) then
        newPayload.glasses = newPayload.data.glasses
        newPayload.data.glasses = nil
    end

    if (newPayload.data.canread != nil) then
        newPayload.canread = newPayload.data.canread
        newPayload.data.canread = nil
    end
end

function PLUGIN:BeardPlayerTick(client)
    local character = client:GetCharacter()
    if (character) then
        if (!client:Alive()) then return end

        local beardProgress = character:GetBeardProgress() + 1
        character:SetBeardProgress(beardProgress)

        if (beardProgress == 180 * 8) then
            local index = client:FindBodygroupByName("beard")
            local groups = character:GetData("groups", {})
            groups[index] = 8
            client:SetBodygroup(index, 8)
            character:SetData("groups", groups)
            client:NotifyLocalized("I should really trim my beard.")
        elseif (beardProgress == 180 * 16) then
            local index = client:FindBodygroupByName("beard")
            local groups = character:GetData("groups", {})
            groups[index] = 5
            client:SetBodygroup(index, 5)
            character:SetData("groups", groups)
            client:NotifyLocalized("My beard is getting really long now.")
        end
    end
end

netstream.Hook("RemoveBeardBodygroup", function(client, target)
    if target and IsValid(target) then
        if client != target then
            client = target
        end
    end

	local character = client:GetCharacter()
    local index = client:FindBodygroupByName("beard")
    if client:GetBodygroup( index ) <= 0 then
        client:NotifyLocalized("I don't have any beard!")
        return false
    end

    local groups = character:GetData("groups", {})
    groups[index] = 0
    client:SetBodygroup(index, 0)
    character:SetData("groups", groups)
    character:SetBeardProgress(0)
end)

netstream.Hook("SetHairBeardBodygroup", function(client, hairID, beardID, hairColor, target)
    if target and IsValid(target) then
        if client != target then
            client = target
        end
    end

    local character = client:GetCharacter()
    local gender = character:GetGender()

    local beardBGIndex = client:FindBodygroupByName("beard")
    local hairBGIndex = client:FindBodygroupByName("hair")

    local curHair = client:GetBodygroup(hairBGIndex)
    local curBeard = beardBGIndex != -1 and client:GetBodygroup(beardBGIndex) or false

    local groups = character:GetData("groups", {})

    if gender != "female" and curBeard and beardID and curBeard != beardID then
        local beardProgress = character:GetBeardProgress()

        if (beardProgress < (180 * 8)) and client:GetBodygroup(beardBGIndex) != 5 and client:GetBodygroup(beardBGIndex) != 8 then
            return false
        end

        character:SetBeardProgress(0)

        groups[beardBGIndex] = beardID
        client:SetBodygroup(beardBGIndex, beardID)
    end

    if hairID and curHair != hairID or hairColor then
        local hairData = character:GetHair()

        if hairID then
            groups[hairBGIndex] = hairID
            local bgName = client:GetModel():find("wn7new") and "cp_Head" or "headwear"
            if client:GetBodygroup(client:FindBodygroupByName(bgName)) <= 0 then
                client:SetBodygroup(hairBGIndex, hairID)
            end

            hairData.hair = hairID
        end

        if hairColor then
            hairData.color = hairColor

            local charProxies = character:GetProxyColors() or {}

            charProxies["HairColor"] = hairColor

            character:SetProxyColors(charProxies)
        end

        character:SetHair(hairData)
    end

    character:SetData("groups", groups)
end)

function PLUGIN:InitializedPlugins()
    Schema.charCreationItems = {}
	for _, v in pairs(ix.item.list) do
		if (v.charCreation or v.adminCreation) and v.bodyGroups then
            Schema.charCreationItems[v.uniqueID] = {bodygroups = v.bodyGroups, proxy = v.proxy or false}
		end
	end
end

netstream.Hook("AcceptStyling", function(target, attempter)
    if !target or !attempter then return end
    if !IsValid(target) or !IsValid(attempter) then return end

    netstream.Start(attempter, "OpenBeardStyling", target)
end)