--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Carte de la H.A.A"
ITEM.model = Model("models/n7/props/n7_cid_card.mdl")
ITEM.description = "Une carte CID de la Haute Autorité Administrative."
ITEM.category = "Combine"
ITEM.skin = 1
ITEM.iconCam = {
	pos = Vector(0, 0, 10),
	ang = Angle(90, 90, 0),
	fov = 45,
}

function ITEM:GetName()
	local accessLevel = self:GetData("accessLevel", "- Niveau 0")

	return "Carte de la Haute Autorité Administrative " .. accessLevel .. ""
end

function ITEM:GetDescription()
	local idCard = ix.item.instances[self:GetData("cardID")]
	return idCard and string.format(self.description.."\n\nActuellement lié au CID #%s.", idCard:GetData("cardNumber")) or
		(self:GetData("cardID") and self.description.."\n\nActuellement lié." or self.description)
end

ITEM.functions.Bind = {
	name = "Lier la carte CID",
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
			Derma_Select("Lier le CID à la carte CID", "Veuillez sélectionner un CID à relier à cette carte :",
				cards, "Sélectionner carte CID",
				"Confirmer", function(value, name)
					netstream.Start("ixBindDOBCard", itemTable:GetID(), value:GetID())
				end, "Annuler")
		elseif (cardsCount == 1) then
			Derma_Query("Êtes-vous sûr de vouloir lier votre CID à cette carte ?", "Lier le CID à la carte CID",
			"Confirmer", function()
				netstream.Start("ixBindDOBCard", itemTable:GetID(), cards[1].value:GetID())
			end, "Annuler")
		else
			LocalPlayer():NotifyLocalized("Vous n'avez pas de carte CID à lier.")
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
	name = "Modifier le niveau d'accès",
	icon = "icon16/vcard_add.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local accessLevel = itemTable:GetData("accessLevel", "0")
		local target = accessLevel == "- NIVEAU 1 (MEMBRE)" and "- NIVEAU 2 (ADMINISTRATION)" or "- NIVEAU 1 (MEMBRE)"

		itemTable:SetData("accessLevel", target)
		client:NotifyLocalized("Vous avez fixé le niveau d'accès de cette carte à : " .. target .. ".")

		return false
	end,
	OnCanRun = function(itemTable)
		return (!IsValid(itemTable.entity) and IsValid(itemTable.player) and (itemTable.player:Team() == FACTION_ADMIN or itemTable.player:IsCombine() or itemTable.player:GetCharacter():HasFlags("M"))) == true
	end
}
