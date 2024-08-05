--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Dispatch Chat"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Adds a dispatch radio and dispatch command chat."

ix.lang.AddTable("english", {
	dispOnlyChat = "Dispatch command chat, only other dispatches, scanners and OTA will hear this.",
	dispAllCombine = "Broadcast important messages to all Combine units, including Civil Protection."
})

ix.lang.AddTable("spanish", {
	dispAllCombine = "Transmite mensajes importantes a todas las unidades de la Alianza, incluido Protección Civil.",
	dispOnlyChat = "Chat de comando de Dispatch, solo otros dispatch, escáneres y OTA escucharán esto."
})

do
	ix.chat.Register("dispatch_chat", {
		CanSay = function(self, speaker, text)
			if (!speaker:IsDispatch() and !speaker:IsOTA() and speaker:Team() != FACTION_SERVERADMIN) then
				speaker:NotifyLocalized("notAllowed")

				return false
			else
				local delay = ix.config.Get("dispatchOocDelay", 10)

				if (delay > 0 and speaker.ixLastDispatchOOC) then
					local lastOOC = CurTime() - speaker.ixLastDispatchOOC

					if (lastOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
						speaker:Notify("You must wait " .. delay - math.ceil(lastOOC) .. " more seconds before using Dispatch OOC again!")

						return false
					end
				end

				speaker.ixLastDispatchOOC = CurTime()
			end
		end,
		CanHear = function(self, speaker, listener)
			return listener:IsDispatch() or listener:IsOTA() or listener:Team() == FACTION_SERVERADMIN
		end,
		OnChatAdd = function(self, speaker, text)
			chat.AddText(Color(255, 200, 50, 255), "@dispatch ", team.GetColor(speaker:Team()), (speaker and speaker.Name and speaker:Name() or "") .. " ", Color(150, 200, 150, 255), text)
		end
	})

	ix.command.Add("D", {
		description = "@dispOnlyChat",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			if (ix.config.Get("allowDispatchOOC", true) or client:IsAdmin()) then
				ix.chat.Send(client, "dispatch_chat", message)
			else
				client:Notify("The Dispatch OOC chat is currently disabled!")
			end
		end,
		OnCheckAccess = function(self, client)
			return client:IsDispatch() or client:IsOTA() or client:Team() == FACTION_SERVERADMIN
		end
	})

	ix.config.Add("allowDispatchOOC", true, "Whether or not Dispatchers/OTA can use the OOC Dispatch chat.", nil, {
		category = "Chat"
	})

	ix.config.Add("dispatchOocDelay", 10, "The delay before a player can use the Dispatch OOC chat again in seconds", nil, {
		data = {min = 0, max = 60},
		category = "Chat"
	})
end

do
	local dispatchIcon = ix.util.GetMaterial("willardnetworks/chat/cp_radio_icon.png")
	ix.chat.Register("scanner_radio", {
		color = Color(81, 208, 231),
		CanSay = function(self, speaker, text)
			if (!speaker:IsDispatch() and speaker:Team() != FACTION_SERVERADMIN) then
				speaker:NotifyLocalized("notAllowed")

				return false
			end
		end,
		CanHear = function(self, speaker, listener)
			return ix.faction.Get(listener:Team()).isCombineFaction or listener:HasActiveCombineSuit() or listener:Team() == FACTION_SERVERADMIN
		end,
		OnChatAdd = function(self, speaker, text)
			local oldFont = self.font 
			local font = hook.Run("GetSpeakerFont", speaker)

			self.font = font

			local rText = string.format("[INTEL] Dispatch: \"%s\"", text)
			if (ix.option.Get("standardIconsEnabled")) then
				chat.AddText(dispatchIcon, self.color, rText)
			else
				chat.AddText(self.color, rText)
			end
			self.font = oldFont
		end
	})

	ix.command.Add("I", {
		description = "@dispAllCombine",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			ix.chat.Send(client, "scanner_radio", message)
		end,
		OnCheckAccess = function(self, client)
			return client:IsDispatch() or client:Team() == FACTION_SERVERADMIN
		end
	})
end

do
	local dispatchIcon = ix.util.GetMaterial("willardnetworks/chat/dispatch_icon.png")
	ix.chat.Register("dispatch_radio", {
		color = Color(200, 0, 0),
		CanSay = function(self, speaker, text)
			if (!speaker:IsDispatch() and !Schema:IsCombineRank(speaker:Name(), "Disp:AI") and !Schema:IsCombineRank(speaker:Name(), "OCIN") and speaker:Team() != FACTION_SERVERADMIN) then
				speaker:NotifyLocalized("notAllowed")

				return false
			end
		end,
		CanHear = function(self, speaker, listener)
			return ix.faction.Get(listener:Team()).isCombineFaction or listener:HasActiveCombineSuit() or listener:Team() == FACTION_SERVERADMIN
		end,
		OnChatAdd = function(self, speaker, text)
			local rText = string.format("[COMMAND] Dispatch: \"%s\"", text)
			local oldFont = self.font 
			local font = hook.Run("GetSpeakerFont", speaker)

			self.font = font

			if (ix.option.Get("standardIconsEnabled")) then
				chat.AddText(dispatchIcon, self.color, rText)
			else
				chat.AddText(self.color, rText)
			end
			self.font = oldFont
		end
	})

	ix.command.Add("C", {
		description = "@dispAllCombine",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			ix.chat.Send(client, "dispatch_radio", message)
		end,
		OnCheckAccess = function(self, client)
			return client:IsDispatch() and Schema:IsCombineRank(client:Name(), "Disp:AI") or Schema:IsCombineRank(client:Name(), "OCIN") or client:Team() == FACTION_SERVERADMIN
		end
	})
end

do
	local dispatchIcon = ix.util.GetMaterial("willardnetworks/chat/dispatch_icon.png")
	ix.chat.Register("overwatch_radio", {
		color = Color(200, 0, 0),
		CanSay = function(self, speaker, text)
			if (!speaker:IsDispatch() and !Schema:IsCombineRank(client:Name(), "OCIN")) then
				speaker:NotifyLocalized("notAllowed")

				return false
			end
		end,
		CanHear = function(self, speaker, listener)
			return ix.faction.Get(listener:Team()).isCombineFaction or listener:HasActiveCombineSuit()
		end,
		OnChatAdd = function(self, speaker, text)
			local rText = string.format("[COMMAND] Overwatch AI: \"%s\"", text)
			local oldFont = self.font 
			local font = hook.Run("GetSpeakerFont", speaker)

			self.font = font

			if (ix.option.Get("standardIconsEnabled")) then
				chat.AddText(dispatchIcon, self.color, rText)
			else
				chat.AddText(self.color, rText)
			end
			self.font = oldFont
		end
	})

	ix.command.Add("O", {
		description = "@overwatchAllCombine",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			ix.chat.Send(client, "overwatch_radio", message)
		end,
		OnCheckAccess = function(self, client)
			return client:IsDispatch() and Schema:IsCombineRank(client:Name(), "OCIN")
		end
	})
end

do
	local dispatchIcon = ix.util.GetMaterial("willardnetworks/chat/dispatch_icon.png")
	ix.chat.Register("dispatchcp_radio", {
		color = Color(200, 0, 0),
		CanSay = function(self, speaker, text)
			if (!speaker:IsDispatch() and !Schema:IsCombineRank(client:Name(), "Disp:AI") and !Schema:IsCombineRank(client:Name(), "OCIN")) then
				speaker:NotifyLocalized("notAllowed")

				return false
			end
		end,
		CanHear = function(self, speaker, listener)
			return ix.faction.Get(listener:Team()).isCombineFaction or listener:HasActiveCombineSuit() and listener:isCP()
		end,
		OnChatAdd = function(self, speaker, text)
			local rText = string.format("[COMMAND] Dispatch to CP: \"%s\"", text)
			local oldFont = self.font 
			local font = hook.Run("GetSpeakerFont", speaker)

			self.font = font

			if (ix.option.Get("standardIconsEnabled")) then
				chat.AddText(dispatchIcon, self.color, rText)
			else
				chat.AddText(self.color, rText)
			end
			self.font = oldFont
		end
	})

	ix.command.Add("CCP", {
		description = "@dispAllCombine",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			ix.chat.Send(client, "dispatchcp_radio", message)
		end,
		OnCheckAccess = function(self, client)
			return client:IsDispatch() and Schema:IsCombineRank(client:Name(), "Disp:AI") or Schema:IsCombineRank(client:Name(), "OCIN")
		end
	})
end

do
	local dispatchIcon = ix.util.GetMaterial("willardnetworks/chat/dispatch_icon.png")
	ix.chat.Register("dispatchota_radio", {
		color = Color(200, 0, 0),
		CanSay = function(self, speaker, text)
			if (!speaker:IsDispatch() and !Schema:IsCombineRank(client:Name(), "Disp:AI") and !Schema:IsCombineRank(client:Name(), "OCIN")) then
				speaker:NotifyLocalized("notAllowed")

				return false
			end
		end,
		CanHear = function(self, speaker, listener)
			return ix.faction.Get(listener:Team()).isCombineFaction or listener:HasActiveCombineSuit() and listener:IsOTA()
		end,
		OnChatAdd = function(self, speaker, text)
			local rText = string.format("[COMMAND] Dispatch to OTA: \"%s\"", text)
			local oldFont = self.font 
			local font = hook.Run("GetSpeakerFont", speaker)

			self.font = font

			if (ix.option.Get("standardIconsEnabled")) then
				chat.AddText(dispatchIcon, self.color, rText)
			else
				chat.AddText(self.color, rText)
			end
			self.font = oldFont
		end
	})

	ix.command.Add("COTA", {
		description = "@dispAllCombine",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			ix.chat.Send(client, "dispatchota_radio", message)
		end,
		OnCheckAccess = function(self, client)
			return client:IsDispatch() and Schema:IsCombineRank(client:Name(), "Disp:AI") or Schema:IsCombineRank(client:Name(), "OCIN")
		end
	})
end

do
	ix.chat.Register("ccg_chat", {
		CanSay = function(self, speaker, text)
			if (!speaker:IsDispatch() and !speaker:IsOTA() and speaker:Team() != FACTION_SERVERADMIN) then
				speaker:NotifyLocalized("notAllowed")

				return false
			else
				local delay = ix.config.Get("ccgOocDelay", 10)

				if (delay > 0 and speaker.ixLastCcgOOC) then
					local lastOOC = CurTime() - speaker.ixLastCcgOOC

					if (lastOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
						speaker:Notify("You must wait " .. delay - math.ceil(lastOOC) .. " more seconds before using CCG OOC again!")

						return false
					end
				end

				speaker.ixLastCcgOOC = CurTime()
			end
		end,
		CanHear = function(self, speaker, listener)
			return listener:IsDispatch() or listener:IsOTA() or listener:Team() == FACTION_SERVERADMIN
		end,
		OnChatAdd = function(self, speaker, text)
			chat.AddText(Color(255, 200, 50, 255), "@ccg ", team.GetColor(speaker:Team()), (speaker and speaker.Name and speaker:Name() or "") .. " ", Color(150, 200, 150, 255), text)
		end
	})

	ix.command.Add("CCG", {
		description = "@ccgOnlyChat",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			if (ix.config.Get("allowCcgOOC", true) or client:IsAdmin()) then
				ix.chat.Send(client, "ccg_chat", message)
			else
				client:Notify("The CCG OOC chat is currently disabled!")
			end
		end,
		OnCheckAccess = function(self, client)
			return client:IsDispatch() or client:IsOTA() or client:Team() == FACTION_SERVERADMIN
		end
	})

	ix.config.Add("allowCcgOOC", true, "Whether or not Dispatchers/OTA/CCG can use the OOC CCG chat.", nil, {
		category = "Chat"
	})

	ix.config.Add("ccgOocDelay", 10, "The delay before a player can use the CCG OOC chat again in seconds", nil, {
		data = {min = 0, max = 60},
		category = "Chat"
	})
end
