--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local ix = ix
local string = string
local os = os
local CurTime = CurTime
local IsValid = IsValid
local netstream = netstream

local PLUGIN = PLUGIN

util.AddNetworkString("changeLockAccess")
util.AddNetworkString("changeLockAccessCmru")
util.AddNetworkString("changeLockAccessCon")

ix.log.AddType("creditIDCardSetCredits", function(client, itemId, amount)
	return string.format("%s has set card #%d's credits to %d.", client:SteamName(), itemId, amount)
end)

-- CID GENERATION
local prime = 99787 -- prime % 4 = 3! DO NOT CHANGE EVER
local offset = 320 -- slightly larger than sqrt(prime) is ok. DO NOT CHANGE EVER
local block = 1000
function PLUGIN:GenerateCid(id)
	id = (id + offset) % prime

	local cid = 0

	for _ = 1, math.floor(id/block) do
		cid = (cid + (id * block) % prime) % prime
	end

	cid = (cid + (id * (id % block) % prime)) % prime

	if (2 * id < prime) then
		return Schema:ZeroNumber(cid, 5)
	else
		return Schema:ZeroNumber(prime - cid, 5)
	end
end

ix.log.AddType("creditTransaction", function(client, senderCard, receiverCard, amount, posDevice, reason, senderCID, receiverCID)
	local senderCardCid
	local receiverCardCid

	if !senderCID then
		senderCardCid = senderCard:GetData("cid", "INVALID")
	else
		senderCardCid = (tostring(senderCard:GetData("cid", "00000")) == "00000" and senderCID or senderCard:GetData("cid", "INVALID"))
	end

	if !receiverCID then
		receiverCardCid = receiverCard:GetData("cid", "INVALID")
	else
		receiverCardCid = (tostring(receiverCard:GetData("cid", "00000") ) == "00000" and receiverCID or receiverCard:GetData("cid", "INVALID"))
	end

	local senderName = senderCard:GetData("name", "UNKNOWN")

	if (IsValid(client) and client:HasActiveCombineMask()) then
		senderName = "IDENTITY REDACTED"
		senderCardCid = "REDACTED"
	end

	local insert = mysql:Insert("ix_cid_transactions")
		insert:Insert("datetime", os.time())
		insert:Insert("sender_name", senderName)
		insert:Insert("sender_cid", senderCardCid)
		insert:Insert("sender_cardid", senderCard:GetID())
		insert:Insert("receiver_name", receiverCard:GetData("name", "UNKNOWN"))
		insert:Insert("receiver_cid", receiverCardCid)
		insert:Insert("receiver_cardid", receiverCard:GetID())
		insert:Insert("amount", amount)
		if (reason and reason != "") then
			insert:Insert("reason", string.len(reason) > 250 and string.sub(reason, 1, 250) or reason)
		else
			insert:Insert("reason", "no reason given")
		end

		if (posDevice) then
			insert:Insert("pos", posDevice:GetID())
			insert:Insert("read", 0)
			insert:Callback(function(result, _, insertID)
				posDevice:AddTransactionID(insertID)
			end)
		else
			insert:Insert("pos", 0)
			insert:Insert("read", 1)
		end
	insert:Execute()

	return string.format("%s (CID: %s, item: %s) has send %d credits to %s (CID: %s, item: %s) via %s.",
		senderCard:GetData("name"),
		senderCardCid,
		senderCard:GetID(),
		amount,
		receiverCard:GetData("name"),
		receiverCardCid,
		receiverCard:GetID(),
		posDevice and string.format("POS device for '%s'", reason) or "terminal"
	)
end)

function PLUGIN:DatabaseConnected()
	local query = mysql:Create("ix_cid_transactions")
		query:Create("id", "INT UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("datetime", "INT NOT NULL")
		query:Create("sender_name", "VARCHAR(255) NOT NULL")
		query:Create("sender_cid", "VARCHAR(255) NOT NULL")
		query:Create("sender_cardid", "INT NOT NULL")
		query:Create("receiver_name", "VARCHAR(255) NOT NULL")
		query:Create("receiver_cid", "VARCHAR(255) NOT NULL")
		query:Create("receiver_cardid", "INT NOT NULL")
		query:Create("amount", "INT NOT NULL")
		query:Create("pos", "INT NOT NULL")
		query:Create("read", "TINYINT(1) NOT NULL")
		query:Create("reason", "VARCHAR(255) DEFAULT NULL")
		query:PrimaryKey("id")
	query:Execute()
end

function PLUGIN:SelectTransactions(client, key, value, maxAge, bNoIncludeRead, customCallback)
	if (client.ixNextTransactionSelect and client.ixNextTransactionSelect > CurTime()) then
		client.ixNextTransactionSelect = CurTime() + 1
		return
	end
	client.ixNextTransactionSelect = CurTime() + 1

	maxAge = maxAge or 7
	local query = mysql:Select("ix_cid_transactions")
		if (key == "cid") then
			query.whereList[#query.whereList + 1] = "(`sender_cid` = '"..query:Escape(value).."' OR `receiver_cid` = '"..query:Escape(value).."')"
		else
			query:Where(key, value)
		end
		query:WhereGTE("datetime", os.time() - maxAge * 24 * 3600)
		if (bNoIncludeRead) then
			query:Where("read", 0)
		end
		query:Select("id")
		query:Select("datetime")
		query:Select("sender_name")
		query:Select("sender_cid")
		query:Select("receiver_name")
		query:Select("receiver_cid")
		query:Select("amount")
		query:Select("reason")
		if (key == "pos") then
			query:Select("pos")
			query:Select("read")
		end
		query:Callback(function(result)
			if (!IsValid(client)) then return end
			if customCallback then
				customCallback(result)
				return
			end

			netstream.Start(client, "ixCreditTransactionLog", result, key == "pos" and !bNoIncludeRead)
		end)
		query:OrderByDesc("datetime")
	query:Execute()
end

function PLUGIN:MarkTransactionsRead(id, bAllFromPos, bRead, pos)
	local query = mysql:Update("ix_cid_transactions")
		if (bAllFromPos) then
			query:Where("pos", id)
		else
			query:Where("pos", pos)
			query:Where("id", id)
		end
		query:Update("read", bRead and 1 or 0)
	query:Execute()
end

netstream.Hook("ixTransactionSetRead", function(client, id, bAllFromPos, bRead, pos)
	local inventory = client:GetCharacter():GetInventory()
	local item = inventory:GetItemByID(pos or id)
	if (!item or (item:GetData("cardIDLock") and !inventory:GetItemByID(item:GetData("cardID")))) then
		return
	end

	PLUGIN:MarkTransactionsRead(id, bAllFromPos, bRead, pos)
end)

function PLUGIN:CreateIDCard(character, inventory, credits)
	local genericdata = character:GetGenericdata()
	local age, height, eyeColor = character:GetAge(), character:GetHeight(), character:GetEyeColor()
	local data = {
		owner = character:GetID(),
		cid = character:GetCid(),
		name = character:GetName(),
		geneticDesc = age.." | "..height.." | "..eyeColor.." EYES",
		active = true,
		credits = credits or 0
	}

	if (character:GetFaction() == FACTION_VORT) then
		data.geneticDesc = age.." | "..height

		if (istable(genericdata)) then
			genericdata.cid = data["cid"]
			character:SetGenericdata(genericdata)
			character:Save()
		end
	end

	local success, error = inventory:Add("id_card", 1, data)

	if (!success) then
		character:GetPlayer():NotifyLocalized(error or "unknownError")
	end
end

-- Generic transaction stuff
local function DoCreditTransaction(recipientCard, sendingCard, transactionAmount, sending, recipient, bPosDevice, reason, senderCid, receiverCid)
	if (!recipientCard or !sendingCard) then
		if (IsValid(sending)) then sending:NotifyLocalized("posError") end
		if (IsValid(recipient)) then recipient:NotifyLocalized("posError") end

		return
	end

	local amount = transactionAmount
	local senderCard = sendingCard
	local receiverCard = recipientCard
	local receiver = recipient
	local sender = sending
	local amountPercent = amount / 100
	local vat = ix.config.Get("transactionVatPercent", 2)
	vat = math.Round(amountPercent * vat)

	if (amount < 0) then
		amount = amount * -1

		senderCard = recipientCard
		receiverCard = sendingCard
		sender = recipient
		receiver = sending
	end

	if (senderCard:HasCredits(amount + vat)) then
		senderCard:TakeCredits(amount + vat)
		ix.city.main:AddCredits(vat)
		receiverCard:GiveCredits(amount)

		if (IsValid(sender)) then
			sender:NotifyLocalized("posTransactionSuccess")

			netstream.Start(sender, "TerminalUpdateCredits", amount)
		end

		if (IsValid(receiver)) then receiver:NotifyLocalized("posTransactionSuccess") end
		ix.log.Add(sending, "creditTransaction", sendingCard, recipientCard, transactionAmount, bPosDevice, reason, senderCid, receiverCid)
	else
		if (IsValid(sender)) then sender:NotifyLocalized("transactionNoMoney") end
		if (IsValid(receiver)) then receiver:NotifyLocalized("transactionNoMoney") end
	end
end

function PLUGIN:CreditTransaction(receiverCardID, senderCardID, amount, sender, receiver, bPosDevice, reason, senderCid, receiverCid)
	senderCid = senderCid or false
	receiverCid = receiverCid or false

	if (ix.config.Get("creditsNoConnection")) then
		if (IsValid(sender)) then sender:NotifyLocalized("errorNoConnection") end
		if (IsValid(receiver)) then receiver:NotifyLocalized("errorNoConnection") end
		return
	end


	if (!receiverCardID or !senderCardID) then
		if (IsValid(sender)) then sender:NotifyLocalized("posError") end
		if (IsValid(receiver)) then receiver:NotifyLocalized("posError") end
		return
	end

	if (!ix.item.instances[receiverCardID]) then
		ix.item.LoadItemByID(receiverCardID, nil, function(receiverCard)
			if (ix.item.instances[senderCardID]) then
				DoCreditTransaction(receiverCard, ix.item.instances[senderCardID], amount, sender, receiver, bPosDevice, reason, senderCid, receiverCid)
			else
				ix.item.LoadItemByID(senderCardID, function(senderCard)
					DoCreditTransaction(receiverCard, senderCard, amount, sender, receiver, bPosDevice, reason, senderCid, receiverCid)
				end)
			end
		end)

		return
	end

	if (!ix.item.instances[senderCardID]) then
		ix.item.LoadItemByID(senderCardID, function(senderCard)
			DoCreditTransaction(ix.item.instances[receiverCardID], ix.item.instances[senderCardID], amount, sender, receiver, bPosDevice, reason, senderCid, receiverCid)
		end)

		return
	end

	DoCreditTransaction(ix.item.instances[receiverCardID], ix.item.instances[senderCardID], amount, sender, receiver, bPosDevice, reason, senderCid, receiverCid)
end

-- CHAR funcs
do
	local CHAR = ix.meta.character

	function CHAR:CreateIDCard(credits)
		PLUGIN:CreateIDCard(self, self:GetInventory(), credits)
	end

	function CHAR:GetCredits()
		local itemID = self:GetIdCard()
		if (!itemID or !ix.item.instances[itemID]) then
			return 0
		end

		return ix.item.instances[itemID]:GetCredits()
	end

	function CHAR:HasCredits(amount)
		local itemID = self:GetIdCard()
		if (!itemID or !ix.item.instances[itemID]) then
			return false
		end

		return amount <= ix.item.instances[itemID]:GetCredits()
	end

	function CHAR:SetCredits(amount)
		local itemID = self:GetIdCard()
		if (!itemID or !ix.item.instances[itemID]) then
			return false
		end

		ix.item.instances[itemID]:SetCredits(amount)

		return true
	end

	function CHAR:GiveCredits(amount, sender, reason)
		local itemID = self:GetIdCard()
		if (!itemID or !ix.item.instances[itemID]) then
			return false
		end

		return ix.item.instances[itemID]:GiveCredits(amount, sender, reason)
	end

	function CHAR:TakeCredits(amount, receiver, reason)
		local itemID = self:GetIdCard()
		if (!itemID or !ix.item.instances[itemID]) then
			return false
		end

		return ix.item.instances[itemID]:TakeCredits(amount, receiver, reason)
	end
end

local playerMeta = FindMetaTable("Player")

function playerMeta:SelectCIDCard(onSuccess, onFail)
	local items = self:GetCharacter():GetInventory():GetItemsByUniqueID("id_card")
	local count = table.Count(items)

	if (count == 1) then
		onSuccess(items[1])
	elseif (count == 0) then
		if (onFail) then
			onFail()
		end
	else
		self.ixSelectCIDSuccess = onSuccess

		if (onFail) then
			self.ixSelectCIDFail = onFail
		end

		netstream.Start(self, "ixSelectCID", isfunction(onFail))
	end
end
