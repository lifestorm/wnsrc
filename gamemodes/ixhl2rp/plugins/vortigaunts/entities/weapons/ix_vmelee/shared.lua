--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.Slot          = 1
	SWEP.SlotPos       = 5
	SWEP.DrawAmmo      = false
	SWEP.PrintName	   = "Vortimelee"
	SWEP.DrawCrosshair = true

    game.AddParticles("particles/Vortigaunt_FX.pcf")
end

PrecacheParticleSystem("vortigaunt_glow_beam_cp1")
PrecacheParticleSystem("vortigaunt_glow_beam_cp1b")
PrecacheParticleSystem("vortigaunt_charge_token")

SWEP.Purpose    = "Melee and Shield"
SWEP.Contact    = ""
SWEP.Author     = "Adolphus (& M!NT)"
SWEP.WorldModel = ""
SWEP.HoldType   = "fist"
SWEP.Category   = "Vort Swep"

SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic   = false
SWEP.Primary.ClipSize    = -1
SWEP.Primary.Ammo        = ""
SWEP.Spawnable     		 = true
SWEP.AdminSpawnable		 = false
SWEP.Primary.Damage = 7 --Fuck this rounding piece
SWEP.Primary.Delay = 0.75

SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic   = false
SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.Ammo	       = ""

SWEP.ViewModelFOV   = 110
SWEP.ViewModel 	    = Model("models/willardnetworks/c_arms_vortigaunt.mdl")
SWEP.IsAlwaysRaised = true

SWEP.vePerShield = 10
SWEP.vePerSlap = 5

SWEP.shieldActive = false

if CLIENT then
	SWEP.NextAllowedPlayRateChange = 0
end

function SWEP:Initialize()
	self.lastHand = 0
end

function SWEP:Deploy()
	local owner = self:GetOwner()
	if (!IsValid(owner)) then
		return
	end

	local viewModel = owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end

    ParticleEffectAttach("vortigaunt_charge_token", PATTACH_POINT_FOLLOW, owner, self:GetOwner():LookupAttachment("leftclaw"))
	ParticleEffectAttach("vortigaunt_charge_token", PATTACH_POINT_FOLLOW, owner, self:GetOwner():LookupAttachment("rightclaw"))
end

if (CLIENT) then
	function SWEP:Think()
		local owner = self:GetOwner()
		if (self.vSHIELD and !IsValid(owner)) then
			self.vSHIELD:Remove()
			return
		end

		local viewModel = owner:GetViewModel()

		if (IsValid(viewModel) and self.NextAllowedPlayRateChange < CurTime()) then
			viewModel:SetPlaybackRate(1)
		end
	end
end

function SWEP:Holster()
	local owner = self:GetOwner()
	if (!IsValid(owner)) then
		return
	end

	local viewModel = owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_HOLSTER)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end

    owner:StopParticles()

    if (self.shieldActive) then
        if (SERVER) then
            if IsValid(self.vSHIELD) then
                self:GetOwner():EmitSound("npc/vort/health_charge.wav")
                maxHealth = self.vSHIELD:GetMaxHealth()
                currentHealth = self.vSHIELD:Health()
                self:GetOwner():GetCharacter():AddVortalEnergy(self.vePerShield * (currentHealth / maxHealth))
                self.vSHIELD:Remove()
            end
        end
    end

    self.shieldActive = false
 
	return true
end

function SWEP:ValidateShield()
	for _, shield in ipairs(ents.FindByClass("ix_vortmeleeshield")) do
		if shield:GetOwner() == self:GetOwner() then
			shield:Remove()
		end
	end
end

function SWEP:DoPunchAnimation()
	self.lastHand = math.abs(1 - self.lastHand)

	local sequence = 3 + self.lastHand
	local viewModel = self:GetOwner():GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(0.5)
		viewModel:SetSequence(sequence)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration() * 2
		end
	end
end

-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack()
    if (!IsFirstTimePredicted()) then
		return
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if (SERVER) then
		self:GetOwner():EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav")
	end

	--self:DoPunchAnimation()

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:GetOwner():ViewPunch(Angle(self.lastHand + 2, self.lastHand + 5, 0.125))

	if ix.plugin.Get("vortigaunts") then
		if (ix.config.Get("pushOnly")) and !self:GetOwner():IsVortigaunt() then
			local data = {}
				data.start = self.Owner:GetShootPos()
				data.endpos = data.start + self.Owner:GetAimVector() * 84
				data.filter = {self, self.Owner}
			local trace = util.TraceLine(data)
			local entity = trace.Entity

			if (entity:IsPlayer() and ix.config.Get("allowPush", true)) then
				self:PushEntity(entity)
			end

			return
		end
	else
		if (ix.config.Get("pushOnly")) then
			local data = {}
				data.start = self.Owner:GetShootPos()
				data.endpos = data.start + self.Owner:GetAimVector() * 84
				data.filter = {self, self.Owner}
			local trace = util.TraceLine(data)
			local entity = trace.Entity

			if (entity:IsPlayer() and ix.config.Get("allowPush", true)) then
				self:PushEntity(entity)
			end

			return
		end
	end

	timer.Simple(0.055, function()
		if (IsValid(self) and IsValid(self:GetOwner())) then
			local damage = self.Primary.Damage
            local vortalSlash = false
            local percentage = self.vePerSlap / 100
            percentage = percentage * ix.config.Get("additionalVortalEnergyDrainPerPointOfArmor", 1)
			if ix.plugin.Get("vortigaunts") then
				if self:GetOwner():IsVortigaunt() then
                    if (self.Owner:HasVortalEnergy(self.vePerSlap + (percentage * self.Owner:Armor()))) and !self.shieldActive then
                        vortalSlash = true
                    end
					damage = damage + self:GetOwner():GetCharacter():GetSkillLevel("melee")
                    if (vortalSlash) then
                        damage = damage + (self:GetOwner():GetCharacter():GetSkillLevel("vort") * 0.6)
                    end
				end
				if (SERVER and self:GetOwner():IsPlayer() and self:GetOwner().GetCharacter and self:GetOwner():GetCharacter() and self:GetOwner():IsVortigaunt()) then
					--self:GetOwner():GetCharacter():DoAction("melee_slash")
				end
			end
			local context = {damage = damage}
			local result = hook.Run("GetPlayerPunchDamage", self:GetOwner(), damage, context)
				if (result != nil) then
					damage = result
				else
					damage = context.damage
				end
            -- damage = damage * 1.7 --For some reason, punching only does 60% of the damage. 60% * 1.7 = 102%
			
            local pos = self:GetOwner():GetShootPos()
	        local ang = self:GetOwner():GetAimVector()

            self:GetOwner():LagCompensation(true)
				
            local data = {}
            data.start = pos
            data.endpos = pos + (ang * 100)
            data.filter = {self:GetOwner(), self.vSHIELD}
            data.mins = Vector(-5, -5, 0)
            data.maxs = Vector(5, 5, 5)
            local trace = util.TraceHull(data)

				if (SERVER and trace.Hit) then
					local entity = trace.Entity

					if (IsValid(entity)) then
						if ix.plugin.Get("vortigaunts") then
							if (self:GetOwner():IsPlayer() and self:GetOwner().GetCharacter and self:GetOwner():GetCharacter() and self:GetOwner():IsVortigaunt() and (entity:IsPlayer() or entity:IsNPC()) then
								self:GetOwner():GetCharacter():DoAction("melee_hit")
							end
						end
						local damageInfo = DamageInfo()
							damageInfo:SetAttacker(self:GetOwner())
							damageInfo:SetInflictor(self)
							damageInfo:SetDamage(damage)
                            if (vortalSlash) then
                                damageInfo:SetDamageType(DMG_SHOCK)
                            else
							    damageInfo:SetDamageType(DMG_GENERIC)
                            end
							damageInfo:SetDamagePosition(trace.HitPos)
							damageInfo:SetDamageForce(self:GetOwner():GetAimVector() * 1024)
						entity:DispatchTraceAttack(damageInfo, data.start, data.endpos)

                        if (vortalSlash) then
                            self.Owner:TakeVortalEnergy(self.vePerSlap + (percentage * self.Owner:Armor()))
                            ParticleEffect("vortigaunt_glow_beam_cp1", trace.HitPos, Angle(0, 0, 0), entity)
                            ParticleEffect("vortigaunt_glow_beam_cp1b", trace.HitPos, Angle(0, 0, 0), entity)
                            if (entity:IsPlayer()) then
                                if (!(entity:GetCharacter():GetBleedout() > 0) ) then
                                    entity:SetLocalVar("blur", 50)
									entity:SetEyeAngles(Angle(math.random(-89,89),math.random(0,359),0))
									entity:SetWalkSpeed(ix.config.Get("walkSpeed")/2)
									entity:SetRunSpeed(ix.config.Get("runSpeed")/2)
									timer.Simple(3, function()
										entity:SetLocalVar("blur", nil)
										entity:SetWalkSpeed(ix.config.Get("walkSpeed"))
										entity:SetRunSpeed(ix.config.Get("runSpeed"))
									end)
                                end
                            end
                        end
                        
                        if (vortalSlash) then
						    self:GetOwner():EmitSound("npc/vort/attack_shoot.wav", 80)
                        else
                            self:GetOwner():EmitSound("physics/body/body_medium_impact_hard"..math.random(1, 6)..".wav", 80)
                        end
					end
				end
				hook.Run("PlayerThrowPunch", self:GetOwner(), trace)
			self:GetOwner():LagCompensation(false)

			if (CLIENT and trace.Hit) then
				local entity = trace.Entity
                if (!vortalSlash and !self.shieldActive) then
                    chat.AddText(Color(26, 171, 69), "[VORTESSENCE] You were too tired to empower your strikes!")
                end
			end
		end
	end)
end

function SWEP:SecondaryAttack()

    if (!self.shieldActive) then
        local owner = self:GetOwner()

        local percentage = self.vePerShield / 100
        percentage = percentage * ix.config.Get("additionalVortalEnergyDrainPerPointOfArmor", 1)
        if !self.Owner:HasVortalEnergy(self.vePerShield + (percentage * self.Owner:Armor())) then
            return
        end

        if (SERVER) then
            if (!IsValid(self.vSHIELD)) then
                self:SetNextSecondaryFire(CurTime() + 1)

                self.Owner:TakeVortalEnergy(self.vePerShield + (percentage * self.Owner:Armor()))

                self:ValidateShield()

                self.vSHIELD = ents.Create("ix_vortmeleeshield")
                self.vSHIELD:SetPos(owner:GetPos() + owner:GetUp()*45)
                self.vSHIELD:Spawn()
                self.vSHIELD:Activate() 
                self.vSHIELD:SetOwner(owner)
                self.vSHIELD:FollowBone(owner, 11)
                self.vSHIELD:SetLocalAngles(Angle(0, 0, -90))
                self.vSHIELD:SetLocalPos(Vector(0, 50, 0))
                owner:EmitSound("npc/vort/health_charge.wav")
            end
        end
        self.shieldActive = true
        return false
    else
        if (SERVER) then
            if IsValid(self.vSHIELD) then
                self:GetOwner():EmitSound("npc/vort/health_charge.wav")
                maxHealth = self.vSHIELD:GetMaxHealth()
                currentHealth = self.vSHIELD:Health()
                self:GetOwner():GetCharacter():AddVortalEnergy(self.vePerShield * (currentHealth / maxHealth))
                self.vSHIELD:Remove()
            end
            self:SetNextSecondaryFire(CurTime() + 1)
        end
        self.shieldActive = false
        return false
    end
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
end
