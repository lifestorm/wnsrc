--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Original code from https://steamcommunity.com/sharedfiles/filedetails/?id=104607228
-- I have only modified this code and I claim no credit for the original ~Aspect

AddCSLuaFile()
--AddCSLuaFile("effects/applicator_effect.lua")

SWEP.PrintName = "Foam Applicator"
SWEP.Author = "Robotboy655 & Aspect™"
SWEP.Category = "HL2 RP"

SWEP.Slot = 5
SWEP.SlotPos = 35
SWEP.Weight = 1

SWEP.DrawWeaponInfoBox = false
SWEP.UseHands = false

SWEP.ViewModel = "models/jq/hlvr/props/xen/combine_foam_applicator.mdl"
SWEP.ViewModelFOV = 75
SWEP.WorldModel = "models/jq/hlvr/props/xen/combine_foam_applicator.mdl"
SWEP.HoldType = "smg"

game.AddAmmoType({name = "applicator"})

SWEP.MaxAmmo = 500

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = SWEP.MaxAmmo
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "applicator"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.IronSightsPos  = Vector(9, 13, -6)
SWEP.IronSightsAng  = Vector(0, 0, 0)

if (CLIENT) then
	function SWEP:CustomAmmoDisplay()
		return {Draw = false}
	end

	local worldModel = ClientsideModel(SWEP.WorldModel)

	worldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()

		if (IsValid(owner)) then
            -- Specify a good position
			local offsetVec = Vector(5, -2.7, -3.4)
			local offsetAng = Angle(180, 0, 0)
			
			local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
			if (!boneid) then return end

			local matrix = owner:GetBoneMatrix(boneid)
			if (!matrix) then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			worldModel:SetPos(newPos)
			worldModel:SetAngles(newAng)

            worldModel:SetupBones()
		else
			worldModel:SetPos(self:GetPos())
			worldModel:SetAngles(self:GetAngles())
		end

		worldModel:DrawModel()
	end
end

function SWEP:Ammo1()
	return 500
end

function SWEP:GetViewModelPosition(EyePos, EyeAng)
	local Mul = 1.0

	local Offset = self.IronSightsPos

	if (self.IronSightsAng) then
        EyeAng = EyeAng * 1
        
		EyeAng:RotateAroundAxis(EyeAng:Right(), self.IronSightsAng.x * Mul)
		EyeAng:RotateAroundAxis(EyeAng:Up(), self.IronSightsAng.y * Mul)
		EyeAng:RotateAroundAxis(EyeAng:Forward(), self.IronSightsAng.z * Mul)
	end

	local Right = EyeAng:Right()
	local Up = EyeAng:Up()
	local Forward = EyeAng:Forward()

	EyePos = EyePos + Offset.x * Right * Mul
	EyePos = EyePos + Offset.y * Forward * Mul
	EyePos = EyePos + Offset.z * Up * Mul
	
	return EyePos, EyeAng
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextIdle")
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())

	self:Idle()

	return true
end

function SWEP:Holster(weapon)
	if (CLIENT) then return end

	if (self.Sound) then
		self.Sound:Stop()
		self.Sound = nil
	end

	return true
end

function SWEP:OnDrop()
	if (self.Sound) then
		self.Sound:Stop()
		self.Sound = nil
	end

	self.Primary.DefaultClip = 0
end

function SWEP:DoEffect(color)
	if (!color) then return end

	local effectData = EffectData()

	effectData:SetAttachment(1)
	effectData:SetEntity(self.Owner)
	effectData:SetOrigin(self.Owner:GetShootPos())
	effectData:SetNormal(self.Owner:GetAimVector())
	effectData:SetColor(color.r)
	effectData:SetHitBox(color.g) -- Please, don't judge.
	effectData:SetMagnitude(color.b)
	effectData:SetScale(1)

	util.Effect("applicator_effect", effectData)
end

function SWEP:DoExtinguish(chemicalID)
	if (self:Ammo1() < 1) then return end
	if (!chemicalID) then return end

	local chemicalItem = ix.item.list[chemicalID]
	if (!chemicalItem) then return end
	
	local chemicalColor = chemicalItem.chemicalColor
	if (!chemicalColor) then return end
	
	if (CLIENT) then
		if (self.Owner == LocalPlayer()) then self:DoEffect(chemicalColor) end
		
		return
	end

	local trace = self.Owner:GetEyeTrace()
	local position = trace.HitPos

	for _, entity in pairs(ents.FindInSphere(position, 80)) do
		if (math.random(0, 100) > 90) then
			if (IsValid(entity) and entity:GetPos():Distance(self:GetPos()) <= 256 and entity:GetClass() == "ix_infestation_prop" and !entity:GetSprayed()) then
				local infestation = ix.infestation.types[entity:GetType()]

				if (!infestation or !infestation.chemical or infestation.chemical != chemicalID) then return end

				entity:OnSprayed(chemicalColor)
			end
		end
	end

	self:DoEffect(chemicalColor)
end

function SWEP:PrimaryAttack()
	local client = self.Owner
	local character = client:GetCharacter()
    local inventoryID = character:GetInventory():GetID()
    local inventory = ix.item.inventories[inventoryID]
	local CurTime = CurTime()

	local tankEnt
	
    for _, items in pairs(inventory.slots) do
        for _, item in pairs(items) do
			local entity = item:GetData("connected", nil)

            if (entity) then
                entity = Entity(entity)

				if (entity and IsValid(entity)) then
					tankEnt = entity

					if (entity:GetChemicalVolume() <= 0) then
						entity:SetChemicalType("")
						entity:SetColor(Color(255, 255, 255))

						return
					end
				end
            end
		end
	end

	if (!tankEnt) then return end
	if (self:GetNextPrimaryFire() > CurTime) then return end

	if (IsFirstTimePredicted()) then
		self:DoExtinguish(tankEnt:GetChemicalType())

		if (SERVER) then
			if (self.Owner:KeyPressed(IN_ATTACK) or !self.Sound) then
				self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

				self.Sound = CreateSound(self.Owner, Sound("weapons/applicator/fire1.wav"))

				self:Idle()
			end

			if (self:Ammo1() > 0 and self.Sound) then self.Sound:Play() end
		end
	end

	self:SetNextPrimaryFire(CurTime + 0.05)

	local deductTime = self.nextTankDeduction or 0
	
	if (deductTime <= CurTime) then
		tankEnt:SetChemicalVolume(tankEnt:GetChemicalVolume() - 1)
		self.nextTankDeduction = CurTime + 1
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:PlaySound()
	self:EmitSound("weapons/applicator/release1.wav", 100, math.random(95, 110))
end

function SWEP:Think()
	if (self:GetNextIdle() > 0 and CurTime() > self:GetNextIdle()) then
		self:DoIdleAnimation()
		self:Idle()
	end

	if (self:GetNextSecondaryFire() > CurTime() or CLIENT) then return end

	if (self.Sound and self.Sound:IsPlaying() and self:Ammo1() < 1) then
		self.Sound:Stop()
		self.Sound = nil
		self:PlaySound()
		self:DoIdleAnimation()
		self:Idle()
	end

	if (self.Owner:KeyReleased(IN_ATTACK) or (!self.Owner:KeyDown(IN_ATTACK) and self.Sound)) then
		self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)

		if (self.Sound) then
			self.Sound:Stop()
			self.Sound = nil
			if (self:Ammo1() > 0) then
				self:PlaySound()
				if (!game.SinglePlayer()) then self:CallOnClient("PlaySound", "") end
			end
		end

		self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
		self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())

		self:Idle()
	end
end

function SWEP:DoIdleAnimation()
	if (self.Owner:KeyDown(IN_ATTACK) and self:Ammo1() > 0) then self:SendWeaponAnim(ACT_VM_IDLE_1) return end
	if (self.Owner:KeyDown(IN_ATTACK) and self:Ammo1() < 1) then self:SendWeaponAnim(ACT_VM_IDLE_EMPTY) return end

	self:SendWeaponAnim(ACT_VM_IDLE)
end

function SWEP:Idle()
	self:SetNextIdle(CurTime() + self:GetAnimationTime())
end

function SWEP:GetAnimationTime()
	local time = self:SequenceDuration()

	if (time == 0 and IsValid(self.Owner) and !self.Owner:IsNPC() and IsValid(self.Owner:GetViewModel())) then
		time = self.Owner:GetViewModel():SequenceDuration()
	end
	
	return time
end
