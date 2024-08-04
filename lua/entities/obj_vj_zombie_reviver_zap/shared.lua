--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Base 			= "obj_vj_projectile_base"
ENT.Type 			= "anim"
ENT.PrintName 		= "Zombie Reviver Zap"
ENT.Author 			= "Fegelein the Antic Master"
ENT.Contact 		= ""
ENT.Purpose 		= ""
ENT.Instructions 	= ""
ENT.Category		= "Half-Life: Alyx"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

if CLIENT then
	function ENT:Draw() self:DrawModel() end
end