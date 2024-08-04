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
ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "VJ Projectile Base"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "To make projectiles."
ENT.Instructions 	= "Don't change anything."
ENT.Category		= "VJ Base"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

if CLIENT then
	function ENT:Draw() self:DrawModel() end
end