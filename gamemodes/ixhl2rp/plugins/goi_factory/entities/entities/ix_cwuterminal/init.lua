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

ENT.localizedCIDTransform = {
	vec = Vector(4.281931, -13.669882, 44.2),
	ang = Angle(31, -178.43, 180)
}

ENT.localizedCWUCardTransform = {
	vec = Vector(11.407880, -13.500206, 33.918171),
	ang = Angle(-0.828, 0.935, 0.204)
}

function ENT:CreateUserTimer()
	timer.Create("ixCWUTerminal" .. self:GetCreationID(), 5, 0, function()
		if !IsValid(self) then return end

		local user = self:GetUsedBy()
		if user == self then
			if self:GetNetVar("broadcasting", false) then
				self:ToggleBroadcast()
			end
			return timer.Remove("ixCWUTerminal" .. self:GetCreationID()) 
		end

		if (!IsValid(user) or !user:IsPlayer() or user:EyePos():DistToSqr(self:GetPos()) > 62500 or user:IsAFK()) then
			if self:GetNetVar("broadcasting", false) then
				self:ToggleBroadcast()
			end

			if (IsValid(user)) then
				if user:GetNetVar("broadcastAuth", false) then
					user:SetNetVar("broadcastAuth", nil)
				end
			end

			self:SetUsedBy(self)

			net.Start("ix.terminal.turnOff")
				net.WriteEntity(self)
			net.Broadcast()

			timer.Remove("ixCWUTerminal" .. self:GetCreationID())
		end
	end)
end

function ENT:ToggleBroadcast()
	local user = self:GetUsedBy()
	local broadcast = !self:GetNetVar("broadcasting", false)
	self:SetNetVar("broadcasting", broadcast)

	net.Start("ix.terminal.CWUWorkshiftSound")
	net.Broadcast()

	self.nextBroadcast = CurTime() + 5
	if user and user:IsPlayer() then
		ix.chat.Send(user, "event", broadcast and "The city's speakers come to life with the signature announcement sound." or "The city's speakers turn off after playing the final distinct announcement sound.", false, nil)
	end
end

function ENT:Initialize()
	self:SetModel("models/willardnetworks/gearsofindustry/wn_machinery_04.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetCID(-1)
	self:SetCWUCard(-1)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:SendCharGenData(id)
	-- insert gendata later
	local genData
	local isCCA = false
	if ix.char.loaded[id] then
		genData = ix.char.loaded[id]:GetGenericdata()
		isCCA = ix.char.loaded[id]:GetFaction() == FACTION_ADMIN
		self:ConfirmCID(genData, isCCA)
	else
		local charQuery = mysql:Select("ix_characters")
		charQuery:Where("id", tostring(charID))
		charQuery:Callback(function(cResult)
			if (!istable(cResult) or #cResult == 0) then
				return
			end
			isCCA = ix.faction.GetIndex(cResult[1].faction) == FACTION_ADMIN

			local query = mysql:Select("ix_characters_data")
			query:Where("key", "genericdata")
			query:Where("id", tostring(charID))
			query:Select("data")
			query:Callback(function(result)
				if (!istable(result) or #result == 0) then
					return
				end

				genData = util.JSONToTable(result[1]["data"])
				self:ConfirmCID(genData, isCCA)
			end)
			query:Execute()
		end)
		charQuery:Execute()
	end
end

function ENT:ConfirmCID(genData, isCCA)
	self.curGenData = genData
	self.curGenData.isCCA = isCCA
	local client = self:GetUsedBy()
	if client and client:IsPlayer() then
		net.Start("ix.terminal.SendCIDInfo")
			net.WriteString(util.TableToJSON(genData))
			net.WriteEntity(self)
		net.Send(client)
	end
end

function ENT:IsFullyAuthed()
	if (self:HasCID()) then
		if self.curGenData and self.curGenData.combine or self.curGenData and self.curGenData.isCCA then
			return true
		end
	end

	if (!self:HasCWUCard() or !self:HasCID()) then
		return false
	end

	if ix.item.instances[self:GetCWUCard()]:GetData("cardID") != self:GetCID() then
		return false
	end

	return true
end

function ENT:HasCID()
	return self:GetCID() != -1
end

function ENT:OnCIDInsert()
	local cid
	local client = self:GetUsedBy()

	if self:HasCWUCard() then
		if !self:IsFullyAuthed() then
			ix.combineNotify:AddImportantNotification("WRN:// Unauthorized access to CWU terminal", nil, "unknown", self:GetPos())

			if (client and client:IsPlayer()) then
				net.Start("ix.terminal.AuthError")
					net.WriteEntity(self)
				net.Send(client)
			end

			return
		else
			cid = ix.item.instances[self:GetCID()]
			self:SendCharGenData(cid:GetData("owner"))
		end
	else
		cid = ix.item.instances[self:GetCID()]
		self:SendCharGenData(cid:GetData("owner"))
	end
end

function ENT:OnCIDDetach()
	self.curGenData = nil

	local client = self:GetUsedBy()
	if (client and client:IsPlayer()) then
		net.Start("ix.terminal.SendCIDRemoved")
			net.WriteEntity(self)
		net.Send(client)
	end
end

function ENT:HasCWUCard()
	return self:GetCWUCard() != -1
end

function ENT:OnCWUCardInsert()
	local client = self:GetUsedBy()

	if self:HasCID() then
		if !self:IsFullyAuthed() then
			ix.combineNotify:AddImportantNotification("WRN:// Unauthorized access to CWU terminal", nil, "unknown", self:GetPos())

			if (client and client:IsPlayer()) then
				net.Start("ix.terminal.AuthError")
					net.WriteEntity(self)
				net.Send(client)
			end

			return
		else
			if (client and client:IsPlayer()) then
				net.Start("ix.terminal.CWUCardInserted")
					net.WriteEntity(self)
				net.Send(client)
			end
		end
	else
		if (client and client:IsPlayer()) then
			net.Start("ix.terminal.CWUCardInserted")
				net.WriteEntity(self)
			net.Send(client)
		end
	end
end

function ENT:OnCWUCardDetach()
	local client = self:GetUsedBy()
	if (client and client:IsPlayer()) then
		net.Start("ix.terminal.CWUCardRemoved")
			net.WriteEntity(self)
		net.Send(client)
	end
end

function ENT:StartTouch(entity)
	if (entity:GetClass() != "ix_item" or entity.attached) then return end
	if (entity:GetItemID() != "id_card" and entity:GetItemID() != "cwu_card") then return end
	if (self.attachedCID and self.attachedCID != NULL and self.attachedCWUCard and self.attachedCWUCard != NULL) then return end

	local physObj = entity:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	if entity:GetItemID() == "id_card" then
		self:CIDInsert(entity)
	elseif entity:GetItemID() == "cwu_card" then
		self:CWUInsert(entity)
	end

	self:EmitSound("physics/metal/weapon_impact_soft" .. math.random(1, 3) .. ".wav")
end

function ENT:OnRemove()
	timer.Remove("ixCWUTerminal" .. self:GetCreationID())
end