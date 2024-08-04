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
	category = "Arcade Machines"
})

ix.config.Add("arcadePacManWebsite", "http://0wain.xyz/pacman/", "The website source. I suggest leaving it as is if you don't really understand this", nil, {
	category = "Arcade Machines"
})

ix.config.Add("arcadePongWebsite", "http://kanocomputing.github.io/Pong.js/examples/player-vs-bot.html", "The website source. I suggest leaving it as is if you don't really understand this", nil, {
	category = "Arcade Machines"
})

ix.config.Add("arcadeSpaceWebsite", "http://funhtml5games.com/spaceinvaders/index.html", "The website source. I suggest leaving it as is if you don't really understand this", nil, {
	category = "Arcade Machines"
})

ix.config.Add("arcadePrice", 1, "The price to play arcade game", nil, {
	data = {min = 1, max = 1000},
	category = "Arcade Machines"
})

ix.config.Add("arcadeTime", 300, "How long it is possible to play for 1 payment (SECONDS)", nil, {
	data = {min = 60, max = 3600},
	category = "Arcade Machines"
})

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")
