--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


DEFINE_BASECLASS("base_gmodentity")

ENT.Type = "anim"
ENT.Author = "Aspect™"
ENT.PrintName = "Infestation Prop"
ENT.Category = "HL2 RP"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Harvested")
	self:NetworkVar("String", 1, "Infestation")
	self:NetworkVar("String", 2, "Type")
	self:NetworkVar("Bool", 3, "Core")
	self:NetworkVar("Bool", 4, "Sprayed")
end
