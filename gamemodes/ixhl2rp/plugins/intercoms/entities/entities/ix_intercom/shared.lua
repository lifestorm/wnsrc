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
ENT.PrintName = "Faction Intercom"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Channel")
end
