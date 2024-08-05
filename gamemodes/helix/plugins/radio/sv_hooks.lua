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

function PLUGIN:PlayerDisconnected(client)
	for _, channel in pairs(ix.radio.channels) do
		if (channel.listenersByKeys[client]) then
			local key = channel.listenersByKeys[client]
			channel.listeners[key] = channel.listeners[#channel.listeners]
			channel.listenersByKeys[channel.listeners[key]] = key

			channel.listeners[#channel.listeners] = nil
			channel.listenersByKeys[client] = nil
		end
	end
end

function PLUGIN:PrePlayerLoadedCharacter(client, character, lastChar)
	client:SetLocalVar("radioChannels", {})

	for _, channel in pairs(ix.radio.channels) do
		if (channel.listenersByKeys[client]) then
			local key = channel.listenersByKeys[client]
			channel.listeners[key] = channel.listeners[#channel.listeners]
			channel.listenersByKeys[channel.listeners[key]] = key

			channel.listeners[#channel.listeners] = nil
			channel.listenersByKeys[client] = nil
		end
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	local currChannel = character:GetRadioChannel()
	if (!ix.radio:FindByID(currChannel) or !ix.radio:CharacterHasChannel(character, currChannel)) then
		character:SetRadioChannel("")
	end

	local channels = ix.radio:GetAllChannelsFromChar(character)
	for _, v in ipairs(channels) do
		ix.radio:AddListenerToChannel(client, v)
	end

	if (!character.vars.radioChannels) then
		character.vars.radioChannels = {}
		net.Start("ixRadioChannels")
			net.WriteUInt(character:GetID(), 32)
			net.WriteUInt(#channels, 16)
			for _, v in ipairs(channels) do
				net.WriteString(v)
			end
		net.Send(character:GetPlayer())
	end
end

function PLUGIN:OnItemTransferred(item, oldInv, newInv)
	if (!item.isRadio) then return end
	local oldID, newID = oldInv:GetID(), newInv:GetID()
	if (oldID == newID) then return end

	local oldOwner = oldID != 0 and !oldInv.vars.isStash and oldInv:GetOwner()
	local newOwner = newID != 0 and !newInv.vars.isStash and newInv:GetOwner()
	if (oldOwner and newOwner and oldOwner == newOwner) then return end

	if (oldOwner and IsValid(oldOwner)) then
		if (item.GetChannels) then
			for _, v in ipairs(item:GetChannels(true)) do
				ix.radio:RemoveListenerFromChannel(oldOwner, v)
			end
		elseif (item.GetChannel and item:GetChannel(true)) then
			ix.radio:RemoveListenerFromChannel(oldOwner, item:GetChannel())
		end
	else
		local channel = item.GetChannel and item:GetChannel(true)
		if (channel) then
			ix.radio:CleanStationariesFromChannel(channel)
		end
	end

	if (newOwner and IsValid(newOwner)) then
		if (item.GetChannels) then
			for _, v in ipairs(item:GetChannels()) do
				ix.radio:AddListenerToChannel(newOwner, v)
			end
		elseif (item.GetChannel and item:GetChannel()) then
			ix.radio:AddListenerToChannel(newOwner, item:GetChannel())
		end
	end
end

function PLUGIN:InventoryItemAdded(oldInv, newInv, item)
	if (oldInv or !item.isRadio) then return end

	local newID = newInv:GetID()
	if (newID == 0) then return end

	local newOwner = newInv:GetOwner()
	if (IsValid(newOwner)) then
		if (item.GetChannels) then
			for _, v in ipairs(item:GetChannels()) do
				ix.radio:AddListenerToChannel(newOwner, v)
			end
		elseif (item.GetChannel and item:GetChannel()) then
			ix.radio:AddListenerToChannel(newOwner, item:GetChannel())
		end
	end
end