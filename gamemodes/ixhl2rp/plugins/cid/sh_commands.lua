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
local math = math
local tostring = tostring
local pairs = pairs
local netstream = netstream
local CurTime = CurTime
local IsValid = IsValid
local util = util
local hook = hook
local ipairs = ipairs
local table = table

local PLUGIN = PLUGIN

ix.command.Add("CharSetCredits", {
	description = "@cmdCharSetMoney",
	privilege = "Set Credits",
	arguments = {
		ix.type.character,
		ix.type.number
	},
	OnRun = function(self, client, target, amount)
		amount = math.Round(amount)

		if (amount <= 0) then
			return "@invalidArg", 2
		end

		target:SetCredits(amount)
		client:NotifyLocalized("setCredits", target:GetName(), tostring(amount))
	end
})

ix.command.Add("CharGiveCredits", {
	description = "@cmdCharGiveCredits",
	privilege = "Set Credits",
	arguments = {
		ix.type.character,
		ix.type.number
	},
	OnRun = function(self, client, target, amount)
		amount = math.Round(amount)

		target:GiveCredits(amount)
		client:NotifyLocalized("giveCredits", target:GetName(), tostring(amount))
	end
})

ix.command.Add("Request", {
	description = "@cmdRequest",
	arguments = {
		ix.type.text
	},
	combineBeep = true,
	OnRun = function(self, client, text)
		local character = client:GetCharacter()
		if (!character) then return end

		local items = character:GetInventory():GetItems()
		local requestDevices = {}

		for _, item in pairs(items) do
			if (item.uniqueID == "request_device" and item:GetData("cardID")) then
				requestDevices[#requestDevices + 1] = item
			end
		end

		if (#requestDevices > 1) then
			client:NotifyLocalized("rdMoreThanOne")
			netstream.Start(client, "rdMoreThanOneText", text)
			return
		elseif (#requestDevices == 0) then
			client:NotifyLocalized("rdNoRD")
			return
		end

		if (ix.config.Get("creditsNoConnection")) then
			client:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
			return
		end

		local idCard = ix.item.instances[requestDevices[1]:GetData("cardID")]
		if (!idCard) then
			client:NotifyLocalized("rdError")
			return
		end

		if (client.ixNextRequest and client.ixNextRequest > CurTime()) then
			client:NotifyLocalized("rdFreqLimit")
			return
		else
			client.ixNextRequest = CurTime() + 10
		end

		idCard:LoadOwnerGenericData(PLUGIN.RequestSuccess, PLUGIN.RequestError, client, text)
	end
})

ix.command.Add("WithdrawCredit", {
	description = "Withdraws credits from the specified character's active CID card.",
	OnCheckAccess = function(self, client)
		return client:GetCharacter() and (client:GetCharacter():GetFaction() == FACTION_ADMIN or client:GetCharacter():HasFlags("U"))
	end,
	arguments = {
		ix.type.character,
		ix.type.number
	},
	OnRun = function(self, client, target, amount)
		amount = math.Round(amount)

		if (amount <= 0) then
			return "@invalidArg", 2
		end

		if (target:HasCredits(amount)) then
			local receiverCardId = client:GetCharacter():GetIdCard()
			local senderCardId = target:GetIdCard()

			PLUGIN:CreditTransaction(receiverCardId, senderCardId, amount, target, client, nil, "CCA Withdraw")

			target:GetPlayer():Notify("The Combine Civil Administration withdrew "..amount.." credits from your card.")
		else
			client:Notify("Character do not have this amount of credits.")
		end
	end
})

ix.command.Add("CreateCid", {
	description = "Creates new CID card for the specified character.",
	adminOnly = true,
	arguments = {
		ix.type.player
	},
	OnRun = function(self, client, target)
		if (IsValid(target) and target:IsPlayer() and target:GetCharacter()) then
			local character = target:GetCharacter()
			local cid = character:GetCid()

			if (!cid) then
				client:NotifyLocalized("idNotFound")
				return
			end

			character:CreateIDCard()
			client:EmitSound("buttons/button4.wav", 60, 100, 0.5)
			client:NotifyLocalized("idCardAdded")

			if (target != client) then
				target:NotifyLocalized("idCardRecreated")
			end
		else
			client:NotifyLocalized("plyNotValid")
		end
	end
})

if (ix.plugin.list.doors) then
	-- Overriding Helix door plugin command to use credits instead
	ix.command.Add("DoorBuy", {
		description = "@cmdDoorBuy",
		OnRun = function(self, client, arguments)
			-- Get the entity 96 units infront of the player.
			local data = {}
				data.start = client:GetShootPos()
				data.endpos = data.start + client:GetAimVector() * 96
				data.filter = client
			local trace = util.TraceLine(data)
			local entity = trace.Entity

			-- Check if the entity is a valid door.
			if (IsValid(entity) and entity:IsDoor() and !entity:GetNetVar("disabled")) then
				if (!entity:GetNetVar("ownable") or entity:GetNetVar("faction") or entity:GetNetVar("class")) then
					return "@dNotAllowedToOwn"
				end

				if (IsValid(entity:GetDTEntity(0))) then
					return "@dOwnedBy", entity:GetDTEntity(0):Name()
				end

				entity = IsValid(entity.ixParent) and entity.ixParent or entity

				-- Get the price that the door is bought for.
				local price = entity:GetNetVar("price", ix.config.Get("doorCost"))
				local character = client:GetCharacter()

				-- Check if the player can actually afford it.
				if (character:HasCredits(price)) then
					-- Set the door to be owned by this player.
					entity:SetDTEntity(0, client)
					entity.ixAccess = {
						[client] = DOOR_OWNER
					}

					ix.plugin.list.doors:CallOnDoorChildren(entity, function(child)
						child:SetDTEntity(0, client)
					end)

					local doors = character:GetVar("doors") or {}
						doors[#doors + 1] = entity
					character:SetVar("doors", doors, true)

					-- Take their money and notify them.
					character:TakeCredits(price, "Housing", "Door purchased")
					ix.city.main:AddCredits(price)
					hook.Run("OnPlayerPurchaseDoor", client, entity, true, ix.plugin.list.doors.CallOnDoorChildren)

					ix.log.Add(client, "buydoor")
					return "@dPurchased", price..(price == 1 and " credit" or " credits")
				else
					-- Otherwise tell them they can not.
					return "@canNotAfford"
				end
			else
				-- Tell the player the door isn't valid.
				return "@dNotValid"
			end
		end
	})

	ix.command.Add("DoorSell", {
		description = "@cmdDoorSell",
		OnRun = function(self, client, arguments)
			-- Get the entity 96 units infront of the player.
			local data = {}
				data.start = client:GetShootPos()
				data.endpos = data.start + client:GetAimVector() * 96
				data.filter = client
			local trace = util.TraceLine(data)
			local entity = trace.Entity

			-- Check if the entity is a valid door.
			if (IsValid(entity) and entity:IsDoor() and !entity:GetNetVar("disabled")) then
				-- Check if the player owners the door.
				if (client == entity:GetDTEntity(0)) then
					entity = IsValid(entity.ixParent) and entity.ixParent or entity

					-- Get the price that the door is sold for.
					local price = math.Round(entity:GetNetVar("price", ix.config.Get("doorCost")) * ix.config.Get("doorSellRatio"))
					local character = client:GetCharacter()

					-- Remove old door information.
					entity:RemoveDoorAccessData()

					local doors = character:GetVar("doors") or {}

					for k, v in ipairs(doors) do
						if (v == entity) then
							table.remove(doors, k)
						end
					end

					character:SetVar("doors", doors, true)

					-- Take their money and notify them.
					character:GiveCredits(price, "Housing", "Door sold")
					hook.Run("OnPlayerPurchaseDoor", client, entity, false, PLUGIN.CallOnDoorChildren)

					ix.log.Add(client, "selldoor")
					return "@dSold", price..(price == 1 and " credit" or " credits")
				else
					-- Otherwise tell them they can not.
					return "@notOwner"
				end
			else
				-- Tell the player the door isn't valid.
				return "@dNotValid"
			end
		end
	})
end
