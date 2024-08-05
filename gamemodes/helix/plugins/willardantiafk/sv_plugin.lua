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
local INTERVAL = 30

util.AddNetworkString("ixPrintAfkPlayers")

ix.log.AddType("afkStart", function(client)
    return Format("%s has gone afk.", client:Name())
end)
ix.log.AddType("afkEnd", function(client, ...)
	local arg = {...}
    return Format("%s is no longer afk. Total time spent AFK: %s", client:Name(), arg[1])
end)

do
    local PLAYER = FindMetaTable("Player")

    function PLAYER:CheckAFKTick(interval)
        local aimVector = self:GetAimVector()
        local posVector = self:GetPos()

        if (self.ixLastAimVector == aimVector
            and self.ixLastPosition == posVector
            and !self.autowalk)
            then

            return self:AddAFKTime(interval or INTERVAL)
        else
            self.ixLastAimVector = aimVector
            self.ixLastPosition = posVector
            if (self:GetNetVar("afkTime", 0) > 0) then
                return self:ResetAFKTimer()
            end
        end
    end

    function PLAYER:AddAFKTime(time)
        local oldValue, oldTime = self:IsAFK(), self:GetNetVar("afkTime", 0)
        self:SetNetVar("afkTime", oldTime + time)

        if (self:IsAFK() and !oldValue) then
            ix.log.Add(self, "afkStart")
            return 5
        elseif (oldTime + time >= ix.config.Get("afkTime") - 60 and oldTime < ix.config.Get("afkTime") - 60) then
            self:Notify("You will be marked as AFK in 60 seconds if you do not move.")
            return 1
        end
    end

    function PLAYER:ResetAFKTimer()
        if (self:IsAFK()) then
            ix.log.Add(self, "afkEnd", self:GetNetVar("afkTime", 0))
        elseif (self:GetNetVar("afkTime", 0) > (ix.config.Get("afkTime") - 60)) then
            self:Notify("AFK timer reset.")
        end

        self:SetNetVar("afkTime", 0)

        return INTERVAL
    end
end

function PLUGIN:KickAFK(target, byAdmin)
	if (target and target:IsAFK()) then
		target:Kick("You were kicked for being AFK")
		if (byAdmin) then
			ix.util.NotifyLocalized("kickedAdminAFK", nil, byAdmin:Name(), target:Name())
		else
			ix.util.NotifyLocalized("kickedAFK", nil, target:Name())
		end
    elseif (byAdmin) then
        byAdmin:NotifyLocalized("targetNotAFK", target:Name())
	end
end
