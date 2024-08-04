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
DEFINE_BASECLASS("portals_in")

ENT.Base = "portals_in"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Portal (Two-way)"
ENT.Category = "Portals"

ENT.Spawnable = true

ENT.BaseColor = Color(127, 255, 255)

ENT.ExitType = "portals_twoway"
