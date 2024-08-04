--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Faction Chats"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Adds a OOC chats for specific factions."

ix.lang.AddTable("english", {
	dispOnlyChat = "Prywatny czat dowódzctwa Dispatch. Widzą go tylko inne Dispatch, skanery, i OTA.",
	cmbOnlyChat = "Prywatny czat Kombinatu. Widzą go tylko inne jednostki Kombinatu.",
	cpOnlyChat = "Prywatny czat CP. Widzą go tylko inne jednostki CP.",
	cwuOnlyChat = "Prywatny czat CWU. Widzą go tylko inni członkowie Civil Workers Union.",
	conOnlyChat = "Prywatny czat Konskryptó. Widzą go tylko inni Konskrypci."
})

ix.lang.AddTable("spanish", {
	dispOnlyChat = "Chat de comando de Dispatch, solo otros dispatch, escáneres y OTA escucharán esto."
})

ix.lang.AddTable("polish", {
	dispOnlyChat = "Prywatny czat dowódzctwa Dispatch. Widzą go tylko inne Dispatch, skanery, i OTA.",
	cmbOnlyChat = "Prywatny czat Kombinatu. Widzą go tylko inne jednostki Kombinatu.",
	cpOnlyChat = "Prywatny czat CP. Widzą go tylko inne jednostki CP.",
	cwuOnlyChat = "Prywatny czat CWU. Widzą go tylko inni członkowie Civil Workers Union.",
	conOnlyChat = "Prywatny czat Konskryptó. Widzą go tylko inni Konskrypci."
})

do
	ix.chat.Register("cp_chat", {
		CanSay = function(self, speaker, text)
			if (!speaker:IsDispatch() and !speaker:IsCP() and !speaker:Team() == FACTION_SERVERADMIN) then
				speaker:NotifyLocalized("notAllowed")

				return false
			else
				local delay = ix.config.Get("cpOocDelay", 10)

				if (delay > 0 and speaker.ixLastCPOOC) then
					local lastOOC = CurTime() - speaker.ixLastCPOOC

					if (lastOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
						speaker:Notify("Musisz poczekać jeszcze " .. delay - math.ceil(lastOOC) .. "s przed ponownym użyciem czatu OOC CP!")

						return false
					end
				end

				speaker.ixLastCPOOC = CurTime()
			end
		end,
		CanHear = function(self, speaker, listener)
			return listener:IsDispatch() or listener:IsCP() or listener:Team() == FACTION_SERVERADMIN or listener:Team() == FACTION_MCP
		end,
		OnChatAdd = function(self, speaker, text)
			if !speaker or speaker and !IsValid(speaker) then return end
			chat.AddText(Color(255, 200, 50, 255), "@cp ", team.GetColor(speaker:Team()), (speaker:Name() or "") .. " ", Color(150, 200, 150, 255), text)
		end
	})

	ix.command.Add("CP", {
		description = "@cpOnlyChat",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			if (ix.config.Get("allowCpOOC", true) or client:IsAdmin()) then
				ix.chat.Send(client, "cp_chat", message)
			else
				client:Notify("Czat OOC CP jest obecnie wyłączony!")
			end
		end,
		OnCheckAccess = function(self, client)
			return client:IsDispatch() or client:IsCP() or client:Team() == FACTION_SERVERADMIN or client:Team() == FACTION_MCP
		end
	})

	ix.config.Add("allowCpOOC", true, "Whether or not CPs can use the OOC CP chat.", nil, {
		category = "Chat"
	})

	ix.config.Add("cpOocDelay", 10, "The delay before a player can use the CP OOC chat again in seconds", nil, {
		data = {min = 0, max = 60},
		category = "Chat"
	})

	ix.chat.Register("cmb_chat", {
		CanSay = function(self, speaker, text)
			if (!speaker:IsCombine() and !speaker:Team() == FACTION_SERVERADMIN) then
				speaker:NotifyLocalized("notAllowed")

				return false
			else
				local delay = ix.config.Get("combineOocDelay", 10)

				if (delay > 0 and speaker.ixLastCombineOOC) then
					local lastOOC = CurTime() - speaker.ixLastCombineOOC

					if (lastOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
						speaker:Notify("Musisz poczekać jeszcze " .. delay - math.ceil(lastOOC) .. "s przed ponownym użyciem czatu OOC Kombinatu!")

						return false
					end
				end

				speaker.ixLastCombineOOC = CurTime()
			end
		end,
		CanHear = function(self, speaker, listener)
			return listener:IsCombine() or listener:Team() == FACTION_SERVERADMIN
		end,
		OnChatAdd = function(self, speaker, text)
			chat.AddText(Color(255, 200, 50, 255), "@combine ", team.GetColor(speaker:Team()), (speaker and speaker.Name and speaker:Name() or "") .. " ", Color(150, 200, 150, 255), text)
		end
	})

	ix.command.Add("CMB", {
		description = "@cmbOnlyChat",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			if (ix.config.Get("allowCombineOOC", true) or client:IsAdmin()) then
				ix.chat.Send(client, "cmb_chat", message)
			else
				client:Notify("Czat OOC Kombinatu jest obecnie wyłączony!")
			end
		end,
		OnCheckAccess = function(self, client)
			return client:IsCombine() or client:Team() == FACTION_SERVERADMIN
		end
	})

	ix.config.Add("allowCombineOOC", true, "Whether or not Combine can use the OOC Combine chat.", nil, {
		category = "Chat"
	})

	ix.config.Add("combineOocDelay", 10, "The delay before a player can use the Combine OOC chat again in seconds", nil, {
		data = {min = 0, max = 60},
		category = "Chat"
	})

	ix.chat.Register("con_chat", {
		CanSay = function(self, speaker, text)
			if (speaker:Team() != FACTION_CCR and !speaker:Team() == FACTION_SERVERADMIN) then
				speaker:NotifyLocalized("notAllowed")

				return false
			else
				local delay = ix.config.Get("conscriptOocDelay", 10)

				if (delay > 0 and speaker.ixLastCONOOC) then
					local lastOOC = CurTime() - speaker.ixLastCONOOC

					if (lastOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
						speaker:Notify("Musisz poczekać jeszcze " .. delay - math.ceil(lastOOC) .. "s przed ponownym użyciem czatu OOC Konskryptów!")

						return false
					end
				end

				speaker.ixLastCONOOC = CurTime()
			end
		end,
		CanHear = function(self, speaker, listener)
			return listener:Team() == FACTION_CCR or listener:Team() == FACTION_SERVERADMIN
		end,
		OnChatAdd = function(self, speaker, text)
			if !speaker or speaker and !IsValid(speaker) then return end

			chat.AddText(Color(255, 200, 50, 255), "@con ", team.GetColor(speaker:Team()), (speaker:Name() or "") .. " ", Color(150, 200, 150, 255), text)
		end
	})

	ix.command.Add("CON", {
		description = "@conOnlyChat",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			if (ix.config.Get("allowConscriptOOC", true) or client:IsAdmin()) then
				ix.chat.Send(client, "con_chat", message)
			else
				client:Notify("Czat OOC Konskryptów jest obecnie wyłączony!")
			end
		end,
		OnCheckAccess = function(self, client)
			return client:Team() == FACTION_CCR or client:Team() == FACTION_SERVERADMIN
		end
	})

	ix.config.Add("allowConscriptOOC", true, "Whether or not Combine can use the OOC Conscript chat.", nil, {
		category = "Chat"
	})

	ix.config.Add("conscriptOocDelay", 10, "The delay before a player can use the Conscript OOC chat again in seconds", nil, {
		data = {min = 0, max = 60},
		category = "Chat"
	})

	ix.chat.Register("cwu_chat", {
		CanSay = function(self, speaker, text)
			if (speaker:Team() != FACTION_WORKERS and !speaker:Team() == FACTION_SERVERADMIN) then
				speaker:NotifyLocalized("notAllowed")

				return false
			else
				local delay = ix.config.Get("cwuOocDelay", 10)

				if (delay > 0 and speaker.ixLastCWUOOC) then
					local lastOOC = CurTime() - speaker.ixLastCWUOOC

					if (lastOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
						speaker:Notify("Musisz poczekać jeszcze " .. delay - math.ceil(lastOOC) .. "s przed ponownym użyciem czatu OOC CWU!")

						return false
					end
				end

				speaker.ixLastCWUOOC = CurTime()
			end
		end,
		CanHear = function(self, speaker, listener)
			return listener:Team() == FACTION_WORKERS or listener:Team() == FACTION_SERVERADMIN
		end,
		OnChatAdd = function(self, speaker, text)
			if !speaker or speaker and !IsValid(speaker) then return end

			chat.AddText(Color(255, 200, 50, 255), "@cwu ", team.GetColor(speaker:Team()), (speaker:Name() or "") .. " ", Color(150, 200, 150, 255), text)
		end
	})

	ix.command.Add("CWU", {
		description = "@cwuOnlyChat",
		arguments = ix.type.text,
		OnRun = function(self, client, message)
			if (ix.config.Get("allowCwuOOC", true) or client:IsAdmin()) then
				ix.chat.Send(client, "cwu_chat", message)
			else
				client:Notify("Czat OOC CWU jest obecnie wyłączony!")
			end
		end,
		OnCheckAccess = function(self, client)
			return client:Team() == FACTION_WORKERS or client:Team() == FACTION_SERVERADMIN
		end
	})

	ix.config.Add("allowCwuOOC", true, "Whether or not CWU can use the OOC CWU chat.", nil, {
		category = "Chat"
	})

	ix.config.Add("cwuOocDelay", 10, "The delay before a player can use the CWU OOC chat again in seconds", nil, {
		data = {min = 0, max = 60},
		category = "Chat"
	})
end
