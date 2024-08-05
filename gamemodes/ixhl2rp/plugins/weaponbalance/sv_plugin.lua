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

function ix.weapons:CalcCritChance(attackerChar, victim, range, hitBox, weaponClass)
    local attacker = attackerChar:GetPlayer()

    if (!self.hitBoxList[hitBox]) then
        return 0, 0, 0
    end

    local weaponCat = self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return 0, 0, 0
    end

    local hitBoxCrit = self:RemapClamp(range, self.hitBoxList[hitBox])
    local armorMod = (victim:IsPlayer() and victim:Armor() > 0 and self:GetArmorPen(weaponClass)) or 1
    local weaponSkillMod = self:GetWeaponSkillMod(attackerChar, weaponClass)
    local rangeSkillMod = self:GetRangeSkillMod(attackerChar, range)
    local effRangeMod = self:GetWeaponEffRangeMod(weaponClass, range)
    local aimPenalty = self:GetWeaponAimPenalty(weaponClass)
    local dodgeMod = 1
    if (victim:IsPlayer() and ix.fights and victim:GetFight() and victim:GetCharacter().fightInfoTable) then
        dodgeMod = (1 - 0.03 *
            (attackerChar:GetSkillScale("guns_moving_target_penalty")) * (victim:GetCharacter().fightInfoTable.movePointsSpend or 0) *
            (1 + victim:GetCharacter():GetSkillScale("speed_dodge_mod")))
    end

    ix.log.Add(attacker, "weaponBalanceDebugOutput", hitBoxCrit, armorMod, weaponSkillMod, rangeSkillMod, effRangeMod, dodgeMod)
    local penalties, bonus = 0, 0
    if (hitBoxCrit < 0.60) then penalties = bit.bor(penalties, 1) elseif (hitBoxCrit >= 0.65) then bonus = bit.bor(bonus, 1) end
    if (armorMod < 0.85) then penalties = bit.bor(penalties, 2) end
    if (weaponSkillMod < 1) then penalties = bit.bor(penalties, 4) elseif (weaponSkillMod >= 1.1) then bonus = bit.bor(bonus, 4) end
    if (rangeSkillMod < 1) then penalties = bit.bor(penalties, 8) elseif (rangeSkillMod >= 1.1) then bonus = bit.bor(bonus, 8) end
    if (effRangeMod < 0.85) then penalties = bit.bor(penalties, 16) end
    if (aimPenalty < 1) then penalties = bit.bor(penalties, 32) end
    if (dodgeMod < 0.85) then penalties = bit.bor(penalties, 64) end

    return hitBoxCrit * armorMod * weaponSkillMod * rangeSkillMod * effRangeMod * aimPenalty * dodgeMod, penalties, bonus
end

function ix.weapons:CalcMeleeCritChance(attackerChar, victim, weaponClass)
    local attacker = attackerChar:GetPlayer()
    local baseCrit = self:GetMeleeWeaponBaseHitChance(attackerChar, weaponClass)
    local armorMod = (victim:IsPlayer() and victim:Armor() > 0 and self:GetMeleeArmorPen(weaponClass)) or 1
    local dodgeMod = 1
    if (victim:IsPlayer() and ix.fights and victim:GetFight() and victim:GetCharacter().fightInfoTable) then
        local movePoints = victim:GetCharacter().fightInfoTable.movePointsSpend or 0
        if (movePoints >= 8) then
            dodgeMod = 0.5
        elseif (movePoints >= 4) then
            dodgeMod = 0.75
        end
    end

    ix.log.Add(attacker, "weaponMeleeBalanceDebugOutput", baseCrit, armorMod, dodgeMod)
    local penalties, bonus = 0, 0
    if (baseCrit < 0.1) then penalties = bit.bor(penalties, 128) elseif (baseCrit >= 0.3) then bonus = bit.bor(bonus, 128) end
    if (armorMod < 0.85) then penalties = bit.bor(penalties, 2) end
    if (dodgeMod < 0.85) then penalties = bit.bor(penalties, 64) end

    return baseCrit * armorMod * dodgeMod, penalties, bonus
end

function ix.weapons:BalanceDamage(victim, damage, attacker, hitgroup)
    local inflictor = damage:GetInflictor()
    if (!IsValid(inflictor)) then return end

    if (inflictor.IsTFAWeapon and !inflictor.noDoubleDamageFix) then
        if (!attacker.ixCanDoDamage) then
            damage:SetDamage(0)
            return false
        else
            attacker.ixCanDoDamage = attacker.ixCanDoDamage - 1
            if (attacker.ixCanDoDamage == 0) then
                attacker.ixCanDoDamage = nil
            end
        end
    end

    if (inflictor:IsPlayer()) then
        inflictor = inflictor:GetActiveWeapon()
    end

    local weaponClass = inflictor:GetClass()
    if (IsValid(attacker:GetActiveWeapon()) and self:IsMelee(attacker:GetActiveWeapon():GetClass())) then
        weaponClass = attacker:GetActiveWeapon():GetClass()
    end

    local range = -1
    local critChance, penalties, bonus, finalDamage, result
    local critRoll = math.random()
    if (!self:IsMelee(weaponClass)) then
        range = attacker:GetPos():Distance(victim:GetPos()) * 0.30 / 16
        critChance, penalties, bonus = self:CalcCritChance(attacker:GetCharacter(), victim, range, hitgroup, weaponClass)
        if (!critChance) then return end

        result = critRoll < critChance and "crit" or "hit"
        local adjust = self.hitBoxDamageList[hitgroup] and self.hitBoxDamageList[hitgroup][result] or 0.9
        finalDamage = math.floor((self:GetWeaponBaseDamage(weaponClass) or damage:GetDamage()) * adjust)

        if (victim:IsNPC() or victim:IsPlayer() and not attacker:GetActiveWeapon():GetClass() == "ix_hands") then
            if (result == "hit") then
                attacker:GetCharacter():DoAction("guns_hit")
            else
                attacker:GetCharacter():DoAction("guns_crit")
            end
        end
    else
        critChance, penalties, bonus = self:CalcMeleeCritChance(attacker:GetCharacter(), victim, weaponClass)
        if (!critChance) then return end

        result = critRoll < critChance and "crit" or "hit"
        finalDamage = math.floor(self:GetMeleeWeaponBaseDamage(weaponClass, attacker:GetActiveWeapon().ixAttackType) * (result == "crit" and 1 or self:GetMeleeWeaponHitAdjsut(weaponClass)))

        if (victim:IsNPC() or victim:IsPlayer()) then
            if (result == "hit") then
                attacker:GetCharacter():DoAction("melee_hit")
            else
                attacker:GetCharacter():DoAction("melee_crit")
            end
        end
    end

    ix.log.Add(attacker, "weaponBalanceDebugRolls", critChance, critRoll, string.utf8upper(result))

    damage:SetDamage(finalDamage)

    hook.Run("PostCalculatePlayerDamage", victim, damage, hitgroup)

    if (victim:IsNPC() or victim:IsPlayer()) then
        ix.log.Add(attacker, "weaponBalanceResult", result, victim, hitgroup, math.Round(damage:GetDamage()), critChance)
    end

    return true, result, range, critChance, penalties, bonus
end

function ix.weapons:QueueDamageMessage(attacker, data)
	if (!self.dmgMessageQueue or !istable(self.dmgMessageQueue)) then
		self.dmgMessageQueue = {}
	end

    local idx = tonumber(attacker:SteamID64())
    if (!self.dmgMessageQueue[idx]) then
        self.dmgMessageQueue[idx] = {}
        self.dmgMessageQueue[idx].lastIndex = 0
        self.dmgMessageQueue[idx].ply = attacker
        self.dmgMessageQueue[idx].stack = {}
    end

	self.dmgMessageQueue[idx].stack[table.Count(self.dmgMessageQueue[idx].stack) + 1] = data
end

timer.Create("ixDamageMessageStackConsumer", 0.25, 0, function()
    if (!ix.weapons.dmgMessageQueue or !istable(ix.weapons.dmgMessageQueue)) then return end

    for i, queue in pairs(ix.weapons.dmgMessageQueue) do
        if (!queue.stack[queue.lastIndex + 1] or !IsValid(queue.ply)) then
            -- queue is drained
            ix.weapons.dmgMessageQueue[i] = nil
            continue
        end

        local data = queue.stack[queue.lastIndex + 1]
        ix.chat.Send(queue.ply, "weapon_damage", "", false, queue.ply, {
            bCrit = data.bCrit,
            target = data.target,
            hitBox = data.hitBox,
            range = data.range,
            damage = data.damage,
            calcCrit = data.calcCrit,
            penalties = data.penalties,
            bonus = data.bonus,
            messageType = data.messageType
        })

        queue.lastIndex = queue.lastIndex + 1
    end
end)
