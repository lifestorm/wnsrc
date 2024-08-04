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

function PLUGIN:PlayerUse(client, entity)
    if (entity.canMalfunction and entity:GetNetVar("isBroken", false) == true) then
        local curTime = CurTime()

        if (!client.nextUse or client.nextUse <= curTime) then
            sound.Play("buttons/combine_button_locked.wav", entity:GetPos())

            client:Notify("The " .. entity.PrintName .. " is broken. You require a toolkit to repair it.")

            client.nextUse = curTime + 1
        end

        return false
    end
end

function PLUGIN:LoadData()
    timer.Create("ixMalfunctions", ix.config.Get("malfunctionTime", 150), 0, function()
        for k, v in ipairs(ents.GetAll()) do
            if (!v:IsPlayer() and !v:IsNPC() and v.canMalfunction and !v:GetNetVar("isBroken", false)) then
                v:SetNetVar("health", 50)

                if (math.random(1, 100) == 1) then
                    ix.malfunctions:Break(v)
                end
            end
        end
    end)
end

function PLUGIN:EntityTakeDamage(entity, dmg)
    if (!entity:IsPlayer() and !entity:IsNPC() and entity.canMalfunction and !entity:GetNetVar("isBroken", false)) then
        local client = dmg:GetAttacker()
        local character = dmg:GetAttacker():GetCharacter()

        if (!ix.malfunctions:CheckCrime()) then
            client:Notify("Not enough CPs online to break the " .. entity.PrintName .. ".")

            return
        end

        if (client:GetActiveWeapon():GetClass() == "ix_hands" and character:GetSkillLevel("melee") < 20) then
            client:Notify("You have hurt yourself!")
            client:TakeDamage(2, client, entity)

            return
        end

        if (entity:GetNetVar("health", 50) <= 0) then
            ix.malfunctions:Break(entity)
            ix.log.Add(client, "malfunctionBreak", entity.PrintName)

            if (client:GetArea()) then
                ix.combineNotify:AddNotification("NTC:// " .. entity.PrintName .. " disengaged at " .. client:GetArea(), Color(198, 43, 43))
            else
                ix.combineNotify:AddNotification("NTC:// " .. entity.PrintName .. " disengaged at UNKNOWN LOCATION", Color(198, 43, 43))
            end
        end

        entity:SetNetVar("health", entity:GetNetVar("health", 50) - dmg:GetDamage())
    end
end

