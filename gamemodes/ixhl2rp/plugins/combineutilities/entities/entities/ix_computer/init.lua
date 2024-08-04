--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local timer = timer
local IsValid = IsValid

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.

include("shared.lua")

function ENT:SetProperSkin()
    self:SetSkin(0)
end

function ENT:SaveMedicalComputers()
	ix.saveEnts:SaveEntity(self)
end

function ENT:Use(client)
	if (client.CantPlace) then
		client:NotifyLocalized("Musisz poczekać, zanim będziesz mógł tego użyć!")
		return false
	end

	client.CantPlace = true

	timer.Simple(3, function()
		if (client) then
			client.CantPlace = false
		end
	end)

	if (self:GetNWInt("owner") == nil) then
		self:SetNWInt("owner", client:GetCharacter():GetID())
	end

	if (!self.canUse) then
		return
	end

	self:EmitSound( "buttons/button1.wav" )
	self.canUse = false

	if (client:GetCharacter():GetGroup()) then
		self:GetGroupInformation(client, client:GetCharacter(), true)
	else
		netstream.Start(client, "OpenComputer", self, self.users, self.notes, false, self.hasDiskInserted)
	end

	self:SetDisplay(2)

	local uniqueID = "computer_"..self:EntIndex().."_charcheck"
	timer.Create(uniqueID, 10, 0, function()
		if (!IsValid(self)) then
			timer.Remove(uniqueID)
			return
		elseif (!IsValid(client) or !client:GetCharacter()) then
			self.canUse = true
			self:SetDisplay(1)

			timer.Remove(uniqueID)
		end
	end)
end