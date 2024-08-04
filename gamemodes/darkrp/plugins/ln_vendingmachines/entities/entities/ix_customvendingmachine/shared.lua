--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Vending Machine"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "ID")
	self:NetworkVar("Bool", 1, "Locked")
end

function ENT:Initialize()
	self.buttons = {}

	local position = self:GetPos()
	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

	self.buttons[1] = position + f * 18 + r * -24.4 + u * 4.3
	self.buttons[2] = position + f * 18 + r * -24.4 + u * 2.25
	self.buttons[3] = position + f * 18 + r * -24.4 + u * 0.20
	self.buttons[4] = position + f * 18 + r * -24.4 + u * -1.85
	self.buttons[5] = position + f * 18 + r * -24.4 + u * -3.9
	self.buttons[6] = position + f * 18 + r * -24.4 + u * -5.95
	self.buttons[7] = position + f * 18 + r * -24.4 + u * -8
	self.buttons[8] = position + f * 18 + r * -24.4 + u * -10.05

	if (SERVER) then
		self:SetModel("models/willardnetworks/misc/customvendingmachine.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		self:SetLocked(true)

		local labels = {}
		local buttons = {}
		local prices = {}
		local stocks = {}

		for i = 1, 8 do
			labels[i] = ""
			buttons[i] = true
			prices[i] = 0
			stocks[i] = false
		end

		self:SetNetVar("labels", labels)
		self:SetNetVar("buttons", buttons)
		self:SetNetVar("prices", prices)
		self:SetNetVar("stocks", stocks)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	else
		local uniqueID = "VendingMachineAmbience" .. self:EntIndex()
		local time = 1

		timer.Simple(1, function()
			timer.Adjust(uniqueID, 1.7461677789688)
		end)

		timer.Create(uniqueID, time, 0, function()
			if (IsValid(self)) then
				self:EmitSound("vendingmachinehum_loop.wav", 65, 100, 0.15)
			else
				timer.Remove(uniqueID)
			end
		end)
	end
end

function ENT:GetNearestButton(client)
	client = client or (CLIENT and LocalPlayer())

	if (self.buttons) then
		local position = self:GetPos()
		local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

		self.buttons[1] = position + f * 18 + r * -24.4 + u * 4.3
		self.buttons[2] = position + f * 18 + r * -24.4 + u * 2.25
		self.buttons[3] = position + f * 18 + r * -24.4 + u * 0.20
		self.buttons[4] = position + f * 18 + r * -24.4 + u * -1.85
		self.buttons[5] = position + f * 18 + r * -24.4 + u * -3.9
		self.buttons[6] = position + f * 18 + r * -24.4 + u * -5.95
		self.buttons[7] = position + f * 18 + r * -24.4 + u * -8
		self.buttons[8] = position + f * 18 + r * -24.4 + u * -10.05

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		local hitPos = trace.HitPos

		if (hitPos) then
			for buttonNum, buttonPos in pairs(self.buttons) do
				if (buttonPos:Distance(hitPos) <= 2) then
					return buttonNum
				end
			end
		end
	end
end

function ENT:OnRemove()
	if (SERVER) then
		if (!ix.shuttingDown) then
			local index = self:GetID()

			if (!self.ixIsSafe and ix.entityDataLoaded and index) then
				local inventory = index != 0 and ix.item.inventories[index]

				if (inventory) then
					ix.item.inventories[index] = nil

					local query = mysql:Delete("ix_items")
						query:Where("inventory_id", index)
					query:Execute()

					query = mysql:Delete("ix_inventories")
						query:Where("inventory_id", index)
					query:Execute()

					hook.Run("ContainerRemoved", self, inventory)
				end
			end
		end
	else
		self:StopSound("vendingmachinehum_loop.wav")

		timer.Simple(0.1, function()
			if (!IsValid(self)) then
				timer.Remove("VendingMachineAmbience" .. self:EntIndex())
			end
		end)
	end
end
