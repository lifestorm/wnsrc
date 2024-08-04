--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/Combine_Super_Soldier.mdl"}
ENT.StartHealth = 100
ENT.Soldier_WeaponSpread = 1

ENT.ItemDropsOnDeathChance = 1
ENT.ItemDropsOnDeath_EntityList = {
"item_battery",
"item_healthvial",
"weapon_frag",
"item_ammo_ar2_altfire",
}