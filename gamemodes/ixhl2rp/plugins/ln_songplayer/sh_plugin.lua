--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Song Player"
PLUGIN.author = "'impulse, DevulTj, Erin & Aspect™"
PLUGIN.description = "Adds a Song Player, allowing to play videos from YouTube."

ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")

ix.lang.AddTable("english", {
	cmdPlaySong = "Odtwarza piosenkę z YouTube dla każdego gracza na serwerze.",
	cmdStopSong = "Zatrzymuje bieżący utwór YouTube.",
	songPlaying = "Rozpocząłeś odtwarzanie utworu.",
	songStopped = "Zatrzymałeś odtwarzanie utworu.",
	invalidURL = "Nie jest to prawidłowy adres URL filmu na YouTube!"
})

ix.lang.AddTable("polish", {
	cmdPlaySong = "Odtwarza piosenkę z YouTube dla każdego gracza na serwerze.",
	cmdStopSong = "Zatrzymuje bieżący utwór YouTube.",
	songPlaying = "Rozpocząłeś odtwarzanie utworu.",
	songStopped = "Zatrzymałeś odtwarzanie utworu.",
	invalidURL = "Nie jest to prawidłowy adres URL filmu na YouTube!"
})

do
	local COMMAND = {}
	COMMAND.description = "@cmdPlaySong"
	COMMAND.adminOnly = true

	COMMAND.arguments = {
		ix.type.string,
		bit.bor(ix.type.number, ix.type.optional),
		bit.bor(ix.type.number, ix.type.optional)
	}

	COMMAND.argumentNames = {
		"Song URL",
		"Start Time",
		"Radius"
	}

	function COMMAND:OnRun(client, url, time, radius)
		time = time or 0

		if (!string.find(url, "https://www.youtube.com/watch?v", 1, true) and !string.find(url, "https://youtu.be/", 1, true)) then
			return "@invalidURL"
		end

		if (radius) then
			local receivers = {}

			for _, player in pairs(ents.FindInSphere(client:GetPos(), radius)) do
				if (!IsValid(player) or !player:IsPlayer()) then continue end

				receivers[#receivers + 1] = player
			end

			net.Start("lnSongPlayerPlay")
			net.WriteString(url)
			net.WriteFloat(time)
			net.Send(receivers)
		else
			net.Start("lnSongPlayerPlay")
			net.WriteString(url)
			net.WriteFloat(time)
			net.Broadcast()
		end

		return "@songPlaying"
	end

	ix.command.Add("PlaySong", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.description = "@cmdStopSong"
	COMMAND.adminOnly = true

	function COMMAND:OnRun(client)
		net.Start("lnSongPlayerStop")
		net.Broadcast()

		return "@songStopped"
	end

	ix.command.Add("StopSong", COMMAND)
end
