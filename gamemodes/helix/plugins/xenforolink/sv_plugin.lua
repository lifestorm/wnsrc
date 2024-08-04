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

function PLUGIN:InitAPIKey()
	if (!CHTTP) then return end
	self.API_KEY = file.Read("gamemodes/helix/plugins/xenforolink/apikey.txt", "GAME")
	if (self.API_KEY) then
		self.API_KEY = string.gsub(self.API_KEY, "[^%w%-]", "")
	end
end

function PLUGIN:GetXenforoGroups(client, notify)
	if (!self.API_KEY) then return end

	if (client.ixXenforoID) then
		client:SetLocalVar("xenforoLink", true)

		local steamName = client:SteamName()
		local endpoint = string.format("https://willard.network/forums/api/users/%s/?with_posts=0", tostring(client.ixXenforoID))
		local request = {
			failed = function(error)
				print("[XENFORO-LINK] Failed to find user: "..error)
				print("[XENFORO-LINK] Client: "..steamName.."; endpoint: "..endpoint)
				if (IsValid(client)) then
					ix.xenforo:ApplyInGameGroups(client)
				end
			end,
			success = function(code, body, headers)
				if (!IsValid(client)) then return end

				local httpResult = util.JSONToTable(body)
				if (!httpResult) then
					print("[XENFORO-LINK] Received invalid response; endpoint: "..endpoint)
					ix.xenforo:ApplyInGameGroups(client)
					return
				end

				if (!httpResult.user) then
					print("[XENFORO-LINK] Received invalid response (no user); endpoint: "..endpoint)
					ix.xenforo:ApplyInGameGroups(client)
					return
				end

				local groups = {}
				if (ix.xenforo:IsValidGroupID(httpResult.user["user_group_id"])) then
					groups[#groups + 1] = tostring(httpResult.user["user_group_id"])
				end

				for _, v in ipairs(httpResult.user["secondary_group_ids"]) do
					if (ix.xenforo:IsValidGroupID(v)) then
						groups[#groups + 1] = tostring(v)
					end
				end

				if (#groups > 0) then
					client.ixXenforoGroups = groups
				else
					client.ixXenforoGroups = nil
				end

				local query = mysql:Update("xenforo_link")
					query:Update("groups", groups and util.TableToJSON(groups) or nil)
					query:Where("steamid", client:SteamID64())
				query:Execute()

				ix.xenforo:ApplyInGameGroups(client)
				if (IsValid(notify)) then
					if (client == notify) then
						notify:NotifyLocalized("xenforoGroupsUpdateSelf", #groups)
					else
						notify:NotifyLocalized("xenforoGroupsUpdate", steamName, #groups)
					end
				end
			end,
			url = endpoint,
			method = "GET",
			headers = {
				["XF-Api-Key"] = self.API_KEY
			}
		}

		if (!CHTTP(request)) then
			ix.xenforo:ApplyInGameGroups(client)
		end
	else
		client:SetLocalVar("xenforoLink", false)

		ix.xenforo:ApplyInGameGroups(client)
		if (notify) then
			notify:NotifyLocalized("xenforoNotLinked", client:SteamName())
		end
	end
end