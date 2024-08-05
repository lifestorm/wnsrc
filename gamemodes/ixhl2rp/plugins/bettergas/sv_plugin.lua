--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local string = string
local CurTime = CurTime
local ipairs = ipairs
local player = player
local os = os
local math = math
local ix = ix

local PLUGIN = PLUGIN

ix.log.AddType("gasDeath", function(client, permakill)
    return string.format("%s has died from lethal poison levels%s.", client:Name(), (permakill and " and will be permakilled") or "")
end, FLAG_DANGER)

function PLUGIN:deductTime(client, points, time)
    if (points >= self.LETHAL_GAS) then
        return points
    end

    if (points <= 0 or ix.config.Get("gasPointRecoveryPenalty") <= 0 or ix.config.Get("gasPointInjuryRecoveryPenalty") <= 0) then
        return 0
    end

    local fl, cl = math.floor(points), math.ceil(points)
    local y
    if (fl == cl) then
        y = self.gasToCooldown[fl]
    else
        y = math.Remap(points, fl, cl, self.gasToCooldown[fl], self.gasToCooldown[cl])
    end

    y = y - time / (ix.config.Get("gasPointRecoveryPenalty") * math.Remap(math.Clamp(client:Health() / client:GetMaxHealth(), 0, 1), 1, 0, 1, ix.config.Get("gasPointInjuryRecoveryPenalty")))

    for i = cl, 1, -1 do
        if (self.gasToCooldown[i - 1] <= y and y <= self.gasToCooldown[i]) then
            return math.Remap(y, self.gasToCooldown[i - 1], self.gasToCooldown[i], i - 1, i)
        end
    end

    return 0
end

function PLUGIN:GasZoneTick(client)
    if (!client:Alive()) then return end

    local character = client:GetCharacter()
    if (!character) then return end

    if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then
        if (character:GetGasCooldownPoints() <= 0) then return end

        local gasPointLoss = self.TIMER_INTERVAL / 60
        if (character:GetGasPoints() > 0) then
            local cdPoints = character:GetGasCooldownPoints()
            if (cdPoints < self.GAS_COOLDOWN_DELAY) then
                cdPoints = cdPoints + self.TIMER_INTERVAL / 60
                character:SetGasCooldownPoints(math.min(cdPoints, self.GAS_COOLDOWN_DELAY))
                if (cdPoints == self.GAS_COOLDOWN_DELAY and ix.option.Get(client, "gasNotificationWarnings")) then
                    client:ChatNotifyLocalized("gasCDStart")
                end
            end

            if (cdPoints == self.GAS_COOLDOWN_DELAY) then
                character:SetGasCooldownStart(os.time())
            end

            if (cdPoints >= self.GAS_DECREASE_DELAY) then
                character:SetGasPoints(self:deductTime(client, character:GetGasPoints(), gasPointLoss / 2))
            end
        end

        return
    end

    if (character:GetGasPoints() >= self.LETHAL_GAS) then
        if ((!client.ixGasCoughCD or client.ixGasCoughCD < CurTime()) and 0.5 > math.random()) then
            client.ixGasCoughCD = CurTime() + 5
            client:EmitSound("ambient/voices/cough"..math.random(1, 4)..".wav")
        end

        local gasDeathTicks = math.min(character:GetGasPoints() + self.TIMER_INTERVAL / 60, self.GAS_DEATH)
        character:SetGasPoints(gasDeathTicks)

        if (gasDeathTicks >= self.GAS_DEATH) then
            local permaKill = ix.config.Get("gasPermakill")
            ix.log.Add(client, "gasDeath", permaKill)

            client:Kill()
            character:SetGasPoints(0)
            if (permaKill) then
                character:SetData("gasPermakill", true)
            end

            for _, v in ipairs(player.GetAll()) do
                if ((v:GetMoveType() == MOVETYPE_NOCLIP and !v:InVehicle()) or v:Team() == FACTION_SERVERADMIN) then
                    v:NotifyLocalized("gasDeathNotif", client:SteamName(), (permaKill and " and will be permakilled") or "")
                end
            end
        end

        return
    end

    local inArea = client.ixInArea and ix.area.stored[client.ixArea].type == "gas"
    if ((inArea and !ix.config.Get("gasReverseZones")) or (ix.config.Get("gasReverseZones") and !inArea)) then
        local filterValue = client:GetFilterValue()
        local gasPointGain = self.TIMER_INTERVAL / 60
        if (filterValue > 0) then
            client:UpdateFilterValue(gasPointGain)
            gasPointGain = gasPointGain * (1 - client:GetFilterQuality())
        end

        gasPointGain = gasPointGain * ix.config.Get("gasPointGainScale") * math.Remap(math.Clamp(client:Health() / client:GetMaxHealth(), 0, 1), 1, 0, 1, ix.config.Get("gasPointInjuryScale"))

        local oldPoints = character:GetGasPoints()
        local gasPoints = oldPoints + gasPointGain
        character:SetGasPoints(gasPoints)
        character:SetGasCooldownPoints(0)

        if (gasPoints >= self.LETHAL_GAS) then
            client:ChatNotifyLocalized("gasLethalNotif")
            client:ChatNotifyLocalized("gasLethalNotifOOC")
        else
            if (ix.option.Get(client, "gasNotificationWarnings") and gasPoints >= 60 and oldPoints < 60) then
                client:ChatNotifyLocalized("gasHighNotif")
            elseif (gasPoints >= 100 and oldPoints < 100) then
                client:ChatNotifyLocalized("gasNearLethalNotif")
            end
        end

        if ((!client.ixGasCoughCD or client.ixGasCoughCD < CurTime()) and math.Clamp((gasPoints - 60) * (1 - client:GetFilterQuality()) / self.LETHAL_GAS, 0.01, 0.5) > math.random()) then
            client.ixGasCoughCD = CurTime() + 5
            client:EmitSound("ambient/voices/cough"..math.random(1, 4)..".wav")
        end
    else
        local gasPointLoss = self.TIMER_INTERVAL / 60
        local filterItem = client:GetFilterItem()
        if (filterItem and !filterItem.noUseOutGas) then
            client:UpdateFilterValue(gasPointLoss / 100)
        end

        if (character:GetGasPoints() > 0) then
            local cdPoints = character:GetGasCooldownPoints()
            if (cdPoints < self.GAS_COOLDOWN_DELAY) then
                cdPoints = cdPoints + self.TIMER_INTERVAL / 60
                character:SetGasCooldownPoints(math.min(cdPoints, self.GAS_COOLDOWN_DELAY))
                if (cdPoints == self.GAS_COOLDOWN_DELAY and ix.option.Get(client, "gasNotificationWarnings")) then
                    client:ChatNotifyLocalized("gasCDStart")
                end
            end

            if (cdPoints == self.GAS_COOLDOWN_DELAY) then
                character:SetGasCooldownStart(os.time())
            end

            if (cdPoints >= self.GAS_DECREASE_DELAY) then
                character:SetGasPoints(self:deductTime(client, character:GetGasPoints(), gasPointLoss))
            end
        end
    end
end