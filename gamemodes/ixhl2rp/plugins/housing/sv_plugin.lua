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
PLUGIN.apartments = PLUGIN.apartments or {}

-- Database formalia
function PLUGIN:DatabaseConnected()
    local query = mysql:Create("ix_apartments_"..game.GetMap())
    query:Create("app_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
    query:Create("app_name", "TEXT")
	query:Create("app_doors", "TEXT")
    query:Create("app_employees", "TEXT")
    query:Create("app_permits", "TEXT")
    query:Create("app_tenants", "TEXT")
    query:Create("app_lastactions", "TEXT")
	query:Create("app_rent", "TEXT")
	query:Create("app_payments", "TEXT")
	query:Create("app_type", "TEXT")
	query:Create("app_noassign", "TEXT")
	query:Create("app_rentdue", "TEXT")
    query:PrimaryKey("app_id")
	query:Callback(function()
		local appsQuery = mysql:Select("ix_apartments_"..game.GetMap())
		appsQuery:Callback(function(appsResult)
			if (!istable(appsResult) or #appsResult == 0) then
				return
			end

			for _, v in pairs(appsResult) do
				local doorsCreationID = util.JSONToTable(v["app_doors"])
				local doors = {}
				for _, v1 in pairs(doorsCreationID) do
					local ent = ents.GetMapCreatedEntity(v1)
					if (!ent) then continue end
					doors[#doors + 1] = ent:EntIndex()

					if (!ix.config.Get("shouldLockDoorsAfterRestart", true) or self.lockedApps) then continue end
					ent:Fire("Lock")
					local partner = ent:GetDoorPartner()
					if (IsValid(partner)) then
						partner:Fire("lock")
					end
				end

				self.apartments[tonumber(v["app_id"])] = {
					name = v["app_name"],
					doors = doors,
					employees = util.JSONToTable(v["app_employees"]),
					permits = util.JSONToTable(v["app_permits"]),
					tenants = util.JSONToTable(v["app_tenants"]),
					lastActions = util.JSONToTable(v["app_lastactions"]),
					rent = v["app_rent"],
					payments = util.JSONToTable(v["app_payments"]),
					type = v["app_type"],
					noAssign = v["app_noassign"],
					rentDue = v["app_rentdue"]
				}

				local employeeList = {}
				for cid, tEmployee in pairs(self.apartments[tonumber(v["app_id"])].employees) do
					employeeList[Schema:ZeroNumber(cid, 5)] = tEmployee
				end

				self.apartments[tonumber(v["app_id"])].employees = employeeList

				local tenantList = {}
				for cid, tTenant in pairs(self.apartments[tonumber(v["app_id"])].tenants) do
					tenantList[Schema:ZeroNumber(cid, 5)] = tTenant
				end

				self.apartments[tonumber(v["app_id"])].tenants = tenantList

				local lastActionList = {}
				for cid, osTime in pairs(self.apartments[tonumber(v["app_id"])].lastActions) do
					lastActionList[Schema:ZeroNumber(cid, 5)] = osTime
				end

				self.apartments[tonumber(v["app_id"])].lastActions = lastActionList

				local paymentList = {}
				for cid, tPaymentInfo in pairs(self.apartments[tonumber(v["app_id"])].payments) do
					paymentList[Schema:ZeroNumber(cid, 5)] = tPaymentInfo
				end

				self.apartments[tonumber(v["app_id"])].payments = paymentList
			end

			self.lockedApps = true
		end)

		appsQuery:Execute()
	end)
    query:Execute()
end

-- A function to create an apartment
function PLUGIN:CreateApartment(client, appName, bNoNotify, sType, callback)
	if self:CheckIfApartmentExists(client, appName) then
		client:NotifyLocalized("Mieszkanie o tej nazwie już istnieje..")
		return false
	end
	local permitsToAssign = {}
	for k, _ in pairs(ix.permits.get()) do
		permitsToAssign[k] = false
	end
    local queryAdd = mysql:Insert("ix_apartments_"..game.GetMap())
		queryAdd:Insert("app_name", appName)
		queryAdd:Insert("app_doors", util.TableToJSON({}))
		queryAdd:Insert("app_employees", util.TableToJSON({}))
		queryAdd:Insert("app_permits", util.TableToJSON(permitsToAssign))
		queryAdd:Insert("app_tenants", util.TableToJSON({}))
		queryAdd:Insert("app_lastactions", util.TableToJSON({}))
		queryAdd:Insert("app_rent", 0)
		queryAdd:Insert("app_payments", util.TableToJSON({}))
		queryAdd:Insert("app_type", sType)
		queryAdd:Insert("app_noassign", string.lower(sType) == "shop" and true or false)
		queryAdd:Insert("app_rentdue", os.time() + (!ix.config.Get("housingTesterMode", false) and 3600 * 24 * 7 * ix.config.Get("housingRentDueInWeeks", 1) or 10))
		queryAdd:Callback(function(result, _, insertID)
			self.apartments[insertID] = {
				name = appName,
				doors = {},
				employees = {},
				permits = permitsToAssign,
				tenants = {},
				lastActions = {},
				rent = 0,
				payments = {},
				type = sType,
				noAssign = string.lower(sType) == "shop" and true or false,
				rentDue = os.time() + (!ix.config.Get("housingTesterMode", false) and 3600 * 24 * 7 * ix.config.Get("housingRentDueInWeeks", 1) or 10)
			}
			if (callback) then
				callback()
			end

			self:SyncApartments(client)
		end)
    queryAdd:Execute()

	if !bNoNotify then
		client:NotifyLocalized("Pomyślnie dodano mieszkanie  "..sType.." o nazwie: "..appName)
	end


end

-- A function to remove an apartment
function PLUGIN:RemoveApartment(client, appName)
	local appID = self:CheckIfApartmentExists(client, appName)
	if appID then
		if self.apartments[appID] then
			for _, doorEntID in pairs(self.apartments[appID].doors) do
				local entDoor = Entity(doorEntID)
				if (IsValid(entDoor) and entDoor:IsDoor()) then
					entDoor:SetNetVar("visible", false)
					entDoor:SetNetVar("name", nil)

					local doorPlugin = ix.plugin.list["doors"]
					if doorPlugin then
						doorPlugin:SaveDoorData()
					end
				end
			end
		end

		self.apartments[appID] = nil

		local queryDelete = mysql:Delete("ix_apartments_"..game.GetMap())
			queryDelete:Where("app_id", appID)
		queryDelete:Execute()

		client:NotifyLocalized("Pomyślnie usunięto mieszkanie: "..appName)
		self:SyncApartments(client)
	else
		client:NotifyLocalized("This apartment does not exist..")
	end
end

-- A function to add a door to an apartment
function PLUGIN:SetApartmentDoor(client, entDoor, appName)
	local existingAppID = self:CheckIfApartmentExists(client, appName)

	if !existingAppID then
		if ix.config.Get("shouldCreateNonExistingApartment", true) then
			client:NotifyLocalized("To mieszkanie nie istniało. Utworzono mieszkanie niepriorytetowe o nazwie "..appName)
			self:CreateApartment(client, appName, true, "normalny", function()
				PLUGIN:SetApartmentDoor(client, entDoor, appName)
			end)
			return
		else
			client:NotifyLocalized("This apartment does not exist.")
			return
		end
	end

	if self:CheckIfDoorAlreadyAdded(client, entDoor) then
		return false
	end

	self.apartments[existingAppID].doors[#self.apartments[existingAppID].doors + 1] = entDoor:EntIndex()

	local doors = {}
	for _, v in pairs(self.apartments[existingAppID].doors) do
		if (IsValid(Entity(v))) then
			local id = Entity(v):MapCreationID()
			if (id == -1) then continue end
			doors[#doors + 1] = id
		end
	end

	if (IsValid(entDoor) and entDoor:IsDoor()) then
		entDoor:SetNetVar("visible", true)

		if (appName:find("%S")) then
			entDoor:SetNetVar("name", appName)
		end

		local doorPlugin = ix.plugin.list["doors"]
		if doorPlugin then
			doorPlugin:SaveDoorData()
		end
	end

    local addDoor = mysql:Update("ix_apartments_"..game.GetMap())
        addDoor:Where("app_id", existingAppID)
		addDoor:Update("app_doors", util.TableToJSON(doors))
    addDoor:Execute()

	client:NotifyLocalized("Pomyślnie dodano te drzwi do "..appName)
	self:SyncApartments(client)
end

-- A function to remove an door from an apartment
function PLUGIN:RemoveApartmentDoor(client, entDoor)
	for appKey, tInfo in pairs(self.apartments) do
		for doorKey, doorIndex in pairs(tInfo.doors) do
			if doorIndex == entDoor:EntIndex() then
				table.remove(self.apartments[appKey].doors, doorKey)

				local doors = {}
				for _, v in pairs(self.apartments[appKey].doors) do
					if (IsValid(Entity(v))) then
						local id = Entity(v):MapCreationID()
						if (id == -1) then continue end
						doors[#doors + 1] = id
					end
				end

				if (IsValid(entDoor) and entDoor:IsDoor()) then
					entDoor:SetNetVar("visible", false)
					entDoor:SetNetVar("name", nil)

					local doorPlugin = ix.plugin.list["doors"]
					if doorPlugin then
						doorPlugin:SaveDoorData()
					end
				end

				local removeDoor = mysql:Update("ix_apartments_"..game.GetMap())
					removeDoor:Where("app_id", appKey)
					removeDoor:Update("app_doors", util.TableToJSON(doors))
				removeDoor:Execute()

				client:NotifyLocalized("Pomyślnie usunięto te drzwi z "..tInfo.name)
				self:SyncApartments(client)
				return true
			end
		end
	end

	client:NotifyLocalized("Te drzwi nie mogły zostać przypisane do mieszkania..")
	return false
end

-- A function to set the rent of an apartment
function PLUGIN:SetApartmentRent(client, appID, entDoor, newRent)
	if (appID) then
		self.apartments[appID].rent = newRent
		if PLUGIN.apartments[appID].type == "shop" then
			for _, shopTerminal in pairs(ents.FindByClass("ix_shopterminal")) do
				shopTerminal:UpdateScreen()
			end
		end
		self:UpdateApartment(appID)
		return true
	end

	if (entDoor) then
		local fetchedID = self:CheckIfDoorAlreadyAdded(client, entDoor, true)
		if (fetchedID) then
			self.apartments[fetchedID].rent = newRent
			self:UpdateApartment(fetchedID)
			client:NotifyLocalized("Ustawiono czynsz "..self.apartments[fetchedID].name.." na "..tostring(newRent).."!")
		else
			client:NotifyLocalized("Te drzwi nie są dodane do żadnego mieszkania!")
		end
	end
end

-- A function to remove a tenant from an apartment
function PLUGIN:RemoveTenant(client, item, appID, bNoNotify)
	local itemCID = (!isnumber(tonumber(item)) and item:GetData("cid") or item)

	if !self.apartments[appID] then
		if !bNoNotify then
			client:NotifyLocalized("Nie udało się znaleźć mieszkania.")
		end

		return
	end

	if !self.apartments[appID].tenants[itemCID] then
		if !bNoNotify then
			client:NotifyLocalized("Nie udało się znaleźć mieszkania z tym CID jako najemca.")

			if !isnumber(tonumber(item)) then
				client:NotifyLocalized("Usunięto przedmiot przypisany do mieszkania.")
				item:SetData("mieszkanie", nil)
			end
		end

		return
	end

	self:LookUpCardItemIDByCID(tostring(itemCID), function(result)
		local idCardID = result[1].idcard or false
		local charID
		if !result then return end
		if !ix.item.instances[idCardID] then
			ix.item.LoadItemByID(idCardID, false, function(card)
				if !card then return end
				charID = card:GetData("owner")
			end)
		else
			charID = ix.item.instances[idCardID]:GetData("owner")
		end

		local permitsToApply = {}
		for k, v in pairs(self.apartments[appID].permits) do
			if v then
				permitsToApply[k] = !v
			end
		end

		local character = ix.char.loaded[charID]
		if character then
			for k, v in pairs(permitsToApply) do
				character:SetPermit(k, v)
			end
		else
			local query = mysql:Select("ix_characters_data")
				query:Where("key", "genericdata")
				query:Where("id", tostring(charID))
				query:Select("data")
				query:Callback(function(genResult)
					if (!istable(genResult) or #genResult == 0) then
						return
					end
					local genericData = util.JSONToTable(genResult[1]["data"])

					for k, v in pairs(permitsToApply) do
						genericData.permits[k] = v
					end
					local removePermits = mysql:Update("ix_characters_data")
					removePermits:Where("id", tostring(charID))
						removePermits:Where("key", "genericdata")
						removePermits:Update("data", util.TableToJSON(genericData))
					removePermits:Execute()
				end)
			query:Execute()
		end
	end)
	self.apartments[appID].tenants[itemCID] = nil
	self.apartments[appID].lastActions[itemCID] = nil
	if !isnumber(tonumber(item)) then
		item:SetData("mieszkanie", nil)
	end

	if !bNoNotify then
		client:NotifyLocalized("Removed the tenant "..itemCID.." from the apartment.")
	end

	if self.apartments[appID].type == "shop" and table.IsEmpty(self.apartments[appID].tenants) then
		for _, shopTerminal in pairs(ents.FindByClass("ix_shopterminal")) do
			shopTerminal:UpdateScreen()
		end
	end

	self:UpdateApartment(appID)

	if !isnumber(tonumber(item)) then return end

	PLUGIN:LookUpCardItemIDByCID(tostring(itemCID), function(result)
		local idCardID = result[1].idcard or false
		if !result then return end

		if !ix.item.instances[idCardID] then
			ix.item.LoadItemByID(idCardID, false, function(cid)
				if !cid then return end
				cid:LoadOwnerGenericData(PLUGIN.RemoveTenantHousing, false, appID)
			end)
		else
			ix.item.instances[idCardID]:LoadOwnerGenericData(PLUGIN.RemoveTenantHousing, false, appID)
		end
	end)
end

function PLUGIN:RemoveEmployee(client, item, appID, bNoNotify)
	local itemCID = (!isnumber(tonumber(item)) and item:GetData("cid") or item)
	if !self.apartments[appID] then
		if !bNoNotify then
			client:NotifyLocalized("Nie udało się znaleźć mieszkania.")
		end

		return
	end

	if !self.apartments[appID].employees[itemCID] then
		if !bNoNotify then
			client:NotifyLocalized("Nie udało się znaleźć mieszkania z tym CID jako pracownik.")
		end

		return
	end

	self:LookUpCardItemIDByCID(tostring(itemCID), function(result)
		local idCardID = result[1].idcard or false
		local charID
		if !result then return end
		if !ix.item.instances[idCardID] then
			ix.item.LoadItemByID(idCardID, false, function(card)
				if !card then return end
				charID = card:GetData("owner")
			end)
		else
			charID = ix.item.instances[idCardID]:GetData("owner")
		end

		local permitsToApply = {}
		for k, v in pairs(self.apartments[appID].permits) do
			if v then
				permitsToApply[k] = !v
			end
		end

		local character = ix.char.loaded[charID]
		if character then
			for k, v in pairs(permitsToApply) do
				character:SetPermit(k, v)
			end
		else
			local query = mysql:Select("ix_characters_data")
				query:Where("key", "genericdata")
				query:Where("id", tostring(charID))
				query:Select("data")
				query:Callback(function(gResult)
					if (!istable(gResult) or #gResult == 0) then
						return
					end
					local genericData = util.JSONToTable(gResult[1]["data"])

					for k, v in pairs(permitsToApply) do
						genericData.permits[k] = v
					end
					local removePermits = mysql:Update("ix_characters_data")
					removePermits:Where("id", tostring(charID))
						removePermits:Where("key", "genericdata")
						removePermits:Update("data", util.TableToJSON(genericData))
					removePermits:Execute()
				end)
			query:Execute()
		end
	end)

	self.apartments[appID].employees[itemCID] = nil
	self.apartments[appID].lastActions[itemCID] = nil

	if !bNoNotify then
		client:NotifyLocalized("Usunięto pracownika "..itemCID.." z mieszkania.")
	end

	self:UpdateApartment(appID)

	if !isnumber(tonumber(item)) then return end
end

-- A function to add a or remove a key to an apartment
function PLUGIN:AddKeyToApartment(client, item, apartment, bRemove, bNoNotify, bEmployee)
	local itemCID = (!isnumber(tonumber(item)) and item:GetData("cid") or item)
	local itemID = (!isnumber(tonumber(item)) and item:GetID() or true)

	if !self.apartments[apartment] then return end
	if !itemCID then return end

	if bRemove and !bEmployee then
		self:RemoveTenant(client, item, apartment)
		return
	elseif bRemove and bEmployee then
		self:RemoveEmployee(client, item, apartment)
		return
	end

	local assignedToShop = false
	local assignedToApp = false
	for appID, tApartment in pairs(self.apartments) do
		if tApartment.tenants[itemCID] or tApartment.employees[itemCID] then
			if tApartment.type == "shop" then
				assignedToShop = appID
			else
				assignedToApp = appID
			end
		end
	end

	if (self.apartments[apartment].type == "shop" and assignedToShop) then
		if !bNoNotify then
			client:NotifyLocalized("Najemca "..itemCID.." jest już przypisany do sklepu "..self.apartments[assignedToShop].name)
		end

		return false
	end

	if (self.apartments[apartment].type != "shop" and assignedToApp) then
		if !bNoNotify then
			client:NotifyLocalized("Najemca  "..itemCID.." jest już przypisany do mieszkania "..self.apartments[assignedToApp].name)
		end

		return false
	end
	if !bEmployee then
		self.apartments[apartment].tenants[itemCID] = {key = itemID, autoPay = true}
		self.apartments[apartment].lastActions[itemCID] = os.time()
	else
		self.apartments[apartment].employees[itemCID] = {key = itemID}
		self.apartments[apartment].lastActions[itemCID] = os.time()
	end

	if !isnumber(tonumber(item)) and !bEmployee then
		item:SetData("mieszkanie", apartment)
	end

	if !bNoNotify and !bEmployee then
		client:NotifyLocalized("Dodano najemcę "..itemCID.." do "..(self.apartments[apartment].type == "shop" and "sklepu " or "mieszkania ")..self.apartments[apartment].name)
	elseif !bNoNotify and bEmployee then
		client:NotifyLocalized("Dodano pracownika "..itemCID.." do "..(self.apartments[apartment].type == "shop" and "sklepu " or "mieszkania ")..self.apartments[apartment].name)
	end

	self:UpdateApartment(apartment)

	return true
end

function PLUGIN:CheckIfCIDExistsLoaded(cid)
	local target = false

	-- Check if CID exists
	local cidCheck = tonumber(cid) != nil and string.utf8len( tostring(cid) ) <= 5
	-- Check for cached characters
	for _, v in pairs(ix.char.loaded) do
		local targetCid = v.GetCid and v:GetCid()
		local name = v.GetName and v:GetName()
		if (cidCheck and targetCid) then
			if string.match( targetCid, cid ) then
				target = v
				break
			end
		elseif name and string.find(name, cid) then
			target = v
			break
		end
	end

	return target
end

function PLUGIN:CheckIfCIDExistsDatabase(cid)
	local target = false
	cid = tostring(cid)

	if (tonumber(cid) != nil and string.utf8len( cid ) <= 5) then
		local query = mysql:Select("ix_characters")
		query:Select("name")
		query:Where("cid", cid)
		query:Where("schema", Schema and Schema.folder or "helix")
		query:Callback(function(result)
			if (!istable(result) or #result == 0) then
				return
			end

			target = result
		end)
		query:Execute()
	end

	return target
end

-- A function to set the CID of a key
function PLUGIN:SetKeyCID(client, item, cid)
	if !cid then
		if item:GetData("mieszkanie") then
			client:NotifyLocalized("Należy najpierw usunąć przypisane mieszkanie.")
			return false
		end

		client:NotifyLocalized("Usunięto CID z klucza.")
		item:SetData("cid", nil)
		return
	end

	if !self:CheckIfCIDExistsLoaded(cid) then
		if !self:CheckIfCIDExistsDatabase(cid) then
			client:NotifyLocalized("Ten CID nie istnieje!")
			return
		end
	end

	item:SetData("cid", cid)
	client:NotifyLocalized("Przypisano CID:  "..cid.." do klucza.")
end

-- A function for the key item to unlock/lock an apartment
function PLUGIN:UnlockLockApartment(keyItem, bUnlock, entDoor)
	local appID = keyItem:GetData("mieszkanie", false)
	local client = keyItem:GetOwner()
	if !appID then return false end

	if self:GetKeyHasAccess(keyItem, entDoor) then
		if (IsValid(client) and client:GetPos():Distance(entDoor:GetPos()) > 96) then
			client:NotifyLocalized("Nie jesteś wystarczająco blisko drzwi!")
			return
		end

		if (entDoor:IsDoor()) then
			local partner = entDoor:GetDoorPartner()
			if entDoor.locked then return end

			if (!bUnlock) then
				if (IsValid(partner)) then
					partner:Fire("lock")
				end

				entDoor:Fire("lock")
				client:EmitSound("doors/door_latch3.wav")

				hook.Run("PlayerLockedDoor", client, entDoor, partner)
			else
				if (IsValid(partner)) then
					partner:Fire("unlock")
				end

				entDoor:Fire("unlock")
				client:EmitSound("doors/door_latch1.wav")

				hook.Run("PlayerUnlockedDoor", client, entDoor, partner)
			end
		end
	end
end

function PLUGIN:GetPriorityApartmentAccess(genericData)
	local loyaltyStatus = genericData.loyaltyStatus
	local tier = tonumber(self:GetNumbersFromText(loyaltyStatus))
	local tierNeeded = tonumber(self:GetNumbersFromText(ix.config.Get("priorityHousingTierNeeded", "POZIOM 4 (NIEBIESKI)")))

	if genericData.loyaltyStatus == "CZŁONEK CAB" then
		return true
	end

	if (!tier or !isnumber(tier)) then
		return false
	end

	if (isnumber(tier) and tier < tierNeeded) then
		return false
	end

	return true
end

-- A function to assign an apartment
function PLUGIN.AssignApartment(idCard, genericData, client, foundApartment)
	if idCard:GetCredits() < ix.config.Get("costForAnApartment", 35) then
		netstream.Start(client, "SendHousingErrorMessage", "NIEWYSTARCZAJĄCA LICZBA KREDYTÓW")
		return
	end

	if !foundApartment then
		netstream.Start(client, "SendHousingErrorMessage", "NIE ZNALEZIONO MIESZKANIA")
		return
	end

	if foundApartment == "priorytetowy" then
		if PLUGIN:GetPriorityApartmentAccess(genericData) then
			foundApartment = PLUGIN:GetWhichApartmentToAssign(foundApartment)
			if !foundApartment then
				netstream.Start(client, "SendHousingErrorMessage", "NIE ZNALEZIONO MIESZKANIA")
				return
			end
		end
	end

	local cid = idCard:GetData("cid", false)
	if !cid then return false end

	for appID, v in pairs(PLUGIN.apartments) do
		if v.type == "shop" then continue end
		if v.tenants[cid] then
			PLUGIN:RemoveTenant(client, cid, appID, true)
		end
	end

	genericData.housing = foundApartment
	local combineutilities = ix.plugin.list["combineutilities"]
	if combineutilities and combineutilities.UpdateGenericData then
		combineutilities:UpdateGenericData(genericData)
	end

	local character = ix.char.loaded[genericData.id]
	if character then
		if !character:GetPurchasedItems()["apartmentkey"] then
			character:SetPurchasedItems("apartmentkey", 1)
		else
			client:NotifyLocalized("Klucz czeka już w Automacie Odbiorczym dla tego CID. Został on zaktualizowany.")
		end
	end

	idCard:TakeCredits(ix.config.Get("costForAnApartment", 35), "Housing", "Kupno mieszkania")
	ix.city.main:AddCredits(ix.config.Get("costForAnApartment", 35))
	PLUGIN:AddKeyToApartment(client, cid, foundApartment, false, true)
	PLUGIN:SyncToOneApartments(client, false, foundApartment, genericData)
end

-- A function to update the assigned itemID of a CID tenant
function PLUGIN:UpdateItemIDTenant(cid, itemID, type)
	for appID, v in pairs(self.apartments) do
		if type:find("shop") and v.type != "shop" then continue end
		if type:find("mieszkanie") and v.type == "shop" then continue end
		if !v.tenants[cid] then continue end
		if v.tenants[cid].key == itemID then break end

		self.apartments[appID].tenants[cid].key = itemID
		self:UpdateApartment(appID)
		break
	end
end
function PLUGIN:UpdateItemIDEmployee(cid, itemID, type)
	for appID, v in pairs(self.apartments) do
		if type:find("shop") and v.type != "shop" then continue end
		if type:find("mieszkanie") and v.type == "shop" then continue end
		if !v.employees[cid] then continue end
		if v.employees[cid].key == itemID then break end
		self.apartments[appID].employees[cid].key = itemID
		self:UpdateApartment(appID)
		break
	end
end
-- A function to handle the apartment assignment request
function PLUGIN:HandleAssignment(client, cid, type)
	cid = self:HasCIDInInventory(client, cid)
	if !cid then return false end

	local foundApartment = type
	if type != "priorytetowy" then
		foundApartment = self:GetWhichApartmentToAssign(type)
	end

	cid:LoadOwnerGenericData(self.AssignApartment, false, client, foundApartment)
end

function PLUGIN:CheckTenantInteraction()
	local interactionWeeks = ix.config.Get("tenantDoorInteractionCheck", 2)
	for appID, tApartment in pairs(self.apartments) do
		for cid, time in pairs(tApartment.lastActions) do
			if (os.time() < (tonumber(time) + 3600 * 24 * 7 * interactionWeeks)) then continue end
			self:RemoveTenant(false, cid, appID, true)
		end
	end
end

function PLUGIN:LookUpCardItemIDByCID(cid, callback)
	local query = mysql:Select("ix_characters")
	query:Select("idcard")
	query:WhereIn("cid", cid)
	query:Callback(function(result)
		if (!istable(result) or #result == 0) then
			return
		end

		if (callback) then
			callback(result)
		end
	end)

	query:Execute()
end

function PLUGIN:PayRentOnCheck(idCard, individualRent, cid, appID)
	local credits = idCard and idCard.GetCredits and idCard:GetCredits()
	local madePayment = false

	if (!idCard or (idCard and !credits)) then
		return false
	end

	if (idCard and credits) and (credits >= individualRent) then
		idCard:TakeCredits(individualRent, "Housing", "Czynsz")
		ix.city.main:AddCredits(individualRent)
		if self.apartments[appID].payments[cid] then
			self.apartments[appID].payments[cid] = {amount = individualRent + self.apartments[appID].payments[cid].amount, date = os.time()}
		else
			self.apartments[appID].payments[cid] = {amount = individualRent, date = os.time()}
		end

		madePayment = cid
	else
		self:RemoveTenant(false, cid, appID, true)
	end

	return madePayment
end

function PLUGIN:CheckRentPayments()
	for appID, tApartment in pairs(self.apartments) do
		if os.time() < tonumber(tApartment.rentDue) then continue end
		local remainingRent = self:GetRemainingRent(tApartment)
		if !remainingRent then return end
		if remainingRent <= 0 then self:ResetRent(appID) continue end

		local tenantCount = table.Count(tApartment.tenants)
		local individualRent = math.ceil( tApartment.rent / tenantCount )

		for tenantCID, _ in pairs(tApartment.tenants) do
			local madePayment = false
			if tApartment.tenants[tenantCID].autoPay then
				self:LookUpCardItemIDByCID(tenantCID, function(result)
					local idCardID = result[1].idcard or false
					if !idCardID then
						ix.log.AddRaw("[HOUSING] "..tenantCID.." został usunięty z mieszkania "..appID..". Powód: false/nil idCardID.")
						self:RemoveTenant(false, tenantCID, appID, true)
						return
					end

					if !ix.item.instances[tonumber(idCardID)] then
						ix.item.LoadItemByID(tonumber(idCardID), false, function(item)
							if !item then
								ix.log.AddRaw("[HOUSING] "..tenantCID.." Przedmiot CID nie został znaleziony podczas przetwarzania płatności czynszu offline za ID mieszkaniowego: "..appID..".")
								return
							end
							madePayment = self:PayRentOnCheck(ix.item.instances[tonumber(idCardID)], individualRent, tenantCID, appID)
						end)
					else
						madePayment = self:PayRentOnCheck(ix.item.instances[tonumber(idCardID)], individualRent, tenantCID, appID)
					end

					timer.Simple(10, function()
						if !madePayment then
							ix.log.AddRaw("[HOUSING] "..tenantCID.." nie dokonał automatycznej płatności, zaznaczono brak automatycznych płatności przed usunięciem z ID mieszkaniowego: "..appID..".")
							self:CheckNoAutoPayments(tApartment, appID, tenantCID)
						end
					end)
				end)
			end
		end

		timer.Simple(6, function()
			self:ResetRent(appID)
		end)
	end
end

function PLUGIN.RemovePermitsGeneric(idCard, genericData)
	genericData.permits = {}

	local combineutilities = ix.plugin.list["combineutilities"]
	if combineutilities and combineutilities.UpdateGenericData then
		combineutilities:UpdateGenericData(genericData)
	end
end

function PLUGIN:RemovePermits(tenantCID)
	tenantCID = Schema:ZeroNumber(tenantCID, 5)

	PLUGIN:LookUpCardItemIDByCID(tostring(tenantCID), function(result)
		local idCardID = result[1].idcard or false
		if !result then return end

		if !ix.item.instances[idCardID] then
			ix.item.LoadItemByID(idCardID, false, function(item)
				if !item then return end
				item:LoadOwnerGenericData(PLUGIN.RemovePermitsGeneric, false)
			end)
		else
			ix.item.instances[idCardID]:LoadOwnerGenericData(PLUGIN.RemovePermitsGeneric, false)
		end
	end)
end

function PLUGIN:CheckNoAutoPayments(tApartment, appID, tenantCID)
	local tenantCount = table.Count(tApartment.tenants)
	local individualRent = math.ceil( tApartment.rent / tenantCount )

	if !tApartment.payments[tenantCID] then
		ix.log.AddRaw("[HOUSING] "..tenantCID.." w ogóle nie dokonywał ręcznych płatności, usunięto ID mieszkaniowe: "..appID..".. dev check: "..tonumber(isnumber(tenantCID)))
		self:RemoveTenant(false, tenantCID, appID, true)

		if tApartment.type == "shop" then
			self:RemovePermits(tenantCID)
		end

		return
	end

	for paymentCID, tPayments in pairs(tApartment.payments) do
		if tPayments.paidAmount and individualRent then
			if tPayments.paidAmount >= individualRent then continue end
		end

		if !tApartment.tenants[paymentCID] then continue end

		if tApartment.type == "shop" then
			self:RemovePermits(paymentCID)
		end

		ix.log.AddRaw("[HOUSING] "..paymentCID.." nie zapłacił ręcznie powyżej indywidualnego czynszu, usunięto z ID mieszkaniowego: "..appID..".. dev check: "..isnumber(paymentCID))
		self:RemoveTenant(false, paymentCID, appID, true)
	end
end

function PLUGIN:ResetRent(appID)
	self.apartments[appID].payments = {}
	self.apartments[appID].rentDue = self.apartments[appID].rentDue + (!ix.config.Get("housingTesterMode", false) and 3600 * 24 * 7 * ix.config.Get("housingRentDueInWeeks", 1) or 10)
	self:UpdateApartment(appID)
end

function PLUGIN:PreCharacterDeleted(client, character)
	local cid = character:GetCid()
	if !cid then return end

	for appID, tApartment in pairs(self.apartments) do
		if !tApartment.tenants[cid] then continue end

		self:RemoveTenant(client, cid, appID, true)
	end
end

function PLUGIN:OnCharacterBanned(character)
	local cid = character:GetCid()
	if !cid then return end

	for appID, tApartment in pairs(self.apartments) do
		if !tApartment.tenants[cid] then continue end

		self:RemoveTenant(false, cid, appID, true)
	end
end

function PLUGIN:OnCharacterBannedByID(charID)
	if (!ix.plugin.list.cid) then return end
	if !ix.plugin.list.cid.GenerateCID then return end
	local cid = ix.plugin.list.cid:GenerateCID(charID)

	for appID, tApartment in pairs(self.apartments) do
		if !tApartment.tenants[cid] then continue end

		self:RemoveTenant(false, cid, appID, true)
	end
end

do
	timer.Create("ixHousingCheckInteractionAndRent", ix.config.Get("housingCheckInteractionAndRentTimer", 20) * 60, 0, function()
		PLUGIN:CheckTenantInteraction()
		PLUGIN:CheckRentPayments()
	end)

	function PLUGIN.UpdateInteractionTimer(oldVal, newVal)
		timer.Adjust("ixHousingCheckInteractionAndRent", newVal * 60)
	end
end