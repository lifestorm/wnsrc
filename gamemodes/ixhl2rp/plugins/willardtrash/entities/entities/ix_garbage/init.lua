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

function ENT:Initialize()
	local garbageModels = {
		"models/willardnetworks/props/trash01.mdl",
		"models/willardnetworks/props/trash02.mdl",
		"models/willardnetworks/props/trash03.mdl"
	}
	self.items = {}
	for i, itemTable in pairs(ix.item.list) do
		if (itemTable.category == "Junk") then
			self.items[i] = itemTable
		end
	end
	self:SetModel(table.Random(garbageModels))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	local phys = self:GetPhysicsObject()
	phys:SetMass( 120 )
	self.alive = true
end

function ENT:UpdateTransmitState()
	return TRANSMIT_PVS
end

function ENT:PhysicsUpdate(physicsObject)
	if (!self:IsPlayerHolding() and !self:IsConstrained()) then
		physicsObject:SetVelocity( Vector(0, 0, 0) )
		physicsObject:Sleep()
	end
end

function ENT:Use(activator, caller)
	if (activator:IsPlayer() and activator:GetEyeTraceNoCursor().Entity == self) then
		local char = activator:GetCharacter()
		if (istable(char)) then
			local cooldown = char:GetTrashCooldownTime()
			if (cooldown > 0) then
				activator:NotifyLocalized("You cannot search the trash for "..tostring(cooldown).." more seconds.")
				return
			end
		end
		if (activator:Crouching()) then
			if (!self.alive) then
				activator:NotifyLocalized("Someone else is already cleaning the trash!")
				return
			else
				self.alive = false
			end
			local trashSearchTime = char:GetActionTimeInfluencedByEnergyLevel(ix.config.Get("Trash Search Time", 10))

			local filter = RecipientFilter()
			filter:AddPVS(self:GetPos())

			self.trashSound = CreateSound(self, "wn_trashbags/trash_search.wav", filter)
			self.trashSound:Play()

			activator:SetAction(
				"You are searching through the trash...", trashSearchTime, function()
					local character = activator:GetCharacter()
					if (!istable(character)) then
						return
					end
					local attempts = char:GetTrashCooldownWindowAttempts()
					char:SetTrashCooldownWindowAttempts(attempts + 1)

					if self.trashSound then
						self.trashSound:Stop()
						self.trashSound = nil
					end

					activator.searchingGarbage = true
					activator:EmitSound("physics/body/body_medium_impact_soft" .. math.random(1, 7) .. ".wav")

					local chance = math.random(0, 100)
					local minPly, maxPly = ix.config.Get("Trash Min Players"), ix.config.Get("Trash Max Players")
					local required = math.Remap(math.Clamp(#player.GetAll(), minPly, maxPly), minPly, maxPly, ix.config.Get("Trash Min Chance"), ix.config.Get("Trash Max Chance"))

					if (chance <= required) then
						local multiplier = ix.config.Get("Trash Search Multiplier")
						local max = ix.config.Get("Trash Search Max Items")
						local targetInventory = character:GetInventory()

						if (!targetInventory) then return end

						local numItems = math.Round(math.random(1, max) * (math.random(0.0, 0.75) * multiplier))

						if (numItems > max) then
							numItems = max
						elseif (numItems < 1) then
							numItems = 1
						end

						if (self.items) then
							for i = numItems,1,-1 do
								local item = table.Random(self.items)

								if (item) then
									if (targetInventory:Add(item.uniqueID, 1)) then
										local name = string.lower(item.name)
										local text = "You found: " .. '"' .. name .. '"' .. "."
										activator:NotifyLocalized(text)
									else
										ix.item.Spawn(item.uniqueID, activator)
									end
								end
							end
						end
					else
						activator:NotifyLocalized("You failed to find anything.")
					end

					if (self and self:IsValid()) then
						activator.searchingGarbage = nil

						self:Remove()
					end
				end
			)

			local uniqueID = "CheckIfStillSearching_" .. activator:SteamID64()
			timer.Create(uniqueID, 0.5, 0, function()
				if (IsValid(activator)) then
					if (IsValid(self) and IsValid(self:GetPhysicsObject())) then
						if (self:GetPos():DistToSqr(activator:GetPos()) > 2500 or !activator:Crouching()) then
							activator:SetAction(false)
							activator.searchingGarbage = nil
							self.alive = true
							timer.Remove(uniqueID)
							activator:NotifyLocalized("You walked away from the trash and stopped searching.")

							if self.trashSound then
								self.trashSound:Stop()
								self.trashSound = nil
							end
						end
					elseif (activator.searchingGarbage) then
						activator:SetAction(false)
						activator.searchingGarbage = nil
						timer.Remove(uniqueID)
						activator:NotifyLocalized("The trash was removed before you could finish searching.")

						if self.trashSound then
							self.trashSound:Stop()
							self.trashSound = nil
						end
					end
				else
					if (IsValid(self)) then self.alive = true end
					timer.Remove(uniqueID)

					if self.trashSound then
						self.trashSound:Stop()
						self.trashSound = nil
					end
				end
			end)
		else
			activator:NotifyLocalized("You need to crouch down to search through the trash.")
		end
	end
end

function ENT:CanTool(player, trace, tool)
	return false
end
