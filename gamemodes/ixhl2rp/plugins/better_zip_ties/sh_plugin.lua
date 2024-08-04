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

PLUGIN.name = "Better Zip Ties"
PLUGIN.description = "Adds the ability for players to drag around tied up characters"
PLUGIN.author = "M!NT"

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

ix.command.Add("RemoveHeadBag", {
    description = "Zdejmij worek z głowy osoby, na którą patrzysz.",
    alias = "rhb",
    OnRun = function(self, client)
        if (client:IsRestricted() or client:GetLocalVar("ragdoll")) then
            return "@notNow"
        end

        local data = {}
            data.start = client:GetShootPos()
            data.endpos = data.start + client:GetAimVector() * 96
            data.filter = client
        local target = util.TraceLine(data).Entity

        if (!target or !target.IsPlayer or !target:IsPlayer() or !IsValid(target)) then
            return "Nie patrzysz na właściwego gracza!"
        end

        if (!target:GetNetVar("WNBagged")) then
            return "Postać, na którą patrzysz, nie ma obecnie torby na głowie!"
        end

        PLUGIN:RemoveBag(client, target)
    end
})

ix.command.Add("RemoveHeadBagSelf", {
    description = "Zdejmij worek z głowy, jeśli to możliwe.",
    alias = "rhbs",
    OnRun = function(self, client)
        if (client:IsRestricted() or client:GetLocalVar("ragdoll")) then
            return "@notNow"
        end

        if (!client:GetNetVar("WNBagged")) then
            return "Obecnie na twojej głowie nie ma żadnego worka..."
        end

        client:SetAction("Zdejmujesz worek", 3, function()
            net.Start("WNBagExit")
			    net.WriteString(client:SteamID64())
		    net.Broadcast()

		    client:SetNetVar("WNBagged", false)
        end)
    end
})

