--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local IsValid = IsValid
local ix = ix

function PLUGIN:PlayerLoadedCharacter(client, character)
    local uniqueID = "ixLethalGas" .. client:SteamID64()
    timer.Create(uniqueID, ix.config.Get("LethalGasDamageTimer"), 0, function()
        if (IsValid(client)) then
            if (!client.ixInArea) then return end

            if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then return end

            if (!ix.config.Get("GasVorts")) then
                if (ix.faction.Get(client:Team()).noGas) then return end
            end

            if (!ix.config.Get("GasBleedout")) then
                if (character:GetBleedout() > 0) then return end
            end

            if (client.ixArea and ix.area.stored[client.ixArea] and ix.area.stored[client.ixArea].type == "lethal gas" and !client:HasPPE()) then
                client:TakeDamage(ix.area.stored[client.ixArea].properties.Severity * ix.config.Get("LethalGasDamage"), null, null)
            end
        else
            timer.Remove(uniqueID)
        end
    end)
end

function PLUGIN:OnPlayerAreaChanged(client, oldID, newID)
    if (ix.area.stored[newID].type == "lethal gas") then
        if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then return end

        if (oldID and ix.area.stored[oldID] and ix.area.stored[oldID].type != "lethal gas" and ix.option.Get(client, "gasNotificationWarnings")) then
            client:ChatNotifyLocalized("lethalGasEntered")
        end
    end
end