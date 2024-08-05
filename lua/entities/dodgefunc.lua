--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.IsDodging = false
ENT.NextDodgeTime = 0

function ENT:DoDodge(dist, chance, dodgeleft, dodgeright, dodgeback, dodgeforward)
	if !self.Dead && !self.MeleeAttacking && !self.ComboAttacking then
		if self.VJ_IsBeingControlled then
			self:StopAttacks(true)
			if self.VJ_TheController:KeyDown(IN_MOVELEFT) && self.VJ_TheController:KeyDown(IN_JUMP) && CurTime() > self.NextDodgeTime then
				self.IsDodging = true
				self:VJ_ACT_PLAYACTIVITY(dodgeleft,true,false,true) -- Left dodge anim
				self.NextDodgeTime = CurTime() + VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence()))+0.2
				timer.Simple(VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence())), function() self.IsDodging = false end)
			
			elseif self.VJ_TheController:KeyDown(IN_MOVERIGHT) && self.VJ_TheController:KeyDown(IN_JUMP) && CurTime() > self.NextDodgeTime then
				self.IsDodging = true
				self:VJ_ACT_PLAYACTIVITY(dodgeright,true,false,true) -- Left dodge anim
				self.NextDodgeTime = CurTime() + VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence()))+0.2
				timer.Simple(VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence())), function() self.IsDodging = false end)
				
			elseif self.VJ_TheController:KeyDown(IN_BACK) && self.VJ_TheController:KeyDown(IN_JUMP) && CurTime() > self.NextDodgeTime then
				self.IsDodging = true
				self:VJ_ACT_PLAYACTIVITY(dodgeback,true,false,true) -- Left dodge anim
				self.NextDodgeTime = CurTime() + VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence()))+0.2
				timer.Simple(VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence())), function() self.IsDodging = false end)
			
			elseif self.VJ_TheController:KeyDown(IN_FORWARD) && self.VJ_TheController:KeyDown(IN_JUMP) && CurTime() > self.NextDodgeTime then
				self.IsDodging = true
				self:VJ_ACT_PLAYACTIVITY(dodgeforward,true,false,true) -- Left dodge anim
				self.NextDodgeTime = CurTime() + VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence()))+0.2
				timer.Simple(VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence())), function() self.IsDodging = false end)
			end
		end
		
		if self:GetEnemy() != nil && !self.VJ_IsBeingControlled && CurTime() > self.NextDodgeTime then
			local EnemyDistance = self:VJ_GetNearestPointToEntityDistance(self:GetEnemy(),self:GetPos():Distance(self:GetEnemy():GetPos()))
			if EnemyDistance <= dist && math.random(1,chance) == 1 && (self:CanDodge("normal") or self:CanDodge("player")) then -- Random movement
				self:StopAttacks(true)
				self.IsDodging = true
				local dodge_close = math.random(1, 3)
				if dodge_close == 1 then
					self:VJ_ACT_PLAYACTIVITY(dodgeleft,true,false,true) -- Left dodge anim

				elseif dodge_close == 2 then
					self:VJ_ACT_PLAYACTIVITY(dodgeright,true,false,true) -- Right dodge anim

				elseif dodge_close == 3 then
					self:VJ_ACT_PLAYACTIVITY(dodgeback,true,false,true) -- Right dodge anim

				end
				self.NextDodgeTime = CurTime() + VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence()))+0.2
				timer.Simple(VJ_GetSequenceDuration(self,self:GetSequenceName(self:GetSequence())), function() self.IsDodging = false end)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanDodge(dodgetype)
	if dodgetype == "normal" then
		if !self.RangeAttacking && !self.MeleeAttacking && self:GetEnemy():IsNPC()
		&& ((self:GetEnemy().MeleeAttacking && self:GetEnemy().MeleeAttacking) 
		or (self:GetEnemy().IsAttacking && self:GetEnemy().IsAttacking)) then
			return true
		else
			return false
		end
	elseif dodgetype == "player" then
		if !self.RangeAttacking && !self.MeleeAttacking && self:GetEnemy():IsPlayer() 
		&& self:GetEnemy():GetEyeTrace().Entity == self && self:GetEnemy():IsPlayer() && self:GetEnemy():GetActiveWeapon() != nil 
		&& self.AcceptableWeaponsTbl[self:GetEnemy():GetActiveWeapon():GetClass()]
		&& (self:GetEnemy():KeyPressed(IN_ATTACK) or self:GetEnemy():KeyPressed(IN_ATTACK2) 
		or self:GetEnemy():KeyReleased(IN_ATTACK) or self:GetEnemy():KeyReleased(IN_ATTACK2) 
		or self:GetEnemy():KeyDown(IN_ATTACK) or self:GetEnemy():KeyDown(IN_ATTACK2)) then
			return true
		else
			return false
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FindSeq(seq)
	return self:GetSequenceActivity(self:LookupSequence(seq))
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.AcceptableWeaponsTbl = {
	["gmod_camera"]=true,
	["gmod_tool"]=true,
	["weapon_physgun"]=true,
	["weapon_physcannon"]=true
}