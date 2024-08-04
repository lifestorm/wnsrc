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
	[1] = {"WAITING FOR USER", Color( 255, 255, 180 ), true},
	[2] = {"RETRIEVING INFO", Color(0, 255, 0)},
	[3] = {"NO PAPER/INK", Color(255, 0, 0)},
	[4] = {"NO PAPER", Color(255, 0, 0)},
	[5] = {"NO INK", Color(255, 0, 0)},
	[6] = {"RELOADING", Color(255, 200, 0)},
	[7] = {"WAITING", Color(255, 255, 180), true},
	[8] = {"PRINTING", Color( 0, 255, 0 ), true},
	[9] = {"NO PERMIT", Color(255, 0, 0)},
	[10] = {"NO CID REQUIRED", Color(0, 255, 0)},
	[11] = {"PAPER MAXED OUT", Color(0, 255, 0)},
	[12] = {"INK MAXED OUT", Color(0, 255, 0)},
	[13] = {"INVALID CID", Color(255, 0, 0)}
}

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Display")
	self:NetworkVar("Float", 0, "Ink")
	self:NetworkVar("Float", 1, "Paper")
end