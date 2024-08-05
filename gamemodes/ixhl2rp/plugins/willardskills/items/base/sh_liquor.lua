--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Liquor Base"
ITEM.model = Model("models/props_junk/garbage_takeoutcarton001a.mdl")
ITEM.description = "A base for alcoholic consumables."
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Consumable"

ITEM.useSound = {"npc/barnacle/barnacle_crunch3.wav", "npc/barnacle/barnacle_crunch2.wav"}

ITEM.hunger = 0
ITEM.thirst = 0
ITEM.health = 0
ITEM.damage = 0
ITEM.strength = 25
ITEM.abv = 10
ITEM.colorAppendix = {}

ITEM.base = "base_stackable"
ITEM.maxStackSize = 1

ITEM.boosts = {
	strength = 3,
    agility = -3,
	perception = -2,
	intelligence = 1
}

ITEM.grade = "LOW" -- ix.inebriation.grades

function ITEM:GetBoostAppend()
	local boostAppend = {}
	if (self.boosts) then
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

function ITEM:GetColorAppendix()
    local tbl = {
        ["yellow"] = self:GetBoostAppend(),
        ["blue"] = "\nABV: "..tostring(self.abv or 0).."%%"
    }

    if (self.shotsPerItem and self.shotsPoured) then
        tbl["red"] = "Glasses Left: "..tostring(self.shotsPerItem - self.shotsPoured)
    end

    if (self.grade and ix.inebriation.grades[self.grade]) then
        local _grade = ix.inebriation.grades[self.grade]
        if (_grade and _grade.appendText) then
            tbl["green"] = "Grade: ".._grade.appendText
        end
    end

	return tbl
end

function ITEM:OnInstanced()
	if (!self:GetData("stack")) then
        self:SetStack(self:GetStackSize())
    end
end

local function consume(item, client, character)
    if (item.useSound) then
        if (istable(item.useSound)) then
            client:EmitSound(table.Random(item.useSound))
        else
            client:EmitSound(item.useSound)
        end
    end

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

    if (item.strength > 0) then
        if (ix.inebriation and ix.inebriation.allowedFactions[character:GetFaction()]) then
            character:SetInebriation(character:GetInebriation() + item.strength)
            client:SetNetVar("inebriation", character:GetInebriation())
        end
    end

    if (item.grade) then
        local grade = ix.inebriation.grades[item.grade]
        if (grade.damage > 0) then
            client:SetHealth(math.Clamp(client:Health() - grade.damage, 0, client:GetMaxHealth()))
        end
    end

    if (item.boosts) then
        for k, v in pairs(item.boosts) do
            character:SetSpecialBoost(k, v, true)
        end
    end
end

ITEM.functions.Consume = {
	icon = "icon16/user.png",
	OnRun = function(item)
		local client = item.player
		local character = item.player:GetCharacter()

        consume(item, client, character)
	end
}

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
		local trace = item.player:GetEyeTraceNoCursor()
		local target = trace.Entity
		if (target:GetClass() == "prop_ragdoll" and IsValid(target.ixPlayer)) then
			target = target.ixPlayer
		end

		local targetChar = target:GetCharacter()

        consume(item, target, targetChar)
	end,
}

ITEM.functions.Pour = {
    OnCanRun = function(item)
        return item.shareable and ix.item.list[item.shotItem]
    end,
    OnRun = function(item)
        local client = item.player
        local character = item.player:GetCharacter()
        local inventory = character:GetInventory()

        local itemName = ix.item.list[item.shotItem] and ix.item.list[item.shotItem].uniqueID or item.shotItem
        if (!itemName) then
            client:NotifyLocalized("Invalid item.")
            return
        end

        local tr = client:GetEyeTrace()

        ix.item.Spawn(itemName, tr.HitPos, function(_item, _)
            _item.grade = item.grade or "LOW"
        end)

        client:NotifyLocalized("You have poured a glass of "..item.name..".")

        item.shotsPoured = item.shotsPoured + 1
        if (item.shotsPoured >= item.shotsPerItem) then
            client:NotifyLocalized("You have poured the last glass of "..item.name..".")
            if (item.junk) then
                if (!inventory:Add(item.junk)) then
                    ix.item.Spawn(item.junk, client)
                end
            end
        else
            -- don't remove the item if it's not the last shot
            return false
        end
    end
}