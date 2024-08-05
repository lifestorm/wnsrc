--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


DEFINE_BASECLASS("ix_combinelock")

AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Group Lock"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Locked")
	self:NetworkVar("Bool", 1, "DisplayError")
	self:NetworkVar("Bool", 2, "Disabled")
	self:NetworkVar("Int", 3, "GroupID")

	if (SERVER) then
		self:NetworkVarNotify("Locked", self.OnLockChanged)
	end
end

if (SERVER) then
	function ENT:SpawnFunction(client, trace)
		local character = client:GetCharacter()
		local group = character:GetGroup()
		local door = trace.Entity

		if (!IsValid(door) or !door:IsDoor() or IsValid(door.ixLock)) then
			return client:NotifyLocalized("dNotValid")
		end

		if (!group or !group.active) then
			return client:Notify("You cannot place a lock without being in an active group.")
		end

		local role = group:GetRoleID(character:GetID())

		if (role != GROUP_LEAD and role != GROUP_MOD) then
			return client:Notify("You do not have permission to place a group lock.")
		end

		local normal = client:GetEyeTrace().HitNormal:Angle()
		local position, angles = self:GetLockPosition(door, normal)

		local entity = ents.Create("ix_grouplock")
		entity:SetPos(trace.HitPos)
		entity:Spawn()
		entity:Activate()
		entity:SetDoor(door, position, angles)
		entity:SetGroupID(group:GetID())
		entity:SetHealth(100)

		ix.saveEnts:SaveEntity(entity)

		return entity
	end

	function ENT:OnRemove()
		if (IsValid(self)) then
			self:SetParent(nil)
		end

		if (IsValid(self.door)) then
			self.door:Fire("unlock")
			self.door.ixLock = nil
		end

		if (IsValid(self.doorPartner)) then
			self.doorPartner:Fire("unlock")
			self.doorPartner.ixLock = nil
		end
	end

	function ENT:Toggle(client)
		if (self:GetDisabled()) then return end

		if (self.nextUseTime > CurTime()) then
			return
		end

		local group = client:GetCharacter():GetGroup()

		if (!client:HasActiveCombineSuit() and !ix.faction.Get(client:Team()).allowUseGroupLock and (!group or group:GetID() != self:GetGroupID())) then
			self:DisplayError()
			self.nextUseTime = CurTime() + 2

			return
		end

		self:SetLocked(!self:GetLocked())
		self.nextUseTime = CurTime() + 2

		ix.saveEnts:SaveEntity(self)
	end
else
	local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")
	local color_green = Color(0, 255, 0, 255)
	local color_purple = Color(138, 43, 226, 255)
	local color_red = Color(255, 50, 50, 255)

	function ENT:GetLightColor()
		local color = color_green

		if (self:GetDisplayError()) then
			color = color_red
		elseif (self:GetLocked()) then
			color = color_purple
		end

		color.a = 255 * self:Health() / 100

		return color
	end

	function ENT:Draw()
		self:DrawModel()

		if (self:GetDisabled()) then return end

		local position = self:GetPos() + self:GetUp() * -8.7 + self:GetForward() * -3.85 + self:GetRight() * -6

		render.SetMaterial(glowMaterial)
		render.DrawSprite(position, 10, 10, self:GetLightColor())
	end
end
