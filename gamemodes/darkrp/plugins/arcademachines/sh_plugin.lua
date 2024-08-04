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

PLUGIN.name = "Arcade Machines"
PLUGIN.author = "The Dream Team, AleXXX_007 (Integration to IX)"
PLUGIN.description = "Adds 3 arcade machines"

ix.config.Add("arcadeDisableTokenSystem", false, "Simply set this to true and all games are free", nil, {
	category = "Machines d'Arcade"
})

ix.config.Add("arcadePacManWebsite", "http://0wain.xyz/pacman/", "La source du site web. Je suggère de la laisser telle quelle si vous ne la comprenez pas vraiment.", nil, {
	category = "Machines d'Arcade"
})

ix.config.Add("arcadePongWebsite", "http://kanocomputing.github.io/Pong.js/examples/player-vs-bot.html", "La source du site web. Je suggère de la laisser telle quelle si vous ne la comprenez pas vraiment.", nil, {
	category = "Machines d'Arcade"
})

ix.config.Add("arcadeSpaceWebsite", "http://funhtml5games.com/spaceinvaders/index.html", "La source du site web. Je suggère de la laisser telle quelle si vous ne la comprenez pas vraiment.", nil, {
	category = "Machines d'Arcade"
})

ix.config.Add("arcadePrice", 1, "Le prix pour jouer au jeu d'arcade", nil, {
	data = {min = 1, max = 1000},
	category = "Machines d'Arcade"
})

ix.config.Add("arcadeTime", 300, "Combien de temps il est possible de jouer pour 1 paiement (SECONDES)", nil, {
	data = {min = 60, max = 3600},
	category = "Machines d'Arcade"
})

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")
