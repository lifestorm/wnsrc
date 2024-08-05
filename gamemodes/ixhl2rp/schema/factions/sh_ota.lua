--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Transhuman Arm"
FACTION.description = "A transhuman Overwatch soldier produced by the Combine."
FACTION.color = Color(150, 50, 50, 255)
FACTION.isDefault = false

-- Char Create stuff
FACTION.noAppearances = true
FACTION.noBackground = true
FACTION.noBeard = true
FACTION.noGender = true
FACTION.noHair = true
FACTION.ReadOptionDisabled = true
FACTION.factionImage = "materials/willardnetworks/faction_imgs/ota.png"
FACTION.selectImage = "materials/willardnetworks/charselect/ota.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/nexus.png"

-- Scoreboard Stuff
FACTION.isGloballyRecognized = true

-- Gameplay stuff
FACTION.noNeeds = true
FACTION.noGenDesc = true
FACTION.saveItemsAfterDeath = true

FACTION.isCombineFaction = true

FACTION.canSeeWaypoints = true
FACTION.canAddWaypoints = true
FACTION.canRemoveWaypoints = true
FACTION.canUpdateWaypoints = true

FACTION.allLanguages = true
FACTION.alwaysDatafile = true
FACTION.allowForcefieldPassage = true
FACTION.allowForcefieldInfestationPassage = true
FACTION.allowEnableRations = true
FACTION.allowKickDoor = true

FACTION.noSmuggler = true
FACTION.maxHealth = 150

-- Tables
FACTION.models = {
	"models/wn/ota_soldier.mdl"
}

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

-- Functions
function FACTION:GetDefaultName(client)
	return "S"
	.. (ix.config.Get("sectorIndex", "10"))
	.. "/OWS.GHOST-"
	.. Schema:ZeroNumber(math.random(1, 99), 2), true
end

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("smallbag")
	inventory:Add("largebag")
	inventory:Add("flashlight")
	inventory:Add("pda", 1)
	inventory:Add("uniform_ota")
	inventory:Add("mask_ota")
	inventory:Add("rappel_gear")
	inventory:Add("mag_pouch")
	inventory:Add("bullet_pouch")


	character:SetData("equipBgClothes", true)

	character:SetRadioChannel("ota-tac")

	character:SetSkill("guns", 50)
	character:SetSkill("speed", 20)
	for _, v in pairs(ix.special.list) do
		character:SetSpecial(v.uniqueID, 0)
	end
end

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()

	if (!Schema:IsCombineRank(oldValue, "OWS") and Schema:IsCombineRank(value, "OWS")) then
		character:SetClass(CLASS_OWS)
	elseif (!Schema:IsCombineRank(oldValue, "ORD") and Schema:IsCombineRank(value, "ORD")) then
		character:SetClass(CLASS_ORD)
	elseif (!Schema:IsCombineRank(oldValue, "OWH") and Schema:IsCombineRank(value, "OWH")) then
		character:SetClass(CLASS_CHA)
	elseif (!Schema:IsCombineRank(oldValue, "APF") and Schema:IsCombineRank(value, "APF")) then
		character:SetClass(CLASS_SUP)
	elseif (!Schema:IsCombineRank(oldValue, "EOW") and Schema:IsCombineRank(value, "EOW")) then
		character:SetClass(CLASS_EOW)
	elseif (!Schema:IsCombineRank(oldValue, "OCS") and Schema:IsCombineRank(value, "OCS")) then
		character:SetClass(CLASS_OCS)
	end
end

function FACTION:OnTransferred(character)
	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])

	local genericData = character:GetGenericdata()
	genericData.combine = true
	character:SetGenericdata(genericData)
end

function FACTION:OnSpawn(client)

	timer.Simple(0.1, function()
		client:SetRunSpeed(ix.config.Get("runSpeed") * 0.9)
		client:SetJumpPower(ix.config.Get("jumpPower") * 1.1)
	end)
end

FACTION_OTA = FACTION.index
