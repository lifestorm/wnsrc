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

function ix.storage.Open(client, inventory, info) -- libs/sh_storage.lua
	assert(IsValid(client) and client:IsPlayer(), "expected valid player")
	assert(type(inventory) == "table" and inventory:IsInstanceOf(ix.meta.inventory), "expected valid inventory")

	if (!inventory.storageInfo) then
		info = info or {}

		-- I, perosnally, dislike storage context system at all, because it's not designed for flexible multiple users interaction, but editing is another task completely, so yeah...
		if (isnumber(info.searchTime) and info.searchTime != 0) then
			local character = client:GetCharacter()

			info.searchTime = character:GetActionTimeInfluencedByEnergyLevel(info.searchTime)
		end

		ix.storage.CreateContext(inventory, info)
	end

	local storageInfo = inventory.storageInfo

	if (storageInfo.bMultipleUsers or !ix.storage.InUse(inventory)) then
		ix.storage.AddReceiver(client, inventory, true)
	else
		client:NotifyLocalized("storageInUse")
		return
	end

	if (storageInfo.searchTime > 0) then
		client:SetAction(storageInfo.searchText, storageInfo.searchTime)
		client:DoStaredAction(storageInfo.entity, function()
			if (IsValid(client) and IsValid(storageInfo.entity) and inventory.storageInfo) then
				ix.storage.Sync(client, inventory)
			end
		end, storageInfo.searchTime, function()
			if (IsValid(client)) then
				ix.storage.RemoveReceiver(client, inventory)
				client:SetAction()
			end
		end)
	else
		ix.storage.Sync(client, inventory)
	end
end

function PLUGIN:InitializedPlugins2() -- plugins/willard_skills/meta/sh_character.lua
	local charMeta = ix.meta.character

	function charMeta:GetSkillBoostLevels(skillID)
		local skill = ix.skill:Find(skillID)
		if (!skill) then return end

		local boostExp

		if (self:IsAffectedByFatigue()) then
			local energy = self:GetEnergy()

			if (energy > 100) then
				local energyBuffs = PLUGIN.energySkillShifts.buffs
				boostExp = energyBuffs[skillID] or energyBuffs.base
			else
				boostExp = 0
			end
		else
			boostExp = 0
		end

		for _, attr in ipairs(skill.attributes) do
			boostExp = boostExp + self:GetAttrBoostLevels(attr, skill)
		end

		return boostExp
	end

	function charMeta:GetSkillNeedsReducing(skillID)
		local skill = ix.skill:Find(skillID)
		if (!skill) then return end
	
		local levelReduction = 0
		local realLevel = self:GetSkill(skillID)
		local reducedEnergy reducedHunger, reducedThirst, reducedGas, reducedHealth = false, false, false, false, false

		if (realLevel == 0) then
			return levelReduction, reducedEnergy, reducedHunger, reducedThirst, reducedGas, reducedHealth
		end

		if (self:IsAffectedByFatigue()) then
			local energy = self:GetEnergy()
			local energyLevelToApplyDebuffs = ix.config.Get("energyLevelToApplyDebuffs", 50)

			if (energy < energyLevelToApplyDebuffs) then
				local energyDebuffs = PLUGIN.energySkillShifts.debuffs

				reducedEnergy = realLevel * (energyDebuffs[skillID] or energyDebuffs.base) * (1 - energy / energyLevelToApplyDebuffs)
				levelReduction = levelReduction + reducedEnergy
			end
		end

		if (self.GetHunger and self.GetThirst) then
			local hunger, thirst = self:GetHunger(), self:GetThirst()

			if (hunger > 50) then
				reducedHunger = realLevel * 0.5 * (1 - (math.min(hunger, 100) - 50) / 50)
				levelReduction = levelReduction + reducedHunger
			end

			if (thirst > 50) then
				reducedThirst = realLevel * 0.5 * (1 - (math.min(thirst, 100) - 50) / 50)
				levelReduction = levelReduction + reducedThirst
			end
		end

		if (self.GetGasPoints) then
			local gasPointFraction = self:GetGasPoints() / 120

			if (gasPointFraction > 0.3) then
				reducedGas = realLevel * 0.4 * ((math.min(gasPointFraction, 1) - 0.3) / 0.7)
				levelReduction = levelReduction + reducedGas
			end
		end

		local client = self:GetPlayer()
		local health, maxHealth = client:Health(), client:GetMaxHealth()
		local halfMaxHealth = math.floor(maxHealth / 2)

		if (health < halfMaxHealth) then
			reducedHealth = realLevel * 0.5 * (1 - health / maxHealth)
			levelReduction = levelReduction + reducedHealth
		end

		return math.min(math.Round(levelReduction, 1), realLevel), reducedEnergy, reducedHunger, reducedThirst, reducedGas, reducedHealth
	end

	if (self.InitializedPlugins3) then
		self:InitializedPlugins3()
	end
end

do
	local charMeta = ix.meta.character

	-- plugins/stamina_enhanced.lua
	function charMeta:GetMaxStamina()
		local client = self:GetPlayer()
		local hunger, thirst, health, maxHealth = self:GetHunger(), self:GetThirst(), client:Health(), client:GetMaxHealth()
		local stamina = 100

		if (self:IsAffectedByFatigue()) then
			local energy = self:GetEnergy()
			local energyLevelToApplyDebuffs = ix.config.Get("energyLevelToApplyDebuffs", 50)

			if (energy < energyLevelToApplyDebuffs) then
				stamina = stamina * (1 - PLUGIN.energyMaxStaminaOffsetDebuff * (1 - energy / energyLevelToApplyDebuffs))
			elseif (energy > 100) then
				stamina = stamina + math.floor(stamina * PLUGIN.energyMaxStaminaOffsetBuff)
			end
		end

		if (hunger > 50) then
			stamina = stamina * (1 - 0.4 * (math.min(hunger - 50, 50) / 50))
		end

		if (thirst > 50) then
			stamina = stamina * (1 - 0.4 * (math.min(thirst - 50, 50) / 50))
		end

		local halfMaxHealth = math.floor(maxHealth * 0.5)

		if (health < halfMaxHealth) then
			stamina = stamina * (1 - 0.4 * (1 - health / halfMaxHealth))
		end
	
		return stamina
	end
end
