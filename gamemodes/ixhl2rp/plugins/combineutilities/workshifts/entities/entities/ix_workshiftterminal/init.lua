--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include('shared.lua')

local PLUGIN = PLUGIN

function ENT:OnInitialize()
	self:SetDisplay(9)
end

function ENT:SaveTerminalLocations()
	ix.saveEnts:SaveEntity(self)
end

function ENT:SetGroups(bUse)
end

function ENT:CheckStartedWorkshift()
	if !PLUGIN:CheckStartedWorkshift(self) then
		self:SetDisplay(9)
		self:EmitSound("buttons/button8.wav")
		self:ResetInfo()

		return false
	end

	return true
end

function ENT:StopWorkshift(client)
	if !self.workshiftStarted then
		self:ResetInfo()
		self:EmitSound("buttons/button8.wav")
		return
	end

	PLUGIN:StopWorkshift(self, client)
end

function ENT:StartWorkshift(client)
	if self.workshiftStarted then
		self:ResetInfo()
		self:EmitSound("buttons/button8.wav")
		return
	end

	self:SetDisplay(3)
	timer.Simple(1, function()
		if IsValid(self) then
			self:SetDisplay(1)
		end
	end)

	self.workshiftStarted = true
	self:ResetInfo()
end

function ENT:ResetInfo()
	self.canUse = true
	self.activePlayer = nil
	self.activeCharacter = nil
end

function ENT:OnUse(client)
	local button = self:GetNearestButton(client)

	if (button) then
		self:EmitSound("buttons/lightswitch2.wav")

		if !self:CheckStartedWorkshift() then
			self:EmitSound("buttons/button8.wav")
			self:ResetInfo()
			return false
		end

		self:CheckForCID(client)
	else
		client:NotifyLocalized("Musisz użyć jednego z przycisków!")
		self:ResetInfo()
	end
end

function ENT:ReadyForAnother()
	timer.Simple(1, function()
		if IsValid(self) then
			self:SetDisplay(1)
			self:ResetInfo()
		end
	end)
end

function ENT:OnSuccess(idCard, genericData, client)
	self:SetDisplay(6)
	self:EmitSound("buttons/button14.wav")
	self:ReadyForAnother()

	if (client:IsVortigaunt()) then
		ix.combineNotify:AddNotification("LOG:// Podmiot " .. string.upper("o identyfikatorze biotycznego zasobu: #") .. genericData.cid .. " dołączył do Cyklu pracy")
	else
		ix.combineNotify:AddNotification("LOG:// Podmiot '" .. genericData.name .. "' dołączył do Cyklu pracy", nil, client)
	end

	PLUGIN:AddToWorkshift(client, idCard, genericData, self)
end

function ENT:AlreadyParticipated()
	self:SetDisplay(10)
	self:EmitSound("buttons/button8.wav")
	self:ReadyForAnother()
end