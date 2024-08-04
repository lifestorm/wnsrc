--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:PostPlayerSay(client, chatType, message, anonymous)
	local entity = client:GetEyeTraceNoCursor().Entity
	if (entity:GetClass() != "ix_intercom") then return end

	if (entity:GetPos():DistToSqr(client:GetPos()) > 9000) then return end

	local channelID = entity:GetChannel()
	if (!channelID or channelID == "") then return end

	local channel = ix.radio.channels[channelID]
	if (!channel) then return end

	local listeners = table.Copy(channel.listeners)
	local radioType = ix.radio.types.talk
	
	if (chatType == "w") then
		radioType = ix.radio.types.whisper
	elseif (chatType == "y") then
		radioType = ix.radio.types.yell
	end

	listeners[#listeners + 1] = client

	client:EmitSound("willardnetworks/radio/handheld/handheld" .. math.random(1, 4) .. ".wav")
	ix.chat.Send(client, "radio", message, false, listeners, {channel = channelID, radioType = radioType})
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_intercom", true, true, true, {
		OnSave = function(entity, data)
			data.channel = entity:GetChannel() or ""
		end,
		OnRestore = function(entity, data)
			entity:SetChannel(data.channel or "")
		end
	})
end
