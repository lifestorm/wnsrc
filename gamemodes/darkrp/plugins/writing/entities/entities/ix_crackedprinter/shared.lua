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
ENT.PrintName = "Cracked Newspaper Printer"
ENT.Base = "ix_newspaperprinter"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true
ENT.cracked = true

ENT.Displays = {
	[1] = {"W41T1NG F0R USER", Color( 255, 255, 180 ), true},
	[2] = {"RETR1EV1NG 1NF0", Color(0, 255, 0)},
	[3] = {"N0 P4PER/1NK", Color(255, 0, 0)},
	[4] = {"N0 P4PER", Color(255, 0, 0)},
	[5] = {"N0 1NK", Color(255, 0, 0)},
	[6] = {"REL04D1NG", Color(255, 200, 0)},
	[7] = {"W41T1NG", Color(255, 255, 180), true},
	[8] = {"PR1NT1NG", Color( 0, 255, 0 ), true},
	[9] = {"N0 PERM1T", Color(255, 0, 0)},
	[10] = {"N0 C1D REQU1RED", Color(0, 255, 0)},
	[11] = {"P4PER M4XED 0UT", Color(0, 255, 0)},
	[12] = {"1NK M4XED 0UT", Color(0, 255, 0)},
	[13] = {"1NV4L1D C1D", Color(255, 0, 0)}
}
