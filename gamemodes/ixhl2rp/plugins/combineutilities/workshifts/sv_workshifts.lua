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

function PLUGIN:StartWorkshift()
	SetNetVar("WorkshiftStarted", true)
end

function PLUGIN:StopWorkshift(ent)
	ent.workshiftPaused = ent.workshiftPaused or false
	ent.savedInfo = ent.savedInfo or {}
	ent.workshiftStarted = false
	ent.workshiftPaused = false
	ent.participants = {}
	ent.savedInfo = {}
	ent:ResetInfo()
	ent:SetDisplay(9)
	ent:EmitSound("ambient/machines/combine_terminal_idle2.wav")
end

function PLUGIN:EndWorkshift(tSaved, client)
	local character = client:GetCharacter()
	local datafields = {"genericdata", "datafilelogs"}

	if tSaved and istable(tSaved) and !table.IsEmpty(tSaved) then
		for genericID, tInfo in pairs(tSaved) do
			local coupon = tInfo.coupon or false
			local points = tInfo.points or 0

			local dataSelect = mysql:Select("ix_characters_data")
			dataSelect:Where("id", genericID)
			dataSelect:WhereIn("key", datafields)
			dataSelect:Callback(function(dataSelectResult)
				if (!istable(dataSelectResult) or #dataSelectResult == 0) then
					return
				end

				local file = {}
				for _, v in ipairs(dataSelectResult) do
					file[v.key] = util.JSONToTable(v.data or "")
				end

				local limitCount = 0

				for _, v in pairs(file["datafilelogs"]) do
					if !v.points then
						continue
					end

					if isnumber(v.date) and os.date("%d/%m/%Y", v.date) == os.date("%d/%m/%Y") then
						limitCount = limitCount + v.points
					end
				end

				if ((points + limitCount) > 20 or (points + limitCount) < -20) then
					PLUGIN:AddLog(client, file["datafilelogs"], file["genericdata"], client:Name(), 0, "Finished Workshift", true, true)
				else
					if (file["genericdata"].cohesionPoints) then
						file["genericdata"].cohesionPoints = !file["genericdata"].combine and math.Clamp(file["genericdata"].cohesionPoints + points, 0, 200) or file["genericdata"].cohesionPoints + points
						file["genericdata"].cohesionPointsDate = os.time()
					else
						file["genericdata"].socialCredits = !file["genericdata"].combine and math.Clamp(file["genericdata"].socialCredits + points, 0, 200) or file["genericdata"].socialCredits + points
						file["genericdata"].socialCreditsDate = os.time()
					end

					PLUGIN:AddLog(client, file["datafilelogs"], file["genericdata"], client:Name(), points, "Finished Workshift", true, true)
					PLUGIN:EditDatafile(client, file["genericdata"], true, true)
				end

				local couponCharacter = ix.char.loaded[genericID]

				if couponCharacter and coupon != false then
					if coupon == "PODSTAWOWY" then
						couponCharacter:SetPurchasedItems("coupon_basic", 1)
					elseif coupon == "ŚREDNI" then
						couponCharacter:SetPurchasedItems("coupon_medium", 1)
					else
						couponCharacter:SetPurchasedItems("coupon_priority", 1)
					end
				end
			end)
			dataSelect:Execute()
		end
	end

	SetNetVar("WorkshiftStarted", false)
end

function PLUGIN:PauseWorkshift(ent, client, bPaused)
	ent.workshiftPaused = bPaused
end

function PLUGIN:SaveWorkshift(tSaved, ent)
	ent.savedInfo = tSaved
end

function PLUGIN:CheckStartedWorkshift(ent)
	if ent.workshiftStarted then return true end

	return false
end

function PLUGIN:AddToWorkshift(client, idCard, genericData, ent)
	if ent.workshiftPaused then
		ent:SetDisplay(11)
		ent:ReadyForAnother()
		return false
	end

	if ent.participants[genericData.id] then
		ent:AlreadyParticipated()
		ent:ResetInfo()
		return false
	end

	ent.participants[genericData.id] = {genericData.cid, genericData.name}

	local pointsToday = 0
	local queryObj = mysql:Select("ix_characters_data")
		queryObj:Where("id", genericData.id)
		queryObj:Where("key", "datafilelogs")
		queryObj:Select("data")
		queryObj:Callback(function(result)
			if (!istable(result) or !result[1]) then return end
			if !result[1].data then return end

			for _, tLog in pairs(util.JSONToTable(result[1].data)) do
				if tLog.points and tLog.points != 0 and tLog.date and isnumber(tLog.date) and os.date("%d/%m/%Y", tLog.date) == os.date("%d/%m/%Y") then
					pointsToday = pointsToday + tLog.points
				end
			end

			ent.participants[genericData.id][3] = pointsToday
		end)
	queryObj:Execute()
end