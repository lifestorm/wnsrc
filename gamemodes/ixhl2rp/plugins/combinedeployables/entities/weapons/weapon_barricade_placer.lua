--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local AddCSLuaFile = AddCSLuaFile
local Model = Model
local Sound = Sound
local IsValid = IsValid
local ents = ents
local Angle = Angle
local pairs = pairs
local game = game
local math = math
local LocalPlayer = LocalPlayer
local draw = draw
local ScrW = ScrW
local ScrH = ScrH
local Color = Color

AddCSLuaFile()

SWEP.PrintName = "Barricade Placer"
SWEP.Author = "JohnyReaper"
SWEP.Purpose = ""
SWEP.Category = "HL2 RP"

SWEP.Slot = 0
SWEP.SlotPos = 1

SWEP.ViewModel = Model("")
SWEP.WorldModel = Model("")
SWEP.ViewModelFOV = 70
SWEP.UseHands = false
SWEP.HoldType = "normal"

SWEP.Ent = "ix_combinebarricade"
SWEP.BarricadePlace = nil
SWEP.PreviewModel = "models/props_combine/combine_barricade_short01a.mdl"

SWEP.Spawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo	= "none"

SWEP.DrawAmmo = false

SWEP.IsAlwaysLowered = true
SWEP.FireWhenLowered = true

local SwingSound = Sound("WeaponFrag.Throw")

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	if CLIENT then
		self:GhostProp()
	end
end

function SWEP:Deploy()
	if CLIENT then
		self:GhostProp()
	end
end

function SWEP:GhostProp()
	if (IsValid(self.ghostProp)) then self.ghostProp:Remove() end
	self.ghostProp = ents.CreateClientProp()
	self.ghostProp:SetModel(self.PreviewModel)
--	self.ghostProp:SetMaterial("models/wireframe")
	self.ghostProp:Spawn()
	self.ghostProp:Activate()
	self.ghostProp:SetParent(self.Owner)
	self.ghostProp:SetRenderMode(RENDERMODE_TRANSALPHA)
end


function SWEP:CalcViewModelView(vm, oldPos, oldAng, pos, ang)
	local oldPos = vm:GetPos()
	local oldAng = vm:GetAngles()

	local newPos = pos + ang:Up() * 5 + ang:Forward() * -12
	return newPos, ang
end

function SWEP:CheckCollisionBox()
	local hitVector = self.Owner:GetPos() + Angle(0, self.Owner:GetAngles().y, 0):Forward() * 55

	local check = true

	for k, v in pairs(ents.FindInSphere(hitVector, 15)) do

		if (check) then
			check = false
		end
	end

	return check
end

function SWEP:PrimaryAttack()
	local tr = self.Owner:GetEyeTrace()
	if (game.SinglePlayer()) then self:CallOnClient("PrimaryAttack") end

	if (SERVER) then
		self.Owner:SetAnimation(PLAYER_ATTACK1)
	end

		if (tr.HitWorld) then
				if (!self.BarricadePlace) then
					self.BarricadePlace = self.Owner:GetPos() + Angle(0, self.Owner:GetAngles().y, 0):Forward() * 65 + Angle(0, self.Owner:GetAngles().y, 0):Right() * -10 + Angle(0, self.Owner:GetAngles().y, 0):Up() * 30
					self.testowyang = Angle(0, self.Owner:GetAngles().y + 330, 0):SnapTo("y", 1)
				end

				if (SERVER) then
					if (self.BarricadePlace) then
						local angles = self.testowyang
						angles.p = 0
						angles.r = 0
						angles:RotateAroundAxis(angles:Up(), 360)

						local barricadeEnt = ents.Create(self.Ent)
						barricadeEnt:SetPos(self.BarricadePlace)
						barricadeEnt:SetAngles(angles)
						barricadeEnt:Spawn()
						barricadeEnt:Activate()

						if (self.Owner.previousWep) then
							self.Owner:SelectWeapon(self.Owner.previousWep)
							self.Owner.previousWep = nil
						end

						self:Remove()
					end
				end

				self.Owner:EmitSound("physics/metal/metal_canister_impact_soft"..math.random(1,3)..".wav", 60, 100, 0.5)
		end
end

function SWEP:SecondaryAttack()
	if (SERVER) then
		local char = self.Owner:GetCharacter()
		local inventory = char:GetInventory()

		inventory:Add("barricade_placer")

		if (self.Owner.previousWep) then
			self.Owner:SelectWeapon(self.Owner.previousWep)
			self.Owner.previousWep = nil
		end
		self:Remove()
	end
end

if (CLIENT) then
	function SWEP:DrawHUD()
		local ply = LocalPlayer()
		if (!ply:Alive()) then return end

 		draw.SimpleTextOutlined("Press LMB to place", "DermaLarge", ScrW() / 2, ScrH()-230, Color(250,250,250), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 250))
		draw.SimpleTextOutlined("Press RMB to exit", "DermaLarge", ScrW() / 2, ScrH()-200, Color(250,250,250), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 250))
	end
end

function SWEP:Think()
	local tr = self.Owner:GetEyeTrace()

	if (CLIENT) then

		if (IsValid(self.ghostProp)) then
			local pozz = self.BarricadePlace
			local angg = self.testowyang

			self.ghostProp:SetPos(self.Owner:GetPos() + Angle(0, self.Owner:GetAngles().y, 0):Forward() * 65 + Angle(0, self.Owner:GetAngles().y, 0):Right() * -10 + Angle(0, self.Owner:GetAngles().y, 0):Up() * 30 )
			self.ghostProp:SetAngles(Angle(0, self.Owner:GetAngles().y + 330, 0):SnapTo("y", 1))

		else
			self:GhostProp()
		end
	end

end

function SWEP:PreDrawViewModel()
	if (CLIENT) then
		if (!IsValid(self.ghostProp)) then
			self:GhostProp()
		end
	end
end

function SWEP:Holster()
	if (CLIENT) then
		if (IsValid(self.ghostProp)) then
			self.ghostProp:Remove()
		end
	end

	if (SERVER) then
		self:Remove()
	end

	return true
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:OnRemove()
	if (CLIENT) then
		if (IsValid(self.ghostProp)) then
			self.ghostProp:Remove()
		end
	end
end