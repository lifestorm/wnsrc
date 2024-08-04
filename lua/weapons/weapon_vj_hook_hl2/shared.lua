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
SWEP.ViewModel					= ""
SWEP.WorldModel					= "models/weapons/w_crowbar.mdl"
SWEP.HoldType 					= "pistol"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.IsVJBaseWeapon				= true
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= math.random(60,77) -- Damage
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

SWEP.BaseCombineHoldType    = false
SWEP.Slash = 1
SWEP.IsCombine              = false
SWEP.CooldownTimer          = false
SWEP.ShowWorldModel         = false
SWEP.WElements = {
	["w_harpoon"] = { type = "Model", model = "models/weapons/w_harpooner.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, -2, 1), angle = Angle(0, 250, 50), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

}
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 0.4 -- Time until it can shoot again after deploying the weapon
SWEP.HasDeploySound				= false -- Does the weapon have a deploy sound?
	-- Reload Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Reload_TimeUntilAmmoIsSet	= 2.1 -- Time until ammo is set to the weapon
SWEP.Reload_TimeUntilFinished	= 3.4 -- How much time until the player can play idle animation, shoot, etc.
SWEP.UseHands				= true
SWEP.ViewModelFOV			= 62
function SWEP:CustomOnThink() 
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
if self.Owner.SquadName == "fish" then
self.Owner.AnimTbl_MeleeAttack = {"swing"}


if self.Owner.FollowingPlayer == false then
self.Owner.AnimTbl_IdleStand = {ACT_IDLE_ANGRY_MELEE}
self.Owner.AnimTbl_Run = {ACT_RUN_CROUCH}

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
self.Owner.ShootDistance = 45
self.Owner.Weapon_FiringDistanceFar = 45
self.Owner.MeleeAttackDistance = 40
self.Owner.DistanceToRunFromEnemy = 20

self.Owner.HasShootWhileMoving = false


self.Owner.MeleeAttackDamage = math.random(60,77)
self.Owner.NextMeleeAttackTime = math.random(0.4,1)

self.Owner.DefaultSoundTbl_MeleeAttack = {"Flesh.ImpactHard"}
self.Owner.DefaultSoundTbl_MeleeAttackMiss = {"WeaponFrag.Roll"}
if CLIENT then
	
		-- // Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels
		
		-- // init view model bone build function
		if IsValid(self.Owner) and self.Owner:IsPlayer() then
		if self.Owner:Alive() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				-- // Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					-- // however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
			
		end
		end
		
	end
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
		if self.Owner:IsNPC() then
			timer.Simple(self.NPC_ExtraFireSoundTime,function()
				if IsValid(self) && IsValid(self.Owner) then
					VJ_EmitSound(self.Owner,self.NPC_ExtraFireSound,self.NPC_ExtraFireSoundLevel,math.Rand(self.NPC_ExtraFireSoundPitch1,self.NPC_ExtraFireSoundPitch2))
				end
			end)
		end
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
			self.Owner.Weapon_ShotsSinceLastReload = self.Owner.Weapon_ShotsSinceLastReload + 1
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



function SWEP:DrawWorldModel()
	local offset, rotate
if not IsValid( self.Owner ) then
self:DrawModel( )
return
end


	
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			-- // when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				-- //model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			-- // Technically, if there exists an element with the same name as a bone
			-- // you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r --// Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		-- // Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				-- // make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			-- // !! WORKAROUND !! --//
			-- // We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			//!! ----------- !! --
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				-- // !! WORKAROUND !! --//
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				//!! ----------- !! --
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end
	
function table.FullCopy( tab )

if (!tab) then return nil end

local res = {}
for k, v in pairs( tab ) do
if (type(v) == "table") then
res[k] = table.FullCopy(v) // recursion ho!
elseif (type(v) == "Vector") then
res[k] = Vector(v.x, v.y, v.z)
elseif (type(v) == "Angle") then
res[k] = Angle(v.p, v.y, v.r)
else
res[k] = v
end
end

return res

end