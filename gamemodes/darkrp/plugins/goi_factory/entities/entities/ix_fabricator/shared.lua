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
ENT.PrintName = "Fabricator"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true
ENT.AutomaticFrameAdvance = true

ENT.bigSteamJet = {
	vec = Vector(1.659318, 56.163685, 33.053894),
	ang = Angle(0, 90, 0)
}
ENT.smallSteamPipes = {
	{vec = Vector(20.475733, 34.197407, 12.701706), ang = Angle(-60, -75, 0)},
	{vec = Vector(20.420990, 28.903364, 12.851990), ang = Angle(-60, -75, 0)},
	{vec = Vector(20.008125, -16.373440, 23.055595), ang = Angle(-90, -90, 0)}
}
ENT.dispensePos = Vector(12.057754, -13.228306, 39.473038)

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "UsedBy")
end