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

SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Combine Sniper Rifle"
SWEP.Author 					= "Comrade Communist"
SWEP.Contact					= ""
SWEP.Purpose					= ""
SWEP.Instructions				= ""
SWEP.Category					= "VJ Base"
SWEP.Spawnable = false
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/weapons/w_combinesniper_e2.mdl"
SWEP.HoldType 					= "ar2"
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 0.2 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0.01 -- How much time until the bullet/projectile is fired?
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = false -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(-10,0,180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1,0,0.5)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 0 -- Damage
SWEP.NPC_CustomSpread	 		= 0.00000001
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.Primary.Ammo				= "AR2" -- Ammo type
SWEP.Primary.TracerType			= "AR2Tracer"
SWEP.Reload_TimeUntilAmmoIsSet	= 0.1 -- Time until ammo is set to the weapon
SWEP.Reload_TimeUntilFinished	= 0.4 -- How much time until the player can play idle animation, shoot, etc.

function SWEP:CustomOnThink() 

if self.Owner.SquadName == "resistance" then

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
if self.Owner.SquadName == "combine_sniper" then

if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_CallForHelp = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_Medic_GiveHealth = {ACT_RANGE_ATTACK_AR2_LOW} 
self.Owner.AnimTbl_Flinch = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.CallForBackUpOnDamageAnimation = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_AlertFriendsOnDeath = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_WeaponAttackCrouch = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_ShootWhileMovingRun = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_ShootWhileMovingWalk = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_ScaredBehaviorStand = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_IdleStand = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_WeaponAttack = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_Walk = {ACT_RANGE_ATTACK_AR2_LOW}
self.Owner.AnimTbl_Run = {ACT_RANGE_ATTACK_AR2_LOW}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY}
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
SWEP.FireDelay = 0
C_RELATIONS = CreateConVar( "cup_companion", "0", FCVAR_CLIENTDLL, "Companion mode." )
function SWEP:CustomOnInitialize()
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
	self.NPCmag = 5
	self.LightAndStuff = false
	self.MoveAss = false
	self.Sniper = false
	self.CanShoot = 1
end
function SWEP:Initialize()

	self:CustomOnInitialize()

	if (SERVER) then
		self:SetNPCMinBurst(10)
		self:SetNPCMaxBurst(20)
		self:SetNPCFireRate(10)

		if self.Owner:IsNPC() then
			self:SetWeaponHoldType(self.HoldType)
			if self.Owner:GetClass() == "npc_sniper" then self.Owner:Fire("DisableWeaponPickup") end
			self.Owner:SetKeyValue("spawnflags","256") -- Long Visibility Shooting since HL2 NPCs are blind
			if self.Owner:GetClass() != "npc_sniper" then
			
			end
		end
	end
	if self.Owner:IsNPC() && self.Owner.IsVJBaseSNPC then
		self.Owner.Weapon_StartingAmmoAmount = self.Primary.ClipSize
	end
	self:SetDefaultValues(self.HoldType)
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:MuzzleFlash( ) 
	if self.Owner:IsNPC() then
	if IsValid(self.sniperpr) then
	self:Relations(self.sniperpr)
	end
	self:BulletLol()
	end
end
function SWEP:Relations(ent)
if IsValid(ent) then
for _, enemy in pairs( ents.GetAll() ) do
if ( C_RELATIONS:GetInt() == 1 ) then
self.Format2 = false
if enemy:IsPlayer() then
ent:AddEntityRelationship( enemy, D_LI, 99 )
end
end
if ( C_RELATIONS:GetInt() == 0 ) then
if enemy:IsPlayer() then
if self.Format2 == false or self.Format2 == nil then
self.Format2 = true

ent:AddEntityRelationship( enemy, D_HT, 99 )
end
end
end
end
end
end
function SWEP:BulletLol()
Nemesis = self.Owner:GetEnemy()
if IsValid(Nemesis) then
if self.Sniper == false then
		self.Sniper = true
		self.sniperpr = ents.Create("npc_sniper")
				local viewpos = self:GetPos() + self:GetForward() * 400 + self:GetUp() * 400 + self:GetRight() * 360
		self.sniperpr:SetPos(viewpos)
		self.sniperpr:Spawn()

		self.sniperpr:SetSolid(SOLID_NONE)
		self.sniperpr:SetParent(self.Weapon)
		self.sniperpr:SetModel("models/weapons/w_pistol.mdl")
		self.sniperpr:SetKeyValue( "squadname", "combine_sniper" )
		self.sniperpr:Fire("setparentattachment", self.Weapon:GetAttachments()[1].name)
		self.sniperpr:SetKeyValue( "spawnflags", "256" + "8192" + "262144" )
		self.sniperpr:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
		self.sniperpr:SetNoDraw(true)
		timer.Simple(4, function()
		if IsValid(self.sniperpr) and (not(IsValid(Nemesis))) then
		self.sniperpr:Remove()
		self.Sniper = false
		end
		end)
end
end
end