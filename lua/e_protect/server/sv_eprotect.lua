--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

eProtect = eProtect or {}
eProtect.queneData = eProtect.queneData or {}
eProtect.saveQueue = eProtect.saveQueue or {}

eProtect.data = eProtect.data or {}
eProtect.data.disabled = eProtect.data.disabled or {}

local ignoreSaving = {
	["fakeNets"] = true,
	["netLogging"] = true,
	["exploitPatcher"] = true
}

util.AddNetworkString("eP:Handeler")

local function openMenu(ply)
	net.Start("eP:Handeler")
	net.WriteUInt(2, 3)
	net.Send(ply)
end

local convertedTbl

convertedTbl = function(tbl)
	local converted_tbl = {}

	for k,v in pairs(tbl) do
		if istable(v) then v = convertedTbl(v) end

		local isSID = util.SteamIDFrom64(k) != "STEAM_0:0:0"

		if isSID then
			converted_tbl["sid64_"..k] = v
		else
			converted_tbl[k] = v
		end
	end

	return converted_tbl
end

local function networkData(ply, data, specific)
	if !data then return end
	local data = util.TableToJSON(convertedTbl(data))

	data = util.Compress(data)

	net.Start("eP:Handeler")
	net.WriteUInt(1, 3)
	net.WriteUInt(#data, 32)
	net.WriteData(data, #data)

	if specific then
		net.WriteString(specific)
	end

	net.Send(ply)
end

eProtect.hasPermission = function(ply, specific)
	return eProtect.config["permission"][ply:GetUserGroup()]
end

local punished = {}

eProtect.getData = function(specific)
	local data = file.Read("eprotect/data.json", "DATA")

	if !data then return end

	data = util.JSONToTable(data)

	if specific then
		data = data[specific]
	end

	for k,v in pairs(data) do
		eProtect.data[k] = v
	end

	return table.Copy(data)
end

eProtect.dataVerification = function()
	local data = eProtect.getData()
	data = data or {}

	data["general"] = data["general"] or {}

	for k,v in pairs(eProtect.BaseConfig) do
		if data["general"][k] then continue end
		data["general"][k] = v[1]
	end

	for k,v in pairs(eProtect.data) do
		if ignoreSaving[k] or k == "general" then continue end
		data[k] = v
	end

	file.CreateDir("eprotect")
	file.Write("eprotect/data.json", util.TableToJSON(data))

	eProtect.getData()
	eProtect.queueNetworking()
end

eProtect.saveData = function()
	file.CreateDir("eprotect")

	local data = table.Copy(eProtect.data)

	for k, v in pairs(data) do
		if ignoreSaving[k] then data[k] = nil end
	end

	file.Write("eprotect/data.json", util.TableToJSON(data))
end

eProtect.canNetwork = function(ply, netstring)
	if !IsValid(ply) or !ply:IsPlayer() then return end
	if (punished[ply:SteamID()] or eProtect.data.disabled[ply:SteamID()] or eProtect.data.general["disable-all-networking"]) and (netstring ~= "eP:Handeler") then return false end

	return true
end

eProtect.punish = function(ply, type, msg, duration)
	if eProtect.data.general["bypassgroup"][ply:GetUserGroup()] or eProtect.data.general["bypass_sids"][ply:SteamID()] or eProtect.data.general["bypass_sids"][ply:SteamID64()] then return end
	msg = eProtect.config["prefix"]..msg

	punished[ply:SteamID()] = true

	slib.punish(ply, type, msg, duration)
end

eProtect.networkData = function(ply)
	if eProtect.queneData[ply:SteamID()] then
		for k,v in pairs(eProtect.queneData[ply:SteamID()]) do
			networkData(ply, eProtect.data[k], k)
			eProtect.queneData[ply:SteamID()][k] = nil
		end
	end
end

local function registerQuene(ply, specific)
	if specific then
		eProtect.queneData[ply:SteamID()] = eProtect.queneData[ply:SteamID()] and eProtect.queneData[ply:SteamID()] or {}
		eProtect.queneData[ply:SteamID()][specific] = true
	else
		for k,v in pairs(eProtect.data) do
			registerQuene(ply, k)
		end
	end
end

eProtect.queueNetworking = function(ply, specific)
	if ply then
		registerQuene(ply, specific)
	else
		for k,v in pairs(player.GetAll()) do
			if !IsValid(v) then continue end
			registerQuene(v, specific)
		end
	end
end

local screenshotRequested = {}
local idRequested = {}
local dataRequested = {}
local limitSC = {}

local function requestData(ply, target, type)
	local data
	
	if type == 1 then
		local sid = target:SteamID()
		if limitSC[sid] and CurTime() - limitSC[sid] < 10 then
			slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "sc-timeout", math.Round(10 - (CurTime() - limitSC[sid])), target:Nick()), ply)
		return end
		
		limitSC[sid] = CurTime()

		data = screenshotRequested
	elseif type == 2 then
		data = idRequested
	elseif type == 3 then
		data = dataRequested
	end

	if data[target] then return end

	data[target] = ply
	
	net.Start("eP:Handeler")
	net.WriteUInt(3, 3)
	net.WriteUInt(type, 2)
	net.WriteBool(false)
	net.Send(target)

	timer.Simple(10, function()
		if !target or !ply then return end
		if data[target] then
			data[target] = nil
			slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "sc-failed", target:Nick()), ply)
		end
	end)
end

hook.Add("PlayerInitialSpawn", "eP:NetworkingQueuer", function(ply)
	eProtect.queueNetworking(ply)
	local sid = ply:SteamID()
	if punished[sid] then punished[sid] = nil end
end)

local function verifyBannedAlt(ply, sid64, type)
	sid64 = sid64 or ply:SteamID64()
	local isBanned = slib.isBanned(sid64, function(banned, sid) if banned then if IsValid(ply) then slib.punish(ply, type, eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "punished-alt")) end end end)
	
	if isBanned then
		slib.punish(ply, type, eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "punished-alt"))
	end

	return isBanned
end

local settingConverter = { // Its reverted on clientside
	[1] = 3,
	[2] = 1,
	[3] = 2
}

hook.Add("PlayerInitialSpawn", "eP:AutomaticChecks", function(ply)
	local automatic_identifier = tonumber(eProtect.data.general["automatic-identifier"]) or 1

	timer.Simple(1.5, function() -- Giving time to set usergroup.
		if !IsValid(ply) or !ply:IsPlayer() or ply:IsBot() or eProtect.data.general["bypassgroup"][ply:GetUserGroup()] or eProtect.data.general["bypass_sids"][ply:SteamID64()] or eProtect.data.general["bypass_sids"][ply:SteamID()] then return end
		
		if eProtect.data.general["block-vpn"] and !eProtect.data.general["bypass-vpn"][ply:GetUserGroup()] and !eProtect.data.general["bypass-vpn"][ply:SteamID64()] then
			local ip = ""
		
			for k,v in ipairs(string.ToTable(ply:IPAddress())) do
				if v == ":" then break end
		
				ip = ip..v
			end
			
			http.Fetch("https://proxycheck.io/v2/"..ip.."?vpn=1", function(result)
				result = result and util.JSONToTable(result)
	
				if result[ip] and result[ip].proxy == "yes" then
					ply:Kick(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "vpn-blocked"))
				end
			end)
		end

		if automatic_identifier > 0 then
			eProtect.correlateIP(ply, function(result)
				local correlatedIPs = result
				local plysid64, ownerplysid64 = ply:SteamID64(), ply:OwnerSteamID64()
				local familyShare = ply:SteamID64() ~= ply:OwnerSteamID64()
				local detections = !familyShare and !table.IsEmpty(correlatedIPs)
				local altsDetected = {}
		
				if detections then
					local detect_type
					detections = ""
					if correlatedIPs and istable(correlatedIPs) and !table.IsEmpty(correlatedIPs) then
						detect_type = "correlated-ip"

						local foundAlts = {}
						for k,v in ipairs(correlatedIPs) do
							table.insert(altsDetected, v.sid64)
						end

						detections = slib.getLang("eprotect", eProtect.config["language"], "correlated-ip")
					end
		
					if familyShare then
						detect_type = "family-share"

						detections = detections == "" and slib.getLang("eprotect", eProtect.config["language"], "family-share") or detections.." "..slib.getLang("eprotect", eProtect.config["language"], "and").." "..slib.getLang("eprotect", eProtect.config["language"], "family-share")
						table.insert(altsDetected, ownerplysid64)
					end
		
					if detections ~= "" then
						local doneAction

						if automatic_identifier == 1 then
							for k, v in ipairs(player.GetAll()) do
								if eProtect.data.general["notification-groups"][v:GetUserGroup()] then
									slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "auto-detected-alt", ply:Nick(), detections), ply)
								end
							end

							doneAction = true
						elseif automatic_identifier == 2 then
							for k,v in ipairs(altsDetected) do
								doneAction = doneAction or verifyBannedAlt(ply, v, 1)
							end
						elseif automatic_identifier == 3 then
							for k,v in ipairs(altsDetected) do
								doneAction = doneAction or verifyBannedAlt(ply, v, 2)
							end
						end

						if doneAction then
							eProtect.logDetectionHandeler(ply, "alt-detection", slib.getLang("eprotect", eProtect.config["language"], detect_type), settingConverter[automatic_identifier])
						end
					end
				end
			end)
		end
	end)
end)

hook.Add("PlayerSay", "eP:OpenMenu", function(ply, text, public)
	if eProtect.config["command"] == string.lower(text) then
		if !eProtect.hasPermission(ply) then
			return text
		end

		eProtect.networkData(ply)

		openMenu(ply)
		return ""
	end
end )

hook.Add("eP:PreNetworking", "eP:Restrictions", function(ply, netstring, len)
	if !eProtect.canNetwork(ply, netstring) then return false end
	if len >= 512000 then eProtect.logDetectionHandeler(ply, "net-overflow", netstring, 1) eProtect.punish(ply, 1, slib.getLang("eprotect", eProtect.config["language"], "kick-net-overflow")) return false end	
end)

hook.Add("eP:PreHTTP", "eP:PreventBlockedHTTP", function(url)
	if eProtect.data.general["httpfocusedurls"] then
		return eProtect.data.general["httpfocusedurlsisblacklist"] == !tobool(eProtect.data.general["httpfocusedurls"][url])
	end
end)

timer.Create("eP:SaveCache", eProtect.config["process-save-queue"], 0, function()
	if !eProtect.saveQueue then return end
	eProtect.saveData()

	eProtect.saveQueue = nil
end)

net.Receive("eP:Handeler", function(len, ply)
	local gateway = net.ReadBit()
	local action = net.ReadUInt(2)

	if tobool(gateway) then
		if !eProtect.hasPermission(ply) then return end

		if action == 0 then
			local id = net.ReadUInt(1)
			local page = net.ReadUInt(15)
			local search = net.ReadString()

			if id == 0 then
				eProtect.requestHTTPLog(ply, page, search)
			elseif id == 1 then
				eProtect.requestDetectionLog(ply, page, search)
			end
		elseif action == 1 then
			local specific = net.ReadUInt(3)
			local strings = {}
	
			for i=1,specific do
				strings[i] = net.ReadString()
			end
	
			local statement = net.ReadUInt(2)
			local data
	
			if statement == 1 then
				data = net.ReadBool()
			elseif statement == 2 then
				data = net.ReadInt(32)
			elseif statement == 3 then
				local chunk = net.ReadUInt(32)
				data = net.ReadData(chunk)
				
				data = util.Decompress(data)
				data = util.JSONToTable(data)

				local converted_tbl = {}

				for k, v in pairs(data) do
					if string.sub(k, 1, 6) == "sid64_" then
						local sid64 = string.sub(k, 7, #k)

						if util.SteamIDFrom64(sid64) != "STEAM_0:0:0" then
							k = sid64
						end
					end

					converted_tbl[k] = v
				end

				data = converted_tbl
			end
			
			local finaldestination = eProtect.data
			for k,v in ipairs(strings) do
				finaldestination = finaldestination[v]
				if k >= (#strings - 1) then break end
			end
	
			finaldestination[strings[#strings]] = data
	
			eProtect.saveQueue = true
			eProtect.queueNetworking(nil, strings[1])
		elseif action == 2 then
			local subaction = net.ReadUInt(3)
			local target = net.ReadUInt(14)
	
			target = Entity(target)
	
			if !IsValid(target) or !target:IsPlayer() then slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "invalid-player"), ply) return end
			
			local sid = target:SteamID()
	
			if subaction == 1 then
				eProtect.data.disabled[sid] = net.ReadBool()
				eProtect.queueNetworking(nil, "disabled")
			elseif subaction == 2 then
				requestData(ply, target, net.ReadUInt(2))
			elseif subaction == 3 then
				local bit = net.ReadBit()
				if tobool(bit) then
					eProtect.correlateIP(target, function(result)
						if !IsValid(target) or !IsValid(ply) then return end
						if table.IsEmpty(result) then slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "no-correlation", target:Nick()), ply) return end

						result = util.TableToJSON(result)
						result = util.Base64Encode(result)

						net.Start("eP:Handeler")
						net.WriteUInt(4,3)
						net.WriteUInt(target:EntIndex(), 14)
						net.WriteString(result)
						net.WriteBit(1)
						net.Send(ply)
					end)
				else
					eProtect.showIPs(target, ply)
				end
			elseif subaction == 4 then
				local sid64 = target:SteamID64()
				local ownersid64 = target:OwnerSteamID64()

				if sid64 == ownersid64 then
					slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "no-family-share", target:Nick()), ply)
				else
					slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "has-family-share", target:Nick(), ownersid64), ply)
				end
			end
		end
	else
		if action == 1 then
			local subaction = net.ReadUInt(2)

			local data

			if subaction == 1 then
				data = screenshotRequested
			elseif subaction == 2 then
				data = idRequested
			elseif subaction == 3 then
				data = dataRequested
			end

			if !data[ply] then if eProtect.config["punishMaliciousIntent"] then eProtect.punish(ply, 1, slib.getLang("eprotect", eProtect.config["language"], "kick-malicious-intent")) end return end
			local target = data[ply]
			data[ply] = nil

			local id
			
			if subaction == 3 then
				local chunk = net.ReadUInt(32)
				id = net.ReadData(chunk)
			else
				id = net.ReadString()
			end

			if !id or id == "" then
				if eProtect.config["punishMaliciousIntent"] then
					eProtect.punish(ply, 1, slib.getLang("eprotect", eProtect.config["language"], "kick-malicious-intent"))
				end
			return end

			net.Start("eP:Handeler")
			net.WriteUInt(3, 3)
			net.WriteUInt(subaction, 2)
			net.WriteUInt(ply:EntIndex(), 14)
			net.WriteBool(true)

			if subaction == 3 then
				local chunk = #id
				net.WriteUInt(chunk, 32)
                net.WriteData(id, chunk)
			else
				net.WriteString(id)
			end

			net.Send(target)
		elseif action == 2 then
			local menu = net.ReadUInt(2)
			local menus = {
				[1] = "Loki",
				[2] = "Exploit City"
			}

			eProtect.logDetectionHandeler(ply, "exploit-menu", menus[menu], 2)
			eProtect.punish(ply, 2, slib.getLang("eprotect", eProtect.config["language"], "banned-exploit-menu"))
		end
	end
end)

hook.Add("eP:SQLConnected", "eP:TransferOldIPs", function()
	local files = file.Find("eprotect/ips/*", "DATA")
	for k,v in pairs(files) do
		local sid64 = string.gsub(v, ".json", "")
		
		local ips = file.Read("eprotect/ips/"..v, "DATA")
		ips = util.JSONToTable(ips)
		if !ips then continue end

		for ip, data in pairs(ips) do
			eProtect.registerIP(sid64, ip, data[1], data[2])
		end

		file.Delete("eprotect/ips/"..v)
	end
	file.Delete("eprotect/ips")

	local save = false

	if eProtect.data.httpLogging then
		for url, v in pairs(eProtect.data.httpLogging) do
			eProtect.logHTTP(url, v.type, v.called)
		end

		eProtect.data.httpLogging = nil

		save = true
	end

	if eProtect.data.punishmentLogging then
		for i = #eProtect.data.punishmentLogging, 1, -1 do
			local data = eProtect.data.punishmentLogging[i]

			eProtect.logDetection(data.ply, "", data.reason, data.info, data.type)
		end

		eProtect.data.punishmentLogging = nil

		save = true
	end

	if save then
		eProtect.saveData()
	end
end)

eProtect.dataVerification()