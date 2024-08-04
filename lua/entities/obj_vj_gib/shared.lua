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

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName		= "Gib Base"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Gibs for SNPCs"
ENT.Category		= "VJ Base"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.IsVJBase_Gib = true
ENT.IsVJBaseCorpse = true

if CLIENT then
	function ENT:Draw() self:DrawModel() end
end