--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model		= Model("models/weapons/tfa_hl2r/w_missile.mdl")
ENT.ModelLaunch	= Model("models/weapons/tfa_hl2r/w_missile_launch.mdl")
ENT.Sprite		= "sprites/animglow01.vmt"
ENT.FlySound	= "Missile.Ignite"

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_FLYGRAVITY)
	self:SetMoveCollide(MOVECOLLIDE_FLY_BOUNCE)
	self:SetSolid(SOLID_BBOX)
	self:SetModel(self.ModelLaunch)
	self:SetCollisionBounds(Vector(), Vector())
	
	local angAngs = self:GetAngles()
	angAngs.x = angAngs.x - 30
	local vecFwd = angAngs:Forward()
	
	self:SetLocalVelocity(vecFwd * 250)
	local svgravity = cvars.Number("sv_gravity", 800)
	if svgravity != 0 then
		local gravityMul = 400 / svgravity
		self:SetGravity(gravityMul)
	end

	self:NextThink(CurTime() + .4)

	self.radius = 300
end

function ENT:Touch(pOther)
	if !pOther:IsSolid() or pOther:GetClass() == "hornet" then
		return
	end
	self:Explode(pOther)
end

function ENT:Explode(ent)
	if self.didHit then return end
	local vecDir = self:GetForward()
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + vecDir * 16,
		mask = MASK_SHOT,
		filter = self
	})
	
	self:SetSolid(SOLID_NONE)
	if tr.Fraction == 1.0 || !tr.HitSky then
		local pos, norm = tr.HitPos, tr.HitNormal
		local explosion = EffectData()
		explosion:SetOrigin(pos)
		explosion:SetNormal(norm)
		if self:WaterLevel() >= 3 then
			util.Effect("WaterSurfaceExplosion", explosion)
		else
			local explode = ents.Create( "info_particle_system" )
			explode:SetKeyValue( "effect_name", "hl2r_explosion_rpg" )
			explode:SetOwner( self.Owner )
			explode:SetPos( self:GetPos() )
			explode:Spawn()
			explode:Activate()
			explode:Fire( "start", "", 0 )
			explode:Fire( "kill", "", 30 )
		end
		util.Decal("Scorch", pos - vecDir + norm, pos + vecDir)
		
		local dlighteff = EffectData()
		dlighteff:SetEntity(self)
		dlighteff:SetOrigin(self:GetPos())
		util.Effect("hl2r_fx_explosion_dlight", dlighteff)
		self:EmitSound("TFA_HL2R_RPG.Explode")
		self:EmitSound("BaseExplosionEffect.Sound")
		
		local owner = IsValid(self.Owner) and self.Owner or self
		local dmg = DamageInfo()
		dmg:SetInflictor(self)
		dmg:SetAttacker(owner)
		dmg:SetDamage(self.dmg)
		dmg:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
		util.BlastDamageInfo(dmg, tr.HitPos, self.radius)
	end
	
	self.didHit = true
	--self:RemoveEffects(EF_BRIGHTLIGHT)
	self:StopSound(self.FlySound)
	self:SetLocalVelocity(Vector())
	self:SetMoveType(MOVETYPE_NONE)
	self:AddEffects(EF_NODRAW)
	if self.glow and IsValid(self.glow) then self.glow:Remove() end
	self:Remove()
end

function ENT:Think()
	if self.didHit then return end
	if !self.m_flIgniteTime then
		self:SetMoveType(MOVETYPE_FLY)
		self:SetModel(self.Model)
		ParticleEffectAttach("hl2r_weapon_rpg_smoketrail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		--self:AddEffects(EF_BRIGHTLIGHT)
		self:EmitSound(self.FlySound)
		
		-- self.glow = ents.Create("env_sprite")
		-- local glow = self.glow
		-- glow:SetKeyValue("rendercolor", "255 192 64")
		-- glow:SetKeyValue("GlowProxySize", "2")
		-- glow:SetKeyValue("HDRColorScale", "1")
		-- glow:SetKeyValue("renderfx", "15")
		-- glow:SetKeyValue("rendermode", "3")
		-- glow:SetKeyValue("renderamt", "255")
		-- glow:SetKeyValue("model", self.Sprite)
		-- glow:SetKeyValue("scale", ".08")
		-- glow:Spawn()
		-- glow:SetParent(self)
		-- glow:SetPos(self:GetPos())
		--ParticleEffectAttach("rocket_smoke_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		--ParticleEffectAttach("weapon_rpg_smoketrail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		ParticleEffectAttach("hl2r_weapon_rpg_smoketrail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		--util.SpriteTrail( self.Entity, 0, Color( 165, 165, 165 ), false, 8, 16, 0.5, 1 / ( 165 ), "trails/smoke.vmt" )
		
		self.m_flIgniteTime = CurTime()
		self.vecTarget = self:GetForward()

		self:NextThink(CurTime() + 0.1)
	end
	if self.bGuiding then
		local spot = IsValid(self.pLauncher) and !self.pLauncher:GetSprinting() and self.pLauncher:GetSpotEntity() or NULL
		local vecDir = Vector()
		
		if IsValid(spot) and spot:GetOwner() == self:GetOwner() and spot:GetDrawLaser() then
			local tr = util.TraceLine({
				start = self:GetPos(),
				endpos = spot:GetPos(),
				filter = {self, self.Owner, spot}
			})
			if tr.Fraction >= 0.90 then
				vecDir = spot:GetPos() - self:GetPos()
				vecDir = vecDir:GetNormalized()
				self.vecTarget = vecDir
			end
		end
	end
	
	self:SetAngles(self.vecTarget:Angle())
	
	local flSpeed = self:GetVelocity():Length()
	self:SetLocalVelocity(self:GetVelocity() * 0.2 + self.vecTarget * (flSpeed * 0.8 + 400))
	if self:WaterLevel() == 3 then
		if self:GetVelocity():Length() > 300 then
			self:SetLocalVelocity(self:GetVelocity():GetNormalized() * 300)
		end
	else
		if self:GetVelocity():Length() > 2000 then
			self:SetLocalVelocity(self:GetVelocity():GetNormalized() * 2000)
		end
	end
	
	self:NextThink(CurTime() + .1)
	return true
end

function ENT:OnRemove()
	self:StopSound(self.FlySound)
end