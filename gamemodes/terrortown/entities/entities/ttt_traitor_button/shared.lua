--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--- Special button only for traitors and usable from range

ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SetupDataTables()
   self:NetworkVar("Float", 0, "Delay")
   self:NetworkVar("Float", 1, "NextUseTime")
   self:NetworkVar("Bool", 0, "Locked")
   self:NetworkVar("String", 0, "Description")
   self:NetworkVar("Int", 0, "UsableRange", {KeyName = "UsableRange"})
end

function ENT:IsUsable()
   return (not self:GetLocked()) and self:GetNextUseTime() < CurTime()
end
