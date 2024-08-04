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

ENT.nextInteraction = 0
ENT.interactionCooldown = 0.25
ENT.batteryChargeReq = 1

function ENT:CreateUserTimer()
	timer.Create("ixFabricator" .. self:GetCreationID(), 5, 0, function()
		if !IsValid(self) then return end

		local user = self:GetUsedBy()
		if user == self then return timer.Remove("ixFabricator" .. self:GetCreationID()) end

		if (!IsValid(user) or !user:IsPlayer() or user:EyePos():DistToSqr(self:GetPos()) > 62500 or user:IsAFK()) then
			self:SetUsedBy(self)

			net.Start("ix.terminal.turnOff")
				net.WriteEntity(self)
			net.Broadcast()

			timer.Remove("ixFabricator" .. self:GetCreationID())
		end
	end)
end

function ENT:OnRemove()
	timer.Remove("ixFabricator" .. self:GetCreationID())
end

function ENT:Initialize()
	self:SetModel("models/willardnetworks/gearsofindustry/wn_machinery_03.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetTrigger(true)

	local physObj = self:GetPhysicsObject()

	self.opened = false

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
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

function ENT:SetDiscItemID(itemID)
	self.dItemID = itemID
end

function ENT:GetDiscItemID()
	return self.dItemID or ""
end

function ENT:OnDiscAttach(disc)
	local client = self:GetUsedBy()

	if !ix.fabrication:Get(disc:GetData("item", "")) then
		if client and client:IsPlayer() then
			client:NotifyLocalized("Data disc is corrupted.")
		end
		return
	end

	self:SetDiscItemID(disc:GetData("item", ""))
	self:SetNetVar("attachedDisc", disc)

	if client and client:IsPlayer() then
		net.Start("ix.terminal.DiscAttach")
			net.WriteEntity(self)
			net.WriteString(self:GetDiscItemID() or "")
		net.Send(client)
	end
end

function ENT:OnDiscDetach(disc)
	self:SetDiscItemID("")
	self:SetNetVar("attachedDisc", nil)

	local client = self:GetUsedBy()

	if client and client:IsPlayer() then
		net.Start("ix.terminal.DiscDetach")
			net.WriteEntity(self)
		net.Send(client)
	end
end

ENT.dispenseBox = {
	mins = Vector(5.035011, 4.218863, 45.633255),
	maxs = Vector(17.356579, -23.244238, 33.593277)
}

function ENT:SearchForItem()
	local mins = self:LocalToWorld(self.dispenseBox.mins)
	local maxs = self:LocalToWorld(self.dispenseBox.maxs)
	for _, item in pairs(ents.FindInBox(mins, maxs)) do
		if item:GetClass() != "ix_item" then continue end
		if self.attachedDisc and item == self.attachedDisc then continue end

		return item
	end
end

ENT.nextDepotToggle = 0

function ENT:OpenDepot()
	self:ResetSequence("Open")
	self.opened = true
end

function ENT:CloseDepot()
	self:ResetSequence("Close")
	self.opened = false
end

function ENT:ToggleDepot()
	if self.bSynthesizing then return "Fabricator is active: you can't do anything else with it yet." end
	if self.nextDepotToggle > CurTime() then return "You have to wait a bit before using this again." end
	if self.opened then self:CloseDepot() else self:OpenDepot() end
	self.nextDepotToggle = CurTime() + 2.5
end

function ENT:Recycle(client)
	if self.bSynthesizing then return "Fabricator is active: you can't do anything else with it yet." end
	if self.nextInteraction > CurTime() then return "You have to wait a bit until next interaction." end
	self.nextInteraction = CurTime() + self.interactionCooldown
	if !IsValid(client) or !client:IsPlayer() then return "Invalid client." end
	if !self:HasBattery() then return "Fabricator requires combine battery in order to function!" end
	if !self:BatteryHasCharge(self.batteryChargeReq) then return "Battery don't have enough charge." end
	self:TakeBatteryCharge(self.batteryChargeReq)

	local recycledItem
	local item = self:SearchForItem()
	if !item then
		return "There's no item in fabricator depot."
	end

	local itemID = item:GetItemID()
	for _, material in pairs(ix.fabrication.MAIN_MATS) do
		if material == itemID then
			return "You can't recycle this!"
		end
	end

	local bClosedDepot = true

	if self.opened then
		self:CloseDepot()
		bClosedDepot = false
	end
	self.bSynthesizing = true

	timer.Simple(bClosedDepot and 0.1 or 2.5, function()
		if (!IsValid(self)) then return end
		if (!IsValid(item)) then
			self.bSynthesizing = false
			return self:OpenDepot()
		end

		self:EmitSound("ambience/3d-sounds/electronics/hipowerup_01.wav")
		recycledItem = item.ixItemID
		item:Remove()

		timer.Simple(6.6, function()
			if (!IsValid(self)) then return end

			for _, pipe in pairs(self.smallSteamPipes) do
				ParticleEffect("steamjet", self:LocalToWorld(pipe.vec), self:LocalToWorldAngles(pipe.ang), self)
			end

			self:EmitSound("ambience/3d-sounds/electronics/openingpowerup_13.wav")
			self:DispenseRecycledMaterials(recycledItem)
		end)
	end)
end

function ENT:DispenseRecycledMaterials(item)
	item = ix.item.instances[item]

	if !item then
		self.bSynthesizing = false
		return self:OpenDepot()
	end

	local itemToDispense
	local matAmount = item.category != "Ammunition" and item:GetData("stack", 1) or 1

	if item.category == "Food" or item.category == "Ingredient" then
		itemToDispense = ix.fabrication.MAIN_MATS["bio"]
	else
		itemToDispense = ix.fabrication.MAIN_MATS["tech"]
	end

	local fabrication = ix.fabrication:Get(item.uniqueID)
	if fabrication then
		itemToDispense = ix.fabrication.MAIN_MATS[fabrication:GetCategory()]
		if item.category == "Ammunition" then
			matAmount = fabrication:GetMainMaterialCost()
		else
			matAmount = fabrication:GetMainMaterialCost() * item:GetData("stack", 1)
		end
	end

	if matAmount > 1 then
		self:MultipleDispense(itemToDispense, matAmount)
	else
		self:Dispense(itemToDispense)
	end
end

function ENT:MultipleDispense(item, amount)
	self.mDispensing = {item = item, amount = amount}

	self:Dispense(item)
end

function ENT:Dispense(item)
	ix.item.Spawn(item, self:GetPos(), function(_, ent)
		ent:SetPos(self:GetAttachment(1).Pos)

		self.dispensedObject = ent
		ent.dispenser = self

		ent:GetPhysicsObject():EnableMotion(false)
	end, self:GetAngles())

	self:OpenDepot()
end

function ENT:OnDispensedItemTaken()
	if self.mDispensing then
		if self.mDispensing.amount > 1 then
			self:CloseDepot()
		end

		self.mDispensing.amount = self.mDispensing.amount - 1

		timer.Simple(2, function()
			if (!IsValid(self)) then return end
			if (!self.mDispensing) then return end

			self:Dispense(self.mDispensing.item)
		end)

		if self.mDispensing.amount > 0 then
			return
		else
			self.mDispensing = nil
		end
	end

	self.bSynthesizing = false

	if self.opened and self.mDispensing and self.mDispensing.amount > 0 then
		self:CloseDepot()
	end
end

function ENT:SynthesizeFabrication(client, fabrication, isBulk, amount)
	if self.bSynthesizing then return "Fabricator is active: you can't do anything else with it yet." end
	if self.nextInteraction > CurTime() then return "You have to wait a bit until next interaction." end
	self.nextInteraction = CurTime() + self.interactionCooldown
	if !IsValid(client) or !client:IsPlayer() then return "Invalid client." end
	fabrication = ix.fabrication:Get(fabrication)
	if !fabrication then return "Selected fabrication is invalid." end
	if !self:HasBattery() then return "Fabricator requires combine battery in order to function!" end
	if !self:BatteryHasCharge(self.batteryChargeReq) then return "Battery don't have enough charge." end

	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local resourceItemID = ix.fabrication.MAIN_MATS[fabrication:GetCategory()]
	local resourceItem = ix.item.list[resourceItemID]
	local hasItem = inventory:GetItemsByUniqueID(resourceItemID)
	local isStackable = resourceItem.maxStackSize != nil
	local resourcesToTake = fabrication:GetMainMaterialCost()

	if (isBulk) then
		resourcesToTake = resourcesToTake * amount
	end

	if !hasItem or !istable(hasItem) or table.IsEmpty(hasItem) then
		return "Unable to find required materials in your inventory."
	end

	local totalItemCount = 0

	if isStackable then
		for _, rItem in pairs(hasItem) do
			totalItemCount = totalItemCount + rItem:GetStackSize()
		end

		if totalItemCount >= resourcesToTake then
			for _, rItem in pairs(hasItem) do
				if resourcesToTake <= 0 then
					break
				end

				local actualStackSize = rItem:GetStackSize()
				rItem:RemoveStack(resourcesToTake)
				resourcesToTake = resourcesToTake - actualStackSize
			end
		else
			return "You don't have enough resources for this fabrication."
		end
	else
		totalItemCount = totalItemCount + #hasItem

		if totalItemCount >= resourcesToTake then
			for _, rItem in pairs(hasItem) do
				if resourcesToTake <= 0 then break end
				rItem:Remove()
				resourcesToTake = resourcesToTake - 1
			end
		else
			return "You don't have enough resources for this fabrication."
		end
	end

	if self.opened then
		self:CloseDepot()
	end

	self.bSynthesizing = true

	self:TakeBatteryCharge(self.batteryChargeReq)

	self:EmitSound("ambience/3d-sounds/electronics/hipowerup_01.wav")

	-- i frickin' love timer simple pyramids 
	timer.Simple(6.6, function()
		if (!IsValid(self)) then return end

		self:EmitSound("ambience/3d-sounds/steam/steam2.wav")
		ParticleEffect("steam_jet_50", self:LocalToWorld(self.bigSteamJet.vec), self:LocalToWorldAngles(self.bigSteamJet.ang), self)

		timer.Simple(2.9, function()
			if (!IsValid(self)) then return end
			self:StopParticles()
			self:EmitSound("ambience/3d-sounds/nexus/printer_verb.ogg")

			timer.Simple(11.2, function()
				if (!IsValid(self)) then return end
				self:EmitSound("ambience/3d-sounds/steam/steam01.wav")
				for _, pipe in pairs(self.smallSteamPipes) do
					ParticleEffect("steamjet", self:LocalToWorld(pipe.vec), self:LocalToWorldAngles(pipe.ang), self)
				end

				timer.Simple(1.8, function()
					if (!IsValid(self)) then return end
					if (isBulk) then
						self:MultipleDispense(fabrication:GetID(), amount)
					else
						self:Dispense(fabrication:GetID())
					end
				end)
			end)
		end)

	end)
end

function ENT:Think()
	self:NextThink( CurTime() )

	return true
end

function ENT:StartTouch(entity)
	if (entity:GetClass() != "ix_item" or entity.attached) then return end
	local attachmentPos = self:GetPos()
	local attachmentAngle = self:GetAngles()

	if (entity:GetItemID() == "combinebattery") then
		if (self.attachedBattery and self.attachedBattery != NULL) then return end

		attachmentPos = self:LocalToWorld(Vector(17.081011, -3.726678, 25.982630))
		attachmentAngle = self:LocalToWorldAngles(Angle(8.451, 7.097, 98.399))
		self.attachedBattery = entity
	elseif (entity:GetItemID() == "datadisc") then
		if (self.attachedDisc and self.attachedDisc != NULL) then return end

		attachmentPos = self:LocalToWorld(Vector(21.495632, -24.401604, 37.726032))
		attachmentAngle = self:LocalToWorldAngles(Angle(0.693, 2.259, 88.879))
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