--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- luacheck: read globals SMUGGLER_BUY SMUGGLER_SELL SMUGGLER_BOTH SMUGGLER_WELCOME SMUGGLER_LEAVE SMUGGLER_NOTRADE SMUGGLER_PRICE
-- luacheck: read globals SMUGGLER_STOCK SMUGGLER_MODE SMUGGLER_MAXSTOCK SMUGGLER_SELLANDBUY SMUGGLER_SELLONLY SMUGGLER_BUYONLY SMUGGLER_TEXT

local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Smuggler"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.isSmuggler = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DisplayName")
	self:NetworkVar("String", 1, "Description")
end

function ENT:Initialize()
	self:SetModel("models/mossman.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(true)


	if (SERVER) then
		self:SetUseType(SIMPLE_USE)
		self:SetSolid(SOLID_OBB)
		self:PhysicsInit(SOLID_OBB)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		self:SetDisplayName("John Doe")
		self:SetDescription("")

		self.items = {}
		self.messages = {}
		self.receivers = {}
		self.stashList = {}
		self.maxStock = 30
		self:SetInactive()
	end

	timer.Simple(1, function()
		if (IsValid(self)) then
			self:SetAnim()
		end
	end)
end

function ENT:CanAccess(client)
	if (client:HasActiveCombineSuit()) then
		return false
	end

	if (ix.faction.Get(client:Team()).noSmuggler) then
		return false
	end

	return true
end

function ENT:GetStock(uniqueID)
	local maxStock = PLUGIN.itemList[uniqueID].maxStock or self.maxStock
	if (self.items[uniqueID]) then
		return self.items[uniqueID][SMUGGLER_STOCK] or 0, maxStock
	end

	return 0, maxStock
end

function ENT:GetTotalStock()
	local stock = 0
	for _, v in pairs(self.items) do
		stock = stock + (v[SMUGGLER_STOCK] or 0)
	end

	return stock
end

function ENT:GetPrice(uniqueID, bClientIsSelling)
	local price = 0
	if (ix.item.list[uniqueID] and self.items[uniqueID]) then
		local info = PLUGIN.itemList[uniqueID]
		if (bClientIsSelling) then
			-- info.buy = price of smuggler buying from player = player selling to smuggler
			price = info.buy or 0
		else
			-- info.sell = price of smuggler selling to player = player buying from smuggler
			price = info.sell or 0
		end
	end

	return price
end

function ENT:HasMoney(amount)
	-- Smuggler not using money system so they can always afford it.
	if (!self.money) then
		return true
	end

	return self.money >= amount
end

function ENT:SetAnim()
	for k, v in ipairs(self:GetSequenceList()) do
		if (v:lower():find("idle") and v != "idlenoise") then
			return self:ResetSequence(k)
		end
	end

	if (self:GetSequenceCount() > 1) then
		self:ResetSequence(4)
	end
end

if (SERVER) then
	function ENT:SpawnFunction(client, trace)
		local angles = (trace.HitPos - client:GetPos()):Angle()
		angles.r = 0
		angles.p = 0
		angles.y = angles.y + 180

		local entity = ents.Create("ix_smuggler")
		entity:SetPos(trace.HitPos)
		entity:SetAngles(angles)
		entity:Spawn()

		ix.saveEnts:SaveEntity(entity)
		PLUGIN:SaveData()

		return entity
	end

	function ENT:SetInactive()
		self.ixIsActiveSmuggler = nil
		self.ixSmugglerPrepRotation = nil

		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:SetNoDraw(true)

		for _, v in pairs(self.items) do
			if (v[SMUGGLER_STOCK]) then
				v[SMUGGLER_STOCK] = 0
			end
		end

		self:SetMoney(0)
		self.pickupCache = nil
	end


	function ENT:SetActive()
		self.ixIsActiveSmuggler = true
		self.ixSmugglerDeliveryOffset = math.Rand(0.9, 1.2)

		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetNoDraw(false)

		self:ResetSmuggler()
	end

	function ENT:ResetSmuggler()
		if (!self.ixIsActiveSmuggler) then return end

		self.ixSmugglerPrepRotation = nil
		self.ixSmugglerDeliveryOffset = math.Rand(0.9, 1.2)

		for _, v in pairs(self.items) do
			if (v[SMUGGLER_STOCK]) then
				v[SMUGGLER_STOCK] = 0
			end
		end

		-- limit money to player count between 10 and 50
		local playerCount = math.Clamp(#player.GetAll(), 10, 50)
		-- remap money: 0 players theoretically gives no money, but we always have a minimum player count of 10
		-- 50 players gives max money
		self:SetMoney(math.Remap(playerCount, 0, 50, 0, ix.config.Get("SmugglerDefaultMoney")))

		local stashList = {}
		for k, v in pairs(self.stashList) do
			stashList[v] = true
		end

		local caches = {}
		for k, v in pairs(PLUGIN.cacheIDList) do
			if (stashList[v.locationId]) then
				table.insert(caches, k)
			end
		end

		if (#caches > 0) then
			self.pickupCache = Entity(table.Random(caches))
		end
	end

	function ENT:Use(activator)
		if (!self.ixIsActiveSmuggler) then
			return
		end

		if (self.ixSmugglerPrepRotation) then
			activator:NotifyLocalized("smugglerPrepMove")
			return
		end

		local character = activator:GetCharacter()
		if (!self:CanAccess(activator) or hook.Run("CanPlayerUseSmuggler", activator) == false) then
			if (self.messages[SMUGGLER_NOTRADE]) then
				activator:ChatPrint(self:GetDisplayName()..": "..self.messages[SMUGGLER_NOTRADE])
			else
				activator:NotifyLocalized("smugglerNoTrade")
			end

			return
		end

		local items = {}
		-- Only send what is needed.
		for k, v in pairs(self.items) do
			if (!table.IsEmpty(v) and (CAMI.PlayerHasAccess(activator, "Helix - Manage Smugglers", nil) or v[SMUGGLER_MODE])) then
				if (!activator:GetCharacter():CanDoAction("recipe_smuggling_"..k)) then continue end

				items[k] = v
			end
		end

		if (table.IsEmpty(items)) then
			activator:NotifyLocalized("smugglerNoItems")
			return
		end

		self.receivers[#self.receivers + 1] = activator

		if (self.messages[SMUGGLER_WELCOME]) then
			activator:ChatPrint(self:GetDisplayName()..": "..self.messages[SMUGGLER_WELCOME])
		end

		activator.ixSmuggler = self
		activator.ixSmugglerDelivery = nil

		-- force sync to prevent outdated inventories while buying/selling
		if (character) then
			character:GetInventory():Sync(activator, true)
		end

		net.Start("ixSmugglerOpen")
			net.WriteEntity(self)
			net.WriteUInt(self.money or 0, 16)
			net.WriteUInt(self.maxStock or 0, 16)
			net.WriteString(IsValid(self.pickupCache) and self.pickupCache:GetDisplayName() or "")
			net.WriteTable(items)
			net.WriteTable(self.stashList)
		net.Send(activator)

		ix.log.Add(activator, "smugglerUse", self:GetDisplayName())
	end

	function ENT:SetMoney(value)
		self.money = value

		net.Start("ixSmugglerMoney")
			net.WriteUInt(value and value or -1, 16)
		net.Send(self.receivers)
	end

	function ENT:GiveMoney(value)
		if (self.money) then
			self:SetMoney(self:GetMoney() + value)
		end
	end

	function ENT:TakeMoney(value)
		if (self.money) then
			self:GiveMoney(-value)
		end
	end

	function ENT:SetStock(uniqueID, value)
		self.items[uniqueID] = self.items[uniqueID] or {}
		self.items[uniqueID][SMUGGLER_STOCK] = math.Clamp(value, 0, PLUGIN.itemList[uniqueID].maxStock or self.maxStock)

		net.Start("ixSmugglerStock")
			net.WriteString(uniqueID)
			net.WriteUInt(self.items[uniqueID][SMUGGLER_STOCK], 16)
		net.Send(self.receivers)
	end

	function ENT:AddStock(uniqueID, value)
		self:SetStock(uniqueID, self:GetStock(uniqueID) + (value or 1))
	end

	function ENT:TakeStock(uniqueID, value)
		self:AddStock(uniqueID, -(value or 1))
	end
else
	function ENT:Draw()
		self:DrawModel()
	end

	function ENT:Think()
		if ((self.nextAnimCheck or 0) < CurTime()) then
			self:SetAnim()
			self.nextAnimCheck = CurTime() + 60
		end

		self:SetNextClientThink(CurTime() + 0.25)

		return true
	end

	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(container)
		if (self:GetNoDraw()) then return end

		local name = container:AddRow("name")
		name:SetImportant()
		name:SetText(self:GetDisplayName())
		name:SizeToContents()

		local descriptionText = self:GetDescription()

		if (descriptionText != "") then
			local description = container:AddRow("description")
			description:SetText(self:GetDescription())
			description:SizeToContents()
		end
	end
end

function ENT:GetMoney()
	return self.money
end
