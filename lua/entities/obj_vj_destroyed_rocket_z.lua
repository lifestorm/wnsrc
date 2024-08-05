--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.Base = "obj_vj_projectile_base"
ENT.Type = "anim"
ENT.PrintName = "Destroyed Missile"
ENT.Author = "Zippy"
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()


end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(true)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------