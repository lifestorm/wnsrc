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

SWEP.Base				= "weapon_base"
SWEP.PrintName			= "Suitcase"
SWEP.Category			= "HL2 RP"
SWEP.Author				= "Exobit"
SWEP.Instructions		= "Nothing but an old fashioned suitcase"


SWEP.ViewModel			= ""
SWEP.WorldModel			= "models/weapons/w_suitcase_passenger.mdl"
SWEP.ViewModelFOV		= 47
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.HoldType			= "normal"
SWEP.UseHands			= true
SWEP.Weight				= 0
SWEP.AutoSwitchTo		= false
SWEP.Spawnable			= false
SWEP.Drop				= false
SWEP.IsAlwaysLowered	= true

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end

function SWEP:CanPrimaryAttack()
	return false
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	y = y + 10
	x = x + 10
	wide = wide -20

	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( Material( "hud/"..self.ClassName..".png"))

	surface.DrawTexturedRect( x + wide/4 + 0.5,y,wide / 2,wide / 2)
end

// https://wiki.facepunch.com/gmod/WEAPON:DrawWorldModel

if CLIENT then
	function SWEP:Initialize()
		self.worldModel = ClientsideModel(self.WorldModel)
		self.worldModel:SetNoDraw(true)
	end

	function SWEP:DrawWorldModel()
		local owner = self.Owner
		local worldModel = self.worldModel

		if owner and worldModel then
			local offsetVec = Vector(4.8, 0, 0)
			local offsetAng = Angle(260, 0, 0)
			
			local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
			if !boneid then return end

			local matrix = owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			worldModel:SetPos(newPos)
			worldModel:SetAngles(newAng)
			worldModel:SetupBones()

			worldModel:DrawModel()
		end
	end

	function SWEP:OnRemove()
		if IsValid(self.worldModel) then
			self.worldModel:Remove()
			self.worldModel = nil
		end
	end
end
