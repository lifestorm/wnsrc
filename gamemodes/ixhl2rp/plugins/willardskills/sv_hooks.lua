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

netstream.Hook("ixBarteringPriceMultiplier", function(client, config, multiplier)
	if client:GetCharacter():GetFaction() then
		if (client:GetCharacter():GetFaction() != FACTION_ADMIN) then return end

		ix.config.Set("BarteringPriceMultiplier"..config, multiplier)
		ix.log.AddRaw("[CAPDA] "..client:Name().." has set BartingPriceMultiplier for "..config.." to "..multiplier..".")
	end
end)

netstream.Hook("SetRationIntervalPDA", function(client, interval)
	if client:GetCharacter():GetFaction() then
		if (client:GetCharacter():GetFaction() != FACTION_ADMIN) then return end
		ix.config.Set("rationInterval", interval)
		ix.log.AddRaw("[CAPDA] "..client:Name().." has set rationInterval to "..interval..".")
	end
end)

netstream.Hook("SelectCID", function(client, idCardID, _, _, activeTerminal)
	if (IsValid(activeTerminal)) then
		local idCard = ix.item.instances[idCardID]
		if (!idCard) then
			activeTerminal.OpenDispenserFail(nil, client, activeTerminal)
		else
			idCard:LoadOwnerGenericData(activeTerminal.OpenDispenser, activeTerminal.OpenDispenserFail, client, activeTerminal)
		end
	end
end)

netstream.Hook("SetPurchasedItems", function(client, pickedUpItem, activePickupDispenser)
	if (!IsValid(activePickupDispenser)) then return end

    activePickupDispenser:GiveItem(client, pickedUpItem, activePickupDispenser.activeCID)
end)

netstream.Hook("ClosePanels", function(client, activePickupDispenser)
	if (!IsValid(activePickupDispenser)) then return end
	activePickupDispenser.OpenDispenserFail(nil, client, activePickupDispenser)
end)

--[[
function PLUGIN:FirefightBeginRound(fight)
    if (#fight.participants >= 4) then
		local i = #fight.participants
		local lowestSwitch
		while (i >= 2) do
			local defender, attacker = fight.participants[i - 1], fight.participants[i]

			local initiative = defender:GetSkillScale("initiative_power") + math.random(1, 25) + math.max(0, 8 - #fight.participants) -- attacker value
			initiative = initiative - (attacker:GetSkillScale("initiative_power") + math.random(1, 20)) -- substract defender value
			initiative = (initiative + 34) / (2 * 34) -- scale above substraction to [0, 1]

			if (math.random() > initiative) then
				fight.participants[i - 1]:GetPlayer():ChatNotifyLocalized("ffLostInitiative")
				fight.participants[i]:GetPlayer():ChatNotifyLocalized("ffGainedInitiative")
				fight.participants[i - 1], fight.participants[i] = fight.participants[i], fight.participants[i - 1]
				lowestSwitch = i - 1
				i = i - 1
			end
			i = i - 1
		end

		if (lowestSwitch) then
			for j = #fight.participants, lowestSwitch, -1 do
				ix.plugin.list.firefights:SendPlayerTurnNumber(fight.participants[j]:GetPlayer(), j)
			end
		end
	end
end
--]]

function PLUGIN:FirefightTurnStart(fight, fightInfo, character)
	if (character:CanDoAction("speed_move_point_base")) then
		fightInfo.turn.movesLeft = fightInfo.turn.movesLeft + 1
	end
end

function PLUGIN:FirefightActionMove(client, character, fightInfo)
	character:DoAction("speed_move_point")

	local weapon = client:GetActiveWeapon()
	local class = IsValid(weapon) and weapon:GetClass() or "__invalid"
	if (ix.weapons.weaponList[class]) then
		character:DoAction("guns_combat_move")
	elseif (ix.weapons.meleeWeapons[class]) then
		character:DoAction("melee_combat_move")
	elseif (client:Team() == FACTION_VORT) then
		character:DoAction("vort_combat_move")
	end
end

function PLUGIN:PlayerDeath(client)
    local character = client:GetCharacter()

    if (character) then
        local skills = character:GetSkill()
        local reduceScale = math.Clamp(ix.config.Get("DeathSkillsReducing", 0) * 0.01, 0, 1)

        if (!table.IsEmpty(skills) and reduceScale > 0 and client:Team() != FACTION_OTA) then
            local reducedSkills = character:GetRefundSkills()

            for k, v in pairs(skills) do
                if (v > 0) then
                    local reduceAmount = math.Round(v * reduceScale)
                    character:SetSkill(k, math.Clamp(v - reduceAmount, 0, ix.skill.MAX_SKILL))
                    reducedSkills[k] = (reducedSkills[k] or 0) + reduceAmount
                end
            end

            character:SetRefundSkills(reducedSkills)
        end

		local boosts = character:GetSpecialBoost()
		if (!table.IsEmpty(boosts)) then
			character:SetSpecialBoost({})
			character:SetRefundBoosts(boosts)
		end
    end
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
    local uniqueIDS = "ixAttribBoostsShort" .. client:SteamID64()
    timer.Create(uniqueIDS, 5, 0, function()
		if (IsValid(client)) then
			PLUGIN:BoostTick(client, true, 5)
		else
			timer.Remove(uniqueIDS)
		end
    end)

    local uniqueIDL = "ixAttribBoostsLong" .. client:SteamID64()
    timer.Create(uniqueIDL, 60, 0, function()
		if (IsValid(client)) then
			PLUGIN:BoostTick(client, false, 1)
		else
			timer.Remove(uniqueIDL)
		end
    end)
end

function PLUGIN:BoostTick(client, bShort, ticks)
	if (client:IsAFK()) then return end

    local character = client:GetCharacter()
    if (!character) then return end

	if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then
		return
	end

    local boosts = character:GetSpecialBoost()
    local changes = !bShort
    for _, boostTable in pairs(boosts) do
        local index = (bShort and "short") or "long"
        local boost = boostTable[index]
        if (boost) then
            local newTime = boost.time - ticks
            if (newTime <= 0) then
                changes = true
                local newLevel = boost.level + (boost.level < boost.target and 1 or -1)
                if (newLevel == 0 and boost.target == 0) then
                    boostTable[index] = nil
                    continue
                end

                if (newLevel == boost.target) then
                    boost.time = boost.targetDuration
					boost.target = 0
					boost.targetDuration = 0
                else
                    boost.time = (bShort and 10) or 30
                end

                boost.level = newLevel
            else
                boost.time = newTime
            end
        end
    end

    if (changes) then
        character:SetSpecialBoost(boosts)
    end
end

function PLUGIN:CanPlayerTakeItem(client, entity)
    if (entity:GetClass() != "ix_item") then return end

    local item = ix.item.instances[entity.ixItemID]
    if (!item) then return end

    if (!item:GetData("placer")) then return end

    if (item.isWorkbench and client:GetCharacter():GetID() != item:GetData("placer")) then
        return false
    end
end
