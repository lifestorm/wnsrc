--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/willardnetworks/plotter.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow(false)
	self:SetUseType(SIMPLE_USE)
	self:SetDisplay(1)
	self:SetSkin(1)

	local physics = self:GetPhysicsObject()
	physics:EnableMotion(false)
	physics:Wake()

	self.canUse = true
	self.paper = self.paper or 0
	self.ink = self.ink or 0
	self:SetInk(self.ink)
	self:SetPaper(self.paper)
	self.canTouch = true
end

function ENT:CheckCID(client)
	if self.cracked == true then return true end
	local character = client:GetCharacter()
	local inventory = character:GetInventory()

	if self.registeredCID and self.registeredCID != "00000" then
		if self.registeredCID != "00000" then
			for _, v in pairs(inventory:GetItems()) do
				if v.uniqueID == "id_card" then
					if v:GetData("cid") == self.registeredCID then
						return true
					else
						return false
					end
				end
			end
		else
			self:SetDisplay(10)
			return true
		end
	else
		self:SetDisplay(10)
		return true
	end

	self:SetDisplay(13)

	timer.Simple(2, function()
		self.canUse = true
		self:SetDisplay(1)
	end)

	return false
end

function ENT:CheckForPaperInk()
	if (self.paper <= 0 or self.ink <= 0) then
		if (self.paper <= 0 and self.ink <= 0) then
			self:SetDisplay(3)
			self:EmitSound("buttons/button10.wav")
			timer.Simple(2, function()
				self:SetDisplay(1)
				self.canUse = true
			end)

			return false
		end

		if self.paper <= 0 then
			self:SetDisplay(4)
			self:EmitSound("buttons/button10.wav")
		end

		if self.ink <= 0 then
			self:SetDisplay(5)
			self:EmitSound("buttons/button10.wav")
		end

		timer.Simple(2, function()
			self:SetDisplay(1)
			self.canUse = true
		end)

		return false
	end

	return true
end

function ENT:Touch(touchingEnt)
	if self.canTouch then
		if touchingEnt:GetClass() == "ix_item" then
			self.canTouch = false
			local itemID = touchingEnt.ixItemID
			local itemTable = ix.item.instances[itemID]
			if itemTable.uniqueID == "paper" or itemTable.uniqueID == "black_ink" then
				if itemTable.uniqueID == "paper" then
					if self.paper == 50 then
						self:SetDisplay(11)
						self:EmitSound("buttons/button10.wav")
						timer.Simple(1, function()
							self:SetDisplay(1)
							self.canTouch = true
						end)

						return false
					end

					self:EmitSound("buttons/button14.wav")
					self.paper = math.Clamp(self.paper + 1, 0, 50)
					self:SetPaper(self.paper)
					touchingEnt:Remove()
				end

				if itemTable.uniqueID == "black_ink" then
					if self.ink == 50 then
						self:SetDisplay(12)
						self:EmitSound("buttons/button10.wav")
						timer.Simple(1, function()
							self:SetDisplay(1)
							self.canTouch = true
						end)

						return false
					end

					self:EmitSound("buttons/button14.wav")
					self.ink = math.Clamp(self.ink + 1, 0, 50)
					self:SetInk(self.ink)
					touchingEnt:Remove()
				end
			end

			timer.Simple(1, function()
				self.canTouch = true
			end)
		end
	end
end

function ENT:Use(client)
	if self.canUse then
		self:SetDisplay(2)
		self:EmitSound("ambient/materials/metal_stress3.wav")
		self.canUse = false
		timer.Simple(2, function()
			if self:CheckCID(client) then
				timer.Simple(2, function()
					if self:CheckForPaperInk() then
						netstream.Start(client, "ixWritingOpenViewerEditor", self:EntIndex(), "newspaper", nil, {builder = true, cracked = self.cracked})
						self:EmitSound("buttons/button4.wav")
						self:SetDisplay(7)
						self.canUse = false

						local uniqueID = "NewspaperCheckForPlayer"..self:EntIndex()
						timer.Create(uniqueID, 10, 0, function()
							if (!IsValid(self)) then
								timer.Remove(uniqueID)
								return
							end

							if !client or !client:GetCharacter() then
								if IsValid(self) then
									self.canUse = true
									self:SetDisplay(1)

									timer.Remove(uniqueID)
								end
							end
						end)
					end
				end)
			end
		end)
	end
end

function ENT:Close()
	self.canUse = true
	self:SetDisplay(1)
end

function ENT:PrintNewspaper(client, data, writingID)
	local character = client:GetCharacter()

	if !character:HasPermit("writing") and self.cracked != true then
		self:SetDisplay(9)
		client:NotifyLocalized("You don't have a writing permit!")
		self:EmitSound("buttons/button10.wav")

		timer.Simple(2, function()
			self:SetDisplay(1)
			self.canUse = true
		end)
	else
		self:SetDisplay(8)
		self:EmitSound("ambient/machines/combine_terminal_idle3.wav")
		self:SetSkin(0)
		self:ResetSequence( 1 )

		timer.Simple(5, function()
			local entity = ents.Create("ix_shipment")
			entity:Spawn()
			entity:SetPos(client:GetItemDropPos(entity))
			entity:SetItems({["newspaper"] = self.paper})
			entity:SetNetVar("owner", character:GetID())
			entity.itemData = {title = data.bigHeadline or "", writingID = writingID, cracked = self.cracked}

			self:SetSkin(1)
			self:SetDisplay(1)
			self:ResetSequence( 0 )
			self:EmitSound("buttons/button6.wav")

			local shipments = character:GetVar("charEnts") or {}
			table.insert(shipments, entity)
			character:SetVar("charEnts", shipments, true)

			hook.Run("CreateShipment", client, entity)

			self.ink = math.Round(math.Clamp(self.ink - (self.paper / 5), 0, 50)) -- 1 ink makes 5 newspapers.
			self.paper = 0
			self:SetInk(self.ink)
			self:SetPaper(self.paper)
			self.canUse = true

			if data.unionDatabase then
				local queryObj = mysql:Insert("ix_unionnewspapers")
				local newData = {bigHeadline = data.bigHeadline, subHeadline = data.subHeadline, unionDatabase = writingID}
				queryObj:Insert("unionnewspaper_data", util.TableToJSON(newData))
				queryObj:Execute()
			end
		end)
	end
end

ENT.AutomaticFrameAdvance = true -- Must be set on client