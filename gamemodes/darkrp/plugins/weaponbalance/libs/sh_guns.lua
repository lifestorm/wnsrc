--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local ix = ix

ix.weapons = ix.weapons or {}

ix.weapons.hitBoxList = ix.weapons.hitBoxList or {}
ix.weapons.hitBoxDamageList = ix.weapons.hitBoxDamageList or {}
ix.weapons.weaponCatList = ix.weapons.weaponCatList or {}
ix.weapons.weaponList = ix.weapons.weaponList or {}

ix.weapons.weaponAimPenalty = ix.weapons.weaponAimPenalty or {}
ix.weapons.weaponDamage = ix.weapons.weaponDamage or {}
ix.weapons.weaponArmorPen = ix.weapons.weaponArmorPen or {}
ix.weapons.weaponNumShots = ix.weapons.weaponNumShots or {}

ix.weapons.armorHitBox = {
    [HITGROUP_CHEST] = true,
    [HITGROUP_STOMACH] = true,
}

ix.weapons.effRange = {
    min = 0,
    max = 50,
    minVal = 50,
    maxVal = 200
}

ix.weapons.maxRange = {
    min = 0,
    max = 50,
    minVal = 200,
    maxVal = 500
}

function ix.weapons:RegisterWeaponCat(uid, data)
    self.weaponCatList[uid] = {
        armorPen = math.Clamp(data.armorPen, 0, 1),
        baseDamage = data.baseDamage,
        numShots = data.numShots,
        name = data.name or uid,
        gunSkill = {
            {inVal = 0, outVal = math.Clamp(data.noSkillMod, 0, 1)},
            {inVal = data.minSkill, outVal = 1},
            {inVal = data.maxSkill, outVal = math.Clamp(data.maxSkillMod, 1, 1.2)}
        },
        effRange = {
            {inVal = 0, outVal = math.Clamp(data.pointBlankMod, 0, 1)},
            {inVal = data.minEffRange, outVal = 1},
            {inVal = data.effRange, outVal = 1},
            {inVal = data.maxEffRange, outVal = 0.2}
        },
        aimPenalty = data.aimPenalty or 1
    }
end

function ix.weapons:RegisterWeapon(weapon, cat)
    self.weaponList[weapon] = cat
end

function ix.weapons:RegisterHitBox(hitBox, minRange, minRangeVal, maxRange, maxRangeVal, critAdjust, hitAdjust)
    self.hitBoxList[hitBox] = {
        min = minRange,
        minVal = math.Clamp(minRangeVal, 0, 0.7),
        max = maxRange,
        maxVal = math.Clamp(maxRangeVal, 0, 0.7)
    }

    self.hitBoxDamageList[hitBox] = {
        crit = critAdjust,
        hit = hitAdjust
    }
end

function ix.weapons:RegisterWeaponExceptions(weapon, damage, armorPen, aimPenalty, numShots)
    if (damage) then
        self.weaponDamage[weapon] = damage --also used for melee base damage adjust
    end

    if (armorPen) then
        self.weaponArmorPen[weapon] = armorPen --also used for melee armor hit adjust
    end

    if (aimPenalty) then
        self.weaponAimPenalty[weapon] = aimPenalty --also used for melee base hit adjust
    end

    if (numShots) then
        self.weaponNumShots[weapon] = numShots
    end
end

function ix.weapons:RemapMulti(value, dataTbl)
    if (value < dataTbl[1].inVal) then
        return dataTbl[1].outVal
    elseif (value >= dataTbl[#dataTbl].inVal) then
        return dataTbl[#dataTbl].outVal
    else
        for k, v in ipairs(dataTbl) do
            if (value >= v.inVal and value < dataTbl[k + 1].inVal) then
                return math.Remap(value, v.inVal, dataTbl[k + 1].inVal, v.outVal, dataTbl[k + 1].outVal)
            end
        end
    end
end

function ix.weapons:RemapClamp(value, dataTbl)
    if (value < dataTbl.min) then
        return dataTbl.minVal
    elseif (value > dataTbl.max) then
        return dataTbl.maxVal
    else
        return math.Remap(value, dataTbl.min, dataTbl.max, dataTbl.minVal, dataTbl.maxVal)
    end
end

function ix.weapons:GetArmorPen(weaponClass)
    if (self.weaponArmorPen[weaponClass]) then
        return self.weaponArmorPen[weaponClass]
    end

    if (!self.weaponList[weaponClass]) then
        return 1
    end

    local weaponCat = self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return 1
    end
    return self.weaponCatList[weaponCat].armorPen
end

function ix.weapons:GetWeaponSkillRequired(weaponClass)
    if (!self.weaponList[weaponClass]) then
        return 0, 50
    end

    local weaponCat = self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return 0, 50
    end

    return self.weaponCatList[weaponCat].gunSkill[2].inVal, self.weaponCatList[weaponCat].gunSkill[3].inVal, self.weaponCatList[weaponCat].gunSkill[3].outval == 1
end

function ix.weapons:GetWeaponSkillMod(character, weaponClass, bOnlyCat)
    if (!bOnlyCat and !self.weaponList[weaponClass]) then
        return 1
    end

    local weaponCat = (bOnlyCat and weaponClass) or self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return 1
    end
    return self:RemapMulti(math.max(character:GetSkillLevel("guns"), 0),
        self.weaponCatList[weaponCat].gunSkill)
end

function ix.weapons:GetRangeSkillMod(character, range)
    local gunSkill = character:GetSkillLevel("guns")
    local minEff, maxEff = self:RemapClamp(gunSkill, self.effRange), self:RemapClamp(gunSkill, self.maxRange)
    return math.min(1.2, math.Remap(range, minEff, maxEff, 1.2, 1))
end

function ix.weapons:GetWeaponEffectiveRanges(weaponClass)
    if (!self.weaponList[weaponClass]) then
        return 1
    end

    local weaponCat = self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return 1
    end

    -- return min effective, max effective, max range
    return self.weaponCatList[weaponCat].effRange[2].inVal, self.weaponCatList[weaponCat].effRange[3].inVal, self.weaponCatList[weaponCat].effRange[4].inVal
end

function ix.weapons:GetWeaponEffRangeMod(weaponClass, range)
    if (!self.weaponList[weaponClass]) then
        return 1
    end

    local weaponCat = self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return 1
    end

    return self:RemapMulti(range, self.weaponCatList[weaponCat].effRange)
end

function ix.weapons:GetWeaponAimPenalty(weaponClass)
    if (self.weaponAimPenalty[weaponClass]) then
        return self.weaponAimPenalty[weaponClass]
    end

    if (!self.weaponList[weaponClass]) then
        return 1
    end

    local weaponCat = self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return 1
    end

    return self.weaponCatList[weaponCat].aimPenalty
end

function ix.weapons:GetWeaponBaseDamage(weaponClass)
    if (self.weaponDamage[weaponClass]) then
        return self.weaponDamage[weaponClass]
    end

    if (!self.weaponList[weaponClass]) then
        return
    end

    local weaponCat = self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return
    end

    return self.weaponCatList[weaponCat].baseDamage
end

function ix.weapons:GetWeaponNumShots(weaponClass)
    if (self.weaponNumShots[weaponClass]) then
        return self.weaponNumShots[weaponClass]
    end

    if (!self.weaponList[weaponClass]) then
        return 1
    end

    local weaponCat = self.weaponList[weaponClass]
    if (!self.weaponCatList[weaponCat]) then
        return 1
    end

    return self.weaponCatList[weaponCat].numShots
end