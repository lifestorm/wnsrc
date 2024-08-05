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
ENT.PrintName		= "Citizen Terminal"
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
	[1] = {"ID BEKLENIYOR", Color( 255, 255, 180 ), true},
	[2] = {"KONTROL EDILIYOR", Color(255, 200, 0)},
	[3] = {"BILGI ALINIYOR", Color(0, 255, 0)},
	[4] = {"YENILENIYOR", Color(255, 200, 0)},
	[5] = {"KAPALI", Color(255, 0, 0), true},
	[6] = {"ID BEKLENIYOR", Color( 255, 255, 180 )},
	[7] = {"HAZIRLANIYOR", Color(0, 255, 0)},
	[8] = {"BILGI YOK", Color(0, 255, 0)}
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
end