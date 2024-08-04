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
local IsValid = IsValid
local ents = ents
local timer = timer
local ix = ix
local Color = Color
local render = render


AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Breaching Charge"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

if (SERVER) then
	function ENT:GetHandlePosition(door, position, normal)
		normal = normal or door:GetForward():Angle()
		position = position + normal:Forward() * 0 + normal:Up() * 0 + normal:Right() * 0

		normal:RotateAroundAxis(normal:Forward(), 180)
		normal:RotateAroundAxis(normal:Right(), 270)

		return position, normal
	end

	function ENT:SetDoor(door, position, angles)
		if (!IsValid(door) or !door:IsDoor()) then
			return
		end

		self.door = door
		self.door:DeleteOnRemove(self)
		door.ixBreach = self

		self:SetPos(position)
		self:SetAngles(angles)
		self:SetParent(door)
	end

	function ENT:SpawnFunction(client, trace)
		local door = trace.Entity

		if (!IsValid(door) or !door:IsDoor() or IsValid(door.ixLock)) then
			return client:NotifyLocalized("dNotValid")
		end

		local normal = trace.HitNormal:Angle()
		local position, angles = self:GetHandlePosition(door, trace.HitPos, normal)

		local entity = ents.Create("ix_breachingcharge")
		entity:SetPos(trace.HitPos)
		entity:Spawn()
		entity:Activate()
		entity:SetDoor(door, position, angles)

--		entity:EmitSound("weapons/c4/c4_plant.wav", 80)
--		entity:EmitSound("weapons/c4/c4_disarm.wav", 100)

		self:BlowUp()

		return entity
	end

	function ENT:BlowUp()
		if (!IsValid(self.door) or self.bIsBlowingUP) then
			return
		end

		self.bIsBlowingUP = true

		local func = function()
			if (IsValid(self)) then
				self:EmitSound("weapons/c4/c4_click.wav")
			end
		end
		timer.Simple(1.0, func)
		timer.Simple(2.0, func)
		timer.Simple(3.0, func)
		timer.Simple(3.5, func)
		timer.Simple(4.0, func)
		timer.Simple(4.2, func)
		timer.Simple(4.5, func)
		timer.Simple(4.7, func)
		timer.Simple(4.9, func)
		timer.Simple(5.0, function()
			if (IsValid(self)) then
				local explode = ents.Create("env_explosion")
				explode:SetPos(self:GetPos())
				explode:SetOwner(self)
				explode:Spawn()
				explode:SetKeyValue("iMagnitude", 100)
				explode:SetKeyValue("iRadiusOverride", 30)
				explode:Fire("Explode", 0, 0)
				explode:EmitSound("weapons/c4/c4_explode1.wav", 100, 100)
				self.door:BlastDoor(self:GetUp() * -750, 60, false)
				self:Remove()
			end
		end)
		return true
	end

	function ENT:Initialize()
		self:SetModel("models/weapons/w_c4_planted.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)

		self.nextUseTime = 0
	end

	function ENT:Use()
		self:EmitSound("buttons/button9.wav")
		self:BlowUp()
	end
else
	local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")
	local color_red = Color(255, 50, 50, 255)

	function ENT:Draw()
		self:DrawModel()

		local color = color_red

		local position = self:GetPos() + self:GetUp() * 4.25 + self:GetForward() * 1.25 + self:GetRight() * 2.1

		render.SetMaterial(glowMaterial)
		render.DrawSprite(position, 3, 3, color)
	end
end
