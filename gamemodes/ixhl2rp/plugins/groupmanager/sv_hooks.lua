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

PLUGIN.cache = PLUGIN.cache or {}
local cache = PLUGIN.cache

function PLUGIN:DatabaseConnected()
	local query = mysql:Create("ix_groups")
		query:Create("id", "INT UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("name", "VARCHAR(50) NOT NULL")
		query:Create("active", "TINYINT(1) NOT NULL")
		query:Create("hidden", "TINYINT(1) NOT NULL")
		query:Create("color_r", "TINYINT UNSIGNED NOT NULL")
		query:Create("color_g", "TINYINT UNSIGNED NOT NULL")
		query:Create("color_b", "TINYINT UNSIGNED NOT NULL")
		query:Create("color_a", "TINYINT UNSIGNED NOT NULL")
		query:Create("roles", "TEXT NOT NULL")
		query:Create("members", "TEXT NOT NULL")
		query:Create("info", "TEXT NOT NULL")
		query:Create("lore", "TEXT NOT NULL")
		query:Create("forum", "TEXT NOT NULL")
		query:Callback(function()
			local load = mysql:Select("ix_groups")
				load:Callback(function(result)
					if (!result) then return end
					for _, v in ipairs(result) do
						local group = table.Copy(ix.meta.group)
						group:FromDB(v)
					end
				end)
			load:Execute()
		end)
		query:PrimaryKey("id")
	query:Execute()
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_grouplock", true, true, true, {
		OnSave = function(entity, data) --OnSave
			data.pos = entity.door:GetPos()
			data.angles = nil
			data.door = entity.door:MapCreationID()
			data.localPos = entity.door:WorldToLocal(entity:GetPos())
			data.localAngs = entity.door:WorldToLocalAngles(entity:GetAngles())
			data.locked = entity:GetLocked()
			data.group = entity:GetGroupID()
		end,
		OnRestore = function(entity, data) --OnRestore
			local door = ents.GetMapCreatedEntity(data.door)
			entity:SetDoor(door, door:LocalToWorld(data.localPos), door:LocalToWorldAngles(data.localAngs))
			entity:SetLocked(data.locked)
			entity:SetGroupID(data.group)
		end,
		ShouldSave = function(entity) --ShouldSave
			return IsValid(entity.door) and entity:GetGroupID() != 0
		end,
		ShouldRestore = function(data) --ShouldRestore
			local door = ents.GetMapCreatedEntity(data.door)
            return IsValid(door) and door:IsDoor()
		end
	})
end

gameevent.Listen( "player_activate" )
hook.Add( "player_activate", "player_activate_example", function( data ) 
	local id = data.userid		
	local client = Player(id)

	local plugin = ix.plugin.Get("groupmanager")

	plugin:SyncAllGroups(client)

end )

function PLUGIN:CharacterLoaded(character)
	if (!table.IsEmpty(self.stored)) then
		for k, v in pairs(self.stored) do
			if (v:GetID() == k) then
				local client = character:GetPlayer()
				v:Sync(client)
			end
		end
	end
end

function PLUGIN:DeleteGroup(groupID)
	local group = self:FindGroup(groupID)

	if (group) then
		for _, v in pairs(group:GetMemberCharacters()) do
			group:KickMember(v)
		end

		self.stored[groupID] = nil

		local query = mysql:Delete("ix_groups")
			query:Where("id", group.id)
		query:Execute()

		self:SyncAllGroups()

		local messageQuery = mysql:Delete("ix_comgroupmessages")
		messageQuery:Where("message_groupid", groupID)
		messageQuery:Callback(function(result)
			local replyQuery = mysql:Delete("ix_comgroupreplies")
			replyQuery:Where("reply_groupid", groupID)
			replyQuery:Execute()
		end)

		messageQuery:Execute()
	end
end

function PLUGIN:SyncAllGroups(client)
	if (!table.IsEmpty(self.stored)) then
		for k, v in pairs(self.stored) do
			if (v:GetID() == k) then
				v:SyncThird(client)
			end
		end
	end
end

function PLUGIN:OnCharacterBanned(character, time)
	local group = character:GetGroup()

	if (group and ix.config.Get("permakill") and character and character:GetData("permakilled")) then
		group:KickMember(character:GetID())
		group:Save()
	end
end

netstream.Hook("ixGroupCreate", function(client, name)
	if (!client:GetCharacter()) then return end
	if (client:GetCharacter():GetGroup()) then return end

	for _, v in pairs(PLUGIN.stored) do
		if (string.utf8lower(v.name) == string.utf8lower(name)) then
			client:Notify("Group with this name already exists.")
			return
		end
	end

	local group = table.Copy(ix.meta.group)
	group.name = name

	group:CreateDB(client:GetCharacter())
end)

netstream.Hook("ixGroupLeave", function(client)
	local character = client:GetCharacter()
	local group = character:GetGroup()

	if (group) then
		local charID = character:GetID()

		if (group:GetRoleID(charID) == GROUP_LEAD and group.active) then
			client:Notify("You can not leave the group, being its leader.")
			return
		end

		group:KickMember(charID)
		group:Save(true)

		client:Notify("You left the group "..group:GetName()..".")

		group:NotifyAll(client:GetName().." has left the group"..group:GetName()..".")
	end
end)

netstream.Hook("ixGroupInvite", function(client, groupID)
	local group = PLUGIN:FindGroup(groupID)
	local character = client:GetCharacter()

	if (character:GetGroup()) then
		client:Notify("You cannot join another group.")
		return
	end

	if (group) then
		group:AddMember(character)
		group:Save(true)

		client:Notify("You have joined the group "..group:GetName()..".")

		group:NotifyAll(client:GetName().." has joined the group "..group:GetName()..".")
	end
end)

netstream.Hook("ixGroupEditInfo", function(client, groupID, text)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD and role != GROUP_MOD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		group.info = text
		group:Save(true)

		group:NotifyAll(client:GetName().." updated the group info.")
	end
end)

netstream.Hook("ixGroupEditLore", function(client, groupID, text)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD and role != GROUP_MOD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		group.lore = text
		group:Save(true)

		group:NotifyAll(client:GetName().." updated the group lore.")
	end
end)

netstream.Hook("ixGroupEditForum", function(client, groupID, text)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		group.forum = text
		group:Save(true)

		group:NotifyAll(client:GetName().." updated the group forum link.")
	end
end)

netstream.Hook("ixGroupEditName", function(client, groupID, text)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		for _, v in pairs(PLUGIN.stored) do
			if (string.utf8lower(v.name) == string.utf8lower(text) and v:GetID() != group:GetID()) then
				client:Notify("Group with this name already exists.")
				return
			end
		end

		local oldName = group:GetName()
		group.name = text
		group:Save(true)

		group:NotifyAll(client:GetName().." has changed the group name from "..oldName.." to "..text..".")
	end
end)

netstream.Hook("ixGroupEditColor", function(client, groupID, color)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		group.color = color
		group:Save(true)

		group:NotifyAll(client:GetName().." has changed the group tab color.")
	end
end)

netstream.Hook("ixGroupRequestMembers", function(client, groupID)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local query = mysql:Select("ix_characters")
		query:Select("id")
		query:Select("name")
		query:Select("description")
		query:Select("steamid")
		query:Select("last_join_time")
		query:Where("group", group:GetID())
		query:Where("schema", Schema and Schema.folder or "helix")
		query:Callback(function(result)
			if (istable(result) and #result > 0) then
				local members = {}
				for _, v in ipairs(result) do
						local id = tonumber(v.id)
						members[id] = v
						members[id].online = ix.char.loaded[id] and IsValid(ix.char.loaded[id]:GetPlayer())
						members[id].role = group.roles[group.members[id]]
				end

				for _, v in ipairs(player.GetAll()) do
					if (v:IsBot() and v:GetCharacter() and v:GetCharacter():GetGroupID() == group:GetID()) then
						members[v:GetCharacter():GetID()] = {
							id = v:GetCharacter():GetID(),
							name = v:Name(),
							description = "This is a bot.",
							steamid = v:SteamID(),
							last_join_time = os.time(),
							online = true,
							role = group.roles[group.members[v:GetCharacter():GetID()]]
						}
					end
				end

				netstream.Start(client, "ixGroupSendMembers", members)
			end
		end)
		query:Execute()
	end
end)

netstream.Hook("ixGroupKick", function(client, groupID, charID)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local character = ix.char.loaded[charID]
		local clientRole = group:GetRole(client:GetCharacter():GetID())
		local targetRole = group:GetRole(charID)

		if (targetRole) then
			if (targetRole.id > clientRole.id) then
				group:KickMember(charID)
				group:Save(true)

				if (character) then
					if (character:GetPlayer():GetCharacter():GetID() == character:GetID()) then
						character:GetPlayer():Notify("You have been kicked from the group "..group:GetName()..".")
					end

					group:NotifyAll(client:GetName().." has kicked "..character:GetName()..".")
				end
			else
				client:Notify("You cannot kick this member.")
			end
		else
			client:Notify("Member not found.")
		end
	end
end)

netstream.Hook("ixGroupSetRole", function(client, groupID, charID, newRole)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local character = ix.char.loaded[charID]
		local clientRole = group:GetRole(client:GetCharacter():GetID())
		local roleData = group:GetRoleData(newRole)

		if (roleData) then
			if (newRole < clientRole.id or clientRole.id == GROUP_LEAD) then
				if (newRole == GROUP_LEAD) then
					group:SetRole(client:GetCharacter():GetID(), GROUP_MOD)
				end

				group:SetRole(charID, newRole)
				group:Save(true)

				local charName = false
				if (!character and cache[charID]) then
					charName = cache[charID].name
					if (istable(cache[charID].role) and !table.IsEmpty(cache[charID].role)) then
						cache[charID].role = roleData
					end
				end

				if (character or charName) then
					local textName = character and character.name or charName
					if (textName) then
						group:NotifyAll(client:GetName().." has set "..textName.."'s role to "..roleData.name..".")
					end
				end
			else
				client:Notify("You cannot set this role.")
			end
		else
			client:Notify("Role not found.")
		end
	end
end)

netstream.Hook("ixGroupEditRoleName", function(client, groupID, roleID, text)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD and role != GROUP_MOD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		local roleData = group:GetRoleData(roleID)

		if (roleData) then
			local oldName = roleData.name
			group.roles[roleData.id].name = text

			group:Save(true)

			group:NotifyAll(client:GetName().." has renamed the role "..oldName.." to "..text..".")
		else
			client:Notify("Role not found.")
		end
	end
end)

netstream.Hook("ixGroupDeleteRole", function(client, groupID, roleID)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD and role != GROUP_MOD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		local roleData = group:GetRoleData(roleID)
		local memberRole = group:GetRole(GROUP_MEMBER)

		if (roleData) then
			if (roleData.id == GROUP_LEAD or roleData.id == GROUP_MOD) then
				client:Notify("This group cannot be deleted.")
				return
			end

			for _, v in pairs(group:GetMemberCharacters()) do
				if (group:GetRoleID(v) == roleID) then
					group:SetRole(v, GROUP_MEMBER)

					local character = ix.char.loaded[v]

					if (character and character:GetPlayer():GetCharacter():GetID() == v) then
						character:GetPlayer():Notify("Your role was deleted and you have been demoted to "..memberRole.name..".")
					end
				end
			end

			-- table.remove doesn't know how to shift values when there's a 999 (member) value in the end so here goes
			for key, roleTable in pairs(group.roles, true) do
				if key == roleID then
					group.roles[key] = nil
				end

				if ( key > roleID ) and key != 999 and key != roleID then
					local newKey = key - 1
					group.roles[newKey] = roleTable
					group.roles[newKey].id = newKey

					group.roles[key] = nil
				end
			end

			group:Save(true)

			group:NotifyAll(client:GetName().." has deleted role "..roleData.name..".")
		else
			client:Notify("Role not found.")
		end
	end
end)

netstream.Hook("ixGroupAddRole", function(client, groupID)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD and role != GROUP_MOD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		local id = table.Count(group.roles)
		table.insert(group.roles, id, {
			id = id,
			name = "New Role"
		})

		group:Save(true)

		client:Notify("New role added.")
	end
end)

netstream.Hook("ixGroupDelete", function(client, groupID)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		if (group:GetRoleID(client:GetCharacter():GetID()) == GROUP_LEAD) then
			group:NotifyAll(client:GetName().." has deleted your group.")

			for _, v in pairs(group:GetMemberCharacters()) do
				group:KickMember(v)
			end

			PLUGIN:DeleteGroup(group.id)

			client:Notify("Group "..group:GetName().." successfully deleted.")
		else
			client:Notify("You do not have permission to do that.")
		end
	end
end)

netstream.Hook("ixGroupHidden", function(client, groupID, value)
	local group = PLUGIN:FindGroup(groupID)

	if (group) then
		local charID = client:GetCharacter():GetID()
		local role = group:GetRoleID(charID)

		if (role != GROUP_LEAD) then
			client:Notify("You do not have permission to do that.")
			return
		end

		group.hidden = value
		group:Save(true)

		group:NotifyAll("Your group members will "..(!value and "now" or "not").." be displayed in a separate scoreboard tab.")
	end
end)
