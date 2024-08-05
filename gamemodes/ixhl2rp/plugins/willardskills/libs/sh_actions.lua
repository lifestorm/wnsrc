--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- registers the actions as ix.action and ix.action.list
-- registers the functions:
-- ix.action.Getactions() - returns actions on character
-- ix.action.RegisterSkillAction(uniqueID, data) - registers action specified
-- ix.action.Find(action) - finds the action specified

ix.action = ix.action or {}
ix.action.list = ix.action.list or {}

local isfunction = isfunction

function ix.action:RegisterSkillAction(skillID, uniqueID, data)
	if (!uniqueID or type(uniqueID) != "string") then
		ErrorNoHalt("Attempted to register action without valid uniqueID.")
		return
	end

	data.uniqueID = uniqueID

	data.name = data.name or "Unknown"
	data.description = data.description or "No description given."

	if (data.DoResult and type(data.DoResult) == "table" and data.DoResult[1]) then
		table.SortByMember(data.DoResult, "level", true)
		local copy = {}
		for k, v in pairs(data.DoResult) do
			copy[v.level] = v.exp
		end

		local currExp = 0
		data.DoResult = {}
		for i = 0, ix.skill.MAX_SKILL - 1 do
			if (copy[i]) then currExp = copy[i] end
			data.DoResult[i] = currExp
		end
		data.DoResult[ix.skill.MAX_SKILL] = 0
	end

	if (!skillID or !ix.skill:Find(skillID)) then
		ErrorNoHalt("Attempted to register '"..uniqueID.."' action without valid skill.")
		return
	else
		data.skill = ix.skill:Find(skillID).uniqueID
		ix.skill:RegisterSkillAction(data.skill, data)
	end

	ix.action.list[uniqueID] = data
end

function ix.action:Find(actionID)
	if (ix.action.list[actionID]) then
		return ix.action.list[actionID]
	else
		for _, action in pairs(ix.action.list) do
			if (string.find(action.name:utf8lower(), actionID:utf8lower())) then
				return action
			end
		end
	end
end

if (SERVER) then
	ix.log.AddType("actionsDoAction", function(client, name, result, skill)
		return string.format("%s has performed the '%s' action, gaining %d experience in %s.", client:GetName(), name, result, skill)
	end)
	ix.log.AddType("actionsDoActionNoExp", function(client, name)
		return string.format("%s has performed the '%s' action.", client:GetName(), name)
	end)
end

do
	local CHAR = ix.meta.character

	function CHAR:CanDoAction(actionID, ...)
		local action = ix.action:Find(actionID)
		if (!action) then
			--ErrorNoHalt("Attempted to check if player can do invalid action '"..(actionID or "nil").."'.")
			return
		end

		if (!action.CanDo) then
			return true
		end

		if (!isfunction(action.CanDo)) then
			return self:GetSkillLevel(action.skill) >= action.CanDo
		else
			return action:CanDo(self, self:GetSkillLevel(action.skill), ...)
		end
	end

	if (SERVER) then
		function CHAR:DoAction(actionID, ...)
			local action = ix.action:Find(actionID)
			if (!action) then
				ErrorNoHalt(string.format("[ACTIONS] Attempted to do invalid action '%s'.", actionID))
			end

			local result = self:GetResult(actionID, ...)

			if (result and result > 0 and self:GetSkillLevel(action.skill) >= 0) then
				if (self:GetSkill(action.skill) >= ix.skill.MAX_SKILL) then
					return
				end

				local storedExp = self:GetSkillStoredExp(action.skill)
				self:SetSkillStoredExp(action.skill, math.min(result, 1999 - storedExp))

				if (self:GetSkillAutoLevel(action.skill)) then
					self:LevelUpSkill(action.skill)
				elseif (self:CanLevelSkill(action.skill) and storedExp < 1000) then
					local skill = ix.skill:Find(action.skill)
					self:GetPlayer():NotifyLocalized("levelPossible", skill.name, self:GetSkill(skill.uniqueID) + 1)
				end

				if (!action.bNoLog) then
					ix.log.Add(self:GetPlayer(), "actionsDoAction", action.name, result, action.skill)
				end
			elseif (action.alwaysLog) then
				ix.log.Add(self:GetPlayer(), "actionsDoActionNoExp", action.name)
			end
		end
	end

	local function GetExp(DoResult, skillLevel)
		for k, v in ipairs(DoResult) do
			if (v.level > skillLevel) then
				break
			elseif (v.level <= skillLevel and skillLevel < DoResult[k + 1].level) then
				return v.exp
			end
		end

		return 0
	end

	function CHAR:GetResult(actionID, ...)
		local action = ix.action:Find(actionID)
		if (!action) then
			--ErrorNoHalt("Attempted to get result from invalid action '"..(actionID or "nil").."'.")
			return
		end

		if (!action.DoResult) then
			return 0
		end

		local min = self:GetSkill(action.skill)
		local max = math.max(min, self:GetSkillLevel(action.skill))
		if (!isfunction(action.DoResult)) then
			local maxExp = 0
			for k = min, max do
				if (action.DoResult[k] and action.DoResult[k] > maxExp) then
					maxExp = action.DoResult[k]
				end
			end
			return maxExp
		else
			local maxExp = 0
			for i = min, max do
				local result = action:DoResult(self, i, ...) or 0
				if (result > maxExp) then
					maxExp = result
				end
			end

			return maxExp
		end
	end
end
