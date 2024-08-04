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

ix.log.AddType("malfunctionBreak", function(client, entityName)
    return string.format("%s has broken a %s", client:Name(), entityName)
end)

ix.log.AddType("malfunctionFix", function(client, entityName)
    return string.format("%s has fixed a %s", client:Name(), entityName)
end)

function ix.malfunctions:CheckCrime()
    local cpCount = 0

    for _, v in pairs(player.GetAll()) do
        if (!IsValid(v)) then continue end
        if (v:Team() != FACTION_CP) then continue end

        cpCount = cpCount + 1
    end

    if (cpCount < ix.config.Get("CheckCrimeAmountNeeded", 4)) then
        return false
    end

    return true
end

function ix.malfunctions:HasDisplay(entity)
    if (!entity or entity and !isentity(entity)) then
        ErrorNoHalt("Attempted to run malfunction break on invalid entity.")

        return
    end

    return istable(entity.Displays)
end

function ix.malfunctions:Break(entity)
    if (!entity or entity and !isentity(entity)) then
        ErrorNoHalt("Attempted to run malfunction break on invalid entity.")

        return
    end

    if (!entity.canMalfunction) then return end -- Remember to add ENT.canMalfunction = true to the entity shared file

    entity:SetNetVar("isBroken", true)

    if (self:HasDisplay(entity)) then
        for k, v in ipairs(entity.Displays) do
            if (v[1] == "OFFLINE") then
                entity:SetDisplay(k)
            end
        end
    end

    if (!timer.Exists("ixMalfunctionsEffect" .. entity:EntIndex())) then
        local index = index or entity:EntIndex()

        timer.Create("ixMalfunctionsEffect" .. index, 1, 0, function()
            if (!IsValid(entity)) then
                timer.Remove("ixMalfunctionsEffect" .. index)

                return
            else
                local effectData = EffectData()
                effectData:SetOrigin(entity:GetPos())
                effectData:SetEntity(entity)
                util.Effect("ManhackSparks", effectData)

                sound.Play("ambient/energy/spark" .. math.random(1, 6) .. ".wav", entity:GetPos())
            end
        end)
    end
end

function ix.malfunctions:Fix(entity, ply)
    if (!entity or entity and !isentity(entity)) then
        ErrorNoHalt("Attempted to run malfunction fix on invalid entity.")

        return
    end

    if (!ply or ply and !ply:IsPlayer()) then
        ErrorNoHalt("Attempted to run malfunction fix without valid player.")

        return
    end

    if (!entity.canMalfunction) then return end
    if (entity.canMalfunction and !entity:GetNetVar("isBroken", false)) then return end

    local playedSound = false
    local timerName = "ixMalfunctionCheckUse" .. ply:SteamID64()
    local soundType = "willardnetworks/malfunctions/tools" .. math.random(1, 4) .. ".mp3"

    timer.Create(timerName, 1, 0, function()
        if (!IsValid(ply)) then
            timer.Remove(timerName)
        end

        if (!playedSound) then
            ply:EmitSound(soundType)

            playedSound = true
        end

        if (ply:GetEyeTraceNoCursor().Entity != entity or ply:GetPos():DistToSqr(entity:GetPos()) > 100 ^ 2) then
            ply:SetAction(false)
            ply:StopSound(soundType)

            timer.Remove(timerName)
        end
    end)

    ply:SetAction("Repairing " .. entity.PrintName .. "...", 20, function()
        if (!IsValid(ply) or IsValid(ply) and !ply:Alive()) then return end

        entity:SetNetVar("isBroken", false)
        entity:SetNetVar("health", 50)
        entity:EmitSound("ambient/levels/citadel/citadel_breakershut2.wav")

        timer.Remove("ixMalfunctionsEffect" .. entity:EntIndex())

        if (timer.Exists(timerName)) then
            timer.Remove(timerName)
        end

        local repairItem = ply:GetCharacter():GetInventory():HasItem("tool_toolkit")

        if (repairItem) then
            repairItem:DamageDurability(1)
        end

        if (self:HasDisplay(entity)) then
            entity:SetDisplay(1)
        end

        ix.log.Add(ply, "malfunctionFix", entity.PrintName)
    end)
end

function ix.malfunctions:ForceFix(entity)
    if (!entity or entity and !isentity(entity)) then
        ErrorNoHalt("Attempted to run malfunction force fix on invalid entity.")

        return
    end

    if (!entity.canMalfunction or entity.canMalfunction and !entity:GetNetVar("isBroken", false)) then return end

    timer.Remove("ixMalfunctionsEffect" .. entity:EntIndex())

    entity:SetNetVar("isBroken", false)
    entity:SetNetVar("health", 50)

    if (ix.malfunctions:HasDisplay(entity)) then
        entity:SetDisplay(1)
    end
end