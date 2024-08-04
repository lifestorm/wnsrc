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
util.AddNetworkString("TempspawnsData")

function PLUGIN:TempSpawnAll(client)
    local players = player.GetAll()
    local amount = 0

    for _, ply in pairs(players) do
        if (!ply:GetCharacter() or ply:GetMoveType() == MOVETYPE_NOCLIP or !ply:Alive()) then
            continue
        end

        if (!ix.faction.Get(ply:Team()).useTempSpawns) then
            continue
        end

        if (IsValid(ply.ixRagdoll)) then
            ply:SetRagdolled(false)
        end

        amount = amount + 1
        local index = amount % #self.tempspawns
        local pos = self.tempspawns[index + 1]
        if amount > #self.tempspawns then
            local a = 1 / 8
            local b = a * (amount - index) / #self.tempspawns
            pos = pos + Vector(
                (b <= a*3 and -50) or (b > a*4 and b <= a*7 and 50) or 0,
                (b <= a*1 and -50) or (b > a*2 and b <= a*5 and 50) or (b > a*6 and -50) or 0,
                10
            )
        end

        ply:SetPos(pos)
    end

    if (amount == 1) then
        client:NotifyLocalized("tempspawnsRespawnOne")
    else
        client:NotifyLocalized("tempspawnsRespawnNumber", amount)
    end
end

function PLUGIN:SendTempspawns(client)
    net.Start("TempspawnsData")
    net.WriteUInt(#self.tempspawns, 16)
    for _, v in ipairs(self.tempspawns) do
        net.WriteVector(v)
    end
    if (client) then
        net.Send(client)
    else
        net.Broadcast()
    end
end

function PLUGIN:PostPlayerLoadout(client)
    if (ix.faction.Get(client:GetCharacter():GetFaction()).useTempSpawns) then
        if (#self.tempspawns > 0) then
            client:SetPos(self.tempspawns[math.random(#self.tempspawns)])
        end
    end
end

function PLUGIN:PlayerInitialSpawn(client)
    self:SendTempspawns(client)
end

function PLUGIN:RemoveTempspawns(client)
    if (#self.tempspawns == 0) then
        client:NotifyLocalized("tempspawnsNoSet")
    end

    self.tempspawns = {}
    self:SendTempspawns()

    client:NotifyLocalized("tempspawnsRemovedAll")
end

function PLUGIN:RemoveTempspawn(client)
    local trace = client:GetEyeTraceNoCursor()
    local pos = trace.HitPos + Vector(0, 0, 10)
    local index = nil
    local minDistanceSqr = nil

    for k, point in ipairs(self.tempspawns) do
        local dist = point:DistToSqr(pos)
        if (!index or dist < minDistanceSqr) then
            index = k
            minDistanceSqr = dist
        end
    end

    if (!index) then
        client:NotifyLocalized("tempspawnsNoSet")
        return
    elseif (index and minDistanceSqr > 40000) then
        client:NotifyLocalized("tempspawnsNoNearLooking")
        return
    end

    PLUGIN:UpdateTempspawn(index)
end

function PLUGIN:UpdateTempspawn(index, newValue)
    if (!newValue) then
        table.remove(self.tempspawns, index)
    else
        self.tempspawns[index] = newValue
    end
    self:SendTempspawns()
end

function PLUGIN:AddTempspawn(tempspawn)
    table.insert(self.tempspawns, tempspawn)
    self:SendTempspawns()
end