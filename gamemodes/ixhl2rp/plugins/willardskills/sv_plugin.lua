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

-- Replace the Schema function concerning combine doors
function PLUGIN:PlayerUseDoor(client, door)
	if (!IsValid(client)) then return end

	if (!door:HasSpawnFlags(256) and !door:HasSpawnFlags(1024)) and door:GetNetVar("combineDoor") then -- Make sure we're dealing with a combine door before doing anything
		if (client:HasActiveCombineSuit() or ix.faction.Get(client:Team()).allowCombineDoors) then
			return
		end

		local character = client:GetCharacter()
		if (character) then
			local idCards = character:GetInventory():GetItemsByUniqueID("id_card")

			if (!istable(idCards)) then return false end

			-- if no id card do nothing
			if (#idCards == 0) then
				return false
			else
				-- check for access
				for _, v in pairs(idCards) do
					if (v.data and v.data.doorAccess and istable(v.data.doorAccess) and table.HasValue(v.data.doorAccess, door:MapCreationID())) then
						if (v:GetData("active") == true) then
							door:Fire("open")
							return true
						else
							ix.combineNotify:AddImportantNotification("WRN:// Inactive Identification Card #" .. v:GetData("cid", 00000) .. " on " .. door:GetNetVar("name") .. " ingress", nil, client, door:GetPos())
						
							return false
						end
					end
				end
			end
		end
	end
end

netstream.Hook("SetDoorAccessCID", function(client, doorEntity, charID)
	if (client:Team() != FACTION_ADMIN) then return end

	if !ix.char.loaded[charID] then
		return false
	end

	local character = ix.char.loaded[charID]

	if !character:GetIdCard() then
		return false
	end

	local cardId = character:GetIdCard()

	if !ix.item.instances[cardId] then
		return false
	end

	local CID = ix.item.instances[cardId]
	local doorAccess = CID:GetData("doorAccess", {})

	if table.HasValue(doorAccess, doorEntity:MapCreationID()) then
		for k, v in pairs(doorAccess) do
			if v == doorEntity:MapCreationID() then
				table.remove(doorAccess, k)
				CID:SetData("doorAccess", doorAccess)

				client:NotifyLocalized("This CID already has access, removed access.")
				return
			end
		end
	end

	table.insert(doorAccess, doorEntity:MapCreationID())
	CID:SetData("doorAccess", doorAccess)

	client:NotifyLocalized("Access given to the CID.")
end)

-- Open crafting menu on E crafting table
function PLUGIN:OnItemSpawned(entity)
	local item = entity:GetItemTable()
	if item.uniqueID == "tool_craftingbench" then
		entity.Use = function(ent, activator, caller)
			local itemTable = ent:GetItemTable()

			if (IsValid(caller) and caller:IsPlayer() and caller:GetCharacter() and itemTable) then
				itemTable.player = caller
				itemTable.entity = ent

				if (itemTable.functions.take.OnCanRun(itemTable)) then
					caller:PerformInteraction(ix.config.Get("itemPickupTime", 0.5), ent, function(client)
						if (!ix.item.PerformInventoryAction(client, "take", ent)) then
							return false -- do not mark dirty if interaction fails
						end
					end)
				end

				itemTable.player = nil
				itemTable.entity = nil
			end

			-- Shitty workaround for quicktapping a button
			if activator:KeyPressed(IN_USE) then
				timer.Simple(0.1, function()
					if activator then
						if !activator:KeyDown(IN_USE) then
							if activator:GetCharacter() then
								netstream.Start(activator, "OpenCraftingMenu")
							end
						end
					end
				end)
			end
		end
	end
end