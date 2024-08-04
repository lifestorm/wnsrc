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

function PLUGIN:UpdateTeamMenu()
	if (IsValid(ix.gui.protectionTeams)) then
		ix.gui.protectionTeams.memberScroll:Clear()
		ix.gui.protectionTeams.teamScroll:Clear()

		if ix.gui.protectionTeams.leaveButton then
			ix.gui.protectionTeams.leaveButton:Remove()
		end

		if ix.gui.protectionTeams.createButton then
			ix.gui.protectionTeams.createButton:Remove()
		end

		if ix.gui.protectionTeams.joinButton then
			ix.gui.protectionTeams.joinButton:Remove()
		end

		ix.gui.protectionTeams.CreateButtons()
	end
end

function PLUGIN:CreateTeam(client, index)
	self.teams[index] = {
		owner = client,
		members = {client}
	}

	hook.Run("OnCreateTeam", client, index)
end

function PLUGIN:ReassignTeam(index, newIndex)
	local curTeam = self.teams[index]

	self:DeleteTeam(index)
	self:CreateTeam(curTeam["owner"], newIndex)
	self.teams[newIndex]["members"] = curTeam["members"]

	hook.Run("OnReassignTeam", index, newIndex)
end

function PLUGIN:DeleteTeam(index)
	self.teams[index] = nil
	hook.Run("OnDeleteTeam", index)
end

function PLUGIN:LeaveTeam(client, index)
	if table.HasValue(self.teams[index]["members"], client) then
		table.RemoveByValue(self.teams[index]["members"], client)
	end

	hook.Run("OnLeaveTeam", client, index)
end

function PLUGIN:JoinTeam(client, index)
	if !index or index and !self.teams[index] then return end
	if !self.teams[index]["members"] then return end
	
	table.insert(self.teams[index]["members"], client)

	hook.Run("OnJoinTeam", client, index)
end

function PLUGIN:SetTeamOwner(index, client)
	if !self.teams[index] then return end

	self.teams[index]["owner"] = client

	hook.Run("OnSetTeamOwner", client, index)
end

-- Hooks
function PLUGIN:OnCreateTeam(client, index)
	self:UpdateTeamMenu()
end

function PLUGIN:OnReassignTeam(index, newIndex)
	self:UpdateTeamMenu()
end

function PLUGIN:OnDeleteTeam(index)
	self:UpdateTeamMenu()
end

function PLUGIN:OnLeaveTeam(client, index)
	self:UpdateTeamMenu()
end

function PLUGIN:OnJoinTeam(client, index)
	self:UpdateTeamMenu()
end

function PLUGIN:OnSetTeamOwner(client, index)
	self:UpdateTeamMenu()
end

function PLUGIN:PopulateCharacterInfo(client, character, container)
	if (LocalPlayer():HasActiveCombineMask() and client:GetNetVar("ProtectionTeam")) then
		local curTeam = container:AddRowAfter("name", "curTeam")
		curTeam:SetText(L("TeamStatus", client:GetNetVar("ProtectionTeam"), client:GetNetVar("ProtectionTeamOwner") and L("TeamOwnerStatus") or L("TeamMemberStatus")))
		curTeam:SetBackgroundColor(client:GetNetVar("ProtectionTeamOwner") and Color(50,150,100) or Color(50,100,150))
	end
end

net.Receive("ixPTSync", function()
	local bTeams = net.ReadBool()

	if (!bTeams) then
		PLUGIN.teams = {}
		return
	end

	local teams = net.ReadTable()
	PLUGIN.teams = teams or {}
end)

net.Receive("ixPTCreate", function()
	local index = net.ReadUInt(8)
	local client = net.ReadEntity()

	PLUGIN:CreateTeam(client, index)
end)

net.Receive("ixPTDelete", function()
	local index = net.ReadUInt(8)

	PLUGIN:DeleteTeam(index)
end)

net.Receive("ixPTLeave", function()
	local index = net.ReadUInt(8)
	local client = net.ReadEntity()

	PLUGIN:LeaveTeam(client, index)
end)

net.Receive("ixPTJoin", function()
	local index = net.ReadUInt(8)
	local client = net.ReadEntity()

	PLUGIN:JoinTeam(client, index)
end)

net.Receive("ixPTOwner", function()
	local index = net.ReadUInt(8)
	local client = net.ReadEntity()

	PLUGIN:SetTeamOwner(index, client)
end)

net.Receive("ixPTReassign", function()
	local index = net.ReadUInt(8)
	local newIndex = net.ReadUInt(8)

	PLUGIN:ReassignTeam(index, newIndex)
end)