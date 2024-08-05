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

ITEM.name = "POS Terminal"
ITEM.model = Model("models/willardnetworks/props/posterminal.mdl")
ITEM.description = "A device that allows someone to request money from another person to be deposited upon another card."
ITEM.category = "Combine"

function ITEM:GetDescription()
  local idCard = ix.item.instances[self:GetData("cardID")]
  return idCard and string.format(self.description.."\n\nCurrently bound to identity card #%s.", idCard:GetData("cardNumber")) or self.description
end

if (SERVER) then
	function ITEM:AddTransactionID(id)
		local ids = self:GetData("transactionIDs", {})
		ids[#ids + 1] = id
		self:SetData("transactionIDs", ids, false, false, true)
	end
end

ITEM.functions.RequestCredits = {
	name = "Request credits",
	icon = "icon16/money.png",
	OnClick = function(itemTable)
		local client = itemTable.player

		if (ix.config.Get("creditsNoConnection")) then
			client:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
			client:NotifyLocalized("errorNoConnection")
			return false
		end

		Derma_StringRequest("Request credits", "How many credits do you want to request?", itemTable:GetData("lastAmount", 0), function(text)
			local amount = tonumber(text)

			if (amount) then
				Derma_StringRequest("Request credits - COMMENT", "Please state the reason for the transaction:", "", function(reason)
					if (text == "") then
						client:NotifyLocalized("reasonNotValid")

						return
					end

					netstream.Start("ixRequestCredits", itemTable:GetID(), math.floor(amount), reason)
				end)
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

		if (!itemTable:GetData("cardID", false)) then
			return false
		end

		return true
	end
}

ITEM.functions.Bind = {
	name = "Bind ID Card",
	icon = "icon16/vcard_edit.png",
	OnClick = function(itemTable)
		local client = itemTable.player

		if (ix.config.Get("creditsNoConnection")) then
			client:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
			client:NotifyLocalized("errorNoConnection")
			return false
		end

		local cards = {}

		for _, v in pairs(client:GetCharacter():GetInventory():GetItemsByUniqueID("id_card")) do
			table.insert(cards, {
				text = v:GetName(),
				value = v
			})
		end

		local cardsCount = table.Count(cards)
		if (cardsCount > 1) then
			Derma_Select("Bind ID Card to POS", "Please select a ID card to bind to this POS terminal:",
				cards, "Select ID card",
				"Confirm Operation", function(value, name)
					netstream.Start("ixBindTerminal", itemTable:GetID(), value:GetID())
				end, "Cancel")
		elseif (cardsCount == 1) then
			Derma_Query("Are you sure you wish to bind your ID to this POS terminal?", "Bind ID Card to POS",
			"Confirm Operation", function()
				netstream.Start("ixBindTerminal", itemTable:GetID(), cards[1].value:GetID())
			end, "Cancel")
		else
			client:NotifyLocalized("You do not have ID card to bind to this terminal.")
		end
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then return false end
		if (!IsValid(itemTable.player)) then return false end

		if (itemTable:GetData("cardIDLock", false)) then return false end

		local inventory = itemTable.player:GetCharacter():GetInventory()
		if (!inventory:HasItem("id_card")) then return false end
		if (!itemTable:GetData("cardID", false)) then return true end

		if (inventory:GetItemCount("id_card") == 1 and inventory:GetItemByID(itemTable:GetData("cardID"))) then
			return false
		end

		return true
	end
}

ITEM.functions.ShowLog = {
	name = "Show Transactions",
	icon = "icon16/eye.png",
	OnRun = function(itemTable, data)
		local inventory = itemTable.player:GetCharacter():GetInventory()
		PLUGIN:SelectTransactions(itemTable.player, "pos", itemTable:GetID(), data and data[1], itemTable:GetData("cardIDLock", false) and !inventory:GetItemByID(itemTable:GetData("cardID")))

		return false
	end,
	isMulti = true,
	multiOptions = function(item, player)
		local options = {{name = "1 day", data = {1}}}

        for i = 2, 6 do
            options[#options + 1] = {name = i.." days", data = {i}}
        end
		options[#options + 1] = {name = "1 week", data = {7}}
		options[#options + 1] = {name = "2 week", data = {14}}
		options[#options + 1] = {name = "1 month", data = {30}}

		options[#options + 1] = {name = "other", data = {-1}, OnClick = function(itemTable)
			Derma_StringRequest("Transaction Log Days", "How many days of transaction logs do you wish to see?", "7", function(text)
				local amount = tonumber(text)
				if (!amount or amount <= 0) then return end

				net.Start("ixInventoryAction")
					net.WriteString("ShowLog")
					net.WriteUInt(itemTable.id, 32)
					net.WriteUInt(itemTable.invID, 32)
					net.WriteTable({amount})
				net.SendToServer()
			end)

			return false
		end}

        return options
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then return false end
		if (!IsValid(itemTable.player)) then return false end
		if (!itemTable:GetData("cardID", false)) then return false end

		return true
	end
}


ITEM.functions.Lock = {
	name = "Lock ID Card",
	icon = "icon16/lock.png",
	OnRun = function(itemTable)
		itemTable:SetData("cardIDLock", true)

		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then return false end
		if (!IsValid(itemTable.player)) then return false end

		if (itemTable:GetData("cardIDLock", false)) then return false end

		local inventory = itemTable.player:GetCharacter():GetInventory()
		if (!itemTable:GetData("cardID", false)) then return false end
		if (!inventory:GetItemByID(itemTable:GetData("cardID"))) then return false end

		return true
	end
}

ITEM.functions.LockUn = {
	name = "UnLock ID Card",
	icon = "icon16/lock_open.png",
	OnRun = function(itemTable)
		itemTable:SetData("cardIDLock", false)

		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then return false end
		if (!IsValid(itemTable.player)) then return false end

		if (!itemTable:GetData("cardIDLock", false)) then return false end

		local inventory = itemTable.player:GetCharacter():GetInventory()
		if (!itemTable:GetData("cardID", false)) then return false end
		if (!inventory:GetItemByID(itemTable:GetData("cardID"))) then return false end

		return true
	end
}
