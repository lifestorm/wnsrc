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

GROUP_LEAD = 0
GROUP_MOD = 1
GROUP_MEMBER = 999

local GROUP = ix.meta.group or {}
GROUP.id = GROUP.id or 0
GROUP.name = GROUP.name or "Undefined"
GROUP.color = GROUP.color or Color(math.random(1, 255), math.random(1, 255), math.random(1, 255))
GROUP.hidden = GROUP.hidden == nil and true or GROUP.hidden
GROUP.info = GROUP.info or ""
GROUP.lore = GROUP.lore or ""
GROUP.forum = GROUP.forum or ""
GROUP.active = GROUP.active == nil and false or GROUP.active
GROUP.roles = GROUP.roles or {}
GROUP.members = GROUP.members or {}

function GROUP:GetID()
	return self.id
end

function GROUP:GetName()
	return self.name
end

function GROUP:GetMemberCharacters()
	return table.GetKeys(self.members)
end

function GROUP:GetMembersCount()
	return table.Count(self.members)
end

function GROUP:GetOnlineMembers()
	local members = {}

	for _, v in ipairs(player.GetAll()) do
		local character = v:GetCharacter()

		if (character and self.members[character:GetID()]) then
			table.insert(members, v)
		end
	end

	return members
end

function GROUP:GetTable()
	return {
		id = self.id,
		name = self.name,
		color = self.color,
		hidden = self.hidden,
		info = self.info,
		lore = self.lore,
		forum = self.forum,
		active = self.active,
		roles = self.roles,
		members = self.members
	}
end

function GROUP:Save(bSync)
	local query = mysql:Update("ix_groups")
		query:Where("id", self.id)
		query:Update("name", self.name)
		query:Update("active", self.active and 1 or 0)
		query:Update("hidden", self.hidden and 1 or 0)
		query:Update("color_r", self.color.r)
		query:Update("color_g", self.color.g)
		query:Update("color_b", self.color.b)
		query:Update("color_a", self.color.a)
		query:Update("roles", util.TableToJSON(self.roles))
		query:Update("members", util.TableToJSON(self.members))
		query:Update("info", self.info)
		query:Update("lore", self.lore)
		query:Update("forum", self.forum)
	query:Execute()

	if (bSync) then
		self:Sync()
	end
end

function GROUP:CreateDB(character)
	self.members[character:GetID()] = GROUP_LEAD

	local query = mysql:Insert("ix_groups")
		query:Insert("name", self.name)
		query:Insert("active", self.active and 1 or 0)
		query:Insert("hidden", self.hidden and 1 or 0)
		query:Insert("color_r", self.color.r)
		query:Insert("color_g", self.color.g)
		query:Insert("color_b", self.color.b)
		query:Insert("color_a", self.color.a)
		query:Insert("roles", util.TableToJSON(self.roles))
		query:Insert("members", util.TableToJSON(self.members))
		query:Insert("info", self.info)
		query:Insert("lore", self.lore)
		query:Insert("forum", self.forum)
		query:Callback(function(result, _, insertID)
			self.id = insertID
			PLUGIN.stored[insertID] = self

			self:AddMember(character, GROUP_LEAD)

			self:Sync()
		end)
	query:Execute()
end

function GROUP:FromDB(group)
	self.id = group.id
	self.name = group.name
	self.color = Color(group.color_r, group.color_g, group.color_b, group.color_a)
	self.hidden = group.hidden == 1
	self.info = group.info
	self.lore = group.lore
	self.forum = group.forum
	self.active = group.active == 1
	self.roles = util.JSONToTable(group.roles)
	self.members = util.JSONToTable(group.members)

	PLUGIN.stored[self.id] = self
end

function GROUP:FromTable(group)
	self.id = group.id
	self.name = group.name
	self.color = group.color
	self.hidden = group.hidden
	self.info = group.info
	self.lore = group.lore
	self.forum = group.forum
	self.active = group.active
	self.roles = group.roles
	self.members = group.members
end

function GROUP:FromTableThird(group)
	self.id = group.id
	self.name = group.name
end

function GROUP:GetRole(characterID)
	return self.roles[self.members[characterID]]
end

function GROUP:GetRoleID(characterID)
	return self:GetRole(characterID).id
end

function GROUP:GetRoles()
	return self.roles
end

function GROUP:GetRoleData(role)
	return self.roles[role]
end

if (SERVER) then
	function GROUP:Sync(client)
		netstream.Start(client, "ixGroupSync", self:GetTable())
	end

	function GROUP:SyncThird(client)
		local tbl = {}
		tbl.id = self.id
		tbl.name = self.name
		netstream.Start(client, "ixGroupSyncNotOwned", tbl)
		if client then
			local character = client:GetCharacter() or nil

			if character and self.members[character:GetID()] then
				netstream.Start(client, "ixGroupSync", self:GetTable())
			end
		end
	end

	function GROUP:AddMember(character, role)
		if (character) then
			self.members[character:GetID()] = role or GROUP_MEMBER
			character:SetGroupID(self:GetID())
			character:Save()
			self:Sync()

			if (self:GetMembersCount() > 3 and !self.active) then
				self.active = true
			end
		end
	end

	function GROUP:KickMember(characterID)
		if (self.members[characterID]) then
			local character = ix.char.loaded[characterID]
			local deleting = false

			if (self:GetRoleID(characterID) == GROUP_LEAD and !self.active) then
				self:NotifyAll("Leader has disbanded your group.")
				deleting = true
			end

			self.members[characterID] = nil

			if (character) then
				character:SetGroupID(-1)
				character:Save()

				self:Sync(character:GetPlayer())
			else
				local query = mysql:Update("ix_characters")
					query:Update("group", -1)
					query:Where("id", characterID)
				query:Execute()
				PLUGIN.cache[characterID] = nil
			end

			if (table.IsEmpty(self.members) or deleting) then
				PLUGIN:DeleteGroup(self.id)
			end
		end
	end

	function GROUP:SetRole(characterID, role)
		self.members[characterID] = self.roles[role] and role
	end

	function GROUP:AddRole(data)
		if (data.id) then
			self.roles[data.id] = data
		else
			local id = table.insert(self.roles, data)
			self.roles[id].id = id
		end
	end

	function GROUP:EditRole(role, data)
		if (self.roles[role]) then
			self.roles[role] = data
		end
	end

	function GROUP:NotifyAll(text)
		for _, v in pairs(self:GetOnlineMembers()) do
			v:NotifyLocalized(text)
		end
	end

	if (table.IsEmpty(GROUP:GetRoles())) then
		GROUP:AddRole({
			id = GROUP_LEAD,
			name = "Group Lead"
		})

		GROUP:AddRole({
			id = GROUP_MOD,
			name = "Group Moderator"
		})

		GROUP:AddRole({
			id = GROUP_MEMBER,
			name = "Member"
		})
	end
end

ix.meta.group = GROUP