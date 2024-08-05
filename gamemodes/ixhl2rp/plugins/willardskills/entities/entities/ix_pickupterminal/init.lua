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

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction(client, trace)
	local dispenser = ents.Create("ix_pickupterminal")

	dispenser:SetPos(trace.HitPos)
	dispenser:SetAngles(trace.HitNormal:Angle())
	dispenser:Spawn()
	dispenser:Activate()

	ix.saveEnts:SaveEntity(dispenser)
	PLUGIN:SavePickupTerminals()
	return dispenser
end

ix.log.AddType("pickupDispenserGotItem", function(client)
    return string.format("[PICKUP DISPENSER] %s ( %s ) picked up an item from the pickup dispenser.", client:SteamName(), client:Name())
end)

function ENT:Initialize()
	-- Because dispenser model has no physics object in order to allow pass through walls
	self:SetModel("models/props_junk/watermelon01.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:DrawShadow(false)
	self:SetUseType(SIMPLE_USE)
	self:SetDisplay(1)
	self:PhysicsInit(SOLID_VPHYSICS)

	self.dispenser = ents.Create("prop_dynamic")
	self.dispenser:SetModel("models/props_combine/pickup_dispenser3.mdl")
	self.dispenser:SetPos(self:GetPos())
	self.dispenser:SetAngles(self:GetAngles())
	self.dispenser:SetParent(self)
	self.dispenser:Spawn()
	self.dispenser:Activate()
	self.dispenser:SetTrigger(true)
	self:DeleteOnRemove(self.dispenser)

	local physics = self.dispenser:GetPhysicsObject()
	physics:EnableMotion(false)
	physics:Wake()

	self.canUse = true
	self.nextUseTime = CurTime()
end

function ENT:ItemChoiceLogic(item, inventory, cid, purchasedItems)
	if (item == "newspaper_printer") then
		if (!inventory:Add(item, 1, {registeredCID = cid:GetData("cid")})) then
			return false
		end
	elseif (item == "apartmentkey" or item == "shopkey") then
		local housing = ix.plugin.list["housing"]
		if housing and housing.GetApartmentByCID then
			local cidData = cid:GetData("cid")
			local appID = housing:GetApartmentByCID(cidData, item)
			if appID then
				if (!inventory:Add(item, 1, {cid = cidData, apartment = appID})) then
					return false
				end
			end
		end
	elseif (string.find(item, "letter")) then
		local itemData = purchasedItems[item]
		if (!inventory:Add("paper", 1, {title = itemData.title, writingID = itemData.writingID, owner = itemData.currentOwner})) then
			return false
		end
	else
		if (!inventory:Add(item)) then
			return false
		end
	end

	return true
end

function ENT:GiveItem(client, item, cid)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local itemTable = string.find(item, "letter") and ix.item.list["paper"] or ix.item.list[item]
	if (!itemTable) then return false end

	if (!inventory:FindEmptySlot(itemTable.width, itemTable.height)) then
		return false
	end

	if !inventory:GetItemByID(cid.id) then
		return false
	end

	if self.charLoaded then
		if ix.char.loaded[self.charLoaded] then
			local items = ix.char.loaded[self.charLoaded]:GetPurchasedItems()
			if (!items[item] or (!istable(items[item]) and items[item] <= 0)) then
				return false
			end

			if self:ItemChoiceLogic(item, inventory, cid, items) then
				ix.char.loaded[self.charLoaded]:SetPurchasedItems(item)
				ix.log.Add(client, "pickupDispenserGotItem")
			end
		end
	else
		if self.dbGeneric then
			local queryObj = mysql:Select("ix_characters_data")
			queryObj:Where("id", self.dbGeneric)
			queryObj:Where("key", "purchasedItems")
			queryObj:Select("data")
			queryObj:Callback(function(result)
				if (!istable(result) or !result[1]) then return end
				if !result[1].data then return end
				local items = util.JSONToTable(result[1].data)

				if !items[item] then return end

				if !istable(items[item]) then
					if items[item] > 0 then
						items[item] = items[item] - 1

						if items[item] == 0 then
							items[item] = nil
						end
					else
						return
					end
				else
					if items[item] then items[item] = nil end
				end

				if self:ItemChoiceLogic(item, inventory, cid, items) then
					local updateQuery = mysql:Update("ix_characters_data")
					updateQuery:Update("data", util.TableToJSON(items))
					updateQuery:Where("id", self.dbGeneric)
					updateQuery:Where("key", "purchasedItems")
					updateQuery:Execute()
					ix.log.Add(client, "pickupDispenserGotItem")
				end
			end)

			queryObj:Execute()
		end
	end

	self:EmitSound("buttons/button1.wav")
	self:SetDisplay(3)

	return true
end

function ENT:OpenCIDSelector(client)
	netstream.Start(client, "OpenCIDSelector", self)
end

function ENT:CreateCombineAlert(client, message)
	ix.combineNotify:AddImportantNotification(message, nil, client, self:GetPos())
end

function ENT.OpenDispenserFail(idCard, client, activeDispenser)
	if (!IsValid(activeDispenser)) then return end

	activeDispenser:SetDisplay(4)
	activeDispenser:EmitSound("ambient/machines/combine_terminal_idle1.wav")
	activeDispenser.charLoaded = nil
	activeDispenser.dbGeneric = nil
	activeDispenser.activeCID = nil

	timer.Simple(2, function()
		if IsValid(activeDispenser) then
			activeDispenser:SetDisplay(1)
			activeDispenser.canUse = true
		end
	end)
end

function ENT:CheckForVerdicts(client, idCard, genericData)
	if (idCard:GetData("active", false) == false) then
		self:CreateCombineAlert(client, "WRN:// Inactive Identification Card #" .. idCard:GetData("cid", 00000) .. " usage attempt detected")
		
		self:SetDisplay(9)
		timer.Simple(1.5, function()
			if self then
				self.OpenDispenserFail(nil, client, self)
			end
		end)
		return
	end

	local isBOL = genericData.bol
	local isAC = genericData.anticitizen
	if (isBOL or isAC) then
		local text = isBOL and "BOL Suspect" or "Anti-Citizen"
		self:CreateCombineAlert(client, "WRN:// " .. text .. " Identification Card activity detected")

		if isAC then
			self:SetDisplay(9)
			timer.Simple(1.5, function()
				if self then
					self.OpenDispenserFail(nil, client, self)
				end
			end)
		end

		return !isAC -- stop if isAC, continue for isBOL
	end

	return true
end

function ENT.OpenDispenser(idCard, genericData, client, activeTerminal)
	if (!IsValid(activeTerminal)) then return end

	activeTerminal:EmitSound("buttons/button4.wav")

	activeTerminal:SetDisplay(2)
	if (activeTerminal:CheckForVerdicts(client, idCard, genericData)) then
		timer.Simple(2, function()
			if table.IsEmpty(genericData) then
				activeTerminal:SetDisplay(9)
				activeTerminal:EmitSound("buttons/button2.wav")
				timer.Simple(2, function()
					if IsValid(activeTerminal) then
						activeTerminal.charLoaded = nil
						activeTerminal.dbGeneric = nil
						activeTerminal.activeCID = nil
						activeTerminal:SetDisplay(1)
						activeTerminal.canUse = true
					end
				end)
			else
				activeTerminal:OnSuccess(idCard, genericData, client)
			end
		end)
	end
end

function ENT:OnSuccess(idCard, genericData, client)
	self:SetDisplay(7)
	self:EmitSound("ambient/machines/combine_terminal_idle3.wav")
	self.activeCID = idCard

	if ix.char.loaded[genericData.id] then
		self.charLoaded = genericData.id
		netstream.Start(client, "OpenPickupDispenser", ix.char.loaded[genericData.id]:GetPurchasedItems(), self)
		return
	end

	local queryObj = mysql:Select("ix_characters_data")
	queryObj:Where("id", genericData.id)
	queryObj:Where("key", "purchasedItems")
	queryObj:Select("data")
	queryObj:Callback(function(result)
		if (!istable(result) or !result[1]) then return end
		if !result[1].data then return end

		netstream.Start(client, "OpenPickupDispenser", util.JSONToTable(result[1].data), self)
		self.dbGeneric = genericData.id
	end)

	queryObj:Execute()
end

function ENT:CheckForCID(client)
	local idCards = self.activeCharacter:GetInventory():GetItemsByUniqueID("id_card")

	if (#idCards > 1) then
		self:OpenCIDSelector(client)
		return
	end

	if (#idCards == 1) then
		idCards[1]:LoadOwnerGenericData(self.OpenDispenser, self.OpenDispenserFail, client, self)
	else
		self.canUse = false
		self:EmitSound("buttons/button2.wav")
		timer.Simple(1, function()
			if (IsValid(self)) then
				self.canUse = true
			end
		end)
	end
end

function ENT:CheckGlobalUse(client)
	if client.CantPlace then
		client:NotifyLocalized("You need to wait before you can use this!")
		return false
	end

	client.CantPlace = true

	timer.Simple(3, function()
		if client then
			client.CantPlace = false
		end
	end)

	return true
end

function ENT:CheckLocalUse(client)
	if (!self.canUse and IsValid(self.activePlayer) and self.activePlayer:GetCharacter() == self.activeCharacter) then
		return false
	else
		self.canUse = false
		self.activePlayer = client
		self.activeCharacter = client:GetCharacter()
		return true
	end
end

function ENT:StartTouch(entity)
	if (entity:GetClass() != "ix_item") then return end
	if !self.canUse then return end

	self.canUse = false

	local itemID = entity:GetItemID()
	if ix.city:IsDisallowment(itemID) then
		self:SetDisplay(11)
		self:EmitSound("ambient/machines/combine_terminal_idle1.wav")

		timer.Simple(2, function()
			if IsValid(self) then
				self:SetDisplay(1)
				self.canUse = true
			end
		end)
	else
		ix.city.main:AddItem(itemID, entity:GetData("stack", 1))
		entity:Remove()

		self:SetDisplay(10)
		self:EmitSound("ambient/machines/combine_terminal_idle1.wav")

		timer.Simple(2, function()
			if IsValid(self) then
				self:SetDisplay(1)
				self.canUse = true
			end
		end)

		self:EmitSound("physics/metal/weapon_impact_soft" .. math.random(1, 3) .. ".wav")
	end
end

function ENT:OnUse(client)
	self:CheckForCID(client)
end

function ENT:Use(client)
	if !self:CheckGlobalUse(client) then
		return false
	end

	if !self:CheckLocalUse(client) then
		return false
	end

	self:OnUse(client)
end