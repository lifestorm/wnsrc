--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local bit = bit
local IsValid = IsValid
local pairs = pairs
local table = table
local L = L
local netstream = netstream
local Entity = Entity
local print = print
local math = math
local tostring = tostring
local CAMI = CAMI
local Vector = Vector
local game = game
local RunConsoleCommand = RunConsoleCommand
local net = net
local player = player
local ipairs = ipairs
local ents = ents
local string = string
local timer = timer
local ix = ix

local PLUGIN = PLUGIN

--Links
ix.command.Add("Discord", {
	description = "Get a link to the Discord Server",
	privilege = "Basic Commands",
	OnRun = function(self, client)
		net.Start("ixOpenURL")
			net.WriteString(ix.config.Get("DiscordLink"))
		net.Send(client)
	end,
	bNoIndicator = true
})
ix.command.Add("Content", {
	description = "Get a link to theWorkshop Content Pack",
	privilege = "Basic Commands",
	OnRun = function(self, client)
		net.Start("ixOpenURL")
			net.WriteString(ix.config.Get("ContentLink"))
		net.Send(client)
	end
})
ix.command.Add("Forum", {
	description = "Get a link to the Forums",
	privilege = "Basic Commands",
	OnRun = function(self, client)
		net.Start("ixOpenURL")
			net.WriteString(ix.config.Get("ForumLink"))
		net.Send(client)
	end,
	bNoIndicator = true
})

--Basic Admin
ix.command.Add("PGI", {
	description = "Get someone's basic information and copy their SteamID.",
	arguments = {
		bit.bor(ix.type.player, ix.type.optional)
	},
	--alias = "PlyGetInfo",
	privilege = "Basic Admin Commands",
	OnRun = function(self, client, target)
		if (!target) then
			target = client:GetEyeTraceNoCursor().Entity
		end

		if (!IsValid(target) or !target:IsPlayer()) then
			client:NotifyLocalized("bastionPGIInvalidTarget")
			return
		end

		net.Start("ixPlayerInfo")
			net.WriteEntity(target)
		net.Send(client)
	end,
	bNoIndicator = true
})

ix.command.Add("PrintStaffList", {
	alias = "PSL",
	description = "Print a list of staff members online.",
	OnRun = function(self, client)
		local staff = {}
		local bFound = false
		for _, v in ipairs(player.GetAll()) do
			local incognitoSetting = ix.option.Get(v, "iconIncognitoMode", false)
			local iconIncognitoMode = !client:IsAdmin() and !client:IsSuperAdmin() and incognitoSetting
			if (v:IsAdmin() or v:IsSuperAdmin()) and !iconIncognitoMode then
				local userGroup = v:GetUserGroup()
				staff[userGroup] = staff[userGroup] or {}
				staff[userGroup][#staff[userGroup] + 1] = v
				bFound = true
			end
		end

		local toSend = {}
		for k, v in pairs(staff) do
			toSend[#toSend + 1] = {name = k, players = v}
		end
		table.SortByMember(toSend, "name", true)

		if (bFound) then
			net.Start("ixStaffList")
				net.WriteUInt(#toSend, 8)
				for _, v in ipairs(toSend) do
					net.WriteString(v.name)
					net.WriteUInt(#v.players, 8)
					for i = 1, #v.players do
						net.WriteEntity(v.players[i])
					end
				end
			net.Send(client)
		else
			client:Notify("There are no staff online currently.")
		end
	end,
	bNoIndicator = true
})

ix.command.Add("PrintFactionList", {
	alias = "PFL",
	description = "Print a list of members of a faction currently online (including on another character).",
	arguments = {
		ix.type.string
	},
	privilege = "Basic Admin Commands",
	OnRun = function(self, client, name)
		if (name == "") then
			return "@invalidArg", 2
		end

		local faction = ix.faction.teams[name]

		if (!faction) then
			for _, v in ipairs(ix.faction.indices) do
				if (ix.util.StringMatches(L(v.name, client), name) or ix.util.StringMatches(v.uniqueID, name)) then
					faction = v

					break
				end
			end
		end

		if (faction) then
			local players = {}
			for _, v in ipairs(player.GetAll()) do
				if (v:HasWhitelist(faction.index)) then
					players[#players + 1] = v
				end
			end
			net.Start("ixStaffList")
				net.WriteUInt(1, 8)
				net.WriteString(faction.name)
				net.WriteUInt(#players, 8)
				for i = 1, #players do
					net.WriteEntity(players[i])
				end
			net.Send(client)
		else
			return "@invalidFaction"
		end
	end,
	bNoIndicator = true
})

ix.command.Add("PlaySound", {
	description = "Play a sound for all players (when no range is given) or those near you.",
	arguments = {
		ix.type.string,
		bit.bor(ix.type.number, ix.type.optional)
	},
	privilege = "Basic Admin Commands",
	OnRun = function(self, client, sound, range)
		local targets = range and {} or player.GetAll()
		if (range) then
			range = range * range
			local clientPos = client:EyePos()
			for _, target in ipairs(player.GetAll()) do
				if (target:EyePos():DistToSqr(clientPos) < range) then
					targets[#targets + 1] = target
				end
			end
		end

		net.Start("ixPlaySound")
			net.WriteString(PLUGIN.soundAlias[sound] or sound)
		net.Send(targets)
	end,
	indicator = "chatPerforming"
})

ix.command.Add("ScreenShake", {
	description = "Shakes the screen of everyone in the specified range. Specify the amplitude, the frequency and the radius for it to work.",
	arguments = {
		ix.type.number,
		ix.type.number,
		ix.type.number,
		ix.type.number
	},
	argumentNames = {"time(seconds)", "amplitude", "frequency", "radius"},
	privilege = "Basic Admin Commands",
	OnRun = function(self, client, seconds, strength, frequency, radius)
		local vector = client:GetPos() 
		util.ScreenShake(vector, strength or 5, frequency or 5, seconds, radius, true)
	end,
	indicator = "chatPerforming"
})

ix.command.Add("PlaySoundGlobal", {
	description = "Play a sound for all players.",
	arguments = {
		ix.type.string,
	},
	privilege = "Basic Admin Commands",
	OnRun = function(self, client, sound)
		net.Start("ixPlaySound")
			net.WriteString(PLUGIN.soundAlias[sound] or sound)
			net.WriteBool(true)
		net.Send(player.GetAll())
	end,
	indicator = "chatPerforming"
})

ix.command.Add("ShowEdicts", {
	description = "Returns the amount of networked entities currently on the server.",
	privilege = "Basic Admin Commands",
	OnRun = function(self, client)
		local edictsCount = ents.GetEdictCount()
		local edictsLeft = 8192 - edictsCount

		return string.format("There are currently %s edicts on the server. You can have up to %s more.", edictsCount, edictsLeft)
	end,
	bNoIndicator = true
})

ix.command.Add("ShowEntsInRadius", {
	description = "Shows a list of entities within a given radius.",
	privilege = "Basic Admin Commands",
	arguments = {ix.type.number},
	OnRun = function(self, client, radius)
		local entities = {}
		local pos = client:GetPos()
		for _, v in pairs(ents.FindInSphere(pos, radius)) do
			if (!IsValid(v)) then continue end
			entities[#entities + 1] = table.concat({v:EntIndex(), v:GetClass(), v:GetModel() or "no model", v:GetPos():Distance(pos), v:MapCreationID()}, ", ")
		end
		netstream.Start(client, "ixShowEntsInRadius", table.concat(entities,"\n"))
		client:NotifyLocalized("entsPrintedInConsole")
	end,
	bNoIndicator = true,
})

ix.command.Add("RemoveEntityByID", {
	description = "Shows a list of entities within a given radius.",
	superAdminOnly = true,
	arguments = {ix.type.number},
	OnRun = function(self, client, number)
		local entity = Entity(number)
		if (IsValid(entity)) then
			client:NotifyLocalized("entityRemoved", number, entity:GetClass())
			entity:Remove()
		else
			client:NotifyLocalized("entityNotFound", number)
		end
	end,
	bNoIndicator = true,
})

if (CLIENT) then
	netstream.Hook("ixShowEntsInRadius", function(text)
		print(text)
	end)
end

ix.command.Add("LocalEvent", {
	description = "@cmdLocalEvent",
	privilege = "Event",
	arguments = {
		ix.type.string,
		bit.bor(ix.type.number, ix.type.optional)
	},
	OnRun = function(self, client, event, range)
		local _range = range or (ix.config.Get("chatRange", 280) * 2)

		ix.chat.classes.localevent.range = _range * _range

		local doubleCommand = false

		-- This could probably be done a bit smarter but I'm sure it'll do.
		if (string.Left(string.lower(event), 11) == "/localevent") then
			doubleCommand = true

			event = string.Right(event, #event - 12)
		elseif (string.Left(string.lower(event), 10) == "localevent") then
			doubleCommand = true

			event = string.Right(event, #event - 11)
		end

		if (doubleCommand) then
			client:NotifyLocalized("textDoubleCommand", "/LocalEvent")
		end

		ix.chat.Send(client, "localevent", event)
	end,
	indicator = "chatPerforming"
})

ix.command.Add("RemovePersistedProps", {
	description = "@cmdRemovePersistedProps",
	superAdminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, radius)
		if (radius < 0) then
			client:Notify("Radius must be a positive number!")

			return
		end

		for _, entity in ipairs(ents.FindInSphere(client:GetPos(), radius)) do
			if (!entity:GetNetVar("Persistent")) then continue end
			
			entity:Remove()
		end

		client:Notify("Removed all persisted props in a radius of " .. radius .. " units.")
	end
})

ix.command.Add("Announce", {
	description = "@cmdAnnounce",
	arguments = {
		ix.type.text
	},
	OnRun = function(self, client, event)
		ix.chat.Send(client, "announcement", event)
	end,
	OnCheckAccess = function(self, client)
		return !client or CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands")
	end,
	indicator = "chatTyping"
})

ix.command.Add("GmRoll", {
	description = "Do a roll that only you can see.",
	arguments = {
		bit.bor(ix.type.number, ix.type.optional)
	},
	privilege = "Basic Admin Commands",
	OnRun = function(self, client, maximum)
		maximum = math.Clamp(maximum or 20, 0, 1000000)

		local value = math.random(0, maximum)

		ix.chat.Send(client, "gmroll", tostring(value), nil, nil, {
			max = maximum
		})

		ix.log.Add(client, "roll", value, maximum)
	end,
	bNoIndicator = true
})

-- Help
ix.command.Add("Help", {
	description = "@cmdStaffHelp",
	arguments = ix.type.text,
	alias = {"GMHelp", "ModHelp"},
	OnRun = function(self, client, text)
		client:Say("@ " .. text)
	end,
	OnCheckAccess = function(self, client)
		return !CAMI.PlayerHasAccess(client, "Helix - Hear Staff Chat")
	end,
	indicator = "chatTyping"
})

-- Admin Chat
ix.command.Add("Staff", {
	description = "Chat with other staff members.",
	arguments = ix.type.text,
	privilege = "Hear Staff Chat",
	alias = {"Op", "Mod", "ModChat"},
	OnRun = function(self, client, text)
		ix.chat.Send(client, "staff_chat", text)
	end,
	indicator = "chatTyping"
})

-- Gamemaster Chat
ix.command.Add("GameMaster", {
	description = "Chat with other Gamemasters.",
	arguments = ix.type.text,
	privilege = "Hear GM Chat",
	alias = {"GMChat", "GM"},
	OnRun = function(self, client, text)
		ix.chat.Send(client, "gm_chat", text)
	end,
	indicator = "chatTyping"
})

-- Mentor Chat
ix.command.Add("Mentor", {
	description = "Chat with other Mentors.",
	arguments = ix.type.text,
	privilege = "Hear Mentor Chat",
	alias = {"MChat", "M"},
	OnRun = function(self, client, text)
		ix.chat.Send(client, "mentor_chat", text)
	end,
	indicator = "chatTyping"
})

-- Fun Stuff
ix.command.Add("Achievement", {
	description = "Someone has earned a special achievement!",
	arguments = {
		ix.type.player,
		ix.type.text
	},
	privilege = "Fun Stuff",
	OnRun = function(self, client, target, text)
		ix.chat.Send(client, "achievement_get", text, false, nil,
		{target, "ambient/water/drip" .. math.random( 1, 4 ) .. ".wav"})
	end,
	indicator = "chatTyping"
})
ix.command.Add("DarwinAward", {
	description = "Someone has earned an  achievement: he has made the ultimate sacrifice to increase humanity's average IQ.",
	arguments = {
		ix.type.player
	},
	privilege = "Fun Stuff",
	OnRun = function(self, client, target)
		if (!target:Alive()) then
			local pos = target:GetPos()
			target:Spawn()

			target:SetPos(pos)
		end
		target:SetMoveType(MOVETYPE_WALK)
		target:SetVelocity(Vector(0, 0, 4000))

		timer.Simple(1, function() PLUGIN:Explode(target) end)
		ix.chat.Send(client, "achievement_get", "DARWIN AWARD", false, nil,
		{target, "ambient/alarms/razortrain_horn1.wav"})
	end,
	indicator = "chatTyping"
})
ix.command.Add("PlyRocket", {
	description = "To infinity, and beyond!.",
	arguments = {
		ix.type.player
	},
	privilege = "Fun Stuff",
	OnRun = function(self, client, target)
		if (!target:Alive()) then
			local pos = target:GetPos()
			target:Spawn()

			target:SetPos(pos)
		end
		target:SetMoveType(MOVETYPE_WALK)
		target:SetVelocity(Vector(0, 0, 4000))

		timer.Simple(1, function() PLUGIN:Explode(target) end)
	end,
	bNoIndicator = true
})

ix.command.Add("SetTimeScale", {
	description = "@cmdTimeScale",
	arguments = {
		bit.bor(ix.type.number, ix.type.optional)
	},
	privilege = "Fun Stuff",
	OnRun = function(self, client, number)
		local scale = math.Clamp(number or 1, 0.001, 5)
		game.SetTimeScale(scale)

		for _, v in ipairs(player.GetAll()) do
			if (self:OnCheckAccess(v)) then
				v:NotifyLocalized("bastionTimeScale", client:Name(), scale)
			end
		end
	end,
	bNoIndicator = true
})

ix.command.Add("SetGravity", {
	description = "@cmdGravity",
	arguments = {
		bit.bor(ix.type.number, ix.type.optional)
	},
	privilege = "Fun Stuff",
	OnRun = function(self, client, number)
		RunConsoleCommand("sv_gravity", number)

		for _, v in ipairs(player.GetAll()) do
			if (self:OnCheckAccess(v)) then
				v:NotifyLocalized("bastionGravity", client:Name(), number)
			end
		end
	end,
	bNoIndicator = true
})

-- lookup commands
ix.command.Add("LookupSteamID", {
	description = "Lookup a SteamID in the Bastion user database",
	arguments = {
		ix.type.text
	},
	privilege = "Bastion Lookup",
	OnRun = function(self, client, target)
		if (string.find(target, "^STEAM_%d+:%d+:%d+$")) then
			PLUGIN:LookupSteamID(client, target)
			return
		elseif (string.len(target) == 17 and string.find(target, "^%d+$")) then
			PLUGIN:LookupSteamID(client, target)
			return
		end

		target = ix.util.FindPlayer(target, false)
		client:NotifyLocalized("bastionTargetSelected", target:Name())

		PLUGIN:LookupSteamID(client, target:SteamID64())
	end,
	bNoIndicator = true
})

ix.command.Add("LookupIPUsers", {
	description = "Lookup a SteamID in the Bastion IP database",
	arguments = {
		ix.type.text
	},
	privilege = "Bastion Lookup",
	OnRun = function(self, client, target)
		if (string.find(target, "^STEAM_%d+:%d+:%d+$")) then
			PLUGIN:LookupIPUsers(client, target)
			return
		elseif (string.len(target) == 17 and string.find(target, "^%d+$")) then
			PLUGIN:LookupIPUsers(client, target)
			return
		end

		target = ix.util.FindPlayer(target, false)
		client:NotifyLocalized("bastionTargetSelected", target:Name())

		PLUGIN:LookupIPUsers(client, target:SteamID64())
	end,
	bNoIndicator = true
})

ix.command.Add("ProxyWhitelist", {
	description = "Whitelist a player as trusted to disable future proxy checks.",
	arguments = {
		ix.type.player
	},
	privilege = "Bastion Whitelist",
	OnRun = function(self, client, target)
		if (PLUGIN:WhitelistPlayer(target)) then
			client:NotifyLocalized("whitelistDone")
		else
			client:NotifyLocalized("whitelistError")
		end
	end,
	indicator = "chatTyping"
})

ix.command.Add("PlyGetCharacters", {
	description = "Get a list of a player's characters.",
	arguments = {
		ix.type.player
	},
	adminOnly = true,
	OnRun = function(self, client, target)
		client:ChatNotify(target:SteamName() .. "'s characters:")
		client:ChatNotify("====================")

		for _, character in pairs(target.ixCharList) do
			client:ChatNotify(ix.char.loaded[character].vars.name)
		end
	end
})


ix.command.Add("LTARP", {
	description = "Automatically ban a player for leaving to avoid RP after a grace period.",
	arguments = {
		ix.type.string,
		ix.type.number,
		bit.bor(ix.type.text, ix.type.optional),
	},
	adminOnly = true,
	OnRun = function(self, client, steamID, days, reason)
		local target = player.GetBySteamID64(steamID) or player.GetBySteamID(steamID)
		if (target) then
			client:Notify(target:SteamName().." is still on the server as '"..target:Name().."!")
			return
		end

		if (days > 100) then
			client:Notify("Invalid duration entered. Max ban length is 100 days.")
			return
		end

		if (string.find(string.upper(steamID), "^STEAM")) then
			steamID = util.SteamIDTo64(string.upper(steamID))
		end

		if (!PLUGIN.disconnects[steamID]) then
			client:Notify("Could not find a disconnect for "..steamID..", manually ban them if needed.")
			return
		end

		local info = PLUGIN.disconnects[steamID]
		if (info.timer) then
			client:Notify(steamID.." is already tagged for LTARP by "..info.bannedByName..".")
			return
		end

		local reconnectTime, maxBanDelay = 30, 40
		if (info.time + reconnectTime * 60 < os.time()) then
			if (info.time + maxBanDelay * 60 < os.time()) then
				client:Notify(steamID.." disconnected more than "..maxBanDelay.." minutes ago already. Manually ban them if needed.")
				return
			end

			RunConsoleCommand("sam", "banid", steamID, tostring(days * 60 * 24), reason != "" and reason or "Leaving to avoid RP. Appeal on willard.network ~"..client:SteamName())
			return
		end

		local uniqueID = "ixLTARP"..steamID
		local bannedBy = client and client:SteamName() or "console"
		timer.Create(uniqueID, info.time - os.time() + reconnectTime * 60, 1, function()
			if (IsValid(client)) then
				client:Notify(steamID.." did not reconnect and has been banned.")
			end
			RunConsoleCommand("sam", "banid", steamID, tostring(days * 60 * 24), reason != "" and reason or "Leaving to avoid RP. Appeal on willard.network ~"..bannedBy)
		end)

		info.timer = uniqueID
		info.bannedBy = client
		info.bannedByName = client and client:SteamName() or "console"
		client:Notify("Timer set! "..steamID.." will be banned in "..math.ceil((info.time - os.time() + reconnectTime * 60) / 60).." minutes.")
	end
})
