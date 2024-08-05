--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Stalker"
FACTION.description = ""
FACTION.color = Color(92, 92, 92)
FACTION.models = {"models/stalker.mdl"}
FACTION.maxHealth = 70
FACTION.armor = 0

FACTION.isDefault = false
FACTION.noAppearances = true
FACTION.noBackground = true
FACTION.noBeard = true
FACTION.noGender = true
FACTION.noNeeds = true
FACTION.noGenetics = true
FACTION.ReadOptionDisabled = true
FACTION.noAttributes = true
FACTION.noNeeds = true
FACTION.noGas = true
FACTION.noTBC = true
FACTION.isCombineFaction = true

FACTION.allowForcefieldControl = true
FACTION.allowCombineDoors = true
FACTION.allowCombineLock = true
FACTION.alwaysFlashlight = true

FACTION.factionImage = "willardnetworks/faction_imgs/stalker.png"
FACTION.selectImage = "willardnetworks/faction_imgs/stalker.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/nexus.png"

FACTION.npcRelations = {
	["npc_combine_camera"] = D_LI,
	["npc_turret_ceiling"] = D_LI,
	["npc_cscanner"] = D_LI,
	["npc_manhack"] = D_LI,
	["npc_rollermine"] = D_LI,
	["npc_clawscanner"] = D_LI,
	["npc_turret_floor"] = D_LI,

	["npc_combinedropship"] = D_LI,
	["CombineElite"] = D_LI,
	["npc_combinegunship"] = D_LI,
	["npc_combine_s"] = D_LI,
	["npc_hunter"] = D_LI,
	["npc_helicopter"] = D_LI,
	["CombinePrison"] = D_LI,
	["PrisonShotgunner"] = D_LI,
	["ShotgunSoldier"] = D_LI,
	["npc_stalker"] = D_LI,
	["npc_strider"] = D_LI,
}

function FACTION:OnSpawn(client)
	timer.Simple(0.1, function()
		client:SetRunSpeed(ix.config.Get("walkSpeed") * 0.5)
		client:SetWalkSpeed(ix.config.Get("walkSpeed") * 0.5)
		client:SetArmor(self.armor)
		client:SetMaxArmor(self.armor)

		-- client:StripWeapons()
	end)
end

function FACTION:GetDefaultName(client)
	return "CMB:STALKER-" .. Schema:ZeroNumber(math.random(1, 99), 2), true
end

FACTION_STALKER = FACTION.index
