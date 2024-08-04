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

function PLUGIN:resizeCharacter(character)
    local client = character:GetPlayer()
    local height = character:GetHeight()
    if (!height or height == "" or height == "N/A" or !IsValid(client) or !ix.config.Get("ModelScalingEnable")) then
        client:SetModelScale(1, 0.01)
        return
    end

    local heightFt, heightIn = string.match(height, "^(%d+)'(%d+)\"$")
    heightFt = tonumber(heightFt)
    heightIn = tonumber(heightIn)
    if (!isnumber(heightFt) or !isnumber(heightIn)) then
        client:SetModelScale(1, 0.01)
        return
    end

    local heightMinIn = ix.config.Get("ModelScalingMinInches", 58) -- minimum inches a character can be
    local heightMaxIn = ix.config.Get("ModelScalingMaxInches", 78) -- maximum inches a character can be
    local heightMin   = ix.config.Get("ModelScalingMin", 0.85)     -- minimum scale allowed
    local heightMax   = ix.config.Get("ModelScalingMax", 1.25)     -- maximum scale allowed
    local inchesFromBase = ((heightFt * 12) + heightIn) - heightMinIn
    local charScaleFromMin = (heightMax - heightMin) / (heightMaxIn - heightMinIn) * inchesFromBase

    local sexOffset = 0
    if (client:IsFemale()) then -- for some reason this is not character:IsFemale()?? thanks alex
        sexOffset = ix.config.Get("ModelScalingSexOffset", 0.1)
    end

    -- final scale. between heightMin and heightMax
    local finalScale = math.Clamp(
        heightMin + charScaleFromMin + sexOffset,
        heightMin,
        heightMax
    )

    -- scale their entire model
    -- for some reason we need to wait awhile (probably because another hook somewhere is resetting this)
    timer.Simple(5, function()
        client:SetModelScale(finalScale, 0.01)
    end)
end

function PLUGIN:CharacterLoaded(character)
    PLUGIN:resizeCharacter(character)
end
