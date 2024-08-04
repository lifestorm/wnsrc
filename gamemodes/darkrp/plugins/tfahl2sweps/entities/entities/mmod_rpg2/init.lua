--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--gernaaaayud
--By Jackarunda
AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

ENT.MotorPower=2500
function ENT:Initialize()
	self.Owner = self:GetOwner()
	self.rockettime = CurTime() + 10
	self.Entity:SetModel("models/weapons/tfa_mmod/w_missile_launch.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)	
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.Entity:SetUseType(SIMPLE_USE)
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(7)
		--phys:EnableGravity(false)
		phys:EnableDrag(false)
	end
	self:Fire("enableshadow","",0)
	self.Exploded=false
	self.ExplosiveMul=0.5
	self.MotorFired=false
	self.Engaged=false
	self:SetModelScale(1,0)
	self:SetColor(Color(255,255,255))
	self.InitialAng=self:GetAngles()
	timer.Simple(0,function()
		if(IsValid(self))then
			self:FireMotor()
		end
	end)
	local Settins=physenv.GetPerformanceSettings()
	if(Settins.MaxVelocity<3000)then
		Settins.MaxVelocity=3000
		physenv.SetPerformanceSettings(Settins)
	end
	--if not(self.InitialVel)then self.InitialVel=Vector(0,0,0) end
end
function ENT:FireMotor()
	self.Entity:EmitSound("TFA_MMOD.RPG.Loop")
	if(self.MotorFired)then return end
	self.MotorFired=true
	--sound.Play("snd_jack_missilemotorfire.wav",self:GetPos(),85,110)
	--sound.Play("snd_jack_missilemotorfire.wav",self:GetPos()+Vector(0,0,1),88,110)
	self:SetDTBool(0,true)
	self.Engaged=true
end
function ENT:PhysicsCollide(data,physobj)
	if((data.Speed>80)and(data.DeltaTime>.2))then
		self:Detonate()
	end
end
function ENT:OnTakeDamage(dmginfo)
	self.Entity:TakePhysicsDamage(dmginfo)
end
function ENT:Think()
	if(self.Exploded)then return end
	if not(self.Engaged)then
		self:GetPhysicsObject():EnableGravity(false)
		self:SetAngles(self.InitialAng)
		--self:GetPhysicsObject():SetVelocity(self.InitialVel)
	end
	if(self.MotorFired)then
		--local Flew=EffectData()
		--Flew:SetOrigin(self:GetPos()-self:GetRight()*20)
		--Flew:SetNormal(-self:GetRight())
		--Flew:SetScale(2)
		--util.Effect("eff_jack_rocketthrust",Flew)
		local Flew=EffectData()
		Flew:SetOrigin(self:GetPos()-self:GetRight()*20)
		Flew:SetNormal(-self:GetRight())
		Flew:SetScale(0.5)
		util.Effect("eff_jack_rocketthrust",Flew)
		local effdat = EffectData()
		effdat:SetOrigin( self:GetPos() )
		effdat:SetNormal( -self:GetForward() )
		effdat:SetScale( 1 )
		local SelfPos=self:GetPos()
		local Phys=self:GetPhysicsObject()
		Phys:EnableGravity(false)
		Phys:ApplyForceCenter(self:GetRight()*self.MotorPower)
		self.MotorPower=self.MotorPower+2000
		if(self.MotorPower>=2000)then self.MotorPower=2000 end
	end
	if self.rockettime < CurTime() then
		self:Detonate()
	end
	self:NextThink(CurTime()+.025)
	return true
end
function ENT:OnRemove()
	--pff
end
function ENT:Detonate()
	self.Entity:StopSound( "TFA_MMOD.RPG.Loop" )
	self.Entity:SetOwner(self.RPGOwner)
	if(self.Exploding)then return end
	self.Exploding=true
	local SelfPos=self:GetPos()
	local Pos=SelfPos
	if(true)then
		/*-  EFFECTS  -*/
		util.ScreenShake(SelfPos,99999,99999,1,750)
		--ParticleEffect("pcf_jack_airsplode_medium",SelfPos,self:GetAngles())
		for key,thing in pairs(ents.FindInSphere(SelfPos,500))do
			if((thing:IsNPC())and(self:Visible(thing)))then
				if(table.HasValue({"npc_strider","npc_combinegunship","npc_helicopter","npc_turret_floor","npc_turret_ground","npc_turret_ceiling"},thing:GetClass()))then
					thing:SetHealth(1)
					thing:Fire("selfdestruct","",.5)
				end
			end
		end
		util.BlastDamage(self.Entity,self.RPGOwner,SelfPos,250,3000)
		for i=0,40 do
			local Trayuss=util.QuickTrace(SelfPos,VectorRand()*200,{self.Entity})
			if(Trayuss.Hit)then
				util.Decal("Scorch",Trayuss.HitPos+Trayuss.HitNormal,Trayuss.HitPos-Trayuss.HitNormal)
			end
		end
		local Boom=EffectData()
		Boom:SetOrigin(SelfPos)
		Boom:SetScale(1)
		util.Effect("eff_jack_lightboom",Boom,true,true)
		self.Entity:Remove()
	end
end
function ENT:Use(activator,caller)
	--lol dude
end