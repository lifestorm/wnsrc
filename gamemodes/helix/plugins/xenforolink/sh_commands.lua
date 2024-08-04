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

ix.command.Add("LinkAccount", {
	description = "Link your steam account to your forum account. Please provide your forum profile link, user ID, username or e-mail.",
	arguments = {
		ix.type.string
	},
    OnCheckAccess = function(self, client)
		return !client:GetLocalVar("xenforoLink")
	end,
	OnRun = function(self, client, forumID)
        PLUGIN:FindUser(client, forumID)
	end
})

ix.command.Add("LinkComplete", {
	description = "Link your steam account to your forum account.",
	arguments = {
		ix.type.text
	},
    OnCheckAccess = function(self, client)
		return client:GetLocalVar("xenforoLinkStart", 0) + PLUGIN.TOKEN_VALID * 60 > os.time() and !client:GetLocalVar("xenforoLink")
	end,
	OnRun = function(self, client, code)
        if (!code) then return end
        PLUGIN:FinishLink(client, code)
	end
})

ix.command.Add("LinkRemove", {
	description = "Link your steam account to your forum account.",
    OnCheckAccess = function(self, client)
		return client:GetLocalVar("xenforoLink")
	end,
	OnRun = function(self, client)
        PLUGIN:RemoveLink(client)
	end
})

ix.command.Add("ForceGroupUpdate", {
	description = "Link your steam account to your forum account.",
	arguments = {
		ix.type.player
	},
    superAdminOnly = true,
	OnRun = function(self, client, target)
        PLUGIN:GetXenforoGroups(target, client)
	end
})

ix.command.Add("PlyGiveTempGroup", {
	description = "Give a player a temporary (admin) group.",
	arguments = {
		ix.type.player,
		ix.type.string,
		ix.type.number
	},
	argumentNames = {"target", "SAM groupName", "duration (minutes)"},
    privilege = "Manage Temp Admin",
	OnRun = function(self, client, target, group, duration)
		local targetGroup = ix.xenforo:FindGroup(group)
		if (!targetGroup) then
			client:NotifyLocalized("xenforoNoGroupFound", group)
			return
		end

		local groupName, time = ix.xenforo:AddGroup(target, targetGroup, duration)
		for _, v in ipairs(player.GetAll()) do
			if (self:OnCheckAccess(v) or v == target) then
				v:NotifyLocalized("xenforoTempGroup", target:Name(), groupName, math.ceil(time / 60))
			end
		end
	end
})

ix.command.Add("PlyRemoveTempGroup", {
	description = "Remove a player a temporary (admin) group.",
	arguments = {
		ix.type.player,
		ix.type.string
	},
	argumentNames = {"target", "forum groupID/SAM groupName"},
    privilege = "Manage Temp Admin",
	OnRun = function(self, client, target, group)
		local targetGroup = ix.xenforo:FindGroup(group)
		if (!targetGroup) then
			client:NotifyLocalized("xenforoNoGroupFound", group)
			return
		end

		local groupName = ix.xenforo:RemoveGroup(target, targetGroup)
		for _, v in ipairs(player.GetAll()) do
			if (self:OnCheckAccess(v) or v == target) then
				v:NotifyLocalized("xenforoTempGroupRemove", target:Name(), groupName)
			end
		end
	end
})

ix.command.Add("PlyClearTempGroups", {
	description = "Clear a player a temporary (admin) groups.",
	arguments = {
		ix.type.player
	},
	argumentNames = {"target"},
    privilege = "Manage Temp Admin",
	OnRun = function(self, client, target)
		target:SetData("xenforoGroups", nil)
		ix.xenforo:ApplyInGameGroups(client)

		for _, v in ipairs(player.GetAll()) do
			if (self:OnCheckAccess(v) or v == target) then
				v:NotifyLocalized("xenforoTempGroupClear", target:Name())
			end
		end
	end
})

ix.command.Add("PlyGetXenforoGroups", {
	description = "Get all Xenforo Groups set on a player.",
	arguments = {
		ix.type.player
	},
	argumentNames = {"target"},
    privilege = "Manage Temp Admin",
	OnRun = function(self, client, target)
		if (target.ixXenforoID) then
			client:ChatNotifyLocalized("xenforoTargetForumID", target:Name(), target.ixXenforoID)
		else
			client:ChatNotifyLocalized("xenforoTargetNoForumID", target:Name())
		end

		if (target.ixXenforoGroups) then
			local groupNames = {}
			for k, v in ipairs(target.ixXenforoGroups) do
				if (!ix.xenforo.stored[v]) then continue end
				groupNames[#groupNames + 1] = ix.xenforo.stored[v].name
			end

			if (#groupNames > 0) then
				client:ChatNotifyLocalized("xenforoTargetGroups", table.concat(groupNames, ", "))
			else
				client:ChatNotifyLocalized("xenforoTargetNoGroups", target:Name())
			end
		else
			client:ChatNotifyLocalized("xenforoTargetNoGroups", target:Name())
		end

		if (target:GetData("xenforoGroups")) then
			local groupNames = {}
			for k, v in pairs(target:GetData("xenforoGroups")) do
				if (!ix.xenforo.stored[tostring(k)]) then continue end
				groupNames[#groupNames + 1] = ix.xenforo.stored[tostring(k)].name..(v < 0 and " (P)" or " (T: "..math.ceil((v - os.time())/60).."m)")
			end
			if (#groupNames > 0) then
				client:ChatNotifyLocalized("xenforoTargetDynGroups", table.concat(groupNames, ", "))
			else
				client:ChatNotifyLocalized("xenforoTargetDynNoGroups", target:Name())
			end
		else
			client:ChatNotifyLocalized("xenforoTargetDynNoGroups", target:Name())
		end

		if (target:GetLocalVar("xenforoRanks")) then
			local ranks = {}
			for k, v in ipairs(target:GetLocalVar("xenforoRanks")) do
				ranks[#ranks + 1] = v
			end
			client:ChatNotifyLocalized("xenforoRanks", table.concat(ranks, ", "))
		else
			client:ChatNotifyLocalized("xenforoNoRanks", target:Name())
		end

		if (target:GetLocalVar("xenforoFlags")) then
			client:ChatNotifyLocalized("xenforoFlags", target:GetLocalVar("xenforoFlags"))
		else
			client:ChatNotifyLocalized("xenforoNoFlags", target:Name())
		end

		if (target:GetNetVar("xenforoTier", 0) > 0) then
			client:ChatNotifyLocalized("xenforoPremium", target:GetLocalVar("xenforoTier"))
		else
			client:ChatNotifyLocalized("xenforoNoPremium", target:Name())
		end
	end
})

ix.command.Add("ToggleGM", {
	description = "Toggle your GM rank on and off. Will notify all admins about it.",
    OnCheckAccess = function(self, client)
		return table.HasValue(client:GetLocalVar("xenforoRanks", {}), "gamemaster_inactive") or
			(table.HasValue(client:GetLocalVar("xenforoRanks", {}), "gamemaster") and client:GetLocalVar("GMToggledOn") == true)
	end,
	OnRun = function(self, client)
        client:SetLocalVar("GMToggledOn", !client:GetLocalVar("GMToggledOn"))
		ix.xenforo:ApplyInGameGroups(client)

		for k, v in ipairs(player.GetAll()) do
			if (v == client or v:IsAdmin()) then
				v:NotifyLocalized("gamemasterToggle", client:Name(), client:GetLocalVar("GMToggledOn") and "on" or "off")
			end
		end
	end
})

ix.command.Add("ToggleMentor", {
	description = "Toggle your mentor rank on and off. Will notify all admins about it",
    OnCheckAccess = function(self, client)
		return table.HasValue(client:GetLocalVar("xenforoRanks", {}), "mentor_inactive") or
			(table.HasValue(client:GetLocalVar("xenforoRanks", {}), "mentor") and client:GetLocalVar("MentorActive") == true)
	end,
	OnRun = function(self, client)
        client:SetLocalVar("MentorActive", !client:GetLocalVar("MentorActive"))
		ix.xenforo:ApplyInGameGroups(client)

		for k, v in ipairs(player.GetAll()) do
			if (v == client or v:IsAdmin()) then
				v:NotifyLocalized("mentorToggle", client:Name(), client:GetLocalVar("MentorActive") and "on" or "off")
			end
		end
	end
})