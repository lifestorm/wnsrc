--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local AddCSLuaFile = AddCSLuaFile
local include = include


AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/willardnetworks/misc/prison_padlock001a.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow(false)

	local physics = self:GetPhysicsObject()
	physics:EnableMotion(false)
	physics:Sleep()

	self:PrecacheGibs()
end

function ENT:Use(client)
	local curTime = CurTime()

	if (self.nextUse and self.nextUse > curTime) then return end

	local door = self.door

	if !IsValid(door) then return end

	if !door.GetSaveTable then return end
	if !door:GetSaveTable() then return end

	self.nextUse = curTime + 1

	if (door:GetSaveTable()["m_bLocked"]) then
		if (door.Sessions and door.Sessions[client:SteamID()]) then
			door:Fire("Unlock")

			door.Sessions[client:SteamID()] = true

			local doorPartner = door:GetDoorPartner()
			if (IsValid(doorPartner)) then
				doorPartner:Fire("Unlock")
				doorPartner.Sessions = doorPartner.Sessions or {}
				doorPartner.Sessions[client:SteamID()] = true
			end

			door:EmitSound("doors/latchunlocked1.wav")

			return
		end

		net.Start("ixDoorPassword")
		net.WriteEntity(self.door)
		net.Send(client)

		return
	end

	if !self.password then
		client:Notify("There's no password on this lock, avoiding locking.")
		return
	end

	door:Fire("Lock")
	door:Fire("Close")

	local doorPartner = door:GetDoorPartner()

	if (IsValid(doorPartner)) then
		doorPartner:Fire("Lock")
		doorPartner:Fire("Close")
	end

	door:EmitSound("doors/latchlocked2.wav")
	client:Notify("You have locked the door again.")
end

function ENT:OnTakeDamage( dmginfo )
	local groupPlugin = ix.plugin.list["groupmanager"]
	local groupStored = groupPlugin.stored

	if groupStored[self:GetParent().group] then
		local group = groupStored[self:GetParent().group]
		if #group:GetOnlineMembers() <= 0 then
			return false
		end
	end

	-- If owner is offline don't apply the damage
	if (self:GetNetVar("owner") and !IsValid(player.GetBySteamID(self:GetNetVar("owner")))) then
		return false
	end

	local inflictor = dmginfo:GetInflictor()

	-- Damage the player when hitting the metal lock with the bare hands
	if (IsValid(inflictor) and inflictor:GetClass() == "ix_hands") then
		dmginfo:GetAttacker():TakeDamage(dmginfo:GetDamage())
		return false
	end

	-- Make sure we're not already applying damage a second time
	-- This prevents infinite loops
	if ( !self.m_bApplyingDamage ) then
		self.m_bApplyingDamage = true
		self:TakeDamageInfo( dmginfo )

		if (self.LockHealth <= 0) then return end -- If the lock health is already zero or below it - do nothing - prevent errors

		self.LockHealth = self.LockHealth - dmginfo:GetDamage() -- Reduce the amount of damage took from lock health
		if (self.LockHealth <= 0) then -- If lock health variable is zero or below it
			self:EmitSound("physics/metal/metal_box_break1.wav")
			self:GibBreakClient(self:GetForward() * 200)

			if self.door then self.door.locked = nil end
			
			self:Remove()
		end

		self.m_bApplyingDamage = false
	end
end

function ENT:SetParentUnlocked()
	if (IsValid(self:GetParent()) and !self:GetParent():GetClass():find("door")) then
		self:GetParent():SetLocked(false)
		self:GetParent().password = nil
	end
end

function ENT:OnRemove()
	self:SetParentUnlocked()
end
