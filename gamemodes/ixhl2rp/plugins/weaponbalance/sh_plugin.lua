--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Weapon Balance"
PLUGIN.author = "Gr4Ss & M!NT"
PLUGIN.description = "Changes the way damage is applied and allows weapons their damage to be rebalanced to be more RP appropriate."

ix.weapons = ix.weapons or {}
ix.weapons.messageTypes = {
    ["WEAPON_DAMAGE"] = 1,
    ["ARMOR_DAMAGE"] = 2,
    ["ARMOR_HALF_DAMAGE"] = 3,
    ["ARMOR_BREAK"] = 4
}

ix.config.Add("weaponBalanceDebugOutput", false, "Print output parameters for weapon balance.", nil, {
	category = "Weapon Balance"
})
ix.config.Add("weaponBalanceDebugRolls", false, "Print rolls results for weapon balance.", nil, {
	category = "Weapon Balance"
})

ix.config.Add("corpseMax", 8, "Maximum number of corpses that are allowed to be spawned.", nil, {
	data = {min = 0, max = 20},
	category = "Persistent Corpses"
})

ix.config.Add("npcArmorPenetration", 0.5, "Percentage of NPC damage which penetrates armor.", nil, {
	data = {min = 0, max = 1, decimals = 2},
	category = "Weapon Balance"
})

ix.config.Add("defaultArmorPenetration", 0.4, "Percentage of damage which penetrates armor when not specified by the item's configuration.", nil, {
    data = {min = 0, max = 1, decimals = 2},
    category = "Weapon Balance"
})

ix.config.Add("corpseDecayTime", 60, "How long it takes for a corpse to decay in seconds. Set to 0 to never decay.", nil, {
	data = {min = 0, max = 1800},
	category = "Persistent Corpses"
})

ix.option.Add("showAdditionalDamageInfo", ix.type.bool, false, {
    category = "notice"
})

ix.option.Add("showDamageInfoChat", ix.type.bool, true, {
    category = "notice"
})

ix.lang.AddTable("english", {
    optShowAdditionalDamageInfo = "Show Extra Weapon Damage Info",
    optdShowAdditionalDamageInfo = "Shows extra info about your weapon damage result: your crit chance, penalties and bonuses received. Warning: chat-spam!",
    optShowDamageInfoChat = "Show Damage Info In Chat",
    optdShowDamageInfoChat = "Shows the damage info in chat. If disabled, damage info will instead be printed into console."
})

ix.lang.AddTable("spanish", {
	optShowAdditionalDamageInfo = "Enseña más Información sobre el Daño del Arma",
	optdShowDamageInfoChat = "Muestra la información sobre el daño en el chat. Si se desactiva, la información sobre el daño aparecerá en la consola.",
	optShowDamageInfoChat = "Muestra Información de Daño en el chat",
	optdShowAdditionalDamageInfo = "Muestra información extra sobre el resultado de daño de un arma: Tu posibilidad de crítico, penalizaciones y bonus. Cuidado: ¡Chat spam!"
})

do
    local CLASS = {}

    local iconOrange = ix.util.GetMaterial("willardnetworks/chat/gun_orange.png")
    local iconRed = ix.util.GetMaterial("willardnetworks/chat/gun_red.png")
    local orange = Color(255, 144, 0)
    local orangeAlt = Color(255, 171, 62)
    local orangeAlt2 = Color(255, 197, 122)
    local red = Color(217, 83, 83)
    local redAlt = Color(150, 83, 83)

	if (CLIENT) then
        function CLASS:OnChatAdd(speaker, text, anonymous, data)
            if (!data.messageType) then return end
            local icon = data.bCrit and iconRed or iconOrange
            local color = orange
            local critText = data.bCrit and "critically hit " or "hit "
            local targetText = ((!IsValid(data.target) or data.target:IsPlayer()) and "your target") or data.target:GetClass()
            local hitBoxText = (data.hitBox and " in the "..data.hitBox) or ""
            local range = data.range == -1 and "" or " at "..data.range.." meters"
            local suffix = ""
            if (data.messageType == ix.weapons.messageTypes.WEAPON_DAMAGE) then
                color = data.bCrit and red or orange
                suffix = ", dealing "..data.damage.." damage"

            elseif (data.messageType == ix.weapons.messageTypes.ARMOR_DAMAGE) then
                color = data.bCrit and orangeAlt or orangeAlt2
                suffix = ", dealing "..data.damage.." damage to their armor"

            elseif (data.messageType == ix.weapons.messageTypes.ARMOR_HALF_DAMAGE) then
                color = data.bCrit and orangeAlt or orangeAlt2
                suffix = ", dealing "..data.damage.." damage, and dealing "..math.Round(data.damage / 2).." damage to their armor"

            elseif (data.messageType == ix.weapons.messageTypes.ARMOR_BREAK) then
                color = data.bCrit and red or redAlt
                suffix = ", breaking their armor"
            end

            local punctuation = data.bCrit and "!" or "."
            local finalText1 = table.concat({
                "You ", critText, targetText, range, hitBoxText, suffix, punctuation
            })
            if (ix.option.Get("showDamageInfoChat")) then
                chat.AddText(icon, color, finalText1)
            else
                MsgC(color, finalText1, "\n")
            end

            if (ix.option.Get("showAdditionalDamageInfo")) then
                local penalties, bonus = {}, {}
                if (bit.band(data.penalties, 1) == 1) then penalties[#penalties + 1] = "bodypart hit range" end
                if (bit.band(data.penalties, 2) == 2) then penalties[#penalties + 1] = "target armor" end
                if (bit.band(data.penalties, 4) == 4) then penalties[#penalties + 1] = "gun skill" end
                if (bit.band(data.penalties, 8) == 8) then penalties[#penalties + 1] = "skill effective range" end
                if (bit.band(data.penalties, 16) == 16) then penalties[#penalties + 1] = "gun effective range" end
                if (bit.band(data.penalties, 32) == 32) then penalties[#penalties + 1] = "gun aim penalty" end
                if (bit.band(data.penalties, 64) == 64) then penalties[#penalties + 1] = "target speed/movement" end
                if (bit.band(data.penalties, 128) == 128) then penalties[#penalties + 1] = "melee skill" end

                if (bit.band(data.bonus, 1) == 1) then bonus[#bonus + 1] = "bodypart hit range" end
                if (bit.band(data.bonus, 4) == 4) then bonus[#bonus + 1] = "gun skill" end
                if (bit.band(data.bonus, 8) == 8) then bonus[#bonus + 1] = "skill effective range" end
                if (bit.band(data.bonus, 128) == 128) then bonus[#bonus + 1] = "melee skill" end

                local finalText2 = table.concat({
                    "Final crit chance: ", math.Clamp(math.Round(data.calcCrit * 100), 0, 100), "%",
                    " | Penalties: ", (#penalties > 0 and table.concat(penalties, ", ")) or "none",
                    " | Bonus: ", (#bonus > 0 and table.concat(bonus, ", ")) or "none"
                }, "")

                if (ix.option.Get("showDamageInfoChat")) then
                    chat.AddText(icon, color, finalText2)
                else
                    MsgC(color, finalText2, "\n")
                end
            end
        end
    end

    ix.chat.Register("weapon_damage", CLASS)
end

ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_util.lua")
ix.util.Include("sv_plugin.lua")

--PLUGIN:RegisterHitBox(hitBox, minRange, minRangeVal, maxRange, maxRangeVal, critAdjust, hitAdjust)
-- How to Modify damage, plz help. I was told the below does, but it doesn't affect the damage modifiers!!! @Gr4Ss
-- ^^ nvm I fix it :) - M!NT
ix.weapons:RegisterHitBox(HITGROUP_HEAD, 40, 0.1, 85, 0.05, 1.25, 1.0)

-- CENTER OF MASS
ix.weapons:RegisterHitBox(HITGROUP_CHEST,   40, 0.3, 85, 0.2, 1.1, 1.0)
ix.weapons:RegisterHitBox(HITGROUP_STOMACH, 40, 0.4, 85, 0.3, 1.1, 1.0)
ix.weapons:RegisterHitBox(HITGROUP_GENERIC, 40, 0.5, 85, 0.4, 1.1, 0.9)
ix.weapons:RegisterHitBox(HITGROUP_GEAR,    40, 0.5, 85, 0.4, 0.9, 0.7)

-- ARM
ix.weapons:RegisterHitBox(HITGROUP_LEFTARM,  40, 0.3, 85, 0.2, 0.9, 0.7)
ix.weapons:RegisterHitBox(HITGROUP_RIGHTARM, 40, 0.3, 85, 0.2, 0.9, 0.7)

-- LEG
ix.weapons:RegisterHitBox(HITGROUP_LEFTLEG,  40, 0.3, 85, 0.2, 0.9, 0.7)
ix.weapons:RegisterHitBox(HITGROUP_RIGHTLEG, 40, 0.3, 85, 0.2, 0.9, 0.7)

ix.weapons:RegisterWeaponCat("pistol", {
    name = "Pistol",
    baseDamage = 9,
    armorPen = 0.2,
    numShots = 3,
    noSkillMod = 0.8,
    minSkill = 0,
    maxSkill = 20,
    maxSkillMod = 1.1,
    pointBlankMod = 1,
    minEffRange = 0,
    effRange = 40,
    maxEffRange = 75
})
ix.weapons:RegisterWeaponCat("revolver", {
    name = "Revolver",
    baseDamage = 28,
    armorPen = 0.4,
    numShots = 1,
    noSkillMod = 0.7,
    minSkill = 0,
    maxSkill = 30,
    maxSkillMod = 1.2,
    pointBlankMod = 1,
    minEffRange = 0,
    effRange = 40,
    maxEffRange = 80
})
ix.weapons:RegisterWeaponCat("smg", {
    name = "SMG",
    baseDamage = 9,
    armorPen = 0.4,
    numShots = 4,
    noSkillMod = 0.7,
    minSkill = 10,
    maxSkill = 30,
    maxSkillMod = 1.2,
    pointBlankMod = 1,
    minEffRange = 0,
    effRange = 50,
    maxEffRange = 100
})
ix.weapons:RegisterWeaponCat("assaultrifle", {
    name = "Assault Rifle",
    baseDamage = 17,
    armorPen = 0.4,
    numShots = 3,
    noSkillMod = 0.5,
    minSkill = 20,
    maxSkill = 40,
    maxSkillMod = 1.2,
    pointBlankMod = 0.8,
    minEffRange = 1,
    effRange = 75,
    maxEffRange = 150
})
ix.weapons:RegisterWeaponCat("dmr", {
    name = "DMR",
    baseDamage = 24,
    armorPen = 0.45,
    numShots = 2,
    noSkillMod = 0.4,
    minSkill = 20,
    maxSkill = 50,
    maxSkillMod = 1.2,
    pointBlankMod = 0.6,
    minEffRange = 2,
    effRange = 125,
    maxEffRange = 250
})
ix.weapons:RegisterWeaponCat("boltaction", {
    name = "Bolt Action Rifle",
    baseDamage = 61,
    armorPen = 0.4,
    numShots = 1,
    noSkillMod = 0.4,
    minSkill = 30,
    maxSkill = 50,
    maxSkillMod = 1.1,
    pointBlankMod = 0.4,
    minEffRange = 3,
    effRange = 300,
    maxEffRange = 500
})
ix.weapons:RegisterWeaponCat("shotgun", {
    name = "Shotgun",
    baseDamage = 11,
    armorPen = 0.2,
    numShots = 1,
    noSkillMod = 0.8,
    minSkill = 5,
    maxSkill = 20,
    maxSkillMod = 1,
    pointBlankMod = 1,
    minEffRange = 0,
    effRange = 40,
    maxEffRange = 80
})
ix.weapons:RegisterWeaponCat("lmg", {
    name = "Light Machine Gun",
    baseDamage = 10,
    armorPen = 0.1,
    numShots = 8,
    noSkillMod = 0.3,
    minSkill = 40,
    maxSkill = 50,
    maxSkillMod = 1,
    pointBlankMod = 0.6,
    minEffRange = 1,
    effRange = 75,
    maxEffRange = 150
})

--[[
hit/critical =  (hitBoxCrit(range, hitBox) * armorPen(hitBox == torso/stomach, weaponCat)) * ((weaponAimSkill(gunSkill, weaponCat) * rangeAimSkill(gunSkill, range)) * effectiveRangeMod(range, weaponCat)) * dodge(victimSpeedSkill, isFFMoving, range)
                (max 0.7                   * (max 1))                          	           * ((max 1.2                             *  max 1.2)                       * max 1)                               * max 1
    -> Hit: damage = (damage * hitBoxDamageCritAdjustment(hitBox))
    -> Miss: damage = (damage * hitBoxDamageHitAdjustment(hitBox))
data points:
    HitBox (for every hitbox):
        minRange    -- below & up to minRange -> minRangeVal
        minRangeVal -- val between 0-0.7
                    -- in between minRange & maxRange -> interpolate between inRangeVal & maxRangeVal
        maxRange    -- from maxRange & above -> maxRangeVal
        maxRangeVal -- val between 0-0.7
    WeaponCat (for every weapon category):
        armorPen    -- lower crit chance if hitting armor -> between 0-1
        noSkillVal  -- penalty for zero/no skill -> val between 0-1
                    -- in between 0 and minAimSkill -> interpolate between noSkillLevel and 1
        minAimSkill -- level at which no penalty/bonus is given -> aka val = 1
        maxAimSkill -- level at which maximum aimSkill bonus is given
        maxSkillVal -- bonus given at/above maxAimSkill, val between 1-1.2

        pointBlankMod -- val between 0 and 1
                    -- in between 0 and MinEffrange -> interpolate between pointBlankMod and 1
        MinEffRange
                    -- in between MinEffRange and EffRange -> mod = 1
        EffRange
                    -- in between EffRange and MaxEffRange -> interpolate  between 1 and 0.2
        MaxEffRange
    GunSkill:
        zeroEffRange -- Effective range at level 0
        maxEffRange  -- Effective range at level 50
                     -- below effective range = 1.2 bonus
                     -- between eff range and max range = interpolate between 1.2 and 1
                     -- above max range = max(interpolate between 1 and .., 0) (same scale as eff range to max range)
        zeroMaxRange -- Max Effective range at level 0
        maxMaxRange  -- Max Effective range at level 50
    Weapon (for every weapon):
        category
]]

function PLUGIN:TFA_CanBash(weapon)
    return false
end

for _, item in pairs(ix.item.list) do
    if (item.balanceCat and ix.weapons) then
        if (item.isMelee) then
            ix.weapons:RegisterMeleeWeapon(item.class, item.balanceCat)
        else
            ix.weapons:RegisterWeapon(item.class, item.balanceCat)
        end

        ix.weapons:RegisterWeaponExceptions(item.class, item.baseDamage, item.armorPen, item.aimPenalty, item.numShots)
    end
end
