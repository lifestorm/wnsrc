--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Type       = "anim"
ENT.PrintName  = "Vortigaunt Shield"
ENT.Category   = "HL2RP"
ENT.Spawnable  = true
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_phx/construct/metal_dome360.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)

		local physObj = self:GetPhysicsObject()
		if (IsValid(physObj)) then
			physObj:Wake() 
		end

		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		self:SetSolid(SOLID_VPHYSICS)
		self:AddEffects(EF_NOSHADOW)
		self:AddEFlags(EFL_DONTBLOCKLOS)
		self:SetRenderMode(RENDERMODE_WORLDGLOW)

		self:SetMaterial("models/props_combine/stasisshield_sheet")
		self:SetColor(Color(0, 255, 55, 255))
		self:SetModelScale(1.2)
		self:SetHealth(ix.config.Get("VortShieldHealth", 500))

		timer.Simple(0.25, function()
			ParticleEffectAttach("vort_shield_parent", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		end)
	end

	function ENT:OnTakeDamage(dmginfo)
		self:EmitSound("ambient/energy/ion_cannon_shot"..math.random(1, 3)..".wav")

		ParticleEffect("vortigaunt_glow_beam_cp0", dmginfo:GetDamagePosition(), Angle(0, 0, 0), self)
		
		self:SetHealth(math.Clamp(self:Health() - dmginfo:GetDamage(), 0, 350))
    
		if self:Health() <= 0 then
			self:Die()
		end
	end

	function ENT:ImpactTrace(trace, dmgtype, customimpactname)
		if (trace.HitSky) then
			return
		end
		
		local effectdata = EffectData()
		effectdata:SetOrigin(trace.HitPos + trace.HitNormal)
		effectdata:SetNormal(trace.HitNormal)
		util.Effect("AR2Impact", effectdata)
		
		return true
	end

	function ENT:Die()
		ParticleEffect("vortigaunt_charge_token", self:GetPos()*15, Angle(0, 0, 0))

		self:EmitSound("ambient/levels/labs/electric_explosion1.wav", 80, 100, 1, CHAN_WEAPON)

		self:Remove()
	end

	function ENT:Think()
		if (!IsValid(self:GetOwner()) or !self:GetOwner():IsVortigaunt()) then
			self:Remove()
		end
		self:NextThink(CurTime() + 0.1)

    	return true
	end	 
else
	function ENT:Think()
		if IsValid(self:GetOwner()) and self:GetOwner():Alive() then 
			local lightVector = self:GetPos() + self:GetUp()*15
			local dlight = DynamicLight(self:EntIndex())					
			dlight.Pos = lightVector
			dlight.r = 30
			dlight.g = 255
			dlight.b = 30
			dlight.Brightness = 0
			dlight.Size = 700
			dlight.Decay = 5
			dlight.DieTime = CurTime() + 0.1
		end
	end

	function ENT:Draw()
		self:DrawModel()
		self:RemoveAllDecals()
	end
end
