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

ix.util.IncludeDir("ixhl2rp/plugins/combineutilities/teams/derma", true)

PLUGIN.teams = {}

function PLUGIN:GetReceivers()
	local recievers = {}

	for _, client in pairs(player.GetAll()) do
		if (client:IsCombine()) then
			table.insert(recievers, client)
		end
	end

	return recievers
end

ix.command.Add("PTCreate", {
	description = "@cmdPTCreate",
	arguments = bit.bor(ix.type.number, ix.type.optional),
	OnCheckAccess = function(self, client)
		return client:IsCombine()
	end,
	OnRun = function(self, client, index)
		if (!client:IsCombine()) then
			return "@CannotUseTeamCommands"
		end

		if (!index) then
			return client:RequestString("@cmdPTCreate", "@cmdCreatePTDesc", function(text) ix.command.Run(client, "PTCreate", {text}) end, "")
		end

		return PLUGIN:CreateTeam(client, index)
	end
})

ix.command.Add("PTJoin", {
	description = "@cmdPTJoin",
	arguments = ix.type.number,
	OnCheckAccess = function(self, client)
		return client:IsCombine()
	end,
	OnRun = function(self, client, index)
		if (!client:IsCombine()) then
			return "@CannotUsePTCommands"
		end

		return PLUGIN:JoinTeam(client, index)
	end
})

ix.command.Add("PTLeave", {
	description = "@cmdPTLeave",
	OnCheckAccess = function(self, client)
		return client:IsCombine()
	end,
	OnRun = function(self, client)
		if (!client:IsCombine()) then
			return "@CannotUsePTCommands"
		end

		return PLUGIN:LeaveTeam(client)
	end
})

ix.command.Add("PTLead", {
	description = "@cmdPTLead",
	arguments = bit.bor(ix.type.player, ix.type.optional),
	OnCheckAccess = function(self, client)
		return client:IsCombine()
	end,
	OnRun = function(self, client, target)
		if (!client:IsCombine()) then
			return "@CannotUseTeamCommands"
		end

		if (target == client or !target) then
			target = client
		end

		local index = target:GetNetVar("ProtectionTeam")

		if (!PLUGIN.teams[index]) then return "@TargetNoCurrentTeam" end

		if (!client:IsDispatch()) then
			if (client:GetNetVar("ProtectionTeam") != target:GetNetVar("ProtectionTeam")) then return "@TargetNotSameTeam" end

			if (PLUGIN.teams[index]["owner"]) then
				if (target == client) then return "@TeamAlreadyHasOwner" end
				if (!client:GetNetVar("ProtectionTeamOwner")) then return "@CannotPromoteTeamMembers" end
			end
		end

		if ((target == client or !target) and (PLUGIN:SetTeamOwner(index, target))) then
			return "@TeamOwnerAssume"
		end

		return PLUGIN:SetTeamOwner(index, target)
	end
})

ix.command.Add("PTKick", {
	description = "@cmdPTKick",
	arguments = ix.type.player,
	OnCheckAccess = function(self, client)
		return client:IsCombine()
	end,
	OnRun = function(self, client, target)
		if (!client:IsCombine()) then
			return "@CannotUseTeamCommands"
		end

		local index = target:GetNetVar("ProtectionTeam")

		if (!PLUGIN.teams[index]) then return "@TargetNoCurrentTeam" end

		if (client:GetNetVar("ProtectionTeam") != target:GetNetVar("ProtectionTeam") and !client:IsDispatch()) then return "@TargetNotSameTeam" end

		if (!client:GetNetVar("ProtectionTeamOwner") and !client:IsDispatch()) then return "@CannotKickTeamMembers" end

		PLUGIN:LeaveTeam(target)

		return "@KickedFromTeam", target:GetName()
	end
})

ix.command.Add("PTReassign", {
	description = "@cmdPTReassign",
	arguments = {bit.bor(ix.type.number, ix.type.optional), bit.bor(ix.type.number, ix.type.optional)},
	OnCheckAccess = function(self, client)
		return client:IsCombine()
	end,
	OnRun = function(self, client, newIndex, oldIndex)
		if (!client:IsCombine()) then
			return "@CannotUseTeamCommands"
		end

		local index = client:GetNetVar("ProtectionTeam")

		if (!oldIndex and index) then
			oldIndex = index
		end

		if (!client:IsDispatch()) then
			if (!PLUGIN.teams[oldIndex]) then return "@NoCurrentTeam" end
			if (!client:GetNetVar("ProtectionTeamOwner")) then return "@CannotReassignTeamIndex" end
		end

		if (newIndex and oldIndex) then
			return PLUGIN:ReassignTeam(oldIndex, newIndex)
		else
			return client:RequestString("@cmdPTReassign", "@cmdReassignPTDesc", function(text) ix.command.Run(client, "PTReassign", {text, oldIndex}) end, "")
		end
	end
})
