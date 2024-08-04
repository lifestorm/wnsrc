--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Civil Protection"
FACTION.description = "A metropolice unit working as Civil Protection."
FACTION.color = Color(50, 100, 150)
FACTION.isDefault = false

-- Char Create Stuff
FACTION.noAppearances = true
FACTION.noBackground = true
FACTION.noBeard = true
FACTION.ReadOptionDisabled = true
FACTION.factionImage = "materials/willardnetworks/faction_imgs/cp.png"
FACTION.selectImage = "materials/willardnetworks/faction_imgs/cp.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/nexus.png"

FACTION.humanVoices = true

-- Scoreboard Stuff
FACTION.isGloballyRecognized = false
FACTION.separateUnknownTab = true

-- Gameplay stuff
FACTION.noGenDesc = false

FACTION.isCombineFaction = true

FACTION.canSeeWaypoints = true
FACTION.canAddWaypoints = true

FACTION.allowEnableRations = true
FACTION.allowKickDoor = true

FACTION.noNeeds = false
FACTION.noGas = false

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

-- Functions
function FACTION:GetDefaultName(client)
	return "C"..ix.config.Get("cityIndex", "24")..":RCT.YELLO-"..Schema:ZeroNumber(math.random(1, 99), 2), true
end

function FACTION:OnCharacterCreated(client, character)
	character:CreateIDCard()

    local inventory = character:GetInventory()
	inventory:Add("pda", 1)
	inventory:Add("uniform_c8_cp")
	inventory:Add("mask_cp")
	inventory:Add("smallbag")
	inventory:Add("largebag")

	character:SetSkill("guns", 5)
	character:SetSkill("speed", 10)

	character:SetData("equipBgClothes", true)
	character:SetRadioChannel("tac-3")
end

function FACTION:OnNameChanged(client, oldValue, value)
	if (oldValue == "") then return end

	if (Schema:IsCombineRank(value, "RL") and !Schema:IsCombineRank(oldValue, "RL")) then
		client:GetCharacter():SetClass(CLASS_CP_RL)
	elseif (Schema:IsCombineRank(value, "CpT") and !Schema:IsCombineRank(oldValue, "CpT")) then
		client:GetCharacter():SetClass(CLASS_CP_CPT)
	elseif (Schema:IsCombineRank(value, "ChF") and !Schema:IsCombineRank(oldValue, "ChF")) then
		client:GetCharacter():SetClass(CLASS_CP_CPT)
	elseif Schema:IsCombineRank(value, "i1") then
		client:GetCharacter():SetClass(CLASS_CP_CMD)
	elseif Schema:IsCombineRank(value, "i2") then 
		client:GetCharacter():SetClass(CLASS_CP_CMD)
	elseif (Schema:IsCombineRank(oldValue, "RL") or Schema:IsCombineRank(oldValue, "CpT")) then
		client:GetCharacter():SetClass(CLASS_CP)
	end
end

function FACTION:OnTransferred(character)
	character:SetName(self:GetDefaultName())

	local genericData = character:GetGenericdata()
	if (genericData) then
		genericData.combine = true
		character:SetGenericdata(genericData)
	end
end

function FACTION:OnSpawn(client)
	if (Schema:IsCombineRank(client:Name(), "RL")) then
		client:GetCharacter():SetClass(CLASS_CP_RL)
	elseif (Schema:IsCombineRank(client:Name(), "CpT")) or (Schema:IsCombineRank(client:Name(), "ChF")) then
		client:GetCharacter():SetClass(CLASS_CP_CPT)
	elseif (Schema:IsCombineRank(client:Name(), "i1")) or (Schema:IsCombineRank(client:Name(), "i2")) then
		client:GetCharacter():SetClass(CLASS_CP_CMD)
	else
		client:GetCharacter():SetClass(CLASS_CP)
	end
end

FACTION_CP = FACTION.index
