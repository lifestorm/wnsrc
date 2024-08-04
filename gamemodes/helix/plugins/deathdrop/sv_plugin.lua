--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix
local IsValid = IsValid
local pairs = pairs
local isfunction = isfunction
local table = table
local ents = ents
local hook = hook
local ipairs = ipairs


local PLUGIN = PLUGIN

ix.log.AddType("droppedItems", function(client, text)
    return text
end)

function PLUGIN:TransferItem(client, itemTable, curInv, inventory)
    itemTable.player = client
    if (itemTable:GetData("equip") == true and itemTable.functions.EquipUn) then
        itemTable.functions.EquipUn.OnRun(itemTable)
    end

    if (itemTable.OnTransferred) then
        itemTable:OnTransferred(curInv, inventory)
    end

    if (itemTable.OnDrop) then
        itemTable:OnDrop()
    end

    local x, y = itemTable.gridX, itemTable.gridY
    local w, h = itemTable.width, itemTable.height

    if (!x or !y or !inventory:CanItemFit(x, y, w, h)) then
        x, y = inventory:FindEmptySlot(w, h)
    end

    itemTable.authorized = true
    itemTable:Transfer(inventory:GetID(), x, y)

    local entity = itemTable:GetEntity()

    if (IsValid(entity)) then
        itemTable:GetEntity():Remove()
    end

    itemTable.player = nil
    itemTable.authorized = nil
end

function PLUGIN:ShouldCharacterDropItems(client)
    if (!ix.config.Get("dropItems")) then
        return false
    end

    local character = client:GetCharacter()

    if (character) then
        local faction = character:GetFaction()

        if (faction) then
            local factionTable = ix.faction.Get(faction)

            if (factionTable.saveItemsAfterDeath) then
                return false
            end
        end
    else
        return false
    end
end

function PLUGIN:PlayerDeath(client, inflictor, attacker)
    if (hook.Run("ShouldCharacterDropItems", client) != false) then
        local clientInv = client:GetCharacter():GetInventory()
        local droppedItems = {}
        local items = {}

        for _, v in pairs(clientInv:GetItems()) do
            if (v.isBag) then continue end

            if (v.OnDeathDrop) then
                v:OnDeathDrop(client, items, droppedItems)
            elseif ((isfunction(v.KeepOnDeath) and v:KeepOnDeath(client) or v.KeepOnDeath) != true) then
                table.insert(items, v)
                table.insert(droppedItems, v:GetID())
                if (v.OnDoDeathDrop) then
                    v:OnDoDeathDrop(client, items, droppedItems)
                end
            end
        end


        if (!table.IsEmpty(items)) then
            local container = ents.Create("ix_drop")
            container:SetPos(client:GetPos())
            container:SetModel(ix.config.Get("dropContainerModel", "models/props_c17/BriefCase001a.mdl"))
            container:Spawn()

            hook.Run("PreDropCharacterInventory", client, items, container)

            ix.inventory.New(0, "droppedItems", function(inventory)
                inventory.vars.isBag = false
                inventory.vars.isDrop = true

                function inventory.OnAuthorizeTransfer(_, _, _, itemTable)
                    if (itemTable.authorized) then
                        return true
                    end
                end

                if (IsValid(container)) then
                    container:SetInventory(inventory)
                    inventory.vars.entity = container

                    for _, v in pairs(items) do
                        self:TransferItem(client, v, clientInv, inventory)
                    end

                    ix.saveEnts:SaveEntity(container)
                    hook.Run("PostDropCharacterInventory", client, items, container, inventory)
                else
                    ix.item.inventories[inventory.id] = nil

                    local query = mysql:Delete("ix_items")
                        query:Where("inventory_id", inventory.id)
                    query:Execute()

                    query = mysql:Delete("ix_inventories")
                        query:Where("inventory_id", inventory.id)
                    query:Execute()
                end
            end)

            client:GetCharacter():SetRefundItems(droppedItems)

            local logString = client:Name().." has dropped:"
            for _, v in ipairs(items) do
                if (!v.maxStackSize or v.maxStackSize == 1) then
                    logString = logString.." "..v:GetName().." (#"..v:GetID()..");"
                else
                    logString = logString.." "..v:GetStackSize().."x "..v:GetName().." (#"..v:GetID()..");"
                end
            end
            ix.log.Add(client, "droppedItems", logString)
        end
    end
end

function PLUGIN:PostDropCharacterInventory(client, items, container, inventory)
	for k, v in pairs(inventory:GetItems()) do
		if (v.replaceOnDeath) then
			local newItem = v.replaceOnDeath
			v:Remove()

            if (ix.item.list[v.replaceOnDeath]) then
			    inventory:Add(newItem)
            end
		end
	end
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_drop", true, true, true, {
		OnSave = function(entity, data) --OnSave
			local inventory = entity:GetInventory()
			data.invID = inventory:GetID()
            data.model = entity:GetModel()
            data.name = entity.name
            data.password = entity.password
            data.money = entity:GetMoney()
		end,
		OnRestore = function(entity, data) --OnRestore
            entity:SetModel(data.model)
            entity:SetSolid(SOLID_VPHYSICS)
            entity:PhysicsInit(SOLID_VPHYSICS)

            if (data.password) then
                entity.password = data.password
                entity:SetLocked(true)
                entity.Sessions = {}
            end

            if (data.name) then
                entity.name = data.name
                entity:SetDisplayName(data.name)
            end

            if (data.money) then
                entity:SetMoney(data.money)
            end

            ix.inventory.Restore(data.invID, ix.config.Get("inventoryWidth"), ix.config.Get("inventoryHeight"), function(inventory)
                inventory.vars.isBag = false
                inventory.vars.isDrop = true

                if (IsValid(entity)) then
                    entity:SetInventory(inventory)
                    inventory.vars.entity = entity
                end
            end)
		end,
		ShouldSave = function(entity) --ShouldSave
			return entity:GetInventory() and entity:GetInventory() != 0
		end,
		ShouldRestore = function(data) --ShouldRestore
			return data.invID >= 1
		end
	})
end