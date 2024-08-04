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

function PLUGIN:PlayerLoadedCharacter(client, character)
	self:GetXenforoGroups(client)
end

function PLUGIN:PlayerInitialSpawn(client)
	local query = mysql:Select("xenforo_link")
		query:Where("steamid", client:SteamID64())
		query:Callback(function(result)
			if (result and #result > 0) then
				client.ixXenforoID = result[1]["forum_id"]
				client.ixXenforoGroups = result[1]["groups"] and util.JSONToTable(result[1]["groups"]) or nil
				for i = #client.ixXenforoGroups, 1, -1 do
					if (!ix.xenforo.stored[tostring(client.ixXenforoGroups[i])]) then
						table.remove(client.ixXenforoGroups, i)
					end
				end
			end
		end)
	query:Execute()
end

function PLUGIN:PostPlayerLoadout(client)
	if (!client:GetCharacter()) then return end

	local flags = client:GetLocalVar("xenforoFlags", "")

	if (flags == "") then return end
	for i = 1, #flags do
		local flag = flags[i]
		local info = ix.flag.list[flag]

		if (info and info.callback) then
			info.callback(client, true)
		end
	end
end

function PLUGIN:CanWhitelistPlayer(target, faction)
	if (ix.config.Get("whitelistForumLink") and ix.xenforo.restrictedWhitelists[faction.index]) then
		return false, "xenforoWhitelistForumLink"
	end
end

function PLUGIN:ModifyXenforoGroups(client, groups)
	if (client:GetLocalVar("MentorActive")) then
		groups[#groups + 1] = "mentor_active"
	end

	if (client:GetLocalVar("GMToggledOn")) then
		groups[#groups + 1] = "gamemaster_active"
	end
end

function PLUGIN:PlayerDataRestored(client)
	local groups = client:GetData("xenforoGroups", {})
	local newGroups = {}
	for k, v in pairs(groups) do
		newGroups[tostring(k)] = v
	end

	client:SetData("xenforoGroups", newGroups)
end