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
local PLUGIN = PLUGIN

ix.languages = ix.languages or {}
ix.languages.stored = ix.languages.stored or {}

--[[
	Begin defining the language class base for other languages to inherit from.
--]]

--[[ Set the __index meta function of the class. --]]
--luacheck: globals CLASS_TABLE
local CLASS_TABLE = {__index = CLASS_TABLE}

CLASS_TABLE.name = "Language Base"
CLASS_TABLE.uniqueID = "language_base"
CLASS_TABLE.gibberish = {}
CLASS_TABLE.color = Color(102, 204, 255)
CLASS_TABLE.format = "%s says in language \"%s\""

-- Called when the language is converted to a string.
function CLASS_TABLE:__tostring()
	return "LANGUAGE["..self.name.."]"
end

--[[
	A function to override language base data. This is
	just a nicer way to set a value to go along with
	the method of querying.
--]]
function CLASS_TABLE:Override(varName, value)
	self[varName] = value
end

-- A function to register a new language.
function CLASS_TABLE:Register()
	return ix.languages:Register(self)
end

function CLASS_TABLE:PlayerCanSpeakLanguage(client)
	return ix.languages:PlayerCanSpeakLanguage(self.uniqueID, client)
end

--[[
	End defining the base language class.
	Begin defining the language utility functions.
--]]

-- A function to get all languages.
function ix.languages:GetAll()
	return self.stored
end

-- A function to get a new language.
function ix.languages:New(language)
	local object = {}
		setmetatable(object, CLASS_TABLE)
		CLASS_TABLE.__index = CLASS_TABLE
	return object
end

local function CanSay(self, speaker, text)
	local language = ix.languages:FindByID(self.langID)

	if (language:PlayerCanSpeakLanguage(speaker)) then
		return true
	end

	speaker:NotifyLocalized("I don't know this language..")
	return false
end

local OnChatAdd
if (CLIENT) then
	OnChatAdd = function(self, speaker, text, anonymous)
		local language = ix.languages:FindByID(self.langID)
		local icon = language.icon or nil
		if icon then
			icon = ix.util.GetMaterial(icon)
		end

		local name = anonymous and L"someone" or
		hook.Run("GetCharacterName", speaker, "ic") or
		(IsValid(speaker) and speaker:Name() or "Console")
		
		text = ix.chat.Format(text)
		
		if language:PlayerCanSpeakLanguage(LocalPlayer()) then
			self.format = "%s "..self.sayType.." in "..language.name.." \"%s\""
			if icon and ix.option.Get("languageFlagsEnabled") then
				chat.AddText(icon, self.color, string.format(self.format, name, text))
			else
				chat.AddText(self.color, string.format(self.format, name, text))
			end

			if self.langID == "vort" and IsValid(speaker) and speaker:IsVortigaunt() then
				if string.find(self.sayType, "shout") then
					PLUGIN:DoVortShout(speaker)
				end
			end
		else
			if language.gibberish then
				if istable(language.gibberish) then
					if !table.IsEmpty(language.gibberish) then
						local gibberish = language.gibberish
						local recreateLast = false
						local endText = string.utf8sub(text, -1)  -- Is it shout, question or period? If yes save it to recreate it after gibberish.
						if (endText == "." or endText == "!" or endText == "?") then
							recreateLast = true
						end

						local splitWords = string.Split(text, " ")
						text = ""

						for _, _ in pairs(splitWords) do
							if math.random(0,5) == 3 then
								text = text..gibberish[math.random( #gibberish )].."'"
							else
								text = text..gibberish[math.random( #gibberish )].." "
							end
						end

						-- Remove space at end
						text = string.TrimRight(text)
						-- Make a period at the ending.
						if (recreateLast) then
							text = (text..endText)
						end

						endText = string.utf8sub(text, -1)
						if (endText != "." and endText != "!" and endText != "?") then
							text = (text..".")
						end

						-- Make capital at start
						local editCapital = string.utf8sub(text, 1, 1)
						text = (string.utf8upper(editCapital)..string.utf8sub(text, 2, string.utf8len(text)))

						self.format = "%s "..self.sayType.." in "..language.name.." \"%s\""
						if icon and ix.option.Get("languageFlagsEnabled") then
							chat.AddText(icon, self.color, string.format(self.format, name, text))
						else
							chat.AddText(self.color, string.format(self.format, name, text))
						end

						return
					end
				end
			end

			if icon and ix.option.Get("languageFlagsEnabled") then
				chat.AddText(icon, self.color, string.format(self.format, name))
			else
				chat.AddText(self.color, string.format(self.format, name))
			end
		end
	end
end

-- A function to register a new language.
function ix.languages:Register(language)
	language.uniqueID = string.utf8lower(string.gsub(language.uniqueID or string.gsub(language.name, "%s", "_"), "['%.]", ""))
	self.stored[language.uniqueID] = language

	local languageClass = {}
	languageClass.color = language.color or Color(102, 204, 255)
	languageClass.sayType = "says"
	languageClass.format = "%s "..languageClass.sayType.." something in "..language.name
	languageClass.CanHear = ix.config.Get("chatRange", 280)
	languageClass.description = "Allows you to say something in "..language.name.." if you know the language."
	languageClass.indicator = "chatTalking"
	languageClass.prefix = {"/"..language.uniqueID, "/"..string.utf8lower(language.name)}
	languageClass.langID = language.uniqueID
	languageClass.CanSay = CanSay

	if (CLIENT) then
		languageClass.OnChatAdd = OnChatAdd
	end

	ix.chat.Register(language.uniqueID, languageClass)

	if (CLIENT) then
		ix.command.list[language.uniqueID].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list[string.utf8lower(language.name)].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list[language.uniqueID].combineBeep = true
		ix.command.list[string.utf8lower(language.name)].combineBeep = true
	end

	local languageClassWhisper = {}
	languageClassWhisper.sayType = "whispers"
	languageClassWhisper.CanHear = ix.config.Get("chatRange", 280) * 0.25
	languageClassWhisper.format = languageClass.format
	languageClassWhisper.indicator = "chatWhispering"
	languageClassWhisper.prefix = {"/w"..language.uniqueID, "/w"..string.utf8lower(language.name)}
	languageClassWhisper.description = "Allows you to whisper something in "..language.name.." if you know the language."
	languageClassWhisper.langID = language.uniqueID
	languageClassWhisper.CanSay = CanSay
	languageClassWhisper.color = Color(102 - 35, 204 - 35, 255 - 35)

	if (CLIENT) then
		languageClassWhisper.OnChatAdd = OnChatAdd
	end

	ix.chat.Register("w"..language.uniqueID, languageClassWhisper)

	if (CLIENT) then
		ix.command.list["w"..language.uniqueID].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list["w"..string.utf8lower(language.name)].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list["w"..language.uniqueID].combineBeep = true
		ix.command.list["w"..string.utf8lower(language.name)].combineBeep = true
	end

	local languageClassYell = {}
	languageClassYell.sayType = "yells"
	languageClassYell.format = languageClass.format
	languageClassYell.CanHear = ix.config.Get("chatRange", 280) * 2
	languageClassYell.indicator = "chatYelling"
	languageClassYell.prefix = {"/y"..language.uniqueID, "/y"..string.utf8lower(language.name)}
	languageClassYell.description = "Allows you to yell something in "..language.name.." if you know the language."
	languageClassYell.langID = language.uniqueID
	languageClassYell.CanSay = CanSay
	languageClassYell.color = Color(102 + 35, 204 + 35, 255 + 35)

	if (CLIENT) then
		languageClassYell.OnChatAdd = OnChatAdd
	end

	ix.chat.Register("y"..language.uniqueID, languageClassYell)

	if (CLIENT) then
		ix.command.list["y"..language.uniqueID].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list["y"..string.utf8lower(language.name)].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
		ix.command.list["y"..language.uniqueID].combineBeep = true
		ix.command.list["y"..string.utf8lower(language.name)].combineBeep = true
	end

	if language.uniqueID == "vort" then
		local languageClassShout = {}
		languageClassShout.sayType = "shouts"
		languageClassShout.format = languageClass.format
		languageClassShout.CanHear = ix.config.Get("chatRange", 280) * 20
		languageClassShout.indicator = "chatYelling"
		languageClassShout.prefix = "/vortshout"
		languageClassShout.description = "Uses the vortigese language and has an extremely large range, able to cover at least half a map."
		languageClassShout.langID = language.uniqueID
		languageClassShout.CanSay = CanSay
		languageClassShout.color = Color(51, 153, 51)

		if (CLIENT) then
			languageClassShout.OnChatAdd = OnChatAdd
		end

		ix.chat.Register("vortshout", languageClassShout)

		if (CLIENT) then
			ix.command.list["vortshout"].OnCheckAccess = function(_, client) return language:PlayerCanSpeakLanguage(client) end
			ix.command.list["vortshout"].combineBeep = true
		end
	end
end

-- A function to get a language by its name.
function ix.languages:FindByID(identifier)
	if (identifier and identifier != 0 and type(identifier) != "boolean") then
		if (self.stored[identifier]) then
			return self.stored[identifier]
		end

		local lowerName = string.utf8lower(identifier)
		local language = nil

		for _, v in pairs(self.stored) do
			local languageName = v.name

			if (string.find(string.utf8lower(languageName), lowerName)
			and (!language or string.utf8len(languageName) < string.utf8len(language.name))) then
				language = v
			end
		end

		return language
	end
end

-- Called when the language is initialized
function ix.languages:Initialize()
	local languages = self:GetAll()

	for _, v in pairs(languages) do
		if (v.OnSetup) then
			v:OnSetup()
		end
	end
end

-- Called when a player attempts to speak a language
function ix.languages:PlayerCanSpeakLanguage(language, client)
	if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then return true end
	local clientFaction = client:Team()
	if clientFaction then
		if (ix.faction.Get(clientFaction).allLanguages) then
			return true
		end
	end

	local languages = client:GetCharacter():GetLanguages()
	if (languages) then
		if (!table.IsEmpty(languages) and table.HasValue(languages, language)) then
			return true
		end
	end

	return false
end

if (CLIENT) then
	ix.option.Add("languageFlagsEnabled", ix.type.bool, true, {
		category = "chat"
	})
end

ix.command.Add("CharSetLanguage", {
	description = "Add a language to a character's vocabulary.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.text},
	alias = "CharSetBilingual",
	OnRun = function(self, client, character, lang)
		if (character) then
			local language = ix.languages:FindByID(lang)
			if (language) then
				local knownLanguages = character:GetLanguages()
				if (table.HasValue(knownLanguages, language.uniqueID)) then
					client:NotifyLocalized("This character already knows "..language.name.."!")
					return false
				else
					table.insert(knownLanguages, language.uniqueID)
					character:SetLanguages(knownLanguages)
					client:NotifyLocalized("You have extended "..character:GetName().."'s vocabulary with "..language.name)
				end
			else
				client:NotifyLocalized("This language does not exist!")
				return false
			end
		else
			client:NotifyLocalized("Could not find this character!")
			return false
		end
	end
})

ix.command.Add("CharRemoveLanguage", {
	description = "Remove a language to a character's vocabulary.",
	adminOnly = true,
	arguments = {ix.type.character, ix.type.text},
	OnRun = function(self, client, character, lang)
		if (character) then
			local language = ix.languages:FindByID(lang)
			if (language) then
				local knownLanguages = character:GetLanguages()
				if (!table.HasValue(knownLanguages, language.uniqueID)) then
					client:NotifyLocalized("This character doesn't know "..language.name.."!")
					return false
				else
					table.RemoveByValue(knownLanguages, language.uniqueID)
					character:SetLanguages(knownLanguages)
					client:NotifyLocalized("You have removed "..language.name.." from "..character:GetName().."'s vocabulary.")
				end
			else
				client:NotifyLocalized("This language does not exist!")
				return false
			end
		else
			client:NotifyLocalized("Could not find this character!")
			return false
		end
	end
})
