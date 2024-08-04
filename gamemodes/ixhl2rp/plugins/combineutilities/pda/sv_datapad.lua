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

function PLUGIN:DatabaseConnected()
	local query = mysql:Create("ix_datapad")
	query:Create("update_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
	query:Create("update_text", "TEXT")
	query:Create("update_date", "TEXT")
	query:Create("update_poster", "TEXT")
	query:PrimaryKey("update_id")
	query:Execute()

	query = mysql:Create("ix_comgroupmessages")
	query:Create("message_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
	query:Create("message_text", "TEXT")
	query:Create("message_date", "TEXT")
	query:Create("message_poster", "TEXT")
	query:Create("message_groupid", "TEXT")
	query:PrimaryKey("message_id")
	query:Execute()

	query = mysql:Create("ix_comgroupreplies")
	query:Create("reply_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
	query:Create("reply_text", "TEXT")
	query:Create("reply_date", "TEXT")
	query:Create("reply_poster", "TEXT")
	query:Create("reply_parent", "TEXT")
	query:Create("reply_groupid", "TEXT")
	query:PrimaryKey("reply_id")
	query:Execute()

	query = mysql:Create("ix_camessaging")
	query:Create("message_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
	query:Create("message_text", "TEXT")
	query:Create("message_date", "TEXT")
	query:Create("message_poster", "TEXT")
	query:Create("message_cid", "TEXT")
	query:Create("message_reply", "TEXT")
	query:PrimaryKey("message_id")
	query:Execute()

	query = mysql:Create("ix_crimereports")
	query:Create("message_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
	query:Create("message_text", "TEXT")
	query:Create("message_date", "TEXT")
	query:Create("message_poster", "TEXT")
	query:Create("message_cid", "TEXT")
	query:PrimaryKey("message_id")
	query:Execute()
end

function PLUGIN:HasAccessToDatafile(client)
	if !client or client and !IsValid(client) then return false end

	local faction = ix.faction.Get(client:Team())
	if (faction.alwaysDatafile or client:GetCharacter():HasFlags("U")) then
		return true
	elseif (client:HasActiveCombineSuit() or faction.allowDatafile) then
		if (client:GetCharacter():GetInventory():HasItem("pda") or client:GetActiveWeapon():GetClass() == "weapon_datapad") then
			return true
		end
	end
end

function PLUGIN:GetUpdates(client)
	local query = mysql:Select("ix_datapad")
	query:Select("update_id")
	query:Select("update_text")
	query:Select("update_date")
	query:Select("update_poster")
	query:Callback(function(result)
		if (!istable(result)) then
			return
		end

		if (!table.IsEmpty(PLUGIN.updatelist)) then
			table.Empty(PLUGIN.updatelist)
		end

		PLUGIN.updatelist = result
	end)

	query:Execute()

	self:GetActivePermits(client)
end

function PLUGIN:Refresh(client, text)
	PLUGIN:GetUpdates(client)
	timer.Simple(0.05, function()
		netstream.Start(client, "OpenPDA", PLUGIN.updatelist, text)
	end)
end

function PLUGIN:GetConsoleUpdates(client)
	PLUGIN:GetUpdates(client)
end

function PLUGIN:CharacterVarChanged(character, key, oldValue, value)
	local genericdata = character:GetGenericdata()
	if (key == "name" and genericdata) then
		genericdata.name = value

		character:SetGenericdata(genericdata)

		if (IsValid(character:GetPlayer())) then
			character:Save()
		end
	end
end

netstream.Hook("ClearArchivedCrimeReports", function(client)
	local character = client:GetCharacter()
	if (!character:IsCombine()) then
		return client:NotifyLocalized("Only combine can clear crime reports.")
	elseif !client:IsCombineRankAbove("i1") then
		return client:NotifyLocalized("Your rank must be above i1 to clear crime reports.")
	end

	local query = mysql:Select("ix_crimereports")
	query:Select("message_id")
	query:Select("message_text")
	query:Select("message_date")
	query:Select("message_poster")
	query:Select("message_cid")
	query:Callback(function(result)
		if (!istable(result) or #result == 0) then
			return
		end

		local newMessages = 0
		local clearedMessages = 0

		for _, v in pairs(result) do
			local msgPoster = util.JSONToTable(v["message_poster"])
			local isArchived = msgPoster["archived"]

			if !isArchived then continue end

			local date = v["message_date"]

			local messageDay = date[1] != "0" and date[1] .. date[2] .. "d" or date[2] .. "d"
			local messageMonth = date[4] != "0" and date[4] .. date[5] .. "m" or date[5] .. "m"
			local messageYear = date[7] .. date[8] .. date[9] .. date[10] .. "y"

			local totalMessageTime = ix.util.GetStringTime(messageDay .. messageMonth .. messageYear)

			local currentDay = ix.date.GetFormatted("%d")[1] != "0" and ix.date.GetFormatted("%d")[1] .. ix.date.GetFormatted("%d")[2] .. "d" or ix.date.GetFormatted("%d")[2] .. "d"
			local currentMonth = ix.date.GetFormatted("%m") != "0" and ix.date.GetFormatted("%m")[1] .. ix.date.GetFormatted("%m")[2] .. "m" or ix.date.GetFormatted("%m")[2] .. "m"
			local currentYear = ix.date.GetFormatted("%Y") .. "y"

			local currentTotalTime = ix.util.GetStringTime(currentDay .. currentMonth .. currentYear)

			if (currentTotalTime - totalMessageTime) < (ix.config.Get("crimeReportArchiveTime", 1) * 604800) then
				newMessages = newMessages + 1
				continue
			end

			local queryObj = mysql:Delete("ix_crimereports")
				queryObj:Where("message_id", v["message_id"])
			queryObj:Execute()

			clearedMessages = clearedMessages + 1
		end

		client:NotifyLocalized(clearedMessages > 0 and "Successfully cleared " .. clearedMessages .. " archived crime reports. " .. "There are " .. newMessages .. " new archived crime reports that can't be cleared yet." or newMessages and "All archived reports are not older than " .. ix.config.Get("crimeReportArchiveTime", 1) .. " week(s)" or "No archived crime reports found.")
	end)
	query:Execute()
end)

netstream.Hook("AddUpdate", function(client, text)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("LOG:// Pobieranie aktualizacji manifestu pliku danych Overwatch")

	timer.Simple(1, function()
		ix.combineNotify:AddNotification("NTC:// Nowy plik danych Aktualizacji został opublikowany przez " .. string.upper(author), Color(171, 222, 47))
	end)

	local timestamp = os.date( "%d.%m.%Y" )
	local queryObj = mysql:Insert("ix_datapad")
		queryObj:Insert("update_text", text)
		queryObj:Insert("update_date", timestamp)
		queryObj:Insert("update_poster", client:Name())
	queryObj:Execute()

	PLUGIN:Refresh(client)
end)

netstream.Hook("RemoveUpdate", function(client, id)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("LOG:// Pobieranie zaktualizowanego manifestu aktualizacji pliku danych Overwatch")

	timer.Simple(1, function()
		ix.combineNotify:AddNotification("NTC:// Plik danych Aktualizacji o ID #" .. id .. " został usunięty przez " .. string.upper(author), Color(171, 222, 47))
	end)

	local queryObj = mysql:Delete("ix_datapad")
		queryObj:Where("update_id", id)
	queryObj:Execute()

	PLUGIN:Refresh(client)
end)

netstream.Hook("EditUpdate", function(client, id, newText)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("LOG:// Pobieranie zaktualizowanego manifestu aktualizacji pliku danych Overwatch")

	timer.Simple(1, function()
		ix.combineNotify:AddNotification("NTC:// Plik danych Aktualizacji o ID #" .. id .. " został zaaktualizowany przez " .. string.upper(author), Color(171, 222, 47))
	end)

	local queryObj = mysql:Update("ix_datapad")
		queryObj:Where("update_id", id)
		queryObj:Update("update_text", newText)
	queryObj:Execute()

	PLUGIN:Refresh(client)
end)


netstream.Hook("SetDatafileLoyaltyPointsServer", function(client, target, amount)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	local genericData = target:GetCharacter():GetGenericdata()

	if (genericData.socialCredits) then
		genericData.socialCredits = !genericData.combine and math.Clamp(amount, 0, 200) or amount

		target:GetCharacter():SetGenericdata(genericData)
		target:GetCharacter():Save()
	end
end)

function PLUGIN:GetActiveShopPermits(client, appID)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	local dataSelect = mysql:Select("ix_apartments_"..game.GetMap())
	dataSelect:Where("app_id", appID)
	dataSelect:Callback(function(dataSelectResult)
		if (!istable(dataSelectResult) or #dataSelectResult == 0) then
			return
		end
		for _, v in ipairs(dataSelectResult) do
			local data = util.JSONToTable(v.app_permits)
			if data and !table.IsEmpty(data) then
				netstream.Start(client, "CreateActiveShopPermitsDatapad", data)
			end
		end
	end)
	dataSelect:Execute()
end

function PLUGIN:GetActivePermits(client)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local dataSelect = mysql:Select("ix_characters_data")
	dataSelect:WhereIn("key", "genericdata")
	dataSelect:Callback(function(dataSelectResult)
		if (!istable(dataSelectResult) or #dataSelectResult == 0) then
			return
		end

		local people = {}
		for _, v in ipairs(dataSelectResult) do
			local data = util.JSONToTable(v.data)
			if data and data.permits and !table.IsEmpty(data.permits) then
				for k2, v2 in pairs(data.permits) do
					if isnumber(v2) and v2 <= os.time() then
						data.permits[k2] = nil
					end
				end

				if !table.IsEmpty(data.permits) then
					people[v.id] = data
				end
			end
		end

		netstream.Start(client, "CreateActivePermitsDatapad", people)
	end)
	dataSelect:Execute()
end

netstream.Hook("GetActiveShopPermitsDatapad", function(client, appID)
	PLUGIN:GetActiveShopPermits(client, appID)
end)
netstream.Hook("ToggleShopPermitDatapad", function(client, permit, bValue, appID)
	local housing = ix.plugin.Get("housing")
	if !housing then return end
	if housing.apartments[appID].type != "shop" then return client:NotifyLocalized("To nie jest sklep!") end
	housing.apartments[appID].permits[permit] = bValue
	housing:UpdateApartment(appID)
	housing:HandleShopPermitUpdate(appID, permit)
end)
netstream.Hook("GetActivePermitsDatapad", function(client)
	PLUGIN:GetActivePermits(client)
end)

util.AddNetworkString("CreateActiveWagesDatapad")

function PLUGIN:GetActiveWages(client, curCollect)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local dataSelect = mysql:Select("ix_characters_data")
	dataSelect:WhereIn("key", "genericdata")
	dataSelect:Limit(5)
	dataSelect:Offset(curCollect)
	dataSelect:Callback(function(dataSelectResult)
		if (!istable(dataSelectResult) or #dataSelectResult == 0) then return end

		local people = {}
		local loyalists = {}

		for _, v in ipairs(dataSelectResult) do
			if !v.data then continue end
			local data = util.JSONToTable(v.data)

			if !data then continue end
			local wages = data.wages and tonumber(data.wages)

			if isnumber(wages) and wages > 0 then
				people[v.id] = data
			end

			local socialCredits = data.socialCredits and tonumber(data.socialCredits)
			local loyaltyStatus = data.loyaltyStatus and string.lower(data.loyaltyStatus)

			if !data.socialCredits and !data.loyaltyStatus then continue end

			if isnumber(socialCredits) and socialCredits >= 175 then
				loyalists[v.id] = data
			end

			if isstring(loyaltyStatus) and loyaltyStatus != "brak" then
				loyalists[v.id] = data
			end
		end

		net.Start("CreateActiveWagesDatapad")
			net.WriteTable(people)
			net.WriteTable(loyalists)
		net.Send(client)
	end)
	dataSelect:Execute()
end

netstream.Hook("GetActiveWagesDatapad", function(client, curCollect)
	PLUGIN:GetActiveWages(client, curCollect)
end)

netstream.Hook("RemovePermitDatapad", function(client, genericdata, loggedAction)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	if (loggedAction != nil) then
		local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
		ix.combineNotify:AddNotification("NTC:// Dla podmiotu '" .. string.upper(genericdata.name or genericdata.collarID) .. "' " .. (loggedAction == "permit" and "plik danych Zezwolenia" or loggedAction and "Dopłata" or "Status Lojalności") .. " został cofnięty przez " .. string.upper(author), Color(171, 222, 47))
	end

	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetGenericdata(genericdata)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "genericdata")
		queryObj:Update("data", util.TableToJSON(genericdata))
	queryObj:Execute()
end)

netstream.Hook("UpdateDatafileLogs", function(client, id, logs, key, subject)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	if (!client:IsCombineRankAbove("RL") and !client:GetCharacter():HasFlags("L")) then
		client:Notify("Nie możesz usunąć tego logu, ponieważ nie masz wystarczająco wysokiej rangi lub nie nosisz mundur!")

		return false
	end

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()

	ix.combineNotify:AddNotification("NTC:// Plik danych logu '" .. string.upper(subject) .. "' został usunięty przez " .. string.upper(author), Color(171, 222, 47))

	local cachedCharacter = ix.char.loaded[id]
	if (cachedCharacter) then
		cachedCharacter:SetDatafilelogs(logs)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", id)
		queryObj:Where("key", "datafilelogs")
		queryObj:Update("data", util.TableToJSON(logs))
	queryObj:Execute()
end)

netstream.Hook("UpdateDatafileMedical", function(client, id, logs, subject, isFromCMUPDA)
	if (!PLUGIN:HasAccessToDatafile(client) and !isFromCMUPDA) then return end

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Plik danych wpisu 'MEDYCZNE' '" .. string.upper(subject) .. "' został usunięty przez " .. string.upper(author), Color(171, 222, 47))


	local cachedCharacter = ix.char.loaded[id]
	if (cachedCharacter) then
		cachedCharacter:SetDatafilemedicalrecords(logs)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", id)
		queryObj:Where("key", "datafilemedicalrecords")
		queryObj:Update("data", util.TableToJSON(logs))
	queryObj:Execute()
end)

netstream.Hook("UpdateDatafileViolations", function(client, id, logs, subject)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Plik danych wpisu 'WYROCZENIE' '" .. string.upper(subject) .. "' został usunięty przez " .. string.upper(author), Color(171, 222, 47))

	local cachedCharacter = ix.char.loaded[id]
	if (cachedCharacter) then
		cachedCharacter:SetDatafileviolations(logs)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", id)
		queryObj:Where("key", "datafileviolations")
		queryObj:Update("data", util.TableToJSON(logs))
	queryObj:Execute()
end)

netstream.Hook("DatafilePromoteDemote", function(client, id, name)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local cachedCharacter = ix.char.loaded[id]
	if (cachedCharacter) then
		cachedCharacter:SetName(name)
		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			return
		end
	end

	local queryObj = mysql:Update("ix_characters")
		queryObj:Where("id", id)
		queryObj:Update("name", name)
	queryObj:Execute()
end)

function PLUGIN:CreateDatafile(client)
	if (client:IsValid()) then
		local character = client:GetCharacter()
		local geneticAge = character:GetAge() or "N/A"
		local geneticHeight = character:GetHeight() or "N/A"
		local geneticEyecolor = character:GetEyeColor() or "N/A"
		local standardCredits = 50
		local designatedStatus = "N/A"
		local anticitizen = false

		if (string.utf8lower(character:GetBackground()) == "zwolennik") then
			standardCredits = 60
		elseif (string.utf8lower(character:GetBackground()) == "wyrzutek") then
			standardCredits = 35
		elseif (character:GetFaction() == FACTION_CP) then
			standardCredits = 0
		end

		local genericData

		if character:IsVortigaunt() then
			genericData = {
				id = character:GetID(),
				cid = "N/A",
				collarID  = character:GetCollarID() or "N/A",
				cohesionPoints = 0,
				cohesionPointsDate = os.date("%d/%m/%Y"),
				nulled = "NIEAKTYWNY",
				geneticDesc = geneticAge .." | ".. geneticHeight,
				occupation = "N/A",
				occupationDate = os.date("%d/%m/%Y"),
				designatedStatus = designatedStatus,
				designatedStatusDate = os.date("%d/%m/%Y"),
				permits = {},
				bol = false,
				anticitizen = anticitizen,
				combine = false,
				loyaltyStatus = "BRAK",
				wages = 0,
				bypassCommunion = false,
				housing = false,
				shop = false,
			}

			if character:GetBackground() == "Kolaborator" then
				genericData.cid = character:GetCid()
			end
		else
			genericData = {
				id = character:GetID(),
				name = character:GetName(),
				cid  = character:GetCid() or "N/A",
				socialCredits = standardCredits,
				socialCreditsDate = os.time(),
				geneticDesc = geneticAge.." | "..geneticHeight.." | "..geneticEyecolor.." OCZY",
				occupation = "N/A",
				occupationDate = os.date("%d/%m/%Y"),
				designatedStatus = designatedStatus,
				designatedStatusDate = os.date("%d/%m/%Y"),
				permits = {},
				bol = false,
				anticitizen = anticitizen,
				combine = false,
				loyaltyStatus = "BRAK",
				wages = 0,
				bypassCommunion = false,
				housing = false,
				shop = false,
			}
		end

		if ix.faction.Get(client:Team()).isCombineFaction then
			 genericData.combine = true
		end

		if client:IsDispatch() then
			genericData.combine = "overwatch"
		end

		local Timestamp = os.time()

		local defaultLogs = {
			[1] = {
				text = "PRZENIESIONY DO DYSTRYKTU",
				date = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp ),
				poster = "Overwatch",
			},
		}

		local defaultViolations = {}
		local defaultMedicalRecords = {}

		character:SetGenericdata(genericData)
		character:SetDatafilelogs(defaultLogs)
		character:SetDatafileviolations(defaultViolations)
		character:SetDatafilemedicalrecords(defaultMedicalRecords)

		character:SetHasDatafile(true)
		character:Save()
	end
end

netstream.Hook("OpenDatafile", function(client, id, bIsLocal)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	PLUGIN:RefreshDatafile(client, id, bIsLocal, nil, true)
end)

function PLUGIN:EditDatafile(client, genericdata, bBypass, bNoRefresh, action)
	if (!bBypass and !PLUGIN:HasAccessToDatafile(client)) then return end

	if (action) then
		local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
		ix.combineNotify:AddNotification("NTC:// Podmiot '" .. string.upper(genericdata.name or genericdata.collarID) .. "' " .. action .. " przez " .. string.upper(author), Color(171, 222, 47))
	end

	local cachedCharacter = ix.char.loaded[genericdata.id]

	if (cachedCharacter) then
		cachedCharacter:SetGenericdata(genericdata)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()

			if (!bNoRefresh) then
				PLUGIN:RefreshDatafile(client, genericdata.id, nil, true)
			end

			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "genericdata")
		queryObj:Update("data", util.TableToJSON(genericdata))
	queryObj:Execute()

	if (!bNoRefresh) then
		PLUGIN:RefreshDatafile(client, genericdata.cid, nil)
	end
end

netstream.Hook("EditDatafile", function(client, genericdata, action)
	PLUGIN:EditDatafile(client, genericdata, nil, nil, action)
end)

function PLUGIN:AddLog(client, logsTable, genericdata, posterName, points, text, bNoRefresh, bBypass, bGenericNote)
	if (!bBypass and !PLUGIN:HasAccessToDatafile(client)) then return end

	local Timestamp = os.time()

	if (!bNoRefresh or bBypass) then
		logsTable[#logsTable + 1] = {
			text = text,
			date = Timestamp,
			points = points or nil,
			poster = posterName
		}
	end

	if (bGenericNote) then
		local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
		ix.combineNotify:AddNotification("NTC:// Plik danych wpisu 'UWAGA' '" .. string.upper(genericdata.name or genericdata.collarID) .. "' został dodany przez " .. string.upper(author), Color(171, 222, 47))
	end

	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetDatafilelogs(logsTable)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()

			if !bNoRefresh then
				PLUGIN:RefreshDatafile(client, genericdata.id, nil, true)
			end

			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "datafilelogs")
		queryObj:Update("data", util.TableToJSON(logsTable))
	queryObj:Execute()

	if bNoRefresh then return end
	PLUGIN:RefreshDatafile(client, genericdata.cid, nil)
end

netstream.Hook("AddLog", function(client, logsTable, genericdata, posterName, points, text, bNoRefresh, bGenericNote)
	PLUGIN:AddLog(client, logsTable, genericdata, posterName, points, text, bNoRefresh, false, bGenericNote)
end)

netstream.Hook("AddViolation", function(client, violationsTable, genericdata, posterName, text, posterID)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	violationsTable[#violationsTable + 1] = {
		text = text,
		date = os.date("%d/%m/%Y"),
		poster = posterName,
		posterID = posterID
	}

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Plik danych wpisu 'WYKROCZENIE' '" .. string.upper(genericdata.name or genericdata.collarID) .. "' został dodany przez " .. string.upper(author), Color(171, 222, 47))

	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetDatafileviolations(violationsTable)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			PLUGIN:RefreshDatafile(client, genericdata.id, nil, true)
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "datafileviolations")
		queryObj:Update("data", util.TableToJSON(violationsTable))
	queryObj:Execute()

	PLUGIN:RefreshDatafile(client, genericdata.cid, nil)
end)

netstream.Hook("SetWagesDatafile", function(client, genericdata, wages)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	genericdata.wages = wages

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Dopłata '" .. string.upper(genericdata.name or genericdata.collarID) .. "' została zmieniona na " .. wages .. " przez " .. string.upper(author), Color(171, 222, 47))

	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetGenericdata(genericdata)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			PLUGIN:RefreshDatafile(client, genericdata.id, nil, true)
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "genericdata")
		queryObj:Update("data", util.TableToJSON(genericdata))
	queryObj:Execute()

	PLUGIN:RefreshDatafile(client, genericdata.cid, nil)
end)

function PLUGIN:UpdateGenericData(genericdata)
	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetGenericdata(genericdata)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			PLUGIN:RefreshDatafile(false, genericdata.id, nil, true)
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "genericdata")
		queryObj:Update("data", util.TableToJSON(genericdata))
	queryObj:Execute()
end

netstream.Hook("SetLoyalistStatusDatafile", function(client, genericdata, status)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	genericdata.loyaltyStatus = status

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Status Lojalności '" .. string.upper(genericdata.name or genericdata.collarID) .. "' został zaktualizowany na '" .. status .. "' przez " .. string.upper(author), Color(171, 222, 47))

	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetGenericdata(genericdata)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			PLUGIN:RefreshDatafile(client, genericdata.id, nil, true)
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "genericdata")
		queryObj:Update("data", util.TableToJSON(genericdata))
	queryObj:Execute()

	PLUGIN:RefreshDatafile(client, genericdata.cid, nil)
end)

netstream.Hook("SetBypassDatafile", function(client, genericdata, bBypass)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	genericdata.bypassCommunion = bBypass

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Dostęp do komunikatora '" .. string.upper(genericdata.name or genericdata.collarID) .. "' został " .. (bBypass and "włączony" or "wyłączony") .. " przez " .. string.upper(author), Color(171, 222, 47))

	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetGenericdata(genericdata)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			PLUGIN:RefreshDatafile(client, genericdata.id, nil, true)
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "genericdata")
		queryObj:Update("data", util.TableToJSON(genericdata))
	queryObj:Execute()

	PLUGIN:RefreshDatafile(client, genericdata.cid, nil)
end)

netstream.Hook("AddMedicalRecord", function(client, medicalTable, genericdata, posterName, text, isFromCMUPDA)
	if (!PLUGIN:HasAccessToDatafile(client) and !isFromCMUPDA) then return end

	medicalTable[#medicalTable + 1] = {
		text = text,
		date = os.date("%d/%m/%Y"),
		poster = posterName
	}

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Plik danych wpisu 'MEDYCZNE' '" .. string.upper(genericdata.name or genericdata.collarID) .. "' został dodany przez " .. string.upper(author), Color(171, 222, 47))

	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetDatafilemedicalrecords(medicalTable)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			PLUGIN:RefreshDatafile(client, genericdata.id, nil, true)
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "datafilemedicalrecords")
		queryObj:Update("data", util.TableToJSON(medicalTable))
	queryObj:Execute()

	PLUGIN:RefreshDatafile(client, genericdata.cid, nil)
end)

netstream.Hook("SetDatafilePermit", function(client, genericdata, permitsTable)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	genericdata.permits = permitsTable

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Plik danych zezwoleń '" .. string.upper(genericdata.name or genericdata.collarID) .. "' został zaktualizowany przez " .. string.upper(author), Color(171, 222, 47))

	local cachedCharacter = ix.char.loaded[genericdata.id]
	if (cachedCharacter) then
		cachedCharacter:SetGenericdata(genericdata)

		if (IsValid(cachedCharacter:GetPlayer())) then
			cachedCharacter:Save()
			return
		end
	end

	local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", genericdata.id)
		queryObj:Where("key", "genericdata")
		queryObj:Update("data", util.TableToJSON(genericdata))
	queryObj:Execute()
end)

netstream.Hook("GetPersonalNotesDatapad", function(client)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	local character = client:GetCharacter()
	if !character then return end
	local notes = character:GetDatapadnotes()
	if !notes then return end

	netstream.Start(client, "ReplyPersonalNotesDatapad", notes)
end)

netstream.Hook("SavePersonalNotesDatapad", function(client, value)
	local character = client:GetCharacter()
	if !character then return end

	character:SetDatapadnotes(value)
	client:Notify("Zapisano notatki osobiste.")
end)