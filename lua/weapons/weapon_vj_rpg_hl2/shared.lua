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
SWEP.PrintName					= "RPG"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 4 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.UseHands					= true
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 5 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0.8 -- How much time until the bullet/projectile is fired?
SWEP.NPC_ReloadSound			= {"vj_weapons/reload_rpg.wav"}
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_rpg.mdl"
SWEP.WorldModel					= "models/weapons/w_rocket_launcher.mdl"
SWEP.HoldType 					= "smg"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 5 -- Damage
SWEP.Primary.Force				= 5 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.Primary.Recoil				= 0.6 -- How much recoil does the player get?
SWEP.Primary.Delay				= 0.3 -- Time until it can shoot again
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "RPG_Round" -- Ammo type
SWEP.Primary.Sound				= {"vj_weapons/rpg/rpg_fire.wav"} // Weapon_RPG.Single
SWEP.Primary.HasDistantSound	= true -- Does it have a distant sound when the gun is shot?
SWEP.Primary.DistantSound		= {"vj_weapons/rpg/rpg_fire_far.wav"} // Weapon_RPG.NPC_Single
SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_SpawnShells = false
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 1 -- Time until it can shoot again after deploying the weapon
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasReloadSound				= true -- Does it have a reload sound? Remember even if this is set to false, the animation sound will still play!
SWEP.Reload_TimeUntilAmmoIsSet	= 0.8 -- Time until ammo is set to the weapon
SWEP.Reload_TimeUntilFinished	= 1.8 -- How much time until the player can play idle animation, shoot, etc.
SWEP.ReloadSound				= "vj_weapons/reload_rpg.wav"
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.1 -- How much time until it plays the idle animation after attacking(Primary)
---------------------------------------------------------------------------------------------------------------------------------------------

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
if self.Owner.SquadName == "metrocop" then
self.HoldType 					= "smg"
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
self.HoldType 					= "smg"
end
end

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
if (CLIENT) then return end
	local SpawnBlaserRod = ents.Create("obj_vj_rpg_shells")
	local OwnerPos = self.Owner:GetShootPos()
	local OwnerAng = self.Owner:GetAimVector():Angle()
	OwnerPos = OwnerPos + OwnerAng:Forward()*-20 + OwnerAng:Up()*-9 + OwnerAng:Right()*10
	if self.Owner:IsPlayer() then SpawnBlaserRod:SetPos(OwnerPos) else SpawnBlaserRod:SetPos(self:GetAttachment(self:LookupAttachment("missile")).Pos) end
	if self.Owner:IsPlayer() then SpawnBlaserRod:SetAngles(OwnerAng) else SpawnBlaserRod:SetAngles(self.Owner:GetAngles()) end
	SpawnBlaserRod:SetOwner(self.Owner)
	SpawnBlaserRod:Activate()
	SpawnBlaserRod:Spawn()
	
	local phy = SpawnBlaserRod:GetPhysicsObject()
	if phy:IsValid() then
		if self.Owner:IsPlayer() then
		phy:ApplyForceCenter(self.Owner:GetAimVector() * 4000) else //200000
		//phy:ApplyForceCenter((self.Owner:GetEnemy():GetPos() - self.Owner:GetPos()) * 4000)
		phy:ApplyForceCenter(((self.Owner:GetEnemy():GetPos()+self.Owner:GetEnemy():OBBCenter()+self.Owner:GetEnemy():GetUp()*-45) - self.Owner:GetPos()+self.Owner:OBBCenter()+self.Owner:GetEnemy():GetUp()*-45) * 4000)
		//data.Dir = (Entity:GetEnemy():GetPos()+Entity:GetEnemy():OBBCenter()+Entity:GetEnemy():GetUp()*-45) -Entity:GetPos()+Entity:OBBCenter()+Entity:GetEnemy():GetUp()*-45
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
