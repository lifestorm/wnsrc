--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Karta Dostępu CMU"
ITEM.model = Model("models/n7/props/n7_cid_card.mdl")
ITEM.description = "Karta dostępu Civil Medical Union."
ITEM.category = "Combine"
ITEM.skin = 2
ITEM.iconCam = {
	pos = Vector(-509.64, -427.61, 310.24),
	ang = Angle(25, 400, 0),
	fov = 0.59
}

function ITEM:GetName()
	local accessLevel = self:GetData("accessLevel", 1)

	return "Karta dostępu  " .. accessLevel .. " CMU"
end

function ITEM:GetDescription()
	local idCard = ix.item.instances[self:GetData("cardID")]
	return idCard and string.format(self.description.."\n\nAktualnie przypisany do CID #%s.", idCard:GetData("cardNumber")) or
		(self:GetData("cardID") and self.description.."\n\nAktualnie przypisany." or self.description)
end

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
			Derma_Select("Przypisz CID do karty CMU", "Prosze wybrać CID aby go przypisać:",
				cards, "Wybierz CID",
				"Potwierdź", function(value, name)
					netstream.Start("ixBindCMRUCard", itemTable:GetID(), value:GetID())
				end, "Anuluj")
		elseif (cardsCount == 1) then
			Derma_Query("Czy jesteś pewny, że chcesz przypisać ten CID do tej karty dostępu?", "Przypisz CID do karty CMU",
			"Potwierdź", function()
				netstream.Start("ixBindCMRUCard", itemTable:GetID(), cards[1].value:GetID())
			end, "Anuluj")
		else
			LocalPlayer():NotifyLocalized("Nie posiadasz CID, który można przypisać do tej karty dostępu.")
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

		if (itemTable:GetData("cardID")) then
			return false
		end

		return true
	end
}

ITEM.functions.SetAccessLevel = {
	name = "Przełącz poziom karty",
	icon = "icon16/vcard_add.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local accessLevel = itemTable:GetData("accessLevel", 1)

		accessLevel = accessLevel != 5 and accessLevel + 1 or 1
		itemTable:SetData("accessLevel", accessLevel)
		client:NotifyLocalized("Ustawiłeś poziom karty na: " .. accessLevel .. ".")

		return false
	end,
	OnCanRun = function(itemTable)
		return (!IsValid(itemTable.entity) and IsValid(itemTable.player) and (itemTable.player:Team() == FACTION_ADMIN or itemTable.player:IsCombine() or itemTable.player:GetCharacter():HasFlags("M"))) == true
	end
}
