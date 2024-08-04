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

ix.weapons.meleeWeapons = ix.weapons.meleeWeapons or {}
ix.weapons.meleeCat = ix.weapons.meleeCat or {}
ix.weapons.bluntWeapons = ix.weapons.bluntWeapons or {}

function ix.weapons:RegisterMeleeWeapon(weapon, category)
    ix.weapons.meleeWeapons[weapon] = category
end

function ix.weapons:IsMelee(weapon)
    return ix.weapons.meleeWeapons[weapon]
end

function ix.weapons:RegisterMeleeCategory(uid, baseDamage, hitScale, critSkillScale, armorPen)
    self.meleeCat[uid] = {
        armorPen = armorPen,
        baseDamage = baseDamage,
        critSkillScale = critSkillScale,
        hitScale = hitScale,
    }
end

function ix.weapons:GetMeleeWeaponBaseHitChance(character, weaponClass)
    if (self.weaponAimPenalty[weaponClass]) then
        return self.weaponAimPenalty[weaponClass]
    end

    if (!self.meleeWeapons[weaponClass]) then
        return 0.8
    end

    local weaponCat = self.meleeWeapons[weaponClass]
    if (!self.meleeCat[weaponCat]) then
        return 0.8
    end

    return character:GetSkillScale(self.meleeCat[weaponCat].critSkillScale) or 0.8
end

function ix.weapons:GetMeleeArmorPen(weaponClass)
    if (self.weaponArmorPen[weaponClass]) then
        return self.weaponArmorPen[weaponClass]
    end

    if (self.bluntWeapons[weaponClass]) then
        return 1
    end

    local weaponCat = self.meleeWeapons[weaponClass]
    if (!self.meleeCat[weaponCat]) then
        return 1
    end

    return self.meleeCat[weaponCat].armorPen
end

function ix.weapons:GetMeleeWeaponBaseDamage(weaponClass, attackType)
    local scale = 1
    if (attackType == "heavy") then
        scale = 2.5
    elseif (attackType == "bash") then
        scale = 0.7
    end

    if (self.weaponDamage[weaponClass]) then
        return self.weaponDamage[weaponClass] * scale
    end

    if (!self.meleeWeapons[weaponClass]) then
        return 16 * scale
    end

    local weaponCat = self.meleeWeapons[weaponClass]
    if (!self.meleeCat[weaponCat]) then
        return 16 * scale
    end

    return self.meleeCat[weaponCat].baseDamage * scale
end

function ix.weapons:GetMeleeWeaponHitAdjsut(weaponClass)
    if (!self.meleeWeapons[weaponClass]) then
        return 0.8
    end

    local weaponCat = self.meleeWeapons[weaponClass]
    if (!self.meleeCat[weaponCat]) then
        return 0.8
    end

    return self.meleeCat[weaponCat].hitScale
end

ix.weapons:RegisterMeleeCategory("light", 24, 0.8, "melee_light", 0.4)
ix.weapons:RegisterMeleeCategory("medium", 36, 0.5, "melee_medium", 0.6)
ix.weapons:RegisterMeleeCategory("heavy", 42, 0.4, "melee_heavy", 0.8)

ix.weapons:RegisterMeleeWeapon("ix_stunstick", "light")
--ix.weapons:RegisterMeleeWeapon("tfa_nmrih_kknife", "light")