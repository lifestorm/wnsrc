--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local util = util
local ix = ix
local string = string
local net = net
local IsValid = IsValid
local pairs = pairs
local tonumber = tonumber

util.AddNetworkString("ixBodygroupView")
util.AddNetworkString("ixBodygroupTableSet")

ix.log.AddType("bodygroupEditor", function(client, target)
    return string.format("%s has changed %s's bodygroups.", client:GetName(), target:GetName())
end)

net.Receive("ixBodygroupTableSet", function(length, client)
    if (!ix.command.HasAccess(client, "CharEditBodygroup") and !client:IsCombine()) then return end

    local target = net.ReadEntity()

    if (client:IsCombine() and !ix.command.HasAccess(client, "CharEditBodygroup") and target != client) then return end

    if (!IsValid(target) or !target:IsPlayer() or !target:GetCharacter()) then
        return
    end

    local bodygroups = net.ReadTable()

    local groups = {}

    for k, v in pairs(bodygroups) do
        target:SetBodygroup(tonumber(k) or 0, tonumber(v) or 0)
        groups[tonumber(k) or 0] = tonumber(v) or 0

        local hairBG = client:FindBodygroupByName( "hair" )
        if k != hairBG then continue end
        if !client:GetModel():find("models/willardnetworks/citizens/") then continue end

        local curHeadwearBG = client:GetBodygroup(client:FindBodygroupByName( "headwear" ))
        local curHairBG = client:GetBodygroup(hairBG)

        local hairBgLength = 0
        for _, v2 in pairs(client:GetBodyGroups()) do
            if v2.name  != "hair" then continue end
            if !v2.submodels then continue end
            if !istable(v2.submodels) then continue end

            hairBgLength =  #v2.submodels
            break
        end

        if (curHeadwearBG != 0) then
            if curHairBG != 0 then
                client:SetBodygroup(hairBG, hairBgLength)
            end
        end
    end

    target:GetCharacter():SetData("groups", groups)

    local hairColor = net.ReadTable()
    local charProxies = target:GetCharacter():GetProxyColors() or {}

    charProxies["HairColor"] = Color(hairColor.r, hairColor.g, hairColor.b)

    target:GetCharacter():SetProxyColors(charProxies)

    ix.log.Add(client, "bodygroupEditor", target)
end)
