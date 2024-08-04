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

function Schema:RegisterGroups(plugin)
	if (SERVER) then
		-- Whitelists cannot be given manually, and will be removed upon group update if necessary
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_OTA)
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_BIRD)
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_SERVERADMIN)
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_EVENT)
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_VORT)
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_ADMIN)
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_HEADCRAB)
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_CP)
		ix.xenforo:RegisterRestrictedWhitelist(FACTION_RESISTANCE)
	end

	plugin:RegisterForumGroup("OTA", "28", {
		whitelists = {[FACTION_OTA] = true},
	})
	plugin:RegisterForumGroup("Vortigaunt", "33", {
		whitelists = {[FACTION_VORT] = true},
	})
	plugin:RegisterForumGroup("CCA", "35", {
		whitelists = {[FACTION_ADMIN] = true},
	})
	plugin:RegisterForumGroup("Event", "38", {
		whitelists = {[FACTION_EVENT] = true},
	})
	plugin:RegisterForumGroup("CP", "69", {
		whitelists = {[FACTION_CP] = true},
	})
	plugin:RegisterForumGroup("Rebel", "79", {
		whitelists = {[FACTION_RESISTANCE] = true},
	})
	--[[
		NOTE: only the highest priority group gets set as the primary group in SAM.
		All other groups still have their permissions applied, but will not show via PLAYER:GetUserGroup()
		You can check for all user groups, including inheritence, via PLAYER:CheckGroup()
	--]]
	local donationFlags = "pet"
	local donatorFactions = {[FACTION_BIRD] = true, [FACTION_HEADCRAB] = true}
	plugin:RegisterForumGroup("Premium 1", "17", {
		camiGroup = "premium1",
		flags = donationFlags,
		premiumTier = 1,
		whitelists = donatorFactions,
	})
	plugin:RegisterForumGroup("Premium 2", "23", {
		camiGroup = "premium2",
		inherits = "premium1",
		flags = donationFlags,
		premiumTier = 2,
		whitelists = donatorFactions,
	})
	plugin:RegisterForumGroup("Premium 3", "16", {
		camiGroup = "premium3",
		inherits = "premium2",
		flags = donationFlags,
		premiumTier = 3,
		whitelists = donatorFactions,
	})

	plugin:RegisterForumGroup("Developer", "13", {
		camiGroup = "developer",
		priority = 7,
		flags = "petcCrn",
	})

	local gmFlags = "petrcn"

	plugin:RegisterForumGroup("Gamemaster (Inactive)", "41", {
		camiGroup = "gamemaster_inactive",
		flags = gmFlags,
		whitelists = {[FACTION_SERVERADMIN] = true, [FACTION_EVENT] = true},
	})
	plugin:RegisterForumGroup("Gamemaster (Active)", "gamemaster_active", {
		camiGroup = "gamemaster",
		priority = 9,
	})

	plugin:RegisterForumGroup("Mentor (Inactive)", "42", {
		camiGroup = "mentor_inactive",
		flags = "petcr",
	})
	plugin:RegisterForumGroup("Mentor (Active)", "mentor_active", {
		camiGroup = "mentor",
		inherits = "admin",
		priority = 15,
	})

	local adminFactions = {[FACTION_SERVERADMIN] = true, [FACTION_EVENT] = true, [FACTION_HEADCRAB] = true}
	local adminFlags = "petcCrna"
	plugin:RegisterForumGroup("Trial Admin", "11", {
		camiGroup = "trial_admin",
		inherits = "admin",
		priority = 20,
		flags = adminFlags,
		whitelists = adminFactions,
	})
	plugin:RegisterForumGroup("Server Admin", "4", {
		camiGroup = "server_admin",
		inherits = "trial_admin",
		priority = 21,
		flags = adminFlags,
		whitelists = adminFactions,
	})
	plugin:RegisterForumGroup("HOSA", "43", {
		camiGroup = "head_of_staff",
		inherits = "server_admin",
		priority = 22,
		flags = adminFlags,
		whitelists = adminFactions,
	})
	plugin:RegisterForumGroup("Head Of Staff", "29", {
		camiGroup = "head_of_staff",
		inherits = "server_admin",
		priority = 23,
		flags = adminFlags,
		whitelists = adminFactions,
	})
	plugin:RegisterForumGroup("Server Council", "74", {
		camiGroup = "server_council",
		inherits = "head_of_staff",
		priority = 24,
		flags = adminFlags,
		whitelists = adminFactions,
	})
	plugin:RegisterForumGroup("Willard Management", "10", {
		camiGroup = "willard_management",
		inherits = "server_council",
		priority = 25,
		flags = adminFlags,
		whitelists = adminFactions,
	})
end