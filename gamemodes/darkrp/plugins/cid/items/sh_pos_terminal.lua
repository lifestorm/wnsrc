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

ITEM.name = "POS Cihazı"
ITEM.model = Model("models/willardnetworks/props/posterminal.mdl")
ITEM.description = "Birinin başka bir karta yatırılmak üzere başka bir kişiden para talep etmesini sağlayan bir cihaz."
ITEM.category = "Combine"

function ITEM:GetDescription()
  local idCard = ix.item.instances[self:GetData("cardID")]
  return idCard and string.format(self.description.."\n\nŞu anda #%s kimlik kartına bağlı.", idCard:GetData("cardNumber")) or self.description
end

if (SERVER) then
	function ITEM:AddTransactionID(id)
		local ids = self:GetData("transactionIDs", {})
		ids[#ids + 1] = id
		self:SetData("transactionIDs", ids, false, false, true)
	end
end

ITEM.functions.RequestCredits = {
	name = "Kredi talep et",
	icon = "icon16/money.png",
	OnClick = function(itemTable)
		local client = itemTable.player

		if (ix.config.Get("creditsNoConnection")) then
			client:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
			client:NotifyLocalized("errorNoConnection")
			return false
		end

		Derma_StringRequest("Kredi talep et", "Kaç kredi talep etmek istiyorsunuz?", itemTable:GetData("lastAmount", 0), function(text)
			local amount = tonumber(text)

			if (amount) then
				Derma_StringRequest("Kredi talep et - YORUM", "Lütfen işlemin nedenini belirtin:", "", function(reason)
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
	name = "Kimlik Kartını Bağla",
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
			Derma_Select("Kimlik Kartını POS'a Bağla", "Lütfen bu POS terminaline bağlanmak için bir kimlik kartı seçin:",
				cards, "Kimlik kartı seç",
				"İşlemi Onayla", function(value, name)
					netstream.Start("ixBindTerminal", itemTable:GetID(), value:GetID())
				end, "İptal")
		elseif (cardsCount == 1) then
			Derma_Query("Kimliğinizi bu POS terminaline bağlamak istediğinizden emin misiniz?", "Kimlik Kartını POS'a Bağla",
			"İşlemi Onayla", function()
				netstream.Start("ixBindTerminal", itemTable:GetID(), cards[1].value:GetID())
			end, "İptal")
		else
			client:NotifyLocalized("Bu terminale bağlanmak için kimlik kartınız yok.")
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
	name = "İşlemleri Göster",
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
			Derma_StringRequest("İşlem Günlüğü Günleri", "Kaç günlük işlem günlüklerini görmek istiyorsunuz?", "7", function(text)
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
	name = "Kimlik Kartını Kilitle",
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
	name = "Kimlik Kartının Kilidini Aç",
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
