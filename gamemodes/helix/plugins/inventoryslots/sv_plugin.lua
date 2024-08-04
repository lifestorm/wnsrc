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

util.AddNetworkString("ixOnBagItemTransferred")
util.AddNetworkString("ixSlotsSyncPlayerToItem")
util.AddNetworkString("ixSyncBagSlots")
util.AddNetworkString("ixSwitchPlayerInv")

function PLUGIN:OpenInventory(client, target, bShouldNotLog)
    if (!IsValid(client) or !IsValid(target)) then return end
    if (!target:IsPlayer()) then return end

    local character = target:GetCharacter()
    if (!character) then return end

    local equipInvID = character.GetEquipInventory and character:GetEquipInventory()
    local equipInv = ix.item.inventories[equipInvID] or false

    local localChar = client.GetCharacter and client:GetCharacter()
    local localPlayer = localChar.GetPlayer and localChar:GetPlayer()
    
    if (equipInv) then
        local name = target:Name().."'s equip inventory"

        ix.storage.Open(client, equipInv, {
            entity = target,
            name = name,
            OnPlayerClose = function()
                if (!bShouldNotLog) then
                    ix.log.Add(client, "bastionInvClose", name)
                else
                    if (localChar) then
                        if equipInv.owner and equipInv.owner == localChar:GetID() then
                            if localPlayer and IsValid(localPlayer) then
                                equipInv:AddReceiver(localPlayer)
                            end
                        end
                    end
                end
            end
        })

        
        if (localChar) then
            localChar:GetInventory():AddReceiver(client)
        end

        if (!bShouldNotLog) then
            ix.log.Add(client, "bastionInvSearch", name)
        end
    end
end

function PLUGIN:CharacterReceiveEqInv(client, character)
    local equipInvID = character:GetEquipInventory()
    local equipInv = ix.item.inventories[equipInvID]
    if !equipInv then return end

    assert(IsValid(client) and client:IsPlayer(), "expected valid player")
    assert(type(equipInv) == "table" and equipInv:IsInstanceOf(ix.meta.inventory), "expected valid inventory")

    equipInv:AddReceiver(client)
    equipInv:Sync(client)
end

function PLUGIN:CharacterLoaded(character)
    local client = character:GetPlayer()
    if (character:GetEquipInventory() == 0) then
        ix.inventory.New(character:GetID(), "equipInventory", function(inventory)
            inventory.vars.isEquipSlots = true
            inventory.vars.equipSlots = self.slots

            inventory:SetOwner(character:GetID())
            character:SetEquipInventory(inventory:GetID())

            self:CharacterReceiveEqInv(client, character)
        end)
    else
        self:CharacterReceiveEqInv(client, character)
    end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
    local equipInv = character.GetEquipInventory and character:GetEquipInventory()
    local invItems = character:GetInventory():GetItems()

    if !equipInv then return end
    if !isnumber(equipInv) then return end
    if equipInv <= 0 then return end

    if (character:GetData("equipBgClothes")) then
        character:SetData("equipBgClothes", nil)

        for i = 1, 2 do
            for _, itemTable in pairs(invItems) do
                if !itemTable.outfitCategory then continue end
                if itemTable.isBag then continue end
                if itemTable.base == "base_maskcp" and i == 1 then continue end
                if itemTable.base != "base_maskcp" and i == 2 then continue end

                if ix.item.inventories[equipInv] then
                    local bSuccess, _ = itemTable:Transfer(equipInv, 1, self.slots[itemTable.outfitCategory])
                    if (bSuccess) then
                        itemTable.functions.Equip.OnRun(itemTable, client)
                    end
                end
            end
        end
    end
end

function PLUGIN:ShouldRestoreInventory(charID, invID, invType)
    if invType != "equipInventory" then return end
    if !invID then return end
    invID = tonumber(invID)

    ix.inventory.Restore(invID, self.slotsW, self.slotsH, function(inventory)
        inventory.vars.isEquipSlots = true
        inventory.vars.equipSlots = self.slots
        
        inventory:SetOwner(charID)
    end)
    
    return false
end

function PLUGIN:SyncAlreadyEquipped(owner)
    if !owner or owner and !IsValid(owner) then return end

    local character = owner.GetCharacter and owner:GetCharacter()
    if !character then return end

    local inventory = character.GetInventory and character:GetInventory()
    if !inventory then return end

    for _, v in pairs (inventory:GetItems()) do
        if v.outfitCategory and v:GetData("equip", false) then
            local eqInv = v.invID and ix.item.inventories[v.invID]
            if eqInv and eqInv.vars and eqInv.vars.isEquipSlots then
                local itemFunctions = v.functions
                if !itemFunctions or itemFunctions and !itemFunctions.Equip then return end
            
                itemFunctions.Equip.OnRun(v, owner)
    
                if v.postHooks.Equip then
                    v.postHooks.Equip(v, owner)
                end
            end
        end
    end
end

function PLUGIN:InventoryItemAdded(oldInv, inventory, newItem)
    local owner = self:IsSameOwner(oldInv, inventory)
    local oldInvOwner = oldInv and oldInv.GetOwner and oldInv:GetOwner()
    local newInvOwner = inventory and inventory.GetOwner and inventory:GetOwner()

    if !owner and !oldInvOwner and !newInvOwner then return end

    if !inventory.vars then return end
    if !inventory.vars.equipSlots then
        if oldInv and oldInv.vars and oldInv.vars.equipSlots then
            local itemFunctions = newItem.functions
            if !itemFunctions or itemFunctions and !itemFunctions.EquipUn then return end

            if !owner and IsValid(oldInvOwner) then owner = oldInvOwner end
            if !owner then return end

            if itemFunctions.EquipUn.OnCanRun and itemFunctions.EquipUn.OnCanRun(newItem, owner) then
                itemFunctions.EquipUn.OnRun(newItem, owner)

                if newItem.postHooks.EquipUn then
                    newItem.postHooks.EquipUn(newItem, owner)
                end

                if newItem.outfitCategory == "model" then
                    self:SyncAlreadyEquipped(owner)
                end

                if (inventory) then
                    inventory:Sync(owner)
                end

                net.Start("ixSyncBagSlots")
                net.Send(owner)
            end
        end
        
        return
    end

    if !owner and IsValid(newInvOwner) then owner = newInvOwner end
    if !owner then return end

    local itemFunctions = newItem.functions
    if !itemFunctions or itemFunctions and !itemFunctions.Equip then return end

    if itemFunctions.Equip.OnCanRun and itemFunctions.Equip.OnCanRun(newItem, owner) then
        itemFunctions.Equip.OnRun(newItem, owner)
        if oldInvOwner and IsValid(oldInvOwner) then
            inventory:Sync(oldInvOwner)
        end

        if newItem.postHooks.Equip then
            newItem.postHooks.Equip(newItem, owner)
        end

        net.Start("ixSyncBagSlots")
        net.Send(owner)
    end

    net.Start("ixSlotsSyncPlayerToItem")
    net.WriteUInt(newItem.id, 32)
    net.Send(owner)
end

function PLUGIN:OnBagItemTransferred(item, curInv, inventory)
    local owner = self:IsSameOwner(curInv, inventory)
    if !owner then return end

    net.Start("ixOnBagItemTransferred")
        net.WriteUInt(tonumber(item.id), 32)
        net.WriteUInt(tonumber(inventory.id), 32)
    net.Send(owner)

    net.Start("ixSyncBagSlots")
    net.Send(owner)
end

function PLUGIN:OnStorageReceiverRemoved(client, inventory)
    if !client or client and !IsValid(client) then return end

    local switchingInv = client.switchingPlayerInv
    if !switchingInv then return end

    local owner = switchingInv and tonumber(switchingInv.owner)
    if !owner then return end

    local char = ix.char.loaded[owner]
    if !char then return end

    local faction = char.GetFaction and char:GetFaction()

    if faction and self.noEquipFactions and self.noEquipFactions[char:GetFaction()] then
        client:Notify("This character does not have equip slots!")
        return false
    end

    local target = char.GetPlayer and char:GetPlayer()
    if !target or target and !IsValid(target) then return end

    if !switchingInv.eqSlots then
        self:OpenInventory(client, target, true)
    else
        Schema:SearchPlayer(client, target)
    end

    client.switchingPlayerInv = nil
end

net.Receive("ixSwitchPlayerInv", function(length, client)
    local inventory = client.ixOpenStorage
    if !inventory then return end

    local isEquipSlots = inventory.vars and inventory.vars.isEquipSlots or false
    client.switchingPlayerInv = {eqSlots = isEquipSlots, owner = inventory.owner}

    ix.storage.RemoveReceiver(client, inventory)
end)