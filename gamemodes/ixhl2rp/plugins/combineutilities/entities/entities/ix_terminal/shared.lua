--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName		= "Terminal Obywatelski"
ENT.Author			= "Fruity"
ENT.Contact			= "Willard Networks"
ENT.Purpose			= "View datafile info and more via entity."
ENT.Instructions	= "Press E"
ENT.Category = "HL2 RP"

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true
ENT.model = "models/willardnetworks/props/civilterminal7.mdl"

ENT.canMalfunction = true

ENT.Displays = {
	[1] = {"OCZEKIWANIE NA CID", Color( 255, 255, 180 ), true},
	[2] = {"WERYFIKOWANIE", Color(255, 200, 0)},
	[3] = {"POBIERANIE INFORMACJI", Color(0, 255, 0)},
	[4] = {"PRZEŁADOWYWANIE", Color(255, 200, 0)},
	[5] = {"OFFLINE", Color(255, 0, 0), true},
	[6] = {"OCZEKIWANIE NA CID", Color( 255, 255, 180 )},
	[7] = {"PRZYGOTOWYWANIE", Color(0, 255, 0)},
	[8] = {"BRAK INFORMACJI", Color(0, 255, 0)}
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
end