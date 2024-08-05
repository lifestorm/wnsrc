--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local netstream = netstream
local CAMI = CAMI
local ix = ix
local math = math
local util = util
local IsValid = IsValid
local CurTime = CurTime
local istable = istable
local Color = Color
local string = string

local PLUGIN = PLUGIN

--Honeypot netstream hook, overwrite unsecure hook in sh_id_card.lua
netstream.Hook("ixSetIDCardCredits", function(client, itemID, amount)
	local bNoAccess = !CAMI.PlayerHasAccess(client, "Helix - Set Credits")
	if (bNoAccess) then
		ix.log.Add(client, "netstreamHoneypot", "ixSetIDCardCredits", bNoAccess)
		return
	end

	if (!ix.item.instances[itemID] or amount < 0) then
		return
	end

	ix.item.instances[itemID]:SetCredits(math.floor(amount))
	ix.log.Add(client, "creditIDCardSetCredits", itemID, amount)
end)

-- Request credits
netstream.Hook("ixRequestCredits", function(client, posTerminalID, amount, reason)
	if (!client:GetCharacter():GetInventory():GetItemByID(posTerminalID)) then
		return
	end

	if (reason == "") then
		client:NotifyLocalized("reasonNotValid")
		return
	end

	local posTerminal = ix.item.instances[posTerminalID]
	if (!posTerminal) then
		return
	end

	local receiverCard = ix.item.instances[posTerminal:GetData("cardID", -1)]
	if (!receiverCard) then
		client:NotifyLocalized("posError")
		return
	end

	if (receiverCard:GetData("active") == false) then
		client:NotifyLocalized("posBoundCardNotActive")
		return
	end

	local data = {}
		data.start = client:GetShootPos()
		data.endpos = data.start + client:GetAimVector() * 96
		data.filter = client
	local target = util.TraceLine(data).Entity
	
	if (IsValid(target) and target:IsPlayer() and target:GetCharacter()) then
		if (IsValid(target.ixSendCreditsTo) and target.ixSendCreditsToTime > CurTime()) then
			client:NotifyLocalized("targetTransactionInProgress")
			return
		end

		posTerminal:SetData("lastAmount", amount, nil, nil, true)

		target.ixSendCreditsTo = client
		target.ixSendCreditsToTime = CurTime() + 15
		target.ixSendCreditsReason = reason
		target.ixReceiverCardID = receiverCard:GetID()
		target.ixSendCreditsAmount = amount
		target.ixSendCreditsPosTerminal = posTerminal

		netstream.Start(target, "ixRequestCredits", client, amount, reason)
		client:NotifyLocalized("posRequestSent")
	else
		client:NotifyLocalized("plyNotValid")
	end
end)

netstream.Hook("ixConfirmCreditOperation", function(sender, senderCardID)
	if (!IsValid(sender.ixSendCreditsTo)) then
		return
	end

	local receiver = sender.ixSendCreditsTo
	local receiverCardID = sender.ixReceiverCardID
	local reason = sender.ixSendCreditsReason
	local amount = sender.ixSendCreditsAmount
	local posTerminal = sender.ixSendCreditsPosTerminal

	sender.ixSendCreditsTo = nil
	sender.ixSendCreditsToTime = nil
	sender.ixSendCreditsReason = nil
	sender.ixReceiverCardID = nil
	sender.ixSendCreditsAmount = nil

	if (!sender:GetCharacter():GetInventory():GetItemByID(senderCardID)) then
		if (IsValid(receiver)) then
			receiver:NotifyLocalized("posError")
		end
		sender:NotifyLocalized("posError")
		return
	end

	local senderCard = ix.item.instances[senderCardID]
	if (senderCard:GetData("active") == false) then
		if (IsValid(receiver)) then
			receiver:NotifyLocalized("posCardNotActive")
		end
		sender:NotifyLocalized("posCardNotActive")
		return
	end

	if (!senderCard:HasCredits(amount)) then
		if (IsValid(receiver)) then
			receiver:NotifyLocalized("transactionNoMoney")
		end
		sender:NotifyLocalized("transactionNoMoney")
		return
	end

	PLUGIN:CreditTransaction(receiverCardID, senderCardID, amount, sender, receiver, posTerminal, reason)
end)

netstream.Hook("ixDenyCreditOperation", function(sender)
	if (IsValid(sender.ixSendCreditsTo)) then
		sender.ixSendCreditsTo:NotifyLocalized("posTransactionRefused")
	end

	sender.ixSendCreditsTo = nil
	sender.ixSendCreditsToTime = nil
	sender.ixSendCreditsReason = nil
	sender.ixReceiverCardID = nil
	sender.ixSendCreditsAmount = nil
end)

netstream.Hook("ixBindTerminal", function(client, itemID, cardID)
	if (!client:GetCharacter():GetInventory():GetItemByID(cardID) or !client:GetCharacter():GetInventory():GetItemByID(itemID)) then
		return
	end

	local itemTable = ix.item.instances[itemID]
	if (itemTable:GetData("active") == false) then
		client:NotifyLocalized("posBoundInactiveCard")
		return
	end

	if (itemTable:GetData("cardIDLock", false)) then return end

	itemTable:SetData("cardID", cardID)

	client:EmitSound("buttons/combine_button1.wav", 60, 100, 0.5)
	client:NotifyLocalized("posBound")
end)


-- Send Credits
netstream.Hook("ixSendCredits", function(client, senderCardID, receiverCid, amount, senderCid)
	if (!client:GetCharacter():GetInventory():GetItemByID(senderCardID)) then
		client:NotifyLocalized("posError")
		return
	end

	local senderCard = ix.item.instances[senderCardID]
	if (!senderCard) then
		client:NotifyLocalized("posError")
		return
	end

	amount = math.floor(amount)
	if (amount <= 0) then
		client:NotifyLocalized("numNotValid")
		return
	end

	if (!senderCard:HasCredits(amount)) then
		client:NotifyLocalized("transactionNoMoney")
		return
	end

	if (senderCard:GetData("cid", "00000") == receiverCid) then
		client:NotifyLocalized("transactionSelf")
		return
	end

	local receiverQuery = mysql:Select("ix_characters")
		receiverQuery:Select("id")
		receiverQuery:Select("idcard")
		receiverQuery:Select("steamid")
		receiverQuery:Where("cid", receiverCid)
		receiverQuery:Limit(1)
		receiverQuery:Callback(function(result)
			if (!result or !istable(result) or #result == 0) then
				client:NotifyLocalized("posError")
				return
			end

			local first = result[1]
			if (client:SteamID64() == first.steamid and result[1].id != client:GetCharacter():GetID()) then
				client:NotifyLocalized("transactionOwnChars")
		--		return
			end

			local receiver = ix.char.loaded[first.id]

			ix.combineNotify:AddNotification("LOG:// Subject ID #" .. senderCid .. " sent " .. amount .. " Credits to #" .. receiverCid, nil, client)
			PLUGIN:CreditTransaction(result[1].idcard, senderCardID, amount, client, receiver, nil, "Terminal Transfer", senderCid, receiverCid)
		end)
	receiverQuery:Execute()
end)


-- Request stuff
local red = Color(255, 0, 0, 255)
local orange = Color(255, 165, 0, 255)
local yellow = Color(255, 255, 0, 255)
local function createCombineAlert(client, text, color)
	ix.combineNotify:AddImportantNotification(text, color, client)
end

function PLUGIN.RequestSuccess(idCard, genericData, client, text, requestType)
	local isBOL = genericData.bol
	local isAC = genericData.anticitizen

	local alertText, color = "%s, #%s (SC: %d) requesting assistance", yellow

	if (client:IsCombine()) then
		alertText = "%s (SC: %d) requesting assistance"
	elseif (isAC) then
		alertText, color = "Anti-Citizen %s, #%s requesting assistance", red
	elseif (isBOL) then
		alertText, color = "BOL Suspect %s, #%s requesting assistance", orange
	elseif (genericData.loyaltyStatus and genericData.loyaltyStatus != "NONE") then
		if (genericData.loyaltyStatus == "CCA MEMBER") then
			alertText, color = "CCA Member "..alertText, red
		else
			alertText, color = string.utf8sub(genericData.loyaltyStatus, 1, 7).." Conformist "..alertText, orange
		end
	elseif (genericData.socialCredits > 90) then
		if (genericData.socialCredits >= 175) then
			alertText = "Tier 3 Conformist "..alertText
		elseif (genericData.socialCredits >= 125) then
			alertText = "Tier 2 Conformist "..alertText
		else
			alertText = "Tier 1 Conformist "..alertText
		end
	end

	if (idCard:GetData("active", false) == false) then
		alertText, color = alertText.." with inactive Identification Card", color != red and orange or red
	end

	alertText = "WRN:// " .. alertText

	if (client:IsCombine()) then
		createCombineAlert(client, string.format(alertText, genericData.name, math.Clamp(tonumber(genericData.socialCredits), 0, 200)), color)
	else
		createCombineAlert(client, string.format(alertText, genericData.name, genericData.cid, math.Clamp(tonumber(genericData.socialCredits), 0, 200)), color)
	end

	local otherListeners = {}
	if (requestType == REQUEST_MED or requestType == REQUEST_WORK) then
		for _, ply in pairs(player.GetAll()) do
			if (ply == client) then continue end
			
			local character = ply:GetCharacter()
			if !character then continue end

			local inventory = character:GetInventory()
			if !inventory then continue end

			local radio = nil
			if (requestType == REQUEST_MED) then
				radio = inventory:HasItem("cmru_radio")
			elseif (requestType == REQUEST_WORK) then
				radio = inventory:HasItem("cwu_radio")
			end

			if (radio and radio:GetData("enabled")) then
				otherListeners[ply] = true
			end
		end
	end

	client:EmitSound("buttons/button3.wav")
	ix.chat.Send(client, "me", ix.config.Get("requestDeviceAction", "used request device."), false)
	ix.chat.Send(client, "request", text, false, nil, {name = genericData.name, cid = genericData.cid, requestType = requestType, otherListeners = otherListeners})
end

function PLUGIN.RequestError(idCard, client, text)
	client:NotifyLocalized("rdError")
end

netstream.Hook("ixRequest", function(client, itemID, text, requestType)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()

	local itemTable = items[itemID]
	local idCard = items[itemTable:GetData("cardID")]
	if (!itemTable or !idCard or itemTable.uniqueID != "request_device" or idCard.uniqueID != "id_card") then
		client:NotifyLocalized("rdError")
		return
	end

	if (client.ixNextRequest and client.ixNextRequest > CurTime()) then
		client:NotifyLocalized("rdFreqLimit")

		return
	else
		client.ixNextRequest = CurTime() + 10
	end

	idCard:LoadOwnerGenericData(PLUGIN.RequestSuccess, PLUGIN.RequestError, client, text, requestType)
end)

netstream.Hook("ixBindRequestDevice", function(client, itemID, cardID)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()
	local itemTable = items[itemID]
	if (!itemTable or itemTable.uniqueID != "request_device" or itemTable:GetData("active") == false or itemTable:GetData("cardID") or !items[cardID] or items[cardID].uniqueID != "id_card") then
		client:NotifyLocalized("posBoundInactiveCard")
		return
	end

	itemTable:SetData("cardID", cardID)

	client:EmitSound("buttons/combine_button1.wav", 60, 100, 0.5)
	client:NotifyLocalized("rdBound")
end)

netstream.Hook("ixBindCWUCard", function(client, itemID, cardID)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()
	local itemTable = items[itemID]
	if (!itemTable or itemTable.uniqueID != "cwu_card" or itemTable:GetData("cardID") or !items[cardID] or items[cardID].uniqueID != "id_card") then
		client:NotifyLocalized("posBoundInactiveCard")
		return
	end

	itemTable:SetData("cardID", cardID)

	client:EmitSound("buttons/combine_button1.wav", 60, 100, 0.5)
	client:NotifyLocalized("cwuBound")
end)

netstream.Hook("ixBindCONCard", function(client, itemID, cardID)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()
	local itemTable = items[itemID]
	if (!itemTable or itemTable.uniqueID != "con_card" or itemTable:GetData("cardID") or !items[cardID] or items[cardID].uniqueID != "id_card") then
		client:NotifyLocalized("posBoundInactiveCard")
		return
	end

	itemTable:SetData("cardID", cardID)

	client:EmitSound("buttons/combine_button1.wav", 60, 100, 0.5)
	client:NotifyLocalized("conBound")
end)

netstream.Hook("ixBindDOBCard", function(client, itemID, cardID)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()
	local itemTable = items[itemID]
	if (!itemTable or itemTable.uniqueID != "dob_card" or itemTable:GetData("cardID") or !items[cardID] or items[cardID].uniqueID != "id_card") then
		client:NotifyLocalized("posBoundInactiveCard")
		return
	end

	itemTable:SetData("cardID", cardID)

	client:EmitSound("buttons/combine_button1.wav", 60, 100, 0.5)
	client:NotifyLocalized("dobBound")
end)

netstream.Hook("ixBindCMRUCard", function(client, itemID, cardID)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()
	local itemTable = items[itemID]
	if (!itemTable or itemTable.uniqueID != "cmru_card" or itemTable:GetData("cardID") or !items[cardID] or items[cardID].uniqueID != "id_card") then
		client:NotifyLocalized("posBoundInactiveCard")
		return
	end

	itemTable:SetData("cardID", cardID)

	client:EmitSound("buttons/combine_button1.wav", 60, 100, 0.5)
	client:NotifyLocalized("cmruBound")
end)

netstream.Hook("ixBindConCard", function(client, itemID, cardID)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()
	local itemTable = items[itemID]
	if (!itemTable or itemTable.uniqueID != "con_card" or itemTable:GetData("cardID") or !items[cardID] or items[cardID].uniqueID != "id_card") then
		client:NotifyLocalized("posBoundInactiveCard")
		return
	end

	itemTable:SetData("cardID", cardID)

	client:EmitSound("buttons/combine_button1.wav", 60, 100, 0.5)
	client:NotifyLocalized("conBound")
end)

netstream.Hook("ixBindMOECard", function(client, itemID, cardID)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()
	local itemTable = items[itemID]
	if (!itemTable or itemTable.uniqueID != "moe_card" or itemTable:GetData("cardID") or !items[cardID] or items[cardID].uniqueID != "id_card") then
		client:NotifyLocalized("posBoundInactiveCard")
		return
	end

	itemTable:SetData("cardID", cardID)

	client:EmitSound("buttons/combine_button1.wav", 60, 100, 0.5)
	client:NotifyLocalized("moeBound")
end)

netstream.Hook("ixSelectCIDSuccess", function(client, cardID)
	local character = client:GetCharacter()
	if (!character) then return end
	local inventory = character:GetInventory()
	if (!inventory) then return end

	local items = inventory:GetItems()
	local cardItem = items[cardID]

	if (cardItem and cardItem.uniqueID == "id_card") then
		client.ixSelectCIDSuccess(cardItem)
	end
end)

netstream.Hook("ixSelectCIDFail", function(client)
	client.ixSelectCIDFail()
end)
