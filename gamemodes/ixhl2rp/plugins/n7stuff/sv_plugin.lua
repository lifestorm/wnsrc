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

util.AddNetworkString("ixDataFilePDA_CWU_Open")
util.AddNetworkString("ixDataFilePDA_CWU_RequestData")
util.AddNetworkString("ixDataFilePDA_CWU_CheckData")
util.AddNetworkString("ixDataFilePDA_CMU_Open")
util.AddNetworkString("ixDataFilePDA_CMU_RequestData")
util.AddNetworkString("ixDataFilePDA_CMU_CheckData")

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("wn_scaffold", true, true, true, {
		OnSave = function(entity, data) --OnSave
			data.motion = false
			data.materials = entity.items
		end,
		OnRestore = function(entity, data) --OnRestore
			entity:SetSolid(SOLID_VPHYSICS)
			entity:PhysicsInit(SOLID_VPHYSICS)

			entity.items = data.materials or 0
			entity:SetNWInt("ItemsRequired", data.materials or 0)
		end,
	})
end

-- Include new required data to datafiles of old characters
function PLUGIN:UpdateOldVortData(character, genericdata)
	if (!character or !istable(genericdata)) then return end

	genericdata.collarID  = character:GetCollarID() or "N/A"
	genericdata.cohesionPoints = genericdata.socialCredits or 0
	genericdata.cohesionPointsDate = ix.config.Get("day").."/"..ix.config.Get("month").."/"..ix.config.Get("year")
	genericdata.nulled = "INACTIVE"
	genericdata.cid = "N/A"

	if (character:HasFlags("N") or character:GetBackground() == "Collaborator") then
		genericdata.nulled = "ACTIVE"
	end

	for _, v in pairs(character:GetInventory():GetItems()) do
		if (table.HasValue({"Vortigaunt Collar", "Vortigaunt Collar (fake)"}, v.name) and v:GetData("equip") == true) then
			if (v:GetData("collarID", nil) and v:GetData("sterilizedCredits", nil)) then
				genericdata.cohesionPoints = v:GetData("sterilizedCredits", 0)
			end
		end
	end

	character:SetGenericdata(genericdata)
	character:Save()

	character:GetPlayer():Notify("New format successfully applied to your datafile.")
end

function PLUGIN:CheckNotifyUpdate(author, character, data)
	if (character:IsVortigaunt()) then
		if (data.cid == "N/A") then
			ix.combineNotify:AddNotification("LOG:// " .. author .. " performing identity inspection on " .. string.upper("biotic asset collar:") .. " #" .. character:GetCollarID())
		else
			ix.combineNotify:AddNotification("LOG:// " .. author .. " performing identity inspection on " .. string.upper("biotic asset identification card:") .. " #" .. data.cid)
		end
	else
		ix.combineNotify:AddNotification("LOG:// " .. author .. " performing identity inspection on '" .. string.upper(data.name) .. "', #" .. data.cid)
	end
end

local function SendDatabaseAnswer(client, data, status, cmu, noNotif)
	data = data or {}

	if (!cmu) then
		data.status = status
	end

	if ((!status or status[2] != "Error") and !noNotif) then
		local author = client:IsDispatch() and "OVERWATCH" or (ix.faction.Get(client:Team()).idInspectionText or "Unit") .. " " .. string.upper(client:GetCombineTag())

		for k, v in ipairs(ix.char.loaded) do
			if (cmu and data.genericData and v:GetID() == data.genericData.id) then
				PLUGIN:CheckNotifyUpdate(author, v, data.genericData)
			elseif (!cmu and data.cid and v:GetID() == data.id) then
				PLUGIN:CheckNotifyUpdate(author, v, data)
			end
		end
	end
	
	local json = util.TableToJSON(data)
	local compressed = util.Compress(json)
	local length = compressed:len()

	net.Start("ixDataFilePDA_" .. (cmu and "CMU" or "CWU") .. "_CheckData")
		net.WriteUInt(length, 32)
		net.WriteData(compressed, length)
	net.Send(client)
end

net.Receive("ixDataFilePDA_CWU_RequestData", function(length, client)
	local text = net.ReadString()

	local query = mysql:Select("ix_characters")
		query:Select("name")
		query:Select("faction")
		query:Select("id")
		query:Select("cid")
		query:Where("schema", Schema and Schema.folder or "helix")
		if tonumber(text) then
			query:Where("cid", text)
		else
			query:Where("name", text)
		end

		query:Callback(function(result)
			if (!istable(result) or #result == 0) then
				return SendDatabaseAnswer(client, nil, { L("pdaDatafile_notFound", client), "Error" })
			end

			result = result[1]

			if client:GetCharacter():GetGenericdata().cid != result.cid then
				if (result.faction == "vortigaunt") then
					return SendDatabaseAnswer(client, nil, { L("pdaDatafile_noAccess", client), "Error" })
				end
			end

			local dataSelect = mysql:Select("ix_characters_data")
			dataSelect:Where("id", result.id)
			dataSelect:WhereIn("key", "genericdata")
			dataSelect:Callback(function(dataSelectResult)
				if (!istable(dataSelectResult) or #dataSelectResult == 0) then
					return SendDatabaseAnswer(client, nil, { L("pdaDatafile_notFound", client), "Error" })
				end

				dataSelectResult = dataSelectResult[1]
				SendDatabaseAnswer(client, util.JSONToTable(dataSelectResult.data), { result.name .." | #"..result.cid, "Success" })
			end)
			dataSelect:Execute()
		end)
	query:Execute()
end)

net.Receive("ixDataFilePDA_CMU_RequestData", function(length, client)
	local text = net.ReadString()
	local noNotif = net.ReadBool()
	
	local query = mysql:Select("ix_characters")
		query:Select("name")
		query:Select("faction")
		query:Select("id")
		query:Select("cid")
		query:Where("schema", Schema and Schema.folder or "helix")
		if tonumber(text) then
			query:Where("cid", text)
		else
			query:Where("name", text)
		end

		query:Callback(function(result)
			if (!istable(result) or #result == 0) then
				return SendDatabaseAnswer(client, nil, nil, true)
			end

			result = result[1]

			if client:GetCharacter():GetGenericdata().cid != result.cid then
				if (result.faction != "citizen") then
					return SendDatabaseAnswer(client, nil, nil, true)
				end
			end

			local dataSelect = mysql:Select("ix_characters_data")
			dataSelect:Where("id", result.id)
			dataSelect:WhereIn("key", "genericdata")
			dataSelect:Callback(function(genericDataResult)
				if (!istable(genericDataResult) or #genericDataResult == 0) then
					return SendDatabaseAnswer(client, nil, nil, true)
				end

				genericDataResult = genericDataResult[1]

				local dataSelect = mysql:Select("ix_characters_data")
				dataSelect:Where("id", result.id)
				dataSelect:WhereIn("key", "datafilemedicalrecords")
				dataSelect:Callback(function(medicalRecordsResult)
					if (!istable(medicalRecordsResult) or #medicalRecordsResult == 0) then
						return SendDatabaseAnswer(client, nil, nil, true)
					end

					medicalRecordsResult = medicalRecordsResult[1]

					local finalResult = {
						genericData = util.JSONToTable(genericDataResult.data),
						medicalRecords = util.JSONToTable(medicalRecordsResult.data),
					}

					SendDatabaseAnswer(client, finalResult, nil, true, noNotif)
				end)
				dataSelect:Execute()
			end)
			dataSelect:Execute()
		end)
	query:Execute()
end)
