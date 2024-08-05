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

if (CLIENT) then
	SWEP.PrintName = "Hands"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Author = "Chessnut"
SWEP.Instructions = [[Primary Fire: Throw/Punch
Secondary Fire: Knock/Pickup
Secondary Fire + Mouse: Rotate Object
Reload: Drop]]
SWEP.Purpose = "Hitting things and knocking on doors."
SWEP.Drop = false

SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.ViewTranslation = 4
if CLIENT then
	SWEP.NextAllowedPlayRateChange = 0
end

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 5
SWEP.Primary.Delay = 0.75

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""
SWEP.Secondary.Delay = 0.5

SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""

SWEP.UseHands = true
SWEP.LowerAngles = Angle(0, 5, -14)
SWEP.LowerAngles2 = Angle(0, 5, -19)
SWEP.KnockViewPunchAngle = Angle(-1.3, 1.8, 0)

SWEP.FireWhenLowered = true
SWEP.HoldType = "fist"

SWEP.holdDistance = 64
SWEP.maxHoldDistance = 96 -- how far away the held object is allowed to travel before forcefully dropping
SWEP.maxHoldStress = 4000 -- how much stress the held object can undergo before forcefully dropping

-- luacheck: globals ACT_VM_FISTS_DRAW ACT_VM_FISTS_HOLSTER
ACT_VM_FISTS_DRAW = 2
ACT_VM_FISTS_HOLSTER = 1

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	self.lastHand = 0
	self.maxHoldDistanceSquared = self.maxHoldDistance ^ 2
	self.heldObjectAngle = Angle(angle_zero)
end

if (CLIENT) then
	function SWEP:PreDrawViewModel(viewModel, weapon, client)
		local hands = player_manager.TranslatePlayerHands(player_manager.TranslateToPlayerModelName(client:GetModel()))

		if client:GetModel() == "models/willardnetworks/vortigaunt.mdl" then
			self.ViewModelFOV = 60
		end

		if (hands and hands.model) then
			viewModel:SetModel(hands.model)
			if hands.skin and isnumber(hands.skin) then
				viewModel:SetSkin(hands.skin)
			end
			viewModel:SetBodyGroups(hands.body)
		end
	end

	function SWEP:DoDrawCrosshair(x, y)
		surface.SetDrawColor(255, 255, 255, 66)
		surface.DrawRect(x - 2, y - 2, 4, 4)
	end

	-- Adjust these variables to move the viewmodel's position
	SWEP.IronSightsPos  = Vector(0, 0, 0)
	SWEP.IronSightsAng  = Vector(0, 0, 0)

	function SWEP:GetViewModelPosition(EyePos, EyeAng)
		if self.Owner:GetModel() == "models/willardnetworks/vortigaunt.mdl" then
			self.IronSightsPos  = Vector(0, -3, -5)
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

	hook.Add("CreateMove", "ixHandsCreateMove", function(cmd)
		if (LocalPlayer():GetLocalVar("bIsHoldingObject", false) and cmd:KeyDown(IN_ATTACK2)) then
			cmd:ClearMovement()
			local angle = RenderAngles()
			angle.z = 0
			cmd:SetViewAngles(angle)
		end
	end)
end

function SWEP:Deploy()
	if (!IsValid(self:GetOwner())) then
		return
	end

	local viewModel = self:GetOwner():GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
		if CLIENT then
			self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration()
		end
	end

	self:DropObject()
	return true
end

function SWEP:Precache()
	util.PrecacheSound("npc/vort/claw_swing1.wav")
	util.PrecacheSound("npc/vort/claw_swing2.wav")
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard1.wav")
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard2.wav")
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard3.wav")
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard4.wav")
	util.PrecacheSound("physics/wood/wood_crate_impact_hard2.wav")
	util.PrecacheSound("physics/wood/wood_crate_impact_hard3.wav")
end

function SWEP:OnReloaded()
	self.maxHoldDistanceSquared = self.maxHoldDistance ^ 2
	self:DropObject()
end

function SWEP:Holster()
	if (!IsValid(self:GetOwner())) then
		return
	end

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

function SWEP:Think()
	if (!IsValid(self:GetOwner())) then
		return
	end

	if (CLIENT) then
		local viewModel = self:GetOwner():GetViewModel()

		if (IsValid(viewModel) and self.NextAllowedPlayRateChange < CurTime()) then
			viewModel:SetPlaybackRate(1)
		end
	else
		if (self:IsHoldingObject()) then
			local physics = self:GetHeldPhysicsObject()
			local bIsRagdoll = self.heldEntity:IsRagdoll()
			local holdDistance = bIsRagdoll and self.holdDistance * 0.5 or self.holdDistance
			local targetLocation = self:GetOwner():GetShootPos() + self:GetOwner():GetForward() * holdDistance

			if (bIsRagdoll) then
				targetLocation.z = math.min(targetLocation.z, self:GetOwner():GetShootPos().z - 32)
			end

			if (!IsValid(physics)) then
				self:DropObject()
				return
			end

			if (physics:GetPos():DistToSqr(targetLocation) > self.maxHoldDistanceSquared) then
				self:DropObject()
			else
				local physicsObject = self.holdEntity:GetPhysicsObject()
				local currentPlayerAngles = self:GetOwner():EyeAngles()
				local client = self:GetOwner()

				if (client:KeyDown(IN_ATTACK2)) then
					local cmd = client:GetCurrentCommand()
					self.heldObjectAngle:RotateAroundAxis(currentPlayerAngles:Forward(), cmd:GetMouseX() / 15)
					self.heldObjectAngle:RotateAroundAxis(currentPlayerAngles:Right(), cmd:GetMouseY() / 15)
				end

				self.lastPlayerAngles = self.lastPlayerAngles or currentPlayerAngles
				self.heldObjectAngle.y = self.heldObjectAngle.y - math.AngleDifference(self.lastPlayerAngles.y, currentPlayerAngles.y)
				self.lastPlayerAngles = currentPlayerAngles

				physicsObject:Wake()
				physicsObject:ComputeShadowControl({
					secondstoarrive = 0.01,
					pos = targetLocation,
					angle = self.heldObjectAngle,
					maxangular = 256,
					maxangulardamp = 10000,
					maxspeed = 256,
					maxspeeddamp = 10000,
					dampfactor = 0.8,
					teleportdistance = self.maxHoldDistance * 0.75,
					deltatime = FrameTime()
				})

				if (physics:GetStress() > self.maxHoldStress) then
					self:DropObject()
				end

				local pos = physics:GetPos()
				local clientPos = client:GetPos()

				if (clientPos.z > pos.z and math.Distance(clientPos.x, clientPos.y, pos.x, pos.y) <= 50) then
					self:DropObject()
				end
			end
		end
		-- Prevents the camera from getting stuck when the object that the client is holding gets deleted.
		if(!IsValid(self.heldEntity) and self:GetOwner():GetLocalVar("bIsHoldingObject", true)) then
			self:GetOwner():SetLocalVar("bIsHoldingObject", false)
		end
	end
end

function SWEP:GetHeldPhysicsObject()
	return IsValid(self.heldEntity) and self.heldEntity:GetPhysicsObject() or nil
end

function SWEP:CanHoldObject(entity)
	if !entity or entity and !IsValid(entity) then return false end

	local physics = entity.GetPhysicsObject and entity:GetPhysicsObject()
	local client = self:GetOwner()
	local clientPos = client:GetPos()
	local pos = physics and IsValid(physics) and physics:GetPos()

	return IsValid(physics) and
		(physics:GetMass() <= ix.config.Get("maxHoldWeight", 100) and physics:IsMoveable()) and
		!self:IsHoldingObject() and
		!IsValid(entity.ixHeldOwner) and
		hook.Run("CanPlayerHoldObject", client, entity) and
		!(clientPos.z > entity:GetPos().z and math.Distance(clientPos.x, clientPos.y, pos.x, pos.y) < 50)
end

function SWEP:IsHoldingObject()
	return IsValid(self.heldEntity) and
		IsValid(self.heldEntity.ixHeldOwner) and
		self.heldEntity.ixHeldOwner == self:GetOwner()
end

function SWEP:PickupObject(entity)
	if (self:IsHoldingObject() or
		!IsValid(entity) or
		!IsValid(entity:GetPhysicsObject())) then
		return
	end

	local physics = entity:GetPhysicsObject()
	physics:EnableGravity(false)
	physics:AddGameFlag(FVPHYSICS_PLAYER_HELD)

	entity.ixHeldOwner = self:GetOwner()
	entity.ixCollisionGroup = entity:GetCollisionGroup()
	entity:StartMotionController()
	entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	self.heldObjectAngle = entity:GetAngles()
	self.heldEntity = entity

	self.holdEntity = ents.Create("prop_physics")
	self.holdEntity:SetPos(self.heldEntity:LocalToWorld(self.heldEntity:OBBCenter()))
	self.holdEntity:SetAngles(self.heldEntity:GetAngles())
	self.holdEntity:SetModel("models/weapons/w_bugbait.mdl")
	self.holdEntity:SetOwner(self:GetOwner())

	self.holdEntity:SetNoDraw(true)
	self.holdEntity:SetNotSolid(true)
	self.holdEntity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self.holdEntity:DrawShadow(false)

	self.holdEntity:Spawn()

	local trace = self:GetOwner():GetEyeTrace()
	local physicsObject = self.holdEntity:GetPhysicsObject()

	if (IsValid(physicsObject)) then
		physicsObject:SetMass(2048)
		physicsObject:SetDamping(0, 1000)
		physicsObject:EnableGravity(false)
		physicsObject:EnableCollisions(false)
		physicsObject:EnableMotion(false)
	end

	if (trace.Entity:IsRagdoll()) then
		local tracedEnt = trace.Entity
		self.holdEntity:SetPos(tracedEnt:GetBonePosition(tracedEnt:TranslatePhysBoneToBone(trace.PhysicsBone)))
	end

	self.constraint = constraint.Weld(self.holdEntity, self.heldEntity, 0,
		trace.Entity:IsRagdoll() and trace.PhysicsBone or 0, 0, true, true)
end

function SWEP:DropObject(bThrow)
	if (!IsValid(self.heldEntity) or self.heldEntity.ixHeldOwner != self:GetOwner()) then
		return
	end

	self.lastPlayerAngles = nil
	self:GetOwner():SetLocalVar("bIsHoldingObject", false)

	self.constraint:Remove()
	self.holdEntity:Remove()

	self.heldEntity:StopMotionController()
	self.heldEntity:SetCollisionGroup(self.heldEntity.ixCollisionGroup or COLLISION_GROUP_NONE)

	local physics = self:GetHeldPhysicsObject()
	physics:EnableGravity(true)
	physics:Wake()
	physics:ClearGameFlag(FVPHYSICS_PLAYER_HELD)

	if (bThrow) then
		timer.Simple(0, function()
			if (IsValid(physics) and IsValid(self:GetOwner())) then
				physics:AddGameFlag(FVPHYSICS_WAS_THROWN)
				physics:ApplyForceCenter(self:GetOwner():GetAimVector() * ix.config.Get("throwForce", 732))
			end
		end)
	end

	self.heldEntity.ixHeldOwner = nil
	self.heldEntity.ixCollisionGroup = nil
	self.heldEntity = nil
end

function SWEP:PlayPickupSound(surfaceProperty)
	local result = "Flesh.ImpactSoft"

	if (surfaceProperty != nil) then
		local surfaceName = util.GetSurfacePropName(surfaceProperty)
		local soundName = surfaceName:gsub("^metal$", "SolidMetal") .. ".ImpactSoft"

		if (sound.GetProperties(soundName)) then
			result = soundName
		end
	end

	self:GetOwner():EmitSound(result, 75, 100, 40)
end

function SWEP:Holster()
	if (!IsFirstTimePredicted() or CLIENT) then
		return
	end

	self:DropObject()
	return true
end

function SWEP:OnRemove()
	if (SERVER) then
		self:DropObject()
	end
end

function SWEP:OwnerChanged()
	if (SERVER) then
		self:DropObject()
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

function SWEP:PrimaryAttack()
	if (!IsFirstTimePredicted()) then
		return
	end

	if (SERVER and self:IsHoldingObject()) then
		self:DropObject(true)
		return
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if (hook.Run("CanPlayerThrowPunch", self:GetOwner()) == false) then
		return
	end

	if (ix.plugin.Get("stamina")) then
		local staminaUse = ix.config.Get("punchStamina")

		if (staminaUse > 0) then
			local value = self:GetOwner():GetLocalVar("stm", 0) - staminaUse

			if (value < 0) then
				return
			elseif (SERVER) then
				self:GetOwner():ConsumeStamina(staminaUse)
			end
		end
	end

	if (SERVER) then
		self:GetOwner():EmitSound("npc/vort/claw_swing"..math.random(1, 2)..".wav")
	end

	self:DoPunchAnimation()

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
			if ix.plugin.Get("vortigaunts") then
				if self:GetOwner():IsVortigaunt() then
					damage = damage + self:GetOwner():GetCharacter():GetSkillLevel("melee")
				end
				if (SERVER and self:GetOwner():IsPlayer() and self:GetOwner().GetCharacter and self:GetOwner():GetCharacter() and self:GetOwner():IsVortigaunt()) then
					self:GetOwner():GetCharacter():DoAction("melee_slash")
				end
			end
			local context = {damage = damage}
			local result = hook.Run("GetPlayerPunchDamage", self:GetOwner(), damage, context)
				if (result != nil) then
					damage = result
				else
					damage = context.damage
				end

			damage = damage * 1.7 --For some reason, punching only does 60% of the damage. 60% * 1.7 = 102%

			if self:GetOwner():IsVortigaunt() and damage > 25 then
				damage = 30
			end

			self:GetOwner():LagCompensation(true)
				local data = {}
					data.start = self:GetOwner():GetShootPos()
					data.endpos = data.start + self:GetOwner():GetAimVector() * 96
					data.filter = self:GetOwner()
				local trace = util.TraceLine(data)

				if (SERVER and trace.Hit) then
					local entity = trace.Entity

					if (IsValid(entity)) then
						if ix.plugin.Get("vortigaunts") then
							if (self:GetOwner():IsPlayer() and self:GetOwner().GetCharacter and self:GetOwner():GetCharacter() and self:GetOwner():IsVortigaunt()) then
								self:GetOwner():GetCharacter():DoAction("melee_hit")
							end
						end
						local damageInfo = DamageInfo()
							damageInfo:SetAttacker(self:GetOwner())
							damageInfo:SetInflictor(self)
							damageInfo:SetDamage(damage)
							damageInfo:SetDamageType(DMG_GENERIC)
							damageInfo:SetDamagePosition(trace.HitPos)
							damageInfo:SetDamageForce(self:GetOwner():GetAimVector() * 1024)
						entity:DispatchTraceAttack(damageInfo, data.start, data.endpos)

						if (entity:IsPlayer()) then
							ix.log.AddRaw(self:GetOwner():Name() .." has damaged " .. entity:Name() .. ", dealing " .. damage .. " with ix_hands")
						end
			
						if (entity:IsNPC()) then
							ix.log.AddRaw(self:GetOwner():Name() .." has damaged " .. entity:GetClass() .. ", dealing " .. damage .. " with ix_hands")
						end

						self:GetOwner():EmitSound("physics/body/body_medium_impact_hard"..math.random(1, 6)..".wav", 80)
					end
				end
				hook.Run("PlayerThrowPunch", self:GetOwner(), trace)
			self:GetOwner():LagCompensation(false)

			if (CLIENT and trace.Hit) then
				local entity = trace.Entity
				--This is kind of redundant
				--if (entity:IsPlayer() and IsValid(entity)) then
				--	chat.AddText(Color(217, 83, 83), "You have damaged " .. entity:Name() .. ", dealing " .. damage .. " points of damage.")
				--end
	
				--if (entity:IsNPC()) then
				--	chat.AddText(Color(217, 83, 83), "You have damaged " .. entity:GetClass() .. ", dealing " .. damage .. " points of damage.")
				--end
			end
		end
	end)
end

function SWEP:SecondaryAttack()
	if (!IsFirstTimePredicted()) then
		return
	end

	local data = {}
		data.start = self:GetOwner():GetShootPos()
		data.endpos = data.start + self:GetOwner():GetAimVector() * 84
		data.filter = {self, self:GetOwner()}
	local trace = util.TraceLine(data)
	local entity = trace.Entity

	if CLIENT then
		local viewModel = self:GetOwner():GetViewModel()

		if (IsValid(viewModel)) then
			viewModel:SetPlaybackRate(0.5)
			if CLIENT then
				self.NextAllowedPlayRateChange = CurTime() + viewModel:SequenceDuration() * 2
			end
		end
	end

	if (SERVER and IsValid(entity)) then
		if (entity:IsDoor()) then
			if (hook.Run("CanPlayerKnock", self:GetOwner(), entity) == false) then
				return
			end

			self:GetOwner():ViewPunch(self.KnockViewPunchAngle)
			self:GetOwner():EmitSound("physics/wood/wood_crate_impact_hard"..math.random(2, 3)..".wav")
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)

			self:DoPunchAnimation()
			self:SetNextSecondaryFire(CurTime() + 0.4)
			self:SetNextPrimaryFire(CurTime() + 1)
		elseif (entity:IsPlayer() and ix.config.Get("allowPush", true)) then
			self:PushEntity(entity)
		elseif (!entity:IsNPC() and self:CanHoldObject(entity)) then
			self:GetOwner():SetLocalVar("bIsHoldingObject", true)
			self:PickupObject(entity)
			self:PlayPickupSound(trace.SurfaceProps)
			self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
		end
	end
end

function SWEP:PushEntity(entity)
	local curTime = CurTime()
	local direction = self.Owner:GetAimVector() * (300 + (self.Owner:GetCharacter():GetAttribute("str", 0) * 3))
		direction.z = 0
	entity:SetVelocity(direction)

	self.Owner:EmitSound("physics/flesh/flesh_impact_hard"..math.random(1, 6)..".wav")
	self:SetNextSecondaryFire(curTime + 1.5)
	self:SetNextPrimaryFire(curTime + 1.5)
end

function SWEP:Reload()
	if (!IsFirstTimePredicted()) then
		return
	end

	if (SERVER and IsValid(self.heldEntity)) then
		self:DropObject()
	end
end
