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

ITEM.name = "Housing Key"
ITEM.model = Model("models/willardnetworks/props/vortkey.mdl")
ITEM.description = ""
ITEM.category = "Housing"
ITEM.KeepOnDeath = true
ITEM.iconCam = {
	pos = Vector(-509.64, -427.61, 310.24),
	ang = Angle(25.06, 400.15, 0),
	fov = 0.68
}

if (CLIENT) then
	function ITEM:GetDescription()
		if self:GetData("cid") then
			return "Klucz przypisany do CID: "..self:GetData("cid").." do otwierania drzwi przypisanego "..(self.shop and "sklepu" or "mieszkania").."."
		end

		return "Klucz do otwierania drzwi przypisanego "..(self.shop and "sklepu" or "mieszkania").."."
	end

	function ITEM:PopulateTooltip(tooltip)
		if (self:GetData("mieszkanie")) then
			local appID = self:GetData("mieszkanie")
			PLUGIN:GetApartmentName(appID)

			if PLUGIN.apartments[appID] then
				local panel = tooltip:AddRowAfter("name", "mieszkanie")
				panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
				panel:SetText("Przypisano "..(self.shop and "Sklep" or "Mieszkanie")..": " .. (appID and PLUGIN.apartments[appID].name or appID))
				panel:SizeToContents()
			end
		end

		local id = tooltip:AddRowAfter("mieszkanie", "id")
		id:SetBackgroundColor(Color(125, 96, 90, 255))
		id:SetText("ID klucza: " .. self:GetID())
		id:SizeToContents()
	end
end

function ITEM:SetCID(cid)
	local client = self:GetOwner()

	PLUGIN:SetKeyCID(client, self, cid)
end

function ITEM:AssignToApartment(apartment)
	if !apartment then return false end
	local client = self:GetOwner()

	PLUGIN:AddKeyToApartment(client, self, apartment)
end

function ITEM:RemoveApartment(appID)
	local client = self:GetOwner()
	appID = appID or self:GetData("mieszkanie")

	PLUGIN:AddKeyToApartment(client, self, appID, true)
end

function ITEM:UnlockLockApartment(bUnlock)
	local client = self:GetOwner()
	local targetEnt = client:GetEyeTrace().Entity
	if (IsValid(targetEnt) and targetEnt:IsDoor()) then
		PLUGIN:UnlockLockApartment(self, bUnlock, targetEnt)
	else
		client:NotifyLocalized("Nie patrzysz się na prawidłowe drzwi!")
	end
end

ITEM.functions.Unlock = {
	name = "Otwórz zamek drzwi",
	icon = "icon16/lock_open.png",
	OnRun = function(itemTable)
		itemTable:UnlockLockApartment(true)

		return false
	end,
	OnCanRun = function(itemTable)
		local client = itemTable:GetOwner()
		if !client then return false end

		if (IsValid(itemTable.entity)) then
			return false
		end

		local targetEnt = client:GetEyeTrace().Entity
		if (!IsValid(targetEnt)) then
			return false
		end

		if !targetEnt:IsDoor() then
			return false
		end

		if (!itemTable:GetData("mieszkanie", false)) then
			return false
		end

		return true
	end
}

ITEM.functions.Lock = {
	name = "Zamknij zamek drzwi",
	icon = "icon16/lock.png",
	OnRun = function(itemTable)
		itemTable:UnlockLockApartment()

		return false
	end,
	OnCanRun = function(itemTable)
		local client = itemTable.GetOwner and itemTable:GetOwner()
		if !client then return false end

		if (IsValid(itemTable.entity)) then
			return false
		end

		local targetEnt = client:GetEyeTrace().Entity
		if (!IsValid(targetEnt)) then
			return false
		end

		if !targetEnt:IsDoor() then
			return false
		end

		if (!itemTable:GetData("mieszkanie", false)) then
			return false
		end

		return true
	end
}

local function ShouldHaveAccess(client)
	if (SERVER) then
		local combineutilities = ix.plugin.list["combineutilities"]
		if (combineutilities and combineutilities:HasAccessToDatafile(client)) then return true end
	else
		local faction = ix.faction.Get(client:Team())
		if (faction.alwaysDatafile or client:GetCharacter():HasFlags("U")) then
			return true
		elseif (client:HasActiveCombineSuit() or faction.allowDatafile) then
			if (client:GetCharacter():GetInventory():HasItem("pda") or client:GetActiveWeapon():GetClass() == "weapon_datapad") then
				return true
			end
		end
	end

	return false
end

ITEM.functions.Assign = {
	name = "Przypisz do mieszkania",
	icon = "icon16/building_go.png",
	OnClick = function(itemTable)
		local window = Derma_StringRequest("Przypisz klucz do "..(itemTable.shop and "Sklepu" or "Mieszkania"), "Do jakiego "..(itemTable.shop and "sklepu" or "mieszkania").." czy chcesz przypisać klucz?", false, function()
			netstream.Start("ixApartmentsAssignCIDToKey", itemTable:GetID())
		end, false, false, false, true)

		PLUGIN:ConvertStringRequestToComboselect(window, "Wybierz: "..(itemTable.shop and "Sklep" or "Mieszkanie"), function(comboBox)
			for appID, tApartment in pairs(PLUGIN.apartments) do
				if !tApartment.type then continue end
				if itemTable.shop and tApartment.type != "shop" then continue end
				if !itemTable.shop and tApartment.type == "shop" then continue end

				comboBox:AddChoice( tApartment.name.." | "..string.upper(tApartment.type), appID )
			end
		end, function(comboBox)
			local _, data = comboBox:GetSelected()
			if !data then window:Close() return end
			netstream.Start("ixApartmentsAssignKeyToApartment", itemTable:GetID(), data)
		end)
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		local client = itemTable.player
		if !client then return false end
		if ShouldHaveAccess(client) then return true end

		if !CAMI.PlayerHasAccess(itemTable:GetOwner(), "Helix - Manage Apartments Key", nil) then
			return false
		end

		if (!itemTable:GetData("cid", false)) then
			return false
		end

		if (itemTable:GetData("mieszkanie", false)) then
			return false
		end

		return true
	end
}

ITEM.functions.AssignCID = {
	name = "Przypisz CID",
	icon = "icon16/vcard_add.png",
	OnClick = function(itemTable)
		Derma_StringRequest("Ustaw CID klucza dla "..(itemTable.shop and "Sklepu" or "Mieszkania"), "Do jakiego CID chcesz to przypisać?", nil, function(text)
			netstream.Start("ixApartmentsAssignCIDToKey", itemTable:GetID(), text)
		end)
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		local client = itemTable.player
		if !client then return false end

		if ShouldHaveAccess(client) then return true end

		if !CAMI.PlayerHasAccess(itemTable:GetOwner(), "Helix - Manage Apartments Key", nil) then
			return false
		end

		if (itemTable:GetData("cid", false)) then
			return false
		end

		return true
	end
}

ITEM.functions.RemoveTenant = {
	name = "Usuń z mieszkania",
	icon = "icon16/building_delete.png",
	OnClick = function(itemTable)
		netstream.Start("ixApartmentsAssignKeyToApartment", itemTable:GetID(), false, true)
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		local client = itemTable.player
		if !client then return false end
		if ShouldHaveAccess(client) then return true end

		if !CAMI.PlayerHasAccess(itemTable:GetOwner(), "Helix - Manage Apartments Key", nil) then
			return false
		end

		if (!itemTable:GetData("mieszkanie", false)) then
			return false
		end

		return true
	end
}

ITEM.functions.RemoveCID = {
	name = "Usuń CID z klucza",
	icon = "icon16/vcard_delete.png",
	OnClick = function(itemTable)
		netstream.Start("ixApartmentsAssignCIDToKey", itemTable:GetID(), false)
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		local client = itemTable.player
		if !client then return false end
		if ShouldHaveAccess(client) then return true end
		
		if !CAMI.PlayerHasAccess(itemTable:GetOwner(), "Helix - Manage Apartments Key", nil) then
			return false
		end

		if (!itemTable:GetData("cid", false)) then
			return false
		end

		return true
	end
}