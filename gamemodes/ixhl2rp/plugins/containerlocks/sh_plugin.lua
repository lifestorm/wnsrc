--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix
local netstream = netstream
local Derma_StringRequest = Derma_StringRequest
local L = L
local properties = properties
local gamemode = gamemode
local net = net
local LocalPlayer = LocalPlayer
local IsValid = IsValid


local PLUGIN = PLUGIN

PLUGIN.name = "Container Locks"
PLUGIN.author = "Fruity"
PLUGIN.description = "Adds in a locking mechanism."

ix.container.Register("models/willardnetworks/safe.mdl", {
	name = "Safe",
	description = "An unbreakable safe to keep your items in.",
	width = 4,
	height = 4,
	sizeClass = "safe"
})

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	netstream.Hook("LockSetContainerPassword", function(entity, bShouldHaveLock, lockEntityID)
		Derma_StringRequest(L("containerPasswordWrite"), "", "", function(text)
			netstream.Start("LockSetContainerPassword", entity, text, lockEntityID)
		end, function()
			if bShouldHaveLock then
				netstream.Start("LockOnCancel", entity)
			end
		end)
	end)
end

properties.Add("container_changepassword", {
	MenuLabel = "Change Password",
	Order = 402,
	MenuIcon = "icon16/lock_edit.png",

	Filter = function(self, entity, client)
		if (!gamemode.Call("CanProperty", client, "container_changepassword", entity)) then return false end
		if (entity:GetClass() != "ix_container" and !entity:IsDoor()) then return false end

		return true
	end,

	Action = function(self, entity)
		if (entity.GetLocked and entity:GetLocked()) or (entity:IsDoor() and #entity:GetChildren() > 0) then
			Derma_StringRequest("This container/door is already locked, write the password to change it", "", "", function(text)
				if (entity.GetPassword and text == entity:GetPassword()) or (entity:IsDoor() and text == entity:GetChildren()[1]:GetPassword()) then
					Derma_StringRequest("Enter the password you want it to change to", "", "", function(newPass)
						self:MsgStart()
							net.WriteEntity(entity)
							net.WriteString(newPass)
						self:MsgEnd()
					end)
				else
					LocalPlayer():NotifyLocalized("Wrong password.")
				end
			end)
		else
			Derma_StringRequest("Enter new password", "", "", function(text)
				self:MsgStart()
					net.WriteEntity(entity)
					net.WriteString(text)
				self:MsgEnd()
			end)
		end
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local password = net.ReadString()

		entity.Sessions = {}

		if (password:utf8len() != 0) then
			if entity.SetLocked then
				entity:SetLocked(true)
				entity:SetPassword(password)
				entity.password = password

				client:NotifyLocalized("containerPassword", password)
			else
				if entity.locked and IsValid(entity.locked) then
					entity.locked.password = password
					entity.locked:SetPassword(password)
					client:Notify("You have changed this door's password to "..password)
					ix.saveEnts:SaveEntity(entity)
				else
					client:Notify("No container/door lock on this door.")
				end
			end
		else
			if entity.SetLocked then
				entity:SetLocked(false)
				entity:SetPassword(nil)
				entity.password = nil

				client:NotifyLocalized("containerPasswordRemove")
			else
				if entity.locked and IsValid(entity.locked) then
					entity.locked.password = nil
					entity.locked:SetPassword(nil)
					entity:Fire("Unlock")
				end
			end
		end

		if !entity.SetLocked then return end

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()


		local definition = ix.container.stored[entity:GetModel():lower()]

		if (definition) then
			entity:SetDisplayName(definition.name)
		end

		ix.log.Add(client, "containerPassword", name, inventory:GetID(), password:utf8len() != 0)
	end
})

properties.Add("containerlock_checkowner", {
	MenuLabel = "Check Owner",
	Order = 399,
	MenuIcon = "icon16/user.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_containerlock") then return false end
		if (!gamemode.Call("CanProperty", client, "containerlock_checkowner", entity)) then return false end

		return true
	end,

	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local steamidNot64 = entity:GetNetVar("owner")
		if !steamidNot64 then client:Notify("No owner assigned.") return end

		local ownerEnt = player.GetBySteamID(steamidNot64) or false

		if (ownerEnt and IsValid(ownerEnt)) then
			client:Notify("Lock owner is "..ownerEnt:SteamName().." ("..steamidNot64.."). This player is online!")
		else
			client:Notify("Lock owner's SteamID is: "..steamidNot64.." - This player is offline!")
			PLUGIN:PrintDateSinceOnline(client, steamidNot64)
		end
	end
})

properties.Add("containerlock_setowner", {
	MenuLabel = "Set Owner",
	Order = 400,
	MenuIcon = "icon16/lock_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_containerlock") then return false end
		if (!gamemode.Call("CanProperty", client, "containerlock_setowner", entity)) then return false end

		return true
	end,

	Action = function(self, entity)
		Derma_StringRequest("Set lock owner", "Enter new owner's SteamID", entity:GetNetVar("owner"), function(text)
			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local ownerSteamID = net.ReadString()

		if (ownerSteamID:len() != 0) then
			entity:SetNetVar("owner", ownerSteamID)

			client:Notify("Lock owner successfully changed")
		else
			entity:SetNetVar("owner")

			client:Notify("Lock owner successfully removed")
		end

		local inventory = entity:GetParent():GetInventory()
		ix.log.Add(client, "containerlockSetOwner", inventory:GetID(), ownerSteamID)
	end
})

properties.Add("door_lockunlock", {
	MenuLabel = "Lock/Unlock Door",
	Order = 402,
	MenuIcon = "icon16/lock_edit.png",

	Filter = function(self, entity, client)
		if (!gamemode.Call("CanProperty", client, "door_lockunlock", entity)) then return false end
		if (!entity:IsDoor()) then return false end

		return true
	end,

	Action = function(self, entity)
		self:MsgStart()
		net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local doorLocked = entity:GetSaveTable()["m_bLocked"]

		entity:Fire(doorLocked and "Unlock" or "Lock")
		local doorPartner = entity:GetDoorPartner()
		if (IsValid(doorPartner)) then
			doorPartner:Fire(doorLocked and "Unlock" or "Lock")
		end
	end
})

if (CLIENT) then
	net.Receive("ixDoorPassword", function(length)
		local entity = net.ReadEntity()

		Derma_StringRequest(
			L("containerPasswordWrite"),
			L("containerPasswordWrite"),
			"",
			function(val)
				net.Start("ixDoorPassword")
					net.WriteEntity(entity)
					net.WriteString(val)
				net.SendToServer()
			end
		)
	end)
end