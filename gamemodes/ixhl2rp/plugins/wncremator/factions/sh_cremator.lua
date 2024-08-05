--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


FACTION.name = "Cremator"
FACTION.description = "A Combine janitor of sorts"
FACTION.color = Color(83, 51, 3)
FACTION.isDefault = false
FACTION.runSounds = {[0] = "npc/cremator/foot1.wav", [1] = "npc/cremator/foot2.wav", [3] = "npc/cremator/foot3.wav"}
FACTION.models = {"models/wn7new/combine_cremator/cremator.mdl"}
FACTION.factionImage = "willardnetworks/faction_imgs/cremator.png"
FACTION.selectImage = "willardnetworks/faction_imgs/cremator.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/nexus.png"
FACTION.noAppearances = true
FACTION.noAttributes = true
FACTION.noBackground = true
FACTION.noBeard = true
FACTION.noGender = true
FACTION.noGenetics = true
FACTION.ReadOptionDisabled = true
FACTION.isGloballyRecognized = true

FACTION.noNeeds = true
FACTION.noGas = true
FACTION.noTBC = true

FACTION.isCombineFaction = true

FACTION.canSeeWaypoints = true
FACTION.canAddWaypoints = true
FACTION.canRemoveWaypoints = true
FACTION.canUpdateWaypoints = true

FACTION.allLanguages = true
FACTION.allowForcefieldControl = true
FACTION.allowCIDCreator = true
FACTION.allowEnableRations = true
FACTION.allowCombineDoors = true
FACTION.allowCombineLock = true
FACTION.alwaysFlashlight = true
FACTION.alwaysDatafile = true
FACTION.canHearRequests = true
FACTION.noSmuggler = true
FACTION.noGenDesc = true

FACTION.npcRelations = {
	["npc_combine_camera"] = D_LI,
	["npc_turret_ceiling"] = D_LI,
	["npc_cscanner"] = D_LI,
	["npc_manhack"] = D_LI,
	["npc_rollermine"] = D_LI,
	["npc_clawscanner"] = D_LI,
	["npc_turret_floor"] = D_LI,
	["npc_metropolice"] = D_LI,
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
	["npc_strider"] = D_LI
}

function FACTION:GetDefaultName(client)
	return "C24.CREMATOR:" .. Schema:ZeroNumber(math.random(100, 999), 3), true
end

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()

	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end

FACTION_CREMATOR = FACTION.index
