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
local INSERT_ID = 1
local CHECKING = 2
local DISPENSING = 3
local FREQ_LIMIT = 4
local WAIT = 5
local OFFLINE = 6
local INSERT_ID_RED = 7
local PREPARING = 8
local INVALID_CID = 9

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

-- INSERT_ID |-> CHECKING |-> PREPARING -> DISPENSING -> WAIT -> INSERT_ID
--			 |			  |-> FREQ LIMIT -- used too quickly (ration interval)
--			 |-> INSERT_ID_RED -- no CID in inv
--			 |-> OFFLINE -- dispenser turned off
-- INVALID_CID: selected CID not instanced server side; should never happen but sanity check

function ENT:SpawnFunction(client, trace)
	local dispenser = ents.Create("ix_rationdispenser")

	dispenser:SetPos(trace.HitPos)
	dispenser:SetAngles(trace.HitNormal:Angle())
	dispenser:Spawn()
	dispenser:Activate()
	dispenser:SetEnabled(true)

	ix.saveEnts:SaveEntity(dispenser)
	Schema:SaveRationDispensers()
	return dispenser
end

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:DrawShadow(false)
	self:SetUseType(SIMPLE_USE)
	self:SetDisplay(INSERT_ID)
	self:SetEnabled(true)

	self.dispenser = ents.Create("prop_dynamic")
	self.dispenser:SetModel("models/willardnetworks/props_combine/combine_dispenser.mdl")
	self.dispenser:SetPos(self:GetPos())
	self.dispenser:SetAngles(self:GetAngles())
	self.dispenser:SetParent(self)
	self.dispenser:Spawn()
	self.dispenser:Activate()
	self:DeleteOnRemove(self.dispenser)

	self.dummy = ents.Create("prop_physics")
	self.dummy:SetModel("models/weapons/w_package.mdl")
	self.dummy:SetPos(self:GetPos())
	self.dummy:SetAngles(self:GetAngles())
	self.dummy:SetMoveType(MOVETYPE_NONE)
	self.dummy:SetNotSolid(true)
	self.dummy:SetNoDraw(true)
	self.dummy:SetParent(self.dispenser, 1)
	self.dummy:Spawn()
	self.dummy:Activate()
	self:DeleteOnRemove(self.dummy)

	local physics = self.dispenser:GetPhysicsObject()
	physics:EnableMotion(false)
	physics:Sleep()

	self.canUse = true
	self.nextUseTime = CurTime()
end

function ENT:Use(client)
	if (!self.canUse or self.nextUseTime > CurTime()) then
		return
	end

	if client.CantUseRation then
		client:NotifyLocalized("You need to wait before you can use this!")
		return false
	end

	client.CantUseRation = true

	timer.Simple(10.2, function()
		if IsValid(client) then
			client.CantUseRation = false
		end
	end)

	if (ix.faction.Get(client:Team()).allowEnableRations or client:HasActiveCombineSuit()) then
		if (client:KeyDown(IN_SPEED)) then
			self:SetEnabled(!self:GetEnabled())
			self:EmitSound(self:GetEnabled() and "buttons/combine_button1.wav" or "buttons/combine_button2.wav")

			ix.combineNotify:AddNotification("NTC:// Ration Distribution Terminal " .. (self:GetEnabled() and "enabled" or "disabled") .. " by " .. client:GetCombineTag(), Color(255, 0, 150, 255), client)

			ix.saveEnts:SaveEntity(self)

			self.nextUseTime = CurTime() + 2

			ix.log.Add(client, "rationsToggleDispenser", self:GetEnabled())

			return
		end
	end

	if (!self:GetEnabled()) then
		self:DisplayError(OFFLINE)
		return
	end

	local character = client:GetCharacter()
	local isVort = character:IsVortigaunt()
	if isVort and character:GetBackground() == "Collaborator" then
		isVort = false
	end
	local idCards = !isVort and character:GetInventory():GetItemsByUniqueID("id_card")
	or character:GetInventory():HasItem("vortigaunt_slave_collar")
	or character:GetInventory():HasItem("vortigaunt_slave_collar_fake")
	if (!isVort and #idCards >= 1 or isVort and idCards) then
		-- display checking message
		self.canUse = false
		self:SetDisplay(CHECKING)
		self:EmitSound("ambient/machines/combine_terminal_idle2.wav")
		if isVort then
			self.CheckIdCard(idCards, character:GetGenericdata(), client, self)
		else
			-- Check for citizen id(s)
			if (#idCards == 1) then
				idCards[1]:LoadOwnerGenericData(self.CheckIdCard, self.CheckIdError, client, self)
			else
				netstream.Start(client, "CIDSelectorDispenser", self)
			end
		end
	else
		self:DisplayError(INSERT_ID_RED)
	end
end

netstream.Hook("SelectIDCardDispenser", function(client, idCard, cidName, entity)
	if !client:GetCharacter():GetInventory():GetItemByID(idCard) then
		return false
	end

	local idCardItem = ix.item.instances[idCard]
	if (idCardItem) then
		idCardItem:LoadOwnerGenericData(entity.CheckIdCard, entity.CheckIdError, client, entity)
	else
		entity:DisplayError(INVALID_CID)
	end
end)

netstream.Hook("SelectIDCardDispenserCoupon", function(client, idCard, cidName, entity)
	local idCardItem = ix.item.instances[idCard]
	if (idCardItem and client.ixCouponUsed) then
		if client:GetCharacter() then
			if client:GetCharacter():GetInventory() then
				if client:GetCharacter():GetInventory():GetItemByID(client.ixCouponUsed) then
					local couponItem = ix.item.instances[client.ixCouponUsed]
					local couponAmount = couponItem.amount or 0
					idCardItem:LoadOwnerGenericData(entity.CheckIdCardCoupon, entity.CheckIdError, client, entity, couponAmount)

					return
				end
			end
		end
	end

	entity:DisplayError(INVALID_CID)
end)

function ENT:IDCardCheck(idCard, genericData, client, entity)
	local character = client:GetCharacter()
	if client:IsVortigaunt() and character:GetBackground() != "Collaborator" then
		if -ix.config.Get("blacklistSCAmount", 40) <= idCard:GetData("sterilizedCredits", 0) then
			return true
		else
			entity:CreateCombineAlert(client, "WRN:// VORTIGAUNT SHACKLES ERROR DETECTED.", FREQ_LIMIT)

			return false
		end
	end

	if (idCard:GetData("active", false) == false) then
		entity:CreateCombineAlert(client, "WRN:// Inactive Identification Card #" .. idCard:GetData("cid", 00000) .. " usage attempt detected", FREQ_LIMIT)

		return false
	end

	local isBOL = genericData.bol
	local isAC = genericData.anticitizen

	if (isBOL or isAC) then
		local text = isBOL and "BOL Suspect" or "Anti-Citizen"
		entity:CreateCombineAlert(client, "WRN:// " .. text .. " Identification Card activity detected", isAC and FREQ_LIMIT)

		-- only halt if isAC, allow it to continue for BOL
		if (isAC) then
			return false
		end
	end

	return true
end

function ENT.CheckIdCard(idCard, genericData, client, entity)
	if entity:IDCardCheck(idCard, genericData, client, entity) then
		entity:CheckRationTime(client, idCard, genericData)
	end
end

function ENT.CheckIdCardCoupon(idCard, genericData, client, entity, couponAmount)
	if entity:IDCardCheck(idCard, genericData, client, entity) then
		if (idCard:GetData("nextRationTime", 0) >= 60 * ix.config.Get("rationInterval")) then
			client:NotifyLocalized("You already have a ration available!")
			return false
		end

		entity:EmitSound("ambient/levels/labs/coinslot1.wav")
		if (ix.config.Get("creditsNoConnection")) then
			entity:SetDisplay(CHECKING)
			timer.Simple(10, function()
				if (!IsValid(entity)) then return end
				entity:DisplayError(OFFLINE, 5)
				timer.Simple(2, function()
					if (!IsValid(entity)) then return end
					entity:EmitSound("ambient/levels/labs/coinslot1.wav")
				end)
			end)
			return
		end

		timer.Simple(1, function()
			if IsValid(entity) then
				entity:EmitSound("Friends/friend_online.wav")
			end
		end)

		entity:SetDisplay(8)
		entity.canUse = false

		timer.Simple(2, function()
			if IsValid(entity) then
				if ix.city.main:HasCredits(couponAmount) then
					entity:EmitSound("Friends/friend_join.wav")
					entity:SetDisplay(10)

					idCard:GiveCredits(couponAmount, "Rations", "Ration Coupon")
					ix.city.main:TakeCredits(couponAmount)
				else
					entity:SetDisplay(5)
					entity.canUse = false
					timer.Simple(6, function()
						if (!IsValid(entity)) then return end

						entity:SetDisplay(11)
						entity:EmitSound("buttons/combine_button_locked.wav")
						timer.Simple(4, function()
							if (!IsValid(entity)) then return end
							entity:SetDisplay(1)
							entity.canUse = true
						end)
					end)
					return
				end

				if ix.item.instances[client.ixCouponUsed] then
					if !ix.item.instances[client.ixCouponUsed]:GetData("stack", false) then
						ix.meta.item.Remove(ix.item.instances[client.ixCouponUsed])
					else
						ix.item.instances[client.ixCouponUsed]:Remove()
					end
				end

				client.ixCouponUsed = nil

				ix.log.Add(client, "rationsCoupon", couponAmount)

				timer.Simple(2, function()
					if IsValid(entity) then
						entity.canUse = true
						entity:SetDisplay(1)
					end
				end)
			end
		end)
	end
end

function ENT.CheckIdError(idCard, client, entity)
	entity:DisplayError(INVALID_CID)
	client.ixCouponUsed = nil
end

local function GetNumbersFromText(txt)
	local str = ""
	string.gsub( txt,"%d+",function(e)
		str = str .. e
	end)

	return str
end

function ENT:CheckRationTime(client, idCard, genericData)
	if (!idCard:GetData("nextRationTime")) then
		idCard:SetData("nextRationTime", 60 * ix.config.Get("rationInterval"))
	end
	local character = client:GetCharacter()
	timer.Simple(math.random(1.8, 2.2), function()
		if (idCard:GetData("nextRationTime", 0) >= 60 * ix.config.Get("rationInterval")) then
			if !client:GetCharacter():GetInventory():GetItemByID(idCard.id) then
				if !client:IsVortigaunt() or character:GetBackground() == "Collaborator" then
					return false
				end
			end

			self:SetDisplay(PREPARING)
			self:EmitSound("ambient/machines/combine_terminal_idle3.wav")

			local ration = "ration"
			local class = "Standard"
			local maxCredits = 15 -- Temp fix
			local rationCredits = 0 -- Temp fix for Ration Coupons vs abritary transfer
			local loyaltyCredits = maxCredits * 2
			local loyaltyStatus = genericData.loyaltyStatus
			local tier = tonumber(GetNumbersFromText(loyaltyStatus))

			if (genericData.combine) then
				rationCredits = rationCredits + 0
				maxCredits = loyaltyCredits
				ration = "civil_protection_ration"
				class = "Functionary"
			elseif (loyaltyStatus) then
				if (tier and isnumber(tier)) then
					if (tier >= 6) then
						maxCredits = loyaltyCredits
						ration = "priority_ration"
						class = "Conformist"
					elseif (tier >= 4) then
						maxCredits = loyaltyCredits
						ration = "trueloyal_ration"
						class = "Conformist"
					end
				elseif (genericData.socialCredits) then
					if (genericData.socialCredits >= 175) then
						maxCredits = loyaltyCredits
						ration = "loyalist_ration"
						class = "Conformist"
					elseif (genericData.socialCredits >= 125) then
						maxCredits = loyaltyCredits
						ration = "improved_ration"
						class = "Conformist"
					elseif (genericData.socialCredits < 40) then
						ration = "underclass_ration"
						class = "Underclass"
					end
				end
			end

			if !client:IsVortigaunt() or character:GetBackground() == "Collaborator" then
				if (!ix.config.Get("creditsNoConnection")) then

					local cwuCard = character:GetInventory():HasItem("cwu_card")
					local budget = false
					if cwuCard then
						local bind = cwuCard:GetData("cardID", false)
						if !bind or bind != idCard:GetID() then
							cwuCard = false
						elseif cwuCard:GetData("faction", false) then
							budget = cwuCard:GetData("faction").id
						end
					end

					local credits = idCard:GetCredits()
					local newCredits = math.max(credits, math.min(maxCredits, credits + 0))
					local giveCredits = (newCredits > credits and newCredits - credits or 0) + (genericData.wages or 0)

					if budget then
						if ix.factionBudget:HasCredits(budget, giveCredits) then
							idCard:GiveCredits(giveCredits, "Income", "Rations/Wages")
							ix.factionBudget:TakeFBCredits(budget, giveCredits)
						else
							return client:NotifyLocalized("Your faction's budget don't have enough credits.")
						end
					else
						if ix.city.main:HasCredits(giveCredits) then
							idCard:GiveCredits(giveCredits, "Income", "Rations/Wages")
							ix.city.main:TakeCredits(giveCredits)
						else
							return client:NotifyLocalized("City fund don't have enough credits.")
						end
					end

					if (newCredits <= credits) then
						if (genericData.wages and genericData.wages > 0) then
							client:NotifyLocalized("creditCapWages", genericData.wages)
						else
							client:NotifyLocalized("creditCapReached")
						end
					end
				end
			end

			ix.log.Add(client, "rationsDispensing", newCredits and newCredits - credits or 0, genericData.wages or 0, ration)

			if (character:IsVortigaunt()) then
				if (genericData.cid or character:GetBackground() == "Collaborator") then
					ix.combineNotify:AddNotification("LOG:// Subject " .. string.upper("biotic asset identification card:") .. " #" .. genericData.cid .. " retrieved " .. class .. "-Class Ration Package from Dispenser", nil, client)
				else
					ix.combineNotify:AddNotification("LOG:// Subject " .. string.upper("biotic asset collar:") .. " #" .. character:GetCollarID() .. " retrieved " .. class .. "-Class Ration Package from Dispenser", nil, client)
				end
			else
				ix.combineNotify:AddNotification("LOG:// Subject '" .. genericData.name .. "' retrieved " .. class .. "-Class Ration Package from Dispenser", nil, client)
			end

			timer.Simple(10.2, function()
				idCard:SetData("nextRationTime", 0)
				self:SpawnRation(ration)
			end)

			local uniqueID = "ixDispenserTimer" .. client:SteamID64()
			if (!timer.Exists(uniqueID)) then
				PLUGIN:CreateRationTimer(client)
			end
		else
			self:DisplayError(FREQ_LIMIT)
			client:NotifyLocalized("Your next ration is available in "..math.Round( ((ix.config.Get("rationInterval", 0) * 60) - idCard:GetData("nextRationTime", 0)) / 60, 2).." hours")
		end
	end)
end

function ENT:SpawnRation(rationType)
	self:SetDisplay(DISPENSING)

	rationType = rationType or "ration"
	local releaseDelay = 1.2
	local itemTable = ix.item.Get(rationType)

	self.dummy:SetModel(itemTable:GetModel())
	self.dummy:SetNoDraw(false)
	self.dummy:Fire("SetParentAttachment", "package_attachment")

	self.dispenser:Fire("SetAnimation", "dispense_package")
	self:EmitSound("ambient/machines/combine_terminal_idle4.wav")

	timer.Simple(releaseDelay, function()
		ix.item.Spawn(rationType, self.dummy:GetPos(), function(item, entity)
			self.dummy:SetNoDraw(true)
		end, self.dummy:GetAngles())

		-- display cooldown notice
		timer.Simple(releaseDelay, function()
			self:SetDisplay(WAIT)
		end)

		-- make dispenser usable
		timer.Simple(releaseDelay + 4, function()
			self.canUse = true
			self:SetDisplay(INSERT_ID)
		end)
	end)
end

function ENT:CreateCombineAlert(client, message, error)
	ix.combineNotify:AddImportantNotification(message, nil, client, self:GetPos())
	if (error) then
		self:DisplayError(error)
	end
end

function ENT:DisplayError(id, length)
	id = id or 6
	length = length or 2

	self:SetDisplay(id)
	self:EmitSound("buttons/combine_button_locked.wav")
	self.canUse = false

	timer.Simple(length, function()
		self:SetDisplay(INSERT_ID)
		self.canUse = true
	end)
end

function ENT:OnRemove()
	if (!ix.shuttingDown) then
		Schema:SaveRationDispensers()
	end
end

netstream.Hook("ClosePanelsDispenser", function(client, entity)
	timer.Simple(1, function()
		if entity then
			entity.canUse = true
		end
	end)

	if entity then
		entity:SetDisplay(INSERT_ID)
		entity:EmitSound("ambient/machines/combine_terminal_idle1.wav")
	end
end)