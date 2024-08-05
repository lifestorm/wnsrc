--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


--[[--
Chat manipulation and helper functions.

Chat messages are a core part of the framework - it's takes up a good chunk of the gameplay, and is also used to interact with
the framework. Chat messages can have types or "classes" that describe how the message should be interpreted. All chat messages
will have some type of class: `ic` for regular in-character speech, `me` for actions, `ooc` for out-of-character, etc. These
chat classes can affect how the message is displayed in each player's chatbox. See `ix.chat.Register` and `ChatClassStructure`
to create your own chat classes.
]]
-- @module ix.chat

ix.chat = ix.chat or {}

--- List of all chat classes that have been registered by the framework, where each key is the name of the chat class, and value
-- is the chat class data. Accessing a chat class's data is useful for when you want to copy some functionality or properties
-- to use in your own. Note that if you're accessing this table, you should do so inside of the `InitializedChatClasses` hook.
-- @realm shared
-- @table ix.chat.classes
-- @usage print(ix.chat.classes.ic.format)
-- > "%s says \"%s\""
ix.chat.classes = ix.chat.classes or {}

if (!ix.command) then
	include("sh_command.lua")
end

CAMI.RegisterPrivilege({
Name = "Helix - Bypass OOC Timer",
	MinAccess = "admin"
})
CAMI.RegisterPrivilege({
	Name = "Helix - OOC See IC Name",
	MinAccess = "admin"
})
CAMI.RegisterPrivilege({
	Name = "Helix - Icon Incognito Mode",
	MinAccess = "admin"
})

-- note we can't use commas in the "color" field's default value since the metadata is separated by commas which will break the
-- formatting for that field

--- Chat messages can have different classes or "types" of messages that have different properties. This can include how the
-- text is formatted, color, hearing distance, etc.
-- @realm shared
-- @table ChatClassStructure
-- @see ix.chat.Register
-- @field[type=string] prefix What the player must type before their message in order to use this chat class. For example,
-- having a prefix of `/Y` will require to type `/Y I am yelling` in order to send a message with this chat class. This can also
-- be a table of strings if you want to allow multiple prefixes, such as `{"//", "/OOC"}`.
--
-- **NOTE:** the prefix should usually start with a `/` to be consistent with the rest of the framework. However, you are able
-- to use something different like the `LOOC` chat class where the prefixes are `.//`, `[[`, and `/LOOC`.
-- @field[type=bool,opt=false] noSpaceAfter Whether or not the `prefix` can be used without a space after it. For example, the
-- `OOC` chat class allows you to type `//my message` instead of `// my message`. **NOTE:** this only works if the last
-- character in the prefix is non-alphanumeric (i.e `noSpaceAfter` with `/Y` will not work, but `/!` will).
-- @field[type=string,opt] description Description to show to the user in the chatbox when they're using this chat class
-- @field[type=string,opt="%s: \"%s\""] format How to format a message with this chat class. The first `%s` will be the speaking
-- player's name, and the second one will be their message
-- @field[type=color,opt=Color(242 230 160)] color Color to use when displaying a message with this chat class
-- @field[type=string,opt="chatTyping"] indicator Language phrase to use when displaying the typing indicator above the
-- speaking player's head
-- @field[type=bool,opt=false] bNoIndicator Whether or not to avoid showing the typing indicator above the speaking player's
-- head
-- @field[type=string,opt=ixChatFont] font Font to use for displaying a message with this chat class
-- @field[type=bool,opt=false] deadCanChat Whether or not a dead player can send a message with this chat class
-- @field[type=number] CanHear This can be either a `number` representing how far away another player can hear this message.
-- IC messages will use the `chatRange` config, for example. This can also be a function, which returns `true` if the given
-- listener can hear the message emitted from a speaker.
-- 	-- message can be heard by any player 1000 units away from the speaking player
-- 	CanHear = 1000
-- OR
-- 	CanHear = function(self, speaker, listener)
-- 		-- the speaking player will be heard by everyone
-- 		return true
-- 	end
-- @field[type=function,opt] CanSay Function to run to check whether or not a player can send a message with this chat class.
-- By default, it will return `false` if the player is dead and `deadCanChat` is `false`. Overriding this function will prevent
-- `deadCanChat` from working, and you must implement this functionality manually.
-- 	CanSay = function(self, speaker, text)
-- 		-- the speaker will never be able to send a message with this chat class
-- 		return false
-- 	end
-- @field[type=function,opt] GetColor Function to run to set the color of a message with this chat class. You should generally
-- stick to using `color`, but this is useful for when you want the color of the message to change with some criteria.
-- 	GetColor = function(self, speaker, text)
-- 		-- each message with this chat class will be colored a random shade of red
-- 		return Color(math.random(120, 200), 0, 0)
-- 	end
-- @field[type=function,opt] OnChatAdd Function to run when a message with this chat class should be added to the chatbox. If
-- using this function, make sure you end the function by calling `chat.AddText` in order for the text to show up.
--
-- **NOTE:** using your own `OnChatAdd` function will prevent `color`, `GetColor`, or `format` from being used since you'll be
-- overriding the base function that uses those properties. In such cases you'll need to add that functionality back in
-- manually. In general, you should avoid overriding this function where possible. The `data` argument in the function is
-- whatever is passed into the same `data` argument in `ix.chat.Send`.
--
-- 	OnChatAdd = function(self, speaker, text, bAnonymous, data)
-- 		-- adds white text in the form of "Player Name: Message contents"
-- 		chat.AddText(color_white, speaker:GetName(), ": ", text)
-- 	end

--- Registers a new chat type with the information provided. Chat classes should usually be created inside of the
-- `InitializedChatClasses` hook.
-- @realm shared
-- @string chatType Name of the chat type
-- @tparam ChatClassStructure data Properties and functions to assign to this chat class
-- @usage -- this is the "me" chat class taken straight from the framework as an example
-- ix.chat.Register("me", {
-- 	format = "** %s %s",
-- 	color = Color(255, 50, 50),
-- 	CanHear = ix.config.Get("chatRange", 280) * 2,
-- 	prefix = {"/Me", "/Action"},
-- 	description = "@cmdMe",
-- 	indicator = "chatPerforming",
-- 	deadCanChat = true
-- })
-- @see ChatClassStructure
function ix.chat.Register(chatType, data)
	chatType = string.lower(chatType)

	if (!data.CanHear) then
		-- Have a substitute if the canHear property is not found.
		function data:CanHear(speaker, listener)
			-- The speaker will be heard by everyone.
			return true
		end
	elseif (isnumber(data.CanHear)) then
		-- Use the value as a range and create a function to compare distances.
		local range = data.CanHear * data.CanHear
		data.range = range

		function data:CanHear(speaker, listener)
			-- Length2DSqr is faster than Length2D, so just check the squares.
			return (speaker:GetPos() - listener:GetPos()):LengthSqr() <= self.range
		end
	end

	-- Allow players to use this chat type by default.
	if (!data.CanSay) then
		function data:CanSay(speaker, text)
			if (!self.deadCanChat and !speaker:Alive()) then
				speaker:NotifyLocalized("noPerm")

				return false
			end

			return true
		end
	end

	-- Chat text color.
	data.color = data.color or Color(242, 230, 160)

	if (!data.OnChatAdd) then
		data.format = data.format or "%s: \"%s\""
		data.icon = data.icon or nil

		function data:OnChatAdd(speaker, text, anonymous, info)
			local color = self.color
			local name = anonymous and
				L"someone" or hook.Run("GetCharacterName", speaker, chatType) or
				(IsValid(speaker) and speaker:Name() or "Console")

			if (self.GetColor) then
				color = self:GetColor(speaker, text, info)
			end

			if self.bigfont then 
                local oldFont = self.font 
				local font = hook.Run("GetSpeakerYellFont", speaker)
                self.font = font
            elseif self.specialfont then  
				local oldFont = self.font 
				local font = hook.Run("GetSpeakerFont", speaker)
                self.font = font
			else 
				local oldFont = self.font 
				local font = "ixChatFont"
                self.font = font
			end 

			local translated = L2(chatType.."Format", name, text)

			if self.icon and ix.option.Get("standardIconsEnabled") then
				chat.AddText(ix.util.GetMaterial(self.icon), color, translated or string.format(self.format, name, text))
			else
				chat.AddText(color, translated or string.format(self.format, name, text))
			end

			if self.font then
				self.font = oldFont
		 	end 
		end
	end

	if (CLIENT and data.prefix) then
		if (istable(data.prefix)) then
			for _, v in ipairs(data.prefix) do
				if (v:utf8sub(1, 1) == "/") then
					ix.command.Add(v:utf8sub(2), {
						description = data.description,
						arguments = ix.type.text,
						indicator = data.indicator,
						bNoIndicator = data.bNoIndicator,
						chatClass = data,
						OnCheckAccess = function() return true end,
						OnRun = function(self, client, message) end
					})
				end
			end
		else
			ix.command.Add(isstring(data.prefix) and data.prefix:utf8sub(2) or chatType, {
				description = data.description,
				arguments = ix.type.text,
				indicator = data.indicator,
				bNoIndicator = data.bNoIndicator,
				chatClass = data,
				OnCheckAccess = function() return true end,
				OnRun = function(self, client, message) end
			})
		end
	end

	data.uniqueID = chatType
	ix.chat.classes[chatType] = data
end

--- Identifies which chat mode should be used.
-- @realm shared
-- @player client Player who is speaking
-- @string message Message to parse
-- @bool[opt=false] bNoSend Whether or not to send the chat message after parsing
-- @treturn string Name of the chat type
-- @treturn string Message that was parsed
-- @treturn bool Whether or not the speaker should be anonymous
function ix.chat.Parse(client, message, bNoSend)
	local anonymous = false
	local chatType = "ic"

	-- Loop through all chat classes and see if the message contains their prefix.
	for k, v in pairs(ix.chat.classes) do
		local isChosen = false
		local chosenPrefix = ""
		local noSpaceAfter = v.noSpaceAfter

		-- Check through all prefixes if the chat type has more than one.
		if (istable(v.prefix)) then
			for _, prefix in ipairs(v.prefix) do
				prefix = prefix:utf8lower()
				local fullPrefix = prefix .. (noSpaceAfter and "" or " ")

				-- Checking if the start of the message has the prefix.
				if (message:utf8sub(1, prefix:utf8len() + (noSpaceAfter and 0 or 1)):utf8lower() == fullPrefix:utf8lower()) then
					isChosen = true
					chosenPrefix = fullPrefix

					break
				end
			end
		-- Otherwise the prefix itself is checked.
		elseif (isstring(v.prefix)) then
			local prefix = v.prefix:utf8lower()
			local fullPrefix = prefix .. (noSpaceAfter and "" or " ")

			isChosen = message:utf8sub(1, prefix:utf8len() + (noSpaceAfter and 0 or 1)):utf8lower() == fullPrefix:utf8lower()
			chosenPrefix = fullPrefix
		end

		-- If the checks say we have the proper chat type, then the chat type is the chosen one!
		-- If this is not chosen, the loop continues. If the loop doesn't find the correct chat
		-- type, then it falls back to IC chat as seen by the chatType variable above.
		if (isChosen) then
			-- Set the chat type to the chosen one.
			chatType = k
			-- Remove the prefix from the chat type so it does not show in the message.
			message = message:utf8sub(chosenPrefix:utf8len() + 1)

			if (ix.chat.classes[k].noSpaceAfter and message:utf8sub(1, 1):match("%s")) then
				message = message:utf8sub(2)
			end

			break
		end
	end

	if (!message:find("%S")) then
		return
	end

	-- Only send if needed.
	if (SERVER and !bNoSend) then
		-- Send the correct chat type out so other player see the message.
		ix.chat.Send(client, chatType, hook.Run("PlayerMessageSend", client, chatType, message, anonymous) or message, anonymous)
	end

	-- Return the chosen chat type and the message that was sent if needed for some reason.
	-- This would be useful if you want to send the message on your own.
	return chatType, message, anonymous
end

--- Formats a string to fix basic grammar - removing extra spacing at the beginning and end, capitalizing the first character,
-- and making sure it ends in punctuation.
-- @realm shared
-- @string text String to format
-- @treturn string Formatted string
-- @usage print(ix.chat.Format("hello"))
-- > Hello.
-- @usage print(ix.chat.Format("wow!"))
-- > Wow!
function ix.chat.Format(text)
	text = string.Trim(text)
	local last = text:utf8sub(-1)

	if (last != "." and last != "?" and last != "!" and last != "-" and last != "\"") then
		text = text .. "."
	end

	return text:utf8sub(1, 1):utf8upper() .. text:utf8sub(2)
end

if (SERVER) then
	util.AddNetworkString("ixChatMessage")

	--- Send a chat message using the specified chat type.
	-- @realm server
	-- @player speaker Player who is speaking
	-- @string chatType Name of the chat type
	-- @string text Message to send
	-- @bool[opt=false] bAnonymous Whether or not the speaker should be anonymous
	-- @tab[opt=nil] receivers The players to replicate send the message to
	-- @tab[opt=nil] data Additional data for this chat message
	function ix.chat.Send(speaker, chatType, text, bAnonymous, receivers, data)
		if (!chatType) then
			return
		end

		data = data or {}
		chatType = string.lower(chatType)

		if (IsValid(speaker) and hook.Run("PrePlayerMessageSend", speaker, chatType, text, bAnonymous, receivers, data) == false) then
			return
		end

		local class = ix.chat.classes[chatType]

		if (class and class:CanSay(speaker, text, data) != false) then
			if (class.CanHear and !receivers) then
				receivers = {}

				for _, v in ipairs(player.GetAll()) do
					if (v:GetCharacter() and class:CanHear(speaker, v, data) != false) then
						receivers[#receivers + 1] = v
					end
				end

				if (#receivers == 0) then
					return
				end
			end

			-- Format the message if needed before we run the hook.
			local rawText = text
			local maxLength = ix.config.Get("chatMax")

			if (text:utf8len() > maxLength) then
				text = text:utf8sub(0, maxLength)
			end

			if (ix.config.Get("chatAutoFormat") and hook.Run("CanAutoFormatMessage", speaker, chatType, text)) then
				text = ix.chat.Format(text)
			end

			local iconIncognitoMode = false
			if speaker and IsValid(speaker) and !speaker:IsBot() then
				iconIncognitoMode = ix.option.Get(speaker, "iconIncognitoMode", false)
			end

			text = hook.Run("PlayerMessageSend", speaker, chatType, text, bAnonymous, receivers, rawText, data) or text

			net.Start("ixChatMessage")
				net.WriteEntity(speaker)
				net.WriteString(chatType)
				net.WriteString(text)
				net.WriteBool(bAnonymous or false)
				net.WriteBool(iconIncognitoMode)
				net.WriteTable(data or {})
			net.Send(receivers)

			return text
		end
	end
else
	function ix.chat.Send(speaker, chatType, text, anonymous, data, iconIncognitoMode)
		local class = ix.chat.classes[chatType]

		if (class) then
			-- luacheck: globals CHAT_CLASS
			CHAT_CLASS = class
				class:OnChatAdd(speaker, text, anonymous, data, iconIncognitoMode)
			CHAT_CLASS = nil
		end
	end

	-- Call OnChatAdd for the appropriate chatType.
	net.Receive("ixChatMessage", function()
		local client = net.ReadEntity()
		local chatType = net.ReadString()
		local text = net.ReadString()
		local anonymous = net.ReadBool()
		local iconIncognitoMode = net.ReadBool()
		local data = net.ReadTable()
		local info = {
			chatType = chatType,
			text = text,
			anonymous = anonymous,
			iconIncognitoMode = iconIncognitoMode,
			data = data
		}

		if (IsValid(client)) then
			hook.Run("MessageReceived", client, info)
			ix.chat.Send(client, info.chatType or chatType, info.text or text, info.anonymous or anonymous, info.data,
			info.iconIncognitoMode)
		else
			if client and client.IsWorld and client:IsWorld() then
				hook.Run("MessageReceived", nil, info)
			end

			ix.chat.Send(nil, chatType, text, anonymous, data)
		end
	end)
end

-- Add the default chat types here.
do
	-- Load the chat types after the configs so we can access changed configs.
	hook.Add("InitializedConfig", "ixChatTypes", function()
		-- The default in-character chat.
		ix.chat.Register("ic", {
			format = "%s says \"%s\"",
			icon = "willardnetworks/chat/message_icon.png",
			indicator = "chatTalking",
			color = Color(255, 254, 153, 255),
			CanHear = ix.config.Get("chatRange", 280)
		})

		ix.option.Add("iconIncognitoMode", ix.type.bool, false, {
			bNetworked = true,
			category = "chat",
			hidden = function()
				return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Icon Incognito Mode")
			end
		})

		if (CLIENT) then
			ix.option.Add("standardIconsEnabled", ix.type.bool, true, {
				category = "chat"
			})

			ix.option.Add("seeGlobalOOC", ix.type.bool, true, {
				category = "chat"
			})

			ix.option.Add("enablePrivateMessageSound", ix.type.bool, true, {
				category = "chat"
			})
		end

		-- Actions and such.
		ix.chat.Register("me", {
			format = "*** %s %s",
			color = Color(214, 254, 137, 255),
			CanHear = ix.config.Get("chatRange", 280) * 2,
			prefix = {"/Me", "/Action"},
			description = "@cmdMe",
			indicator = "chatPerforming",
			CanSay = function(self, speaker, text)
				if (!speaker:Alive() and speaker.lastMeExpended) then
					speaker:NotifyLocalized("noPerm")

					return false
				end
			end
		})

		-- Actions and such.
		ix.chat.Register("it", {
			OnChatAdd = function(self, speaker, text)
				chat.AddText(ix.config.Get("chatColor"), "***' "..text)
			end,
			CanHear = ix.config.Get("chatRange", 280) * 2,
			prefix = {"/It"},
			description = "@cmdIt",
			indicator = "chatPerforming",
			deadCanChat = true
		})

		-- Whisper chat.
		ix.chat.Register("w", {
			format = "%s whispers \"%s\"",
			icon = "willardnetworks/chat/whisper_icon.png",
			color = Color(158, 162, 191, 255),
			CanHear = ix.config.Get("chatRange", 280) * 0.25,
			prefix = {"/W", "/Whisper"},
			description = "@cmdW",
			indicator = "chatWhispering",
			specialfont = true
		})

		-- Yelling out loud.
		ix.chat.Register("y", {
			format = "%s yells \"%s\"",
			color = Color(254, 171, 103, 255),
			icon = "willardnetworks/chat/yell_icon.png",
			CanHear = ix.config.Get("chatRange", 280) * 2,
			prefix = {"/Y", "/Yell"},
			description = "@cmdY",
			indicator = "chatYelling",
			bigfont = true
		})

		-- REMEMBER TO UPDATE THESE WHEN WE CHANGE RANKS IN SAM
		local chatIconMap = {
			["willardnetworks/chat/star.png"] = {
				["community_manager"] = true,
				["head_of_staff"] = true,
				["server_council"] = true,
				["willard_management"] = true,
				["superadmin"] = true
			},
			["willardnetworks/chat/hammer.png"] = {
				["senior_admin"] = true,
				["server_admin"] = true,
				["trial_admin"] = true,
				["admin"] = true
			},
			["willardnetworks/chat/paintbrush.png"] = {
				["gamemaster"] = true
			},
			["willardnetworks/chat/wrench.png"] = {
				["developer"] = true
			},
			["willardnetworks/chat/leaf.png"] = {
				["mentor"] = true
			},
			["willardnetworks/chat/heart.png"] = {
				["premium1"] = true,
				["premium2"] = true,
				["premium3"] = true
			}
		}
		local function GetIcon(speaker, iconIncognitoMode)
			local icon = "willardnetworks/chat/ooc_icon.png"
			if !speaker or speaker and !IsValid(speaker) then
				return ix.util.GetMaterial(icon)
			end

			if iconIncognitoMode then return ix.util.GetMaterial(icon) end

			for mat, rankGroup in pairs(chatIconMap) do
				if (rankGroup[speaker:GetUserGroup()]) then
					icon = mat
				end
			end

			return ix.util.GetMaterial(hook.Run("GetPlayerIcon", speaker) or icon)
		end
		-- Out of character.
		ix.chat.Register("ooc", {
			CanSay = function(self, speaker, text)
				if (!ix.config.Get("allowGlobalOOC")) then
					speaker:NotifyLocalized("GOOCIsDisabled")
					return false
				else
					local delay = ix.config.Get("oocDelay", 10)

					-- Only need to check the time if they have spoken in OOC chat before.
					if (delay > 0 and speaker.ixLastOOC) then
						local lastOOC = CurTime() - speaker.ixLastOOC

						-- Use this method of checking time in case the oocDelay config changes.
						if (lastOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
							speaker:NotifyLocalized("oocDelay", delay - math.ceil(lastOOC))

							return false
						end
					end

					-- Save the last time they spoke in OOC.
					speaker.ixLastOOC = CurTime()
				end
			end,
			OnChatAdd = function(self, speaker, text, _, _, iconIncognitoMode)
				-- @todo remove and fix actual cause of speaker being nil
				if (!IsValid(speaker) or !ix.option.Get("seeGlobalOOC", true)) then
					return
				end

				local icon = GetIcon(speaker, iconIncognitoMode)
				if (CAMI.PlayerHasAccess(LocalPlayer(), "Helix - OOC See IC Name")) then
					chat.AddText(icon, Color(255, 66, 66), "[OOC] ", Color(192, 192, 196), speaker:SteamName()
								, " (", speaker:Name(), ")", color_white, ": ", text)
				else
					chat.AddText(icon, Color(255, 66, 66), "[OOC] ", Color(192, 192, 196), speaker:SteamName(), color_white, ": ", text)
				end
			end,
			prefix = {"//", "/OOC"},
			description = "@cmdOOC",
			noSpaceAfter = true
		})

		-- Local out of character.
		ix.chat.Register("looc", {
			CanSay = function(self, speaker, text)
				local delay = ix.config.Get("loocDelay", 0)

				-- Only need to check the time if they have spoken in OOC chat before.
				if (delay > 0 and speaker.ixLastLOOC) then
					local lastLOOC = CurTime() - speaker.ixLastLOOC

					-- Use this method of checking time in case the oocDelay config changes.
					if (lastLOOC <= delay and !CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil)) then
						speaker:NotifyLocalized("loocDelay", delay - math.ceil(lastLOOC))

						return false
					end
				end

				-- Save the last time they spoke in OOC.
				speaker.ixLastLOOC = CurTime()
			end,
			OnChatAdd = function(self, speaker, text, _, _, iconIncognitoMode)
				local icon = GetIcon(speaker, iconIncognitoMode)
				local name = hook.Run("GetCharacterName", speaker, "ic") or
					(IsValid(speaker) and speaker:Name() or "Console")
				
				chat.AddText(icon, Color(255, 66, 66), "[LOOC] ", Color(255, 254, 153, 255), name..": "..text)
			end,
			CanHear = ix.config.Get("chatRange", 280),
			prefix = {".//", "[[", "/LOOC"},
			description = "@cmdLOOC",
			noSpaceAfter = true
		})

		-- Roll information in chat.
		ix.chat.Register("roll", {
			format = "*** %s has rolled %s out of %s.",
			color = Color(155, 111, 176),
			CanHear = ix.config.Get("chatRange", 280),
			deadCanChat = true,
			OnChatAdd = function(self, speaker, text, bAnonymous, data)
				local max = data.max or 100
				local translated = L2(self.uniqueID.."Format", speaker:Name(), text, max)

				chat.AddText(self.color, translated and "*** "..translated or string.format(self.format,
					speaker:Name(), text, max
				))
			end
		})

		-- run a hook after we add the basic chat classes so schemas/plugins can access their info as soon as possible if needed
		hook.Run("InitializedChatClasses")
	end)
end

-- Private messages between players.
ix.chat.Register("pm", {
	format = "%s (%s): %s",
	color = Color(255, 255, 239, 61),
	deadCanChat = true,

	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		local client = LocalPlayer()

		if (ix.option.Get("standardIconsEnabled")) then
			if (speaker and client == speaker) then
				if !data.target or data.target and !IsValid(data.target) then return end

				chat.AddText(ix.util.GetMaterial("willardnetworks/chat/pm_icon.png"), Color(254, 238, 60), "[PM] »"
				, self.color, string.format(self.format, data.target:GetName(), data.target:SteamName(), text))
			else
				chat.AddText(ix.util.GetMaterial("willardnetworks/chat/pm_icon.png"), Color(254, 238, 60), "[PM] "
				, self.color, string.format(self.format, speaker:GetName(), speaker:SteamName(), text))
			end
		else
			if (client == speaker) then
				chat.AddText(Color(254, 238, 60), "[PM] »"
				, self.color, string.format(self.format, data.target:GetName(), data.target:SteamName(), text))
			else
				chat.AddText(Color(254, 238, 60), "[PM] "
				, self.color, string.format(self.format, speaker:GetName(), speaker:SteamName(), text))
			end
		end

		if (client != speaker and ix.option.Get("enablePrivateMessageSound", true)) then
			surface.PlaySound("hl1/fvox/bell.wav")
		end
	end
})

-- Global events.
ix.chat.Register("event", {
	CanHear = 1000000,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(254, 138, 0), text)
	end,
	indicator = "chatPerforming"
})

ix.chat.Register("connect", {
	CanSay = function(self, speaker, text)
		return !IsValid(speaker)
	end,
	OnChatAdd = function(self, speaker, text)
		local icon = ix.util.GetMaterial("willardnetworks/chat/connected_icon.png")

		chat.AddText(icon, Color(151, 153, 152), L("playerConnected", text))
	end,
	noSpaceAfter = true
})

ix.chat.Register("disconnect", {
	CanSay = function(self, speaker, text)
		return !IsValid(speaker)
	end,
	OnChatAdd = function(self, speaker, text)
		local icon = ix.util.GetMaterial("willardnetworks/chat/disconnected_icon.png")

		chat.AddText(icon, Color(151, 153, 152), L("playerDisconnected", text))
	end,
	noSpaceAfter = true
})

ix.chat.Register("notice", {
	CanSay = function(self, speaker, text)
		return !IsValid(speaker)
	end,
	OnChatAdd = function(self, speaker, text, bAnonymous, data)
		local icon = ix.util.GetMaterial(data.bError and "icon16/comment_delete.png" or "icon16/comment.png")
		chat.AddText(icon, data.bError and Color(200, 175, 200, 255) or Color(175, 200, 255), text)
	end,
	noSpaceAfter = true
})

-- Why does ULX even have a /me command?
hook.Remove("PlayerSay", "ULXMeCheck")
