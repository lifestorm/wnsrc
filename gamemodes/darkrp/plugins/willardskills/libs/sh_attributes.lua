--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- registers the attributes as ix.special and ix.special.list
-- registers the functions:
-- ix.special.GetSpecial() - returns attributes on character
-- ix.special.RegisterAttributes(uniqueID, data) - registers attribute specified
-- ix.special.Find(attribute) - finds the attribute specified

ix.special = ix.special or {}
ix.special.list = ix.special.list or {}

if (SERVER) then
	ix.log.AddType("specialBoostExtend", function(client, name, type, level)
		return string.format("%s extended their level %d %s boost in %s.", client:GetName(), level, type, name)
	end)
	ix.log.AddType("specialBoostLevel", function(client, name, type, level)
		return string.format("%s has gained a level %d %s boost in %s.", client:GetName(), level, type, name)
	end)
	ix.log.AddType("specialBoostTarget", function(client, name, type, level, current)
		return string.format("%s has updated their %s %s boost target to %d (current : %d).", client:GetName(), name, type, level, current)
	end)
	ix.log.AddType("specialBoostWasted", function(client, name, type, level, current, target)
		return string.format("%s has wasted a level %d %s boost in %s (current: %d; target: %d).", client:GetName(), level, type, name, current, target)
	end)
end

ix.char.RegisterVar("special", {
	default = {},
	isLocal = true,
	bNoDisplay = true,
	field = "special",
	fieldType = ix.type.text,
	OnSet = function(character, attribute, value)
		local special = ix.special:Find(attribute)
		if (!special) then return end

		local attributes = character:GetSpecial()
		local client = character:GetPlayer()

		attributes[special.uniqueID] = math.Clamp(value, 0, 10)

		if (IsValid(client)) then
			net.Start("ixAttributeTbl")
				net.WriteUInt(character:GetID(), 32)
				net.WriteString(special.uniqueID)
				net.WriteInt(value, 8)
			net.Send(client)
		end

		character.vars.special = attributes
	end,
	OnGet = function(character, key, default)
		local data = character.vars.special or {}

		if (key) then
			if (!data) then	return 0 end

			return data[key] != nil and data[key] or 0
		else
			return data
		end
	end,
	OnValidate = function(self, value, data, client)
		if (value != nil) then
			if (istable(value)) then
				local count = 0

				for _, v in pairs(value) do
					count = count + v
				end

				if (count > (hook.Run("GetDefaultAttributePoints", client, data) or ix.config.Get("maxAttributes", 30))) then
					return false, "unknownError"
				end
			else
				return false, "unknownError"
			end
		end
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.special = value
	end
})

ix.char.RegisterVar("specialBoost", {
	default = {},
	isLocal = true,
	bNoDisplay = true,
	field = "special_boost",
	fieldType = ix.type.text,
	OnSet = function(character, attribute, value, bShort)
		local client = character:GetPlayer()
		if (!value and type(attribute) == "table") then
			character.vars.specialBoost = attribute
			if (IsValid(client)) then
				net.Start("ixAttributeBoostTbl")
					net.WriteUInt(character:GetID(), 32)
					net.WriteTable(attribute)
				net.Send(client)
			end

			return
		end

		local special = ix.special:Find(attribute)
		if (!special) then return end

		local boosts = character:GetSpecialBoost()
		if (!boosts[special.uniqueID]) then
			boosts[special.uniqueID] = {}
		end

		local index = bShort and "short" or "long"
		if (!boosts[special.uniqueID][index]) then
			boosts[special.uniqueID][index] = {
				level = 0,
				time = (bShort and 10) or 30,
				target = value,
				targetDuration = (bShort and 15 * 60) or 6 * 60
			}
			ix.log.Add(client, "specialBoostLevel", special.name, index, value)
		else
			local currentBoost = boosts[special.uniqueID][index]
			if (currentBoost.level == value and currentBoost.target <= value) then
				currentBoost.time = (bShort and 15 * 60) or 6 * 60
				currentBoost.target = 0
				currentBoost.targetDuration = 0
				ix.log.Add(client, "specialBoostExtend", special.name, index, value)
			elseif (currentBoost.level < value and currentBoost.target < value) then
				if (currentBoost.target < currentBoost.level) then
					currentBoost.time = (bShort and 10) or 30
				end
				currentBoost.target = value
				currentBoost.targetDuration = (bShort and 15 * 60) or 6 * 60
				ix.log.Add(client, "specialBoostLevel", special.name, index, value)
			elseif (currentBoost.level > value and (currentBoost.target <= value or currentBoost.target == 0)) then
				currentBoost.target = value
				currentBoost.targetDuration = ((bShort and 15 * 60) or 6 * 60) - currentBoost.time
				ix.log.Add(client, "specialBoostTarget", special.name, index, value, currentBoost.level)
			else
				ix.log.Add(client, "specialBoostWasted", special.name, index, value, currentBoost.level, currentBoost.target)
			end
		end

		if (IsValid(client)) then
			net.Start("ixAttributeBoostTbl")
				net.WriteUInt(character:GetID(), 32)
				net.WriteTable(boosts)
			net.Send(client)
		end

		character.vars.specialBoost = boosts
	end,
	OnGet = function(character, attributeID)
		local data = character.vars.specialBoost or {}

		if (attributeID) then
			if (!data or !data[attributeID]) then return 0 end

			local short = (data[attributeID].short and data[attributeID].short.level) or 0
			local long = (data[attributeID].long and data[attributeID].long.level) or 0

			return short + long
		else
			return data
		end
	end
})

if (CLIENT) then
	net.Receive("ixAttributeTbl", function()
		local id = net.ReadUInt(32)
		local character = ix.char.loaded[id]

		if (character) then
			character.vars.special = character.vars.special or {}
			character.vars.special[net.ReadString()] = net.ReadInt(8)
		end
	end)

	net.Receive("ixAttributeBoostTbl", function()
		local id = net.ReadUInt(32)
		local character = ix.char.loaded[id]

		if (character) then
			character.vars.specialBoost = net.ReadTable()
		end
	end)
else
	util.AddNetworkString("ixAttributeTbl")
	util.AddNetworkString("ixAttributeBoostTbl")
end

function ix.special:RegisterAttribute(uniqueID, data)
	if (!uniqueID or type(uniqueID) != "string") then
		ErrorNoHalt("Attempted to register attribute without valid uniqueID.")
		return
	end

	data.uniqueID = uniqueID

	data.name = data.name or "Unknown"
	data.description = data.description or "No description given."

	if (data.skills) then
		for skillID, _ in pairs(data.skills) do
			ix.skill:RegisterAttribute(skillID, data)
		end
	end

	ix.special.list[uniqueID] = data
end

function ix.special:Find(attribute)
	if (ix.special.list[attribute]) then
		return ix.special.list[attribute]
	else
		attribute = string.utf8lower(attribute)
		for _, data in pairs(ix.special.list) do
			if (string.find(string.utf8lower(data.name), attribute)) then
				return data
			end
		end
	end
end

do
	local CHAR = ix.meta.character

	function CHAR:GetAttrBoostLevels(attribute, skill)
		return self:GetBoostedAttribute(attribute.uniqueID) * (attribute.skills[skill.uniqueID] or 0)
	end

	function CHAR:GetBoostedAttribute(attributeID)
		return math.Clamp(self:GetSpecial(attributeID) + self:GetSpecialBoost(attributeID), -10, 10)
	end
end