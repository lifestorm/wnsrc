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

function PLUGIN:PlayerLoadedCharacter(client, character)
    if (!ix.inebriation.allowedFactions[character:GetFaction()]) then
        client:SetNetVar("inebriation", 0)
        return
    end

    client:SetNetVar("inebriation", character:GetInebriation() or 0)

    local uniqueID = "ixInebriateTracker "..client:SteamID64()
    timer.Create(uniqueID, 10, 0, function()
		if (IsValid(client)) then
            local iPercent = client:GetNetVar("inebriation", 0)
            if (client:GetNetVar("inebriation", 0) > 0) then
                local toDecrement = math.Clamp(iPercent - ix.config.Get("inebriationDecay", 10), 0, 100)
                client:SetNetVar("inebriation", toDecrement)
                character:SetInebriation(toDecrement)

                local isRunning = client:KeyDown(IN_SPEED) or client:KeyDown(IN_RUN)
                if (client.GetRagdolled and client:GetRagdolled()) then
                    return
                end

                local gotTrolled
                if (client:IsDrunk() and toDecrement > math.random(0, 200) and isRunning) then
                    -- troll
                    client:SetRagdolled(true, 3)
                    if (ix.autochat) then
                        ix.chat.Send(client, "autochat_message", "", false, ix.autochat:GetRecievers(client), {
                            autochatType = "DRUNK_FALL_OVER"
                        })
                    end
                    gotTrolled = true
                end

                if (!gotTrolled and client:IsDrunk() and toDecrement > math.random(0, 2500)) then
                    if (client:GetNetVar("actEnterAngle")) then
                        -- they're in some kind of act sequence currently.
                        return
                    end

                    if (ix.autochat) then
                        ix.chat.Send(client, "autochat_message", "", false, ix.autochat:GetRecievers(client), {
                            autochatType = "DRUNK_FALL_OVER"
                        })
                    end
                    client:SetRagdolled(true, 30)
                end
            end
        else
			timer.Remove(uniqueID)
		end
	end)
end
