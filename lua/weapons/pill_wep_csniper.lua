--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

//SWEP.base = "weapon_base"

AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_combine_sniper.mdl"

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "AR2"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Pulse Sniper Rifle"
SWEP.Category = "Pill Pack Weapons"
SWEP.Slot=3

SWEP.pill_attachment = "anim_attachment_RH"
SWEP.pill_offset = Vector(20,0,5)
SWEP.pill_angle = Angle(0,180,0)

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"Scoped")
end

function SWEP:Initialize()
	self:SetHoldType("ar2")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
 
	local bullet = {} 
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	//bullet.Spread = Vector(.001 ,.001, 0)
	bullet.Tracer = 1
	bullet.TracerName = "AirboatGunHeavyTracer"
	bullet.Force = 5
	bullet.Damage = 50
 
	self:ShootEffects()
 
	self.Owner:FireBullets(bullet) 
	self:EmitSound("npc/sniper/sniper1.wav")
	self:EmitSound("npc/sniper/echo1.wav")
	self:TakePrimaryAmmo(1)
 
	//self:SetNextPrimaryFire( CurTime() + .5)
end

function SWEP:SecondaryAttack()
	//if !IsFirstTimePredicted() then return end
	self:SetScoped(!self:GetScoped())

	if self:GetScoped() then
		local effectdata = EffectData()
		effectdata:SetEntity(self)
		util.Effect("sniper_lazer",effectdata,true,true)
	end
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if ( self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		self:EmitSound("npc/sniper/reload1.wav")
		self:DefaultReload(ACT_VM_RELOAD)
		self.ReloadingTime = CurTime() + 1.5
		self:SetNextPrimaryFire(CurTime() + 1.5)
	end
end

function SWEP:TranslateFOV( fov )
	if self:GetScoped() then
		return 15
	end
	return fov
end

function SWEP:AdjustMouseSensitivity()
	if self:GetScoped() then
		return .1
	end
	return 1
end

function SWEP:Holster()
	self:SetScoped(false)
	return true
end

/*local lazerMat = Material("cable/xbeam")
function SWEP:PillDraw()
	//print("AHHH")
	print(self:GetScoped())
	//if self:GetScoped() then
		//print("NIG")
		local color = Color(90, 240, 255)
	 
		render.SetMaterial(lazerMat)
	 
		render.DrawBeam(self.Owner:EyePos(),self.Owner:GetEyeTrace().HitPos,2,0,0,color)
		//print("RWJ")
	//end
end*/