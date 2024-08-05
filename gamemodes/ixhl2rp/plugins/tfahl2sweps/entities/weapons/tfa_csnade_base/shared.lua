--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

SWEP.Base = "tfa_csgo_base"

DEFINE_BASECLASS(SWEP.Base)

SWEP.NoStattrak = true
SWEP.NoNametag = true

SWEP.MuzzleFlashEffect = ""
SWEP.data = {}
SWEP.data.ironsights = 0

SWEP.Delay = 0.1 -- Delay to fire entity
SWEP.Delay_Underhand = 0.1 -- Delay to fire entity
SWEP.Primary.Round = ("") -- Nade Entity
SWEP.Velocity = 550 -- Entity Velocity

SWEP.Underhanded = false

function SWEP:Initialize()
	self.ProjectileEntity = self.ProjectileEntity or self.Primary.Round --Entity to shoot
	self.ProjectileVelocity = self.Velocity and self.Velocity or 550 --Entity to shoot's velocity
	self.ProjectileModel = nil --Entity to shoot's model
	self.ProjectileAngles = nil

	-- copied idea from gauss just because WHY THE FUCK NOT
	self.GetNW2Bool = self.GetNW2Bool or self.GetNWBool
	self.SetNW2Bool = self.SetNW2Bool or self.SetNWBool

	self:SetNW2Bool("Charging", false)
	self:SetNW2Bool("Ready", false)
	self:SetNW2Bool("Underhanded", false)

	BaseClass.Initialize(self)
end

function SWEP:Deploy()
	if self:Clip1() <= 0 then
		if self:Ammo1() <= 0 then
			timer.Simple(0, function()
				if CLIENT or not IsValid(self) or not self:OwnerIsValid() then return end
				self:GetOwner():StripWeapon(self:GetClass())
			end)
		else
			self:TakePrimaryAmmo(1, true)
			self:SetClip1(1)
		end
	end

	self:SetNW2Bool("Charging", false)
	self:SetNW2Bool("Ready", false)
	self:SetNW2Bool("Underhanded", false)

	self:CleanParticles()
	BaseClass.Deploy(self)
end

function SWEP:ChoosePullAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChoosePullAnim then
		self.Callback.ChoosePullAnim(self)
	end

	self.Owner:SetAnimation(PLAYER_RELOAD)
	--self:ResetEvents()
	local tanim = ACT_VM_PULLPIN
	local success = true
	self:SendViewModelAnim(ACT_VM_PULLPIN)

	if game.SinglePlayer() then
		self:CallOnClient("AnimForce", tanim)
	end

	self.lastact = tanim

	return success, tanim
end

function SWEP:ChooseShootAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChooseShootAnim then
		self.Callback.ChooseShootAnim(self)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	--self:ResetEvents()
	local mybool = self:GetNW2Bool("Underhanded", false)
	local tanim = mybool and ACT_VM_RELEASE or ACT_VM_THROW
	if not self.SequenceEnabled[ACT_VM_RELEASE] then
		tanim = ACT_VM_THROW
	end
	if mybool then
		tanim = ACT_VM_RELEASE
	end
	local success = true
	self:SendViewModelAnim(tanim)

	if game.SinglePlayer() then
		self:CallOnClient("AnimForce", tanim)
	end

	self.lastact = tanim

	return success, tanim
end

function SWEP:CanFire()
	if not self:OwnerIsValid() then return false end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return false end

	--[[
	local vm = self.Owner:GetViewModel()
	local seq = vm:GetSequence()
	local act = vm:GetSequenceActivity(seq)
	if not (act == ACT_VM_DRAW or act == ACT_VM_IDLE) then return false end
	if act == ACT_VM_DRAW and vm:GetCycle() < 0.99 then return false end
	]] -- you see tfa WE DONT NEED THAT OLD CODE ANYMORE

	return not (self:GetNW2Bool("Charging") or self:GetNW2Bool("Ready"))
end

function SWEP:ThrowStart()
	if self:Clip1() > 0 then
		self:ChooseShootAnim()
		self:SetNW2Bool("Ready", false)
		local bool = self:GetNW2Bool("Underhanded", false)

		self:SetStatus(TFA.Enum.STATUS_GRENADE_THROW)
		self:SetStatusEnd(CurTime() + (bool and self.Delay_Underhand or self.Delay))
	end
end

function SWEP:Throw()
	if self:Clip1() > 0 then
		local bool = self:GetNW2Bool("Underhanded", false)
		local ply = self:GetOwner()

		local entity = ents.Create(self:GetStat("Primary.Round"))
		entity:SetOwner(ply)

		if not bool then
			self.ProjectileVelocity = self.Velocity or 550 --Entity to shoot's velocity
			if IsValid(entity) then
				entity:SetPos(ply:GetShootPos() + ply:EyeAngles():Forward() * 16)
				entity:SetAngles(ply:EyeAngles())
				entity:Spawn()
			
				local physObj = entity:GetPhysicsObject()
				if IsValid(physObj) then
					physObj:SetVelocity(ply:GetAimVector() * self.Velocity + Vector(0, 0, 200))
					physObj:AddAngleVelocity(Vector(math.Rand(-750, 750), math.Rand(-750, 750), math.Rand(-750, 750)))
				end
			end
		else
			if self:GetStat("Velocity_Underhand") then
				if IsValid( entity ) then
					entity:SetPos( ply:GetShootPos() + ply:EyeAngles():Forward() * 16 + ply:EyeAngles():Up() * -12 )
					entity:SetAngles( ply:EyeAngles() )
					entity:Spawn()
					entity:GetPhysicsObject():SetVelocity( ply:GetAimVector() * self:GetStat("Velocity_Underhand") + Vector( 0, 0, 200 ) )
					entity:GetPhysicsObject():AddAngleVelocity( Vector( math.Rand( -500, 500 ), math.Rand( -500, 500 ), math.Rand( -500, 500 ) ) )
				end
			else
				--self.ProjectileVelocity = (self.Velocity and self.Velocity or 550) / 1.5
				if IsValid( entity ) then
					entity:SetPos( ply:GetShootPos() + ply:EyeAngles():Forward() * 16 )
					entity:SetAngles( ply:EyeAngles() )
					entity:Spawn()
					entity:GetPhysicsObject():SetVelocity( ply:GetAimVector() * self.Velocity + Vector( 0, 0, 200 ) )
					entity:GetPhysicsObject():AddAngleVelocity( Vector( math.Rand( -750, 750 ), math.Rand( -750, 750 ), math.Rand( -750, 750 ) ) )
				end
			end
		end

		self:TakePrimaryAmmo(1)

		self:SetStatus(TFA.Enum.STATUS_GRENADE_READY)
		self:SetStatusEnd(CurTime() + self.OwnerViewModel:SequenceDuration())
		self:SetNextPrimaryFire(self:GetStatusEnd())
	end
end

function SWEP:PrimaryAttack()
	if self:Clip1() > 0 and self:OwnerIsValid() and self:CanFire() then
		self:ChoosePullAnim()
		self:SetStatus(TFA.Enum.STATUS_GRENADE_PULL)
		self:SetStatusEnd(CurTime() + self.OwnerViewModel:SequenceDuration())
		self:SetNW2Bool("Charging", true)
		self:SetNW2Bool("Underhanded", false)
	end
end

function SWEP:SecondaryAttack()
	if self:Clip1() > 0 and self:CanFire() then
		self:ChoosePullAnim()
		self:SetStatus(TFA.Enum.STATUS_GRENADE_PULL)
		self:SetStatusEnd(CurTime() + self.OwnerViewModel:SequenceDuration())
		self:SetNW2Bool("Charging", true)
		self:SetNW2Bool("Ready", false)
		self:SetNW2Bool("Underhanded", true)
	end
end

function SWEP:Reload()
	if self:Clip1() <= 0 and self:CanFire() then
		self:Deploy()
	end
end

function SWEP:ChooseIdleAnim( ... )
	if self:GetNW2Bool("Charging") or self:GetNW2Bool("Ready") then return end
	BaseClass.ChooseIdleAnim(self,...)
end

function SWEP:Think2()
	if SERVER then
		local ct = CurTime()

		if self:GetStatus() == TFA.Enum.STATUS_GRENADE_PULL and ct >= self:GetStatusEnd() then
			self:SetNW2Bool("Charging", false)
			self:SetNW2Bool("Ready", true)
		elseif self:GetStatus() == TFA.Enum.STATUS_GRENADE_THROW and ct >= self:GetStatusEnd() then
			self:Throw()
		elseif self:GetStatus() == TFA.Enum.STATUS_GRENADE_READY and ct >= self:GetStatusEnd() then
			self:Deploy()
		end

		if self:OwnerIsValid() and self:GetOwner():IsPlayer() then -- npc support haHAA
			if self:GetNW2Bool("Charging", false) and not self:GetNW2Bool("Ready", false) then
				if self:GetOwner():KeyDown(IN_ATTACK2) then
					self:SetNW2Bool("Underhanded", true)
				end
			elseif not self:GetNW2Bool("Charging", false) and self:GetNW2Bool("Ready", true) then
				if not self:GetOwner():KeyDown(IN_ATTACK2) and not self:GetOwner():KeyDown(IN_ATTACK) then
					self:ThrowStart()
				end
			end
		end
	end

	return BaseClass.Think2(self)
end

function SWEP:ShootBullet()
	return false -- OMEGALUL
end