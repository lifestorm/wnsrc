--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

FACTION.name = "Bird"
FACTION.description = "A regular bird surviving on scrap and food."
FACTION.color = Color(128, 128, 128, 255)
FACTION.isDefault = false
FACTION.bAllowDatafile = false
FACTION.noAppearances = true
FACTION.noBackground = true
FACTION.noBeard = true
FACTION.noGender = true
FACTION.noGenetics = true
FACTION.ReadOptionDisabled = true
FACTION.noAttributes = true
FACTION.noTBC = true
FACTION.bDrinkUnfilteredWater = true
FACTION.canEatRaw = true

FACTION.factionImage = "materials/willardnetworks/faction_imgs/bird.png"
FACTION.selectImage = "materials/willardnetworks/faction_imgs/bird.png"
FACTION.inventoryImage = "materials/willardnetworks/tabmenu/inventory/backgrounds/sky.png"

FACTION.models = {
	"models/crow.mdl",
	"models/pigeon.mdl",
	"models/seagull.mdl"
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

function FACTION:OnSpawn(client)
	local character = client:GetCharacter()
	
	timer.Simple(0.1, function()
		local hull = Vector(10, 10, 10)

		client:SetHull(-Vector(hull.x / 2, hull.y / 2, 0), Vector(hull.x / 2, hull.y / 2, hull.z))
		client:SetHullDuck(-Vector(hull.x / 2, hull.y / 2, 0), Vector(hull.x / 2, hull.y / 2, hull.z))
		client:SetViewOffset(Vector(0,0,10))
		client:SetViewOffsetDucked(Vector(0,0,10))
		client:SetCurrentViewOffset(Vector(0,10,0))
		client:SetWalkSpeed(25)
		client:SetRunSpeed(50)
		client:SetMaxHealth(ix.config.Get("birdHealth", 2))
		client:SetHealth(ix.config.Get("birdHealth", 2))

		timer.Simple(1, function() -- Eh...
			client:StripWeapons()
		end)

		local birdData = character:GetData("babyBird", 0)

		if (birdData > os.time()) then
			client:SetModelScale(0.5)
		end
	end)
end

FACTION_BIRD = FACTION.index
