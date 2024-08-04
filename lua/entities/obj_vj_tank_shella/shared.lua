--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Combine APC"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"

if (CLIENT) then
	local Name = "Combine APC"
	local LangName = "obj_vj_tank_shella"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))

	function ENT:Think()
		if self:IsValid() then
			self.Emitter = ParticleEmitter(self:GetPos())
			self.SmokeEffect1 = self.Emitter:Add("particles/flamelet2",self:GetPos() +self:GetForward()*-7)
			self.SmokeEffect1:SetVelocity(self:GetForward() *math.Rand(0, -50) +Vector(math.Rand(5, -5), math.Rand(5, -5), math.Rand(5, -5)) +self:GetVelocity())
			self.SmokeEffect1:SetDieTime(0.2)
			self.SmokeEffect1:SetStartAlpha(100)
			self.SmokeEffect1:SetEndAlpha(0)
			self.SmokeEffect1:SetStartSize(10)
			self.SmokeEffect1:SetEndSize(1)
			self.SmokeEffect1:SetRoll(math.Rand(-0.2,0.2))
			self.SmokeEffect1:SetAirResistance(200)
			self.Emitter:Finish()
		end
	end
end
