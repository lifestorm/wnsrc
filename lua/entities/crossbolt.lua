--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if CLIENT then
killicon.Add( "Crossbolt", "hud/crossbolt", Color( 255, 255, 255, 255 ) )

end	

AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
	self:DrawModel()
	
    local dlight = DynamicLight(self:EntIndex())	
	

end

if CLIENT then return end

function ENT:Initialize()

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetPhysicsAttacker(self.Owner)
	
	timer.Create("effe35dfs" .. self:EntIndex(), 0.01, 0, function()
		if not IsValid(self) then timer.Stop("effedfs" .. self:EntIndex()) return end
		
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)

	end)
end

function ENT:Think()
	if self:WaterLevel() == 3 then self:Remove() end
end

function ENT:Damage(data, physobj)

	local ind = math.random(1,100)
	
	
	local models = {


	}

	local dmgtyp = {

			DMG_NEVERGIB,
			DMG_RADIATION

	}
	
	local dmg = DamageInfo()
	
	local owner = self:GetOwner()
	if not IsValid(owner) then owner = self end
	
	dmg:SetAttacker(owner)
	dmg:SetInflictor(self)
	

	
	if ind >= 990 and ind <= 9900 then 	
		dmg:SetDamage(math.random(60,150))
		dmg:SetDamageType(dmgtyp[math.random(1,#dmgtyp)])
		data.HitEntity:TakeDamageInfo(dmg)
	end
	
	if ind >= 990 and ind <= 9100 then 
		self.Owner:TakeDamage(self.Owner:Health(), self.Owner, self)
	end
	
	if ind >= 990 and ind <= 9100 then 
		data.HitEntity:TakeDamage(data.HitEntity:Health(), self.Owner, self)
	end
	
	if ind >= 990 and ind <= 9100 then
		if data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() then
	
			local damg = math.random(30,60)
			if data.HitEntity:Health() < damg then damg = data.HitEntity:Health() end
	
			dmg:SetDamage(damg)
			dmg:SetDamageType(dmgtyp[math.random(1,#dmgtyp)])
			data.HitEntity:TakeDamageInfo(dmg)

		end
	end
	
	if ind >= 990 and ind <= 9100 then
		data.HitEntity:SetHealth(data.HitEntity:GetMaxHealth())
	end
	
	if ind >= 990 and ind <= 9100 then
		if data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() then

			data.HitEntity:DrawShadow(false)
		end
		
		if data.HitEntity:IsPlayer() then 		
			timer.Create("shsf"..self:EntIndex(), 30, 1, function()
				if not data.HitEntity or not IsValid(data.HitEntity) then return end
				data.HitEntity:SetMaterial("bom")
				data.HitEntity:DrawShadow(true)				
			end)
		end
	end
	
	if ind >= 990 and ind <= 9100 then
		if data.HitEntity:IsNPC() then
			data.HitEntity:Remove()
				
			local npc21 = ents.Create(npc2)						
			npc21:SetPos(data.HitPos + Vector(0,0,100))
			npc21:Spawn()			
			npc21:Activate()
		end
		
		if data.HitEntity:IsPlayer() then
			data.HitEntity:KillSilent()	
		
			local npc21 = ents.Create(npc2)
			npc21:SetPos(data.HitPos + Vector(0,0,100))
			npc21:Spawn()			
			npc21:Activate()
		end
	end
	
	if ind >= 50 and ind <= 100 then	
	
		if data.HitEntity:IsNPC() then
			data.HitEntity:Remove()
		
			local prop13 = ents.Create("prop_ragdoll")


			prop13:SetRenderMode(RENDERMODE_NORMAL)
		end
		

	end
	
	if ind >= 9990 and ind <= 9100 then
		local explode = ents.Create("env_explosion")
		explode:SetPos(data.HitPos)
		explode:Spawn()
		explode:Fire( "Explode", 0, 0 )
		explode:SetKeyValue( "iMagnitude", "0" )
		
		util.BlastDamage(self, owner, data.HitPos, 200, 200)
	end
	
	if ind >= 910 and ind <= 1000 then
		local bone = ents.Create(bone)

	end
end

function ENT:PhysicsCollide(data, phys)
	
	local Ent = data.HitEntity
	if !(Ent:IsValid() or Ent:IsWorld()) then return end
	
	if Ent:IsWorld() then
			util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
				self:SetPos(data.HitPos - data.HitNormal)
				self:SetAngles(self.Entity:GetAngles())
				self:GetPhysicsObject():EnableMotion(false)

			self:Disable()


	elseif Ent.Health then
		if not(Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then 
			util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
		end
		local plydmg = math.random(15,18)
		local entdmg = math.random(30,46)
		if Ent:IsPlayer() then 
		Ent:TakeDamage(plydmg, self:GetOwner(), self.Entity)
		end
		if Ent:IsNPC() then
		Ent:TakeDamage(entdmg, self:GetOwner(), self.Entity)
		end
		if (Ent:IsPlayer() or Ent:IsNPC()) then 
							local blood = Ent:GetBloodColor()	
						   local fleshimpact		= EffectData()
								fleshimpact:SetEntity(self.Weapon)
								fleshimpact:SetOrigin(data.HitPos)
								fleshimpact:SetNormal(data.HitPos)
								if blood >= 0 then
								fleshimpact:SetColor(blood)
								util.Effect("BloodImpact", fleshimpact)	
                                 end								
			   end
				self:EmitSound(Sound("Weapon_Crossbow.BoltHitBody"))
			self:Remove()
		end
		
	end