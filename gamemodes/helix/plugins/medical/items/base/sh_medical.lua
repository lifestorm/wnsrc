--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Medical Item"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A small roll of hand-made gauze."
ITEM.category = "Medical"

ITEM.useSound = "items/medshot4.wav"

ITEM.base = "base_stackable"
ITEM.bInstanceMaxstack = true

ITEM.usableInCombat = false

function ITEM:GetBoostAppend()
	local boostAppend = {}
	if (ix.special and self.boosts) then
		boostAppend[#boostAppend + 1] = "SHORT-TERM BOOSTS:\n"

		if (self.boosts.strength) then
			boostAppend[#boostAppend + 1] = string.format("Strength: %d\n", self.boosts.strength)
		end
		if (self.boosts.agility) then
			boostAppend[#boostAppend + 1] = string.format("Agility: %d\n", self.boosts.agility)
		end
		if (self.boosts.intelligence) then
			boostAppend[#boostAppend + 1] = string.format("Intelligence: %d\n", self.boosts.intelligence)
		end
		if (self.boosts.perception) then
			boostAppend[#boostAppend + 1] = string.format("Perception: %d", self.boosts.perception)
		end
	end

	return table.concat(boostAppend, "")
end

function ITEM:GetHealingAppend()
	local character = LocalPlayer():GetCharacter()
	local healingAppend = {}

	if (character and self.healing) then
		healingAppend[#healingAppend + 1] = "HEALING:\n"
		if (self.healing.bandage) then
			healingAppend[#healingAppend + 1] = string.format("Bandage: %dHP\n", self.healing.bandage * (1 + character:GetSkillScale("bandage_skill")))
		end
		if (self.healing.disinfectant) then
			healingAppend[#healingAppend + 1] = string.format("Disinfectant: %dHP\n", self.healing.disinfectant * (1 + character:GetSkillScale("disinfectant_skill")))
		end
		if (self.healing.painkillers) then
			healingAppend[#healingAppend + 1] = string.format("Painkillers: %dHP", self.healing.painkillers)
		end
	end

	return table.concat(healingAppend, "")
end

function ITEM:GetColorAppendix()
	if (!ix.special) then return false end

	if self.boosts and self.healing then
		return {["yellow"] = self:GetBoostAppend(), ["green"] = self:GetHealingAppend()}
	elseif self.boosts and !self.healing then
		return {["yellow"] = self:GetBoostAppend()}
	elseif !self.boosts and self.healing then
		return {["green"] = self:GetHealingAppend()}
	else
		return false
	end
end

ITEM.action = {
	skill = "medicine",
	level = function(action, character, skillLevel, target, item, bNotify)
		local requiredLevel = -1
		if (item.GetLevel) then
			 requiredLevel = item:GetLevel(action, character, skillLevel, target)
		elseif (item.level) then
			requiredLevel = item.level
		end

		if (requiredLevel <= skillLevel) then
			return true
		else
			if (bNotify) then
				character:GetPlayer():NotifyLocalized("medicalRequiredLevel", requiredLevel)
			end
			return false
		end
	end,
	experience = function(action, character, skillLevel, target, item)
		if (item.healing) then
			local exp = 0
			local targetChar = target:GetCharacter()
			local healingData = targetChar:GetHealing() or {bandage = 0, disinfectant = 0, fakeHealth = 0, painkillers = 0}
			local missingHealth = target:GetMaxHealth() - target:Health()
			if (item.healing.bandage) then
				local healingLeft = missingHealth - (healingData.bandage or 0) + (healingData.fakeHealth or 0)
				exp = exp + math.min(healingLeft, item.healing.bandage) * ix.config.Get("ExperienceBandageScale", 1)
			end

			if (item.healing.disinfectant) then
				local disinfectant = item.healing.disinfectant * (1 + character:GetSkillScale("disinfectant_skill")) * 60 /
						(ix.config.Get("HealingRegenRate") * ix.config.Get("HealingRegenBoostFactor"))
				if (disinfectant > (healingData.disinfectant or 0)) then
					exp = exp + math.min(item.healing.disinfectant, (1 - healingData.disinfectant / disinfectant) * missingHealth)  * ix.config.Get("ExperienceDisinfectantScale", 1)
				end
			end

			if (item.healing.painkillers) then
				exp = exp + math.min(item.healing.painkillers, missingHealth - (healingData.painkillers or 0)) * ix.config.Get("ExperiencePainkillerScale", 1)
			end

			return exp
		end
	end
}

ITEM.functions.use = {
	name = "Use on yourself",
	tip = "applyTip",
	icon = "icon16/user.png",
	OnCanRun = function(item)
		local character = item.player:GetCharacter()
		if (item.player:Health() >= item.player:GetMaxHealth() and !(ix.special and item.boosts)) then
			if (character:GetHealing("fakeHealth") == 0 and
				(character:GetBleedout() == -1 or !item.healing or !item.healing.bandage)) then
				return false
			end
		end

		if (timer.Exists("combattimer" .. item.player:SteamID64()) and !item.usableInCombat) then
			item.player:Notify("You cannot use this item while in combat.")
			return false
		end

		if (item.action and ix.action) then
			return character:CanDoAction("item_"..item.uniqueID, item.player, item, SERVER)
		end

		return true
	end,
	OnRun = function(item)
		local character = item.player:GetCharacter()

		local player = item.player

		item.player:Freeze(true)
        item.player:SetAction("Applying medical...", 3, function()
			if !IsValid(player) then return end
			player:Freeze(false)
		end)


		if (item.action and ix.action) then
			-- Do action before healing is given for exp calculation
			character:DoAction("item_"..item.uniqueID, item.player, item)
		end

		if (item.healing) then
			for k, v in pairs(item.healing) do
				character:SetHealing(k, v, character)
			end

			if (item.healing.bandage) then
				character:SetBleedout(-1)
			end
		end

		if (ix.special and item.boosts) then
			for k, v in pairs(item.boosts) do
				character:SetSpecialBoost(k, v, true)
			end
		end

		item.player:EmitSound(item.useSound, 110)

		if (item:IsSingleItem()) then
			-- Spawn the junk item if it exists
			if (item.junk) then
				if (!character:GetInventory():Add(item.junk)) then
					ix.item.Spawn(item.junk, item.player)
				end
			end
		end

		return true
	end,
}

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.give = {
	name = "Use on character",
	tip = "giveTip",
	icon = "icon16/user_go.png",
	OnCanRun = function(item)
		if (item.entity) then return false end

		local trace = item.player:GetEyeTraceNoCursor()
		local target = trace.Entity
		if (!IsValid(target)) then
			return false
		end

		if (CLIENT and target:GetClass() == "prop_ragdoll") then
			return true
		end

		if (IsValid(target.ixPlayer)) then
			target = target.ixPlayer
		end

		if (!target:IsPlayer() or !target:GetCharacter()) then
			return false
		end

		if (target:Health() >= target:GetMaxHealth() and !(ix.special and item.boosts)) then
			local targetChar = target:GetCharacter()
			if (targetChar:GetHealing("fakeHealth") == 0 and
				(targetChar:GetBleedout() == -1 or !item.healing or !item.healing.bandage)) then
				return false
			end
		end

		if (item.action and ix.action) then
			local result = item.player:GetCharacter():CanDoAction("item_"..item.uniqueID, item.player, item, SERVER)
			return result
		end

		return true
	end,
	OnRun = function(item)
		local target = item.player:GetEyeTraceNoCursor().Entity
		if (!IsValid(target)) then
			return false
		end

		if (IsValid(target.ixPlayer)) then
			target = target.ixPlayer
		end

		local targetChar = target:GetCharacter()
		local playerChar = item.player:GetCharacter()

		local player = item.player

		item.player:Freeze(true)
		target:Freeze(true)
        item.player:SetAction("Applying medical...", 3, function()
			if !IsValid(player) then return end
			player:Freeze(false)
			target:Freeze(false)
		end)

		if (item.action and ix.action) then
			-- Do action before healing is given for exp calculation
			playerChar:DoAction("item_"..item.uniqueID, target, item)
		end

		if (item.healing) then
			for k, v in pairs(item.healing) do
				targetChar:SetHealing(k, v, playerChar)
			end

			if (item.healing.bandage) then
				targetChar:SetBleedout(-1)
			end
		end

		if (ix.special and item.boosts) then
			for k, v in pairs(item.boosts) do
				targetChar:SetSpecialBoost(k, v, true)
			end
		end

		item.player:EmitSound(item.useSound, 110)

		if (item:IsSingleItem()) then
			-- Spawn the junk item if it exists
			if (item.junk) then
				if (!playerChar:GetInventory():Add(item.junk)) then
					ix.item.Spawn(item.junk, item.player)
				end
			end
		end

		return true
	end,
}
