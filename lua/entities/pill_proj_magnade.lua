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

ENT.Type   = "anim"
ENT.PrintName = "Magnade"
ENT.Category = "Pill Pack Entities"

//ENT.Spawnable = true
//ENT.AdminSpawnable = true

//ENT.AutomaticFrameAdvance = true

//loop npc/scanner/combat_scan_loop2.wav
//stick weapons/strider_buster/strider_buster_stick1.wav
//det weapons/strider_buster/strider_buster_detonate.wav

function ENT:Initialize()
	if SERVER then
		//Physics
		self:SetModel("models/weapons/w_magnade.mdl")
		self:PhysicsInit(SOLID_VPHYSICS )
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			//phys:SetMaterial("metal_bouncy")
		end

		self.idleSound = CreateSound(self, "npc/scanner/combat_scan_loop2.wav")
		self.idleSound:Play()

		timer.Simple(10,function()
			if IsValid(self) then
				self:EmitSound("physics/metal/metal_box_break1.wav",500)
				ParticleEffect("striderbuster_break",self:GetPos(),self:GetAngles())
				self:Remove()
			end
		end)
	end
end

function ENT:OnRemove()
	if SERVER then self.idleSound:Stop() end
end

//Stolen from bouncy ball
local BounceSound = Sound("npc/roller/blade_cut.wav")
function ENT:PhysicsCollide( data, physobj )
	if (!data.HitEntity:IsWorld()&&data.HitEntity:GetClass()!="pill_proj_magnade") then
		self:SetParent(data.HitEntity)
		//constraint.Weld(self,data.HitEntity, 0, 0, 0, true, true)
		self:EmitSound("weapons/strider_buster/strider_buster_stick1.wav")
		ParticleEffect("striderbuster_attach",self:GetPos(),self:GetAngles(),self)
		ParticleEffect("striderbuster_attach_flash",self:GetPos(),self:GetAngles(),self)
		return
	end

	-- Play sound on bounce
	if ( data.Speed > 60 && data.DeltaTime > 0.2 ) then
		sound.Play( BounceSound, self:GetPos(), 75, math.random( 90, 120 ), math.Clamp( data.Speed / 150, 0, 1 ) )
	end

	-- Bounce like a crazy bitch
	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = physobj:GetVelocity()
	NewVelocity:Normalize()
	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed
	physobj:SetVelocity( TargetVelocity )
end

function ENT:OnTakeDamage(dmg)
	if self.sploded then return end
	self.sploded=true
	util.BlastDamage(self, self.attacker||self, self:GetPos(), 100, 100)
	self:EmitSound("weapons/strider_buster/strider_buster_detonate.wav",500)
	ParticleEffect("striderbuster_explode_core",self:GetPos(),self:GetAngles())
	ParticleEffect("striderbuster_explode_flash",self:GetPos(),self:GetAngles())
	self:Remove()
end

/*

function ENT:SpawnFunction( ply, tr, ClassName )

	if (  !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 100

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent

end*/