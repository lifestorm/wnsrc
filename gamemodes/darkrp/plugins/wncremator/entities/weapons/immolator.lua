--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


resource.AddFile("materials/effects/muzzleflash2edit.vtf")
resource.AddFile("materials/effects/muzzleflash2edit.vmt")

SWEP.Author	= "Draco_2k"
SWEP.Category = "HL2RP"
SWEP.Purpose = "Set stuff on fire"
SWEP.Instructions = "Left-Click: Fire\nReload: Regenerate Ammunition"
SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

SWEP.ViewModel = "models/weapons/v_physcannon.mdl"
SWEP.WorldModel = ""

SWEP.UseHands = false
SWEP.IsAlwaysRaised = true
SWEP.HoldType = "normal"
SWEP.AnimPrefix	 = "normal"
SWEP.PrintName = "Immolator"
SWEP.DrawAmmo = false	
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize	= 75
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo	= "ar2"
SWEP.Slot = 3
SWEP.SlotPos = 3

SWEP.ReloadDelay = 0

--Precache everything
function SWEP:Precache()
	util.PrecacheSound("ambient/machines/keyboard2_clicks.wav")

	util.PrecacheSound("ambient/machines/thumper_dust.wav")
	util.PrecacheSound("ambient/fire/mtov_flame2.wav")
	util.PrecacheSound("ambient/fire/ignite.wav")

	util.PrecacheSound("vehicles/tank_readyfire1.wav")
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

-- luacheck: globals ACT_VM_FISTS_DRAW ACT_VM_FISTS_HOLSTER
ACT_IDLE = 1

function SWEP:Holster()
	if (!IsValid(self.Owner)) then
		return
	end

	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_IDLE)
	end

	return true
end

function SWEP:ShouldDrawViewModel()
	return false
end

--Primary attack
function SWEP:PrimaryAttack()
	if (SERVER) then
		if (self.Owner:GetAmmoCount("ar2") < 1 or self.ReloadDelay == 1) then
			self:RunoutReload()

			return
		end
	end

	if (self.Owner:GetAmmoCount("ar2") > 0 and self.ReloadDelay == 0) then
		self.Owner:RemoveAmmo(1, self.Weapon:GetSecondaryAmmoType())
		self.Owner:MuzzleFlash()
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.08)

		if (SERVER) then
			local trace = self.Owner:GetEyeTrace()
			local Distance = self.Owner:GetPos():Distance(trace.HitPos)

			if (Distance < 520) then
				--This is how we ignite stuff
				local Ignite = function()
					--Safeguard
					if (!self:IsValid()) then return end

					--Damage things in radius of impact
					local flame = ents.Create("point_hurt")
					flame:SetPos(trace.HitPos)
					flame:SetOwner(self.Owner)
					flame:SetKeyValue("DamageRadius",128)
					flame:SetKeyValue("Damage",4)
					flame:SetKeyValue("DamageDelay",0.32)
					flame:SetKeyValue("DamageType",8)
					flame:Spawn()
					flame:Fire("TurnOn","",0) 
					flame:Fire("kill","",0.72)
					
					if (trace.HitWorld) then
						--Create actual fire - doesn't work very well in practice
						local fire = ents.Create("env_fire")

						fire:SetPos(trace.HitPos + Vector(0, 0, -8))
						fire:SetAngles(Angle(0,0, math.random(-360, 360)))
						fire:SetKeyValue("health", 10)
						fire:SetKeyValue("firesize", math.random(82, 128))
						fire:SetKeyValue("fireattack", tostring(math.random(0.72, 1.32)))
						fire:SetKeyValue("damagescale", 8)
						fire:SetKeyValue("spawnflags","178") --162
						fire:Spawn()
						fire:Activate()
						fire:Fire("StartFire","", 0)

						local nearbystuff = ents.FindInSphere(trace.HitPos, 100)

						for _, stuff in pairs(nearbystuff) do
							if (stuff != self.Owner) then
								if (stuff:GetPhysicsObject():IsValid()) then
									stuff:Ignite(5, 100)
								end
							end
						end
					end

					if (trace.Entity:IsValid()) then
						if (trace.Entity:GetPhysicsObject():IsValid()) then
							trace.Entity:Ignite(5, 100)
						end
					end
				end

				--Ignite stuff; based on how long it takes for flame to reach it
				timer.Simple(Distance/1520, Ignite)
			end
		end
	end
end

--Unused
function SWEP:SecondaryAttack() end

--Play a nice sound on deployment
function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	if (SERVER) then
		self.Owner:EmitSound("ambient/machines/keyboard2_clicks.wav", 42, 100)
	end

	return true
end

--Think function
function SWEP:Think()
	if (SERVER) then
		if (self.Owner:KeyReleased(IN_ATTACK) and (self.Owner:GetAmmoCount("ar2") > 1) and (self.ReloadDelay != 1)) then
			self.Owner:EmitSound("ambient/fire/mtov_flame2.wav", 24, 100)
		end

		if (self.Owner:GetAmmoCount("ar2") > 0 and self.ReloadDelay == 0) then
			if (self.Owner:KeyPressed(IN_ATTACK)) then
				self.Owner:EmitSound("ambient/machines/thumper_dust.wav", 46, 100)
			end
			
			if (self.Owner:KeyDown(IN_ATTACK)) then
				self.Owner:EmitSound("ambient/fire/mtov_flame2.wav", math.random(27, 35), math.random(32, 152))
					
				local trace = self.Owner:GetEyeTrace()
				local flamefx = EffectData()

				flamefx:SetOrigin(trace.HitPos)
				flamefx:SetStart(self.Owner:GetShootPos())
				flamefx:SetAttachment(1)
				flamefx:SetEntity(self.Weapon)

				util.Effect("swep_flamethrower_flame", flamefx, true, true)
			end
		end
	end
end

--Reload function
function SWEP:Reload()
	if (self.Owner:GetAmmoCount("ar2") > 74 or self.ReloadDelay == 1) then return end

	self.ReloadDelay = 1

	if (SERVER) then
		self.Owner:EmitSound("vehicles/tank_readyfire1.wav", 30, 100)
	end

	timer.Simple(1.82, function()
		if (self:IsValid()) then 
			self:ReloadSelf()
		end
	end)
end

--How to reload if running out of ammo
function SWEP:RunoutReload()
	if (self.Owner:GetAmmoCount("ar2") > 74 or self.ReloadDelay == 1) then return end

	self.ReloadDelay = 1

	if (SERVER) then
		self.Owner:EmitSound("ambient/machines/thumper_dust.wav", 48, 100)
		self.Owner:EmitSound("vehicles/tank_readyfire1.wav", 30, 100)
	end

	timer.Simple(1.82, function()
		if (self:IsValid()) then
			self:ReloadSelf()
		end
	end)
end

--Finish reloading
function SWEP:ReloadSelf()
	--Safeguards
	if (!self or !self:IsValid()) then return end

	if (SERVER) then
		local ammo = math.Clamp((75 - self.Owner:GetAmmoCount("ar2")), 0, 75)

		self.Owner:GiveAmmo(ammo, "ar2")
	end

	self.ReloadDelay = 0
	
	if (self.Owner:KeyDown(IN_ATTACK)) then
		if (SERVER) then
			self.Owner:EmitSound("ambient/machines/thumper_dust.wav", 46, 100)
		end
	end
end
