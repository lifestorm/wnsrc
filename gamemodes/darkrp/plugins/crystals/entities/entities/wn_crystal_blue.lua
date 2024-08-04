--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

DEFINE_BASECLASS("crystal_base")

ENT.Type = "anim"
ENT.Base = "crystal_base"
ENT.Author = "gb"
ENT.PrintName = "Blue Crystal"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Crystals"
ENT.LootCrystal = "blue_crystal"
ENT.loopSound = "ambient/energy/electric_loop.wav"

if (SERVER) then
	function ENT:OnInitialize()
		self:SetModel("models/props_abandoned/crystals_fixed/crystal_damaged/crystal_cluster_huge_damaged_a.mdl")
		self:SetSkin(6)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetSolid(SOLID_VPHYSICS)
	
		local physicsObject = self:GetPhysicsObject()
		self:EmitSound(self.loopSound, 60, 100)
		
		if (IsValid(physicsObject)) then
			physicsObject:Wake()
			physicsObject:EnableMotion(false)
		end
		
		local StartLight1 = ents.Create("light_dynamic")
		StartLight1:SetKeyValue("brightness", "3")
		StartLight1:SetKeyValue("distance", "150")
		StartLight1:SetKeyValue("style", 5)
		StartLight1:SetLocalPos(self:GetPos() + self:GetUp() * 30)
		StartLight1:SetLocalAngles(self:GetAngles())
		StartLight1:Fire("Color", "0 0 176")
		StartLight1:SetParent(self)
		StartLight1:Spawn()
		StartLight1:Activate()
		StartLight1:SetParent(self)
		StartLight1:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(StartLight1)
		
		timer.Create("BeamRingEffectTimer" .. self:EntIndex(), 2, 0, function()
			if not IsValid(self) then return end
			self:CreateBeamRingEffect()
			self:CreateTeslaEffect()
		end)
	end

	function ENT:CreateBeamRingEffect()
		effects.BeamRingPoint(self:GetPos() + Vector(0, 0, 10), 1, 0, 400, 10, 0, Color(104, 100, 176))
	end

	function ENT:CreateTeslaEffect()
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() + Vector(0, 0, 10)) 
		effectdata:SetEntity(self)
		util.Effect("tesla_effect", effectdata)

		for i = 1, 10 do
			local tesla = ents.Create("point_tesla")
			if not IsValid(tesla) then return end
		
			tesla:SetPos(self:GetPos() + VectorRand() * 50)
			tesla:SetKeyValue("m_SoundName", "") 
			tesla:SetKeyValue("texture", "sprites/laserbeam.spr")
			tesla:SetKeyValue("m_Color", "104 160 176")
			tesla:SetKeyValue("m_flRadius", "100")
			tesla:SetKeyValue("beamcount_min", "5")
			tesla:SetKeyValue("beamcount_max", "8")
			tesla:SetKeyValue("thick_min", "2")
			tesla:SetKeyValue("thick_max", "4")
			tesla:SetKeyValue("lifetime_min", "0.1")
			tesla:SetKeyValue("lifetime_max", "0.2")
			tesla:SetKeyValue("interval_min", "0.05")
			tesla:SetKeyValue("interval_max", "0.1")
			tesla:Spawn()
			tesla:Activate()
			self:EmitSound("ambient/energy/zap"..math.random(1, 9)..".wav")
			tesla:Fire("DoSpark", "", 0)
		end
	end

	function ENT:TriggerReaction(damageInfo)
		local attacker = damageInfo:GetAttacker()
		if not IsValid(attacker) then return end
	
		local hitPos = damageInfo:GetDamagePosition()
	
		self:EmitSound("physics/glass/glass_impact_bullet1.wav")

		local tesla = ents.Create("point_tesla")
		if not IsValid(tesla) then return end
		local damageInfo = DamageInfo()

		damageInfo:SetDamage(5)
		damageInfo:SetDamageType(DMG_SHOCK)
		damageInfo:SetAttacker(attacker)
		damageInfo:SetInflictor(attacker)
		attacker:TakeDamageInfo(damageInfo)

		tesla:SetPos(hitPos)
		tesla:SetKeyValue("m_SoundName", "") 
		tesla:SetKeyValue("texture", "sprites/laserbeam.spr")
		tesla:SetKeyValue("m_Color", "104 100 176")
		tesla:SetKeyValue("m_flRadius", "100")
		tesla:SetKeyValue("beamcount_min", "5")
		tesla:SetKeyValue("beamcount_max", "8")
		tesla:SetKeyValue("thick_min", "2")
		tesla:SetKeyValue("thick_max", "4")
		tesla:SetKeyValue("lifetime_min", "0.1")
		tesla:SetKeyValue("lifetime_max", "0.2")
		tesla:SetKeyValue("interval_min", "0.05")
		tesla:SetKeyValue("interval_max", "0.1")
		tesla:Spawn()
		tesla:Activate()
		self:EmitSound("ambient/energy/zap"..math.random(1, 9)..".wav")
		tesla:Fire("DoSpark", "", 0)


		timer.Simple(0.5, function()
			if IsValid(tesla) then
				tesla:Remove()
			end
			if IsValid(sound) then
				sound:Remove()
			end
		end)
	end 

	function ENT:OnRemove()
		self:StopSound(self.loopSound)
		timer.Remove("BeamRingEffectTimer" .. self:EntIndex())
	end
	
	function ENT:OnDestroyed(singularity) 
		self:Dissolve(1, 100)
		
		timer.Simple(2, function()
			if not IsValid(self) then return end
	
			self:EmitSound(table.Random({"vj_hlr/fx/bustglass1.wav","vj_hlr/fx/bustglass2.wav"}), 100)
			util.ScreenShake(self:GetPos(), 100, 150, 5, 1250, true)
			
			local data = EffectData()
			data:SetOrigin(self:GetPos())
			util.Effect("cball_explode", data)
			
			effects.BeamRingPoint(self:GetPos(), 0.2, 12, 1024, 64, 0, Color(104, 100, 176, 32), {
				speed = 0,
				spread = 0,
				delay = 0,
				framerate = 2,
				material = "sprites/lgtning.vmt"
			})
		
			effects.BeamRingPoint(self:GetPos(), 0.5, 12, 1024, 64, 0, Color(104, 100, 176, 64), {
				speed = 0,
				spread = 0,
				delay = 0,
				framerate = 2,
				material = "sprites/lgtning.vmt"
			})
	
			if singularity or ix.config.Get("crystalSingularity", false) then  
				local singularityPos = self:GetPos() + Vector(0, 0, 50)
				local singularityEnt = ents.Create("wn_singularity_blue")
				
				if IsValid(singularityEnt) then
					singularityEnt:SetPos(singularityPos)
					singularityEnt:Spawn()
				end
			end 
	
			self:Remove()
		end)
	end	 
end
