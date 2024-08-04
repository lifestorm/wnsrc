--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Ministry of Entertainment"
FACTION.description = "A member of the MOE."
FACTION.color = Color(144, 65, 233, 255)
FACTION.isDefault = false

-- Char Create Stuff
FACTION.noBackground = true
FACTION.factionImage = "materials/willardnetworks/faction_imgs/cityadmin.png"
FACTION.selectImage = "materials/willardnetworks/charselect/citizen2.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/office.png"

-- Scoreboard stuff
FACTION.isGloballyRecognized = true

-- Gameplay stuff
FACTION.humanVoices = true

FACTION.allowForcefieldPassage = true
FACTION.allowCIDCreator = true
FACTION.allowDatafile = true
FACTION.allowComputerLoginOverride = true
FACTION.allowUseGroupLock = true
FACTION.allowEnableRations = true
FACTION.allowCombineDoors = true
FACTION.allowCombineLock = true
FACTION.canHearRequests = true
FACTION.noSmuggler = true

FACTION.idInspectionText = "Entertainment"

-- Tables
FACTION.models = {
	female = {
		"models/willardnetworks/citizens/female_01.mdl",
		"models/willardnetworks/citizens/female_02.mdl",
		"models/willardnetworks/citizens/female_03.mdl",
		"models/willardnetworks/citizens/female_04.mdl",
		"models/willardnetworks/citizens/female_06.mdl",
		"models/willardnetworks/citizens/female_05.mdl"
	};
	male = {
		"models/willardnetworks/citizens/male_01.mdl",
		"models/willardnetworks/citizens/male_02.mdl",
		"models/willardnetworks/citizens/male_03.mdl",
		"models/willardnetworks/citizens/male_04.mdl",
		"models/willardnetworks/citizens/male_05.mdl",
		"models/willardnetworks/citizens/male_06.mdl",
		"models/willardnetworks/citizens/male_07.mdl",
		"models/willardnetworks/citizens/male_08.mdl",
		"models/willardnetworks/citizens/male_09.mdl",
		"models/willardnetworks/citizens/male_10.mdl"
	};
};

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

FACTION.radioChannels = {"cca", "cmb", "cca-cwu"}

-- Functions
local translate = {nil, "torso", "legs", "shoes"}
translate[8] = "glasses"
function FACTION:OnCharacterCreated(client, character)
	character:CreateIDCard()

	local inventory = character:GetInventory()
	inventory:Add("pda", 1)

	-- Give clothing chosen upon char creation
	local chosenClothes = character:GetData("chosenClothes")
	if (istable(chosenClothes) and !table.IsEmpty(chosenClothes)) then
		if chosenClothes.torso then
			inventory:Add(chosenClothes.torso, 1)
		end

		if chosenClothes.legs then
			inventory:Add(chosenClothes.legs, 1)
		end

		if chosenClothes.shoes then
			inventory:Add(chosenClothes.shoes, 1)
		end

		if chosenClothes["8"] then
			inventory:Add("glasses", 1)
		end

		character:SetData("equipBgClothes", true)
	end
	character:SetData("chosenClothes", nil)
end

function FACTION:OnTransferred(character)
	local genericData = character:GetGenericdata()
	genericData.combine = false
	character:SetGenericdata(genericData)
end

FACTION_MOE = FACTION.index
