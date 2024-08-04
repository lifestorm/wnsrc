--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local util = util
local ix = ix
local string = string
local timer = timer
local GetNetVar = GetNetVar
local unpack = unpack
local math = math
local EmitSentence = EmitSentence
local SentenceDuration = SentenceDuration
local net = net


local PLUGIN = PLUGIN

util.AddNetworkString("ixTypingBeep")
util.AddNetworkString("ixVisorNotify")

ix.log.AddType("combineSuitsAdminActivate", function(client, item, bDeactivate)
	return string.format("%s has admin-%sactivated a '%s' (#%d)", client:GetName(), bDeactivate and "de" or "", item:GetName(), item:GetID())
end)
ix.log.AddType("combineSuitsAdminTracking", function(client, item, bDeactivate)
	return string.format("%s has admin-%sactivated the tracker on a '%s' (#%d)", client:GetName(), bDeactivate and "de" or "", item:GetName(), item:GetID())
end)
ix.log.AddType("combineSuitsAdminOwner", function(client, item)
	return string.format("%s has admin-disabled the owner on a '%s' (#%d)", client:GetName(), item:GetName(), item:GetID())
end)
ix.log.AddType("combineSuitsAdminOwnerClear", function(client, item)
	return string.format("%s has admin-cleared the owner on a '%s' (#%d)", client:GetName(), item:GetName(), item:GetID())
end)
ix.log.AddType("combineSuitsAdminName", function(client, item)
	return string.format("%s has admin-changed the name a '%s' (#%d) to %s.", client:GetName(), item:GetName(), item:GetID(), item:GetData("ownerName"))
end)

PLUGIN.voiceLines = {
	["METROPOLICE_IDLE"] = 7,
	["METROPOLICE_IDLE_CHECK"] = 3,
	["METROPOLICE_IDLE_CLEAR"] = 18,
	["METROPOLICE_IDLE_QUEST"] = 7,
	["METROPOLICE_IDLE_ANSWER"] = 6,
	["METROPOLICE_HEARD_SOMETHING"] = 3,
	["METROPOLICE_IDLE_CR"] = 18,
	["METROPOLICE_IDLE_CHECK_CR"] = 7,
	["METROPOLICE_IDLE_CLEAR_CR"] = 4,
	["METROPOLICE_IDLE_QUEST_CR"] = 6,
	["METROPOLICE_IDLE_ANSWER_CR"] = 6,
	["COMBINE_IDLE"] = 4,
	["COMBINE_CHECK"] = 2,
	["COMBINE_CLEAR"] = 6,
	["COMBINE_QUEST"] = 5,
	["COMBINE_ANSWER"] = 4,
	["COMBINE_ALERT"] = 9,
}

PLUGIN.cpLines = {
	{"METROPOLICE_IDLE"},
	{"METROPOLICE_IDLE_CHECK", "METROPOLICE_IDLE_CLEAR"},
	{"METROPOLICE_IDLE_QUEST", "METROPOLICE_IDLE_ANSWER"},
	{"METROPOLICE_HEARD_SOMETHING", "METROPOLICE_IDLE_CLEAR", 2}
}
PLUGIN.cpLinesCR = {
	{"METROPOLICE_IDLE_CR"},
	{"METROPOLICE_IDLE_CHECK_CR", "METROPOLICE_IDLE_CLEAR_CR"},
	{"METROPOLICE_IDLE_QUEST_CR", "METROPOLICE_IDLE_ANSWER_CR"},
	{"METROPOLICE_HEARD_SOMETHING", "METROPOLICE_IDLE_CLEAR_CR", 2}
}
PLUGIN.otaLines = {
	{"COMBINE_IDLE"},
	{"COMBINE_CHECK", "COMBINE_CLEAR"},
	{"COMBINE_QUEST", "COMBINE_ANSWER"},
	{"COMBINE_ALERT"}
}
PLUGIN.otaLinesBlue = {
	{"COMBINE_CHECK", "COMBINE_CLEAR", false, 600},
}

function PLUGIN:ClientChatter(client, uniqueID)
	local character = client:GetCharacter()
	if (!character) then return end

	if (client:IsAFK() or
			(client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) or
			!client:Alive() or
			!ix.option.Get(client, "ChatterEnabled", true) or
			!client:HasActiveCombineMask()) then
		-- Reset a reply if one is still pending
		if (client.ixSentenceReply) then
			timer.Adjust(uniqueID, ix.option.Get(client, "ChatterInterval", 120))
			client.ixSentenceReply = nil
			client.ixSentenceReplyInterval = nil
		end
		return
	end

	if (client.ixSentenceReply) then
		self:EmitSentence(client, client.ixSentenceReply,  nil, nil, client.ixSentenceReplyInterval)
		client.ixSentenceReply = nil
		return
	end

	local suit = client:GetActiveCombineSuit()
	local soundTable
	if (suit.isCP) then
		if (GetNetVar("visorColor", "blue") != "blue") then
			soundTable = self.cpLinesCR
		else
			soundTable = self.cpLines
		end
	elseif (suit.isOTA) then
		if (GetNetVar("visorColor", "blue") != "blue") then
			soundTable = self.otaLines
		else
			soundTable = self.otaLinesBlue
		end
	else
		return
	end

	self:EmitSentence(client, unpack(soundTable[math.random(#soundTable)]))
end

function PLUGIN:EmitSentence(client, sentence, answer, delay, interval)
	if (self.voiceLines[sentence]) then
		sentence = sentence..math.random(0, self.voiceLines[sentence])
	end
	EmitSentence(sentence, client:GetPos(), client:EntIndex(), CHAN_AUTO, 1, 75, 0, 100)

	if (answer) then
		client.ixSentenceReply = answer..math.random(0, self.voiceLines[answer])
		client.ixSentenceReplyInterval = interval or 30
		--luacheck: read globals SentenceDuration
		timer.Adjust("ixChatter"..client:SteamID64(), (delay or 0) + math.random(3, 5) + SentenceDuration(sentence))
	else
		interval = interval or ix.option.Get(client, "ChatterInterval", 120)
		timer.Adjust("ixChatter"..client:SteamID64(), math.random(interval, interval * 2))
	end
end

net.Receive("ixTypingBeep", function(len, client)
	if (net.ReadBool() == false and client.bTypingBeep) then
		client.bTypingBeep = nil

		local suit = client:GetActiveCombineSuit()
		if (!suit or !client:HasActiveCombineMask() or (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle())) then return end

		if (suit.isCP) then
			client:EmitSound("NPC_MetroPolice.Radio.Off")
		elseif (suit.isOTA) then
			client:EmitSound("voices/transhuman/radio/off"..math.random(1, 3)..".wav")
		end

		return
	end

	if (!client.bTypingBeep) then
		local suit = client:GetActiveCombineSuit()
		if (!suit or !client:HasActiveCombineMask() or (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle())) then return end

		if (suit.isCP) then
			client:EmitSound("NPC_MetroPolice.Radio.On")
			client.bTypingBeep = true
		elseif (suit.isOTA) then
			client:EmitSound("voices/transhuman/radio/on"..math.random(1, 2)..".wav")
			client.bTypingBeep = true
		end
	end
end)

function PLUGIN:ResetSCTimer(client, character)
	local delay = ix.config.Get("passiveStcTimer", 60)

	if (delay <= 0) then return end

	local uniqueID = "ixPassiveSC" .. client:SteamID64()

	timer.Create(uniqueID, 300, 0, function()
		if (ix.config.Get("suitsNoConnection")) then return end

		if (!IsValid(client) or !client:GetCharacter()) then
			timer.Remove(uniqueID)

			return
		end

		if (!client:GetActiveCombineSuit() or !client:HasActiveCombineMask() or client:IsAFK()) then return end

		local progress = character:GetPassiveSCProgress()

		if (progress < delay - 5) then
			character:SetPassiveSCProgress(progress + 5)
		else
			character.vars.genericdata.socialCredits = character.vars.genericdata.socialCredits + 1
			character:Save()

			character:SetPassiveSCProgress(0)
			self:ResetSCTimer(client, character)
		end
	end)
end
