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

ITEM.name = "Terminal POS"
ITEM.model = Model("models/willardnetworks/props/posterminal.mdl")
ITEM.description = "Dispositif permettant à quelqu'un de demander à une autre personne de déposer des crédits sur une autre carte CID."
ITEM.category = "Combine"

function ITEM:GetDescription()
  local idCard = ix.item.instances[self:GetData("cardID")]
  return idCard and string.format(self.description.."\n\nLié à la carte CID n°#%s.", idCard:GetData("cardNumber")) or self.description
end

if (SERVER) then
	function ITEM:AddTransactionID(id)
		local ids = self:GetData("transactionIDs", {})
		ids[#ids + 1] = id
		self:SetData("transactionIDs", ids, false, false, true)
	end
end

ITEM.functions.RequestCredits = {
	name = "Demander des crédits",
	icon = "icon16/money.png",
	OnClick = function(itemTable)
		local client = itemTable.player

		if (ix.config.Get("creditsNoConnection")) then
			client:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
			client:NotifyLocalized("errorNoConnection")
			return false
		end

		Derma_StringRequest("Demander des crédits", "Combien de crédits demandez-vous ?", itemTable:GetData("lastAmount", 0), function(text)
			local amount = tonumber(text)

			if (amount) then
				Derma_StringRequest("Demander des crédits - RAISON", "Entrez une raison pour cette transaction :", "", function(reason)
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
	name = "Lier la carte CID",
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
			Derma_Select("Liaison du CID au terminal", "Veuillez sélectionner un CID à relier à ce terminal :",
				cards, "Sélectionner la carte",
				"Confirmer", function(value, name)
					netstream.Start("ixBindTerminal", itemTable:GetID(), value:GetID())
				end, "Annuler")
		elseif (cardsCount == 1) then
			Derma_Query("Êtes-vous sûr de vouloir lier CID à ce terminal ?", "Liaison du CID au terminal",
			"Confirmer", function()
				netstream.Start("ixBindTerminal", itemTable:GetID(), cards[1].value:GetID())
			end, "Annuler")
		else
			client:NotifyLocalized("Vous n'avez pas de carte CID à lier.")
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
	name = "Transactions récentes",
	icon = "icon16/eye.png",
	OnRun = function(itemTable, data)
		local inventory = itemTable.player:GetCharacter():GetInventory()
		PLUGIN:SelectTransactions(itemTable.player, "pos", itemTable:GetID(), data and data[1], itemTable:GetData("cardIDLock", false) and !inventory:GetItemByID(itemTable:GetData("cardID")))

		return false
	end,
	isMulti = true,
	multiOptions = function(item, player)
		local options = {{name = "1 jour", data = {1}}}

        for i = 2, 6 do
            options[#options + 1] = {name = i.." Jours", data = {i}}
        end
		options[#options + 1] = {name = "1 Semaine", data = {7}}
		options[#options + 1] = {name = "2 Semaines", data = {14}}
		options[#options + 1] = {name = "1 Mois", data = {30}}

		options[#options + 1] = {name = "Plus", data = {-1}, OnClick = function(itemTable)
			Derma_StringRequest("Registre", "Entrez le nombre de jours auxquels vous voulez voir les registres.", "7", function(text)
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
	name = "Bloquer la Carte",
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
	name = "Débloquer la Carte",
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
