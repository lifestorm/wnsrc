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

PLUGIN.name = "Anti-AFK"
PLUGIN.author = "Gr4Ss, M!NT"
PLUGIN.description = "Empêche les joueurs AFK de gagner des salaires et d'être kick lorsque le serveur est plein."
PLUGIN.license = [[
(c) 2020 by Willard Networks - WN:IX A unique HL2RP schema built by the WN team
Copyright Atko 2020 All Rights Reserved
]]
ix.afk = ix.afk or {}

ix.config.Add("afkTime", 300, "Le nombre de secondes qu'il faut pour qu'une personne soit signalée comme AFK.", nil, {
	data = {min = 120, max = 3600},
	category = "Anti-afk"
})

ix.lang.AddTable("english", {
    playerIsAFK = "Ce joueur est AFK",
    noAfk = "Personne n'est actuellement AFK.",
    currentAFK = "Joueurs AFK actuels :\n",
    afkFormat = "%s pour %.1fm\n",
})

ix.lang.AddTable("french", {
    playerIsAFK = "Ce joueur est AFK",
    noAfk = "Personne n'est actuellement AFK.",
    currentAFK = "Joueurs AFK actuels :\n",
    afkFormat = "%s pour %.1fm\n",
})

ix.lang.AddTable("spanish", {
	playerIsAFK = "Este jugador está AFK",
	currentAFK = "Jugadores AFK actuales:\n",
	afkFormat = "%s para %.1fm\n",
	noAfk = "Nadie está AFK ahora mismo."
})

ix.command.Add("PrintAFKPlayers", {
	description = "Désigne les joueurs actuellement AFK dans votre chat.",
	adminOnly = true,
	OnRun = function(self, client)
        local text = L("noAfk", client)
        local afkPlayers = {}
        for _, target in ipairs(player.GetAll()) do
            if (target:IsAFK()) then
                afkPlayers[#afkPlayers + 1] = target
            end
        end

        if (#afkPlayers > 0) then
            text = L("currentAFK", client)
            for _, target in pairs(afkPlayers) do
                text = text..string.format("%s pour %.1fm\n", target:GetName(), math.floor(target:GetNetVar("afkTime", 0) / 60))
            end
        end

        net.Start("ixPrintAfkPlayers")
            net.WriteString(text)
        net.Send(client)
	end
})

do
    local PLAYER = FindMetaTable("Player")

    function PLAYER:IsAFK()
        return self:GetNetVar("afkTime", 0) >= ix.config.Get("afkTime")
    end
end


ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_hooks.lua")
