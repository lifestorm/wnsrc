--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "TFA Weapons"
ITEM.base = "base_weapons"
ITEM.description = "A Weapon."
ITEM.category = "Weapons"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.class = "weapon_pistol"
ITEM.width = 2
ITEM.height = 2
ITEM.isWeapon = true
ITEM.isGrenade = false
ITEM.weaponCategory = "sidearm"
ITEM.useSound = "items/ammo_pickup.wav"

ITEM.atts = {}

function ITEM:GetDescription()
	local description = {self.description}
	return table.concat(description, "")
end

function ITEM:GetBaseInfo()
	local baseInfo = {}
	if (self.balanceCat) then
		baseInfo[#baseInfo + 1] = "Weapon Category: "
        baseInfo[#baseInfo + 1] = self.balanceCat
        if (self.isMelee) then
            baseInfo[#baseInfo + 1] = " melee"
        end
		if (CLIENT) then
			baseInfo[#baseInfo + 1] = "\nBase crit chance: "
            if (self.isMelee) then
                baseInfo[#baseInfo + 1] = math.max(math.floor(ix.weapons:GetMeleeWeaponBaseHitChance(LocalPlayer():GetCharacter(), self.class) * ix.weapons:GetWeaponAimPenalty(self.class) * 100), 0)
            else
                baseInfo[#baseInfo + 1] = math.floor(ix.weapons:GetWeaponSkillMod(LocalPlayer():GetCharacter(), self.class) * ix.weapons:GetWeaponAimPenalty(self.class) * 100)
            end
            baseInfo[#baseInfo + 1] = "%%"
		end
	end

	return table.concat(baseInfo, "")
end

function ITEM:GetExtendedInfo()
	local extendedInfo = {}
    if (self.balanceCat) then
        if (self.isMelee) then
            extendedInfo[#extendedInfo + 1] = "Base damage: "
            extendedInfo[#extendedInfo + 1] = ix.weapons:GetMeleeWeaponBaseDamage(self.class)
        else
            extendedInfo[#extendedInfo + 1] = "Base damage: "
            extendedInfo[#extendedInfo + 1] = ix.weapons:GetWeaponBaseDamage(self.class)

            local min, max, bFlat = ix.weapons:GetWeaponSkillRequired(self.class)
            if (!bFlat) then
                extendedInfo[#extendedInfo + 1] = "\nSkill range: "
                extendedInfo[#extendedInfo + 1] = min.."-"..max
            else
                extendedInfo[#extendedInfo + 1] = "\nSkill required: "
                extendedInfo[#extendedInfo + 1] = min
            end

            local minR, effR = ix.weapons:GetWeaponEffectiveRanges(self.class)
            extendedInfo[#extendedInfo + 1] = "\nMinimum effective range: "
            extendedInfo[#extendedInfo + 1] = minR.."m"
            extendedInfo[#extendedInfo + 1] = "\nMaximum effective range: "
            extendedInfo[#extendedInfo + 1] = effR.."m"

            extendedInfo[#extendedInfo + 1] = "\nShots per action point: "
            extendedInfo[#extendedInfo + 1] = ix.weapons:GetWeaponNumShots(self.class)
            extendedInfo[#extendedInfo + 1] = "\nArmor Penetration: "
            extendedInfo[#extendedInfo + 1] = math.floor(ix.weapons:GetArmorPen(self.class) * 100).."%%"
        end
	end

	return table.concat(extendedInfo, "")
end

function ITEM:GetColorAppendix()
	if self.balanceCat then
		return {["blue"] = self:GetBaseInfo(), ["red"] = self:GetExtendedInfo()}
	end
end

function ITEM:OnRegistered()
    if (self.balanceCat and ix.weapons) then
        if (self.isMelee) then
            ix.weapons:RegisterMeleeWeapon(self.class, self.balanceCat)
        else
            ix.weapons:RegisterWeapon(self.class, self.balanceCat)
        end

        ix.weapons:RegisterWeaponExceptions(self.class, self.baseDamage, self.armorPen, self.aimPenalty, self.numShots)
    end
end

function ITEM:OnEquipWeapon(client, weapon)
    if (self:GetData("BioLocked") or self:GetData("tfa_atts") or !table.IsEmpty(self.atts)) then
        timer.Simple(0.5, function()
            weapon:SetNetVar("ixItemAtts", self.atts)

            if (!IsValid(weapon)) then return end
            weapon:InitAttachments()

            for _, v in pairs(self.atts) do
                if (self:GetData("tfa_default_atts_uneq", {})[v]) then continue end

                weapon:Attach(v)
            end

            if (self:GetData("tfa_atts")) then
                for _, v in pairs(self:GetData("tfa_atts")) do
                    if (istable(v) and v.att) then
                        weapon:Attach(v.att)
                    end
                end
            end

            if (self:GetData("BioLocked")) then
                weapon:SetNetVar("BioLocked", true)
            end
        end)
    end
end