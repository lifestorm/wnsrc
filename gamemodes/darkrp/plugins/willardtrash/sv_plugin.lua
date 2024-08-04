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

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_trashspawner", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})
end

-- Called when Helix has loaded all of the entities.
function PLUGIN:InitPostEntity()
    if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

    local trashSpawns = ix.data.Get("trashSpawns")
    if trashSpawns then
        for _, v in pairs(trashSpawns) do
            local entity = ents.Create("ix_trashspawner")
            entity:SetAngles(v.angles)
            entity:SetPos(v.position)
            entity:Spawn()
        end
    end
end

-- Called just after data should be saved.
function PLUGIN:SaveData()
    local trashSpawns = {}

    local entities = ents.GetAll()
    for i = 1, #entities do
        if (entities[i]:GetClass() != "ix_trashspawner") then continue end
        local v = entities[i]
        trashSpawns[#trashSpawns + 1] = {
            angles = v:GetAngles(),
            position = v:GetPos(),
        }
    end

    ix.data.Set("trashSpawns", trashSpawns)
end

function PLUGIN:CharacterLoaded(char)
    local timerName = "UpdateTrashWindowFor "..tostring(char:GetName())
    local timerWindow = 0
    if (istable(char) and IsValid(char:GetPlayer())) then
        timer.Create(timerName, 1, 0, function ()
            timerWindow = timerWindow + 1
            if (!istable(char) or !IsValid(char:GetPlayer())) then
                timer.Remove(timerName)
                return
            end

            local cooldownTime = char:GetTrashCooldownTime()
            if (cooldownTime > 0) then
                -- char is already in cooldown
                char:SetTrashCooldownTime(cooldownTime - 1)
                char:SetTrashCooldownWindowAttempts(0)
                timerWindow = 0
                return  
            end

            local attempts = char:GetTrashCooldownWindowAttempts()
            local attemptsMax = ix.config.Get("Trash Cooldown Threshold")
            if (attempts >= attemptsMax) then
                local ply = char:GetPlayer()
                if (!IsValid(ply)) then
                    -- shouldn't happen here but we should check anyways
                    return
                end

                local windowTime = ix.config.Get("Trash Cooldown Window")
                if (timerWindow < windowTime) then
                    -- attempts > max and within the window means we're putting the char on cooldown
                    local cooldown = ix.config.Get("Trash Cooldown Time")
                    char:SetTrashCooldownTime(cooldown)

                    ply:NotifyLocalized("You have been put in cooldown for searching through trash.")
                    char:SetTrashCooldownWindowAttempts(0)

                    return
                end
                
                char:SetTrashCooldownWindowAttempts(0) -- reset back to zero because we're outside the window
                char:SetTrashCooldownTime(0)           -- reset back to zero because char should not be in cooldown
            end
        end)
    end
end
