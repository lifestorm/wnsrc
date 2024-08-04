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
    description = "Désigne la dernière personne ayant interagi avec le conteneur que vous regardez.",
    privilege = "Helix - Manage Containers",
    adminOnly = true,
    OnRun = function(self, client)
        local container = client:GetEyeTrace().Entity 
        if container and container:GetClass() != "ix_wncontainer" then return client:NotifyLocalized("Vous ne regardez aucun conteneur !") end
        PLUGIN:GetContainerInteractionInfo(container, client)
    end
})