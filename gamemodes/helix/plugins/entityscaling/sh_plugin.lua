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

PLUGIN.name = "Entity Scaling"
PLUGIN.description = "A simple plugin providing scaling functionality on entities."
PLUGIN.author = "Mango"

ix.scalestuff = ix.scalestuff or {}

PLUGIN.disallowedClasses = {
    "prop_ragdoll"
}

CAMI.RegisterPrivilege({
	Name = "Helix - Entity Scaling",
	MinAccess = "admin"
})

ix.command.Add("entscale", {
    description = "Scale an entity to a desired size.",
    adminOnly = true,
    arguments = {
        ix.type.number
    },
    OnRun = function(self, client, val)
        if !CAMI.PlayerHasAccess(client, "Helix - Entity Scaling", nil) then return end

        local ent = client:GetEyeTraceNoCursor().Entity

        ix.scalestuff:ScaleEntity(ent, val)
    end
})

ix.util.Include("sv_plugin.lua")