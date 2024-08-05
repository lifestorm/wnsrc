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
local ix = ix

local IsValid = IsValid
local hook = hook

PLUGIN.name = "Radio Redux"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Implements a better functional radio system. Based on my CW Radio Redux plugin. Credits to SleepyMode for the initial port (which this is very loosely based on)."

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Radio",
	MinAccess = "admin",
	Description = "Manually assign radio channels to players."
})

CAMI.RegisterPrivilege({
	Name = "Helix - Radio Use",
	MinAccess = "user",
	Description = "Use the basic radio commands."
})

ix.char.RegisterVar("radioChannel", {
	default = "",
	field = "radiochannel",
	fieldType = ix.type.string,
	isLocal = true,
	bNoDisplay = true
})

ix.config.Add("radioLimitRange", 0, "Limit the range of regular handheld radios.", nil, {
	data = {min = 0, max = 25000},
	category = "Miscellaneous"
})
ix.config.Add("radioHideWhisper", true, "Do not give the actual text for radio whispers.", nil, {
	category = "Miscellaneous"
})

ix.lang.AddTable("english", {
	radioFormat = "[%s] %s%s: \"%s\"",
	radioWhisper = " whispers",
	radioYell = " yells",
	radioScream = " SCREAMS",
	radioEaves = " speaks into ",
	radioEavesW = " whispers into ",
	radioEavesY = " yells into ",
	radioEavesSc = " SCREAMS into ",
	radioHis = "his",
	radioHer = "her",
	radioRadio = "radio",
	radioStationary = "a stationary radio",
	radioYellOver = " yells over radio",
	radioScreamOver = " SCREAMS over radio",
	radioChannels = "Radio channels",
	quickChannels = "Quick channels",
	radioSpeaking = "Speaking on",
	radioNone = "none",
	radioSetChannel = "You have set your channel to \"%s\".",
	radioChannelNotExist = "This channel doesn't exist!",
	radioSubbed = "You have subscribed %s to the '%s' channel.",
	radioSubbedT = "You have been subscribed to the '%s' channel by %s.",
	radioUnsubbed = "You have unsubscribed %s to the '%s' channel.",
	radioUnsubbedT = "You have been unsubscribed to the '%s' channel by %s.",
	radioNotOn = "This radio is not turned on!",
	radioTooFar = "This stationary radio is too far away!",
	radioInvalidChannel = "You must speak on a valid radio channel!",
	cmdCharAddRadioChannel = "Subscribes a player to a radio channel.",
	cmdCharRemoveRadioChannel = "Unsubscribes a player to a radio channel.",
	cmdSC = "Select the Channel you want to speak on.",
})

ix.lang.AddTable("spanish", {
	radioNotOn = "¡Esta radio no está encendida!",
	radioFormat = "[%s] %s%s: \"%s\"",
	radioRadio = "radio",
	radioWhisper = " susurra",
	radioSpeaking = "Hablando en",
	radioScreamOver = " CHILLA por la radio",
	radioInvalidChannel = "¡Debes hablar en un canal de radio válido!",
	radioSetChannel = "Has establecido tu canal a \"%s\".",
	cmdSC = "Elige el Canal en el que quieres hablar.",
	radioYell = " grita",
	radioChannels = "Canales de radio",
	radioChannelNotExist = "¡Este canal no existe!",
	radioScream = " CHILLA",
	radioStationary = "una radio fija",
	cmdCharRemoveRadioChannel = "Anula la suscripción de un jugador a un canal de radio.",
	cmdCharAddRadioChannel = "Suscribe a un jugador a un canal de radio.",
	radioUnsubbedT = "Has sido dado de baja del canal '%s' por %s.",
	radioTooFar = "¡Esta radio fija está demasiado lejos!",
	radioSubbedT = "Has sido suscrito al canal '%s' por %s.",
	radioEaves = " habla hacia su ",
	radioHis = "su",
	radioEavesY = " grita a su ",
	radioEavesW = " suspira a su ",
	radioSubbed = "Has suscrito a %s al canal '%s'.",
	radioHer = "su",
	radioEavesSc = " CHILLA en su ",
	radioNone = "ninguno",
	radioYellOver = " grita por la radio",
	radioUnsubbed = "Has cancelado la suscripción de %s al canal '%s'."
})

ix.char.RegisterVar("radioChannels", {
	default = {},
	field = "radiochannels",
	fieldType = ix.type.text,
	bNoDisplay = true,
	isLocal = true,
	OnSet = function(character, channelID, bRemove)
		local channel = ix.radio:FindByID(channelID)
		if (!channel) then return end

		local channels = character:GetRadioChannels()

		channelID = channel.uniqueID
		if (!bRemove) then
			for _, v in ipairs(channels) do
				if v == channelID then
					return
				end
			end

			channels[#channels + 1] = channelID
		else
			local removed = false
			for k, v in ipairs(channels) do
				if v == channelID then
					removed = true
					table.remove(channels, k)
					break
				end
			end

			if (!removed) then return end
		end

		table.sort(channels)

		character.vars.radioChannels = channels
		net.Start("ixRadioChannels")
			net.WriteUInt(character:GetID(), 32)
			net.WriteUInt(#channels, 16)
			for _, v in ipairs(channels) do
				net.WriteString(v)
			end
		net.Send(character:GetPlayer())
	end,
	OnGet = function(character)
		return character.vars.radioChannels or {}
	end
})

--ix.util.Include("meta/sh_player.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sh_channels.lua")
ix.util.Include("sh_commands.lua")

do
	local types = {
		[ix.radio.types.talk] = "",
		[ix.radio.types.whisper] = "radioWhisper",
		[ix.radio.types.yell] = "radioYell",
		[ix.radio.types.scream] = "radioScream",
	}
	local CLASS = {}
	CLASS.indicator = "chatRadio"

	if (CLIENT) then
		function CLASS:OnChatAdd(speaker, text, anonymous, data)
			local name = anonymous and L"someone" or
				hook.Run("GetCharacterName", speaker, "radio") or
				(IsValid(speaker) and speaker:Name() or "Console")

			local rtext = L(types[data.radioType] or "")
			local channel = ix.radio:FindByID(data.channel)
			local rText = L("radioFormat", channel.name, name, rtext, text)

			--local quickCom = LocalPlayer():HasQuickComms(data.channel)
			local color = (quickCom and ix.option.Get("com"..quickCom.."Color")) or channel.color
			if (channel.icon) then
				chat.AddText(channel.icon, color, rText)
			else
				chat.AddText(color, rText)
			end
		end
	end

	ix.chat.Register("radio", CLASS)
end

do
	local types = {
		[ix.radio.types.talk] = "radioEaves",
		[ix.radio.types.whisper] = "radioEavesW",
		[ix.radio.types.yell] = "radioEavesY",
		[ix.radio.types.scream] = "radioEavesSc",
	}
	local CLASS = {}

	if (CLIENT) then
		function CLASS:OnChatAdd(speaker, text, anonymous, data)
			local name = anonymous and L"someone" or
				hook.Run("GetCharacterName", speaker, "radio_eavesdrop") or
				(IsValid(speaker) and speaker:Name() or "Console")

			local rtext = L(types[data.radioType] or "")
			if (!data.stationary) then
				local genderText = L("radioHis")
				if (speaker:IsFemale()) then
					genderText = L("radioHer")
				end

				if (!ix.config.Get("radioHideWhisper") or data.radioType != ix.radio.types.whisper) then
					chat.AddText(ix.chat.classes.ic.color, name, rtext, genderText, " ", L("radioRadio"), ": \"", text, "\"")
				else
					chat.AddText(ix.chat.classes.ic.color, name, rtext, genderText, " ", L("radioRadio"), ".")
				end
			else
				if (!ix.config.Get("radioHideWhisper") or speaker == LocalPlayer() or data.radioType != ix.radio.types.whisper) then
					chat.AddText(ix.chat.classes.ic.color, name, rtext, L("radioStationary"), ": \"", text, "\"")
				else
					chat.AddText(ix.chat.classes.ic.color, name, rtext, L("radioStationary"), ".")
				end
			end
		end
	end

	ix.chat.Register("radio_eavesdrop", CLASS)
end

do
	local CLASS = {}

	if (CLIENT) then
		function CLASS:OnChatAdd(speaker, text, anonymous, data)
			local name = anonymous and L"someone" or
				hook.Run("GetCharacterName", speaker, "radio_eavesdrop_yell") or
				(IsValid(speaker) and speaker:Name() or "Console")

			chat.AddText(ix.chat.classes.ic.color, name, L(data.radioType == ix.radio.types.yell and "radioYellOver" or "radioScreamOver"), ": \"", text, "\"")
		end
	end

	ix.chat.Register("radio_eavesdrop_yell", CLASS)
end
