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

-- could just call ixPlayer on the ragdoll but then the colors will change on the ragdoll according to what the player is doing
-- in their inventory (even if they are dead)

function PLUGIN:OnCharacterFallover(client, entity, bFallenOver)
    if (entity == nil or !IsValid(entity)) then return end

    local character = client.GetCharacter and client:GetCharacter()
    if (!character) then return end

    local colorProxies = character:GetProxyColors() or {}
    for proxy, vector in pairs(colorProxies) do
        local color = vector
        if !isvector(color) and istable(color) and color.r then
            color = Vector(color.r / 255, color.g / 255, color.b / 255)
        end

        entity:SetNWVector(proxy, color)
    end
end