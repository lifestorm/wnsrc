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

REQUEST_CP = 0
REQUEST_MED = 1
REQUEST_WORK = 2

ITEM.name = "Pager"
ITEM.model = Model("models/gibs/shield_scanner_gib1.mdl")
ITEM.description = "Małe urządzenie zgłaszające. Z tyłu widoczne jest logo kombinatu. \n\nNa instrukcji czytamy: Proszę najpierw zarejestrować urządzenie przykładając swój CID do urządzenia. Po zakończeniu rejestracji otrzymasz możliwość wezwania pomocy od Civil Protection, aby to zrobić naciśnij przycisk i zgłoś swoje zgłoszenie. Twoje imię i CID zostanie załączony ze zgłoszeniem.\nProszę być świadomym, że każde fałszywe zgłoszenie jak i korzystanie z urządzenia przypisanego do innej osoby jest karane i skutkować będzie surowymi karami od Civil Protection."
ITEM.price = 20
ITEM.category = "Combine"
function ITEM:GetDescription()
    local idCard = ix.item.instances[self:GetData("cardID")]
    return idCard and string.format(self.description.."\n\nAktualnie przypisane do CID #%s.", idCard:GetData("cardNumber")) or self.description
end

local function GetRequestTable(data)
	return {
		name = data.actionName,
		icon = "icon16/help.png",
		OnClick = function(itemTable)
				if (ix.config.Get("creditsNoConnection")) then
					itemTable.player:EmitSound("hl1/fvox/buzz.wav", 60, 100, 0.5)
					return
				end

				Derma_StringRequest(data.requestTitle, data.requestMessage, PLUGIN.text,
					function(text)
						if (text and string.utf8len(text) > 0) then
							netstream.Start("ixRequest", itemTable:GetID(), text, data.requestType)
						end

						PLUGIN.text = nil
					end,
					function(text)
						if (text == PLUGIN.text) then
							PLUGIN.text = text
						elseif (text and string.utf8len(text) > 0)then
							PLUGIN.text = text
						else
							PLUGIN.text = nil
						end
					end, "STWÓRZ ZGŁOSZENIE", "ANULUJ"
				)
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
end

ITEM.functions.RequestCp = GetRequestTable({
	actionName = "Stwórz zgłoszenie do CP",
	requestTitle = "Poproś o pomoc Civil Protection",
	requestMessage = "Wprowadź swoje zgłoszenie dla Civil Protection. Twoje imię i CID zostaną automatycznie dodane do zgłoszenia.",
	requestType = REQUEST_CP
})

ITEM.functions.RequestMed = GetRequestTable({
	actionName = "Stwórz zgłoszenie do CMU",
	requestTitle = "Poproś o pomoc Civil Medical Union",
	requestMessage = "Wprowadź swoje zgłoszenie dla Civil Medical Union. Twoje imię i CID zostaną automatycznie dodane do zgłoszenia. Nie zapomnij podać swojej lokalizacji!",
	requestType = REQUEST_MED
})

ITEM.functions.RequestCwu = GetRequestTable({
	actionName = "Stwórz zgłoszenie do CWU",
	requestTitle = "Poproś o pomoc Civil Workers Union",
	requestMessage = "Wprowadź swoje zgłoszenie dla Civil Workers Union. Twoje imię i CID zostaną automatycznie dodane do zgłoszenia. Nie zapomnij podać swojej lokalizacji!",
	requestType = REQUEST_WORK
})

ITEM.functions.Bind = {
	name = "Przypisz CID",
	icon = "icon16/vcard_edit.png",
	OnClick = function(itemTable)
		local cards = {}

		for _, v in pairs(LocalPlayer():GetCharacter():GetInventory():GetItemsByUniqueID("id_card")) do
			table.insert(cards, {
				text = v:GetName(),
				value = v
			})
		end

		local cardsCount = table.Count(cards)
		if (cardsCount > 1) then
			Derma_Select("Przypisz CID do Pagera", "Prosze wybrać CID aby go przypisać:",
				cards, "Wybierz CID",
				"Potwierdź", function(value, name)
					netstream.Start("ixBindRequestDevice", itemTable:GetID(), value:GetID())
				end, "Anuluj")
		elseif (cardsCount == 1) then
			Derma_Query("Czy jesteś pewny, że chcesz przypisać ten CID do Pagera?", "Przypisz CID do Pagera",
			"Potwierdź", function()
				netstream.Start("ixBindRequestDevice", itemTable:GetID(), cards[1].value:GetID())
			end, "Anuluj")
		else
			LocalPlayer():NotifyLocalized("Nie posiadasz CID, który można przypisać do tego pagera.")
		end
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		if (!IsValid(itemTable.player)) then
			return false
		end

		local inventory = itemTable.player:GetCharacter():GetInventory()
		if (!inventory:HasItem("id_card")) then
			return false
		end

		if (!itemTable:GetData("cardID", false)) then
			return true
		end

		if (inventory:GetItemCount("id_card") == 1 and inventory:GetItemByID(itemTable:GetData("cardID"))) then
			return false
		end

		return true
	end
}

if (CLIENT) then
	netstream.Hook("rdMoreThanOneText", function(text)
		PLUGIN.rdText = text
	end)
end
