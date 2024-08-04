--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local timer = timer
local math = math
local os = os
local IsValid = IsValid
local ix = ix

local PLUGIN = PLUGIN

function PLUGIN:PlayerLoadedCharacter(client, character)
    local uniqueID = "ixGas" .. client:SteamID64()
    timer.Create(uniqueID, self.TIMER_INTERVAL, 0, function()
        if (IsValid(client)) then
            if (ix.faction.Get(client:Team()).noGas) then return end

            PLUGIN:GasZoneTick(client)
        else
            timer.Remove(uniqueID)
        end
    end)

    if (character:GetGasCooldownPoints() >= self.GAS_COOLDOWN_DELAY) then
        local time = math.floor((os.time() - character:GetGasCooldownStart()) / 60)
        if (time > 0) then
            character:SetGasPoints(self:deductTime(client, character:GetGasPoints(), time / 2))
        end
    end
end

function PLUGIN:OnPlayerAreaChanged(client, oldID, newID)
    if (ix.area.stored[newID].type == "gas") then
        if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then return end
        if (ix.faction.Get(client:Team()).noGas) then return end

        client:GetCharacter():SetGasCooldownPoints(0)

        if (oldID and ix.area.stored[oldID] and ix.area.stored[oldID].type != "gas" and ix.option.Get(client, "gasNotificationWarnings")) then
            client:ChatNotifyLocalized("gasEntered")
        end
    end
end

function PLUGIN:PlayerSpawn(client)
    local character = client:GetCharacter()
	if (!character) then return end
	if (ix.config.Get("gasPermakill") and character:GetData("gasPermakill")) then
        character:SetData("gasPermakill", nil)
		character:Ban()
	else
		character:SetData("gasPermakill", nil)
	end
end