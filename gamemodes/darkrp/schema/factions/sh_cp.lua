--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Protection Civile"
FACTION.description = "Une unité de la Protection Civile."
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
FACTION.alwaysDatafile = true

FACTION.allowEnableRations = true
FACTION.allowKickDoor = true

FACTION.noNeeds = false
FACTION.noGas = false

FACTION.radioChannels = {"pc", "ota", "ac", "haa"}

-- Tables
FACTION.models = {
	female = {
	"models/wn7new/metropolice/female_01.mdl",
	"models/wn7new/metropolice/female_02.mdl",
	"models/wn7new/metropolice/female_03.mdl",
	"models/wn7new/metropolice/female_04.mdl",
	"models/wn7new/metropolice/female_06.mdl",
	"models/wn7new/metropolice/female_05.mdl"
	};
	male = {
	"models/wn7new/metropolice/male_01.mdl",
	"models/wn7new/metropolice/male_02.mdl",
	"models/wn7new/metropolice/male_03.mdl",
	"models/wn7new/metropolice/male_04.mdl",
	"models/wn7new/metropolice/male_05.mdl",
	"models/wn7new/metropolice/male_06.mdl",
	"models/wn7new/metropolice/male_07.mdl",
	"models/wn7new/metropolice/male_08.mdl",
	"models/wn7new/metropolice/male_09.mdl",
	"models/wn7new/metropolice/male_10.mdl"
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
	return "C"..ix.config.Get("cityIndex", "13")..":RCT.UNION-"..Schema:ZeroNumber(math.random(1, 999), 3), true
end

function FACTION:OnCharacterCreated(client, character)
	character:CreateIDCard()

    local inventory = character:GetInventory()
	inventory:Add("pda", 1)
	inventory:Add("uniform_auxcp")
	inventory:Add("mas_aux")
	inventory:Add("handheld_radio")
	inventory:Add("flashlight")
	inventory:Add("smallbag")
	inventory:Add("largebag")

	character:SetSkill("guns", 5)
	character:SetSkill("speed", 10)

	character:SetData("equipBgClothes", true)
	character:SetRadioChannel("pc")
end

function FACTION:OnNameChanged(client, oldValue, value)
	if (oldValue == "") then return end

	if (Schema:IsCombineRank(value, "i1") and !Schema:IsCombineRank(oldValue, "i1")) then
		client:GetCharacter():SetClass(CLASS_CP_CPT)
	// !Schema:IsCombineRank(oldValue, "i1/i2")) was breaking all this shit. I don't know why, but without it - stuff below works fine.
	elseif Schema:IsCombineRank(value, "RL") then
		client:GetCharacter():SetClass(CLASS_CP_CMD)
	elseif Schema:IsCombineRank(value, "CmD") then 
		client:GetCharacter():SetClass(CLASS_CP_CMD)
	// ^^^^^
	elseif (Schema:IsCombineRank(oldValue, "RL") or Schema:IsCombineRank(oldValue, "CmD")) then
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
	if (Schema:IsCombineRank(client:Name(), "i1")) then
		client:GetCharacter():SetClass(CLASS_CP_CPT)
	elseif (Schema:IsCombineRank(client:Name(), "RL")) or (Schema:IsCombineRank(client:Name(), "CmD")) then
		client:GetCharacter():SetClass(CLASS_CP_CMD)
	else
		client:GetCharacter():SetClass(CLASS_CP)
	end
end

FACTION_CP = FACTION.index
