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

	local SpawnPosition = trace.HitPos + trace.HitNormal
	local SpawnAngle = client:EyeAngles()
	SpawnAngle.p = 0
	SpawnAngle.y = SpawnAngle.y + 180

	local entity = ents.Create("ix_infestation_tank")
	entity:SetPos(SpawnPosition)
	entity:SetAngles(SpawnAngle)
	entity:Spawn()
	entity:Activate()

	ix.saveEnts:SaveEntity(entity)
	PLUGIN:SaveInfestationTanks()

	return entity
end

function ENT:Initialize()
	self:SetModel("models/jq/hlvr/props/xen/combine_foam_tank_set.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetSkin(1)
	self:SetBodygroup(self:FindBodygroupByName("Hose"), 1)
	self:SetBodygroup(self:FindBodygroupByName("Applicator"), 1)

	local physicsObject = self:GetPhysicsObject()

	if (IsValid(physicsObject)) then
		physicsObject:Wake()
		physicsObject:EnableMotion(false)
	end
end

function ENT:OnOptionSelected(client, option, data)
	if (option == "Detach Hose") then
		if (self:GetHoseAttached()) then
			if (!self:GetApplicatorAttached()) then
				if (!client:GetCharacter():GetInventory():Add("ic_hose")) then
					ix.item.Spawn("ic_hose", client)
				end

				self:SetHoseAttached(false)
				self:SetBodygroup(self:FindBodygroupByName("Hose"), 1)

				client:NotifyLocalized("hoseDetachedSuccess")
			else
				client:NotifyLocalized("hoseDetachedFailure")
			end
		else
			client:NotifyLocalized("noHoseAttached")
		end
	elseif (option == "Detach Applicator") then
		if (self:GetApplicatorAttached()) then
			if (!client:GetCharacter():GetInventory():Add("applicator")) then
				ix.item.Spawn("applicator", client)
			end

			self:SetApplicatorAttached(false)
			self:SetBodygroup(self:FindBodygroupByName("Applicator"), 1)

			client:NotifyLocalized("applicatorDetachedSuccess")
		else
			client:NotifyLocalized("noApplicatorAttached")
		end
	elseif (option == "Pack Up") then
		if (self:GetApplicatorAttached()) then
			client:NotifyLocalized("packUpFailureApplicator")
		elseif (self:GetHoseAttached() or self:GetHoseConnected()) then
			client:NotifyLocalized("packUpFailureHose")
		else
			local dataTable = {
				ChemicalVolume = self:GetChemicalVolume(),
				ChemicalType = self:GetChemicalType(),
				TankColor = self:GetColor()
			}

			if (client:GetCharacter():GetInventory():Add("ic_tank", 1, dataTable)) then
				self:Remove()

				client:NotifyLocalized("packUpSuccess")
			else
				client:NotifyLocalized("packUpFailureInventory")
			end
		end
	end
end
