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

local datafields = {"genericdata", "datafilelogs", "datafileviolations", "datafilemedicalrecords"}

function PLUGIN:SendFile(client, file)
	timer.Simple(0.05, function()
		netstream.Start(client, "OpenDatafileCl", file)
	end)
end

-- Include new required data to datafiles of old characters
function PLUGIN:UpdateOldVortData(character, genericdata)
	if (!character or !istable(genericdata)) then return end

	genericdata.collarID  = character:GetCollarID() or "N/A"
	genericdata.cohesionPoints = genericdata.socialCredits or 0
	genericdata.cohesionPointsDate = ix.config.Get("day").."/"..ix.config.Get("month").."/"..ix.config.Get("year")
	genericdata.nulled = "NIEAKTYWNY"
	genericdata.cid = "N/A"
	genericdata.name = nil

	if (character:HasFlags("N") or character:GetBackground() == "Kolaborator") then
		genericdata.nulled = "AKTYWNY"
	end

	for _, v in pairs(character:GetInventory():GetItems()) do
		if (table.HasValue({"Obroża Vortigaunta", "Obroża Vortigaunta (fałszywa)"}, v.name) and v:GetData("equip") == true) then
			if (v:GetData("collarID", nil) and v:GetData("sterilizedCredits", nil)) then
				genericdata.cohesionPoints = v:GetData("sterilizedCredits", 0)
			end
		end
	end

	character:SetGenericdata(genericdata)
	character:Save()

	character:GetPlayer():Notify("Nowy format został pomyślnie zastosowany dla twojego pliku danych.")
end

-- Search the collarID through the database
function PLUGIN:LookUpCollarID(client, id, bNotify)
	if (!client or !id) then return end

	id = string.sub(id, 2)

	local query = mysql:Select("ix_characters")
	query:Select("name")
	query:Select("faction")
	query:Select("id")
	query:Select("collarID")
	query:Select("background")
	query:Where("collarID", id)
	query:Where("schema", Schema and Schema.folder or "helix")
	query:Callback(function(result)
		if (!istable(result) or #result == 0) then
			return
		end

		local resultFactionString = result[1].faction

		if (resultFactionString != "vortigaunt") then
			return
		end

		local dataSelect = mysql:Select("ix_characters_data")
		dataSelect:Where("id", result[1].id)
		dataSelect:WhereIn("key", datafields)
		dataSelect:Callback(function(dataSelectResult)
			if (!istable(dataSelectResult) or #dataSelectResult == 0) then
				return
			end

			local file = {}
			for _, v in ipairs(dataSelectResult) do
				file[v.key] = util.JSONToTable(v.data or "")
				file["charID"] = result[1].id

				if (v.key == "genericdata") then
					if file[v.key].name != result[1].name then
						file[v.key].name = result[1].name

						local updateQuery = mysql:Update("ix_characters_data")
						updateQuery:Update("data", util.TableToJSON(file[v.key]) or "")
						updateQuery:Where("id", result[1].id)
						updateQuery:Where("key", "genericdata")
						updateQuery:Execute()
					end
				end
			end

			if (bNotify) then
				local author = client:IsDispatch() and "OVERWATCH" or (ix.faction.Get(client:Team()).idInspectionText or "Unit") .. " " .. string.upper(client:GetCombineTag())

				ix.combineNotify:AddNotification("LOG:// " .. author .. " przeprowadza inspekcję tożsamości na " .. string.upper("zasobie biotycznym:") .. " #" .. result[1].collarID)
			end

			self:SendFile(client, file)
		end)
		dataSelect:Execute()

	end)
	query:Execute()
end

function PLUGIN:RefreshDatafile(client, id, bIsLocal, bCachedID, bNotify)
	if !client then return end

	if (client:Team() == FACTION_SERVERADMIN) then
		bNotify = false
	end

	--If the player is trying to view his/her own datafile
	if (bIsLocal) then
		local character = client:GetCharacter()
		local file = {}

		file["genericdata"] = character:GetGenericdata()
		file["datafileviolations"] = character:GetDatafileviolations()
		file["datafilemedicalrecords"] = character:GetDatafilemedicalrecords()
		file["datafilelogs"] = character:GetDatafilelogs()
		file["charID"] = character:GetID()

		if character:IsVortigaunt() and !file["genericdata"].cohesionPoints then
			self:UpdateOldVortData(character, file["genericdata"])
		end

		self:SendFile(client, file)

		return
	end

	local target = false

	if (bCachedID) then
		if isnumber(tonumber(id)) then
			if ix.char.loaded[id] then
				target = ix.char.loaded[id]
			end
		end
	end

	if !target then
		-- Check for cached characters
		if (tonumber(id) != nil and string.utf8len(tostring(id)) <= 5) then
			-- id to cid comparison
			for _, v in pairs(ix.char.loaded) do
				local cid = v.GetCid and v:GetCid()
				local genericdata = v:GetGenericdata()

				if (v:IsVortigaunt() and v:GetCid() == id and genericdata.cid == "N/A") then return end

				if (cid and id) then
					if (tostring(cid) == id) then
						target = v
						break
					end
				end
			end
		elseif (id != nil and string.sub(id, 1, 1) == "!") then
			id = string.sub(id, 2)

			for _, v in pairs(ix.char.loaded) do
				if (v:IsVortigaunt() and v:GetCollarID() == id) then
					target = v
					break
				end
			end
		else
			-- id to name comparison
			for _, v in pairs(ix.char.loaded) do
				local genericdata = v:GetGenericdata()

				if string.find(v:GetName(), id) then
					if (v:IsVortigaunt() and genericdata.cid == "N/A") then return end

					target = v
					break
				end
			end
		end
	end

    -- Make sure further code isn't ran
    if target then
        local file = {}
        file["genericdata"] = target:GetGenericdata()
        file["datafileviolations"] = target:GetDatafileviolations()
        file["datafilemedicalrecords"] = target:GetDatafilemedicalrecords()
        file["datafilelogs"] = target:GetDatafilelogs()
		file["charID"] = target:GetID()

		if (target:IsVortigaunt() and !file["genericdata"].cohesionPoints) then
			self:UpdateOldVortData(target, file["genericdata"])
		end

		if (bNotify) then
			local author = client:IsDispatch() and "OVERWATCH" or (ix.faction.Get(client:Team()).idInspectionText or "Unit") .. " " .. string.upper(client:GetCombineTag())

			if (target:IsVortigaunt()) then
				if (file["genericdata"].cid == "N/A" and file["genericdata"].collarID != "N/A") then
					ix.combineNotify:AddNotification("LOG:// " .. author .. " performing identity inspection on " .. string.upper("biotic asset collar:") .. " #" .. target:GetCollarID())
				elseif (file["genericdata"].cid == "N/A" and file["genericdata"].collarID == "N/A") then
					ix.combineNotify:AddNotification("LOG:// " .. author .. " performing identity inspection on " .. string.upper("biotic asset collar:") .. " #" .. target:GetFakeCollarID())
				else
					ix.combineNotify:AddNotification("LOG:// " .. author .. " przeprowadza inspekcję tożsamości na " .. string.upper("zasobie biotycznym o identyfikatorze:") .. " #" .. file["genericdata"].cid)
				end
			else
				ix.combineNotify:AddNotification("LOG:// " .. author .. " przeprowadza inspekcję tożsamości na '" .. string.upper(target:GetName()) .. "', #" .. target:GetCid())
			end
		end

        self:SendFile(client, file)
        return
    end

	-- If no cached character, search in datafile
	if (tonumber(id) != nil and string.utf8len( id ) <= 5) then
		local query = mysql:Select("ix_characters")
		query:Select("name")
		query:Select("faction")
		query:Select("id")
		query:Select("cid")
		query:Select("background")
		query:Where("cid", id)
		query:Where("schema", Schema and Schema.folder or "helix")
		query:Callback(function(result)
			if (!istable(result) or #result == 0) then
				return
			end

			local resultFactionString = result[1].faction
			if (resultFactionString == "overwatch" and client:Team() != FACTION_OVERWATCH) then
				client:NotifyLocalized("Nie masz dostępu do tego pliku danych!")
				return false
			end
			if (resultFactionString == "ota" or resultFactionString == "administrator" or resultFactionString == "guard") then
				local character = client:GetCharacter()
				if (client:Team() != FACTION_OVERWATCH and client:Team() != FACTION_OTA and character:GetClass() != FACTION_MCP and client:Team() != CLASS_CP_CMD and character:GetClass() != CLASS_CP_CPT and character:GetClass() != CLASS_CP_RL) then
					if client:Team() != FACTION_ADMIN then
						client:NotifyLocalized("Nie masz dostępu do tego pliku danych!")
						return false
					end
				end
			end

			local dataSelect = mysql:Select("ix_characters_data")
			dataSelect:Where("id", result[1].id)
			dataSelect:WhereIn("key", datafields)
			dataSelect:Callback(function(dataSelectResult)
				if (!istable(dataSelectResult) or #dataSelectResult == 0) then
					return
				end

				local file = {}
				for _, v in ipairs(dataSelectResult) do
					file[v.key] = util.JSONToTable(v.data or "")
					file["charID"] = result[1].id

					if (v.key == "genericdata") then
						if (resultFactionString == "vortigaunt" and util.JSONToTable(v.data).cid == "N/A") then return end

						if file[v.key].name != result[1].name then
							file[v.key].name = result[1].name

							local updateQuery = mysql:Update("ix_characters_data")
							updateQuery:Update("data", util.TableToJSON(file[v.key]) or "")
							updateQuery:Where("id", result[1].id)
							updateQuery:Where("key", "genericdata")
							updateQuery:Execute()
						end
					end
				end

				if (bNotify) then
					local author = client:IsDispatch() and "OVERWATCH" or (ix.faction.Get(client:Team()).idInspectionText or "Unit") .. " " .. string.upper(client:GetCombineTag())

					ix.combineNotify:AddNotification("LOG:// " .. author .. " przeprowadza inspekcję tożsamości na '" .. string.upper(result[1].name) .. "', #" .. result[1].cid)
				end

				self:SendFile(client, file)
			end)
			dataSelect:Execute()

		end)
		query:Execute()
	else
		if (string.sub(id, 1, 1) == "!") then
			self:LookUpCollarID(client, id, bNotify)
		end

		local query = mysql:Select("ix_characters")
		query:Select("id")
		query:Select("name")
		query:Select("faction")
		query:Select("background")
		query:Select("cid")
		query:WhereLike("name", id)
		query:Where("schema", Schema and Schema.folder or "helix")
		query:Callback(function(result)
			if (!istable(result) or #result == 0) then
				return
			end

			local resultFactionString = result[1].faction
			if (resultFactionString == "overwatch" and client:Team() != FACTION_OVERWATCH) then
				client:NotifyLocalized("Nie masz dostępu do tego pliku danych!")
				return false
			end
			if (resultFactionString == "ota" or resultFactionString == "administrator" or resultFactionString == "guard") then
				local character = client:GetCharacter()
				if (client:Team() != FACTION_OVERWATCH and client:Team() != FACTION_OTA and character:GetClass() != FACTION_MCP and client:Team() != CLASS_CP_CMD and character:GetClass() != CLASS_CP_CPT and character:GetClass() != CLASS_CP_RL) then
					if client:Team() != FACTION_ADMIN then
						client:NotifyLocalized("Nie masz dostępu do tego pliku danych!")
						return false
					end
				end
			end

			local dataSelect = mysql:Select("ix_characters_data")
			dataSelect:Where("id", result[1].id)
			dataSelect:WhereIn("key", datafields)
			dataSelect:Callback(function(dataSelectResult)
				if (!istable(dataSelectResult) or #dataSelectResult == 0) then
					return
				end

				local file = {}
				for _, v in ipairs(dataSelectResult) do
					file[v.key] = util.JSONToTable(v.data or "")
					file["charID"] = result[1].id

					if (v.key == "genericdata") then
						if (resultFactionString == "vortigaunt" and util.JSONToTable(v.data).cid == "N/A") then return end

						if file[v.key].name != result[1].name then
							file[v.key].name = result[1].name

							local updateQuery = mysql:Update("ix_characters_data")
							updateQuery:Update("data", util.TableToJSON(file[v.key]) or "")
							updateQuery:Where("id", result[1].id)
							updateQuery:Where("key", "genericdata")
							updateQuery:Execute()
						end
					end
				end

				if (bNotify) then
					local author = client:IsDispatch() and "OVERWATCH" or (ix.faction.Get(client:Team()).idInspectionText or "Unit") .. " " .. string.upper(client:GetCombineTag())

					ix.combineNotify:AddNotification("LOG:// " .. author .. " przeprowadza inspekcję tożsamości na '" .. string.upper(result[1].name) .. "', #" .. result[1].cid)
				end
				self:SendFile(client, file)
			end)
			dataSelect:Execute()

		end)
		query:Execute()
	end
end

netstream.Hook("RequestCIDCreditsDatafile", function(client, cid)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	cid = Schema:ZeroNumber(cid, 5)
	local housing = ix.plugin.list["housing"]
	if !housing then return end

	housing:LookUpCardItemIDByCID(tostring(cid), function(result)
		local idCardID = result[1].idcard or false
		if !result then return end

		if !ix.item.instances[idCardID] then
			ix.item.LoadItemByID(idCardID, false, function(item)
				if !item then return end
				local credits = item:GetData("credits", 0)
				netstream.Start(client, "UpdateDatafileCredits", credits)
			end)
		else
			local credits = ix.item.instances[idCardID]:GetData("credits", 0)
			netstream.Start(client, "UpdateDatafileCredits", credits)
		end
	end)
end)

netstream.Hook("ixDatafileRequestTransactionLogs", function(client, cid)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end
	cid = Schema:ZeroNumber(cid, 5)

	ix.plugin.list.cid:SelectTransactions(client, "cid", cid, ix.config.Get("TransactionLogDaysDatafile", 14), nil, function(result)
		netstream.Start(client, "ixDatafileReplyTransactionLogs", result)
	end)
end)

netstream.Hook("TerminalReportCrime", function(client, name, cid, text, activeTerminal)
	if !text or !name or !cid then return false end
	if string.len(text) <= 0 then client:Notify("Nie możesz wysłać pustego zgłoszenia.") return end
	if cid != activeTerminal.activeCID then
		return false
	end

	local timestamp = ix.date.GetFormatted("%d.%m.%Y")
	local queryObj = mysql:Insert("ix_crimereports")
		queryObj:Insert("message_poster", name)
		queryObj:Insert("message_text", text)
		queryObj:Insert("message_date", timestamp)
		queryObj:Insert("message_cid", cid)
	queryObj:Execute()

	ix.combineNotify:AddImportantNotification("WRN:// Zgłoszenie złożone przez " .. name .. " #" .. cid, Color(0, 150, 255), client, activeTerminal:GetPos())
end)

function PLUGIN:GetCrimeReports(client, bArchived, bResolved, curCollect)

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

		local toSort = {}

		for key, _ in pairs(result) do
			local posterIsTable = string.find(result[key].message_poster, "{")
			if posterIsTable then result[key].message_poster = util.JSONToTable(result[key].message_poster) end

			if posterIsTable or (bArchived or bResolved) then
				if bArchived and result[key].message_poster.archived then
					toSort[#toSort + 1] = result[key]

					continue
				end

				if bResolved and result[key].message_poster.resolved then
					toSort[#toSort + 1] = result[key]

					continue
				end

				continue
			end

			toSort[#toSort + 1] = result[key]
		end

		local toSend = {}
		for i = curCollect, curCollect + 5 do
			if toSort[i] then
				toSend[#toSend + 1] = toSort[i]
			end
		end

		netstream.Start(client, "ReplyCrimeReports", toSend)
	end)

    query:Execute()
end

netstream.Hook("GetCrimeReports", function(client, bArchived, bResolved, curCollect)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	PLUGIN:GetCrimeReports(client, bArchived, bResolved, curCollect)
end)

netstream.Hook("DeleteCrimeReport", function(client, key, bDatapad, lastUsedTab, curCollect)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local queryObj = mysql:Delete("ix_crimereports")
		queryObj:Where("message_id", key)
	queryObj:Execute()

	PLUGIN:GetCrimeReports(client, (lastUsedTab == "archived" and true or false), (lastUsedTab == "resolved" and true or false), curCollect)
end)

netstream.Hook("ResolveCrimeReport", function(client, key, poster, bUnResolve, lastUsedTab, curCollect)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Zgłoszenie o ID #" .. key .. " zostało uznane za " .. (bUnResolve and "nierozwiązane" or "rozwiązane") .. " przez " .. string.upper(author), Color(171, 222, 47))

	local queryObj = mysql:Update("ix_crimereports")
		queryObj:Where("message_id", key)
		queryObj:Update("message_poster", util.TableToJSON({poster = (istable(poster) and poster.poster or poster), resolved = (!bUnResolve and true or false), archived = (istable(poster) and poster.archived or false)}))
	queryObj:Execute()

	PLUGIN:GetCrimeReports(client, (lastUsedTab == "archived" and true or false), (lastUsedTab == "resolved" and true or false), curCollect)
end)

netstream.Hook("ArchiveCrimeReport", function(client, key, poster, bUnArchive, lastUsedTab, curCollect)
	if (!PLUGIN:HasAccessToDatafile(client)) then return end

	local author = client:IsDispatch() and "Overwatch" or client:GetCombineTag()
	ix.combineNotify:AddNotification("NTC:// Zgłoszenie o ID #" .. key .. (bUnArchive and " odarchiwizowano" or " zarchiwizowano") .. " przez " .. string.upper(author), Color(171, 222, 47))

	local queryObj = mysql:Update("ix_crimereports")
		queryObj:Where("message_id", key)
		queryObj:Update("message_poster", util.TableToJSON({poster = (istable(poster) and poster.poster or poster), resolved = (istable(poster) and poster.resolved or false), archived = (!bUnArchive and true or false)}))
	queryObj:Execute()

	PLUGIN:GetCrimeReports(client, (lastUsedTab == "archived" and true or false), (lastUsedTab == "resolved" and true or false), curCollect)
end)

netstream.Hook("ResetDatafileToDefault", function(client, charID)
	if !CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands") then return end
	local character = ix.char.loaded[charID]
	if !character then
		client:NotifyLocalized("Właściciel postaci musi być online, aby reset zadziałał.")
		return
	end

	local player = character:GetPlayer()
	if !player then return end

	PLUGIN:CreateDatafile(player)
end)