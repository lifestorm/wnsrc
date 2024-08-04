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
SWEP.PrintName					= "Crossbow"
SWEP.Author 					= "Comrafe Communist"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------

	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
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
SWEP.ViewModel					= "models/weapons/ñ_crossbow.mdl"
SWEP.WorldModel					= "models/weapons/w_crossbow.mdl"
SWEP.HoldType 					= "smg"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 65 -- Damage
SWEP.Primary.Force				= 5 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.Primary.Recoil				= 0.6 -- How much recoil does the player get?
SWEP.Primary.Delay				= 0.3 -- Time until it can shoot again
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "RPG_Round" -- Ammo type
SWEP.NPC_CustomSpread	 		= 0.000001
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
SWEP.SetFOV = 0


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
self.NPC_NextPrimaryFireT2 = math.random(60000.5,200000)
	self.NPC_TimeUntilFires	 		= math.random(60000.5,20000)	-- How much time until the bullet/projectile is fired?
self.NPC_NextSecondaryFire 		= math.random(10000.093,20000.093)
if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_MeleeAttack = {"swing"}

end
if self.Owner.FollowingPlayer == true then
self.Owner.AnimTbl_MeleeAttack = {"swing"}

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

self.Owner.AnimTbl_MeleeAttack = {"swing"}

end
if self.Owner.FollowingPlayer == true then

self.Owner.AnimTbl_MeleeAttack = {"swing"}

end
end
end
SWEP.Primary.Spread			= 0
function SWEP:PrimaryAttack()
if !(self.Weapon:GetNextPrimaryFire() < CurTime()) then return end
if SERVER then
self.Owner:EmitSound("Weapon_Crossbow.BoltFly")
self.Owner:EmitSound(Sound("weapons/crossbow/fire1.wav"))
end
self.Weapon:SetNextPrimaryFire(CurTime() + 2.4)
self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
self.Owner:MuzzleFlash()							
self.Owner:SetAnimation( PLAYER_ATTACK1 )

local ply = self.Owner
local selfclass = self:GetClass()
timer.Simple( 0.6, function() if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass()==selfclass then  self:SetNetworkedBool( "Ironsights", false ) ply:GetActiveWeapon():SendWeaponAnim( ACT_VM_RELOAD ) timer.Simple(1,function() if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass()==selfclass then ply:EmitSound("Weapon_Crossbow.BoltElectrify") end end) end end)
    if SERVER then
	local bolt2 = ents.Create("crossbow_bolt")
	bolt2:SetOwner(self.Owner)
	bolt2:SetPos(self.Owner:GetShootPos())
	bolt2:SetAngles(self.Owner:EyeAngles())
	bolt2:Spawn()
	bolt2:Activate()
	bolt2:SetVelocity(self.Owner:GetAimVector()*3000)
	bolt2.IsScripted = true
	end

end
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )	
//	surface.SetDrawColor(255, 255, 255, alpha)
//	surface.SetMaterial( self.WepSelectIcon )
	
	local fsin = 0
	
	// Borders
	//y = y + 25
	//x = x + 25
	wide = wide - 45
	
    //surface.DrawTexturedRect( x - 15, y - 12 , 254, 155 )
	//draw.DrawText( ".", "TargetID", x - 15, y - 12, Color( 255, 80, 0, 255 ), TEXT_ALIGN_CENTER )
	surface.SetFont("HL2BoltFont")
	surface.SetTextColor( 255, 191, 0, 255 )
    surface.SetTextPos( x + 20 , y + 10 ) 
    surface.DrawText( "g" )
	
	self:PrintWeaponInfo(x + wide + -28, y + tall * 1.05, alpha)
end
 
function SWEP:Shooting()


	if ( CLIENT ) then return end
	
	local ent = ents.Create("crossbow_bolt")

	ent:SetOwner(self.Owner)
	ent:SetPos(self.Owner:GetShootPos())
	ent:SetAngles(self.Owner:EyeAngles())
	ent:SetDamage( 55 )
	ent:Spawn()
	ent:Activate()
	ent:SetVelocity(self.Owner:GetAimVector()*3000)
	ent.IsScripted = true

	ent.Force = 1
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
		ent:SetPos(self.Owner:GetShootPos() + self.Owner:EyeAngles():Right() * 1 + self.Owner:GetAimVector() * 0 + self.Owner:EyeAngles():Up() * 10 )
	phys:SetMass(100)
	phys:EnableGravity(false)
	phys:ApplyForceCenter(self.Owner:GetAimVector() * 999999999)
end


SWEP.CustomModel = {}
SWEP.CustomModel.CSModel = SWEP.ViewModel
SWEP.CustomModel.CSModelAngle = Angle(90,0,270)
SWEP.CustomModel.CSModelPosition = Vector(8,-6,-20)
SWEP.CustomModel.CSModel2 = "models/crossbow_bolt.mdl"
SWEP.CustomModel.CSModelAngle2 = Angle(90,0,0)
SWEP.CustomModel.CSModelPosition2 = Vector(0,0.5,-5)

function SWEP:ViewModelDrawn()
if SERVER then return end
if !IsValid(self.CSModelGet) then
-- CSModel
local CSModelSinth = ClientsideModel(self.CustomModel.CSModel,RENDER_GROUP_VIEW_MODEL_OPAQUE)
CSModelSinth:SetParent(self)
CSModelSinth:SetSequence(1)
CSModelSinth:SetNoDraw(true)
self.CSModelGet = CSModelSinth
else
local CSModelAng = self.CustomModel.CSModelAngle
local CSModelPos = self.CustomModel.CSModelPosition
bone = self.Owner:GetViewModel():LookupBone("ValveBiped.Crossbow_base")
pos, ang = Vector(0,0,0), Angle(0,0,0)
if (!bone) then return end
local m = self.Owner:GetViewModel():GetBoneMatrix(bone)
if (m) then
ViewModelPos, ang = m:GetTranslation(), m:GetAngles()
end
local up = ang:Up()
local right = ang:Right()
local forward = ang:Forward()
local worthposition = ViewModelPos + ang:Forward() * CSModelPos.x + ang:Right() * CSModelPos.y + ang:Up() * CSModelPos.z
if CSModelAng then
ang:RotateAroundAxis (ang:Right(),         CSModelAng.x)
ang:RotateAroundAxis (ang:Up(),         CSModelAng.y)
ang:RotateAroundAxis (ang:Forward(),     CSModelAng.z)
end
self.CSModelGet:SetPos(worthposition)
self.CSModelGet:SetAngles(ang)
self.CSModelGet.IsBoltBow = true
local normal = -self.CSModelGet:GetUp()
local position = normal:Dot( self.CSModelGet:GetPos() + self.CSModelGet:GetUp()*5 )
local oldEC = render.EnableClipping( true )
render.PushCustomClipPlane( normal, position )
self.CSModelGet:DrawModel()
render.PopCustomClipPlane()
render.EnableClipping( oldEC )
end
if !IsValid(self.CSModelGet2) then
-- CSModel
local CSModelSinth = ClientsideModel(self.CustomModel.CSModel2,RENDER_GROUP_VIEW_MODEL_OPAQUE)
CSModelSinth:SetParent(self)
CSModelSinth:SetSequence(1)
CSModelSinth:SetNoDraw(true)
self.CSModelGet2 = CSModelSinth
else
local CSModelAng = self.CustomModel.CSModelAngle2
local CSModelPos = self.CustomModel.CSModelPosition2
bone = self.Owner:GetViewModel():LookupBone("ValveBiped.bolt")
pos, ang = Vector(0,0,0), Angle(0,0,0)
if (!bone) then return end
local m = self.Owner:GetViewModel():GetBoneMatrix(bone)
if (m) then
ViewModelPos, ang = m:GetTranslation(), m:GetAngles()
end
local up = ang:Up()
local right = ang:Right()
local forward = ang:Forward()
local worthposition = ViewModelPos + ang:Forward() * CSModelPos.x + ang:Right() * CSModelPos.y + ang:Up() * CSModelPos.z
if CSModelAng then
ang:RotateAroundAxis (ang:Right(),         CSModelAng.x)
ang:RotateAroundAxis (ang:Up(),         CSModelAng.y)
ang:RotateAroundAxis (ang:Forward(),     CSModelAng.z)
end
self.CSModelGet2:SetPos(worthposition)
self.CSModelGet2:SetAngles(ang)
self.CSModelGet2:SetSkin(1)
render.SetColorModulation(1, 1, 1)
render.SetBlend(1)
self.CSModelGet2:DrawModel()
render.SetBlend(1)
render.SetColorModulation(1, 1, 1)
end
end