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
ENT.PrintName = "Data-Disc Scanner"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

ENT.scanTimer = 5
ENT.linePoses = {
	Vector(-0.591944, 2.154315, 50),
	Vector(0.672625, -0.008970, 50),
	Vector(-0.630802, -2.203331, 50),
	Vector(-1.493779, -0.068308, 50)
}
function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "UsedBy")
end