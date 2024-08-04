--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN or {}

PLUGIN.name = "TempSpawns"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Adds temporary spawnpoints that are not saved, are easy to move around and can be used to gather players"

PLUGIN.tempspawns = PLUGIN.tempspawns or {}

CAMI.RegisterPrivilege({
	Name = "Helix - Manage TempSpawns",
	MinAccess = "admin"
})

ix.util.Include("sv_plugin.lua")

do
	ix.command.Add("TempspawnAdd", {
		description = "@cmdTemspawnAdd",
		privilege = "Manage TempSpawns",
		OnRun = function(self, client, color, text)
			local trace = client:GetEyeTraceNoCursor()
			PLUGIN:AddTempspawn(trace.HitPos + Vector(0, 0, 10))
		end
	})

	ix.command.Add("TempspawnRemove", {
		description = "@cmdTempspawnRemove",
		privilege = "Manage TempSpawns",
		arguments = {bit.bor(ix.type.bool, ix.type.optional)},
		argumentsNames = {"all"},
		OnRun = function(self, client, all)
			if (!all) then
				PLUGIN:RemoveTempspawn(client)
			else
				PLUGIN:RemoveTempspawns()
			end
		end
	})

	ix.command.Add("TempspawnAll", {
		description = "@cmdTempspawnAll",
		privilege = "Manage TempSpawns",
		OnRun = function(self, client)
			if (#PLUGIN.tempspawns == 0) then
				client:NotifyLocalized("tempspawnsNoSet")
			end

			PLUGIN:TempSpawnAll(client)
		end
	})
end

ix.lang.AddTable("english", {
	optTempspawnESP = "Włącz TempSpawn ESP",
	optdTempspawnESP = "Określa, czy tymczasowe spwany powinny być wyświetlane w ESP obserwatora.",
	tempSpawn = "TempSpawn",
	tempspawnsNoSet = "Nie ustawiono jeszcze tymczasowych punktów odrodzenia!",
	tempspawnsRemovedAll = "Usunąłeś wszystkie tymczasowe punkty odrodzenia!",
	tempspawnsNoNearLooking = "Nie ma żadnych tempspawnów w pobliżu miejsca, w którym patrzysz!",
	tempspawnsRespawnOne = "Odrodziłeś 1 gracza.",
	tempspawnsRespawnNumber = "Odrodziłeś %d graczy.",
	cmdTempspawnAll = "Teleportuje wszystkich żywych graczy do tymczasowego miejsca odrodzenia.",
	cmdTempspawnRemove = "Usuń jeden lub wszystkie tymczasowe punkty odrodzenia w pobliżu miejsca, na które patrzysz.",
	cmdTemspawnAdd = "Dodaj tymczasowy punkt odrodzenia tam, gdzie się patrzysz."
})

ix.lang.AddTable("spanish", {
	cmdTempspawnRemove = "Quita un spawn temporal cerca de donde estés mirando o quita todo los spawns temporales.",
	cmdTempspawnAll = "Teletransporta a todos los jugadores vivos a un spawn temporal.",
	cmdTemspawnAdd = "Añade un spawn temporal en donde estás mirando.",
	tempspawnsNoSet = "¡Aún no se han establecido los spawns temporales!",
	tempspawnsRespawnNumber = "Has resucitado a %d jugadores.",
	tempspawnsRespawnOne = "Has resucitado a 1 jugador.",
	tempspawnsRemovedAll = "¡Has eliminado todo los spawns temporales!",
	optTempspawnESP = "Activar TempSpawn ESP",
	tempSpawn = "TempSpawn",
	tempspawnsNoNearLooking = "¡No hay tempspawns cerca de donde estás mirando!"
})

ix.lang.AddTable("polish", {
	optTempspawnESP = "Włącz TempSpawn ESP",
	optdTempspawnESP = "Określa, czy tymczasowe spwany powinny być wyświetlane w ESP obserwatora.",
	tempSpawn = "TempSpawn",
	tempspawnsNoSet = "Nie ustawiono jeszcze tymczasowych punktów odrodzenia!",
	tempspawnsRemovedAll = "Usunąłeś wszystkie tymczasowe punkty odrodzenia!",
	tempspawnsNoNearLooking = "Nie ma żadnych tempspawnów w pobliżu miejsca, w którym patrzysz!",
	tempspawnsRespawnOne = "Odrodziłeś 1 gracza.",
	tempspawnsRespawnNumber = "Odrodziłeś %d graczy.",
	cmdTempspawnAll = "Teleportuje wszystkich żywych graczy do tymczasowego miejsca odrodzenia.",
	cmdTempspawnRemove = "Usuń jeden lub wszystkie tymczasowe punkty odrodzenia w pobliżu miejsca, na które patrzysz.",
	cmdTemspawnAdd = "Dodaj tymczasowy punkt odrodzenia tam, gdzie się patrzysz."
})

if (CLIENT) then
	ix.option.Add("tempspawnESP", ix.type.bool, true, {
		category = "observer",
		hidden = function()
			return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
		end
	})

	function PLUGIN:DrawPointESP(points)
		local text = L("tempSpawn")
		if (ix.option.Get("tempspawnESP")) then
			for _, v in ipairs(self.tempspawns) do
				points[#points + 1] = {v,  text}
			end
		end
	end

	net.Receive("TempspawnsData", function(len)
		PLUGIN.tempspawns = {}
		local max = net.ReadUInt(16)
		for _ = 1, max do
			PLUGIN.tempspawns[#PLUGIN.tempspawns + 1] = net.ReadVector()
		end
	end)
end
