--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.receivers = {}

	local definition = ix.container.stored[self:GetModel():lower()]
	if (definition) then
		self:SetDisplayName(definition.name)
	end

	local physObj = self:GetPhysicsObject()
	if (IsValid(physObj)) then
		physObj:EnableMotion(true)
		physObj:Wake()
	end

	self:ChangeType(self.PUBLIC)
end

function ENT:ChangeType(newType, ...)
	if (newType != self:GetType()) then
		self:SetLastUsed(os.time())

		self.users = nil
		self.usersReset = nil
		self.adminText = nil

		self.ownerCharID = nil
		self:SetCharID(0)
		self.ownerCharName = nil
		self.owner = nil
		self.ownerLastSeen = nil
		self:SetPremium(false)

		self:SetCleanup(0)
	end

	if (newType == self.PUBLIC) then
		self:SetType(self.PUBLIC)
	elseif (newType == self.GROUP) then
		local args = {...}
		self:SetType(self.GROUP)
		self:ResetUsers()
		self:UpdateAdminText(args[1])
	elseif (newType == self.PRIVATE) then
		local args = {...}
		self:SetType(self.PRIVATE)
		self:SetPrivateOwner(args[1])
	elseif (newType == self.CLEANUP) then
		ix.log.AddRaw("The "..self:GetDisplayName().." container (#"..self:GetInventory():GetID()..") was set to CLEANUP.")
		self:SetCleanup(os.time() + ix.config.Get("containerRemoveGrace") * 24 * 3600)
		self:SetType(self.CLEANUP)
	elseif (newType == self.MANCLEANUP) then
		ix.log.AddRaw("The "..self:GetDisplayName().." container (#"..self:GetInventory():GetID()..") was set to MANUAL CLEANUP.")
		self:SetCleanup(os.time() + ix.config.Get("containerRemoveGrace") * 24 * 3600)
		self:SetType(self.MANCLEANUP)
	elseif (newType == self.PKHOLD) then
		ix.log.AddRaw("The "..self:GetDisplayName().." container (#"..self:GetInventory():GetID()..") was set to PK HOLD.")
		self:SetCleanup(os.time() + ix.config.Get("containerPKGrace") * 24 * 3600)
		self:SetType(self.PKHOLD)
	end

	ix.saveEnts:SaveEntity(self)
end

function ENT:SaveType(data)
	data.type = self:GetType()
	data.adminText = self:GetAdminText()
	data.lastUsed = self:GetLastUsed()
	if (data.type == self.GROUP) then
		data.users = self.users
		data.usersReset = self.usersReset
	elseif (data.type == self.PRIVATE) then
		data.ownerCharID = self.ownerCharID
		data.ownerCharName = self.ownerCharName
		data.owner = self.owner
		data.ownerLastSeen = self.ownerLastSeen
		data.premiumExpired = self.premiumExpired == true
	elseif (data.type == self.CLEANUP or data.type == self.PKHOLD or data.type == self.MANCLEANUP) then
		data.cleanup = self:GetCleanup()
	end
end

function ENT:RestoreType(data)
	self:SetType(data.type)
	self:SetAdminText(data.adminText)
	self:SetLastUsed(data.lastUsed)

	if (data.type == self.PUBLIC) then
		self:SetPass("")
	elseif (data.type == self.GROUP) then
		self.users = data.users
		self.usersReset = data.usersReset
		self.adminText = data.adminText
	elseif (data.type == self.PRIVATE) then
		self.ownerCharID = data.ownerCharID
		self:SetCharID(self.ownerCharID)
		self.ownerCharName = data.ownerCharName
		self.owner = data.owner
		self.ownerLastSeen = data.ownerLastSeen
		self.premiumExpired = data.premiumExpired
	elseif (data.type == self.CLEANUP or data.type == self.MANCLEANUP) then
		if (data.cleanup < os.time()) then
			ix.log.AddRaw("The "..self:GetDisplayName().." container (#"..self:GetInventory():GetID()..") was removed due to inactivity.")
			self:Remove()
			return
		end
		self:SetCleanup(data.cleanup)
	elseif (data.type == self.PKHOLD) then
		if (data.cleanup < os.time()) then
			self:SetType(self.CLEANUP)
			self:SetCleanup(data.cleanup + ix.config.Get("containerPKGrace") * 24 * 3600)
			return
		end
		self:SetCleanup(data.cleanup)
	end
end

function ENT:SetPassword(password)
	if (self:CanHavePassword()) then
		self:SetPass(password or "")
		self:ResetUsers()
		self.Sessions = {}
		ix.saveEnts:SaveEntity(self)
	end
end

function ENT:UpdateAdminText(text)
	if (self:GetType() == self.PRIVATE) then
		local ownerText = {self.ownerCharName, util.SteamIDFrom64(self.owner)}
		if (self:GetPremium()) then
			ownerText[#ownerText + 1] = "Premium"
		end
		self:SetAdminText(table.concat(ownerText, " - "))
	else
		self:SetAdminText(text)
	end
	ix.saveEnts:SaveEntity(self)
end

function ENT:UpdateLastUsed()
	self:SetLastUsed(os.time())
end

--[[
	PRIVATE CONTAINERS
]]
function ENT:SetPrivateOwner(client)
	local character = client:GetCharacter()
	if (self:GetType() == self.PRIVATE and character) then
		self.ownerCharID = character:GetID()
		self:SetCharID(self.ownerCharID)
		self.ownerCharName = character:GetName()
		self.owner = client:SteamID64()
		self.ownerName = client:SteamName()
		self.ownerLastSeen = os.time()
		self:UpdateAdminText()
	end
end

function ENT:UpdatePrivateOwner(client)
	if (self:GetType() == self.PRIVATE and client:GetCharacter() and self.ownerCharID == client:GetCharacter():GetID()) then
		self.ownerLastSeen = os.time()
		self.ownerCharName = client:GetCharacter():GetName()
		self.ownerName = client:SteamName()
		self:UpdateAdminText()
		self:UpdateLastUsed()
	end
end

function ENT:TogglePremium()
	if (self:GetType() != self.PRIVATE) then return end
	self:SetPremium(!self:GetPremium())
	self:UpdateAdminText()
end

--[[
	GROUP CONTAINERS
]]
function ENT:UpdateUser(client)
	if (!self.users) then return end

	local character = client:GetCharacter()
	if (!character) then return end

	local charID = character:GetID()
	for k, v in ipairs(self.users) do
		if (v.charID == charID) then
			v.time = os.time()
			ix.saveEnts:SaveEntity(self)
			return true
		end
	end

	return false
end

function ENT:AddUser(client)
	if (self.users and !self:UpdateUser(client)) then
		self:UpdateLastUsed()
		self.users[#self.users + 1] = {id = client:SteamID64(), charID = client:GetCharacter():GetID(), time = os.time()}
		ix.saveEnts:SaveEntity(self)
	end
end

function ENT:RemoveUser(charID)
	if (!self.users) then return end

	for k, v in ipairs(self.users) do
		if (v.charID == charID) then
			table.remove(self.users, k)
			if (#self.users == 0) then
				self:CheckActivity()
			else
				ix.saveEnts:SaveEntity(self)
			end
			return
		end
	end
end

function ENT:CleanupUsers()
	if (!self.users) then return end

	local newUsers = {}
	for k, v in ipairs(self.users) do
		if (v.time > os.time() - 3600 * 24 * ix.config.Get("containerInactivityDays")) then
			newUsers[#newUsers + 1] = v
		end
	end

	self.users = newUsers
	ix.saveEnts:SaveEntity(self)
end

function ENT:ResetUsers()
	if (self:GetType() == self.GROUP and self:GetPassword() != "") then
		self.users = {}
		self.usersReset = os.time()
	else
		self.users = nil
	end
end

--[[
	ACTIVITY
]]
function ENT:CheckActivity()
	if (self:GetType() == self.GROUP) then
		self:CleanupUsers()
		if (self.users and #self.users == 0) then
			if (self.usersReset > os.time() - ix.config.Get("containerSetupGrace") * 24 * 3600) then
				return -- still in grace period
			end
			self:ChangeType(self.CLEANUP)
		end
	elseif (self:GetType() == self.PRIVATE and self.ownerLastSeen) then
		if (self.ownerLastSeen > os.time() - ix.config.Get("containerInactivityDays") * 24 * 3600) then
			return -- still active
		end

		local query = mysql:Insert("ix_container_inactive")
			query:Insert("inv_id", self:GetID())
			query:Insert("steamid", self.owner)
			query:Insert("character_id", self.ownerCharID)
			query:Insert("money", self:GetMoney())
			query:Insert("datetime", os.time())
			query:Insert("model", self:GetModel())
		query:Execute()

		ix.log.AddRaw("The "..self:GetDisplayName().." container (#"..self:GetInventory():GetID()..") was inactive and has been soft-removed.")

		self:SetID(0)
		self:Remove()
	end
end

function ENT:ContainerUsed(client)
	if (self:GetType() == self.PUBLIC or
		(self:GetType() == self.GROUP and self:GetPassword() == "")) then
		self:UpdateLastUsed()
	elseif (self:GetType() == self.GROUP) then
		self:AddUser(client)
	end
end

--[[
	GENERAL FUNCS
]]
function ENT:SetInventory(inventory, bNoSave)
	if (inventory) then
		if (inventory.vars.entity and IsValid(inventory.vars.entity) and inventory.vars.entity != self) then
			ErrorNoHalt("[WNCONT] Attempted to set inventory #"..inventory:GetID().." on container, but inventory already has an entity!")
			return
		end

		self:SetID(inventory:GetID())
		if (ix.saveEnts and !bNoSave) then
			ix.saveEnts:SaveEntity(self)
		end
	end
end

function ENT:SetMoney(amount)
	self.money = math.max(0, math.Round(tonumber(amount) or 0))
	if (ix.saveEnts) then
		ix.saveEnts:SaveEntity(self)
	end
end

function ENT:GetMoney()
	return self.money or 0
end

function ENT:OnRemove()
	local index = self:GetID()

	if (!ix.shuttingDown and !self.ixIsSafe and ix.entityDataLoaded and index) then
		local inventory = index != 0 and ix.item.inventories[index]

		if (inventory) then
			if (inventory.vars.entity and IsValid(inventory.vars.entity) and inventory.vars.entity != self) then
				return
			end

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

function ENT:OpenInventory(activator)
	local inventory = self:GetInventory()
	if (inventory) then
		if (self:GetType() == self.CLEANUP or self:GetType() == self.MANCLEANUP) then
			activator:NotifyLocalized("wncontCleanup", os.date("%Y-%m-%d %X", self:GetCleanup()))
		end

		local name = self:GetDisplayName()

		ix.storage.Open(activator, inventory, {
			name = name,
			entity = self,
			bMultipleUsers = true,
			searchTime = ix.config.Get("containerOpenTime", 0.7),
			data = {money = self:GetMoney()},
			OnPlayerClose = function()
				ix.log.Add(activator, "closeContainer", name, inventory:GetID())
			end
		})

		ix.log.Add(activator, "openContainer", name, inventory:GetID())
		self:ContainerUsed(activator)
	end
end

function ENT:Use(activator)
	if (self:GetType() == self.PKHOLD and self:GetCleanup() > os.time()) then
		activator:NotifyLocalized("containerPKHold",  os.date("%Y-%m-%d %X", self:GetCleanup()))
		return
	end

	local inventory = self:GetInventory()

	if (inventory and (activator.ixNextOpen or 0) < CurTime()) then
		local character = activator:GetCharacter()

		if (character) then
			if (activator:SteamID64() == self.owner and character:GetID() != self.ownerCharID) then
				activator:NotifyLocalized("wncontOwnDifferentChar")
				return
			end
			local def = ix.container.stored[self:GetModel():lower()]
			if (self:GetLocked() and !self.Sessions[character:GetID()] and !self:GetNetVar("isOneWay", false)) then
				self:EmitSound(def.locksound or "doors/default_locked.wav")

				if (!self.keypad) then
					net.Start("ixWNContainerPassword")
						net.WriteEntity(self)
					net.Send(activator)
				end
			else
				self:OpenInventory(activator)
			end
		end

		activator.ixNextOpen = CurTime() + 1
	end
end