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

-- Util Functions:
-- A function to sync apartment name and type with the client (for ESP)
function PLUGIN:SyncApartments(client)
	if !CAMI.PlayerHasAccess(client, "Helix - Observer Extra ESP", nil) then return end

	local nameAndType = self:AppGetNameAndType()

	for _, v in pairs(player.GetAll()) do
		if !CAMI.PlayerHasAccess(v, "Helix - Observer Extra ESP", nil) then continue end
		netstream.Start(v, "SyncApartments", nameAndType)
	end
end

-- A function to sync the apartment doors, name and type with the client (for ESP) on initial spawn
function PLUGIN:SyncToOneApartments(client, appID, foundApartment, genericData, bDatafile)
	if (appID) then
		local nameTable = {}
		appID = tonumber(appID)
		if !self.apartments[appID] then return end

		nameTable[appID] = {
			name = self.apartments[appID].name
		}

		netstream.Start(client, "SyncApartments", nameTable, true, bDatafile)
		return
	end

	if foundApartment and genericData then
		local names = self:GetAppNames()
		netstream.Start(client, "TerminalUpdateHousing", foundApartment, names, genericData)
	end

	if !CAMI.PlayerHasAccess(client, "Helix - Observer Extra ESP", nil) then return end

	local nameAndType = self:AppGetNameAndType()
	netstream.Start(client, "SyncApartments", nameAndType)
end

function PLUGIN:SyncApartmentsToDatapad(client, curCollect)
	if !self:HasAccessToDatafile(client) then return end

	local toSend = {}
	local curApartments = {}
	local curShops = {}

	for appID, v in pairs(self.apartments) do
		v.appID = appID

		if v.type == "normalny" then
			curApartments[#curApartments + 1] = v
			continue
		end

		curShops[#curShops + 1] = v
	end

	for i = curCollect - 4, curCollect do
		if curApartments[i] then
			toSend[#toSend + 1] = curApartments[i]
		end

		if curShops[i] then
			toSend[#toSend + 1] = curShops[i]
		end
	end

	netstream.Start(client, "SyncApartmentsToDatapad", toSend)
end

-- A function to get doors, type and names from the apartments table
function PLUGIN:AppGetNameAndType()
	local namesAndType = {}
	for appID, tApartment in pairs(self.apartments) do
		namesAndType[appID] = {
			name = tApartment.name,
			doors = tApartment.doors,
			type = tApartment.type
		}
	end

	return namesAndType
end

-- A function to get names from the apartments table
function PLUGIN:GetAppNames()
	local names = {}
	for appID, tApartment in pairs(self.apartments) do
		names[appID] = {
			name = tApartment.name
		}
	end

	return names
end

-- A function to update an apartment in the database
function PLUGIN:UpdateApartment(appID)
	local queryUpdate = mysql:Update("ix_apartments_"..game.GetMap())
		queryUpdate:Where("app_id", appID)
		queryUpdate:Update("app_name", self.apartments[appID].name)
		local doors = {}
		for _, v in pairs(self.apartments[appID].doors) do
			if (IsValid(Entity(v))) then
				local id = Entity(v):MapCreationID()
				if (id == -1) then continue end
				doors[#doors + 1] = id
			end
		end
		queryUpdate:Update("app_doors", util.TableToJSON(doors))
		queryUpdate:Update("app_employees", util.TableToJSON(self.apartments[appID].employees))
		queryUpdate:Update("app_permits", util.TableToJSON(self.apartments[appID].permits))
		queryUpdate:Update("app_tenants", util.TableToJSON(self.apartments[appID].tenants))
		queryUpdate:Update("app_lastactions", util.TableToJSON(self.apartments[appID].lastActions))
		queryUpdate:Update("app_rent", self.apartments[appID].rent)
		queryUpdate:Update("app_payments", util.TableToJSON(self.apartments[appID].payments))
		queryUpdate:Update("app_type", self.apartments[appID].type)
		queryUpdate:Update("app_noassign", self.apartments[appID].noAssign)
		queryUpdate:Update("app_rentdue", self.apartments[appID].rentDue)
	queryUpdate:Execute()
end

local function HandlePermitUpdateForEachChar(newPermit, permits, char, charID, isEmployee)
	if char then
		local genericData = char:GetGenericdata()
		local charPermits = ix.permits.get()
		if isEmployee then
			for k, _ in pairs(charPermits) do
				charPermits[k] = false
			end
			for k, v in pairs(genericData.permits) do
				charPermits[k] = v
			end
			for k, v in pairs(permits) do
				if charPermits[k] != v then return end
			end
		end

		char:SetPermit(newPermit, !permits[newPermit])
	else
		local query = mysql:Select("ix_characters_data")
		query:Where("key", "genericdata")
		query:Where("id", tostring(charID))
		query:Select("data")
		query:Callback(function(result)
			if (!istable(result) or #result == 0) then
				return
			end
			local genericData = util.JSONToTable(result[1]["data"])

			local charPermits = ix.permits.get()
			if isEmployee then
				for k, _ in pairs(charPermits) do
					charPermits[k] = false
				end
				for k, v in pairs(genericData.permits) do
					charPermits[k] = v
				end
				for k, v in pairs(permits) do
					if charPermits[k] != v then return end
				end
			end
			if !permits[newPermit] then
				genericData.permits[newPermit] = !permits[newPermit]
			else
				genericData.permits[newPermit] = nil
			end
			local addPermit = mysql:Update("ix_characters_data")
				addPermit:Where("id", tostring(charID))
				addPermit:Where("key", "genericdata")
				addPermit:Update("data", util.TableToJSON(genericData))
			addPermit:Execute()
		end)
		query:Execute()
	end
end

function PLUGIN:HandleShopPermitUpdate(appID, newPermit)
	local apartment = self.apartments[appID]
	if apartment.type != "shop" then return end
	local permits = {}
	for permit, bValue in pairs(apartment.permits) do
		permits[permit] = bValue
	end
	permits[newPermit] = !permits[newPermit]
	for cid, employee in pairs(apartment.employees) do
		local char
		local charID
		self:LookUpCardItemIDByCID(tostring(cid), function(result)
			local idCardID = result[1].idcard or false
			if !result then return end
			if !ix.item.instances[idCardID] then
				ix.item.LoadItemByID(idCardID, false, function(item)
					if !item then return end
					char = ix.char.loaded[item:GetData("owner")]
					charID = item:GetData("owner")

					HandlePermitUpdateForEachChar(newPermit, permits, char, charID, true)
				end)
			else
				char = ix.char.loaded[ix.item.instances[idCardID]:GetData("owner")]
				charID = ix.item.instances[idCardID]:GetData("owner")

				HandlePermitUpdateForEachChar(newPermit, permits, char, charID, true)
			end
		end)
	end

	for cid, tenant in pairs(apartment.tenants) do
		local char
		local charID
		self:LookUpCardItemIDByCID(tostring(cid), function(result)
			local idCardID = result[1].idcard or false
			if !result then return end
			if !ix.item.instances[idCardID] then
				ix.item.LoadItemByID(idCardID, false, function(item)
					if !item then return end
					char = ix.char.loaded[item:GetData("owner")]
					charID = item:GetData("owner")

					HandlePermitUpdateForEachChar(newPermit, permits, char, charID, false)
				end)
			else
				char = ix.char.loaded[ix.item.instances[idCardID]:GetData("owner")]
				charID = ix.item.instances[idCardID]:GetData("owner")

				HandlePermitUpdateForEachChar(newPermit, permits, char, charID, false)
			end
		end)
	end
end

-- A function to check if a door is already added to an apartment
function PLUGIN:CheckIfDoorAlreadyAdded(client, entDoor, bNoNotify)
	for key, tInfo in pairs(self.apartments) do
		for _, doorIndex in pairs(tInfo.doors) do
			if doorIndex == entDoor:EntIndex() then
				if !bNoNotify then
					client:NotifyLocalized("Te drzwi są już dodane do mieszkania! - "..tInfo.name)
				end

				return key, tInfo.name
			end
		end
	end

	return false
end

-- A function to check if an apartment exists before adding a door to it
function PLUGIN:CheckIfApartmentExists(client, appName)
	for key, tInfo in pairs(self.apartments) do
		if string.lower(tInfo.name) == string.lower(appName) then
			return key
		end
	end

	return false
end

-- A function check what apartment a CID belongs to
function PLUGIN:GetApartmentByCID(cid, type)
	for key, tInfo in pairs(self.apartments) do
		if (type and type:find("shop")) then
			if tInfo.type != "shop" then continue end
		end

		if (type and type:find("mieszkanie")) then
			if tInfo.type == "shop" then continue end
		end

		if tInfo.tenants[cid] or tInfo.employees[cid] then
			return key
		end
	end

	return false
end

-- A function to find the apartment to assign
function PLUGIN:GetWhichApartmentToAssign(appType)
	local appTenants = {}
	local maxTenants = ix.config.Get("housingMaxTenants")
	for appID, tApartment in pairs(self.apartments) do
		if tApartment.noAssign == true then continue end
		if table.IsEmpty(tApartment.doors) then continue end
		if table.Count(tApartment.tenants) >= maxTenants then continue end
		if tApartment.type != appType then continue end

		appTenants[appID] = table.Count(tApartment.tenants)
	end

	local fillOrder = {}
	for i = 0, maxTenants - 1 do
		fillOrder[#fillOrder + 1] = i
	end
	if (maxTenants >= 2) then
		if (ix.config.Get("housingFirstFull")) then
			fillOrder = table.Reverse(fillOrder)
		elseif (ix.config.Get("housingFirstDouble")) then
			fillOrder[1] = 1
			fillOrder[2] = 0
		end
	end

	for _, i in ipairs(fillOrder) do
		for appID2, tenantCount in pairs(appTenants) do
			if tenantCount == i then
				return appID2
			end
		end
	end

	return false
end

function PLUGIN:InventoryItemAdded(oldInv, inventory, item)
	if (oldInv != nil) then return end

	if (item.uniqueID == "apartmentkey" or item.uniqueID == "shopkey") then
		PLUGIN:UpdateItemIDTenant(item:GetData("cid"), item:GetID(), item.uniqueID)
		PLUGIN:UpdateItemIDEmployee(item:GetData("cid"), item:GetID(), item.uniqueID)
	end
end

-- A function to get what apartment the door is assigned to
function PLUGIN:GetDoorApartment(client, entDoor)
	if !self:CheckIfDoorAlreadyAdded(client, entDoor) then
		client:NotifyLocalized("Nie można znaleźć mieszkania, do którego przypisane są te drzwi.")
	end
end

-- A function to check if a key has access
function PLUGIN:GetKeyHasAccess(item, entDoor, bNoNotify)
	local client = item:GetOwner()
	local _, appName = self:CheckIfDoorAlreadyAdded(client, entDoor, true)
	local itemCID = item:GetData("cid") or false
	local itemID = item:GetID()

	for appID, tApartment in pairs(self.apartments) do
		if !tApartment.tenants[itemCID] and !tApartment.employees[itemCID] then continue end
		for _, doorIndex in pairs(tApartment.doors) do
			if doorIndex != entDoor:EntIndex() then continue end

			if tApartment.tenants[itemCID] and tApartment.tenants[itemCID].key == itemID then return appID, itemCID
			elseif tApartment.employees[itemCID] and tApartment.employees[itemCID].key == itemID then return appID, itemCID end
		end
	end

	if !bNoNotify then
		client:NotifyLocalized("Nie masz dostępu do tego mieszkania!")
	end

	return false
end

-- A function get if a key already has access to another apartment
function PLUGIN:GetKeyAlreadyHasOtherAccess(item)
	local itemCID = item:GetData("cid") or false

	for key, tApartment in pairs(self.apartments) do
		local tenant = tApartment.tenants[itemCID]
		if (tenant and tenant != false) then return key end
	end

	return false
end

function PLUGIN:HasCIDInInventory(client, cid)
	local bFound = false
	for _, v in pairs(client:GetCharacter():GetInventory():GetItems()) do
		if v.uniqueID != "id_card" then continue end
		if v:GetData("cid", false) and tonumber(v:GetData("cid", false)) == tonumber(cid) then
			bFound = v
			break
		end
	end

	return bFound
end

function PLUGIN:RequestAssignedApartmentInfo(client, cid, bShop)
	if !self:HasCIDInInventory(client, cid) then return end

	local assignedApp
	if !bShop then assignedApp = self:GetApartmentByCID(cid, "mieszkanie") end
	if bShop then assignedApp = self:GetApartmentByCID(cid, "shop") end
	if !assignedApp then
		netstream.Start(client, "ReplyApartmentInfo", false, false)
		return
	end

	netstream.Start(client, "ReplyApartmentInfo", self.apartments[assignedApp], assignedApp, bShop)
end

function PLUGIN:ToggleApartmentNoAssign(client, appID)
	if !appID then client:NotifyLocalized("Invalid apartment") return end

	if self.apartments[appID].noAssign then
		self.apartments[appID].noAssign = false
		client:NotifyLocalized("Toggled this apartment from apartment assignment to false.")
	else
		self.apartments[appID].noAssign = true
		client:NotifyLocalized("Toggled this apartment from apartment assignment to true.")
	end

	self:UpdateApartment(appID)
end

function PLUGIN:AddDoorInteraction(client, appID, cid)
	self.apartments[appID].lastActions[cid] = os.time()
	self:UpdateApartment(appID)
end

function PLUGIN:PayRent(client, amount, appID, cid)
	local cidItem = self:HasCIDInInventory(client, cid)
	if !cidItem then return false end

	local cidData = cidItem:GetData("cid")
	if !cidData then return false end

	if cidItem:GetCredits() < amount then
		netstream.Start(client, "SendHousingErrorMessage", "NOT ENOUGH CREDITS")
		return
	end

	cidData = Schema:ZeroNumber(cidData, 5)

	if self.apartments[appID].payments[cidData] then
		self.apartments[appID].payments[cidData] = {amount = amount + self.apartments[appID].payments[cidData].amount, date = os.time()}
	else
		self.apartments[appID].payments[cidData] = {amount = amount, date = os.time()}
	end

	cidItem:TakeCredits(amount, "Housing", "Rent")
	ix.city.main:AddCredits(amount)

	self:UpdateApartment(appID)

	netstream.Start(client, "UpdateHousingPaymentPanel", self.apartments[appID], appID, amount)
end

function PLUGIN:SetTenantAutoPayment(client, appID, cid, bEnabled)
	local cidItem = self:HasCIDInInventory(client, cid)
	if !cidItem then return false end

	local cidData = cidItem:GetData("cid")
	if !cidData then return false end

	cidData = Schema:ZeroNumber(cidData, 5)

	self.apartments[appID].tenants[cidData].autoPay = bEnabled
	self:UpdateApartment(appID)
end

function PLUGIN:HasAccessToDatafile(client)
	local combineutilities = ix.plugin.list["combineutilities"]
	if !combineutilities then return end
	if (!combineutilities:HasAccessToDatafile(client)) then return false end

	return true
end

-- Hooks

netstream.Hook("SetTenantAutoPayment", function(client, appID, cid, bEnabled)
	PLUGIN:SetTenantAutoPayment(client, appID, cid, bEnabled)
end)

hook.Add("CanPlayerAccessDoor", "CheckForKeyItem", function(client, entDoor)
	for _, item in ipairs(client:GetCharacter():GetInventory():GetItemsByUniqueID("apartmentkey")) do
		local appID, cid = PLUGIN:GetKeyHasAccess(item, entDoor, true)
		if (appID and cid) then
			PLUGIN:AddDoorInteraction(client, appID, cid)
			return true
		end
	end

	for _, item in ipairs(client:GetCharacter():GetInventory():GetItemsByUniqueID("shopkey")) do
		local appID, cid = PLUGIN:GetKeyHasAccess(item, entDoor, true)
		if (appID and cid) then
			PLUGIN:AddDoorInteraction(client, appID, cid)
			return true
		end
	end

	return false
end)

hook.Add("CAMI.PlayerUsergroupChanged", "SyncApartmentsToOne", function(client)
	PLUGIN:SyncToOneApartments(client)
end)

netstream.Hook("RequestApartmentNames", function(client, appID)
	PLUGIN:SyncToOneApartments(client, appID)
end)

function PLUGIN:RefreshApartmentsPanel(client)
	if !CAMI.PlayerHasAccess(client, "Helix - Manage Apartments", nil) then return end

	local nameAndType = PLUGIN:AppGetNameAndType()

	for appID, tApartment in pairs(PLUGIN.apartments) do
		nameAndType[appID].rent = tApartment.rent
	end

	netstream.Start(client, "SyncApartmentsApartmentsPanel", nameAndType)
end

netstream.Hook("RequestApartmentNamesApartmentsPanel", function(client)
	PLUGIN:RefreshApartmentsPanel(client)
end)

netstream.Hook("CreateApartmentApartmentsUI", function(client, type, name)
	PLUGIN:CreateApartment(client, name, false, type)
	PLUGIN:RefreshApartmentsPanel(client)
end)

netstream.Hook("RequestApartmentNamesDatafile", function(client, appID)
	PLUGIN:SyncToOneApartments(client, appID, false, false, true)
end)

netstream.Hook("ixApartmentsRequest", function(client, cid, type)
	PLUGIN:HandleAssignment(client, cid, type)
end)

netstream.Hook("RequestAssignedApartmentInfo", function(client, cid, bShop)
	PLUGIN:RequestAssignedApartmentInfo(client, cid, bShop)
end)

netstream.Hook("ixApartmentsAssignKeyToApartment", function(client, keyItemID, appID, bRemove)
	if !CAMI.PlayerHasAccess(client, "Helix - Manage Apartments Key", nil) then return end
	if !ix.item.instances[keyItemID] then return end

	if !bRemove then
		ix.item.instances[keyItemID]:AssignToApartment(appID)
	else
		ix.item.instances[keyItemID]:RemoveApartment()
	end
end)

netstream.Hook("ixApartmentsAssignCIDToKey", function(client, keyItemID, cid)
	if !CAMI.PlayerHasAccess(client, "Helix - Manage Apartments Key", nil) then return end
	if !ix.item.instances[keyItemID] then return end

	ix.item.instances[keyItemID]:SetCID(cid)
end)

netstream.Hook("PayRent", function(client, amount, appID, cid)
	PLUGIN:PayRent(client, amount, appID, cid)
end)

netstream.Hook("RequestApartmentNamesDatapad", function(client, curCollect)
	PLUGIN:SyncApartmentsToDatapad(client, curCollect)
end)

netstream.Hook("ChangeApartmentName", function(client, appID, newName)
	if !CAMI.PlayerHasAccess(client, "Helix - Manage Apartments", nil) then return end
	if !PLUGIN.apartments[appID] then return end
	PLUGIN.apartments[appID].name = newName
	PLUGIN:UpdateApartment(appID)

	for _, doorEntID in pairs(PLUGIN.apartments[appID].doors) do
		local entDoor = Entity(doorEntID)
		if (IsValid(entDoor) and entDoor:IsDoor()) then
			entDoor:SetNetVar("visible", true)
			entDoor:SetNetVar("name", newName)

			local doorPlugin = ix.plugin.list["doors"]
			if doorPlugin then
				doorPlugin:SaveDoorData()
			end
		end
	end

	netstream.Start(client, "UpdateApartmentList")
end)

netstream.Hook("RemoveApartmentHousing", function(client, name)
	PLUGIN:RemoveApartment(client, name)
	netstream.Start(client, "UpdateApartmentList")
end)

netstream.Hook("RemoveTenant", function(client, tenantCID, appID)
	if !PLUGIN:HasAccessToDatafile(client) then return end
	if !PLUGIN.apartments[appID] then return end
	if !PLUGIN.apartments[appID].tenants[tenantCID] then
		for newAppID, tApartment in pairs(PLUGIN.apartments) do
			if !tApartment.tenants[tenantCID] then continue end

			PLUGIN:RemoveTenant(client, tenantCID, newAppID, true)
		end

		return
	end

	PLUGIN:RemoveTenant(client, tenantCID, appID, true)
end)

netstream.Hook("RemoveEmployee", function(client, employeeCID, appID)
	if !PLUGIN:HasAccessToDatafile(client) and !PLUGIN.apartments[appID].tenants[client:GetCharacter():GetGenericdata().cid] then return end
	if !PLUGIN.apartments[appID] then return end
	if !PLUGIN.apartments[appID].employees[employeeCID] then
		for newAppID, tApartment in pairs(PLUGIN.apartments) do
			if !tApartment.employees[employeeCID] then continue end

			PLUGIN:RemoveEmployee(client, employeeCID, newAppID, true)
		end

		return
	end

	PLUGIN:RemoveEmployee(client, employeeCID, appID, true)
end)

function PLUGIN.RenewKey(idCard, genericData, client, appID, bEmployee)
	if !PLUGIN:HasAccessToDatafile(client) then return end

	if !idCard then return end
	local cid = idCard:GetData("cid")
	if !cid or istable(cid) then client:NotifyLocalized("CID IS TABLE") return end

	if !PLUGIN.apartments[appID] then return end
	if !bEmployee then
		if !PLUGIN.apartments[appID].tenants[cid] then return end
	else
		if !PLUGIN.apartments[appID].employees[cid] then return end
	end
	local character = ix.char.loaded[genericData.id]
	if character then
		local appType = PLUGIN.apartments[appID].type
		if !character:GetPurchasedItems()[appType == "shop" and "shopkey" or "apartmentkey"] then
			character:SetPurchasedItems(appType == "shop" and "shopkey" or "apartmentkey", 1)
		else
			client:NotifyLocalized("Klucz czeka już w automacie odbiorczym dla tego CID. Został on zaktualizowany.")
		end
		if !bEmployee then
			PLUGIN.apartments[appID].tenants[cid].key = true
		else
			PLUGIN.apartments[appID].employees[cid].key = true
		end
		PLUGIN:UpdateApartment(appID)
		client:NotifyLocalized("Sukces. Obecny klucz został wyłączony, teraz możesz odebrać nowy klucz z automatu odbiorczego.")
		netstream.Start(client, "UpdateIndividualApartment", appID, PLUGIN.apartments[appID])
		return
	end

	client:NotifyLocalized("Niepowodzenie. Postać nie była online, więc nie przypisano nowego klucza.")
end

netstream.Hook("RenewKey", function(client, tenantCID, appID, bEmployee)
	if !PLUGIN:HasAccessToDatafile(client) then return end
	if !PLUGIN.apartments[appID] then return end
	tenantCID = Schema:ZeroNumber(tenantCID, 5)

	if !PLUGIN.apartments[appID].tenants[tenantCID] and !PLUGIN.apartments[appID].employees[tenantCID] then return end

	PLUGIN:LookUpCardItemIDByCID(tostring(tenantCID), function(result)
		local idCardID = result[1].idcard or false
		if !result then client:NotifyLocalized("Te CID nie istnieje!") return end

		if !ix.item.instances[idCardID] then
			ix.item.LoadItemByID(idCardID, false, function(item)
				if !item then return end
				item:LoadOwnerGenericData(PLUGIN.RenewKey, false, client, appID, bEmployee)
			end)
		else
			ix.item.instances[idCardID]:LoadOwnerGenericData(PLUGIN.RenewKey, false, client, appID, bEmployee)
		end
	end)
end)

function PLUGIN.AddEmployeeManually(idCard, genericData, client, appID)
	local cid = idCard:GetData("cid")
	if !cid or istable(cid) then client:NotifyLocalized("CID IS TABLE") return end
	if PLUGIN.apartments[appID].type != "shop" then return client:NotifyLocalized("To nie jest sklep!") end
	cid = Schema:ZeroNumber(idCard:GetData("cid"), 5)
	for newAppID, tApartment in pairs(PLUGIN.apartments) do
		if tApartment.type != "shop" then continue end
		if tApartment.employees[cid] then return client:NotifyLocalized(tostring(cid) .. " jest już pracownikiem w " .. PLUGIN.apartments[newAppID].name) end
		if tApartment.tenants[cid] then return client:NotifyLocalized(tostring(cid) .. " jest już najemcą w" .. PLUGIN.apartments[newAppID].name) end
	end
	local character = ix.char.loaded[genericData.id]
	if character then
		for k, v in pairs(PLUGIN.apartments[appID].permits) do
			character:SetPermit(k, v)
		end
		if PLUGIN:AddKeyToApartment(client, cid, appID, nil, nil, true) then
			local appType = PLUGIN.apartments[appID].type
			local item = (appType != "shop" and "apartmentkey" or "shopkey")
			if !character:GetPurchasedItems()[item] then
				character:SetPurchasedItems(item, 1)
			else
				client:NotifyLocalized("Klucz do "..(appType != "shop" and "mieszkania" or "sklepu").." czeka już w automacie odbiorczym dla tego CID. Został on zaktualizowany.")
			end
			netstream.Start(client, "UpdateIndividualApartment", appID, PLUGIN.apartments[appID])
		end
		netstream.Start(client, "AddEmployeeToList", PLUGIN.apartments[appID], cid, appID)
	else
		client:NotifyLocalized("Niepowodzenie. Postać nie była online, więc nie przydzielono żadnego pracownika.")
	end
end

function PLUGIN.AddTenantManually(idCard, genericData, client, appID)
	local cid = idCard:GetData("cid")
	if !cid or istable(cid) then client:NotifyLocalized("CID IS TABLE") return end
	cid = Schema:ZeroNumber(idCard:GetData("cid"), 5)

	if PLUGIN.apartments[appID].employees[cid] then return client:NotifyLocalized("Nie można przypisać osoby, która jest już pracownikiem, jako najemcę.") end

	if PLUGIN.apartments[appID].type == "shop" then
		if table.IsEmpty(genericData.permits) then
			client:NotifyLocalized("Ten CID nie ma zezwolenia działalności, ale i tak został dodany.")
		end
	end

	if PLUGIN.apartments[appID].type == "shop" then
		genericData.shop = appID
	else
		genericData.housing = appID
	end

	local combineutilities = ix.plugin.list["combineutilities"]
	if combineutilities and combineutilities.UpdateGenericData then
		combineutilities:UpdateGenericData(genericData)
	end



	local character = ix.char.loaded[genericData.id]
	if character then
		if PLUGIN.apartments[appID].type == "shop" then
			for k, v in pairs(PLUGIN.apartments[appID].permits) do
				character:SetPermit(k, v)
			end
		end
		if PLUGIN:AddKeyToApartment(client, cid, appID) then
			local appType = PLUGIN.apartments[appID].type
			local item = (appType != "shop" and "apartmentkey" or "shopkey")

			if !character:GetPurchasedItems()[item] then
				character:SetPurchasedItems(item, 1)
			else
				client:NotifyLocalized("Klucz do "..(appType != "shop" and "mieszkania" or "sklepu").." czeka już w automacie odbiorczym dla tego CID. Został on zaktualizowany.")
			end

			netstream.Start(client, "UpdateIndividualApartment", appID, PLUGIN.apartments[appID])
		end

		if PLUGIN.apartments[appID].type == "shop" then
			for _, shopTerminal in pairs(ents.FindByClass("ix_shopterminal")) do
				shopTerminal:UpdateScreen()
			end
		end
	else
		client:NotifyLocalized("Niepowodzenie. Postać nie była online, więc nie przypisano najemcy.")
	end
end

netstream.Hook("AddTenant", function(client, appID, cid)
	if !PLUGIN:HasAccessToDatafile(client) then return end
	if !appID or !cid then return end

	cid = Schema:ZeroNumber(cid, 5)

	if !PLUGIN:CheckIfCIDExistsLoaded(cid) then
		if !PLUGIN:CheckIfCIDExistsDatabase(cid) then
			client:NotifyLocalized("Ten CID nie istnieje!")
			return
		end

		client:NotifyLocalized("Ten CID nie istnieje!")
		return
	end

	PLUGIN:LookUpCardItemIDByCID(tostring(cid), function(result)
		local idCardID = result[1].idcard or false
		if !result then client:NotifyLocalized("Ten CID nie istnieje!") return end

		if !ix.item.instances[idCardID] then
			ix.item.LoadItemByID(idCardID, false, function(item)
				if !item then return end
				item:LoadOwnerGenericData(PLUGIN.AddTenantManually, false, client, appID)
			end)
		else
			ix.item.instances[idCardID]:LoadOwnerGenericData(PLUGIN.AddTenantManually, false, client, appID)
		end
	end)
end)

netstream.Hook("AddEmployee", function(client, appID, cid)
	if !PLUGIN:HasAccessToDatafile(client) and !PLUGIN.apartments[appID].tenants[client:GetCharacter():GetGenericdata().cid] then return end
	if !appID or !cid then return end
	if PLUGIN.apartments[appID].type != "shop" then return client:NotifyLocalized("To nie jest sklep!") end


	cid = Schema:ZeroNumber(cid, 5)

	if !PLUGIN:CheckIfCIDExistsLoaded(cid) then
		if !PLUGIN:CheckIfCIDExistsDatabase(cid) then
			client:NotifyLocalized("Ten CID nie istnieje")
			return
		end

		client:NotifyLocalized("Ten CID nie istnieje")
		return
	end

	PLUGIN:LookUpCardItemIDByCID(tostring(cid), function(result)
		local idCardID = result[1].idcard or false
		if !result then client:NotifyLocalized("Ten CID nie istnieje") return end

		if !ix.item.instances[idCardID] then
			ix.item.LoadItemByID(idCardID, false, function(item)
				if !item then return end
				item:LoadOwnerGenericData(PLUGIN.AddEmployeeManually, false, client, appID)
			end)
		else
			ix.item.instances[idCardID]:LoadOwnerGenericData(PLUGIN.AddEmployeeManually, false, client, appID)
		end
	end)
end)

netstream.Hook("ApartmentUpdateRent", function(client, appID, newRent)
	if !PLUGIN:HasAccessToDatafile(client) then return end

	PLUGIN:SetApartmentRent(client, appID, false, newRent)
	netstream.Start(client, "UpdateIndividualApartment", appID, PLUGIN.apartments[appID])
end)

netstream.Hook("ApartmentExtendRentDueDateByDays", function(client, appID, days)
	if !PLUGIN:HasAccessToDatafile(client) then return end
	PLUGIN.apartments[appID].rentDue = PLUGIN.apartments[appID].rentDue + 3600 * 24 * tonumber(days)
	PLUGIN:UpdateApartment(appID)

	netstream.Start(client, "UpdateIndividualApartment", appID, PLUGIN.apartments[appID])
end)

netstream.Hook("BuyShopViaTerminal", function(client, ent, permits)
	if !IsValid(ent) then return end

	if ent:IsPurchasable() then
		local shopID = ent:GetShopID()
		local character = client:GetCharacter()
		local idCard = character:GetInventory():HasItem("id_card")

		if (client:EyePos():DistToSqr(ent:GetPos()) > 62500) then return end
		if !shopID then return client:NotifyLocalized("Nie można znaleźć sklepu z tym ID.") end
		if !idCard then return client:NotifyLocalized("Nie masz CID w swoim ekwipunku!!") end
		if !permits or #table.GetKeys(permits) > 3 then return end
		if character:GetGenericdata().socialCredits < ent:GetShopSocialCreditReq() then
			return client:NotifyLocalized("Nie masz wystarczająco społecznych kredytów!")
		end

		if !idCard:HasCredits(ent:GetShopCost()) then
			return client:NotifyLocalized("Nie masz wystarczająco kredytów!")
		end

		idCard:TakeCredits(ent:GetShopCost(), "Shop Terminal", "Kupiono sklep.")
		local idCardNumber = idCard:GetData("cid", "00000")

		for i = 1, #PLUGIN.apartments do
			local apartment = PLUGIN.apartments[i]
			if apartment.type == "shop" and apartment.tenants[idCardNumber] then
				return client:NotifyLocalized("Już posiadasz sklep!")
			end
		end

		for k, _ in pairs(PLUGIN.apartments[shopID].permits) do
			if permits[k] then
				PLUGIN.apartments[shopID].permits[k] = true
			else
				PLUGIN.apartments[shopID].permits[k] = false
			end
		end

		idCard:LoadOwnerGenericData(PLUGIN.AddTenantManually, false, client, shopID)
	end
end)