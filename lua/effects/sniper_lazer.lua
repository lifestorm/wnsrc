--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function EFFECT:Init(effectdata)
	self.wep = effectdata:GetEntity()
	self.ply = self.wep.Owner
end

function EFFECT:Think()
	if !IsValid(self.wep) or !IsValid(self.ply) then return false end
	self.tr=self.ply:GetEyeTrace()
	self:SetPos(self.ply:GetShootPos())
	self:SetRenderBoundsWS(self:GetPos(),self.tr.HitPos)
	return self.wep:GetScoped()
end
 
local lazerMat = Material("cable/physbeam")
local dotMat = Material("sprites/light_glow02_add")
function EFFECT:Render()
	if !self.tr then return end
	render.SetMaterial(lazerMat)

	//render.SetColorModulation( number r, number g, number b )
	render.DrawBeam(self:GetPos(),self.tr.HitPos,1,0,self:GetPos():Distance(self.tr.HitPos)/300,Color(255,0,0))

	cam.Start3D(EyePos(),EyeAngles())
		render.SetMaterial(dotMat)
		render.DrawSprite(self.tr.HitPos, 8, 8, Color(130,190,240)) //color
	cam.End3D()
end