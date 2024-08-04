--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "AR2"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.UseHands					= true
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 0.9 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0.1 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {0.1,0.2,0.3,0.4,0.5,0.6} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_irifle.mdl"
SWEP.WorldModel					= "models/weapons/w_irifle.mdl"
SWEP.HoldType 					= "ar2"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false

SWEP.NPC_NextPrimaryFireT2 = math.random(6.5,10)
	SWEP.NPC_TimeUntilFires	 		= math.random(6.5,10)	-- How much time until the bullet/projectile is fired?
SWEP.NPC_NextSecondaryFire 		= math.random(10.093,15.093)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= math.random(8,10) -- Damage
SWEP.Primary.Force				= 10 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 30 -- Max amount of bullets per clip
SWEP.Primary.Delay				= 0.1 -- Time until it can shoot again
SWEP.Primary.TracerType			= "AR2Tracer" -- Tracer type (Examples: AR2, laster, 9mm)
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "AR2" -- Ammo type
SWEP.Primary.Sound				= {"vj_weapons/hl2_ar2/ar2_single1.wav","vj_weapons/hl2_ar2/ar2_single2.wav","vj_weapons/hl2_ar2/ar2_single3.wav"}
SWEP.Primary.DistantSound		= {"Weapon_AR2.NPC_Single"}
SWEP.PrimaryEffects_MuzzleParticles = {"vj_rifle_full_blue"}
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_DynamicLightColor = Color(0, 31, 225)
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound				= false -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.ReloadSound				= "weapons/ar2/ar2_reload.wav"
SWEP.Reload_TimeUntilAmmoIsSet	= 0.8 -- Time until ammo is set to the weapon
SWEP.Reload_TimeUntilFinished	= 1.8 -- How much time until the player can play idle animation, shoot, etc.
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.1 -- How much time until it plays the idle animation after attacking(Primary)



function SWEP:CustomOnPrimaryAttack_AfterShoot()
				 		local dm = math.random(0,60)
				if ( dm == 20 ) then
	self:FireBalls()
	end

 end
 function SWEP:FireBalls()

if SERVER then
local cballspawner = ents.Create( "point_combine_ball_launcher" )
	local OwnerPos = self.Owner:GetShootPos()
	local OwnerAng = self.Owner:GetAimVector():Angle()
cballspawner:SetAngles( self.Owner:GetAngles())
	local OwnerPos = self.Owner:GetShootPos()
	local OwnerAng = self.Owner:GetAimVector():Angle()
	OwnerPos = OwnerPos + OwnerAng:Forward()*-20 + OwnerAng:Up()*-9 + OwnerAng:Right()*math.random(0,10)
	if self.Owner:IsPlayer() then cballspawner:SetPos(OwnerPos) else cballspawner:SetPos(self:GetAttachment(self:LookupAttachment("muzzle")).Pos) end
	if self.Owner:IsPlayer() then cballspawner:SetAngles(OwnerAng) else cballspawner:SetAngles(self.Owner:GetAngles()) end
cballspawner:SetKeyValue( "minspeed",3000 )
cballspawner:SetKeyValue( "maxspeed", 3000 )
cballspawner:SetKeyValue( "ballradius", "20" )
cballspawner:SetKeyValue( "ballcount", "1" )
cballspawner:SetKeyValue( "maxballbounces", "3" )
cballspawner:SetKeyValue( "launchconenoise", 0 )

cballspawner:Spawn()
cballspawner:Activate()
cballspawner:Fire( "LaunchBall" )
cballspawner:Fire("kill","",0)

	local phy = cballspawner:GetPhysicsObject()
	if phy:IsValid() then
		if self.Owner:IsPlayer() then
		phy:ApplyForceCenter(self.Owner:GetAimVector() * 4000) else //200000
		//phy:ApplyForceCenter((self.Owner:GetEnemy():GetPos() - self.Owner:GetPos()) * 4000)
		phy:ApplyForceCenter(((self.Owner:GetEnemy():GetPos()+self.Owner:GetEnemy():OBBCenter()+self.Owner:GetEnemy():GetUp()*math.random(45,145)) - self.Owner:GetPos()+self.Owner:OBBCenter()+self.Owner:GetEnemy():GetUp()*math.random(-45,-145)) * 4000)
		//data.Dir = (Entity:GetEnemy():GetPos()+Entity:GetEnemy():OBBCenter()+Entity:GetEnemy():GetUp()*-45) -Entity:GetPos()+Entity:OBBCenter()+Entity:GetEnemy():GetUp()*-45
		end
	end
end

timer.Create("Uniquename1",0.01,1,function()
if IsValid(self.Owner) then
for k,v in pairs(ents.FindInSphere(self.Owner:GetShootPos(),100)) do
if IsValid(v) and v:GetClass() == "prop_combine_ball" and !IsValid(v:SetOwner()) and SERVER then
v:SetOwner(self.Owner)
end
end
end
end)

end
function SWEP:PrimaryAttackEffects()
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(self.Owner:GetShootPos())
	vjeffectmuz:SetEntity(self.Weapon)
	vjeffectmuz:SetStart(self.Owner:GetShootPos())
	vjeffectmuz:SetNormal(self.Owner:GetAimVector())
	vjeffectmuz:SetAttachment(1)
	vjeffectmuz:SetMagnitude(0)
	util.Effect("VJ_Weapon_RifleMuzzle1",vjeffectmuz)
	
	if GetConVarNumber("vj_wep_nobulletshells") == 1 then
	if !self.Owner:IsPlayer() then
	local vjeffect = EffectData()
	vjeffect:SetEntity(self.Weapon)
	vjeffect:SetOrigin(self.Owner:GetShootPos())
	vjeffect:SetNormal(self.Owner:GetAimVector())
	vjeffect:SetAttachment(1)
	util.Effect("VJ_Weapon_RifleShell1",vjeffect) end
	end

	if (SERVER) then
	if GetConVarNumber("vj_wep_nomuszzleflash") == 1 then
	local FireLight1 = ents.Create("light_dynamic")
	FireLight1:SetKeyValue("brightness", "2")
	if self.Owner:IsPlayer() then
	FireLight1:SetKeyValue("distance", "200") else FireLight1:SetKeyValue("distance", "150") end
	FireLight1:SetLocalPos(self.Owner:GetShootPos() +self:GetForward()*40 + self:GetUp()*-40)
	FireLight1:SetLocalAngles(self:GetAngles())
	FireLight1:Fire("Color", "255 150 60")
	FireLight1:SetParent(self)
	FireLight1:Spawn()
	FireLight1:Activate()
	FireLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(FireLight1)
	timer.Simple(0.07,function() if self:IsValid() then FireLight1:Remove() end end)
	end
 end
end
function SWEP:CustomOnThink() 

if self.Owner.SquadName == "resistance" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_RPG}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE_RELAXED}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE_RELAXED}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN_RPG}
self.Owner.AnimTbl_Walk = {ACT_WALK_RPG_RELAXED}
end
end
if self.Owner.SquadName == "barney" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1_STIMULATED}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN_RPG}
self.Owner.AnimTbl_Walk = {ACT_WALK_RPG_RELAXED}
end
end
if self.Owner.SquadName == "metrocop" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN}

self.Owner.AnimTbl_Walk = {ACT_WALK}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "combine" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "combine_elit" then

if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "combine_nova" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_IDLE_SMG1}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "metrocops" then
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then

self.Owner.AnimTbl_Run = {ACT_RUN}
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Walk = {ACT_IDLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
end

