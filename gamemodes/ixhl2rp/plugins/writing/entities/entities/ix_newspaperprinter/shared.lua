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
ENT.Author = "Fruity"
ENT.PrintName = "Newspaper Printer"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true
ENT.cracked = false

ENT.Displays = {
	[1] = {"OCZEKIWANIE", Color( 255, 255, 180 ), true},
	[2] = {"POBIERANIE INFORMACJI", Color(0, 255, 0)},
	[3] = {"BRAK PAPIERU I TUSZU", Color(255, 0, 0)},
	[4] = {"BRAK PAPIERU", Color(255, 0, 0)},
	[5] = {"BRAK TUSZU", Color(255, 0, 0)},
	[6] = {"PRZEŁADOWYWANIE", Color(255, 200, 0)},
	[7] = {"OCZEKIWANIE", Color(255, 255, 180), true},
	[8] = {"DRUKOWANIE", Color( 0, 255, 0 ), true},
	[9] = {"BRAK ZEZWOLENIA", Color(255, 0, 0)},
	[10] = {"BRAK WYMOGU CID", Color(0, 255, 0)},
	[11] = {"PAPIER ZAPEŁNIONY", Color(0, 255, 0)},
	[12] = {"TUSZ ZAPEŁNIONY", Color(0, 255, 0)},
	[13] = {"NIEPRAWIDŁOWY CID", Color(255, 0, 0)}
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
	self:NetworkVar("Float", 0, "Ink")
	self:NetworkVar("Float", 1, "Paper")
end