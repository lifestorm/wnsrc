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
local Vector = Vector
local timer = timer

AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Combine Barricade"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.PhysgunDisable = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/props_combine/combine_barricade_short01a.mdl")

		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:PhysicsInit(SOLID_VPHYSICS)
		self.health = 400

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		--self:FreezeBarricade()
	end
--[[
	function ENT:FreezeBarricade()
		timer.Create("Freeze", 3, 0, function()
			local physObj = self:GetPhysicsObject()

			if (IsValid(physObj)) then
				physObj:EnableMotion(false)
				physObj:Sleep()
			end
		end)
	end--]]

	function ENT:OnTakeDamage(damage)
		self.health = self.health - damage:GetDamage()
--		self:SetHealth(self.health - damage:GetDamage())

		if (!IsValid(self.spark)) then
			self.spark = ents.Create("env_spark")
		end
		if (!IsValid(self.explosion)) then
			self.explosion = ents.Create("npc_grenade_frag")
		end

		if (self.health <= 0) then
			self.spark:SetPos(self:GetPos() + Vector(0, 10, 0))
			self.spark:Fire("SparkOnce")
			self.explosion:SetPos(self.spark:GetPos())
			self.explosion:Fire("Timer", 0.01)
			self.explosion:Fire("SetTimer", 0.01)
			timer.Remove("PrintTimer" .. self:EntIndex())
			self:Remove()
		end
	end

	function ENT:OnRemove()
		if (IsValid(self.spark) or IsValid(self.explosion)) then
			timer.Simple(5, function()
				if (IsValid(self.spark)) then self.spark:Remove() end
				if (IsValid(self.explosion)) then self.explosion:Remove() end
			end)
		end
	end
end