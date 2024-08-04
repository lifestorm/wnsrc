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

ix.command.Add("ShowAllApartments", {
	description = "Shows all apartments with some options.",
    privilege = "Manage Apartments",
    OnRun = function(self, client)
		netstream.Start(client, "ixHousingShowAllApartments")
    end
})

ix.command.Add("CreateApartment", {
	description = "Creates an apartment group.",
    privilege = "Manage Apartments",
    arguments = ix.type.text,
    OnRun = function(self, client, apartmentName)
		PLUGIN:CreateApartment(client, apartmentName, false, "normalny")
    end
})

ix.command.Add("CreatePriorityApartment", {
	description = "Creates an apartment group for loyalists.",
    privilege = "Manage Apartments",
    arguments = ix.type.text,
    OnRun = function(self, client, apartmentName)
		PLUGIN:CreateApartment(client, apartmentName, false, "priorytetowy")
    end
})

ix.command.Add("CreateShop", {
	description = "Creates an apartment group for shops.",
    privilege = "Manage Apartments",
    arguments = ix.type.text,
    OnRun = function(self, client, apartmentName)
		PLUGIN:CreateApartment(client, apartmentName, false, "shop")
    end
})

ix.command.Add("RemoveApartment", {
	description = "Removes an apartment group.",
    privilege = "Manage Apartments",
    arguments = ix.type.text,
    OnRun = function(self, client, apartmentName)
		PLUGIN:RemoveApartment(client, apartmentName)
    end
})

ix.command.Add("SetApartmentDoor", {
	description = "Adds the door you are looking at to an apartment group and creates a non-priority group if it doesn't exist.",
    privilege = "Manage Apartments",
    arguments = ix.type.text,
    OnRun = function(self, client, apartmentName)
		local targetDoor = client:GetEyeTrace().Entity
		if (IsValid(targetDoor) and targetDoor:IsDoor()) then
			PLUGIN:SetApartmentDoor(client, targetDoor, apartmentName)
		else
			client:NotifyLocalized("You are not looking at a valid door!")
		end
    end
})

ix.command.Add("RemoveApartmentDoor", {
	description = "Removes the door you are looking at from an apartment group.",
    privilege = "Manage Apartments",
    OnRun = function(self, client)
		local targetDoor = client:GetEyeTrace().Entity
		if (IsValid(targetDoor) and targetDoor:IsDoor()) then
			PLUGIN:RemoveApartmentDoor(client, targetDoor)
		else
			client:NotifyLocalized("You are not looking at a valid door!")
		end
    end
})

ix.command.Add("GetDoorApartment", {
	description = "Gets the apartment group the door you are looking at is assigned to.",
    privilege = "Manage Apartments",
    OnRun = function(self, client)
		local targetDoor = client:GetEyeTrace().Entity
		if (IsValid(targetDoor) and targetDoor:IsDoor()) then
			PLUGIN:GetDoorApartment(client, targetDoor)
		else
			client:NotifyLocalized("You are not looking at a valid door!")
		end
    end
})

ix.command.Add("SetApartmentRent", {
	description = "Sets the rent of an apartment group by the door you are looking at.",
    privilege = "Manage Apartments",
    arguments = ix.type.number,
    OnRun = function(self, client, rent)
		local targetDoor = client:GetEyeTrace().Entity
		if (IsValid(targetDoor) and targetDoor:IsDoor()) then
			PLUGIN:SetApartmentRent(client, false, targetDoor, rent)
		else
			client:NotifyLocalized("You are not looking at a valid door!")
		end
    end
})

ix.command.Add("AssignApartment", {
	description = "Assigns a character the first found apartment with 0-2 tenants until found (types: normal, priority).",
    privilege = "Manage Apartments",
    arguments = {ix.type.character, ix.type.string},
    OnRun = function(self, client, character, appType)
		if appType then
			if string.lower(appType) == "shop" then
				client:NotifyLocalized("This command does not assign people to shops..")
				return
			end
		end

		if (character) then
			local appID = PLUGIN:GetWhichApartmentToAssign(appType)
			if (appID) then
				for oldAppID, v in pairs(PLUGIN.apartments) do
					if v.type == "shop" then continue end
					
					if v.tenants[character:GetCid()] then
						client:NotifyLocalized("This character's CID is already assigned to the apartment: "..v.name.."!")
						PLUGIN:AddKeyToApartment(client, character:GetCid(), oldAppID, true)
						return false
					end
				end

				if PLUGIN.apartments[appID].tenants[character:GetCid()] then
					PLUGIN:AddKeyToApartment(client, character:GetCid(), appID, true)
				else
					PLUGIN:AddKeyToApartment(client, character:GetCid(), appID)
				end
			else
				client:NotifyLocalized("Could not find a suitable apartment!")
			end
		else
			client:NotifyLocalized("Could not find the character!")
		end
    end
})

ix.command.Add("SetApartmentTenant", {
	description = "Sets/Removes the tenant of an apartment group by the door you are looking at.",
    privilege = "Manage Apartments",
    arguments = ix.type.character,
    OnRun = function(self, client, character)
		local targetDoor = client:GetEyeTrace().Entity
		if (IsValid(targetDoor) and targetDoor:IsDoor()) then
			if character then
				local appID = PLUGIN:CheckIfDoorAlreadyAdded(client, targetDoor, true)
				if !appID then
					client:NotifyLocalized("This door is not allocated to any apartment.")
					return
				end

				if PLUGIN.apartments[appID].type == "shop" then
					client:NotifyLocalized("This command cannot add tenants to a shop.")
					return
				end

				local bFound = false
				local inventory = character:GetInventory()

				for _, v in pairs(inventory:GetItems()) do
					if v.uniqueID != "apartmentkey" then continue end
					if v.shop then continue end

					if !v:GetData("mieszkanie", false) then
						if v:GetData("cid", false) and v:GetData("cid", false) == character:GetCid() then
							bFound = v
							break
						end
					end

					if v:GetData("mieszkanie", false) and v:GetData("mieszkanie", false) == appID then
						bFound = v
						break
					end
				end

				if bFound then
					local otherAccess = PLUGIN:GetKeyAlreadyHasOtherAccess(bFound)

					if otherAccess then
						if bFound:GetData("mieszkanie") then
							bFound:RemoveApartment()
							return
						else
							bFound:RemoveApartment(otherAccess)
							return
						end
					end

					bFound:AssignToApartment(appID)

					return
				end

				if PLUGIN.apartments[appID].tenants[character:GetCid()] then
					PLUGIN:AddKeyToApartment(client, character:GetCid(), appID, true)
				else
					PLUGIN:AddKeyToApartment(client, character:GetCid(), appID)
				end
			else
				client:NotifyLocalized("Could not find the character!")
			end
		else
			client:NotifyLocalized("You are not looking at a valid door!")
		end
    end
})

ix.command.Add("ToggleApartmentNoAssign", {
	description = "Toggles apartment capability of automatic assignment via terminal by the door you are looking at.",
    privilege = "Manage Apartments",
    OnRun = function(self, client)
		local targetDoor = client:GetEyeTrace().Entity
		if (IsValid(targetDoor) and targetDoor:IsDoor()) then
			local appID = PLUGIN:CheckIfDoorAlreadyAdded(client, targetDoor, true)
			PLUGIN:ToggleApartmentNoAssign(client, appID)
		end
	end
})