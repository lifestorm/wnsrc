--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

DEFINE_BASECLASS("tfa_bash_base")

SWEP.Type = "Melee"

SWEP.LuaShellEject = false

SWEP.Primary.Blunt = false
SWEP.Primary.Damage = 60
SWEP.Primary.Reach = 75
SWEP.Primary.RPM = 60
SWEP.Primary.SoundDelay = 0.2
SWEP.Primary.Delay = 0.35
SWEP.Primary.Window = 0.3

SWEP.Secondary.Blunt = false
SWEP.Secondary.RPM = 45 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 120
SWEP.Secondary.Reach = 70
SWEP.Secondary.SoundDelay = 0.05
SWEP.Secondary.Delay = 0.25

SWEP.Secondary.BashDamage = 25
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashLength = 65
SWEP.Secondary.BashDamageType = DMG_CLUB

SWEP.DisableChambering = true
SWEP.Primary.Motorized = false
SWEP.Primary.Motorized_ToggleBuffer = 0.1 --Blend time to idle when toggling
SWEP.Primary.Motorized_ToggleTime = 1.5 --Time until we turn on/off, independent of the above
SWEP.Primary.Motorized_IdleSound = Sound("Weapon_Chainsaw.IdleLoop") --Idle sound, when on
SWEP.Primary.Motorized_SawSound = Sound("Weapon_Chainsaw.SawLoop") --Rev sound, when on
SWEP.Primary.Motorized_AmmoConsumption_Idle = 100/120 --Ammo units to consume while idle
SWEP.Primary.Motorized_AmmoConsumption_Saw = 100/15 --Ammo units to consume while sawing
SWEP.Primary.Motorized_RPM = 600
SWEP.Primary.Motorized_Damage = 100 --DPS
SWEP.Primary.Motorized_Reach = 60 --DPS

SWEP.Slot = 0
SWEP.DrawCrosshair = false

SWEP.AnimSequences = {
	attack_quick = "Attack_Quick",
	--attack_quick2 = "Attack_Quick2",
	charge_begin = "Attack_Charge_Begin",
	charge_loop = "Attack_Charge_Idle",
	charge_end = "Attack_Charge_End",
	turn_on = "TurnOn",
	turn_off = "TurnOff",
	idle_on = "IdleOn",
	attack_enter = "Idle_To_Attack",
	attack_loop = "Attack_On",
	attack_exit = "Attack_To_Idle"
}

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.Sound = Sound("Weapon_Melee.FireaxeLight")
SWEP.Primary.HitSound_Flesh = {
	sharp = "Weapon_Melee_Sharp.Impact_Light",
	blunt = "Weapon_Melee_Blunt.Impact_Light"
}
SWEP.Primary.HitSound = {
	sharp = {
		[MAT_CONCRETE] = Sound("Weapon_Melee.Impact_Concrete"),
		[MAT_DIRT] = Sound("Weapon_Melee.Impact_Concrete"),
		[MAT_GRASS] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_SNOW] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_SAND] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_METAL] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_VENT] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_CLIP] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_COMPUTER] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_WOOD] = Sound("Weapon_Melee.Impact_Wood"),
		[MAT_WARPSHIELD] = "",
		[MAT_DEFAULT] = ""
	},
	blunt = {
		[MAT_CONCRETE] = Sound("Weapon_Melee.Impact_Concrete"),
		[MAT_DIRT] = Sound("Weapon_Melee.Impact_Concrete"),
		[MAT_GRASS] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_SNOW] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_SAND] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_METAL] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_VENT] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_CLIP] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_COMPUTER] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_WOOD] = Sound("Weapon_Melee.Impact_Wood"),
		[MAT_WARPSHIELD] = "",
		[MAT_DEFAULT] = ""
	}
}

SWEP.Secondary.Sound = Sound("Weapon_Melee.FireaxeHeavy")
SWEP.Secondary.HitSound_Flesh = {
	sharp = "Weapon_Melee_Sharp.Impact_Heavy",
	blunt = "Weapon_Melee_Blunt.Impact_Heavy"
}
SWEP.Secondary.HitSound = {
	sharp = {
		[MAT_CONCRETE] = Sound("Weapon_Melee.Impact_Concrete"),
		[MAT_DIRT] = Sound("Weapon_Melee.Impact_Concrete"),
		[MAT_GRASS] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_SNOW] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_SAND] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_METAL] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_VENT] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_CLIP] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_COMPUTER] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_WOOD] = Sound("Weapon_Melee.Impact_Wood"),
		[MAT_WARPSHIELD] = "",
		[MAT_DEFAULT] = ""
	},
	blunt = {
		[MAT_CONCRETE] = Sound("Weapon_Melee.Impact_Concrete"),
		[MAT_DIRT] = Sound("Weapon_Melee.Impact_Concrete"),
		[MAT_GRASS] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_SNOW] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_SAND] = Sound("Weapon_Melee.Impact_Generic"),
		[MAT_METAL] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_VENT] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_CLIP] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_COMPUTER] = Sound("Weapon_Melee.Impact_Metal"),
		[MAT_WOOD] = Sound("Weapon_Melee.Impact_Wood"),
		[MAT_WARPSHIELD] = "",
		[MAT_DEFAULT] = ""
	}
}


SWEP.InspectPos = Vector(4.84, 1.424, -3.131)
SWEP.InspectAng = Vector(17.086, 3.938, 14.836)

SWEP.IronSightsPos = Vector()
SWEP.IronSightsAng = Vector()

SWEP.Secondary.IronFOV = 90

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, Hybrid = stop mdl animation, Lua = hybrid but continue idle
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, Hybrid = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH

SWEP.RunSightsPos = Vector(0,0,0)
SWEP.RunSightsAng = Vector(0,0,0)

SWEP.data = {}
SWEP.data.ironsights = 0

SWEP.IsKnife = true

DEFINE_BASECLASS("tfa_bash_base")

SWEP.TFA_NMRIH_MELEE = true

SWEP.UseHands = true



SWEP.NextSwingSoundTime = -1
SWEP.NextSwingTime = -1

local stat

function SWEP:Deploy()
	BaseClass.Deploy(self)
	if not self:OwnerIsValid() then return true end
	self.Owner.LastNMRIMSwing = nil
	self.Owner.HasTFANMRIMSwing = false
	return true
end

function SWEP:Holster( ... )
	if not self:OwnerIsValid() then return true end
	self.Owner.LastNMRIMSwing = nil
	self.Owner.HasTFANMRIMSwing = false
	self:StopSound( self.Primary.Motorized_SawSound )
	self:StopSound( self.Primary.Motorized_IdleSound )
	return BaseClass.Holster( self, ... )
end

local IdleStatus = {
	[ TFA.GetStatus("NMRIH_MELEE_CHARGE_LOOP") ] = true,
	[ TFA.GetStatus("NMRIH_MELEE_MOTOR_LOOP") ] = true,
	[ TFA.GetStatus("NMRIH_MELEE_MOTOR_ATTACK") ] = true
}

local OnStatus = {
	[ TFA.GetStatus("NMRIH_MELEE_MOTOR_LOOP") ] = true,
	[ TFA.GetStatus("NMRIH_MELEE_MOTOR_ATTACK") ] = true
}

local TYPE_PRIMARY = 0
local TYPE_SECONDARY = 1
local TYPE_MOTORIZED = 2

SWEP.AmmoDrainDelta = 0

function SWEP:Think2()
	if not self:OwnerIsValid() then return end
	stat = self:GetStatus()
	if self.Primary.Motorized then
		--[[
		if stat == TFA.GetStatus("bashing") and self.GetBashing and self:GetBashing() and CurTime() >= self:GetStatusEnd() and self.reqon then
			stat = TFA.GetStatus("NMRIH_MELEE_MOTOR_LOOP")
			self:SetStatus( stat )
			self:SetStatusEnd( math.huge )
			self:ChooseIdleAnim()
			self:PlayIdleSound( false )
			self:CompleteReload()
		end
		]]--
		if OnStatus[stat] then
			if SERVER then
				self.AmmoDrainDelta = self.AmmoDrainDelta + ( self.Owner:KeyDown(IN_ATTACK) and self.Primary.Motorized_AmmoConsumption_Saw or self.Primary.Motorized_AmmoConsumption_Idle ) * TFA.FrameTime()
				while self.AmmoDrainDelta > 0 do
					self.AmmoDrainDelta = self.AmmoDrainDelta - 1
					self:TakePrimaryAmmo(1)
				end
			end
			if self:Clip1() <= 0 then
				self:TurnOff()
			elseif stat == TFA.GetStatus("NMRIH_MELEE_MOTOR_ATTACK") and CurTime() > self:GetNextPrimaryFire() then
				local ft = 60 / self.Primary.Motorized_RPM
				self:HitThing( self.Primary.Motorized_Damage * ft, self.Primary.Motorized_Damage * 0.2 * ft, self.Primary.Motorized_Reach, false, TYPE_MOTORIZED )
				self:SetNextPrimaryFire( CurTime() + ft )
			end
		end
		if stat == TFA.GetStatus("NMRIH_MELEE_MOTOR_START") and CurTime() > self:GetStatusEnd() then
			stat = TFA.GetStatus("NMRIH_MELEE_MOTOR_LOOP")
			self:SetStatus( stat )
			self:SetStatusEnd( math.huge )
			self:ChooseIdleAnim()
			self:PlayIdleSound( false )
			self:CompleteReload()
		elseif stat == TFA.GetStatus("NMRIH_MELEE_MOTOR_LOOP") and self.Owner:KeyDown(IN_ATTACK) then
			stat = TFA.GetStatus("NMRIH_MELEE_MOTOR_ATTACK")
			self:SetStatus( stat )
			self:SetStatusEnd( math.huge )
			self:SendViewModelSeq(self.AnimSequences.attack_enter)
			self:StopSound(self.Primary.Motorized_IdleSound)
			self.HasPlayedSound[ "idle" ] = false
		elseif stat == TFA.GetStatus("NMRIH_MELEE_MOTOR_ATTACK") and not self.Owner:KeyDown(IN_ATTACK) then
			stat = TFA.GetStatus("NMRIH_MELEE_MOTOR_LOOP")
			self:SetStatus( stat )
			self:SetStatusEnd( math.huge )
			self:SendViewModelSeq(self.AnimSequences.attack_exit)
			self:StopSound(self.Primary.Motorized_SawSound)
			self.HasPlayedSound[ "saw" ] = false
		end
	end
	if stat == TFA.GetStatus("NMRIH_MELEE_CHARGE_START") and CurTime() > self:GetStatusEnd() then
		stat = TFA.GetStatus("NMRIH_MELEE_CHARGE_LOOP")
		self:SetStatus( stat )
		self:SetStatusEnd( math.huge )
		self:ChooseIdleAnim()
	end
	if stat == TFA.GetStatus("NMRIH_MELEE_CHARGE_LOOP") and not self.Owner:KeyDown(IN_ATTACK) then
		stat = TFA.GetStatus("NMRIH_MELEE_CHARGE_END")
		self:SwingThirdPerson()
		self:SendViewModelSeq(self.AnimSequences.charge_end)
		self:SetStatus( stat )
		self:SetStatusEnd( CurTime() + self.OwnerViewModel:SequenceDuration() - 0.3 )
		self.Owner.HasTFANMRIMSwing = false
		self.Owner.LastNMRIMSwing = nil
	end
	BaseClass.Think2(self)

	if game.SinglePlayer() and CLIENT then return end

	self:HandleDelayedAttack( stat )
	if IdleStatus[stat] and CurTime() > self:GetNextIdleAnim() then
		self:ChooseIdleAnim()
	end
end

function SWEP:Reload()
	if not self.Primary.Motorized then return end
	if not self.Owner:KeyPressed(IN_RELOAD) then return end
	stat = self:GetStatus()
	if stat == TFA.GetStatus("IDLE") and ( self:Clip1() > 0 or self:Ammo1() > 0 ) then
		self.reqon = true
		self:SendViewModelSeq(self.AnimSequences.turn_on)
		self:SetStatus( TFA.GetStatus("NMRIH_MELEE_MOTOR_START") )
		self:SetStatusEnd( CurTime() + self.OwnerViewModel:SequenceDuration() - 0.1 )
	elseif stat == TFA.GetStatus("NMRIH_MELEE_MOTOR_LOOP") then
		self:TurnOff()
	end
end

function SWEP:TurnOff()
	self:SendViewModelSeq(self.AnimSequences.turn_off)
	self:SetStatus( TFA.GetStatus("NMRIH_MELEE_MOTOR_END") )
	self:SetStatusEnd( CurTime() + self.OwnerViewModel:SequenceDuration() - 0.1 )
	self:StopSound( self.Primary.Motorized_SawSound )
	self:StopSound( self.Primary.Motorized_IdleSound )
	self.reqon = false
end

SWEP.wassw_old = false
SWEP.wassw_hard_old = false

function SWEP:HandleDelayedAttack( statv )
	stat = statv
	if stat == TFA.GetStatus("NMRIH_MELEE_SWING") then
		if self.wassw_old == false then
			self.NextSwingTime = CurTime() + self.Primary.Delay
			self.NextSwingSoundTime = CurTime() + self.Primary.SoundDelay
		end
		if self.NextSwingTime > 0 and CurTime() > self.NextSwingTime then
			self:HitThing( self.Primary.Damage, self.Primary.Damage * 0.2, self.Primary.Reach, self.Primary.Blunt, TYPE_PRIMARY )
			self.NextSwingTime = -1

			if (SERVER and self.Owner:IsPlayer() and self.Owner.GetCharacter and self.Owner:GetCharacter()) then
				--self.Owner:GetCharacter():DoAction("melee_slash")
			end
		end
		if self.NextSwingSoundTime > 0 and CurTime() > self.NextSwingSoundTime then
			self:EmitSound(self.Primary.Sound)
			self.NextSwingSoundTime = -1
		end
		self.wassw_old = true
	else
		self.wassw_old = false
	end


	if stat == TFA.GetStatus("NMRIH_MELEE_CHARGE_END") then
		if self.wassw_hard_old == false then
			self.NextSwingTime_Hard = CurTime() + self.Secondary.Delay
			self.NextSwingSoundTime_Hard = CurTime() + self.Secondary.SoundDelay
		end
		if self.NextSwingTime_Hard > 0 and CurTime() > self.NextSwingTime_Hard then
			self:HitThing( self.Secondary.Damage, self.Secondary.Damage * 0.2, self.Secondary.Reach, self.Secondary.Blunt, TYPE_SECONDARY )
			self.NextSwingTime_Hard = -1

			if (SERVER and self.Owner:IsPlayer() and self.Owner.GetCharacter and self.Owner:GetCharacter()) then
				--self.Owner:GetCharacter():DoAction("melee_slash_heavy")
			end
		end
		if self.NextSwingSoundTime_Hard > 0 and CurTime() > self.NextSwingSoundTime_Hard then
			self:EmitSound(self.Secondary.Sound)

			if self.Owner.Vox then
				self.Owner:Vox("bash", 4)
			end

			self.NextSwingSoundTime_Hard = -1
		end
		self.wassw_hard_old = true
	else
		self.wassw_hard_old = false
	end
end

function SWEP:PrimaryAttack( release, docharge )
	self:VMIV()
	if (release) then
		if (not docharge) then
			self:Swing()
		else
			self:StartCharge()
		end
	end
end

function SWEP:Swing()
	if (!self:VMIV()) then return end
	if (hook.Run("CanDoMeleeAttack", self) == false) then
		return
	end

	math.randomseed(CurTime() - 1)
	if (self.AnimSequences.attack_quick2 and math.random(0,1) == 0) then
		self:SendViewModelSeq(self.AnimSequences.attack_quick2)
	else
		self:SendViewModelSeq(self.AnimSequences.attack_quick)
	end
	self:SwingThirdPerson()
	self:SetStatus(TFA.GetStatus("NMRIH_MELEE_SWING"))
	self:SetStatusEnd(CurTime() + 60 / self.Primary.RPM)
	self.NeedsHit = true
end

function SWEP:StartCharge()
	if (hook.Run("CanDoHeavyMeleeAttack", self) == false) then
		self.Owner.HasTFANMRIMSwing = false
		self.Owner.LastNMRIMSwing = nil
		return
	end

	self:SendViewModelSeq(self.AnimSequences.charge_begin)
	self:SetStatus( TFA.GetStatus("NMRIH_MELEE_CHARGE_START") )
	self:SetStatusEnd( CurTime() + self.OwnerViewModel:SequenceDuration() - 0.1 )
end

local pos,ang,hull
hull = {}

function SWEP:HitThing( damage, force, reach, blunt, sndtype )
	if not self:OwnerIsValid() then return end
	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()

	local secondary = false
	if sndtype == TYPE_SECONDARY then
		if (hook.Run("CanDoHeavyMeleeAttack", self) == false) then
			return
		end
		secondary = true
	elseif sndtype == TYPE_PRIMARY then
		if (hook.Run("CanDoMeleeAttack", self) == false) then
			return
		end
	end

	self.Owner:LagCompensation(true)

	hull.start = pos
	hull.endpos = pos + (ang * reach)
	hull.filter = self.Owner
	hull.mins = Vector(-5, -5, 0)
	hull.maxs = Vector(5, 5, 5)
	local slashtrace = util.TraceHull(hull)

	self.Owner:LagCompensation(false)

	if slashtrace.Hit then
		if slashtrace.Entity == nil then return end

		if (SERVER and IsValid(slashtrace.Entity) and (slashtrace.Entity:IsPlayer() or slashtrace.Entity:IsNPC())) then
			if (sndtype == TYPE_SECONDARY) then
				self.ixAttackType = "heavy"
			elseif (sndtype == TYPE_PRIMARY) then
				self.ixAttackType = nil
			end
		end

		if game.GetTimeScale() > 0.99 then
			local srctbl = secondary and self.Secondary or self.Primary
			if sndtype == TYPE_MOTORIZED then srctbl = nil end
			self.Owner:FireBullets({
				Attacker = self.Owner,
				Inflictor = self,
				Damage = damage,
				Force = force,
				Distance = reach + 10,
				HullSize = 12.5,
				Tracer = 0,
				Src = self.Owner:GetShootPos(),
				Dir = slashtrace.Normal,
				Callback = function(a, b, c)
					if c then
						if sndtype == TYPE_MOTORIZED then
							c:SetDamageType( bit.bor( DMG_SLASH,DMG_ALWAYSGIB) )
						else
							c:SetDamageType( blunt and DMG_CLUB or DMG_SLASH )
						end
					end
					if srctbl then
						if b.MatType == MAT_FLESH or b.MatType == MAT_ALIENFLESH then
							self:EmitSound( srctbl.HitSound_Flesh["sharp"] or srctbl.HitSound_Flesh["blunt"] )
						else
							local sndtbl = srctbl.HitSound[ blunt and "blunt" or "sharp" ]
							local snd = sndtbl[ b.MatType ] or sndtbl[ MAT_DIRT ]
							self:EmitSound( snd )
						end
					end
				end
			})
		else
			local dmg = DamageInfo()
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(self.Owner:GetShootPos())
			dmg:SetDamageForce(self.Owner:GetAimVector() * (damage * 0.25))
			dmg:SetDamage(damage)
			if sndtype == TYPE_MOTORIZED then
				dmg:SetDamageType( bit.bor( DMG_SLASH,DMG_ALWAYSGIB) )
			else
				dmg:SetDamageType( blunt and DMG_CLUB or DMG_SLASH )
			end
			slashtrace.Entity:TakeDamageInfo(dmg)
		end

		targ = slashtrace.Entity

		local srctbl = secondary and self.Secondary or self.Primary
		if sndtype == TYPE_MOTORIZED then sndtbl = nil end
		if srctbl and game.GetTimeScale() < 0.99 then
			if slashtrace.MatType == MAT_FLESH or slashtrace.MatType == MAT_ALIENFLESH then
				self:EmitSound( srctbl.HitSound_Flesh["sharp"] or srctbl.HitSound_Flesh["blunt"] )
			else
				local sndtbl = srctbl.HitSound[ blunt and "blunt" or "sharp" ]
				local snd = sndtbl[ slashtrace.MatType ] or sndtbl[ MAT_DIRT ]
				self:EmitSound( snd )
			end
		end
	end
end

function SWEP:ChooseIdleAnim()
	stat = self:GetStatus()
	if self.Primary.Motorized then
		if stat == TFA.GetStatus("NMRIH_MELEE_MOTOR_LOOP") then
			self:SendViewModelSeq(self.AnimSequences.idle_on)
			self:PlayIdleSound( false )
		elseif stat == TFA.GetStatus("NMRIH_MELEE_MOTOR_ATTACK") then
			self:SendViewModelSeq(self.AnimSequences.attack_loop)
			self:PlayIdleSound( true )
		end
		return
	end
	if stat == TFA.GetStatus("NMRIH_MELEE_CHARGE_LOOP") then
		self:SendViewModelSeq(self.AnimSequences.charge_loop)
	else
		BaseClass.ChooseIdleAnim(self)
	end
end

SWEP.HasPlayedSound = {
	["idle"] = false,
	["saw"] = false
}

function SWEP:PlayIdleSound( sawing )
	if game.SinglePlayer() and CLIENT then return end
	local sndid = sawing and "saw" or "idle"
	if sawing and self.HasPlayedSound[ "idle" ] then
		self:StopSound(self.Primary.Motorized_IdleSound)
		self.HasPlayedSound[ "idle" ] = false
	elseif self.HasPlayedSound[ "saw" ] and not sawing then
		self:StopSound(self.Primary.Motorized_SawSound)
		self.HasPlayedSound[ "saw" ] = false
	end
	if not self.HasPlayedSound[ sndid ] then
		self.HasPlayedSound[ sndid ] = true
		self:EmitSound( sawing and self.Primary.Motorized_SawSound or self.Primary.Motorized_IdleSound)
	end
end

function SWEP:DoImpactEffect(tr, dmgtype)
	if not IsValid(self) then return end
	stat = self:GetStatus()
	if stat == TFA.GetStatus("NMRIH_MELEE_SWING")  then
		dmgtype = self.Primary.Blunt and DMG_CLUB or DMG_SLASH
	elseif stat == TFA.GetStatus("NMRIH_MELEE_CHARGE_END")  then
		dmgtype = self.Secondary.Blunt and DMG_CLUB or DMG_SLASH
	elseif self.Primary.Motorized and not ( self.GetBashing and self:GetBashing() ) then
		dmgtype = DMG_SLASH
	end
	if tr.MatType ~= MAT_FLESH and tr.MatType ~= MAT_ALIENFLESH then
		self:ImpactEffectFunc( tr.HitPos, tr.HitNormal, tr.MatType )
		if tr.HitSky then return true end
		if bit.band(dmgtype,DMG_SLASH) == DMG_SLASH then
			util.Decal("ManhackCut", tr.HitPos + tr.HitNormal * 4, tr.HitPos - tr.HitNormal)
			return true
		else
			return false
		end
	end
	return false
end

function SWEP:SwingThirdPerson()
	if self.HoldType == "melee" or self.HoldType == "melee2" then
		self.Owner:SetAnimation(PLAYER_ATTACK1)
	else
		self.Owner:AnimRestartGesture(0, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2, true)
	end
end

function SWEP:ProcessHoldType( ... )
	if self.Primary.Motorized and self:GetStatus() == TFA.GetStatus("NMRIH_MELEE_MOTOR_ATTACK") then
		self:SetHoldType( "ar2" )
	else
		BaseClass.ProcessHoldType(self, ...)
	end
end

function SWEP:AltAttack()
	return BaseClass.AltAttack(self)
end

local l_CT = CurTime

function SWEP:AltAttack()
	BaseClass.AltAttack(self)
end