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

ix.command.Add("GroupInvite", {
	description = "Invite a player you are looking at to join your group.",
	arguments = ix.type.text,
	OnRun = function(self, client, message)
		local character = client:GetCharacter()
		local group = character:GetGroup()

		if (group) then
			local role = group:GetRoleID(character:GetID())

			if (role == GROUP_LEAD or role == GROUP_MOD) then
				local data = {}
					data.start = client:GetShootPos()
					data.endpos = data.start + client:GetAimVector() * 96
					data.filter = client
				local target = util.TraceLine(data).Entity

				if (IsValid(target) and target:IsPlayer()) then
					local targetGroup = target:GetCharacter():GetGroup()
					if (targetGroup) then
						client:Notify(target:GetName().." already belongs to "..(targetGroup:GetID() != group:GetID() and "other" or "your").." group.")
						target:Notify(client:GetName().." has tried to invite you to the group '"..group:GetName().."'.")

						return
					end

					if (target:IsBot()) then
						group:AddMember(target:GetCharacter())
						group:Sync()

						for k, v in pairs(group:GetOnlineMembers()) do
							v:Notify(target:GetName().." has joined the group "..group:GetName()..".")
						end
					else
						netstream.Start(target, "ixGroupInvite", group:GetID(), client)
					end

					client:Notify(target:GetName().." was invited to your group.")
				else
					client:NotifyLocalized("plyNotValid")
				end
			else
				client:Notify("You do not have permission to invite someone to the group.")
			end
		else
			client:Notify("You do not belong to any group.")
		end
	end
})

ix.command.Add("SetGroupName", {
	description = "Rename existing group name.",
	privilege = "Manage Groups",
	arguments = {
		ix.type.string,
		ix.type.text
	},
	OnRun = function(self, client, name, nameTo)
		local group = PLUGIN:FindGroup(name)

		if (group) then
			for k, v in pairs(PLUGIN.stored) do
				if (string.utf8lower(v.name) == string.utf8lower(nameTo) and v:GetID() != group:GetID()) then
					client:Notify("Group with this name already exists.")
					return
				end
			end

			local oldName = group:GetName()
			group.name = nameTo
			group:Sync()

			group:NotifyAll(client:GetName().." has changed the group name from "..oldName.." to "..nameTo..".")
		end
	end
})

ix.command.Add("DeleteGroup", {
	description = "Delete existing group.",
	privilege = "Manage Groups",
	arguments = {
		ix.type.text
	},
	OnRun = function(self, client, name)
		local group = PLUGIN:FindGroup(name)

		if (group) then
			local activeGroup = group.active

			if !activeGroup then
				client:NotifyLocalized("You cannot remove a inactive group.")
				return
			end

			group:NotifyAll(client:GetName().." has deleted your group.")

			for k, v in pairs(group:GetMemberCharacters()) do
				group:KickMember(v)
			end

			PLUGIN:DeleteGroup(group.id)

			client:NotifyLocalized("Group "..group:GetName().." successfully deleted.")
		else
			client:NotifyLocalized("This group does not exist.")
		end
	end
})

ix.command.Add("SetGroupLead", {
	description = "Set new group lead.",
	privilege = "Manage Groups",
	arguments = {
		ix.type.string,
		ix.type.character
	},
	OnRun = function(self, client, name, target)
		local group = PLUGIN:FindGroup(name)

		if (group) then
			local members = group:GetMemberCharacters()

			for k, v in pairs(members) do
				if (group:GetRoleID(v) == GROUP_LEAD) then
					group:SetRole(v, GROUP_MOD)
					break
				end
			end

			local targetID = target:GetID()

			if (members[targetID]) then
				group:SetRole(targetID, GROUP_LEAD)
			else
				group:AddMember(target, GROUP_LEAD)
			end

			group:NotifyAll(client:GetName().." has changed the group lead to "..target:GetName()..".")
		end
	end
})

ix.command.Add("AdminJoinGroup", {
	description = "Force any character to join certain group.",
	privilege = "Manage Groups",
	arguments = {
		ix.type.character,
		ix.type.string
	},
	OnRun = function(self, client, target, name)
		local group = PLUGIN:FindGroup(name)

		if (group) then
			local targetID = target:GetID()
			local prevGroup = target:GetGroup()

			if (prevGroup) then
				if (group:GetID() == prevGroup:GetID()) then
					client:Notify(target:GetName().." already belongs to this group.")
					return
				end

				prevGroup:KickMember(targetID)
			end

			group:AddMember(target)
			group:Save(true)
			group:NotifyAll(client:GetName().." has joined "..target:GetName().." to the group.")
		else
			client:NotifyLocalized("This group does not exist.")
		end
	end
})

ix.command.Add("AdminKickGroup", {
	description = "Kick any character from the group they're in.",
	privilege = "Manage Groups",
	arguments = {
		ix.type.character
	},
	OnRun = function(self, client, target, name)
		local targetID = target:GetID()
		local group = target:GetGroup()

		if (group) then
			group:KickMember(targetID)

			group:NotifyAll(client:GetName().." has kicked "..target:GetName().." from the group.")
		else
			client:NotifyLocalized("This character doesn't belong to any group.")
		end
	end
})
