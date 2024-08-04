--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if ( SERVER ) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.Slot = 0
	SWEP.SlotPos = 5
	SWEP.DrawAmmo = false
	SWEP.PrintName = "Vortibeam"
	SWEP.DrawCrosshair = true

	game.AddParticles("particles/Vortigaunt_FX.pcf")
end

PrecacheParticleSystem("vortigaunt_beam")
PrecacheParticleSystem("vortigaunt_beam_b")
PrecacheParticleSystem("vortigaunt_charge_token")

SWEP.Instructions = "Primary Fire: Fire your beam."
SWEP.Purpose = "Immediately kills the target that you fire it at."
SWEP.Contact = ""
SWEP.Author	= "RJ"
SWEP.Category = "Vort Swep"

player_manager.AddValidModel("vortigaunt_arms2", "models/willardnetworks/vortigaunt.mdl")
player_manager.AddValidHands("vortigaunt_arms2", "models/willardnetworks/c_arms_vortigaunt.mdl", 1, "0000000")

SWEP.ViewModel 				= Model("models/willardnetworks/c_arms_vortigaunt.mdl")
SWEP.ViewModelFOV = 110
SWEP.WorldModel = ""
SWEP.HoldType = "pistol"

SWEP.Spawnable     			= true
SWEP.AdminSpawnable			= true

SWEP.Primary.IsAlwaysRaised = true
SWEP.IsAlwaysRaised = true

SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.Damage = 40
SWEP.Primary.Delay = 1.5
SWEP.Primary.Ammo = ""

SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 0
SWEP.Secondary.Ammo	= ""

SWEP.vePerShot = 5
SWEP.aoeRadius = 50

SWEP.lockAngle = 5

if CLIENT then
	SWEP.NextAllowedPlayRateChange = 0
end

-- Called when the SWEP is deployed.
function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)

	local viewModel = self:GetOwner():GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end
end

-- Called when the SWEP is holstered.
function SWEP:Holster(switchingTo)
	self:SendWeaponAnim(ACT_VM_HOLSTER)

	local viewModel = self:GetOwner():GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_HOLSTER)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end

	return true
end


if (CLIENT) then
	function SWEP:PreDrawViewModel(viewModel, weapon, client)
		local hands = player_manager.TranslatePlayerHands(player_manager.TranslateToPlayerModelName(client:GetModel()))

		if (hands and hands.model) then
			viewModel:SetModel(hands.model)
			viewModel:SetSkin(hands.skin)
			viewModel:SetBodyGroups(hands.body)
		end
	end

	function SWEP:DoDrawCrosshair(x, y)
		surface.SetDrawColor(255, 255, 255, 66)
		surface.DrawRect(x - 2, y - 2, 4, 4)
	end

	-- Adjust these variables to move the viewmodel's position
	SWEP.IronSightsPos  = Vector(-5, -5, -55)
	SWEP.IronSightsAng  = Vector(35, 15, 10)

	function SWEP:GetViewModelPosition(EyePos, EyeAng)
		local Mul = 1.0

		local Offset = self.IronSightsPos

		if (self.IronSightsAng) then
			EyeAng = EyeAng * 1

			EyeAng:RotateAroundAxis(EyeAng:Right(), 	self.IronSightsAng.x * Mul)
			EyeAng:RotateAroundAxis(EyeAng:Up(), 		self.IronSightsAng.y * Mul)
			EyeAng:RotateAroundAxis(EyeAng:Forward(),   self.IronSightsAng.z * Mul)
		end

		local Right 	= EyeAng:Right()
		local Up 		= EyeAng:Up()
		local Forward 	= EyeAng:Forward()

		EyePos = EyePos + Offset.x * Right * Mul
		EyePos = EyePos + Offset.y * Forward * Mul
		EyePos = EyePos + Offset.z * Up * Mul

		return EyePos, EyeAng
	end

	if (CLIENT) then
		function SWEP:Think()
			if (!IsValid(self:GetOwner())) then
				return
			end

			local viewModel = self:GetOwner():GetViewModel()

			if (IsValid(viewModel) and self.NextAllowedPlayRateChange < CurTime()) then
				viewModel:SetPlaybackRate(1)
				self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
			end
		end
	end
end

function SWEP:OnRemove()
	if (SERVER) then
		if self:GetOwner() then
			if self:GetOwner().DrawViewModel then
				self:GetOwner():DrawViewModel(true)
			end
		end
	end

	if (self:GetOwner().broomModel) then
		if (self:GetOwner().broomModel:IsValid()) then
			self:GetOwner().broomModel:Remove()
		end
	end

	return true
end

-- Called when the SWEP is initialized.
function SWEP:Initialize()
	self.Primary.Damage = ix.config.Get("vortBeamAdditionalDamage", 40)
	self.lockAngle = ix.config.Get("VortbeamAngle", 5)
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:CanPrimaryAttack()
	local v = hook.Run("TFA_CanSecondaryAttack", self)
	if v ~= nil then
		return v
	end

	local percentage = self.vePerShot / 100
	percentage = percentage * ix.config.Get("additionalVortalEnergyDrainPerPointOfArmor", 1)
	if !self:GetOwner():HasVortalEnergy(self.vePerShot + (percentage * self:GetOwner():Armor())) then
		return false
	end

	if (!self:GetOwner():GetCharacter():CanDoAction("vort_beam_shoot")) then
		return false
	end

	if (!self:GetOwner():OnGround()) then
		return false
	end

	return true
end

function SWEP:InterestingHit(entity)
	if entity:IsPlayer() or entity:IsNextBot() or entity:IsNPC() or entity:IsVehicle() then
		return true
	else
		return false
	end
end

-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack()
	if (self.bIsFiring or !self:CanPrimaryAttack() or self:GetOwner():IsSprinting()) then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self.bIsFiring = true

	if (CLIENT) then
		-- Adjust these variables to move the viewmodel's position
		self.IronSightsPos  = Vector(-10, -5, -70)
		self.IronSightsAng  = Vector(-5, 100, 10)
	end

	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:GetOwner():SetAnimation( PLAYER_ATTACK1 )

	local chargeSound = CreateSound(self:GetOwner(), "npc/vort/attack_charge.wav")
	chargeSound:SetSoundLevel( 60 )
	chargeSound:Play()

	if (SERVER) then
		self:GetOwner():SprintDisable()
	end				

	ParticleEffectAttach("vortigaunt_charge_token", PATTACH_POINT_FOLLOW, self:GetOwner(), self:GetOwner():LookupAttachment("leftclaw"))
	ParticleEffectAttach("vortigaunt_charge_token", PATTACH_POINT_FOLLOW, self:GetOwner(), self:GetOwner():LookupAttachment("rightclaw"))

	timer.Simple(0.6, function()
		chargeSound:Stop()
		if (SERVER) then
			self:GetOwner():SprintEnable()
		end

		if (!IsValid(self)) then return end

		if (!IsValid(self:GetOwner())) then
			self.bIsFiring = false
			return
		end

		local v = hook.Run("TFA_CanSecondaryAttack", self)
		if v ~= nil then
			self.bIsFiring = false
			return v
		end
		self:GetOwner():EmitSound("npc/vort/attack_shoot.wav", 40)

		local distance = nil;
		local closest = nil;
		local directAim = false;

		local ang = self:GetOwner():GetAimVector()
		local pos = self:GetOwner():GetShootPos()

		local trace = {}
		trace.start = pos
		trace.endpos = pos + (ang * 65535)
		trace.filter = {self:GetOwner()}
		trace.mask = 33570817
		local trace = util.TraceLine(trace)

		local finalHitPos = trace.HitPos;

		if (trace.Entity and (trace.Entity:IsPlayer() or trace.Entity:IsNPC())) then
							-- we are looking right at something, that is the closest thing for sure
			closest = trace.Entity;
			directAim = true;
		else
			local x1 = self.Owner:GetShootPos();
			local x2 = trace.HitPos;
			local x12 = x2 - x1;
			local difflength = x12:LengthSqr();

			local maxangle = math.cos(3.14159265 * self.lockAngle / 180)
			maxangle = maxangle * maxangle --Square all the way

			local entities = ents.GetAll();

			for k, v in pairs(entities) do
									--loop through everything, skip invalid stuff
				if (!v:IsValid()) then
					continue;
				elseif (!v:IsPlayer() and !v:IsNPC() and !v:IsNextBot()) then
					continue;
				elseif ((v.Health and v:Health() <= 0) or (v.Alive and !v:Alive())) then
					continue;
				elseif (v == self.Owner or (v.IsNoClipping and v:IsNoClipping())) then
					continue;
				end;

				local targetFeet = v:GetPos()
				local targetShootPos = v:EyePos()
									-- we grab something roughly between their eyes and feet
				local x0 = (targetShootPos + Vector(0, 0, -5)) * 0.80 + targetFeet * 0.20;

									-- determine angle from our LOS to our LOS to them, if they are really close to us it might be they are too far off to the side, we don't want to snap someone hugging our shoulder because he is ~30 units away from the start of our LOS
				local x10 = x0 - x1;
				local x10x12Dot = x10:Dot(x12)
				x10x12Dot = x10x12Dot * x10x12Dot
				local angle = x10x12Dot / (difflength * x10:LengthSqr());
				if (angle < maxangle) then
					continue;
				end;

				local x20 = x10 - x12;
				local angle2 = x20:Dot(x12 * -1)
									-- also determine the angle with the end hit marker, to be sure they aren't beyond where the trace hit
				if (angle2 < 0) then
					continue;
				end;

									-- cool vector math to calculate distance to a line
				local dist = (x0 - x1):Cross(x0 - x2):LengthSqr() / difflength;
				
				local maxDistBase = ix.config.Get("VortbeamBorders", 100)
				if dist > (maxDistBase * maxDistBase) then continue end

				if (!distance or distance > dist) then
					local centerTrace = {};
						centerTrace.start = x1;
						centerTrace.endpos = x0;
						centerTrace.filter = {self:GetOwner()}
						centerTrace.mask = 	33570817
					local centerTraceResult = util.TraceLine(centerTrace)
					
					if (!centerTraceResult.Hit or (centerTraceResult.Entity and centerTraceResult.Entity == v)) then
						closest = v;
						distance = dist;
						finalHitPos = x0;
					else
						local feetTrace = {}
							feetTrace.start = x1
							feetTrace.endpos = targetFeet
							feetTrace.filter = {self:GetOwner()}
							feetTrace.mask = 33570817
						local feetTraceResult = util.TraceLine(feetTrace)

						if (!feetTraceResult.Hit or (feetTraceResult.Entity and feetTraceResult.Entity == v)) then
							closest = v;
							distance = dist;
							finalHitPos = targetFeet
						else
							local headTrace = {}
								headTrace.start = x1
								headTrace.endpos = targetShootPos
								headTrace.filter = {self:GetOwner()}
								headTrace.mask = 33570817
							local headTraceResult = util.TraceLine(headTrace)

							if (!headTraceResult.Hit or (headTraceResult.Entity and headTraceResult.Entity == v)) then
								closest = v;
								distance = dist;
								finalHitPos = targetShootPos;
							end
						end
					end;
				end;
			end;
		end;

		if (closest) then
			if (SERVER) then
				local target = closest
				local damage = self:GetOwner():GetCharacter():GetSkillScale("vort_beam") + self.Primary.Damage
				-- damage = damage * 1.7
				local damageInfo = DamageInfo()
				if self:GetOwner():GetNetVar("ixVortExtract") then
					damage = 999
				end
				damageInfo:SetAttacker(self:GetOwner())
				damageInfo:SetInflictor(self)
				damageInfo:SetDamage(damage)
				damageInfo:SetDamageForce(ang * damage)
				damageInfo:SetReportedPosition(leftClaw and self:GetOwner():GetAttachment(leftClaw).Pos or self:GetOwner():EyePos())
				damageInfo:SetDamagePosition(finalHitPos)
				damageInfo:SetDamageType(DMG_SHOCK)
				if target != self:GetOwner() and
				target:IsPlayer() or
				target:IsNextBot() or
				target:IsNPC() or
				target:IsVehicle() then
					if (damageInfo:GetDamage() >= 1) then
						target:TakeDamageInfo(damageInfo)
					end
	
					if (target:IsPlayer()) then
						hook.Run("PostCalculatePlayerDamage", target, damageInfo, HITGROUP_GENERIC)
	
						ix.log.AddRaw("[VORT] " .. self:GetOwner():Name() .. " has damaged " .. target:Name() .. ", dealing " .. damage .. " with vortbeam")
	
						ix.chat.Send(self:GetOwner(), "vortbeam", "has damaged " .. target:Name() .. ", dealing " .. damage .. " points of damage", false, attacker)
					end
	
					if (target:IsNPC()) then
						ix.log.AddRaw("[VORT] " .. self:GetOwner():Name() .. " has damaged " .. target:GetClass() .. ", dealing " .. damage .. " with vortbeam")
	
						ix.chat.Send(self:GetOwner(), "vortbeam", "has damaged " .. target:GetClass() .. ", dealing " .. damage .. " points of damage", false, attacker)
					end
	
					if (target:IsNPC() or target:IsPlayer()) then
						self:GetOwner():GetCharacter():DoAction("vort_beam_shoot")
					end
				end
			end
		else
			-- When you don't hit shit you don't hit shit.
		end;

		self:GetOwner():StopParticles()

		local leftClaw = self:GetOwner():LookupAttachment("leftclaw")

		if (leftClaw) then
			util.ParticleTracerEx(
				"vortigaunt_beam", self:GetOwner():GetAttachment(leftClaw).Pos, finalHitPos, true, self:GetOwner():EntIndex(), leftClaw
			)
		end

		if SERVER then
			local percentage = self.vePerShot / 100
			percentage = percentage * ix.config.Get("additionalVortalEnergyDrainPerPointOfArmor", 1)
			self:GetOwner():TakeVortalEnergy(self.vePerShot + (percentage * self:GetOwner():Armor()))
		end
		self.bIsFiring = false
		local viewModel = self:GetOwner():GetViewModel()
		timer.Simple(1, function()
			if (IsValid(viewModel)) then
				viewModel:SetPlaybackRate(1)
				viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
				if CLIENT then
					self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
				end

				self.IronSightsPos  = Vector(-5, -5, -105)
				self.IronSightsAng  = Vector(35, 15, 10)
			end
		end)

		timer.Simple(1, function()
			-- Adjust these variables to move the viewmodel's position
			self.IronSightsPos  = Vector(-5, -5, -55)
		end)

		hook.Run("TFA_PostSecondaryAttack", self)

		if (SERVER) then
			self:GetOwner():GetCharacter():DoAction("vort_beam_practice")
		end
	end)
	hook.Run("TFA_PostSecondaryAttack", self, true)
end

function SWEP:SecondaryAttack()
	return false
end