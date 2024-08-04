--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


if (!sam) then return end

local ix = ix

ix.xenforo = ix.xenforo or {}
ix.xenforo.stored = ix.xenforo.stored or {}
ix.xenforo.restrictedWhitelists = ix.xenforo.restrictedWhitelists or {}

function ix.xenforo:RegisterForumGroup(name, id, data)
	self.stored[id] = {id = id, name =  name,
		premiumTier = data.premiumTier or 0,
		camiGroup = data.camiGroup,
		inherits = data.inherits,
		priority = data.priority,
		flags = data.flags,
		whitelists = data.whitelists,
	}

	if (!self.stored[id].premiumTier) then
		self.stored[id].premiumTier = 0
	end

	if (!self.stored[id].priority) then
		self.stored[id].priority = -1
	end
end

function ix.xenforo:RegisterRestrictedWhitelist(whitelist)
	self.restrictedWhitelists[whitelist] = true
end

function ix.xenforo:IsValidGroupID(id)
	id = tostring(id)
	return self.stored[id] != nil
end

function ix.xenforo:FindGroup(group)
	local targetGroup
	if (string.find(group, "^%d+$") and self.stored[group]) then
		targetGroup = group
	else
		group = string.lower(group)
		for k, v in pairs(self.stored) do
			if (string.find(string.utf8lower(v.name), group, 1, true) and (!targetGroup or string.utf8len(targetGroup) > string.utf8len(v.name))) then
				targetGroup = k
			end
		end
	end

	return targetGroup
end

function ix.xenforo:AddGroup(client, id, duration)
	if (!self.stored[id]) then return false end

	local groups = client:GetData("xenforoGroups", {})
	if (duration) then
		local time = math.Clamp(duration, 30, 2880)
		groups[id] = os.time() + time * 60
	else
		groups[id] = -1
	end
	client:SetData("xenforoGroups", groups)

	self:ApplyInGameGroups(client)

	return self.stored[id].name, groups[id] - os.time()
end

function ix.xenforo:RemoveGroup(client, id)
	if (!self.stored[id]) then return false end

	local groups = client:GetData("xenforoGroups", {})
	groups[id] = nil

	if (table.IsEmpty(groups)) then
		client:SetData("xenforoGroups", nil)
	else
		client:SetData("xenforoGroups", groups)
	end

	self:ApplyInGameGroups(client)

	return self.stored[id].name
end

function ix.xenforo:ClearTempGroups(client)
	local tempGroups = client:GetData("xenforoGroups", {})
	local bRemoved = false
	for k, v in pairs(tempGroups) do
		if (v >= 0 and v < os.time()) then
			tempGroups[k] = nil
			bRemoved = true
		end
	end

	local bHasTempGroups = !table.IsEmpty(tempGroups)
	if (bRemoved) then
		if (!table.IsEmpty(tempGroups)) then
			client:SetData("xenforoGroups", tempGroups)
		else
			client:SetData("xenforoGroups", nil)
		end
	end

	return tempGroups, bHasTempGroups
end

local inherits_from = sam.ranks.inherits_from
function ix.xenforo:ApplyInGameGroups(client)
	local ranks = {}
	local prio = 0
	local primaryRank = "user"
	local flags = ""
	local tier = 0
	local toRemove = table.Copy(self.restrictedWhitelists)

	if (client.ixXenforoGroups or client:GetData("xenforoGroups")) then
		local tempGroups, bHasTempGroups = self:ClearTempGroups(client)

		-- copy table so we don't modify it when adding the temp groups
		local forumGroups = table.Copy(client.ixXenforoGroups or {})
		if (bHasTempGroups) then
			forumGroups = table.Add(forumGroups, table.GetKeys(tempGroups))
		end

		-- Allow other plugins to add xenforo groups manually
		hook.Run("ModifyXenforoGroups", client, forumGroups)

		for _, v in ipairs(forumGroups) do
			local data = self.stored[tostring(v)]
			if (!data) then continue end

			if (data.camiGroup) then
				ranks[#ranks + 1] = data.camiGroup
				if (data.priority > prio) then
					prio = data.priority
					primaryRank = data.camiGroup
				end
			end

			-- Give flags
			if (data.flags) then
				for i = 1, #data.flags do
					local flag = data.flags[i]
					if (!string.find(flags, flag, 1, true)) then
						flags = flags..flag
					end
				end
			end

			-- Set Premium tier
			if (data.premiumTier > tier) then
				tier = data.premiumTier
			end

			-- Give whitelists
			if (ix.config.Get("whitelistForumLink") and data.whitelists) then
				for faction in pairs(data.whitelists) do
					toRemove[faction] = nil --don't remove this whitelist

					if (!client:HasWhitelist(faction)) then
						client:SetWhitelisted(faction, true)
					end
				end
			end
		end
	end

	-- Allow other plugins to add CAMI ranks to the list
	hook.Run("ModifyClientCAMIGroups", client, ranks)

	-- Network ranks
	if (#ranks > 0) then
		client:SetLocalVar("xenforoRanks", ranks)
	else
		client:SetLocalVar("xenforoRanks", nil)
	end

	-- Network flags
	local oldFlags = client:GetLocalVar("xenforoFlags", "")
	if (flags != "") then
		client:SetLocalVar("xenforoFlags", flags)
		for i = 1, #flags do
			local flag = flags[i]
			local info = ix.flag.list[flag]

			if (info and info.callback) then
				info.callback(client, true)
			end

			string.gsub(oldFlags, flag, "")
		end
	else
		client:SetLocalVar("xenforoFlags", nil)
	end

	-- Remove old flags that haven't been given again
	if (client:GetCharacter() and #oldFlags > 0) then
		for i = 1, #oldFlags do
			local flag = oldFlags[i]
			local info = ix.flag.list[flag]

			if (!client:GetCharacter():HasFlags(flag) and info and info.callback) then
				info.callback(client, false)
			end
		end
	end

	-- Network Premium tier
	if (tier > 0) then
		client:SetNetVar("xenforoTier", tier)
	else
		client:SetNetVar("xenforoTier", nil)
	end

	-- Set primary rank
	if (client:GetUserGroup() == "superadmin" and
		(inherits_from(primaryRank, "admin") or inherits_from(primaryRank, "superadmin"))) then
		primaryRank = "superadmin"
	end
	client:sam_set_rank(primaryRank)

	-- Remove whitelists
	if (ix.config.Get("whitelistForumLink")) then
		-- remove whitelists
		for k in pairs(toRemove) do
			if (client:HasWhitelist(k)) then
				client:SetWhitelisted(k, false)
			end
		end
	end

	hook.Run("PostPlayerXenforoGroupsUpdate", client)
end