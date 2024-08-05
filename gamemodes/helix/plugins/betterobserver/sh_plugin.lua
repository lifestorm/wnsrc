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

PLUGIN.name = "Better Observer"
PLUGIN.author = "Chessnut & Gr4Ss"
PLUGIN.description = "Adds on to the no-clip mode to prevent intrusion. Edited for WN by Gr4Ss."

ix.plugin.SetUnloaded("observer", true)

CAMI.RegisterPrivilege({
	Name = "Helix - Observer",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Observer Extra ESP",
	MinAccess = "superadmin"
})

ix.option.Add("observerTeleportBack", ix.type.bool, true, {
	bNetworked = true,
	category = "observer",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
	end
})
ix.option.Add("observerESP", ix.type.bool, true, {
	category = "observer",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
	end
})
ix.option.Add("steamESP", ix.type.bool, true, {
	category = "observer",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
	end
})
ix.option.Add("mapscenesESP", ix.type.bool, false, {
	category = "observer",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
	end
})
ix.option.Add("alwaysObserverLight", ix.type.bool, true, {
    category = "observer",
    hidden = function()
        return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer")
    end,
	bNetworked = true
})
ix.option.Add("observerFullBright", ix.type.bool, false, {
    category = "observer",
    hidden = function()
        return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer")
    end,
	bNetworked = true
})

ix.option.Add("observerPlayerHighlight", ix.type.bool, true, {
	bNetworked = true,
	category = "observer",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
	end
})

ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")

ix.lang.AddTable("english", {
	optSteamESP = "Show Admin ESP Extra Info",
	optdSteamESP = "Shows a player's SteamID and their Health/Armor on the admin ESP",
	optMapscenesESP = "Show Map Scene ESP",
	optdMapscenesESP = "Show Map Scene locations in the admin ESP.",
	optAlwaysObserverLight = "Always Turn On Observer Light",
    optdAlwaysObserverLight = "Turn on your observer light automatically when entering observer. Otherwise it will follow your flashlight. Can still be turned off manually.",
	optObserverFullBright = "Observer Light Full Bright",
    optdObserverFullBright = "Light up the entire map when enabling the Observer Light.",
	optObserverPlayerHighlight = "Highlight Player",
	optdObserverPlayerHighlight = "Whether or not players get an aura highlighting their model"
})

ix.lang.AddTable("spanish", {
	optdSteamESP = "Muestra el SteamID de un jugador, su salud/armadura en el admin ESP",
	optdAlwaysObserverLight = "Enciende la luz del observer automáticamente al entrar en él. De lo contrario seguirá tu linterna. Se puede apagar manualmente.",
	optAlwaysObserverLight = "Encender siempre la luz del observer",
	optSteamESP = "Muestra la información extra del Admin ESP",
	optdMapscenesESP = "Mostrar las localizaciones de Escenarios del Mapa en el Admin-ESP.",
	optMapscenesESP = "Mostrar el ESP del Escenario"
})