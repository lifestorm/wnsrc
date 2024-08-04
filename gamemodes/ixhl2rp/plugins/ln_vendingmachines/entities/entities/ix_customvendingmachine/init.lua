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

local PLUGIN = PLUGIN

function ENT:SpawnFunction(client, trace)
	if (!trace.Hit) then return end

	local SpawnPosition = trace.HitPos + trace.HitNormal + Vector(0, 0, 45)
	local SpawnAngle = client:EyeAngles()
	SpawnAngle.p = 0
	SpawnAngle.y = SpawnAngle.y + 180

	local entity = ents.Create("ix_customvendingmachine")
	entity:SetPos(SpawnPosition)
	entity:SetAngles(SpawnAngle)
	entity:Spawn()
	entity:Activate()

	ix.inventory.New(0, "vendingMachine", function(inventory)
		if (!IsValid(entity)) then return end
		if (inventory) then
			inventory.vars.isBag = true
			inventory.vars.isVendingMachine = true

			entity:SetID(inventory:GetID())

			ix.item.Spawn("vendingmachinekey", client, nil, nil, {vendingMachineID = entity:GetID()})
			ix.item.Spawn("vendingmachinekey", client, nil, nil, {vendingMachineID = entity:GetID()})
			ix.item.Spawn("vendingmachinekey", client, nil, nil, {vendingMachineID = entity:GetID()})

			ix.saveEnts:SaveEntity(entity)
			PLUGIN:SaveData()
		end
	end)

	return entity
end

function ENT:CheckHasID(character)
	local idCard = character:GetInventory():HasItem("id_card")

	if (!idCard) then
		self:EmitSound("buttons/button2.wav")
		self.nextUse = CurTime() + 1

		return false
	end

	return true
end

function ENT.CheckIDCard(idCard, genericData, client, entity, collecting)
	if (idCard:GetData("active", false) == false) then
		ix.combineNotify:AddImportantNotification("WRN:// Inactive Identification Card #" .. idCard:GetData("cid", 00000) .. " usage attempt detected", nil, client, client:GetPos())
		entity:EmitSound("buttons/button2.wav")
		entity.nextUse = CurTime() + 1

		return
	end

	local isBOL = genericData.bol
	local isAC = genericData.anticitizen

	if (isBOL or isAC) then
		local text = isBOL and "BOL Suspect" or "Anti-Citizen"

		ix.combineNotify:AddImportantNotification("WRN:// " .. text .. " Identification Card activity detected", nil, client, client:GetPos())
	end

	if (collecting) then
		idCard:GiveCredits(entity:GetNetVar("credits", 0), "Vending Machine", "Vending Machine (" .. entity:GetID() .. ") Credit Collection")
		entity:SetNetVar("credits", 0)
		ix.saveEnts:SaveEntity(entity)
	else
		entity:PostAuthorized(client, idCard)
	end
end

function ENT.CheckIDError(_, entity)
	entity:EmitSound("buttons/button2.wav")
end

function ENT:Use(activator)
	if ((self.nextUse or 0) < CurTime()) then
		self.nextUse = CurTime() + 1
	else
		return
	end

	local button = self:GetNearestButton(activator)

	if (button) then
		activator:EmitSound("buttons/lightswitch2.wav", 55, 125)

		local character = activator:GetCharacter()

		if (self:CheckHasID(character)) then
			local idCards = character:GetInventory():GetItemsByUniqueID("id_card")

			if (#idCards == 1) then
				idCards[1]:LoadOwnerGenericData(self.CheckIDCard, self.CheckIDError, activator, self)
			else
				self.cidSelection = activator

				net.Start("ixSelectVendingMachineCID")
					net.WriteEntity(self)
				net.Send(activator)

				timer.Simple(30, function()
					if (IsValid(self)) then
						self.cidSelection = nil
					end
				end)
			end
		end
	elseif (!self:GetLocked()) then
		activator.ixVendingMachineEdit = self
		activator:EmitSound("buttons/lightswitch2.wav", 55, 125)

		self:EmitSound("buttons/button1.wav")

		net.Start("ixVendingMachineManager")
		net.WriteEntity(self)
		net.Send(activator)
	end
end

function ENT:PostAuthorized(activator, idCard)
	local button = self:GetNearestButton(activator)
	local prices = self:GetNetVar("prices")
	local labels = self:GetNetVar("labels")
	local buttons = self:GetNetVar("buttons")

	if (!labels[button]) then
		return
	end

	if (buttons[button]) then
		local item = self:FindItemInRow(button)

		if (item) then
			local price = prices[button]

			if (idCard:HasCredits(price)) then
				local position = self:GetPos()
				local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
				local inventory = ix.item.inventories[self:GetID()]

				item.invID = 0
				inventory:Remove(item.id, false, true)

				local query = mysql:Update("ix_items")
					query:Update("inventory_id", 0)
					query:Where("item_id", item.id)
				query:Execute()

				inventory = ix.item.inventories[0]
				inventory[item:GetID()] = item

				item:Spawn(position + f * 19 + r * 4 + u * -26)
				idCard:TakeCredits(price, "Vending Machine", "\"" .. item:GetName() .. "\" Vending Machine (" .. self:GetID() .. ") purchase.")

				self:EmitSound("buttons/button4.wav")
				self:SetNetVar("credits", self:GetNetVar("credits", 0) + price)

				activator:Notify("You have purchased a " .. labels[button] .. " for " .. price .. " Credits.")
			else
				self:EmitSound("buttons/button8.wav")

				activator:Notify("You need a total of " .. price .. " Credits to purchase a " .. labels[button] .. "!")
			end

			-- Check again to see if we ran out. If we did, change to red.
			self:UpdateStocks()
			ix.saveEnts:SaveEntity(self)
		else
			self:EmitSound("buttons/button2.wav")

			self:UpdateStocks()
		end
	else
		self:EmitSound("buttons/combine_button_locked.wav")
	end
end

function ENT:CollectCredits(activator)
	local character = activator:GetCharacter()

	if (!self:GetLocked() and self:CheckHasID(character)) then
		local idCards = character:GetInventory():GetItemsByUniqueID("id_card")

		if (#idCards == 1) then
			idCards[1]:LoadOwnerGenericData(self.CheckIDCard, self.CheckIDError, activator, self, true)
		else
			self.cidSelection = activator
			activator.isCollecting = true

			net.Start("ixSelectVendingMachineCID")
				net.WriteEntity(self)
			net.Send(activator)

			timer.Simple(30, function()
				if (IsValid(self)) then
					self.cidSelection = nil
				end

				if (IsValid(activator)) then
					activator.isCollecting = nil
				end
			end)
		end
	end
end

function ENT:FindItemInRow(row)
	local inventory = ix.item.inventories[self:GetID()]

 	if (inventory) then
		for _, itemData in pairs(inventory:GetItems(true)) do
			if (itemData.gridY == row) then
				return itemData
			end
		end
	end
end

function ENT:SetData(dataType, slot, value)
	local data = self:GetNetVar(dataType, {})

	if (data[slot] != value) then
		data[slot] = value

		self:SetNetVar(dataType, data)
	end
end

function ENT:UpdateStocks()
	for i = 1, 8 do
		if (self:FindItemInRow(i)) then
			self:SetData("stocks", i, true)
		else
			self:SetData("stocks", i, false)
		end
	end
end
