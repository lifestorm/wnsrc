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

PLUGIN.name = "Extra Admin Container Command"
PLUGIN.author = "Naast"
PLUGIN.description = "Does what it does."

ix.util.Include("sv_plugin.lua")

ix.command.Add("CheckContainerLastAccessor", {
    description = "Prints out the last person interacted with container that you looking at.",
    privilege = "Helix - Manage Containers",
    adminOnly = true,
    OnRun = function(self, client)
        local container = client:GetEyeTrace().Entity 
        if container and container:GetClass() != "ix_wncontainer" then return client:NotifyLocalized("You're not looking at any container!") end
        PLUGIN:GetContainerInteractionInfo(container, client)
    end
})