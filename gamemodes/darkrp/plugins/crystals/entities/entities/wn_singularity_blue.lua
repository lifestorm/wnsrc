--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Author = "gb"
ENT.PrintName = "Blue Singularity"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Crystals"
ENT.LootCrystal = "blue_crystal"
ENT.loopSound = "ambient/energy/force_field_loop1.wav"

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
		self:SetNoDraw(true)
		self:DrawShadow(false)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		ParticleEffectAttach("[8]magic_portal", 1, self, 1)
		self:EmitSound(self.loopSound)
		
		local physicsObject = self:GetPhysicsObject()
		if (IsValid(physicsObject)) then
			physicsObject:Wake()
			physicsObject:EnableMotion(false)
		end
		
		local StartLight1 = ents.Create("light_dynamic")
		StartLight1:SetKeyValue("brightness", "5")
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
		
		timer.Create("BeamRingEffectTimer" .. self:EntIndex(), 1, 0, function()
			if not IsValid(self) then return end
			self:CreateBeamRingEffect()
			self:CreateTeslaEffect()
		end)

		timer.Create("RemoveEntityTimer" .. self:EntIndex(), 120, 1, function()
			if IsValid(self) then
				self:Dissolve(1, 300)
			end
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

		for i = 1, 5 do
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

			timer.Simple(0.2, function()
				if IsValid(tesla) then
					tesla:Remove()
				end
			end)
		end
	end

	function ENT:OnRemove()
		timer.Remove("BeamRingEffectTimer" .. self:EntIndex())
		timer.Remove("RemoveEntityTimer" .. self:EntIndex())
		self:StopSound(self.loopSound)
	end
end
