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
ENT.PrintName = "Infestation Control Tank"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "ChemicalVolume")
	self:NetworkVar("String", 1, "ChemicalType")
	self:NetworkVar("Bool", 2, "HoseAttached")
	self:NetworkVar("Bool", 3, "ApplicatorAttached")
	self:NetworkVar("Bool", 4, "HoseConnected")
end

function ENT:GetEntityMenu(client)
	local options = {}
	
	options["Detach Hose"] = true
	options["Detach Applicator"] = true
	options["Pack Up"] = true

	return options
end
