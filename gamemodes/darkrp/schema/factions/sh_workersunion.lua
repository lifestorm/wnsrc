--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Civil Workers Union"
FACTION.description = "A member of the Workers Union"
FACTION.color = Color(63, 142, 164, 255)
FACTION.isDefault = false

-- Char Create Stuff
FACTION.noBackground = true
FACTION.factionImage = "materials/willardnetworks/faction_imgs/cwu.png"
FACTION.selectImage = "materials/willardnetworks/charselect/citizen2.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/factory.png"

-- Gameplay stuff
FACTION.bIsBystanderTBC = true
FACTION.humanVoices = true
FACTION.allowForcefieldInfestationPassage = true

FACTION.idInspectionText = "Worker"

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
	["npc_turret_ceiling"] = D_LI,
	["npc_cscanner"] = D_LI,
	["npc_manhack"] = D_LI,
	["npc_turret_floor"] = D_LI,
}

FACTION.radioChannels = {"cca-cwu"}

-- Functions
function FACTION:OnCharacterCreated(client, character)
	character:CreateIDCard()
	local background = character:GetBackground()

	-- Give clothing chosen upon char creation
	local inventory = character:GetInventory()
	inventory:Add("pda_cwu", 1)
	inventory:Add("cwu_card", 1)

	if (background == "Worker") then
		inventory:Add("torso_yellow_worker_jacket", 1)
		inventory:Add("cwu_radio", 1)
	end
	if (background == "Medic") then
		inventory:Add("torso_medic_shirt", 1)
		inventory:Add("cmru_radio", 1)
	end

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

FACTION_WORKERS = FACTION.index
