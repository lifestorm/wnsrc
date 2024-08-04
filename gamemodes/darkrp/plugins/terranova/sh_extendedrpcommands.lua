--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--[[
	© 2020 TERRANOVA do not share, re-distribute or modify
	without permission of its author (zacharyenriquee@gmail.com).
--]]

ix.chat.Register("meL", {
	OnChatAdd = function(self, speaker, text, anonymous)
		if (!IsValid(speaker)) then
			return
		end
		local name = anonymous and
		L"someone" or hook.Run("GetCharacterName", speaker, "me") or
		(IsValid(speaker) and speaker:Name() or "Console")

		local chatColor = ix.config.Get("chatColor")
		chatColor = Color(chatColor.r + 35, chatColor.g + 35, chatColor.b + 35)

		chat.AddText(chatColor, "**** ", name, " ", text)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 4,
	prefix = {"/MeL", "/ActionL"},
	description = "Effectuer une action physique bruyament.",
	indicator = "chatPerforming",
	CanSay = function(self, speaker, text)
		if (!speaker:Alive() and speaker.lastMeExpended) then
			speaker:NotifyLocalized("noPerm")

			return false
		end
	end
})

ix.chat.Register("meC", {
	OnChatAdd = function(self, speaker, text, anonymous)
		if (!IsValid(speaker)) then
			return
		end

		local name = anonymous and
		L"someone" or hook.Run("GetCharacterName", speaker, "me") or
		(IsValid(speaker) and speaker:Name() or "Console")

		local chatColor = ix.config.Get("chatColor")
		chatColor = Color(chatColor.r - 35, chatColor.g - 35, chatColor.b - 35)

		chat.AddText(chatColor, "* ", name, " ", text)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 0.25,
	prefix = {"/MeC", "/ActionC"},
	description = "Effectuer une action physique discretement.",
	indicator = "chatPerforming",
	CanSay = function(self, speaker, text)
		if (!speaker:Alive() and speaker.lastMeExpended) then
			speaker:NotifyLocalized("noPerm")

			return false
		end
	end
})

ix.chat.Register("meD", {
	OnChatAdd = function(self, speaker, text, anonymous)
		if (!IsValid(speaker)) then
			return
		end

		local name = anonymous and
		L"someone" or hook.Run("GetCharacterName", speaker, "me") or
		(IsValid(speaker) and speaker:Name() or "Console")

		local chatColor = ix.config.Get("chatColor")
		chat.AddText(chatColor, "** ", name, " ", text)
	end,
	deadCanChat = true
})

ix.command.Add("MeD", {
	description = "Envoyez un /me directement à la personne que vous regardez.",
	alias = "ActionD",
	arguments = ix.type.text,
	OnCheckAccess = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		if (!IsValid(trace.Entity) or !trace.Entity:IsPlayer()) then return false end

		return true
	end,
	OnRun = function(self, client, text)
		ix.chat.Send(client, "meD", text, nil, {client, client:GetEyeTraceNoCursor().Entity})
	end
})


ix.chat.Register("itL", {
	GetColor = function(self, speaker, text)
		local color = ix.config.Get("chatColor")

		return Color(color.r + 35, color.g + 35, color.b + 35)
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(ix.config.Get("chatColor"), "****' "..text)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 4,
	prefix = {"/ItL"},
	description = "Faites quelque chose autour de vous pour effectuer une action bruyament.",
	indicator = "chatPerforming",
	deadCanChat = true
})

ix.chat.Register("itC", {
	GetColor = function(self, speaker, text)
		local color = ix.config.Get("chatColor")

		return Color(color.r - 35, color.g - 35, color.b - 35)
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(ix.config.Get("chatColor"), "*' "..text)
	end,
	CanHear = ix.config.Get("chatRange", 280) * 0.25,
	prefix = {"/ItC"},
	description = "Faites quelque chose autour de vous pour effectuer une action discretement.",
	indicator = "chatPerforming",
	deadCanChat = true
})

ix.chat.Register("itD", {
	OnChatAdd = function(self, speaker, text, anonymous)
		local chatColor = ix.config.Get("chatColor")
		chat.AddText(chatColor, "**' "..text)
	end,
	deadCanChat = true
})

ix.command.Add("ItD", {
	description = "Envoyez un /it directement à la personne que vous regardez (et à personne d'autre).",
	arguments = ix.type.text,
	OnCheckAccess = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		if (!IsValid(trace.Entity) or !trace.Entity:IsPlayer()) then return false end

		return true
	end,
	OnRun = function(self, client, text)
		ix.chat.Send(client, "itD", text, nil, {client, client:GetEyeTraceNoCursor().Entity})
	end
})

if (CLIENT) then
	CHAT_RECOGNIZED = CHAT_RECOGNIZED or {}
	CHAT_RECOGNIZED["itC"] = true
	CHAT_RECOGNIZED["itL"] = true
	CHAT_RECOGNIZED["itD"] = true
	CHAT_RECOGNIZED["meC"] = true
	CHAT_RECOGNIZED["meL"] = true
	CHAT_RECOGNIZED["meD"] = true
end
