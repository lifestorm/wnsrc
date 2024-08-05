--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/fruity/combine_tptimer_edit.mdl" )
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self:SetAngles(self:GetAngles() + Angle(0, 180, 0))
	self.canUse = true

    self.bin = ents.Create("prop_dynamic")
    self.bin:SetPos(self:GetPos() + self:GetForward() * -67.2 + self:GetRight() * -1.6)
    self.bin:SetAngles(self:GetAngles() + Angle(0, 180, 0))
    self.bin:SetModel("models/props/de_vostok/hardwarebina.mdl")
    self.bin:Activate()
    self.bin:SetParent(self)
	self.bin:SetModelScale(4.3)
    self.bin:DeleteOnRemove(self)
	self.bin:SetMaterial("models/props_combine/combine_barricade_tall02b.vmt")

	self.spark = ents.Create("env_spark")

    local lifter = ents.Create("prop_dynamic")
    lifter:SetPos(self:GetPos() + self:GetForward() * -70.2 + self:GetRight() * -1.5)
    lifter:SetAngles(self:GetAngles() + Angle(0, 180, 0))
    lifter:SetModel("models/fruity/trash_collector_lifter.mdl")
    lifter:Activate()
    lifter:SetParent(self)
    lifter:Spawn()
    lifter:DeleteOnRemove(self)
	lifter:SetMaterial("models/props_combine/combine_barricade_tall02b.vmt")

	local physics = self:GetPhysicsObject()
	physics:EnableMotion(false)
	physics:Wake()

	self:SetDisplay(1)
	self.junkAmount = 0
	self.junk = {}
	self:SetUsed(false)

	ix.saveEnts:SaveEntity(self)
	PLUGIN:SaveTrashCollectors()
end

function ENT:Use(client)
	local button = self:GetNearestButton(client)
	if (button) then
		if self:GetUsed() then return false end

		if button == 1 then
			self:EmitSound("buttons/button6.wav")
			netstream.Start(client, "ixTrashCollectorSelector", self:EntIndex(), self.junkAmount)
		else
			if self.junkAmount <= 0 then self:EmitSound("buttons/button2.wav") return false end
			self:SetUsed(true)
			self:MoveBin()
		end
	end
end

function ENT:OnRemove()
	self:StopSound("ambient/machines/engine1.wav")
	self:StopSound("ambient/levels/canals/manhack_machine_loop1.wav")
end

function ENT:PlaceJunk(model, client)
	self.junkAmount = self.junkAmount + 1
    local junkEnt = ents.Create("prop_dynamic")
    junkEnt:SetPos(self.bin:GetPos() + Vector(0, 0, 15))
    junkEnt:SetAngles(self.bin:GetAngles() + Angle(0, 90, 0))
    junkEnt:SetModel(model)
    junkEnt:Activate()
    junkEnt:SetParent(self.bin)
    junkEnt:Spawn()

	self.bin:DeleteOnRemove(junkEnt)

	self.junk[#self.junk + 1] = junkEnt
	self:EmitSound("physics/cardboard/cardboard_box_impact_hard5.wav")
end

netstream.Hook("ixTrashCollectorPlaceJunk", function(client, itemID, entIndex)
	local item = ix.item.instances[itemID]
	if !item then return end
	local character = client:GetCharacter()
	if !character then return end

	local inventory = character:GetInventory()
	if !inventory then return end

	if !inventory:GetItemByID(itemID) then return end
	local model = item.model or false

	if !Entity(entIndex) then return end
	if !IsValid(Entity(entIndex)) then return end
	if !model then return end

	if Entity(entIndex).junkAmount == 5 then
		client:Notify("This machine is filled with junk!")
		return
	end

	if Entity(entIndex):GetUsed() then
		client:Notify("This machine is ongoing!")
		return false
	end

	item:Remove()
	Entity(entIndex):PlaceJunk(model, client)
end)

function ENT:MoveBin()
	self:SetDisplay(2)
	self:ResetSequence(self:LookupSequence("30sec"))
	self:EmitSound("buttons/lightswitch2.wav")
	local upCount,  maxUpCount = 0, 3.6
	local inCount, maxInCount = 0, 3.4
	local outCount, maxOutCount, minOutCount = -10, 3.3, -10
	local downCount, maxDownCount = 0, 2.6
	local startPos = self.bin:GetPos()
	self:EmitSound("buttons/combine_button5.wav")
	self:EmitSound("ambient/machines/engine1.wav")

	timer.Create("ixTrashCollectorBinMove_"..self:EntIndex(), 0.1, 0, function()
		if IsValid(self.bin) then
			upCount = math.Clamp(upCount + 0.1, 0, maxUpCount)
			if upCount == maxUpCount then
				if inCount == maxInCount then
					if outCount == maxOutCount then
						if downCount == maxDownCount then
							-- Reset
							timer.Remove("ixTrashCollectorBinMove_"..self:EntIndex())
							self.bin:SetPos(startPos)
							self.bin:Respawn()
							self:StopSound("ambient/machines/engine1.wav")
							self:EmitSound("buttons/button3.wav")
							self:ResetSequence(self:LookupSequence("idle"))
							self:SetDisplay(4)
							timer.Simple(1, function()
								self:SetDisplay(1)
								self:SetUsed(false)
							end)

							return
						end

						-- Down
						self.bin:SetPos(self.bin:GetPos() + Vector(0, 0, -(1 + downCount)))
						self.bin:Respawn()

						downCount = math.Clamp(downCount + 0.1, 0, maxDownCount)
						return
					end

					if outCount >= 0 then
						self.bin:SetPos(self.bin:GetPos() + self:GetForward() * -(1 + outCount))
						self.bin:Respawn()
					end

					-- Out

					if outCount == -10 or math.Round(outCount, 1) == -5 or math.Round(outCount, 1) == 0 then
						if outCount == -10 then
							self:StopSound("ambient/machines/engine1.wav")
							self:EmitSound("ambient/levels/canals/manhack_machine_loop1.wav")
							self.spark:SetPos(self.bin:GetPos())

							for key, v in pairs(self.junk) do
								self.junk[key] = nil
								v:Remove()
							end

							self.junkAmount = 0
						end

						self.spark:Fire("SparkOnce")
					end

					if math.Round(outCount, 1) == 0 then
						self:StopSound("ambient/levels/canals/manhack_machine_loop1.wav")
						self:EmitSound("ambient/machines/engine1.wav")
					end

					outCount = math.Clamp(outCount + 0.1, minOutCount, maxOutCount)
					return
				end

				-- In
				self.bin:SetPos(self.bin:GetPos() + self:GetForward() * (1 + inCount))
				self.bin:Respawn()

				inCount = math.Clamp(inCount + 0.1, 0, maxInCount)
				return
			end

			-- Up
			self.bin:SetPos(self.bin:GetPos() + Vector(0, 0, upCount))
			self.bin:Respawn()
		end
	end)
end

ENT.AutomaticFrameAdvance = true -- Must be set on client

function ENT:Think()
	-- Do stuff

	self:NextThink( CurTime() ) -- Set the next think to run as soon as possible, i.e. the next frame.
	return true -- Apply NextThink call
end