--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

include ("shared.lua")

SWEP.MagLifeTime = 15

function SWEP:DropMag()

	if not self.MagModel then return end

	local mag = ents.CreateClientProp()

	mag:SetModel(self.MagModel)
	mag:SetMaterial(self:GetMaterial())

	local pos, ang = self:GetPos(), self:GetAngles()

	if self:IsFirstPerson() and self:VMIV() then
		local vm = self.OwnerViewModel
		ang = vm:GetAngles()
		pos = vm:GetPos() - ang:Up() * 8
	end

	mag:SetPos(pos)
	mag:SetAngles(ang)

	mag:PhysicsInit(SOLID_VPHYSICS)
	mag:PhysWake()
		
	mag:SetMoveType(MOVETYPE_VPHYSICS) -- we call it AFTER physics init

	mag:Spawn()

	SafeRemoveEntityDelayed(mag, self.MagLifeTime)
		
end