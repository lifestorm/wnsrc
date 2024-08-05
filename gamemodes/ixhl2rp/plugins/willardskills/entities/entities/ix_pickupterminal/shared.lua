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
ENT.PrintName		= "Pickup Terminal"
ENT.Author			= "Fruity"
ENT.Contact			= "Willard Networks"
ENT.Purpose			= "Pickup items bought with certain skills."
ENT.Instructions	= "Press E"
ENT.Category = "HL2 RP"

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

ENT.canMalfunction = true

ENT.Displays = {
	[1] = {"WAITING FOR CID", Color( 255, 255, 180 ), true},
	[2] = {"CHECKING", Color(255, 200, 0)},
	[3] = {"DISPENSING", Color(0, 255, 0)},
	[4] = {"RELOADING", Color(255, 200, 0)},
	[5] = {"OFFLINE", Color(255, 0, 0), true},
	[6] = {"WAITING FOR CID", Color( 255, 255, 180 )},
	[7] = {"PREPARING", Color(0, 255, 0)},
	[8] = {"NO PURCHASED ITEMS", Color(0, 255, 0)},
	[9] = {"INVALID CID", Color(255, 0, 0)},
	[10] = {"ITEM ADDED", Color(0, 255, 0)},
	[11] = {"ITEM REJECTED", Color(255, 0, 0), true},
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
end