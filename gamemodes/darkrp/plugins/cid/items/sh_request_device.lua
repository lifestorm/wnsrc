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

ITEM.name = "Dispositif d'aide"
ITEM.model = Model("models/gibs/shield_scanner_gib1.mdl")
ITEM.description = "Un petit appareil aux coins arrondis, abritant un bouton. Un petit logo du Cartel est visible.\n\nLes instructions sont : veuillez d'abord enregistrer cet appareil en tenant votre carte CID contre cet appareil. Une fois l'inscription terminée, vous pouvez demander l'assistance de la Protection Civile en appuyant sur le bouton et en précisant votre demande. Votre nom et votre CID sont automatiquement inclus dans la demande.\nVeuillez noter que l'utilisation abusive du dispositif de demande, les fausses déclarations à la Protection Civile et l'usurpation d'identité sont punissables sévèrements et entraîneront des poursuites par la Protection Civile."
ITEM.price = 20
ITEM.category = "Combine"
function ITEM:GetDescription()
    local idCard = ix.item.instances[self:GetData("cardID")]
    return idCard and string.format(self.description.."\n\nActuellement lié à la carte CID n°#%s.", idCard:GetData("cardNumber")) or self.description
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
					end, "FAIRE UNE DEMANDE", "ANNULER"
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
	actionName = "Requête Protection Civile",
	requestTitle = "Demander de l'aide à la Protection Civile",
	requestMessage = "Entrez la raison de votre demande. Votre nom & votre CID sont automatiquement inclus.",
	requestType = REQUEST_CP
})

ITEM.functions.RequestMed = GetRequestTable({
	actionName = "Requête UCMR",
	requestTitle = "Demander de l'aide à L'union Civile de Médecine et de Recherche",
	requestMessage = "Entrez la raison de votre demande. Votre nom & votre CID sont automatiquement inclus. N'oubliez pas de dire votre position!",
	requestType = REQUEST_MED
})

ITEM.functions.RequestCwu = GetRequestTable({
	actionName = "Requête UTC",
	requestTitle = "Demander de l'aide à l'Union des Travailleurs Civile",
	requestMessage = "Entrez la raison de votre demande. Votre nom & votre CID sont automatiquement inclus.",
	requestType = REQUEST_WORK
})

ITEM.functions.Bind = {
	name = "Lié carte CID",
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
			Derma_Select("Lier le CID au dispositif", "Veuillez sélectionner un CID à relier au dispositif :",
				cards, "Sélectionner carte CID",
				"Confirmer", function(value, name)
					netstream.Start("ixBindRequestDevice", itemTable:GetID(), value:GetID())
				end, "Annuler")
		elseif (cardsCount == 1) then
			Derma_Query("Êtes-vous sûr de vouloir lier votre CID à ce dispositif ?", "Lier le CID au dispositif",
			"Confirmer", function()
				netstream.Start("ixBindRequestDevice", itemTable:GetID(), cards[1].value:GetID())
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
