--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local CHAR = ix.meta.character

function CHAR:GetSkillLevel(skillID)
	local level = self:GetSkill(skillID) + self:GetSkillBoostLevels(skillID) - self:GetSkillNeedsReducing(skillID)

	return math.Clamp(level, 0, ix.skill.MAX_SKILL)
end

function CHAR:GetSkillNeedsReducing(skillID)
	local skill = ix.skill:Find(skillID)
	if (!skill) then return end

	local reduceLevels = 0
	local realLevel = self:GetSkill(skillID)
	local reducedHunger, reducedThirst, reducedGas, reducedHealth = false, false, false, false

	if (self.GetHunger and self.GetThirst) then
		local hunger, thirst = self:GetHunger(), self:GetThirst()

		if (hunger >= 50) then
			local math = realLevel * math.Remap(math.min(hunger, 100), 50, 100, 0, 0.5)

			reduceLevels = reduceLevels + math
			reducedHunger = math
		end

		if (thirst >= 50) then
			local math = realLevel * math.Remap(math.min(thirst, 100), 50, 100, 0, 0.5)

			reduceLevels = reduceLevels + math
			reducedThirst = math
		end
	end
	
	if (self.GetGasPoints) then
		local gasPointFraction = self:GetGasPoints() / 120
		
		if (gasPointFraction > 0.3) then
			local math = realLevel * math.Remap(math.min(gasPointFraction, 1), 0.3, 1, 0, 0.4)

			reduceLevels = reduceLevels + math
			reducedGas = math
		end
	end
	
	local health, maxHealth = self:GetPlayer():Health(), self:GetPlayer():GetMaxHealth()
	
	if (health <= maxHealth / 2) then
		local math = realLevel * math.Remap(math.min(health, maxHealth), 50, 100, 0, 0.5)

		reduceLevels = reduceLevels - math

		reducedHealth = math
	end

	return math.Round(math.min(reduceLevels, realLevel)), reducedHunger, reducedThirst, reducedGas, reducedHealth
end

function CHAR:GetSkillBoostLevels(skillID)
	local skill = ix.skill:Find(skillID)
	if (!skill) then return end

	local boostExp = 0
	for _, attr in ipairs(skill.attributes) do
		boostExp = boostExp + self:GetAttrBoostLevels(attr, skill)
	end

	return boostExp
end

function CHAR:GetSkillScale(scaleID)
	local scale = ix.skill.scale[scaleID]
	if (!scale) then return end

	if (scale.GetValue) then
		return scale:GetValue(self)
	end

	local skillLevel = self:GetSkillLevel(scale.skill)
	return math.Clamp(
		scale.minValue + scale.increase * (skillLevel - scale.minLevel) / (scale.maxLevel - scale.minLevel),
		scale.minValue, scale.minValue + scale.increase)
end

function CHAR:CanLevelSkill(skillID)
	local skill = ix.skill:Find(skillID)
	if (!skill) then return end

	return self:GetSkillStoredExp(skill.uniqueID) >= 1000 and self:GetSkill(skill.uniqueID) < ix.skill.MAX_SKILL and self:GetTotalSkillLevel() < ix.config.Get("MaxTotalSkill")
end

function CHAR:GetTotalSkillLevel()
	local skills = self:GetSkill()
	local totalLevel = 0
	for _, v in pairs(skills) do
		totalLevel = totalLevel + v
	end

	return totalLevel
end

if (SERVER) then
	function CHAR:LevelUpSkill(skillID)
		if (self:CanLevelSkill(skillID)) then
			self:AddSkillLevel(skillID, 1)
			self:SetSkillStoredExp(skillID, true)
		end
	end

	function CHAR:AddSkillExperience(skillID, experience, bDirect)

	end

	function CHAR:AddSkillLevel(skillID, amount)
		self:SetSkill(skillID, math.Clamp(self:GetSkill(skillID) + amount, 0, ix.skill.MAX_SKILL))
	end
end
