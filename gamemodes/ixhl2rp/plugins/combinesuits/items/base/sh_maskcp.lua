--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.base = "base_bgclothes"

ITEM.isGasmask = true
ITEM.isCombineMask = true
ITEM.isMask = true

ITEM.hooks.Equip = function(item, data)
    local character = item.player:GetCharacter()
    if (character and character:GetCombineSuit() == 0) then
        return false
    end
end

ITEM.postHooks.Equip = function(item, client)
    local player = item.player or client
    hook.Run("OnPlayerCombineMaskChange", player, true, player:GetActiveCombineSuit())
end

ITEM.postHooks.EquipUn = function(item, client)
    local player = item.player or client
    hook.Run("OnPlayerCombineMaskChange", player, false, player:GetActiveCombineSuit())
end

function ITEM:OnLoadout()
    if (self:GetData("equip")) then
        local client = self.player
        timer.Simple(1, function()
            if (!IsValid(client)) then return end
            hook.Run("OnPlayerCombineMaskChange",client, true, client:GetActiveCombineSuit())
        end)
    end
end