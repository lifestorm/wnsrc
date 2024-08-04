--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Advanced Custom Item Creation"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Ajoute la possibilité de créer des éléments personnalisés à la volée avec des options de personnalisation avancées."

ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

CAMI.RegisterPrivilege({
	Name = "Helix - Create Custom Script",
	MinAccess = "admin"
})

ix.command.Add("CreateCustomItem", {
	description = "Opens the Custom Item Creator menu.",
	OnRun = function(self, client)
		net.Start("ixCreateCustomItem")
		net.Send(client)
	end,
	OnCheckAccess = function(self, client)
		return CAMI.PlayerHasAccess(client, "Helix - Create Custom Script")
	end
})
