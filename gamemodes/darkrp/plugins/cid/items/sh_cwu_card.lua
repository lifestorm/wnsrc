--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Carte de l'UTC"
ITEM.model = Model("models/n7/props/n7_cid_card.mdl")
ITEM.description = "Une carte CID de l'UTC."
ITEM.category = "Combine"
ITEM.skin = 3
ITEM.iconCam = {
	pos = Vector(0, 0, 10),
	ang = Angle(90, 90, 0),
	fov = 45,
}

function ITEM:GetName()
	local accessLevel = self:GetData("accessLevel", "- Niveau 0")

	return "Carte de l'UTC " .. accessLevel .. ""
end

function ITEM:GetFactionInfo()
	return self:GetData("faction", false) and ix.factionBudget.list[self:GetData("faction")] and "Lié à: " .. ix.factionBudget.list[self:GetData("faction")].name or "Cette carte n'est lié a aucune faction."
end

function ITEM:GetColorAppendix()
    local info = {["green"] = self:GetFactionInfo()}

    return info
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
					netstream.Start("ixBindCWUCard", itemTable:GetID(), value:GetID())
				end, "Annuler")
		elseif (cardsCount == 1) then
			Derma_Query("Êtes-vous sûr de vouloir lier votre CID à cette carte ?", "Lier le CID à la carte CID",
			"Confirmer", function()
				netstream.Start("ixBindCWUCard", itemTable:GetID(), cards[1].value:GetID())
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
	isMulti = true,
	multiOptions = function(item, player)
		local keys = table.GetKeys(ix.city.cwuAccess)
		local accessLevels = {}
		for _, accessLevel in pairs(keys) do
			accessLevels[#accessLevels + 1] = {name = accessLevel, data = {aLevel = accessLevel .. " Accès"}}
		end

		return accessLevels
	end,
	OnRun = function(itemTable, accessLevel)
		local client = itemTable.player

		itemTable:SetData("accessLevel", accessLevel.aLevel)
		client:NotifyLocalized("Vous avez fixé le niveau d'accès de cette carte à : " .. accessLevel.aLevel .. ".")

		return false
	end,
	OnCanRun = function(itemTable)
		return (!IsValid(itemTable.entity) and IsValid(itemTable.player) and (itemTable.player:Team() == FACTION_ADMIN or itemTable.player:IsCombine() or itemTable.player:GetCharacter():HasFlags("M"))) == true
	end
}

ITEM.functions.SetFaction = {
	name = "Set Card Faction",
	icon = "icon16/vcard_add.png",
	isMulti = true,
	multiOptions = function(item, player)
		local factions = {}
		for id, faction in pairs(ix.factionBudget.list) do
			factions[#factions + 1] = {name = faction.name, data = faction}
		end

		return factions
	end,
	OnRun = function(item, data)
		item:SetData("faction", data.id)

		return false
	end,
	OnCanRun = function(itemTable)
		return (!IsValid(itemTable.entity) and IsValid(itemTable.player) and (itemTable.player:Team() == FACTION_ADMIN or itemTable.player:IsCombine() or itemTable.player:GetCharacter():HasFlags("M"))) == true
	end
}

ITEM.functions.insert = {
	name = "Insérez carte",
	icon = "icon16/add.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local ent = client:GetEyeTrace().Entity
		if (!ent.CWUInsert) or client:EyePos():DistToSqr(ent:GetPos()) > 62500 then
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
			ent:CWUInsert(bSuccess)
		end

		return false
	end,
	OnCanRun = function(itemTable)
		local client = itemTable.player

		if (!client:GetEyeTrace().Entity.CWUInsert) then
			return false
		end

		return true
	end
}