--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

ENT.scanBox = {
	mins = Vector(-8.344721, -7.158762, 39.878693),
	maxs = Vector(2.849499, 6.975823, 49.807785)
}

ENT.nextScan = 0
ENT.batteryChargeReq = 1

function ENT:CreateUserTimer()
	timer.Create("ixDiscScanner" .. self:GetCreationID(), 5, 0, function()
		if !IsValid(self) then return end

		local user = self:GetUsedBy()
		if user == self then return timer.Remove("ixDiscScanner" .. self:GetCreationID()) end

		if (!IsValid(user) or !user:IsPlayer() or user:EyePos():DistToSqr(self:GetPos()) > 62500 or user:IsAFK()) then
			self:SetUsedBy(self)

			net.Start("ix.terminal.turnOff")
				net.WriteEntity(self)
			net.Broadcast()

			timer.Remove("ixDiscScanner" .. self:GetCreationID())
		end
	end)
end

function ENT:OnRemove()
	timer.Remove("ixDiscScanner" .. self:GetCreationID())
end

function ENT:HasBattery()
	return IsValid(self.attachedBattery)
end

function ENT:BatteryHasCharge(charge)
	return self.attachedBattery:GetData("charge", 0) >= charge
end

function ENT:TakeBatteryCharge(charge)
	ix.item.instances[self.attachedBattery.ixItemID]:SetData("charge", self.attachedBattery:GetData("charge") - charge)
end

function ENT:Initialize()
	self:SetModel("models/willardnetworks/gearsofindustry/wn_machinery_02.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetTrigger(true)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:SearchForItem()
	local mins = self:LocalToWorld(self.scanBox.mins)
	local maxs = self:LocalToWorld(self.scanBox.maxs)
	for _, item in pairs(ents.FindInBox(mins, maxs)) do
		if item:GetClass() != "ix_item" then continue end

		return item
	end
end

function ENT:Scan(client)
	if self.bScanning then return end

	local item = self:SearchForItem()

	if item then
		if !ix.fabrication:GetTech(item:GetItemID()) and !ix.fabrication:GetAdvancedTech(item:GetItemID()) then
			return "This item cannot be encoded into data disc."
		end
		if self.attachedDisc:GetData("item", "") != "" then
			return "This disc already have data on it."
		end
		if !self:HasBattery() then return "Data-disc encoder requires combine battery in order to function!" end
		if !self:BatteryHasCharge(self.batteryChargeReq) then return "Battery don't have enough charge." end
		self:TakeBatteryCharge(self.batteryChargeReq)

		item:GetPhysicsObject():EnableMotion(false)

		local ef = EffectData()
		ef:SetEntity(item)
		ef:SetScale(self.scanTimer)
		util.Effect("scanGlow", ef)

		self:SetNetVar("scanning", item)
		self.bScanning = true

		if client and client:IsPlayer() then
			net.Start("ix.terminal.Scan")
				net.WriteEntity(self)
			net.Send(client)
		end

		item.inUse = true
		self.attachedDisc.inUse = true

		self:EmitSound("wn_goi/disc_encode_start.wav", 55, 100, 1, nil, 0, 11)
		timer.Simple(SoundDuration("wn_goi/disc_encode_start.wav"), function()
			self:EmitSound("wn_goi/disc_encode_loop.wav", 55, 100, 1, nil, 0, 11)
		end)

		timer.Simple(self.scanTimer, function()
			if (item and IsValid(item)) then
				item.inUse = nil
				item:GetPhysicsObject():EnableMotion(true)
			end

			if (self.attachedDisc and IsValid(self.attachedDisc)) then
				self.attachedDisc.inUse = nil
			end

			if !IsValid(self) or !IsValid(item) or !IsValid(self.attachedDisc) then
				if IsValid(self) then
					self:StopSound("wn_goi/disc_encode_loop.wav")
				end
				return "Error!"
			end

			self.bScanning = false
			self:SetNetVar("scanning", nil)
			self:StopSound("wn_goi/disc_encode_loop.wav")
			self:EmitSound("wn_goi/disc_encode_stop.wav", 55, 100, 1, nil, 0, 11)

			ix.item.instances[self.attachedDisc.ixItemID]:SetData("item", item:GetItemID())
			self:SetDiscItemID(self.attachedDisc:GetData("item", ""))

			ef = EffectData()
			ef:SetOrigin(self:LocalToWorld(Vector(4.453487, 0.434061, 39.031250)))
			util.Effect("scanVaporize", ef)
			item:Remove()

			self:EmitSound("ambience/3d-sounds/steam/steam07.wav")

			if client and client:IsPlayer() then
				net.Start("ix.terminal.DiscAttach")
					net.WriteEntity(self)
					net.WriteString(self:GetDiscItemID() or "")
				net.Send(client)
			end
		end)
	else
		return "There's no items in terminal depot."
	end
end

function ENT:SetDiscItemID(itemID)
	self.dItemID = itemID
end

function ENT:GetDiscItemID()
	return self.dItemID or ""
end

function ENT:OnDiscAttach(disc)
	self:SetDiscItemID(disc:GetData("item", ""))
	self:SetNetVar("attachedDisc", disc)

	local client = self:GetUsedBy()

	if client and client:IsPlayer() then
		net.Start("ix.terminal.DiscAttach")
			net.WriteEntity(self)
			net.WriteString(self:GetDiscItemID() or "")
		net.Send(client)
	end
end

function ENT:OnDiscDetach(disc)
	self:SetDiscItemID(nil)
	self:SetNetVar("attachedDisc", nil)

	local client = self:GetUsedBy()

	if client and client:IsPlayer() then
		net.Start("ix.terminal.DiscDetach")
			net.WriteEntity(self)
		net.Send(client)
	end
end

function ENT:StartTouch(entity)
	if (entity:GetClass() != "ix_item" or entity.attached) then return end
	local attachmentPos = self:GetPos()
	local attachmentAngle = self:GetAngles()

	if (entity:GetItemID() == "combinebattery") then
		if (self.attachedBattery and self.attachedBattery != NULL) then return end

		attachmentPos = self:LocalToWorld(Vector(-3.006432, -14.451619, 10.576401))
		attachmentAngle = self:LocalToWorldAngles(Angle(-0.281, -89.269, 89.798))
		self.attachedBattery = entity
	elseif (entity:GetItemID() == "datadisc") then
		if (self.attachedDisc and self.attachedDisc != NULL) then return end

		attachmentPos = self:GetPos() + self:GetUp() * 55.4 + self:GetRight() * -4.5 + self:GetForward() * 5
		self.attachedDisc = entity
		self:OnDiscAttach(entity)
	else return	end

	local physObj = entity:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	entity:SetPos(attachmentPos)
	entity:SetAngles(attachmentAngle)
	entity:SetParent(self)

	entity.attached = self

	self:EmitSound("physics/metal/weapon_impact_soft" .. math.random(1, 3) .. ".wav")
end