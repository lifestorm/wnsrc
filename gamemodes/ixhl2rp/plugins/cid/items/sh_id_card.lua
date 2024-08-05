--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "#00000's Identity Card"
ITEM.model = Model("models/n7/props/n7_cid_card.mdl")
ITEM.description = "A citizen identification card assigned to %s, CID #%s.\n\nCard Number: %s\nGenetic description:\n%s.\n\nThis card is property of the Combine Civil Administration. Illegal possession and identity fraud are punishable by law and will result in prosecution by Civil Protection. If found, please return this card immediately to the nearest Civil Protection team."
ITEM.category = "Combine"
ITEM.iconCam = {
	pos = Vector(0, 0, 10),
	ang = Angle(90, 90, 0),
	fov = 45,
}

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("active")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:GetName()
	return "#" .. self:GetData("cid", "00000") .. "'s Identity Card"
end

-- It's also possible to use ITEM.KeepOnDeath = true
function ITEM:KeepOnDeath(client)
	return self:GetData("owner") == client:GetCharacter():GetID() and self:GetData("active")
end

function ITEM:GetDescription()
	return string.format(self.description,
		self:GetData("name", "Nobody"),
		self:GetData("cid", "00000"),
		self:GetData("cardNumber", "00-0000-0000-00"),
		self:GetData("geneticDesc", "N/A | N/A | N/A EYES | N/A HAIR"))
end

local prime = 9999999787 -- prime % 4 = 3! DO NOT CHANGE EVER
local offset = 100000 -- slightly larger than sqrt(prime) is ok. DO NOT CHANGE EVER
local block = 100000000
local function generateCardNumber(id)
	id = (id + offset) % prime

	local cardNum = 0

	for _ = 1, math.floor(id/block) do
		cardNum = (cardNum + (id * block) % prime) % prime
	end

	cardNum = (cardNum + (id * (id % block) % prime)) % prime

	if (2 * id < prime) then
		return cardNum
	else
		return prime - cardNum
	end
end

function ITEM:GetCredits()
	return self:GetData("credits", 0)
end

function ITEM:HasCredits(amount)
	return amount <= self:GetData("credits", 0)
end

if (SERVER) then
	function ITEM:SetCredits(amount)
		self:SetData("credits", math.floor(amount))

		return true
	end

	function ITEM:GiveCredits(amount, sender, reason)
		if (amount < 0 and !self:HasCredits(math.abs(amount))) then
			return false
		end

		if (amount == 0) then
			return true
		end

		if (sender) then
			local insert = mysql:Insert("ix_cid_transactions")
				insert:Insert("datetime", os.time())
				insert:Insert("sender_name", sender)
				insert:Insert("sender_cid", "00000")
				insert:Insert("sender_cardid", 0)
				insert:Insert("receiver_name", self:GetData("name", "UNKNOWN"))
				insert:Insert("receiver_cid", self:GetData("cid", "INVALID"))
				insert:Insert("receiver_cardid", self:GetID())
				insert:Insert("amount", amount)
				if (reason and reason != "") then
					insert:Insert("reason", string.len(reason) > 250 and string.sub(reason, 1, 250) or reason)
				else
					insert:Insert("reason", "no reason given")
				end

				insert:Insert("pos", 0)
				insert:Insert("read", 1)
			insert:Execute()
		end

		return self:SetCredits(amount + self:GetCredits())
	end

	function ITEM:TakeCredits(amount, receiver, reason)
		if (amount > 0 and !self:HasCredits(amount)) then
			return false
		end

		if (amount == 0) then
			return true
		end

		if (receiver) then
			local insert = mysql:Insert("ix_cid_transactions")
				insert:Insert("datetime", os.time())
				insert:Insert("sender_name", self:GetData("name", "UNKNOWN"))
				insert:Insert("sender_cid", self:GetData("cid", "INVALID"))
				insert:Insert("sender_cardid", self:GetID())
				insert:Insert("receiver_name", receiver)
				insert:Insert("receiver_cid", "00000")
				insert:Insert("receiver_cardid", 0)
				insert:Insert("amount", amount)
				if (reason and reason != "") then
					insert:Insert("reason", string.len(reason) > 250 and string.sub(reason, 1, 250) or reason)
				else
					insert:Insert("reason", "no reason given")
				end

				insert:Insert("pos", 0)
				insert:Insert("read", 1)
			insert:Execute()
		end

		return self:SetCredits(self:GetCredits() - amount)
	end

	function ITEM:OnInstanced()
		local cardNum = Schema:ZeroNumber(generateCardNumber(self:GetID()), 10)
		self:SetData("cardNumber", string.utf8sub(cardNum, 1, 2).."-"..string.utf8sub(cardNum, 3, 6).."-"..string.utf8sub(cardNum, 7, 10)..
			"-"..Schema:ZeroNumber(cardNum % 97, 2))
	end

	function ITEM:TransferData(newCard, wipe)
		newCard:SetData("credits", self:GetData("credits", 0))
		newCard:SetData("nextRationTime", self:GetData("nextRationTime", 0))

		if (wipe) then
			self:SetData("active", false)
			self:SetData("credits", 0)
			self:SetData("nextRationTime", 0)
		end
	end

	function ITEM:OnRemoved()
		if (self:GetData("active") != false) then
			local ownerId = self:GetData("owner")
			local data = {credits = self:GetData("credits", 0), ration = self:GetData("nextRationTime", 0)}
			if (ix.char.loaded[ownerId]) then
				ix.char.loaded[ownerId]:SetIdCardBackup(data)
				ix.char.loaded[ownerId]:SetIdCard(nil)
			end

			local updateQuery = mysql:Update("ix_characters_data")
				updateQuery:Update("data", util.TableToJSON(data))
				updateQuery:Where("id", ownerId)
				updateQuery:Where("key", "idCardBackup")
			updateQuery:Execute()

			local idCardQuery = mysql:Update("ix_characters")
				idCardQuery.updateList[#idCardQuery.updateList + 1] = {"`idcard`", "NULL"}
				idCardQuery:Where("id", ownerId)
				idCardQuery:Where("schema", Schema and Schema.folder or "helix")
			idCardQuery:Execute()

			self:SetData("active", false)
		end
	end

	function ITEM:LoadOwnerGenericData(callback, error, ...)
		if (!callback) then return end

		local arg = {...}
		local queryObj = mysql:Select("ix_characters_data")
			queryObj:Where("id", self:GetData("owner", 0))
			queryObj:Where("key", "genericdata")
			queryObj:Select("data")
			queryObj:Callback(function(result)
				if (!istable(result) or !result[1]) then
					if (error) then
						error(self, unpack(arg))
					end
				else
					callback(self, util.JSONToTable(result[1].data or ""), unpack(arg))
				end
			end)
		queryObj:Execute()
	end

	netstream.Hook("ixSetIDCardCredits", function(client, itemID, amount)
		ix.item.instances[itemID]:SetCredits(amount)
	end)
end

ITEM.functions.SetCredits = {
	name = "Set Credits",
	icon = "icon16/money_add.png",
	OnClick = function(itemTable)
		local client = itemTable.player
		Derma_StringRequest("Set Credits", "What do you want to set the credits to?", itemTable:GetData("credits", 0), function(text)
			local amount = tonumber(text)

			if (amount and amount >= 0) then
				netstream.Start("ixSetIDCardCredits", itemTable:GetID(), math.floor(amount))
			else
				client:NotifyLocalized("numNotValid")
			end
		end)
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		if (!CAMI.PlayerHasAccess(itemTable.player, "Helix - Set Credits")) then
			return false
		end

		if (!itemTable:GetData("active", false)) then
			return false
		end

		return true
	end
}

ITEM.functions.insert = {
	name = "Insert CID",
	icon = "icon16/add.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local ent = client:GetEyeTrace().Entity
		if (!ent.CIDInsert) or client:EyePos():DistToSqr(ent:GetPos()) > 62500 then
			return false
		end

		local bSuccess, error = itemTable:Transfer(nil, nil, nil, client)
		if (!bSuccess and isstring(error)) then
			client:NotifyLocalized(error)
			return false
		else
			client:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)
		end

		if bSuccess and IsEntity(bSuccess) then
			ent:CIDInsert(bSuccess)
		end

		return false
	end,
	OnCanRun = function(itemTable)
		local client = itemTable.player

		if (!client:GetEyeTrace().Entity.CIDInsert) then
			return false
		end

		if (!itemTable:GetData("active", false)) then
			return false
		end

		return true
	end
}