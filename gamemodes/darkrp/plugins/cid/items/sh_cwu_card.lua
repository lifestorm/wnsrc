--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "CWU Access Card"
ITEM.model = Model("models/n7/props/n7_cid_card.mdl")
ITEM.description = "A Civil Workers' Union Access Keycard."
ITEM.category = "Combine"
ITEM.skin = 2
ITEM.iconCam = {
	pos = Vector(-509.64, -427.61, 310.24),
	ang = Angle(25, 400, 0),
	fov = 0.59
}

function ITEM:GetName()
	local accessLevel = self:GetData("accessLevel", "Member Access")

	return "CWU " .. accessLevel .. " Keycard"
end

function ITEM:GetFactionInfo()
	return self:GetData("faction", false) and ix.factionBudget.list[self:GetData("faction")] and "Binded to: " .. ix.factionBudget.list[self:GetData("faction")].name or "This card is not binded to any faction."
end

function ITEM:GetColorAppendix()
    local info = {["green"] = self:GetFactionInfo()}

    return info
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
			Derma_Select("Bind ID Card to CWU Card", "Please select a ID card to bind to this CWU Card:",
				cards, "Select ID card",
				"Confirm Operation", function(value, name)
					netstream.Start("ixBindCWUCard", itemTable:GetID(), value:GetID())
				end, "Cancel")
		elseif (cardsCount == 1) then
			Derma_Query("Are you sure you wish to bind your ID to this CWU Card?", "Bind ID Card to CWU Card",
			"Confirm Operation", function()
				netstream.Start("ixBindCWUCard", itemTable:GetID(), cards[1].value:GetID())
			end, "Cancel")
		else
			LocalPlayer():NotifyLocalized("You do not have ID card to bind to this CWU Card.")
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
	isMulti = true,
	multiOptions = function(item, player)
		local keys = table.GetKeys(ix.city.cwuAccess)
		local accessLevels = {}
		for _, accessLevel in pairs(keys) do
			accessLevels[#accessLevels + 1] = {name = accessLevel, data = {aLevel = accessLevel .. " Access"}}
		end

		return accessLevels
	end,
	OnRun = function(itemTable, accessLevel)
		local client = itemTable.player

		itemTable:SetData("accessLevel", accessLevel.aLevel)
		client:NotifyLocalized("You have set this card's Access Level to " .. accessLevel.aLevel .. ".")

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
	name = "Insert card",
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