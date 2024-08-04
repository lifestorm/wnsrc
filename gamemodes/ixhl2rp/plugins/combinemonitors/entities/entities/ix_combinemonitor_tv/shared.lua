--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ENT.Type = "anim"
ENT.Base = "ix_combinemonitor"

ENT.PrintName		= "Combine Monitor TV"
ENT.Author			= "Fruity"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= "Fruitybooty"

ENT.tv = true

ENT.Category = "HL2 RP"

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 1, "Enabled")
end