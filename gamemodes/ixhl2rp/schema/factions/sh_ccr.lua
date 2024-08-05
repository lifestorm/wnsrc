--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Combine Conscript Reserve"
FACTION.description = "Combine Civil Reserve a Human meatshields"
FACTION.color = Color(50, 100, 150)
FACTION.isDefault = false

-- Char Create Stuff
FACTION.noAppearances = false
FACTION.noBackground = true
FACTION.noBeard = false
FACTION.ReadOptionDisabled = true
FACTION.factionImage = "materials/willardnetworks/faction_imgs/citizen.png"
FACTION.selectImage = "materials/willardnetworks/faction_imgs/citizen2.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/street.png"

FACTION.humanVoices = true

-- Scoreboard Stuff
FACTION.isGloballyRecognized = false
FACTION.separateUnknownTab = true

-- Gameplay stuff
FACTION.noGenDesc = false
FACTION.allowForcefieldInfestationPassage = true

FACTION.isCombineFaction = false
FACTION.allowCombineDoors = true
FACTION.noNeeds = false
FACTION.noGas = false

-- Tables
FACTION.models = {
	female = {
	"models/willardnetworks/conscripts/female_01.mdl",
	"models/willardnetworks/conscripts/female_02.mdl",
	"models/willardnetworks/conscripts/female_03.mdl",
	"models/willardnetworks/conscripts/female_04.mdl",
	"models/willardnetworks/conscripts/female_05.mdl",
	"models/willardnetworks/conscripts/female_06.mdl"
	};
	male = {
		"models/willardnetworks/conscripts/male_01.mdl",
		"models/willardnetworks/conscripts/male_02.mdl",
		"models/willardnetworks/conscripts/male_03.mdl",
		"models/willardnetworks/conscripts/male_04.mdl",
		"models/willardnetworks/conscripts/male_05.mdl",
		"models/willardnetworks/conscripts/male_06.mdl",
		"models/willardnetworks/conscripts/male_07.mdl",
		"models/willardnetworks/conscripts/male_08.mdl",
		"models/willardnetworks/conscripts/male_09.mdl",
		"models/willardnetworks/conscripts/male_10.mdl"
	}
}

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

function FACTION:OnCharacterCreated(client, character)
	character:CreateIDCard()

    local inventory = character:GetInventory()
	inventory:Add("smallbag")
	inventory:Add("largebag")
	inventory:Add("ccr_radio")
	character:SetData("equipBgClothes", true)

end

FACTION_CCR = FACTION.index
