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
	description = "Invite un joueur a votre groupe.",
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
						client:Notify(target:GetName().." appartient déjà à "..(targetGroup:GetID() != group:GetID() and "other" or "your").." Groupe.")
						target:Notify(client:GetName().." a essayé de vous inviter dans le groupe '"..group:GetName().."'.")

						return
					end

					if (target:IsBot()) then
						group:AddMember(target:GetCharacter())
						group:Sync()

						for k, v in pairs(group:GetOnlineMembers()) do
							v:Notify(target:GetName().." a rejoint le groupe "..group:GetName()..".")
						end
					else
						netstream.Start(target, "ixGroupInvite", group:GetID(), client)
					end

					client:Notify(target:GetName().." a été invité dans votre groupe.")
				else
					client:NotifyLocalized("plyNotValid")
				end
			else
				client:Notify("Vous n'êtes pas autorisé à inviter quelqu'un dans le groupe.")
			end
		else
			client:Notify("Vous n'appartenez à aucun groupe.")
		end
	end
})

ix.command.Add("SetGroupName", {
	description = "Renommer votre groupe.",
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
					client:Notify("Le groupe portant ce nom existe déjà.")
					return
				end
			end

			local oldName = group:GetName()
			group.name = nameTo
			group:Sync()

			group:NotifyAll(client:GetName().." a changé le nom du groupe de "..oldName.." a "..nameTo..".")
		end
	end
})

ix.command.Add("DeleteGroup", {
	description = "Supprimer votre groupe.",
	privilege = "Manage Groups",
	arguments = {
		ix.type.text
	},
	OnRun = function(self, client, name)
		local group = PLUGIN:FindGroup(name)

		if (group) then
			local activeGroup = group.active

			if !activeGroup then
				client:NotifyLocalized("Vous ne pouvez pas supprimer un groupe inactif.")
				return
			end

			group:NotifyAll(client:GetName().." a supprimé votre groupe.")

			for k, v in pairs(group:GetMemberCharacters()) do
				group:KickMember(v)
			end

			PLUGIN:DeleteGroup(group.id)

			client:NotifyLocalized("Groupe "..group:GetName().." supprimé avec succès.")
		else
			client:NotifyLocalized("Ce groupe n'existe pas.")
		end
	end
})

ix.command.Add("SetGroupLead", {
	description = "Changer le chef de votre groupe.",
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

			group:NotifyAll(client:GetName().." a changé le chef du groupe en "..target:GetName()..".")
		end
	end
})

ix.command.Add("AdminJoinGroup", {
	description = "Forcer n'importe quel personnage à rejoindre un certain groupe.",
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
					client:Notify(target:GetName().." appartient déjà à ce groupe.")
					return
				end

				prevGroup:KickMember(targetID)
			end

			group:AddMember(target)
			group:Save(true)
			group:NotifyAll(client:GetName().." a rejoint "..target:GetName().." le groupe.")
		else
			client:NotifyLocalized("Ce groupe n'existe pas.")
		end
	end
})

ix.command.Add("AdminKickGroup", {
	description = "Expulsez n'importe quel personnage du groupe dans lequel il se trouve.",
	privilege = "Manage Groups",
	arguments = {
		ix.type.character
	},
	OnRun = function(self, client, target, name)
		local targetID = target:GetID()
		local group = target:GetGroup()

		if (group) then
			group:KickMember(targetID)

			group:NotifyAll(client:GetName().." a expulser "..target:GetName().." du groupe.")
		else
			client:NotifyLocalized("Ce personnage n'appartient à aucun groupe.")
		end
	end
})
