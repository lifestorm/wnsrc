--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Weapon Holsters"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Show holstered weapons on the player's model."

ix.config.Add("ShowHolsteredWeapons", true, "Enable the showing of holstered weapons on all players.", nil, {
	category = "Characters"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Weapon Holsters",
	MinAccess = "superadmin"
})


--ix.util.Include("sv_data.lua")
--ix.util.Include("sv_plugin.lua")

PLUGIN.HL2Weps = {
	["weapon_pistol"] = "Pistol",
	["weapon_357"] = "357",
	["weapon_frag"] = "Frag Grenade",
	["weapon_slam"] = "SLAM",
	["weapon_crowbar"] = "Crowbar",
	["weapon_stunstick"] = "Stunstick",
	["weapon_shotgun"] = "Shotgun",
	["weapon_rpg"] = "RPG Launcher",
	["weapon_smg1"] = "SMG",
	["weapon_ar2"] = "AR2",
	["weapon_crossbow"] = "Crossbow",
	["weapon_physcannon"] = "Gravity Gun",
	["weapon_physgun"] = "Physics Gun"
}
