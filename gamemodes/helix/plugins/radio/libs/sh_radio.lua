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

ix.radio = ix.radio or {}
ix.radio.channels = ix.radio.channels or {}

ix.radio.types			= {}
ix.radio.types.whisper	= 1
ix.radio.types.talk		= 2
ix.radio.types.yell		= 3
ix.radio.types.scream	= 4

local ipairs = ipairs
local istable = istable
local table = table

function ix.radio:RegisterChannel(uniqueID, data)
	if (self.channels[uniqueID]) then
		return
	end

	if (!istable(data)) then
		ErrorNoHalt("[IX: Radio] Attempted to register channel \"" .. uniqueID .. "\" with invalid data.")
		return
	end

	data.uniqueID = uniqueID
	data.name = data.name or uniqueID

	if (!data.color) then
		data.color = Color(96, 179, 0, 255)
	end

	data.listeners = {}
	data.listenersByKeys = {}
	data.stationaries = {}

	data.priority = data.priority or 0

	if (data.icon and isstring(data.icon)) then
		data.icon = ix.util.GetMaterial(data.icon)
	end

	self.channels[uniqueID] = data

	if (data.shortcutCommand) then
		local sc = data.shortcutCommand
		local a = string.sub(sc, 1, 1)
		ix.command.Add(sc.."Radio", {
			alias = {a, data.alias},
			arguments = ix.type.text,
			OnCheckAccess = function(_, client)
				return client:GetCharacter() and ix.radio:CharacterHasChannel(client:GetCharacter(), uniqueID)
			end,
			OnRun = function(_, client, text)
				return ix.radio:SayOnRadio(client, text, ix.radio.types.talk, uniqueID)
			end
		})

		ix.command.Add(sc.."Whisper", {
			alias = {a.."W", (data.alias or a).."W"},
			arguments = ix.type.text,
			OnCheckAccess = function(_, client)
				return client:GetCharacter() and ix.radio:CharacterHasChannel(client:GetCharacter(), uniqueID)
			end,
			OnRun = function(_, client, text)
				return ix.radio:SayOnRadio(client, text, ix.radio.types.whisper, uniqueID)
			end,
		})

		ix.command.Add(sc.."Yell", {
			alias = {a.."Y", (data.alias or a).."Y"},
			arguments = ix.type.text,
			OnCheckAccess = function(_, client)
				return client:GetCharacter() and ix.radio:CharacterHasChannel(client:GetCharacter(), uniqueID)
			end,
			OnRun = function(_, client, text)
				return ix.radio:SayOnRadio(client, text, ix.radio.types.yell, uniqueID)
			end,
		})
	end

	return data
end

function ix.radio:RemoveChannel(uniqueID)
	self.channels[uniqueID] = nil
end

function ix.radio:FindByID(channelID)
	if (!channelID or channelID == "") then return end

	if (self.channels[channelID]) then
		return self.channels[channelID]
	else
		local zone, channel, qt = string.match(channelID, "^freq_(%d)_(%d?%d)_(%d?%d)$")
		if (zone and channel and qt) then
			local qtText = zone == "1" and " QT" or " DQT"
			self:RegisterChannel(channelID, {
				name = zone.."-"..channel..qtText..qt,
				icon = "willardnetworks/chat/radio_icon.png"
			})

			return self.channels[channelID]
		end

		local freq = string.match(channelID, "^freq_(%d%d)$")
		if (freq and tonumber(freq) and tonumber(freq) >= 10) then
			self:RegisterChannel(channelID, {
				name = freq,
				icon = "willardnetworks/chat/radio_icon.png",
				backpackRadio = true
			})

			return self.channels[channelID]
		end
	end
end

function ix.radio.sortFunc(a, b)
	a, b = ix.radio:FindByID(a), ix.radio:FindByID(b)
	if (!a) then
		return false
	elseif (!b) then
		return true
	elseif (a.priority != b.priority) then
		return a.priority > b.priority
	else
		return a.name < b.name
	end
end

function ix.radio:GetAllChannelsFromChar(character)
	local channels = table.Copy(character:GetRadioChannels())

	local inventory = character:GetInventory()
	local items = inventory:GetItems()
	for _, item in pairs(items) do
		if (item.isRadio) then
			if (item.GetChannels) then
				for _, v in ipairs(item:GetChannels()) do
					channels[#channels + 1] = v
				end
			elseif (item.GetChannel and item:GetChannel()) then
				channels[#channels + 1] = item:GetChannel()
			end
		end
	end

	local faction = ix.faction.indices[character:GetFaction()]
	if (faction and istable(faction.radioChannels)) then
		for _, channel in ipairs(faction.radioChannels) do
			channels[#channels + 1] = channel
		end
	end

	hook.Run("AdjustCharacterRadioChannels", character, channels)

	local seen = {}
	for i = #channels, 1, -1 do
		if (seen[channels[i]]) then
			table.remove(channels, i)
		else
			seen[channels[i]] = true
		end
	end

	table.sort(channels, ix.radio.sortFunc)
	return channels
end

function ix.radio:CharacterHasChannel(character, channelID)
	local channel = self:FindByID(channelID)
	if (!channel) then return false end

	channelID = channel.uniqueID

	local faction = ix.faction.indices[character:GetFaction()]
	if (faction and istable(faction.radioChannels)) then
		for _, chnlID in ipairs(faction.radioChannels) do
			if (chnlID == channelID) then
				return true
			end
		end
	end

	local inventory = character:GetInventory()
	local items = inventory:GetItems()
	for _, item in pairs(items) do
		if (item.isRadio) then
			if (item.GetChannels) then
				for _, v in ipairs(item:GetChannels()) do
					if (v == channelID) then
						return true
					end
				end
			elseif (item:GetChannel() == channelID) then
				return true
			end
		end
	end

	local channels = character:GetRadioChannels()
	for _, chnl in ipairs(channels) do
		if (chnl == channelID) then
			return true
		end
	end

	return hook.Run("HasCharacterRadioChannel", character, channelID)
end
