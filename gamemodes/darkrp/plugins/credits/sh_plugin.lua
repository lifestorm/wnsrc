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
local netstream = netstream
local pairs = pairs
local player = player


local PLUGIN = PLUGIN

PLUGIN.name = "Credits"
PLUGIN.author = "Fruity"
PLUGIN.description = "A custom credits plugin for event usage."
PLUGIN.creditsMembers = PLUGIN.creditsMembers or {}

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Event Credits",
	MinAccess = "admin"
})

ix.command.Add("EditCredits", {
	description = "Edit the event credits.",
	privilege = "Manage Event Credits",
	OnRun = function(self, client)
		netstream.Start(client, "EditEventCredits", PLUGIN.creditsMembers)
	end
})

ix.command.Add("EventIntro", {
	description = "Showcase the event intro.",
	privilege = "Manage Event Credits",
	OnRun = function(self, client)
		for _, v in pairs(player.GetAll()) do
			netstream.Start(v, "ShowcaseEventCredits", PLUGIN.creditsMembers)
		end
	end
})

ix.command.Add("EventCredits", {
	description = "Showcase the event credits.",
	privilege = "Manage Event Credits",
	OnRun = function(self, client)
		for _, v in pairs(player.GetAll()) do
			netstream.Start(v, "ShowcaseEventCredits", PLUGIN.creditsMembers, true)
		end
	end
})

ix.config.Add("eventCreditsImageW", 1, "The width of the event credits title image.", nil, {
	data = {min = 1, max = 3000},
	category = "Event Credits"
})

ix.config.Add("eventCreditsImageH", 1, "The height of the event credits title image.", nil, {
	data = {min = 1, max = 3000},
	category = "Event Credits"
})

ix.config.Add("eventCreditsImageURL", "URL", "The URL of the event credits title image.", nil, {
	category = "Event Credits"
})

ix.config.Add("eventCreditsImageShownTimer", 5, "The amount of time the title image is shown.", nil, {
	data = {min = 1, max = 10},
	category = "Event Credits"
})

ix.config.Add("eventCreditsSpeedOfRoller", 60, "The amount of time it takes for the credits to reach the top in seconds.", nil, {
	data = {min = 1, max = 1000},
	category = "Event Credits"
})