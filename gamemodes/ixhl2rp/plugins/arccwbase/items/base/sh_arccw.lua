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

ITEM.name = "ArcCW Weapons"
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

ITEM.defaultAttachments = {}

local color_green = Color(100, 255, 100)
local color_red = Color(200, 25, 25)

function ITEM:GetDescription()
	local description = {self.description}
	return table.concat(description, "")
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
        local shotsBeforeBreak = ITEM.shotsBeforeBreak or ix.config.Get("shotsBeforeBreakingWeapon", 900)
        local shotsFired = item:GetShotsFired()
        local width = w - 8
        local durLerp = 1 - (shotsFired / shotsBeforeBreak)
        local color = ix.util.ColorLerp(durLerp, color_red, color_green)
        surface.SetDrawColor(color)

        surface.DrawRect(5, h - 8, width * durLerp, 4)
	end
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

function ITEM:GetMagazineInfo()
    if (!self.magazines or table.IsEmpty(self.magazines)) then return "This weapon has no magazines set. Please submit a bug report." end


    local magInfo = {}
    for mag in pairs(self.magazines) do
        local itemTable = ix.item.list[mag]
        if (itemTable) then
            magInfo[#magInfo + 1] = itemTable:GetName()
        else
            magInfo[#magInfo + 1] = mag
        end
    end

    return "Magazines: "..table.concat(magInfo, ", ")
end

function ITEM:GetColorAppendix()
    local info = {["green"] = self:GetMagazineInfo()}
	if self.balanceCat then
		info["blue"] =  self:GetBaseInfo()
        info["red"] = self:GetExtendedInfo()
	end

    return info
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

    if (self.OnRegistered2) then
        self:OnRegistered2()
    end
end

function ITEM.EquipAttachment(client, weapon, slot, attachment)
    client.ixAttachWeapon = weapon
    weapon:Attach(slot, attachment, true)
    client.ixAttachWeapon = nil
end

function ITEM:OnEquipWeapon(client, weapon)
    weapon:SetNetVar("ixItemID", weapon.ixItem:GetID())

    local oldPrimaryAttack = weapon.PrimaryAttack
    weapon.PrimaryAttack = function(s)
        oldPrimaryAttack(s)

        if !self:GetData("broken", false) then
            local shotData = self:GetData("FiredShots", 0)
            self:SetData("FiredShots", shotData + 1)
            self:OnShotFired(shotData + 1, s, client)
        end
    end

    if (self:GetData("BioLocked") or self:GetData("WeaponAttachments") or !table.IsEmpty(self.defaultAttachments)) then
        timer.Simple(0.5, function()
			if (!IsValid(weapon)) then return end
            weapon:SetNWBool("ArcCW_DisableAutosave", true)
            weapon:SetNetVar("ixItemDefaultWeaponAtts", self.defaultAttachments)

            for _, v in pairs(self.defaultAttachments) do
                if (self:GetData("WeaponDefaultAttachmentsUnequipped", {})[v.attachment]) then continue end
                self.EquipAttachment(client, weapon, v.slot, v.attachment)
            end

            if (self:GetData("WeaponAttachments")) then
                for _, v in pairs(self:GetData("WeaponAttachments")) do
                    if (istable(v) and v.attachment) then
						self.EquipAttachment(client, weapon, v.slot, v.attachment)
                    end
                end
            end

            if (self:GetData("BioLocked")) then
                weapon:SetNetVar("BioLocked", true)
            end
        end)
    end
end

function ITEM:GetShotsFired()
    return self:GetData("FiredShots", 0)
end

function ITEM:OnShotFired(shotsFired, weapon, client)
    if ITEM.shotsBeforeBreak and shotsFired > ITEM.shotsBeforeBreak or shotsFired > ix.config.Get("shotsBeforeBreakingWeapon", 900) then
        self:BreakWeapon(client)
    end
end

function ITEM:BreakWeapon(client)
    self:SetData("FiredShots", ITEM.shotsBeforeBreak and ITEM.shotsBeforeBreak or ix.config.Get("shotsBeforeBreakingWeapon", 900))

    self:SetData("broken", true)

    if client:Alive() then
        self:Unequip(client)
        client:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav")
    end
end

function ITEM:OnUnequipWeapon(client, weapon)
    weapon:SetNetVar("ixItemID", nil)

    if (self:GetData("reloadMagazineItem")) then
        local chamber = math.Clamp(weapon:Clip1(), 0, weapon:GetChamberSize())
        PLUGIN:RefundAmmoItem(weapon, client:GetCharacter(), self:GetData("reloadMagazineItem"), weapon:Clip1() + client:GetAmmoCount(weapon:GetPrimaryAmmoType()) - chamber, self:GetData("reloadMagazineInvPos"))
        self:SetData("ammo", chamber)
        self:SetData("reloadMagazineItem", nil)
        client:SetAmmo(0, weapon:GetPrimaryAmmoType())
    end
end

if (SERVER) then

    ix.log.AddType("potentialMagExploitAbuse", function(client, item, ammoToRefund)
        return string.format("%s is removing a mag while reloading: Item ID: #(%d) Ammo: %s", client:GetName(), item:GetID(), ammoToRefund)
    end, FLAG_DANGER)

end

ITEM.functions.repairWeapon = {
	name = "Repair Weapon",
    icon = "icon16/bullet_wrench.png",
	OnRun = function(item)
        local client = item.player

        local character = client:GetCharacter()
        local inv = character:GetInventory()
        local repairKit = inv:HasItem("weapon_repair_kit")

        if (!repairKit) then
            client:NotifyLocalized("You don't have a repair kit!")
            return false
        end

        client:EmitSound("willardnetworks/skills/skill_medicine.wav")

        repairKit:DamageDurability(1)
        item:SetData("FiredShots", 0)
        item:SetData("broken", false)

        return false
	end,
	OnCanRun = function(item)
        local client = item.player

        if (IsValid(item.entity) or !IsValid(item:GetOwner())) then return false end

        if (!IsValid(client)) then return false end

        local character = client:GetCharacter()
        local inv = character:GetInventory()
        local repairKit = inv:HasItem("weapon_repair_kit")

        if (!repairKit) then return false end

        return true
	end
}

ITEM.functions.removeMag = {
	name = "Remove Magazine",
	OnRun = function(item, data)
        local client = item:GetOwner()
        for k, v in pairs(client:GetWeapons()) do
            if (v:GetClass() == item.class) then
                local chamber = math.Clamp(v:Clip1(), 0, v:GetChamberSize())
                local ammoToRefund = v:Clip1() + client:GetAmmoCount(v:GetPrimaryAmmoType()) - chamber
                ix.log.Add(client, "potentialMagExploitAbuse", item, ammoToRefund)

                PLUGIN:RefundAmmoItem(v, client:GetCharacter(), item:GetData("reloadMagazineItem"), ammoToRefund, item:GetData("reloadMagazineInvPos"))
                item:SetData("reloadMagazineItem", nil)
                v:SetClip1(chamber)
                item:SetData("ammo", chamber)
                return false
            end
        end

        return false
	end,
	OnCanRun = function(item)
        if (IsValid(item.entity) or !IsValid(item:GetOwner())) then return false end

        if (!item:GetData("equip") or !item:GetData("reloadMagazineItem")) then return false end

        for k, v in pairs(item:GetOwner():GetWeapons()) do
            if (v:GetClass() == item.class) then
                return true
            end
        end

        return false
	end
}

ITEM.functions.clearChamber = {
	name = "Clear Chamber",
	OnRun = function(item, data)
        local ammoItem = ix.item.list[next(item.magazines)]
        local inventory = ix.item.inventories[item.invID]
        local amount = item:GetData("ammo", 0)
        if (!inventory:Add(ammoItem.bullets, 1, {stack = amount, bIsSplit = true})) then
			ix.item.Spawn(uniqueID, item.player, function(itemT)
                itemT:SetStack(amount)
            end)
		end
        item:SetData("ammo", chamber)

        return false
	end,
	OnCanRun = function(item)
        if (IsValid(item.entity) or !IsValid(item:GetOwner())) then return false end

        if (item:GetData("ammo", 0) <= 0) then return false end

        if (!item.magazines) then return false end
        local ammoItem = ix.item.list[next(item.magazines)]
        if (!ammoItem or !ammoItem.bullets) then return false end

        if (item:GetData("equip")) then return false end

        local inventory = ix.item.inventories[item.invID]
        if (!inventory) then return false end

        return true
	end
}