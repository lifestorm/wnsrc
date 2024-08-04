--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function Schema:CanPlayerUseBusiness(client, uniqueID)
	if (client:Team() == FACTION_CITIZEN or client:Team() == FACTION_WORKERS) then
		local itemTable = ix.item.list[uniqueID]

		if (itemTable) then
			if (itemTable.permit) then
				local character = client:GetCharacter()
				local inventory = character:GetInventory()

				if (!inventory:HasItem("permit_"..itemTable.permit)) then
					return false
				end
			elseif (itemTable.base ~= "base_permit") then
				return false
			end
		end
	end
end

function Schema:CanPlayerViewObjectives(client)
	return client:HasActiveCombineSuit() or client:IsDispatch()
end

function Schema:CanPlayerEditObjectives(client)
	if (!client:HasActiveCombineSuit() and !client:IsDispatch()) then
		return false
	end

	return client:IsCombineRankAbove("RL")
end

function Schema:CanDrive()
	return false
end

function Schema:SetupAreaProperties()
	ix.area.AddProperty("combineText", ix.type.string, "")
	ix.area.AddProperty("dispatchsound", ix.type.string, "")
end

function Schema:InitializedChatClasses()
	ix.chat.Register("ic", {
		format = " \"%s\"",
		icon = "willardnetworks/chat/message_icon.png",
		indicator = "chatTalking",
		GetColor = function(self, speaker, text)
			-- If you are looking at the speaker, make it greener to easier identify who is talking.
			if (LocalPlayer():GetEyeTrace().Entity == speaker) then
				return ix.config.Get("chatListenColor")
			end

			-- Otherwise, use the normal text color.
			return color_white
		end,
		GetICChatAlpha = function(self, speaker)
			-- alpha based on spkr distance
			local minAlpha = 55
			local maxAlpha = 255

			if (!speaker or !speaker.GetPos or !LocalPlayer().GetPos) then
				return maxAlpha
			end

			local maxDistSqr = ix.config.Get("chatRange", 280)
			maxDistSqr = maxDistSqr * maxDistSqr

			local spkrPos = speaker:GetPos()
			if (!spkrPos or !isvector(spkrPos) or !spkrPos.DistToSqr) then
				return maxAlpha
			end

			local distToSpkrSqr = spkrPos:DistToSqr(LocalPlayer():GetPos())
			if (!distToSpkrSqr or !isnumber(distToSpkrSqr)) then
				return maxAlpha
			end

			-- normalizing
			local normal = (distToSpkrSqr - 1) * (maxAlpha - minAlpha) / (maxDistSqr - 1)
			return math.Clamp(math.ceil(maxAlpha - normal), minAlpha, maxAlpha)
		end,
		OnChatAdd = function(self, speaker, text, anonymous, info)
			local chatTextColor = self:GetColor(speaker, text, info)
			local chatTextAlpha = 255
			local name = anonymous and
				L"someone" or hook.Run("GetCharacterName", speaker, "ic") or
				(IsValid(speaker) and speaker:Name() or "Console")

			local translated = L2("icWNFormat", text)
			local bToYou = speaker and IsValid(speaker) and speaker:GetEyeTraceNoCursor().Entity == LocalPlayer()
			local oldFont = self.font 
			local font = hook.Run("GetSpeakerFont", speaker)

			self.font = font

			if (speaker ~= LocalPlayer()) then
				-- no reason to do this on the local player. comes out to 255 anyways (cuz my code is so good. SKILLZ)
				chatTextAlpha = self:GetICChatAlpha(speaker) or 255
			end

			if self.icon and ix.option.Get("standardIconsEnabled") then
				chat.AddText(ix.util.GetMaterial(self.icon), Color(255, 254, 153, chatTextAlpha), name, " says", bToYou and " (to you)" or "", ColorAlpha(chatTextColor, chatTextAlpha), translated or string.format(self.format, text))
			else
				chat.AddText(Color(255, 254, 153, chatTextAlpha), name, " says", bToYou and " (to you)" or "", ColorAlpha(chatTextColor, chatTextAlpha), translated or string.format(self.format, text), Color(255, 254, 153, 255), "")
			end
			self.font = oldFont
		end,
		CanHear = ix.config.Get("chatRange", 280)
	})
end

function Schema:InitializedPlugins()
	if (ix.plugin.list.inventoryslosts and FACTION_OVERWATCH) then
		ix.plugin.list.inventoryslots.noEquipFactions[FACTION_OVERWATCH] = true
	end
end
