--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Server Administration"
FACTION.description = "Staff members of Willard.Network"
FACTION.color = Color(255, 85, 20, 255)
FACTION.isDefault = false
FACTION.factionImage = "materials/willardnetworks/faction_imgs/admin.png"
FACTION.selectImage = "materials/willardnetworks/faction_imgs/admin.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/street.png"

FACTION.noBackground = true
FACTION.noBeard = true
FACTION.noGender = true
FACTION.noGenetics = true
FACTION.noHair = true
FACTION.noAppearances = true

FACTION.isGloballyRecognized = true
FACTION.seeAll = true
FACTION.recogniseAll = true

FACTION.noNeeds = true
FACTION.noGas = true
FACTION.noTBC = true
FACTION.noGenDesc = true
FACTION.saveItemsAfterDeath = true

FACTION.canSeeWaypoints = true

FACTION.allLanguages = true
FACTION.allowForcefieldControl = true
FACTION.allowCIDCreator = true
FACTION.allowEnableRations = true
FACTION.allowComputerLoginOverride = true
FACTION.allowCombineDoors = true
FACTION.allowCombineLock = true
FACTION.alwaysFlashlight = true
FACTION.canHearRequests = true

FACTION.models = {"models/breen.mdl"}

FACTION.lockAllDoors = true

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

function FACTION:GetDefaultName(client)
	return client:SteamName(), false
end

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("smallbag")
	inventory:Add("largebag")

	character:SetData("equipBgClothes", true)
end

function FACTION:OnWhitelist(client)
	local faction = ix.faction.teams["event"]
	if (faction) then
		client:SetWhitelisted(faction.index, true)
	end
end

FACTION_SERVERADMIN = FACTION.index
