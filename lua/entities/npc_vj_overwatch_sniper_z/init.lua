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

ENT.StartHealth = 80
ENT.WeaponBackAway_Distance = 300 -- When the enemy is this close, the SNPC will back away | 0 = Never back away
ENT.MoveRandomlyWhenShooting = false -- Should it move randomly when shooting?
ENT.CanCrouchOnWeaponAttackChance = 1 -- How much chance of crouching? | 1 = Crouch every time