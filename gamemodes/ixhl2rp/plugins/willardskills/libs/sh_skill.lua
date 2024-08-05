--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.skill = ix.skill or {}
ix.skill.list = ix.skill.list or {}
ix.skill.scale = ix.skill.scale or {}

ix.skill.MAX_SKILL = 50

if (SERVER) then
	ix.log.AddType("skillsGetSkill", function(client, name)
		return string.format("%s has selected the %s skill.", client:GetName(), name)
	end)
	ix.log.AddType("skillsRemovedSkill", function(client, name, oldXP)
		if (oldXP > 0) then
			return string.format("%s has removed the %s skill (experience was: %d).", client:GetName(), name, oldXP)
		else
			return string.format("%s has removed the %s skill.", client:GetName(), name)
		end
	end)
	ix.log.AddType("skillLevelUp", function(client, name, newExp)
		return string.format("%s has gained level %d in the %s skill.", client:GetName(), newExp, name)
	end)
end

ix.char.RegisterVar("skill", {
	default = {},
	isLocal = true,
	bNoDisplay = true,
	field = "skills",
	fieldType = ix.type.text,
	OnSet = function(character, skillID, level)
		if (!skillID) then
			ErrorNoHalt("Attempted to set level but no skillID was provided!")
			return
		end

		local skill = ix.skill:Find(skillID)
		if (!skill) then
			ErrorNoHalt("Attempted to set level on invalid skill "..skillID.."!")
			return
		end

		if (!level) then
			level = character:GetSkill(skill.uniqueID) + 1
		end

		level = math.floor(level)

		if (level < 0 or level > ix.skill.MAX_SKILL) then
			ErrorNoHalt("Attempted to set invalid level '"..level.."' on "..skill.name.."'.")
			return
		end

		local skills = character:GetSkill()
		local totalLevel = character:GetTotalSkillLevel()
		local currentLevel = skills[skill.uniqueID] or 0
		if (currentLevel <= level and totalLevel - currentLevel + level > ix.config.Get("MaxTotalSkill")) then
			ErrorNoHalt("Attempted to add level "..skill.name.." above total skill level!")
			return
		end


		local client = character:GetPlayer()
		if (IsValid(client) and (skills[skill.uniqueID] or 0) < level) then
			ix.log.Add(client, "skillLevelUp", skill.name, level)
			if (character:GetSkillAutoLevel(skill.uniqueID)) then
				client:NotifyLocalized("levelGained", skill.name, character:GetSkill(skill.uniqueID) + 1)
			end

			net.Start("ixSkillLevelUpSound")
			net.Send(client)
		end

		if (level > 0) then
			skills[skill.uniqueID] = level
		else
			skills[skill.uniqueID] = nil
		end
		character.vars.skill = skills

		if (IsValid(client)) then
			net.Start("ixCharacterSkill")
				net.WriteUInt(character:GetID(), 32)
				net.WriteString(skill.uniqueID)
				net.WriteUInt(skills[skill.uniqueID] or 0, 8)
			net.Send(client)
		end

		if (level == ix.skill.MAX_SKILL) then
			character:SetSkillStoredExp(skill.uniqueID)
		end
	end,
	OnGet = function(character, skillID)
		local skills = character.vars.skill or {}

		if (skillID) then
			if (!ix.skill:Find(skillID)) then
				ErrorNoHalt("Attempted to get skill level in invalid skill "..skillID..".")
			end
			return skills[skillID] != nil and skills[skillID] or 0
		else
			return skills
		end
	end,
	OnValidate = function(self, value, data, client)
		if (value != nil) then
			if (istable(value)) then
				local count = 0

				for _, v in pairs(value) do
					count = count + v
				end

				if (count > 10) then
					return false, "unknownError"
				end
			else
				return false, "unknownError"
			end
		end
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.skill = value
	end
})

ix.char.RegisterVar("skillAutoLevel", {
	default = {},
	isLocal = true,
	bNoDisplay = true,
	field = "skills_autolevel",
	fieldType = ix.type.text,
	OnSet = function(character, skillID)
		if (!skillID) then
			ErrorNoHalt("Attempted to set experience but no skillID was provided!")
			return
		end

		local skill = ix.skill:Find(skillID)
		if (!skill) then
			ErrorNoHalt("Attempted to set experience on invalid skill "..skillID.."!")
			return
		end

		local skills = character:GetSkillAutoLevel()
		skills[skill.uniqueID] = !skills[skill.uniqueID]
		character.vars.skillAutoLevel = skills

		-- Level skill if possible
		if (skills[skill.uniqueID] == true) then
			character:LevelUpSkill(skill.uniqueID)
		end

		local client = character:GetPlayer()
		if (IsValid(client)) then
			net.Start("ixCharacterSkillAutoLevel")
				net.WriteUInt(character:GetID(), 32)
				net.WriteString(skill.uniqueID)
				net.WriteBool(skills[skill.uniqueID])
			net.Send(client)
		end
	end,
	OnGet = function(character, skillID)
		local skills = character.vars.skillAutoLevel or {}

		if (skillID) then
			return skills[skillID] != nil and skills[skillID] or false
		else
			return skills
		end
	end
})

ix.char.RegisterVar("skillStoredExp", {
	default = {},
	isLocal = true,
	bNoDisplay = true,
	field = "skills_storedexp",
	fieldType = ix.type.text,
	OnSet = function(character, skillID, exp)
		if (!skillID) then
			ErrorNoHalt("Attempted to set stored experience but no skillID was provided!")
			return
		end

		local skill = ix.skill:Find(skillID)
		if (!skill) then
			ErrorNoHalt("Attempted to set stored experience on invalid skill "..skillID.."!")
			return
		end

		local skills = character:GetSkillStoredExp()
		if (character:GetSkill(skill.uniqueID) >= ix.skill.MAX_SKILL) then
			skills[skill.uniqueID] = nil
		elseif (isbool(exp)) then
			if (!skills[skill.uniqueID] or skills[skill.uniqueID] < 1000) then
				ErrorNoHalt("Attempted to level "..skill.name.." without enough stored experience!")
				return
			end

			skills[skill.uniqueID] = math.max(skills[skill.uniqueID] - 1000, 0)

			if (skills[skill.uniqueID] == 0 or character:GetSkill(skill.uniqueID) >= ix.skill.MAX_SKILL) then
				skills[skill.uniqueID] = nil
			end
		else
			exp = exp and math.floor(exp)
			if (!exp or exp < 0) then
				ErrorNoHalt("Attempted to set "..skill.name.." to invalid stored experience ("..(exp or "nil")..")!")
				return
			end

			if (character:GetSkill(skill.uniqueID) >= ix.skill.MAX_SKILL) then
				ErrorNoHalt("Attempted to add stored experience to "..skill.name.." which is max level already!")
				return
			end

			if (skills[skill.uniqueID] and skills[skill.uniqueID] + exp >= 2000) then
				ErrorNoHalt("Attempted to add stored experience to "..skill.name.." above total stored experience ceiling!")
			end

			skills[skill.uniqueID] = math.min((skills[skill.uniqueID] or 0) + exp, 1999)
		end

		character.vars.skillStoredExp = skills

		local client = character:GetPlayer()
		if (IsValid(client)) then
			net.Start("ixCharacterSkillStoredExp")
				net.WriteUInt(character:GetID(), 32)
				net.WriteString(skill.uniqueID)
				net.WriteInt(skills[skill.uniqueID] or -1, 32)
			net.Send(client)
		end
	end,
	OnGet = function(character, skillID)
		local skills = character.vars.skillStoredExp or {}

		if (skillID) then
			return skills[skillID] != nil and skills[skillID] or 0
		else
			return skills
		end
	end
})

if (CLIENT) then
	net.Receive("ixCharacterSkill", function()
		local id = net.ReadUInt(32)
		local character = ix.char.loaded[id]

		if (character) then
			local skill = net.ReadString()
			local level = net.ReadUInt(8)
			local skills = character:GetSkill()
			skills[skill] = (level != 0 and level) or nil

			character.vars.skill = skills

			if (IsValid(ix.gui.skills)) then
				ix.gui.skills.skillPanels[skill].skillLevel:SetText("Skill Level: "..character:GetSkillLevel(skill).."/"..ix.skill.MAX_SKILL)
			end
		end
	end)

	net.Receive("ixCharacterSkillAutoLevel", function()
		local id = net.ReadUInt(32)
		local character = ix.char.loaded[id]

		if (character) then
			local skill = net.ReadString()
			local skillAutoLevel = character:GetSkillAutoLevel()
			skillAutoLevel[skill] = net.ReadBool()

			character.vars.skillAutoLevel = skillAutoLevel

			if (IsValid(ix.gui.skills)) then
				ix.gui.skills.skillPanels[skill].autoLevel.autoLevel = skillAutoLevel[skill]
			end
		end
	end)

	net.Receive("ixCharacterSkillStoredExp", function()
		local id = net.ReadUInt(32)
		local character = ix.char.loaded[id]

		if (character) then
			local skill = net.ReadString()
			local exp = net.ReadInt(32)
			local skillStoredExp = character:GetSkillStoredExp()
			skillStoredExp[skill] = (exp != -1 and exp) or nil

			character.vars.skillStoredExp = skillStoredExp

			if (IsValid(ix.gui.skills)) then
				local progress = math.Clamp(character:GetSkillStoredExp(skill) / 1000, 0, 1)
				ix.gui.skills.skillPanels[skill].progressBar.progress = progress
				ix.gui.skills.skillPanels[skill].processLabel:SetupText(character)
			end
		end
	end)

	local levelCD = 0
	net.Receive("ixSkillLevelUpSound", function()
		if (levelCD < CurTime()) then
			surface.PlaySound("willardnetworks/skills/levelup.mp3")
			levelCD = CurTime() + 5
		end
	end)
else
	util.AddNetworkString("ixCharacterSkill")
	util.AddNetworkString("ixCharacterSkillAutoLevel")
	util.AddNetworkString("ixCharacterSkillStoredExp")
	util.AddNetworkString("ixSkillLevelUp")
	util.AddNetworkString("ixSkillSetAutoLevel")
	util.AddNetworkString("ixSkillLevelUpSound")

	net.Receive("ixSkillLevelUp", function(len, ply)
		local character = ply:GetCharacter()
		local skill = net.ReadString()

		if (character and character:CanLevelSkill(skill)) then
			character:LevelUpSkill(skill)
		end
	end)

	net.Receive("ixSkillSetAutoLevel", function(len, ply)
		local character = ply:GetCharacter()
		local skill = net.ReadString()

		if (character) then
			character:SetSkillAutoLevel(skill)
		end
	end)
end

function ix.skill:RegisterSkill(uniqueID, data)
	if (!uniqueID or type(uniqueID) != "string") then
		ErrorNoHalt("Attempted to register skill without valid uniqueID.")
		return
	end

	data.uniqueID = uniqueID

	data.name = data.name or "Unknown"
	data.description = data.description or "No description given."

	data.actions = data.actions or {}
	data.attributes = data.attributes or {}
	data.scale = data.scale or {}

	ix.skill.list[uniqueID] = data
end

function ix.skill:RegisterSkillAction(skillID, action)
	local skill = self:Find(skillID)
	if (!skill) then return end

	for k, v in ipairs(skill.actions) do
		if (v.uniqueID == action.uniqueID) then
			skill.actions[k] = action
			return
		end
	end

	skill.actions[#skill.actions + 1] = action
end

function ix.skill:RegisterAttribute(skillID, attribute)
	local skill = self:Find(skillID)
	if (!skill) then return end

	for k, v in ipairs(skill.attributes) do
		if (v.uniqueID == attribute.uniqueID) then
			skill.attributes[k] = attribute
			return
		end
	end

	skill.attributes[#skill.attributes + 1] = attribute
end

function ix.skill:RegisterSkillScale(skillID, uniqueID, data)
	local skill = self:Find(skillID)
	if (!skill) then return end

	data.uniqueID = uniqueID

	data.name = data.name or "Unknown"
	data.description = data.description or "No description given."

	data.minLevel = data.minLevel or 0
	data.maxLevel = data.maxLevel or self.MAX_SKILL

	data.minValue = data.minValue or 0
	data.increase = data.increase or 1

	data.digits = data.digits or 0

	data.skill = skill.uniqueID

	if (ix.skill.scale[uniqueID]) then
		for k, v in ipairs(skill.scale) do
			if v.uniqueID == uniqueID then
				skill.scale[k] = data
			end
		end
	else
		skill.scale[#skill.scale + 1] = data
	end

	ix.skill.scale[uniqueID] = data

	-- Register "non-recipe" for current skill scale
	local RECIPE = ix.recipe:New()

	RECIPE.uniqueID = "skillscale_"..uniqueID
	RECIPE.name = "Current "..data.name
	RECIPE.category = "Level Unlocks"
	RECIPE.noIngredients = true
	RECIPE.skillScale = true
	RECIPE.skillScaleID = uniqueID
	RECIPE.level = 0
	RECIPE.skill = skillID

	RECIPE:Register()
end

function ix.skill:Find(skill)
	-- finds a skill based on input by stripping caps on input and looking through DB recursive
	if (ix.skill.list[skill]) then
		return ix.skill.list[skill]
	else
		skill = string.utf8lower(skill)
		for _, data in pairs(ix.skill.list) do
			if (string.find(string.utf8lower(data.name), skill)) then
				return data
			end
		end
	end
end
