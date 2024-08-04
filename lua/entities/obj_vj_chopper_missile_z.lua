--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_tank_shell"
ENT.PrintName		= "Homing Missile"
ENT.Author 			= "Zippy"
ENT.Spawnable = false

ENT.RadiusDamage = 32
ENT.RadiusDamageRadius = 130

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

	self:EmitSound("weapons/rpg/rocketfire1.wav",105,math.random(85, 115))
	ParticleEffectAttach("vj_rpg1_fulltrail", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	timer.Simple(0.2, function() if IsValid(self) then

		local timer_name = "vj_homingtimer_z" .. self:EntIndex()
		timer.Create(timer_name, 0.05, 0, function()
			if IsValid(self) && self.Target && IsValid(self.Target) then

				local own = self:GetOwner()
				local enemyvisible = false
				if IsValid(own) && IsValid(own:GetEnemy()) then
					enemyvisible = own:Visible(own:GetEnemy())
				end

				if enemyvisible then
					local idealang = ( self.Target:GetPos()+self.Target:OBBCenter() - self:GetPos() ):Angle()
					local ang = LerpAngle(0.22,self:GetAngles(),idealang)
					self:SetAngles(ang)
					self:GetPhysicsObject():SetVelocity( self:GetForward()*self.Speed )
				end

				local targetdist = self:GetPos():Distance(self.Target:GetPos())
				if targetdist < 200 then
					timer.Remove(timer_name)
				end

			else
				timer.Remove(timer_name)
			end
		end)

	end end)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:GetPhysicsObject():GetAngleVelocity() != Vector(0,0,0) then
		self:DeathEffects( util.TraceLine({start=self:GetPos(),endpos=self:GetPos()}) )
		self:Remove()
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------