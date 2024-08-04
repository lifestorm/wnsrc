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
SWEP.Base 						= "weapon_vj_melee_base_v2"



SWEP.PrintName					= "Crowbar VJ"
SWEP.Author 					= "Comrade Communist"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
SWEP.Slot						= 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.SwayScale 					= 1 -- Default is 1, The scale of the viewmodel sway
end
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_crowbar.mdl"
SWEP.WorldModel					= "models/weapons/w_crowbar.mdl"
SWEP.HoldType 					= "melee"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.IsVJBaseWeapon				= true
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= math.random(30,37) -- Damage
SWEP.Primary.PlayerDamage		= "Double" -- Only applies for players | "Same" = Same as self.Primary.Damage, "Double" = Double the self.Primary.Damage OR put a number to be different from self.Primary.Damage
SWEP.Primary.Force				= math.random(1,2) -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 10000000 -- Max amount of bullets per clip
SWEP.Primary.Recoil				= 1.3 -- How much recoil does the player get?
SWEP.NPC_TimeUntilFires	 		= math.random(0.4,1)
SWEP.NPC_NextPrimaryFire 		= 1.093
SWEP.Primary.Delay				= 0.8 -- Time until it can shoot again
SWEP.Primary.Automatic			= false -- Is it automatic?
SWEP.Primary.Ammo				= "smg" -- Ammo type

SWEP.Primary.HasDistantSound	= false -- Does it have a distant sound when the gun is shot?

SWEP.PrimaryEffects_MuzzleAttachment = 0
SWEP.PrimaryEffects_ShellAttachment = 0
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_RifleShell1"
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 0.4 -- Time until it can shoot again after deploying the weapon
SWEP.HasDeploySound				= false -- Does the weapon have a deploy sound?
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Reload_TimeUntilAmmoIsSet	= 2.1 -- Time until ammo is set to the weapon
SWEP.Reload_TimeUntilFinished	= 3.4 -- How much time until the player can play idle animation, shoot, etc.
SWEP.UseHands				= true
SWEP.ViewModelFOV			= 62
function SWEP:CustomOnThink() 
self.Owner.Weapon_FiringDistanceFar = math.random(35,45)
self.Owner.Weapon_FiringDistanceClose = math.random(-100,-1000)

self.Owner.WeaponReloadAnimationFaceEnemy = false
self.Owner.HasWeaponBackAway = false
self.Owner.AllowWeaponReloading = true
self.Owner.CanCrouchOnWeaponAttack = false
self.Owner.RunAwayOnUnknownDamage = false
self.Owner.MoveOrHideOnDamageByEnemy = false
self.Owner.DisableWeaponReloadAnimation = true
self.Owner.WaitForEnemyToComeOut = false
self.Owner.NoWeapon_UseScaredBehavior = false
self.Owner.RunFromEnemy_Distance = 0

if self.Owner.SquadName == "metrocopg" then

if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_WALK_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "metrocopga" then

if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_WALK_RIFLE}

self.Owner.AnimTbl_Walk = {ACT_IDLE_SMG1}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_RIFLE}
end
end
if self.Owner.SquadName == "resistance" then
self.Owner.AnimTbl_MeleeAttack = {"swing"}


if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN}

self.Owner.AnimTbl_Walk = {ACT_WALK}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE}
self.Owner.AnimTbl_Run = {ACT_RUN}
self.Owner.AnimTbl_Walk = {ACT_WALK}
end
end
if self.Owner.SquadName == "metrocop" then
self.Owner.AnimTbl_MeleeAttack = {"swing","thrust","swinggesture"}
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
if self.Owner.SquadName == "combine_elit" then
self.Owner.AnimTbl_MeleeAttack = {"melee_gunhit","swing","throw1"}

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
self.Owner.AnimTbl_MeleeAttack = {"melee_gunhit","swing","throw1"}

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
self.Owner.AnimTbl_MeleeAttack = {"swing","thrust","swinggesture"}

if self.Owner.FollowingPlayer == false then

self.Owner.AnimTbl_Run = {ACT_RUN}
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_PISTOL}
self.Owner.AnimTbl_Walk = {ACT_IDLE_PISTOL}
end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_MELEE}
self.Owner.AnimTbl_Run = {ACT_RUN_RIFLE}
self.Owner.AnimTbl_Walk = {ACT_WALK_ANGRY}
end
end

end
function SWEP:CustomOnInitialize()

self.Owner.MeleeAttackDamage = math.random(20,27)
self.Owner.NextMeleeAttackTime = math.random(0.4,1)

self.Owner.DefaultSoundTbl_MeleeAttack = {"Flesh.ImpactHard"}
self.Owner.DefaultSoundTbl_MeleeAttackMiss = {"WeaponFrag.Roll"}
self.Owner.AnimTbl_MeleeAttack = {"swing"}
self.Owner.AnimTbl_WeaponAttack = {ACT_MELEE_ATTACK1}
end



function SWEP:PrimaryAttack()

//if self.Owner:KeyDown(IN_RELOAD) then return end
	//self.Owner:SetFOV(45, 0.3)
	//if !IsFirstTimePredicted() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if self.Reloading == true then return end
	if self.Owner:IsNPC() && self.Owner.VJ_IsBeingControlled == false && !IsValid(self.Owner:GetEnemy()) then return end
	if self.Owner:IsPlayer() && self.Primary.AllowFireInWater == false && self.Owner:WaterLevel() == 3 && self.Reloading == false then self:EmitSound(VJ_PICKRANDOMTABLE(self.DryFireSound),self.DryFireSoundLevel,math.random(self.DryFireSoundPitch1,self.DryFireSoundPitch2)) return end
	if self:Clip1() <= 0 && self.Reloading == false then self:EmitSound(VJ_PICKRANDOMTABLE(self.DryFireSound),self.DryFireSoundLevel,math.random(self.DryFireSoundPitch1,self.DryFireSoundPitch2)) return end
	if (!self:CanPrimaryAttack()) then return end
	self:CustomOnPrimaryAttack_BeforeShoot()
	if (SERVER) then

		local firesd = VJ_PICKRANDOMTABLE(self.Primary.Sound)
		if firesd != false then
			sound.Play(firesd,self:GetPos(),80,math.random(90,100))
		end
		if self.Primary.HasDistantSound == true then
			local farsd = VJ_PICKRANDOMTABLE(self.Primary.DistantSound)
			if farsd != false then
				sound.Play(farsd,self:GetPos(),self.Primary.DistantSoundLevel,math.random(self.Primary.DistantSoundPitch1,self.Primary.DistantSoundPitch2),self.Primary.DistantSoundVolume)
			end
		end
	end
	//self:EmitSound(Sound(self.Primary.Sound),80,self.Primary.SoundPitch)
	if self.Primary.DisableBulletCode == false then
	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()
	damagedice = math.Rand(1,2)
			
	pain = self.Primary.Damage * damagedice
			self.Weapon:EmitSound("WeaponFrag.Roll")--slash in the wind sound here
				if SERVER and IsValid(self.Owner) then
						local slash = {}
						slash.start = pos
						slash.endpos = pos + (ang * 80)
						slash.filter = self.Owner
						slash.mins = Vector(-5, -5, 0)
						slash.maxs = Vector(5, 5, 5)
						local slashtrace = util.TraceHull(slash)
						if slashtrace.Hit then
							targ = slashtrace.Entity
							if targ:IsPlayer() or targ:IsNPC() then
									self.Owner:EmitSound("Flesh.ImpactHard")								
								paininfo = DamageInfo()
								paininfo:SetDamage(pain)
								paininfo:SetDamageType(DMG_SLASH)
								paininfo:SetAttacker(self.Owner)
								paininfo:SetInflictor(self.Weapon)
						  local RandomForce = math.random(1,20)
								paininfo:SetDamageForce(slashtrace.Normal * RandomForce)
								if targ:IsPlayer() then
								targ:ViewPunch( Angle( -10, -20, 0 ) )
								end
							local blood = targ:GetBloodColor()	
						   local fleshimpact		= EffectData()
								fleshimpact:SetEntity(self.Weapon)
								fleshimpact:SetOrigin(slashtrace.HitPos)
								fleshimpact:SetNormal(slashtrace.HitPos)
								if blood >= 0 then
								fleshimpact:SetColor(blood)
								util.Effect("BloodImpact", fleshimpact)
								end
								
								if SERVER then targ:TakeDamageInfo(paininfo) end
							end
						end
					end
						local slash = {}
						slash.start = pos
						slash.endpos = pos + (ang * 80)
						slash.filter = self.Owner
						slash.mins = Vector(-5, -5, 0)
						slash.maxs = Vector(5, 5, 5)
			local spawnpos = self.Owner:GetShootPos()
			if self.Owner:IsNPC() then
				spawnpos = self:GetNWVector("VJ_CurBulletPos")
			end
			//print(spawnpos)
			//VJ_CreateTestObject(spawnpos,self:GetAngles(),Color(0,0,255))

				self:CustomOnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
			end
								local slash = {}
						slash.start = pos
						slash.endpos = pos + (ang * 80)
						slash.filter = self.Owner
						slash.mins = Vector(-5, -5, 0)
						slash.maxs = Vector(5, 5, 5)
				local slashtrace = util.TraceHull(slash)
						if slashtrace.Hit then
							targ = slashtrace.Entity
							if targ:IsPlayer() or targ:IsNPC() then
									self.Owner:EmitSound("Flesh.ImpactHard")								
								paininfo = DamageInfo()
								paininfo:SetDamage(pain)
								paininfo:SetDamageType(DMG_SLASH)
								paininfo:SetAttacker(self.Owner)
								paininfo:SetInflictor(self.Weapon)
						  local RandomForce = math.random(1,20)
								paininfo:SetDamageForce(slashtrace.Normal * RandomForce)
								if targ:IsPlayer() then
								targ:ViewPunch( Angle( -10, -20, 0 ) )
								end
							local blood = targ:GetBloodColor()	
						   local fleshimpact		= EffectData()
								fleshimpact:SetEntity(self.Weapon)
								fleshimpact:SetOrigin(slashtrace.HitPos)
								fleshimpact:SetNormal(slashtrace.HitPos)
								if blood >= 0 then
								fleshimpact:SetColor(blood)
								util.Effect("BloodImpact", fleshimpact)
								end
								end




	else
		if self.Owner:IsNPC() && self.Owner.IsVJBaseSNPC == true then
			
		end
	end
	if GetConVarNumber("vj_wep_nomuszzleflash") == 0 then self.Owner:MuzzleFlash() end

	if self.Owner:IsPlayer() then
		local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
	self:ShootEffects("ToolTracer")
	self:SendWeaponAnim(VJ_PICKRANDOMTABLE(self.AnimTbl_PrimaryFire))
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:ViewPunch(Angle(-self.Primary.Recoil,0,0)) end
	if !self.Owner:IsNPC() then
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	end
	self:CustomOnPrimaryAttack_AfterShoot()
	//self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	timer.Simple(self.NextIdle_PrimaryAttack,function() if self:IsValid() then self:DoIdleAnimation() end end)
	end




