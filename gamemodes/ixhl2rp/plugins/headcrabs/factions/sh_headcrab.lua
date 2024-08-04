--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

FACTION.name = "Headcrab"
FACTION.description = "A creature that laches onto peoples heads and controls them."
FACTION.color = Color(255,82,63)
FACTION.runSpeed = 70
FACTION.walkSpeed = 30

FACTION.isDefault = false
FACTION.DisableInv = true
FACTION.bAllowDatafile = false
FACTION.noAppearances = true
FACTION.noBackground = true
FACTION.noBeard = true
FACTION.noGender = true
FACTION.noNeeds = true
FACTION.noGenetics = true
FACTION.ReadOptionDisabled = true
FACTION.noAttributes = true
FACTION.noGas = true
FACTION.noTBC = true
FACTION.humanVoices = false
FACTION.allLanguages = true
FACTION.canEatRaw = true
FACTION.bDrinkUnfilteredWater = true

FACTION.factionImage = "willardnetworks/faction_imgs/xen.png"
FACTION.selectImage = "willardnetworks/faction_imgs/xen.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/xen.png"

FACTION.models = {
	"models/headcrabclassic.mdl",
	"models/headcrab.mdl",
    "models/headcrabblack.mdl"
}

FACTION.npcRelations = {
	["npc_zombie"] = D_LI,
	["npc_zombie_torso"] = D_LI,
	["npc_zombine"] = D_LI,
	["npc_headcrab_fast"] = D_LI,
	["npc_fastzombie"] = D_LI,
	["npc_fastzombie_torso"] = D_LI,
	["npc_headcrab"] = D_LI,
	["npc_headcrab_black"] = D_LI,
	["npc_poisonzombie"] = D_LI,
}

-- function FACTION:OnSpawn(client)
-- 	timer.Simple(0.1, function()
-- 		client:StripWeapons()
-- 	end)
-- end

FACTION_HEADCRAB = FACTION.index
