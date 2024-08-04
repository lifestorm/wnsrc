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
ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "VJ APC Base"
ENT.Author 			= "Comrade Communist"
ENT.Contact 		= ""
ENT.Purpose 		= "To make SNPCs."
ENT.Instructions 	= "Don't change anything."
ENT.Category		= "Comrade Bases"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.IsVJBaseSNPC_Apc = true -- Is it a VJ Base tank SNPC?
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, physobj)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsUpdate(physobj)
end
---------------------------------------------------------------------------------------------------------------------------------------------
/*if (CLIENT) then
  local Name = "rrrrrrrrrrrrrrrrrr"
  local LangName = "rrrrrrrrrrrrrrrrrr"
  language.Add(LangName, Name)
  killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
  language.Add("#"..LangName, Name)
  killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end*/

net.Receive("vj_tank_base_spawneffects", function()
	-- Add codes in the tank SNPC's shared file
end)

net.Receive("vj_tank_base_moveeffects", function()
	-- Add codes in the tank SNPC's shared file
end)
