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

ENT.Type = "anim"
ENT.PrintName = "Editable Emplacement"
ENT.Category = "Jakub Baku"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.Editable = true

if(CLIENT) then
	ENT.Laser = Material("sprites/bluelaser1")

	function ENT:DrawTranslucent()
		self:DrawModel()

		local gun = self:GetNWEntity("gun")

		if(IsValid(gun)) then
			if(self:GetLaser() && self:GetNWBool("manned", false)) then
				local origin = gun:GetAttachment(self:GetNWInt("attachment")).Pos

				local target = util.TraceLine({
						start = origin,
						endpos = gun:GetForward() * 1000000 * self:GetNWInt("mul", 1) + origin,
						filter = function(e)
							if(e == gun || e == self) then return false else return true end
						end
					}).HitPos

				self:SetRenderBoundsWS(target, self:GetPos(), Vector(20, 20, 20))

				render.SetMaterial(self.Laser)
				render.DrawBeam(origin, target, 16, 0, 0, self:GetLaserColor():ToColor())
			end

			if(self:GetShowAmmo() && self:GetEnableAmmo()) then
				local ang = gun:GetAngles()
				ang:RotateAroundAxis(gun:GetRight(), 90)
				ang:RotateAroundAxis(gun:GetForward(), 90)

				if(self:GetNWInt("mul", 1) < 0) then
					ang:RotateAroundAxis(gun:GetUp(), 180)
				end

				cam.Start3D2D(gun:GetPos() - gun:GetRight() * 13 * self:GetNWInt("mul", 1)  + gun:GetUp() * 10, ang, 0.5)
					draw.SimpleText(self:GetNWInt("ammo", 0))
				cam.End3D2D()
			end
		end
	end
end

function ENT:SetupDataTables()
	/*self:NetworkVar("Int", 6, "Preset", {KeyName = "preset", Edit = { title = "Preset", category = "Preset Bank", type = "Combo", order = 10, values = {
		["Airboat Gun"] = 1,
		["Combine Bunker Gun"] = 2,
		["SMG1"] = 3,
 	}}})*/

	self:NetworkVar("Int", 0, "BulletsPerShot", {KeyName = "numbullets", Edit = { title = "Bullets per shot", category = "Basics", type = "Int", order = 20, min = 1, max = 10}})
	self:NetworkVar("Int", 1, "BulletDamage", {KeyName = "dmgbullet", Edit = { title = "Bullet Damage", category = "Basics", type = "Int", order = 30, min = 0, max = 50}})

	self:NetworkVar("Int", 6, "ProjType", {KeyName = "projtype", Edit = { title = "Projectile", category = "Basics", type = "Combo", order = 10, values = {
		["Bullet"] = 1,
		["Flechette"] = 2,
		["SMG Grenade"] = 3,
		["Rocket"] = 4,
		["Homing Rocket"] = 5,
		["Physics Prop"] = 6
	}}})

	self:NetworkVar("Int", 2, "DmgTypeBullet", {KeyName = "dmgbullettype", Edit = { title = "Damage type", category = "Advanced", type = "Combo", order = 80, values = {
		["Airboat"] = DMG_AIRBOAT,
		["Bullet"] = DMG_BULLET,
		["Energy"] = DMG_ENERGYBEAM,
		["Burn"] = DMG_BURN,
		["Explosion"] =  DMG_BLAST,
		["Dissolve"] =  DMG_DISSOLVE
	}}})
	self:NetworkVar("Int", 3, "MuzzleEffect", {KeyName = "muzzleeffect", Edit = { title = "Muzzle Effect", category = "Advanced", type = "Combo", order = 90, values = {
		["Airboat Gun"] = 3,
		["Chopper"] = 2,
		["Gunship"] = 1,
		["Counter Strike X"] = 6,
		["HL2 Default"] =  4,
		["Counter Strike"] =  5,
		["Strider"] =  7
	}}})

	self:NetworkVar("Int", 4, "Tracer", {KeyName = "tracereffect", Edit = { title = "Tracer Effect", category = "Advanced", type = "Combo", order = 100, values = {
		["AR2"] = 1,
		["Chopper"] = 2,
		["Airboat Gun"] = 3,
		["Combine laser"] = 5,
		["HL2 Default"] = 8,
		["Toolgun"] = 9
 	}}})

 	self:NetworkVar("Int", 5, "Impact", {KeyName = "impacteffect", Edit = { title = "Impact Effect", category = "Advanced", type = "Combo", order = 110, values = {
		["Stunstick"] = 1,
		["Crossbow Bolt"] = 2,
		["Manhack Sparks"] = 3,
		["Helicopter Bomb Explosion"] = 4,
		["AR2"] = 5,
		["Strider Wormhole"] = 6,
		["No effect"] = 0
 	}}})

 	self:NetworkVar("Int", 10, "GunModel", {KeyName = "gunmodel", Edit = { title = "Model", category = "Advanced", type = "Combo", order = 85, values = {
		["Airboat gun"] = 1,
		["Pistol"] = 2,
		["SMG1"] = 3,
		["AR2"] = 4,
		[".357"] = 5,
		["Shotgun"] = 6
  	}}})

	self:NetworkVar("Float", 0, "BulletSpread", {KeyName = "sprdbullet", Edit = { title = "Spread", category = "Basics", type = "Float", order = 40, min = 0, max = 0.2}})
	self:NetworkVar("Float", 1, "BulletForce", {KeyName = "frcbullet", Edit = { title = "Force", category = "Basics", type = "Float", order = 50, min = 0, max = 10}})
	self:NetworkVar("Float", 6, "GunInertia", {KeyName = "inertia", Edit = { title = "Gun's Weight", category = "Basics", type = "Float", order = 51, min = 0.05, max = 1}})
	self:NetworkVar("Float", 5, "GunKick", {KeyName = "kick", Edit = { title = "Gun's Recoil", category = "Basics", type = "Float", order = 52, min = 0.01, max = 5}})
	self:NetworkVar("Float", 2, "ShootDelay", {KeyName = "shootdelay", Edit = { title = "Delay", category = "Basics", type = "Float", order = 60, min = 0.05, max = 2}})
	self:NetworkVar("Float", 3, "PropVel", {KeyName = "propvelocity", Edit = { title = "Prop's Velocity", category = "Physics Prop", type = "Float", order = 79, min = 0, max = 100000}})
	self:NetworkVar("Float", 4, "FlareScale", {KeyName = "flarescale", Edit = { title = "Flare size", category = "Misc", type = "Float", order = 160, min = 1, max = 40}})

	self:NetworkVar("String", 0, "ShootSound", {KeyName = "shootsnd", Edit = { title = "Shoot Sound", category = "Basics", type = "Generic", order = 70}})
	self:NetworkVar("String", 3, "LastSound", {KeyName = "lastsnd", Edit = { title = "Last shoot Sound", category = "Basics", type = "Generic", order = 72}})
	self:NetworkVar("Bool", 1, "SndLoop", {KeyName = "sndloop", Edit = {title = "Loop the sound", category = "Basics", type = "Boolean", order = 71}})
	self:NetworkVar("String", 1, "ImpactSound", {KeyName = "impactsnd", Edit = { title = "Impact Sound", category = "Basics", type = "Generic", order = 73}})
	self:NetworkVar("String", 2, "PropModel", {KeyName = "propmodel", Edit = { title = "Prop Model", category = "Physics Prop", type = "Generic", order = 78}})

	self:NetworkVar("Bool", 7, "EmitShells", {KeyName = "shlemit", Edit = {title = "Emit shells", category = "Basics", type = "Boolean", order = 74}})
	self:NetworkVar("Bool", 0, "Immolate", {KeyName = "shouldimmolate", Edit = {title = "Immolate on Kill", category = "Advanced", type = "Boolean", order = 120}})
	self:NetworkVar("Bool", 2, "Laser", {KeyName = "laserenable", Edit = {title = "Laser sight", category = "Misc", type = "Boolean", order = 130}})
	self:NetworkVar("Bool", 3, "Flare", {KeyName = "flareenable", Edit = {title = "Enable Flare (Right Click)", category = "Misc", type = "Boolean", order = 150}})
	self:NetworkVar("Vector", 0, "LaserColor", {KeyName = "lasercolor", Edit = {title = "Laser color", category = "Misc", type = "VectorColor", order = 140}})

	self:NetworkVar("Bool", 4, "EnableAmmo", {KeyName = "enableammo", Edit = {title = "Enable ammo", category = "Ammo & Regen", type = "Boolean", order = 170}})
	self:NetworkVar("Bool", 6, "RegenAmmo", {KeyName = "rgnammo", Edit = {title = "Regenerate ammo", category = "Ammo & Regen", type = "Boolean", order = 171}})
	self:NetworkVar("Bool", 5, "ShowAmmo", {KeyName = "showammo", Edit = {title = "Show Ammo", category = "Ammo & Regen", type = "Boolean", order = 172}})
	self:NetworkVar("Int", 9, "AmmoEnt", {KeyName = "ammoent", Edit = {title = "Ammo Entity", category = "Ammo & Regen", type = "Combo", order = 173, values = {
		["AR2 Ammo"] = 1,
		[".357 Ammo"] = 2,
		["Pistol Ammo"] = 3,
		["Shotgun Ammo"] = 4,
		["SMG1 Ammo"] = 5,
		["Crossbow Ammo"] = 7,
		["SMG Grenade"] = 6,
		["RPG Rocket"] = 8,
		["Suit Battery"] = 9
	}}})
	self:NetworkVar("Int", 11, "ShellType", {KeyName = "shelltype", Edit = {title = "Shell Type", category = "Basics", type = "Combo", order = 75, values = {
		["Default"] = 1,
		["Rifle"] = 2,
		["Buckshot"] = 3
	}}})
	self:NetworkVar("Int", 7, "AmmoCapacity", {KeyName = "ammocap", Edit = { title = "Ammo Capacity", category = "Ammo & Regen", type = "Int", order = 175, min = 1, max = 100}})
	self:NetworkVar("Int", 8, "AmmoPerShot", {KeyName = "ammopershot", Edit = { title = "Take Ammo per Shot", category = "Ammo & Regen", type = "Int", order = 180, min = 1, max = 10}})
	self:NetworkVar("Float", 7, "RegenDelay", {KeyName = "rgndelay", Edit = { title = "Regen Delay", category = "Ammo & Regen", type = "Float", order = 185, min = 0.01, max = 1}})
	self:NetworkVar("Float", 8, "PostShootDelay", {KeyName = "psrgndelay", Edit = { title = "Post-shoot Regen Delay", category = "Ammo & Regen", type = "Float", order = 190, min = 0, max = 1}})

	self:NetworkVar("Int", 12, "Burst", {KeyName = "burst", Edit = { title = "Rounds per burst", category = "Burst mode", type = "Int", order = 200, min = 0, max = 10}})
	self:NetworkVar("Float", 9, "BurstDelay", {KeyName = "burstdelay", Edit = { title = "Delay between bursts", category = "Burst mode", type = "Float", order = 210, min = 0, max = 4}})
end

if(SERVER) then
	function ENT:Initialize()
		self.Presets = {
			{
				["numbullets"] = 2,
				["dmgbullet"] = 6,
				["dmgbullettype"] = DMG_AIRBOAT,
				["muzzleeffect"] = 3,
				["tracereffect"] = 3,
				["impacteffect"] = 5,
				["sprdbullet"] = 0.00,
				["frcbullet"] = 3,
				["shootdelay"] = 0.07,
				["shootsnd"] = "Weapon_AR2.NPC_Single"
			},
			{
				["numbullets"] = 1,
				["dmgbullet"] = 6,
				["dmgbullettype"] = DMG_BULLET,
				["muzzleeffect"] = 3,
				["tracereffect"] = 1,
				["impacteffect"] = 5,
				["sprdbullet"] = 0.03,
				["frcbullet"] = 3,
				["shootdelay"] = 0.07,
				["shootsnd"] = "Weapon_AR2.NPC_Single"
			}
		}

		self.Shells = {
			"ShellEject",
			"RifleShellEject",
			"ShotgunShellEject"
		}

		self.Models = {
			{"models/airboatgun.mdl", false},
			{"models/weapons/w_pistol.mdl", true}, 
			{"models/weapons/w_smg1.mdl",false},
			{"models/weapons/w_irifle.mdl",true},
			{"models/weapons/w_357.mdl",false},
			{"models/weapons/w_shotgun.mdl", true}
		}

		self.AmmoEntities = {
			{"item_ammo_ar2", 30, 1, "models/items/combine_rifle_cartridge01.mdl"}, {"item_ammo_357", 8, 1, "models/items/357ammo.mdl"}, {"item_ammo_pistol", 15, 1, "models/items/boxsrounds.mdl"}, {"item_box_buckshot", 12, 1, "models/items/boxbuckshot.mdl"}, {"item_ammo_smg1", 35, 1, "models/items/boxmrounds.mdl"}, {"item_ammo_smg1_grenade", 1, 1, "models/items/ar2_grenade.mdl"}, {"item_ammo_crossbow", 3, 1, "models/items/crossbowrounds.mdl"},
			{"item_rpg_round", 1, 1, "models/weapons/w_missile_closed.mdl"}, {"item_battery", 40, 2, "models/items/battery.mdl"}
		}

		self.PickupSounds = {"items/ammo_pickup.wav", "items/battery_pickup.wav"}

		util.PrecacheModel("models/airboatgun.mdl")

		self:SetModel("models/airboatgun_stand.mdl")
		local min = Vector(-1, -1, 0) * 8
		local max = Vector(1, 1, 1) * 8

		self:PhysicsInitBox(min, max)

		self.UseTimer = 0
		self.ShootTimer = 0
		self.FlareTimer = 0
		self.RegenTimer = 0
		self.BurstTimer = 0
		self.Mul = 1
		self.Burst = 0
		self.IsBursting = false

		self.LerpTime = 0
		self.NewAng = Angle(0, 0, 0)
		self.OldAng = Angle(0, 0, 0)

		self.LastWeapon = nil
		self.SndPlaying = false
		self.LoopSound = nil

		self.VehicleMode = false
		self.Vehicle = nil

		self:SetBulletsPerShot(2)
		self:SetBulletDamage(3)
		self:SetBulletSpread(0.03)
		self:SetBulletForce(0.3)
		self:SetShootDelay(0.075)
		self:SetShootSound("Weapon_AR2.NPC_Single")
		self:SetDmgTypeBullet(DMG_BULLET)
		self:SetMuzzleEffect(3)
		self:SetTracer(1)
		self:SetImpact(5)
		self:SetProjType(1)
		self:SetPropModel("models/props_c17/oildrum001_explosive.mdl")
		self:SetPropVel(1000)
		self:SetSndLoop(false)
		self:SetLastSound("Airboat.FireGunRevDown")
		self:SetLaserColor(Vector(255, 0, 0))
		self:SetFlareScale(10)
		self:SetGunInertia(0.1)
		self:SetEnableAmmo(false)
		self:SetRegenDelay(0.05)
		self:SetAmmoPerShot(1)
		self:SetAmmoCapacity(100)
		self:SetAmmoEnt(1)
		self:SetGunModel(1)
		self:SetShellType(1)

		self.Gun = ents.Create("prop_dynamic")
		self.Gun:SetModel(self.Models[1][1])
		self.Gun:SetPos(self:GetPos() + self:GetUp() * 10)
		self.Gun:SetAngles(self:GetAngles())
		self.Gun:Spawn()
		self.Gun:SetParent(self)

		self.Attachment = self.Gun:LookupAttachment("muzzle")
		self:SetNWInt("attachment",self.Attachment)

		self:SetNWEntity("gun", self.Gun) 

		self.Ammo = 100
		self:SetNWInt("ammo", self.Ammo)

		self.InfoTarget = ents.Create("info_target")
		self.InfoTarget:SetPos(self:GetPos())

		self.Impacts = {
			"StunstickImpact",
			"BoltImpact",
			"ManhackSparks",
			"HelicopterMegaBomb",
			"AR2Impact",
			"effect_combine_destruction"
		}

		self.Muzzles = {
			"GunshipMuzzleFlash",
			"ChopperMuzzleFlash",
			"AirboatMuzzleFlash",
			"MuzzleEffect",
			"CS_MuzzleFlash",
			"CS_MuzzleFlash_X",
			"StriderMuzzleFlash",
			"effect_combine_muzzle"
		}

		self.Tracers = {
			"AR2Tracer",
			"HelicopterTracer",
			"AirboatGunTracer",
			"GaussTracer",
			"effect_combine_tracer",
			"effect_combine_tracker",
			"GunshipTracer",
			"Tracer",
			"ToolTracer"
		}

		self:NetworkVarNotify("SndLoop", self.NotifyOnVar)
		self:NetworkVarNotify("ShootSound", self.NotifyOnVar)
		self:NetworkVarNotify("AmmoCapacity", self.NotifyOnVar)
		self:NetworkVarNotify("EnableAmmo", self.NotifyOnVar)
		self:NetworkVarNotify("GunModel", self.NotifyOnVar)
	end

	function ENT:NotifyOnVar(name, old, new)
		if(name == "SndLoop") then
			if(!old && new) then
				self.LoopSound = CreateSound(self, self:GetShootSound())
				self.SndPlaying = false
			elseif(old && !new) then
				self.LoopSound:Stop()
				self.SndPlaying = false
			end
		elseif(name == "ShootSound" && self:GetSndLoop()) then
			self.LoopSound:Stop()
			self.LoopSound = CreateSound(self, new)
			self.SndPlaying = false
		elseif(name == "AmmoCapacity") then
			self.Ammo = math.min(self.Ammo, new)
			self:SetNWInt("ammo", self.Ammo)
		elseif(name == "EnableAmmo") then
			self.Ammo = self:GetAmmoCapacity()
			self:SetNWInt("ammo", self.Ammo)
		elseif(name == "GunModel") then
			self.Gun:SetModel(self.Models[new][1])

			self.Attachment = self.Gun:LookupAttachment("muzzle")
			self:SetNWInt("attachment",self.Attachment)

			if(self.Models[new][2]) then
				self.Mul = -1
				self:SetNWInt("mul", -1)
			else
				self.Mul = 1
				self:SetNWInt("mul", 1)
			end
		end
	end

	function ENT:StopTheSound()
		if(!self:GetSndLoop()) then return end
		self.LoopSound:Stop()
		self.SndPlaying = false
	end

	function ENT:Think()
		if(IsValid(self.User)) then
			if(IsValid(self.User:GetActiveWeapon())) then
				self.LastWeapon = self.User:GetActiveWeapon()
				self.User:SetActiveWeapon(nil)
			end

			//self.Gun:SetPos(self:GetPos() + self:GetUp() * 10)
			local topoint
			local trace
			if(self.VehicleMode) then
				trace = util.TraceLine({
					start = self.User:EyePos(),
					endpos = self.User:GetAimVector() * 1000000,
					filter = function(ent)
						if(ent == self.User:GetVehicle()) then return false else return true end
					end
				})
				topoint = trace.HitPos - self.Gun:GetAttachment(self.Attachment).Pos
				topoint = topoint * self.Mul
			else
				trace = self.User:GetEyeTrace()
				topoint = trace.HitPos - self.Gun:GetAttachment(self.Attachment).Pos
				topoint = topoint * self.Mul
			end

			self.InfoTarget:SetPos(trace.HitPos)

			if(self.LerpTime < CurTime()) then
				self.OldAng = self.NewAng
				self.NewAng = topoint:Angle()

				self.LerpTime = CurTime() + math.max(self:GetGunInertia(), 0.05)
			end

			if(topoint:DistToSqr(Vector(0, 0, 0)) > 1900) then
				local lerped = LerpAngle((self.LerpTime - CurTime()) / math.max(self:GetGunInertia(), 0.05), self.NewAng, self.OldAng)

				self.Gun:SetAngles( lerped )
			end

			if(self.ShootTimer < CurTime() && (self.User:KeyDown(IN_ATTACK) || self.IsBursting) && (self.BurstTimer < CurTime() || self:GetBurst() < 1)) then
				if(!(self:GetEnableAmmo() && self.Ammo < self:GetAmmoPerShot())) then
					if(!self:GetSndLoop()) then
						self:EmitSound(self:GetShootSound())
					elseif(!self.SndPlaying) then
						self.SndPlaying = true
						self.LoopSound:Play()
					end

					if(self.Burst + 1 >= self:GetBurst()) then
						self.Burst = 0
						self.BurstTimer = CurTime() + self:GetBurstDelay()
						self.IsBursting = false
					else
						self.Burst = self.Burst + 1
						self.IsBursting = true
					end

					if(self:GetEmitShells()) then
						local shang = self.Gun:GetAngles()
						shang:RotateAroundAxis(self.Gun:GetUp(), -90)
						local eff = EffectData()
						eff:SetOrigin(self.Gun:GetPos())
						eff:SetAngles(shang)

						util.Effect(self.Shells[self:GetShellType()], eff)
					end

					self.Ammo = self.Ammo - self:GetAmmoPerShot()
					self:SetNWInt("ammo", self.Ammo)

					self.RegenTimer = CurTime() + self:GetPostShootDelay()

					self.NewAng.x = self.NewAng.x - self:GetGunKick()//self:GetGunInertia()
				
					local bullet = {} 
						bullet.Num = math.min(self:GetBulletsPerShot(), 10)
						bullet.Src = self.Gun:GetAttachment(1).Pos + self.Gun:GetForward() * 20 * self.Mul * self:GetVelocity():Length() * 0.01
						bullet.Dir = self.Gun:GetForward() * self.Mul
						bullet.Spread = Vector(1, 1, 1) * self:GetBulletSpread()
						bullet.Tracer = 1 
						bullet.Force = self:GetBulletForce()
						bullet.Damage = math.min(self:GetBulletDamage(), 50)
						bullet.AmmoType = "Pistol"
						bullet.TracerName = self.Tracers[self:GetTracer()]
						bullet.Attacker = self.User
						bullet.Callback = function ( attacker, tr, dmginfo ) 
										dmginfo:SetDamageType(self:GetDmgTypeBullet())

										if(self:GetImpact() != 0) then
											local eff = EffectData()
											eff:SetOrigin(tr.HitPos)
											eff:SetNormal(tr.HitNormal)
											//eff:SetScale( 1 )

											util.Effect( self.Impacts[self:GetImpact()], eff)
										end

										if(self:GetImmolate()) then
											for k, v in pairs(ents.FindInSphere(tr.HitPos, 10 )) do
												if((v:IsNPC() || v:IsPlayer()) && v:Health() <= self:GetBulletDamage()) then
													v:SetName("to_dissolve")
													local dis = ents.Create("env_entity_dissolver")
													dis:Spawn()
													dis:SetKeyValue("target", "to_dissolve")
													dis:SetKeyValue("dissolvetype", "2")
													dis:Fire("Dissolve", "", "")
													dis:Remove()
												end
											end
										end

										sound.Play(self:GetImpactSound(), tr.HitPos, 100)
									end

					
					if(self:GetProjType() == 1) then
						self.Gun:FireBullets(bullet)
					else
						local spread = (bullet.Dir + VectorRand() * self:GetBulletSpread())

						if(self:GetProjType() == 2) then
							
							local flech = ents.Create("hunter_flechette")
							flech:SetPos(bullet.Src)
							flech:SetAngles(spread:Angle())
							flech:SetOwner(self.User)
							flech:Spawn()
							flech:SetVelocity(spread * 3000)

						elseif(self:GetProjType() == 3) then

							local ssbolt = ents.Create("grenade_ar2")
							ssbolt:SetPos(bullet.Src)
							ssbolt:SetAngles(spread:Angle())
							ssbolt:SetOwner(self.User)
							ssbolt:Spawn()
							ssbolt:SetVelocity(spread * 3000)
						elseif(self:GetProjType() == 4) then
							local ssbolt = ents.Create("entity_tank_rocket")
							ssbolt:SetPos(bullet.Src)
							ssbolt:SetAngles(spread:Angle())
							ssbolt:Spawn()
							ssbolt:GetPhysicsObject():SetVelocity(spread * 300)
							ssbolt.Owner = self.User
							ssbolt.TargetAng = (self.Gun:GetForward() * self.Mul):Angle()
							ssbolt.GraceTime = 0.1
						elseif(self:GetProjType() == 5) then
							local ssbolt = ents.Create("entity_tank_rocket")
							ssbolt:SetPos(bullet.Src)
							ssbolt:SetAngles(spread:Angle())
							ssbolt:Spawn()
							ssbolt:GetPhysicsObject():SetVelocity(spread * 300)
							ssbolt.Owner = self.User

							if(false && (trace.Entity:IsNPC() || trace.Entity:IsPlayer())) then
								ssbolt.Target = trace.Entity
								local min, max = trace.Entity:GetCollisionBounds()
								ssbolt.Offset = max / 2
							else
								ssbolt.Target = self.InfoTarget
							end
						else

							local prop = ents.Create("prop_physics")
							prop:SetModel(self:GetPropModel())
							prop:SetPos(bullet.Src + spread * 10)
							prop:SetAngles(spread:Angle()) 
							prop:SetOwner(self.User)
							prop:Spawn()
							prop:Fire("Kill", "", 10)
							prop:GetPhysicsObject():SetVelocity(spread * self:GetPropVel())
						end
					end

					local muzzle = EffectData()
					muzzle:SetOrigin(self.Gun:GetAttachment(1).Pos)
					muzzle:SetEntity( self.Gun )
					muzzle:SetAngles( self.Gun:GetAttachment(1).Ang )
					muzzle:SetAttachment( 1 )
					muzzle:SetScale( 1 )

					util.Effect( self.Muzzles[self:GetMuzzleEffect()], muzzle)

					self.ShootTimer = CurTime() + math.max(0.05, math.min(self:GetShootDelay(), 10))
				else
					self:EmitSound("Weapon_Pistol.Empty")

					self.ShootTimer = CurTime() + 0.3

					if(self.SndPlaying) then
						self:StopTheSound()
						self:EmitSound(self:GetLastSound())
					end
				end

				
			elseif(!self.User:KeyDown(IN_ATTACK)) then
				if(self.SndPlaying) then
					self:StopTheSound()
					self:EmitSound(self:GetLastSound())
				end

				if(self.User:KeyDown(IN_ATTACK2) && self:GetFlare()) then
					if(!self.FlareShot && self.FlareTimer < CurTime()) then
						self.FlareShot = true
						self.FlareTimer = CurTime() + 1

						local flech = ents.Create("env_flare")
							flech:SetPos(self.Gun:GetAttachment(1).Pos)
							flech:SetAngles(self.Gun:GetAttachment(1).Ang)
							flech:SetOwner(self.User)
							flech:SetKeyValue( "scale", self:GetFlareScale() )
							flech:Spawn()
							flech:Activate()

							self:EmitSound("Weapon_IRifle.Single")
							
							flech:Fire("Launch", "3000", 0)
							flech:Fire("Start", "30", 0.3)
					end
				else
					self.FlareShot = false
				end

				if(self.RegenTimer < CurTime() && self.Ammo < self:GetAmmoCapacity() && self:GetRegenAmmo()) then
					self.Ammo = self.Ammo + 1
					self:SetNWInt("ammo", self.Ammo)

					self.RegenTimer = CurTime() + self:GetRegenDelay()
				end
			end

			local tobarrel = self.Gun:GetAttachment(1).Pos - self.User:EyePos()
			tobarrel:Normalize()

			if((self.User:GetPos():DistToSqr(self:GetPos()) > 10000 || !self.User:Alive() || (tobarrel:Dot(self.User:GetAimVector()) < 0.5 && false)) && !self.VehicleMode) then
				self:EmitSound("weapons/shotgun/shotgun_cock.wav")
				self.User:SetActiveWeapon(self.LastWeapon)
				self.User.IsManningTheGun = false
				self:SetNWBool("manned", false)
				self.User = nil
				self.UseTimer = CurTime() + 0.5

				self:StopTheSound()

			end

			self:NextThink(CurTime())
			return true
		end
	end

	function ENT:Use(ply)
		if(self.UseTimer < CurTime() && ply:GetPos():DistToSqr(self:GetPos()) < 7000 && !self.VehicleMode) then
			if(self.User == nil && !ply.IsManningTheGun) then
				self:EmitSound("weapons/shotgun/shotgun_cock.wav")
				self.User = ply
				self.LastWeapon = self.User:GetActiveWeapon()
				self.User:SetActiveWeapon(nil)
				self:SetNWBool("manned", true)

				self.UseTimer = CurTime() + 1
				self.User.IsManningTheGun = true
			elseif(ply == self.User) then
				self:EmitSound("weapons/shotgun/shotgun_cock.wav")
				self.User:SelectWeapon(self.LastWeapon:GetClass() or "weapon_crowbar")
				self.User.IsManningTheGun = false
				self.User = nil
				self:SetNWBool("manned", false)

				self.UseTimer = CurTime() + 1
			end
		end
	end

	function ENT:OnRemove()
		if(IsValid(self.LastWeapon) && IsValid(self.User)) then
			self.User:SetActiveWeapon(self.LastWeapon)
			self.User.IsManningTheGun = false
		end

		if(self.SndPlaying) then
			self.LoopSound:Stop()
		end

		self.InfoTarget:Remove()
	end

	function ENT:PhysicsCollide(data, col)
		if(string.find(data.HitEntity:GetClass(), self.AmmoEntities[self:GetAmmoEnt()][1]) != nil || (data.HitEntity:GetClass() == "prop_physics" && data.HitEntity:GetModel() == self.AmmoEntities[self:GetAmmoEnt()][4])) then
			local bonus = 0

			if(string.find(data.HitEntity:GetClass(), "_large") != nil) then
				bonus = math.Round(self.AmmoEntities[self:GetAmmoEnt()][2] * 0.25)
			end

			if(self.Ammo < self:GetAmmoCapacity()) then
				self.Ammo = math.min(self.Ammo + self.AmmoEntities[self:GetAmmoEnt()][2] + bonus, self:GetAmmoCapacity())
				self:SetNWInt("ammo", self.Ammo)

				self:EmitSound(self.PickupSounds[self.AmmoEntities[self:GetAmmoEnt()][3]])

				data.HitEntity:Remove()
			end
		end
	end

	hook.Add("PlayerEnteredVehicle", "entity_tank_editable", function(ply, veh, role)
		for k, v in pairs(constraint.FindConstraints(veh, "Weld")) do
			local ent

			if(v.Ent1:GetClass() == "entity_tank_editable") then
				ent = v.Ent1
			elseif(v.Ent2:GetClass() == "entity_tank_editable") then
				ent = v.Ent2
			else
				continue
			end  

			if(ent.User != nil) then
				ent.User:SetActiveWeapon(ent.LastWeapon)
				ent.User.IsManningTheGun = false

				if(ent:GetSndLoop()) then
					ent.LoopSound:Stop()
				end
			end

			ent:EmitSound("weapons/shotgun/shotgun_cock.wav")
			ent:SetNWBool("manned", true)
			ent.User = ply
			ent.VehicleMode = true
			veh.Turret = ent
			ent.LastWeapon = ply:GetActiveWeapon()
			ent.Vehicle = veh

			break
		end
	end)

	hook.Add("PlayerLeaveVehicle", "entity_tank_editable", function(ply, veh)
		if(veh.Turret != nil) then
			local ent = veh.Turret
			ent:EmitSound("weapons/shotgun/shotgun_cock.wav")
			ent.User.IsManningTheGun = false
			ent.User = nil
			veh.Turret = nil
			ent:SetNWBool("manned", false)
			ent.VehicleMode = false

			if(ent:GetSndLoop()) then 
				ent.LoopSound:Stop()
			end

			ent.Vehicle = nil

			ply:SetActiveWeapon(ent.LastWeapon)
		end
	end)

	duplicator.RegisterEntityClass("entity_tank_editable", function(ply, data)
		data.Gun = nil
		data.User = nil
		data.VehicleMode = false
		
		data.UseTimer = 0
		data.ShootTimer = 0
		data.FlareTimer = 0
		data.RegenTimer = 0
		data.LerpTime = 0
		data.BurstTimer = 0
		data.Burst = 0

		data.SndPlaying = false
		data.LoopSound = nil
		data.Vehicle = nil
		data.InfoTarget = nil
		return duplicator.GenericDuplicatorFunction(ply, data)
	end, "Data")
end