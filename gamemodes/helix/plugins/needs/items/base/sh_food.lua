--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Consumable Base"
ITEM.model = Model("models/props_junk/garbage_takeoutcarton001a.mdl")
ITEM.description = "A base for consumables."
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Consumable"

ITEM.useSound = {"npc/barnacle/barnacle_crunch3.wav", "npc/barnacle/barnacle_crunch2.wav"}

ITEM.hunger = 0
ITEM.thirst = 0
ITEM.health = 0
ITEM.damage = 0
ITEM.spoilTime = 14

ITEM.colorAppendix = {}

ITEM.base = "base_stackable"
ITEM.maxStackSize = 1

function ITEM:GetName()
	if (self:GetSpoiled()) then
		local spoilText = self.spoilText or "Spoiled"
		return spoilText.." "..self.name
	end

	return self.name
end

function ITEM:GetDescription()
	local description = {self.description}
	if (!self:GetSpoiled() and self:GetData("spoilTime")) then
		local spoilTime = math.floor((self:GetData("spoilTime") - os.time()) / 60)
		local text = " minute"
		if (spoilTime > 60) then
			text = " hour"
			spoilTime = math.floor(spoilTime / 60)
		end

		if (spoilTime > 24) then
			text = " day"
			spoilTime = math.floor(spoilTime / 24)
		end

		if (spoilTime > 1) then
			text = text.."s"
		end

		description[#description + 1] = "\nSpoils in "..spoilTime..text.."."
	end

	return table.concat(description, "")
end

function ITEM:GetBoostAppend()
	local boostAppend = {}
	if (self.boosts) then
		boostAppend[#boostAppend + 1] = "LONG-TERM BOOSTS:\n"

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

function ITEM:GetColorAppendix()
	return {["yellow"] = self:GetBoostAppend()}
end

function ITEM:GetSpoiled()
	local spoilTime = self:GetData("spoilTime")
	if (!spoilTime) then
		return false
	end

	return os.time() > spoilTime
end

function ITEM:OnInstanced()
	if (self.spoil and !self:GetData("spoilTime")) then
		self:SetData("spoilTime", os.time() + 24 * 60 * 60 * self.spoilTime)
	end

	if (!self:GetData("stack")) then
        self:SetStack(self:GetStackSize())
    end
end

ITEM.functions.Consume = {
	icon = "icon16/user.png",
	OnRun = function(item)
		local client = item.player
		local character = item.player:GetCharacter()
		local bSpoiled = item:GetSpoiled()

		if (item.damage > 0) then
			client:TakeDamage(item.damage, client, client)
		end

		if (item.instantHeal) then
			client:SetHealth(client:GetMaxHealth())

			character:SetBleedout(-1)

			local healing = character:GetHealing()
			if (healing and istable(healing) and !table.IsEmpty(healing)) then
				healing.fakeHealth = 0
				character:SetHealing("table", healing)
			end

			character:SetGasPoints(0)

			client:SetLocalVar("stm", 100)

			character:SetGlasses(false)
		end

		-- Spawn the junk item if it exists
		if (item:IsSingleItem() and item.junk) then
			if (!character:GetInventory():Add(item.junk)) then
				ix.item.Spawn(item.junk, client)
			end
		end

		if (item.useSound) then
			if (istable(item.useSound)) then
				client:EmitSound(table.Random(item.useSound))
			else
				client:EmitSound(item.useSound)
			end
		end

		if (!bSpoiled) then
			if item.OnConsume then
				item:OnConsume(client, character)
			end
			if (item.thirst > 0) then
				character:SetThirst(math.Clamp(character:GetThirst() - (client:Team() == FACTION_BIRD and item.thirst * 2 or item.thirst), 0, 100))
			end

			if (item.hunger > 0) then
				character:SetHunger(math.Clamp(character:GetHunger() - (client:Team() == FACTION_BIRD and item.hunger * 2 or item.hunger), 0, 100))
			end

			if (item.health > 0) then
				client:SetHealth(math.Clamp(client:Health() + (client:Team() == FACTION_BIRD and item.health * 2 or item.health), 0, client:GetMaxHealth()))
			end

			if (item.boosts) then
				for k, v in pairs(item.boosts) do
					character:SetSpecialBoost(k, v, false)
				end
			end
		end
	end
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

		if (target:GetClass() == "prop_ragdoll" and IsValid(target.ixPlayer)) then
			target = target.ixPlayer
		end

		if (!target:IsPlayer() or !target:GetCharacter()) then
			return false
		end

		if (target:Health() >= target:GetMaxHealth()) then
			local targetChar = target:GetCharacter()
			if (targetChar:GetHealing("fakeHealth") == 0 and targetChar:GetBleedout() == -1) then
				return false
			end
		end

		return true
	end,
	OnRun = function(item)
		local client = item.player
		local character = item.player:GetCharacter()
		local bSpoiled = item:GetSpoiled()

		local trace = item.player:GetEyeTraceNoCursor()
		local target = trace.Entity
		if (target:GetClass() == "prop_ragdoll" and IsValid(target.ixPlayer)) then
			target = target.ixPlayer
		end

		local targetChar = target:GetCharacter()

		if (item.instantHeal) then
			target:SetHealth(target:GetMaxHealth())

			targetChar:SetBleedout(-1)

			local healing = targetChar:GetHealing()
			if (healing and istable(healing) and !table.IsEmpty(healing)) then
				healing.fakeHealth = 0
				targetChar:SetHealing("table", healing)
			end

			targetChar:SetGasPoints(0)

			target:SetLocalVar("stm", 100)

			targetChar:SetGlasses(false)
		end

		-- Spawn the junk item if it exists
		if (item:IsSingleItem() and item.junk) then
			if (!character:GetInventory():Add(item.junk)) then
				ix.item.Spawn(item.junk, client)
			end
		end

		if (item.useSound) then
			if (istable(item.useSound)) then
				target:EmitSound(table.Random(item.useSound))
			else
				target:EmitSound(item.useSound)
			end
		end

		if (!bSpoiled) then
			if item.OnConsume then
				item:OnConsume(client, character)
			end

			if (item.thirst > 0) then
				targetChar:SetThirst(math.Clamp(targetChar:GetThirst() - (target:Team() == FACTION_BIRD and item.thirst * 2 or item.thirst), 0, 100))
			end

			if (item.hunger > 0) then
				targetChar:SetHunger(math.Clamp(targetChar:GetHunger() - (target:Team() == FACTION_BIRD and item.hunger * 2 or item.hunger), 0, 100))
			end

			if (item.health > 0) then
				target:SetHealth(math.Clamp(target:Health() + (target:Team() == FACTION_BIRD and item.health * 2 or item.health), 0, target:GetMaxHealth()))
			end

			if (item.boosts) then
				for k, v in pairs(item.boosts) do
					targetChar:SetSpecialBoost(k, v, false)
				end
			end
		end
	end,
}
