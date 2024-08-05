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

PLUGIN.name = "DND-Styled Attribute/Skill Rolls"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Adds dnd-styled attribute and skill-specific rolls."
PLUGIN.rolls = {}
PLUGIN.skillRolls = {}

if (SERVER) then
	ix.log.AddType("rollStat", function(client, roll, attribute, attributeName, maxRoll)
		return string.format("%s rolled %s out of %s (+%s from %s).", client:Name(), roll, tostring(maxRoll), attribute, attributeName)
	end)

	ix.log.AddType("rollSkill", function(client, roll, skill, skillName, maxRoll)
		return string.format("%s rolled %s out of %s (+%s from %s).", client:Name(), roll, tostring(maxRoll), skill, skillName)
	end)
end

-- This is dirty, but it's better than editing core.
function PLUGIN:InitializedPlugins()
	ix.command.list["roll"] = ix.command.list["attributeroll"]
	ix.command.list["roll"].name = "Roll"
	ix.command.list["roll"].uniqueID = "roll"
	
	ix.command.list["attributeroll"] = nil
end

ix.lang.AddTable("english", {
	cmdAttributeRoll = "Rolls a number between 0 and 20, with the ability to add bonuses from attributes.",
	cmdSkillRoll = "Rolls a number between 0 and 100, with the ability to add bonuses from skills.",
	invalidSkill = "That is not a valid skill!",
	chatRolling = "Rolling...",
})

-- Generic roll
PLUGIN.rolls["generic"] = function(client, maxRoll)
	if (!IsValid(client)) then
		return
	end

	local roll = math.random(1, maxRoll)

	ix.chat.Send(client, "rollStat", tostring(roll), nil, nil, {boosted = false, maxRoll = maxRoll})
	ix.log.Add(client, "roll", roll, maxRoll)
end

for k, v in pairs(ix.special.list) do
	PLUGIN.rolls[k] = function(client, maxRoll)
		if (!IsValid(client)) then
			return
		end

		local character = client:GetCharacter()
		local attribute = character:GetSpecial(k)
		local boost = character:GetSpecialBoost(k)
		local roll = math.random(1, maxRoll)

		ix.chat.Send(client, "rollStat", tostring(roll), nil, nil, {boosted = true, stat = v.name, statBoost = attribute, rollBoost = boost, rollTotal = roll + attribute + boost, maxRoll = maxRoll})
		ix.log.Add(client, "rollStat", roll, attribute, v.name, maxRoll)
	end
end

local skillBoostLookup = {
	["cooking"] = {"perception", "intelligence"},
	["crafting"] = {"intelligence", "strength"},
	["guns"] = {"strength", "perception"},
	["medicine"] = {"intelligence", "agility"},
	["melee"] = {"strength", "agility"},
	["smuggling"] = {"agility", "perception"},
	["speed"] = {"agiility", "strength"},
	["vort"] = {"perception", "agiility"}
}

for k, v in pairs(ix.skill.list) do
	PLUGIN.skillRolls[k] = function(client, maxRoll)
		if (!IsValid(client)) then
			return
		end

		local character = client:GetCharacter()
		local skill = character:GetSkill(k)
		local boost = character:GetSkillBoostLevels(k)
		local nerf = character:GetSkillNeedsReducing(k)
		local roll = math.random(1, maxRoll)

		ix.chat.Send(client, "rollSkill", tostring(roll), nil, nil, {stat = v.name, statBoost = skill, rollBoost = boost, rollNerf = nerf, rollTotal = roll + skill + boost - nerf, maxRoll = maxRoll})
		ix.log.Add(client, "rollSkill", roll, skill, v.name, maxRoll)
	end
end

local CLASS = {}

CLASS.indicator = "chatRolling"
CLASS.format = "** %s has rolled a %s d%s, they rolled %s out of %s. Adding +%s from their attribute roll, and +%s from their attribute boost, the total is %s."
CLASS.formatAlt = "** %s has rolled a Generic d%s, they rolled %s out of %s."
CLASS.color = Color(155, 111, 176)

function CLASS:CanHear(speaker, listener)
	local chatRange = ix.config.Get("chatRange", 280)

	return (speaker:GetPos() - listener:GetPos()):LengthSqr() <= (chatRange * chatRange)
end

function CLASS:OnChatAdd(speaker, text, anonymous, data)
	local characterName = hook.Run("GetCharacterName", speaker, "roll") or speaker:Name()

	if (data.boosted) then
		chat.AddText(self.color, string.format(self.format, characterName, data.stat, tostring(data.maxRoll), text, tostring(data.maxRoll), tostring(data.statBoost), tostring(data.rollBoost), tostring(data.rollTotal)))
	else
		chat.AddText(self.color, string.format(self.formatAlt, characterName, tostring(data.maxRoll), text, tostring(data.maxRoll)))
	end
end

ix.chat.Register("rollStat", CLASS)

local CLASS = {}

CLASS.indicator = "chatRolling"
CLASS.format = "** %s has rolled a %s d%s, they rolled %s out of %s. Adding +%s from their skill roll, +%s from their skill boost, and removing -%s from their skill nerf, the total is %s."
CLASS.color = Color(155, 111, 176)

function CLASS:CanHear(speaker, listener)
	local chatRange = ix.config.Get("chatRange", 280)

	return (speaker:GetPos() - listener:GetPos()):LengthSqr() <= (chatRange * chatRange)
end

function CLASS:OnChatAdd(speaker, text, anonymous, data)
	local characterName = hook.Run("GetCharacterName", speaker, "roll") or speaker:Name()

	chat.AddText(self.color, string.format(self.format, characterName, data.stat, tostring(data.maxRoll), text, tostring(data.maxRoll), tostring(data.statBoost), tostring(data.rollBoost), tostring(data.rollNerf), tostring(data.rollTotal)))
end

ix.chat.Register("rollSkill", CLASS)

local COMMAND = {}

COMMAND.description = "@cmdAttributeRoll"
COMMAND.arguments = {
	bit.bor(ix.type.string, ix.type.optional),
	bit.bor(ix.type.number, ix.type.optional)
}

local argNames = "generic | "

for attributeName, _ in pairs(ix.special.list) do
	argNames = argNames .. attributeName .. " | "
end

argNames = string.Left(argNames, #argNames - 3)
COMMAND.argumentNames = {argNames, "Maximum Roll"}

function COMMAND:OnRun(client, attribute, maxRoll)
	local requestedRoll = "generic"
	local maximumRoll = 20
	
	if (attribute and attribute != "") then
		attribute = string.lower(attribute)
	end

	if (ix.special.list[attribute]) then
		requestedRoll = attribute
	end

	local attributeRoll = PLUGIN.rolls[requestedRoll]

	if (!attributeRoll) then
		attributeRoll = PLUGIN.rolls["generic"]
	end

	if (maxRoll and maxRoll > 0) then
		maximumRoll = maxRoll
	end

	attributeRoll(client, maximumRoll)
end

ix.command.Add("AttributeRoll", COMMAND)

COMMAND = {}

COMMAND.description = "@cmdSkillRoll"
COMMAND.arguments = {
	bit.bor(ix.type.string, ix.type.optional),
	bit.bor(ix.type.number, ix.type.optional)
}

local argNames = ""

for skillName, _ in pairs(ix.skill.list) do
	if (skillName == "bartering") then continue end

	argNames = argNames .. skillName .. " | "
end

argNames = string.Left(argNames, #argNames - 3)
COMMAND.argumentNames = {argNames, "Maximum Roll"}

function COMMAND:OnRun(client, skill, maxRoll)
	local requestedRoll
	local maximumRoll = 100
	
	if (skill and skill != "") then
		skill = string.lower(skill)
	end

	if (ix.skill.list[skill]) then
		requestedRoll = skill
	end

	if (maxRoll and maxRoll > 0) then
		maximumRoll = maxRoll
	end

	local skillRoll = PLUGIN.skillRolls[requestedRoll]

	if (!requestedRoll or !skillRoll) then
		return "@invalidSkill"
	end

	skillRoll(client, maximumRoll)
end

ix.command.Add("SkillRoll", COMMAND)
