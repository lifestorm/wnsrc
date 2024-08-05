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

util.AddNetworkString("ixPTSync")
util.AddNetworkString("ixPTCreate")
util.AddNetworkString("ixPTDelete")
util.AddNetworkString("ixPTJoin")
util.AddNetworkString("ixPTLeave")
util.AddNetworkString("ixPTOwner")
util.AddNetworkString("ixPTReassign")

function PLUGIN:CreateTeam(client, index, bNetworked, bNoNotif)
	if (IsValid(client) and client:GetNetVar("ProtectionTeam")) then
		return "@AlreadyHasTeam"
	end

	if (self.teams[index]) then
		return "@TeamAlreadyExists", tostring(index)
	end

	if (index > 99 or index < 1) then
		return "@TeamMustClamp"
	end

	self.teams[index] = {
		owner = client,
		members = {client}
	}

	if (IsValid(client)) then
		client:SetNetVar("ProtectionTeam", index)
		client:SetNetVar("ProtectionTeamOwner", true)
	end

	if (!bNetworked) then
		net.Start("ixPTCreate")
			net.WriteUInt(index, 8)
			net.WriteEntity(client)
		net.Send(self:GetReceivers())
	end

	hook.Run("OnCreateTeam", client, index)

	if (!bNoNotif) then
		ix.combineNotify:AddNotification("NTC:// " .. client:GetCombineTag() .. " has established Protection-Team " .. index, Color(0, 145, 255, 255))
	end

	return "@TeamCreated", tostring(index)
end

function PLUGIN:ReassignTeam(index, newIndex, bNetworked)
	if (newIndex > 99 or newIndex < 1) then
		return "@TeamMustClamp"
	end

	if (self.teams[newIndex]) then
		return "@TeamAlreadyExists", tostring(index)
	end

	local curTeam = self.teams[index]

	self:DeleteTeam(index, true, true)

	self:CreateTeam(curTeam["owner"], newIndex, true, true)

	self.teams[newIndex]["members"] = curTeam["members"]

	for _, client in pairs(curTeam["members"]) do
		client:SetNetVar("ProtectionTeam", newIndex)
	end

	if (!bNetworked) then
		net.Start("ixPTReassign")
			net.WriteUInt(index, 8)
			net.WriteUInt(newIndex, 8)
		net.Send(self:GetReceivers())
	end

	hook.Run("OnReassignTeam", index, newIndex)

	ix.combineNotify:AddNotification("NTC:// Protection-Team " .. index .. " re-assigned as Protection-Team " .. newIndex, Color(0, 145, 255, 255))
	
	return "@TeamReassigned", tostring(index), tostring(newIndex)
end

function PLUGIN:SetTeamOwner(index, client, bNetworked)
	local curOwner = self.teams[index]["owner"]
	
	if (IsValid(curOwner)) then
		curOwner:SetNetVar("ProtectionTeamOwner", nil)
	end
	
	self.teams[index]["owner"] = client
	
	if (IsValid(client)) then
		client:SetNetVar("ProtectionTeamOwner", true)
	end
	
	if (!bNetworked) then
		net.Start("ixPTOwner")
		net.WriteUInt(index, 8)
		net.WriteEntity(client)
		net.Send(self:GetReceivers())
	end
	
	hook.Run("OnSetTeamOwner", client, index)

	if (IsValid(client)) then
		ix.combineNotify:AddNotification("NTC:// " .. client:GetCombineTag() .. " designated as Protection-Team " .. index .. " Leader", Color(0, 145, 255, 255))
		return "@TeamOwnerSet", client:GetName()
	end
end

function PLUGIN:DeleteTeam(index, bNetworked, bNoNotif)
	self.teams[index] = nil
	
	for _, client in pairs(self:GetReceivers()) do
		if (client:GetNetVar("ProtectionTeam") == index) then
			client:SetNetVar("ProtectionTeam", nil)
			
			if (client:GetNetVar("ProtectionTeamOwner")) then
				client:SetNetVar("ProtectionTeamOwner", nil)
			end
		end
	end
	
	if (!bNetworked) then
		net.Start("ixPTDelete")
		net.WriteUInt(index, 8)
		net.Send(self:GetReceivers())
	end

	if (!bNoNotif) then
		ix.combineNotify:AddNotification("NTC:// Protection-Team " .. index .. " has been disbanded", Color(0, 145, 255, 255))
	end
	
	hook.Run("OnDeleteTeam", index)
end

function PLUGIN:JoinTeam(client, index, bNetworked)
	if (client:GetNetVar("ProtectionTeam")) then
		return "@TeamMustLeave"
	end
	
	if (index > 99 or index < 1) then
		return "@TeamMustClamp"
	end

	if (!self.teams[index]) then
		return "@TeamNonExistent", tostring(index)
	end
	
	table.insert(self.teams[index]["members"], client)
	
	client:SetNetVar("ProtectionTeam", index)
	
	if (!bNetworked) then
		net.Start("ixPTJoin")
		net.WriteUInt(index, 8)
		net.WriteEntity(client)
		net.Send(self:GetReceivers())
	end
	
	hook.Run("OnJoinTeam", client, index)

	ix.combineNotify:AddNotification("NTC:// " .. client:GetCombineTag() .. " has interlocked into Protection-Team " .. index, Color(0, 145, 255, 255))
	
	return "@JoinedTeam", index
end

function PLUGIN:LeaveTeam(client, bNetworked)
	if (!client:GetNetVar("ProtectionTeam")) then
		return "@NoCurrentTeam"
	end
	
	local index = client:GetNetVar("ProtectionTeam")
	local curTeam = self.teams[index]
	
	if (curTeam) then
		table.RemoveByValue(self.teams[index]["members"], client)
		
		client:SetNetVar("ProtectionTeam", nil)
		
		if (!bNetworked) then
			net.Start("ixPTLeave")
			net.WriteUInt(index, 8)
			net.WriteEntity(client)
			net.Send(self:GetReceivers())
		end
		
		if (client:GetNetVar("ProtectionTeamOwner")) then
			self:SetTeamOwner(index, nil)
		end

		hook.Run("OnLeaveTeam", client, index)

		ix.combineNotify:AddNotification("NTC:// " .. client:GetCombineTag() .. " has detached from Protection-Team " .. index, Color(0, 145, 255, 255))

		return "@LeftTeam", index
	end
end

function PLUGIN:Tick()
	local curTime = CurTime()

	if (!self.tick or self.tick < curTime) then
		self.tick = curTime + 30

		for index, teamTbl in pairs(self.teams) do
			if (table.IsEmpty(teamTbl["members"])) then
				self:DeleteTeam(index)
			end
		end
	end
end

function PLUGIN:PlayerDisconnected(client)
	if (client:GetNetVar("ProtectionTeam")) then
		self:LeaveTeam(client)
	end
end