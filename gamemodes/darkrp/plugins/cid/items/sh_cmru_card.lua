--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "CMRU Access Card"
ITEM.model = Model("models/n7/props/n7_cid_card.mdl")
ITEM.description = "A Civil Medical & Research Union Keycard."
ITEM.category = "Combine"
ITEM.skin = 2
ITEM.iconCam = {
	pos = Vector(-509.64, -427.61, 310.24),
	ang = Angle(25, 400, 0),
	fov = 0.59
}

function ITEM:GetName()
	local accessLevel = self:GetData("accessLevel", 1)

	return "CMRU Level " .. accessLevel .. " Access Keycard"
end

function ITEM:GetDescription()
	local idCard = ix.item.instances[self:GetData("cardID")]
	return idCard and string.format(self.description.."\n\nCurrently bound to identity card #%s.", idCard:GetData("cardNumber")) or
		(self:GetData("cardID") and self.description.."\n\nCurrently bound." or self.description)
end

ITEM.functions.Bind = {
	name = "Bind ID Card",
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
			Derma_Select("Bind ID Card to CMRU Card", "Please select a ID card to bind to this CMRU Card:",
				cards, "Select ID card",
				"Confirm Operation", function(value, name)
					netstream.Start("ixBindCMRUCard", itemTable:GetID(), value:GetID())
				end, "Cancel")
		elseif (cardsCount == 1) then
			Derma_Query("Are you sure you wish to bind your ID to this CMRU Card?", "Bind ID Card to CMRU Card",
			"Confirm Operation", function()
				netstream.Start("ixBindCMRUCard", itemTable:GetID(), cards[1].value:GetID())
			end, "Cancel")
		else
			LocalPlayer():NotifyLocalized("You do not have ID card to bind to this CMRU Card.")
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
	name = "Toggle Card Access Level",
	icon = "icon16/vcard_add.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local accessLevel = itemTable:GetData("accessLevel", 1)

		accessLevel = accessLevel != 5 and accessLevel + 1 or 1
		itemTable:SetData("accessLevel", accessLevel)
		client:NotifyLocalized("You have set this card's Access Level to Access Level " .. accessLevel .. ".")

		return false
	end,
	OnCanRun = function(itemTable)
		return (!IsValid(itemTable.entity) and IsValid(itemTable.player) and (itemTable.player:Team() == FACTION_ADMIN or itemTable.player:IsCombine() or itemTable.player:GetCharacter():HasFlags("M"))) == true
	end
}
