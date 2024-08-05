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

SWEP.PrintName = "Workbench Placer"
SWEP.Author = "JohnyReaper/Fruity"
SWEP.Purpose = ""
SWEP.Category = "HL2 RP"

SWEP.Slot = 0
SWEP.SlotPos = 1

SWEP.ViewModel = Model("")
SWEP.WorldModel = Model("")
SWEP.ViewModelFOV = 70
SWEP.UseHands = false
SWEP.HoldType = "normal"

SWEP.Ent = "ix_item"
SWEP.BarricadePlace = nil
SWEP.item = false

SWEP.PreviewModel = false

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

if (CLIENT) then
	SWEP.nextModelRequest = CurTime()

	net.Receive("ixRequestWorkBenchGhostModel", function()
		local model = net.ReadString()

		if LocalPlayer().ghostProp and IsValid(LocalPlayer().ghostProp) then
			LocalPlayer().ghostProp:SetModel(model)
		end
	end)
else
	util.AddNetworkString("ixRequestWorkBenchGhostModel")

	net.Receive("ixRequestWorkBenchGhostModel", function(_, client)
		local weapon = client:GetActiveWeapon()
		if IsValid(weapon) and weapon.GetClass and weapon:GetClass() == "weapon_workbench_placer" then
			net.Start("ixRequestWorkBenchGhostModel")
			net.WriteString(weapon.PreviewModel)
			net.Send(client)
		end
	end)
end

function SWEP:GhostProp()
	if (IsValid(self.ghostProp)) then self.ghostProp:Remove() end
	self.ghostProp = ents.CreateClientProp()

	local curTime = CurTime()
	if !self.PreviewModel and self.nextModelRequest <= curTime then
		LocalPlayer().ghostProp = self.ghostProp

		net.Start("ixRequestWorkBenchGhostModel")
		net.SendToServer()

		self.nextModelRequest = curTime + 2
		return
	end

--	self.ghostProp:SetMaterial("models/wireframe")
	self.ghostProp:Spawn()
	self.ghostProp:Activate()
	self.ghostProp:SetParent(self.Owner)
	self.ghostProp:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function SWEP:CalcViewModelView(vm, oldPos, oldAng, pos, ang)
	local newPos = pos + ang:Up() * 5 + ang:Forward()
	return newPos, ang
end

function SWEP:SetInfo(uniqueID, model)
	self.item = uniqueID
	self.PreviewModel = model
end

function SWEP:PrimaryAttack()
	local tr = self.Owner:GetEyeTrace()
	if (game.SinglePlayer()) then self:CallOnClient("PrimaryAttack") end

	if (SERVER) then
		self.Owner:SetAnimation(PLAYER_ATTACK1)
	end

	if (tr.HitWorld) then
		if (!self.BarricadePlace) then
			self.BarricadePlace = self.Owner:GetPos() + Angle(0, self.Owner:GetAngles().y, 0):Forward() * 50 + Angle(0, self.Owner:GetAngles().y, 0):Right() * -10 + Angle(0, self.Owner:GetAngles().y, 0):Up()
			self.testowyang = Angle(0, self.Owner:GetAngles().y + 180, 0):SnapTo("y", 1)
		end

		if (SERVER) then
			if (self.BarricadePlace) then
				local angles = self.testowyang
				angles.p = 0
				angles.r = 0
				angles:RotateAroundAxis(angles:Up(), 360)

				if (self.item) then
					local client = self:GetOwner()
					local char = client.GetCharacter and client:GetCharacter()
					local id = char and char.GetID and char:GetID()
					local actualItem = char:GetInventory():HasItem(self.item)

					if (actualItem) then
						actualItem:Remove()

						local currentItems = client:GetNetVar("visibleItems", {})
						local itemName = ix.item.list[self.item].name
						
						if (currentItems[itemName]) then
							currentItems[itemName] = nil
						end
						
						client:SetNetVar("visibleItems", currentItems)

						if (id) then
							ix.item.Spawn(self.item, self.BarricadePlace, function(_, entity)
								if IsValid(entity) then
									local physObj = entity:GetPhysicsObject()
									if IsValid(physObj) then
										physObj:EnableMotion( false )
									end
								end
							end, angles, {placer = id})
						end
					end
				end

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
	if (CLIENT) then

		if (IsValid(self.ghostProp)) then
			self.ghostProp:SetPos(self.Owner:GetPos() + Angle(0, self.Owner:GetAngles().y, 0):Forward() * 50 + Angle(0, self.Owner:GetAngles().y, 0):Right() * -10 + Angle(0, self.Owner:GetAngles().y, 0):Up() )
			self.ghostProp:SetAngles(Angle(0, self.Owner:GetAngles().y + 180, 0):SnapTo("y", 1))

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