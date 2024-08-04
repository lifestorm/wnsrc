--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.StartPos = self:GetTracerShootPos(self.Position,self.WeaponEnt,self.Attachment)
	self.EndPos = data:GetOrigin()
	util.ParticleTracerEx("cmb_tracer",self.StartPos,self.EndPos,1,0,-1)
end
function EFFECT:Render()
	return false
end