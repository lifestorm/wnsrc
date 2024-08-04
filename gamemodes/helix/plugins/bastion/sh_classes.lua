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
local Color = Color
local chat = chat
local string = string
local IsValid = IsValid
local LocalPlayer = LocalPlayer
local MsgC = MsgC
local CAMI = CAMI
local surface = surface
local team = team

-- luacheck: globals FACTION_SERVERADMIN


-- Roll information in chat.
ix.chat.Register("gmroll", {
	format = "** You have gm-rolled %s out of %s.",
	color = Color(155, 111, 176),
	CanHear = function(self, speaker, listener)
		return speaker == listener
	end,
	deadCanChat = true,
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		chat.AddText(self.color, string.format(self.format, text, data.max or 20))
	end
})

ix.chat.Register("localevent", {
	CanHear = (ix.config.Get("chatRange", 280) * 2),
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(255, 150, 0), text)
	end,
})

local broadcastIcon = ix.util.GetMaterial("willardnetworks/chat/broadcast_icon.png")

ix.chat.Register("localbroadcast", {
	CanHear = (ix.config.Get("chatRange", 280) * 2),
	CanSay = function(self, speaker, text)
		if (speaker:Team() != FACTION_ADMIN and !speaker:GetCharacter():GetInventory():HasItem("wireless_microphone")) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end,
	OnChatAdd = function(self, speaker, text)
		if (ix.option.Get("standardIconsEnabled")) then
			chat.AddText(broadcastIcon, Color(151, 161, 255), string.format("%s broadcasts locally \"%s\"", (speaker and speaker.Name and speaker:Name() or ""), text))
		else
			chat.AddText(Color(151, 161, 255), string.format("%s broadcasts locally \"%s\"", (speaker and speaker.Name and speaker:Name() or ""), text))
		end
	end
})

ix.chat.Register("localbroadcastme", {
	CanHear = (ix.config.Get("chatRange", 280) * 2),
	CanSay = function(self, speaker, text)
		if (speaker:Team() != FACTION_ADMIN and !speaker:GetCharacter():GetInventory():HasItem("wireless_microphone")) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end,
	OnChatAdd = function(self, speaker, text)
		if (ix.option.Get("standardIconsEnabled")) then
			chat.AddText(broadcastIcon, Color(151, 161, 255), string.format("*** %s %s", (speaker and speaker.Name and speaker:Name() or ""), text))
		else
			chat.AddText(Color(151, 161, 255), string.format("*** %s %s", (speaker and speaker.Name and speaker:Name() or ""), text))
		end
	end
})

ix.chat.Register("localbroadcastit", {
	CanHear = (ix.config.Get("chatRange", 280) * 2),
	CanSay = function(self, speaker, text)
		if (speaker:Team() != FACTION_ADMIN and !speaker:GetCharacter():GetInventory():HasItem("wireless_microphone")) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end,
	OnChatAdd = function(self, speaker, text)
		if (ix.option.Get("standardIconsEnabled")) then
			chat.AddText(broadcastIcon, Color(151, 161, 255), string.format("***' %s", text))
		else
			chat.AddText(Color(151, 161, 255), string.format("***' %s", text))
		end
	end
})

ix.chat.Register("announcement", {
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(254, 238, 60), "[ADMIN] ", text)
	end,
	CanSay = function(self, speaker, text)
		return true
	end
})

-- STAFF CHAT
do
	local CLASS = {}
	local icon = ix.util.GetMaterial("icon16/medal_gold_3.png")

	if (CLIENT) then
		function CLASS:OnChatAdd(speaker, text, anonymous, data)
			if (!IsValid(speaker)) then return end

			if (speaker != LocalPlayer() and !ix.option.Get("staffChat")) then
				local character = LocalPlayer():GetCharacter()
				if (character and character:GetFaction() != FACTION_SERVERADMIN) then
					MsgC(Color(255,215,0), "[Staff] ",
						Color(128, 0, 255, 255), speaker:Name(), " (", speaker:SteamName(), "): ",
						Color(255, 255, 255), text.."\n")
					 return
				end
			 end

			chat.AddText(icon, Color(255,215,0), "[Staff] ",
				Color(128, 0, 255, 255), speaker:Name(), " (", speaker:SteamName(), "): ",
				Color(255, 255, 255), text)
		end
	else
		function CLASS:CanHear(speaker, listener)
			return CAMI.PlayerHasAccess(listener, "Helix - Hear Staff Chat")
		end
	end

	ix.chat.Register("staff_chat", CLASS)
end

-- GM CHAT
do
	local CLASS = {}
	local icon = ix.util.GetMaterial("icon16/rosette.png")

	if (CLIENT) then
		function CLASS:OnChatAdd(speaker, text, anonymous, data)
			if (!IsValid(speaker)) then return end

			chat.AddText(icon, Color(142, 28, 255), "[GM] ", Color(255, 215, 0, 255), speaker:Name(), " (", speaker:SteamName(), "): ", Color(255, 255, 255), text)
		end
	else
		function CLASS:CanHear(speaker, listener)
			return CAMI.PlayerHasAccess(listener, "Helix - Hear GM Chat")
		end
	end

	ix.chat.Register("gm_chat", CLASS)
end

-- MENTOR CHAT
do
	local CLASS = {}
	local icon = ix.util.GetMaterial("icon16/user_suit.png")

	if (CLIENT) then
		function CLASS:OnChatAdd(speaker, text, anonymous, data)
			if (!IsValid(speaker)) then return end

			chat.AddText(icon, Color(66, 135, 245), "[Mentor] ", Color(66, 245, 191, 255), speaker:Name(), " (", speaker:SteamName(), "): ", Color(255, 255, 255), text)
		end
	else
		function CLASS:CanHear(speaker, listener)
			return CAMI.PlayerHasAccess(listener, "Helix - Hear Mentor Chat")
		end
	end

	ix.chat.Register("mentor_chat", CLASS)
end

-- ACHIEVEMENT
do
	local CLASS = {}

	if (CLIENT) then
		function CLASS:OnChatAdd(speaker, text, anonymous, data)
			if (!IsValid(data[1])) then return end

			if (data[2]) then
				surface.PlaySound(data[2])
			end

			local target = data[1]
			chat.AddText(team.GetColor(target:Team()), target:SteamName(), Color(255, 255, 255), " earned the achievement ",
			Color( 255, 201, 0, 255 ), text)
		end
	end

	ix.chat.Register("achievement_get", CLASS)
end
