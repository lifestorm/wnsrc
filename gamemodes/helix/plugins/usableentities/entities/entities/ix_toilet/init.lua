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

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	ix.inventory.New(0, "toilet", function(inventory)
		if (!IsValid(self)) then return end

		if (inventory) then
			inventory.vars.isBag = true

			self:SetNetVar("ID", inventory:GetID())	
		end
	end)
end

function ENT:OnOptionSelected(client, option, data)
	if (option == "Open") then
		local inventory = ix.item.inventories[self:GetNetVar("ID")]

		if (inventory) then
			ix.storage.Open(client, inventory, {
				name = "Toilet",
				entity = self,
				searchTime = 1
			})
		end
	elseif (option == "Flush") then
		if (self.nextFlush or 0) < CurTime() then
			self.nextFlush = CurTime() + 7

			local inventory = ix.item.inventories[self:GetNetVar("ID")]

			if (inventory) then
				for _, item in pairs(inventory:GetItems()) do
					item:Remove()
				end
			end

			self:EmitSound("ambient/machines/usetoilet_flush1.wav", nil, math.random(90, 110))
		end
	end
end

function ENT:OnRemove()
	if (!ix.shuttingDown) then
		local index = self:GetNetVar("ID")

		if (!self.ixIsSafe and ix.entityDataLoaded and index) then
			local inventory = index != 0 and ix.item.inventories[index]

			if (inventory) then
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
end
