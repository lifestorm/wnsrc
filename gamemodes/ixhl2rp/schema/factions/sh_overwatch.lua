--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Overwatch AI"
FACTION.description = "The central Overwatch network."
FACTION.color = Color(150, 50, 50, 255)
FACTION.isDefault = false

FACTION.noAppearances = true
FACTION.noAttributes = true
FACTION.noBackground = true
FACTION.noBeard = true
FACTION.noGender = true
FACTION.noHair = true
FACTION.noGenetics = true
FACTION.ReadOptionDisabled = true
FACTION.factionImage = "willardnetworks/faction_imgs/cmb.png"
FACTION.selectImage = "willardnetworks/faction_imgs/cmb.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/nexus.png"

FACTION.isGloballyRecognized = true

FACTION.noNeeds = true
FACTION.noGas = true
FACTION.noTBC = true
FACTION.noGenDesc = true
FACTION.saveItemsAfterDeath = true

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

FACTION.idInspectionText = "Dispatch"

FACTION.models = {"models/dav0r/hoverball.mdl"}

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
	["npc_strider"] = D_LI,
}

FACTION.radioChannels = {"ota-tac", "tac-3", "tac-4", "tac-5", "cmb", "cca", "mcp", "ccr-tac"}


function FACTION:GetDefaultName(client)
	return "S"..ix.config.Get("sectorIndex", "10")..":SCN-"..Schema:ZeroNumber(math.random(1, 9), 1), true
end

function FACTION:OnNameChanged(client, oldValue, value)
	if (oldValue == "") then return end

	if (!Schema:IsCombineRank(oldValue, "SCN") and Schema:IsCombineRank(value, "SCN")
			or !Schema:IsCombineRank(oldValue, "SHIELD") and Schema:IsCombineRank(value, "SHIELD")) then
		client:GetCharacter():SetClass(CLASS_OW_SCANNER)
	elseif (!Schema:IsCombineRank(value, "SCN") and !Schema:IsCombineRank(value, "SHIELD")) then
		client:GetCharacter():SetClass(CLASS_OVERWATCH)
	elseif (!Schema:IsCombineRank(value, "SCN") and !Schema:IsCombineRank(value, "Disp:AI")) then
		client:GetCharacter():SetClass(CLASS_OW_SCANNER)
	end
end

function FACTION:OnTransferred(character)
	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])

	local genericData = character:GetGenericdata()
	genericData.combine = "overwatch"
	character:SetGenericdata(genericData)
end

function FACTION:OnSpawn(client)
	if (Schema:IsCombineRank(client:Name(), "SCN") or Schema:IsCombineRank(client:Name(), "SHIELD") or Schema:IsCombineRank(client:Name(), "Disp:AI")) then
		client:GetCharacter():SetClass(CLASS_OW_SCANNER)
	else
		client:GetCharacter():SetClass(CLASS_OVERWATCH)
	end
end

FACTION_OVERWATCH = FACTION.index
