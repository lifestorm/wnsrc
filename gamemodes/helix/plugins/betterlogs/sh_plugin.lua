--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix
local CAMI = CAMI
local LocalPlayer = LocalPlayer

local PLUGIN = PLUGIN

PLUGIN.name = "Better Logs"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "Saves logs in a database and allows permitted staff to look them up."

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Logs",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Tp",
	MinAccess = "admin"
})

ix.lang.AddTable("french", {
	optLogDefaultTime = "Durée de recherche des logs par défaut",
	optdLogDefaultTime = "La durée par défaut de la recherche dans l'outil de recherche des logs."
})

ix.lang.AddTable("english", {
	optLogDefaultTime = "Durée de recherche des logs par défaut",
	optdLogDefaultTime = "La durée par défaut de la recherche dans l'outil de recherche des logs."
})

ix.lang.AddTable("spanish", {
	optdLogDefaultTime = "La cantidad de tiempo por defecto para buscar en la herramienta de búsqueda de registros.",
	optLogDefaultTime = "Tiempo de búsqueda de registros por defecto"
})

ix.option.Add("logDefaultTime", ix.type.string, "1d", {
	bNetworked = true,
	category = "Administration",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Manage Logs", nil)
	end
})