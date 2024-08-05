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

GetConVar("arccw_attinv_lockmode"):SetBool(true)

function PLUGIN:DoPlayerDeath(client, attacker, dmg)
    local character = client:GetCharacter()
    local inv = character:GetInventory()

    for _, item in pairs(inv:GetItemsByBase("base_arccw")) do
        item:BreakWeapon(client)
    end
end

function ArcCW:PlayerGiveAtt(client, attachment, amount)
    amount = amount or 1

    local attachmentData = ArcCW.AttachmentTable[attachment]
    if (!attachmentData or attachmentData.Free) then return end

    if (!IsValid(client) or !client.ixDeattachAttempt) then return end

    local character = client:GetCharacter()
	if (!character) then return end

    if (attachmentData.AdminOnly and !(client:IsPlayer() and client:IsAdmin())) then return false end

    if (attachmentData.InvAtt) then
        attachment = attachmentData.InvAtt
    end

    local deattachAttempt = client.ixDeattachAttempt
    local weapon = deattachAttempt.weapon
    local slot = deattachAttempt.slot

    client.ixDeattachAttempt = nil
    if (!weapon.ixItem) then return end

    for _, v in pairs(weapon.ixItem.defaultAttachments) do
        if (v == attachment) then
            local data = weapon.ixItem:GetData("WeaponDefaultAttachmentsUnequipped", {})
            data[v] = true
            weapon.ixItem:SetData("WeaponDefaultAttachmentsUnequipped", data)
            return
        end
    end

    local attData = weapon.ixItem:GetData("WeaponAttachments", {})

    local itemID = attData[slot].itemID
    PLUGIN:RefundAttachment(weapon, character, itemID)

    attData[slot] = nil

    if (!table.IsEmpty(attData)) then
        weapon.ixItem:SetData("WeaponAttachments", attData)
    else
        weapon.ixItem:SetData("WeaponAttachments", nil)
    end
end

function ArcCW:PlayerTakeAtt(client, attachment, amount)
    amount = amount or 1

    local attachmentData = ArcCW.AttachmentTable[attachment]
    if (!attachmentData or attachmentData.Free) then return end

    if (!IsValid(client) or !client.ixAttachAttempt) then return end

	local character = client:GetCharacter()
	if (!character) then return end

    if (attachment != client.ixAttachAttempt.attachment) then return end

    if (attachmentData.InvAtt) then
        attachment = attachmentData.InvAtt
    end

    local attachAttempt = client.ixAttachAttempt
    local weapon = attachAttempt.weapon
    local slot = attachAttempt.slot
    client.ixAttachAttempt = nil

    if (!weapon.ixItem) then return end

    if (attachAttempt.mode == "reattach") then
        return true
    elseif (attachAttempt.mode == "default") then
        for _, v in pairs(weapon.ixItem.defaultAttachments) do
            if (v == attachment) then
                local data = weapon.ixItem:GetData("WeaponDefaultAttachmentsUnequipped", {})
                data[v] = nil
                weapon.ixItem:SetData("WeaponDefaultAttachmentsUnequipped", data)
                break
            end
        end
        return true
    elseif (attachAttempt.mode == "item") then
        local attData = weapon.ixItem:GetData("WeaponAttachments", {})
        if (attData[slot]) then
            if (attData[slot].attachment == attachment) then
                return true
            else
                PLUGIN:RefundAttachment(weapon, character, attData[slot].itemID)
                attData[slot] = nil
                weapon.ixItem:SetData("WeaponAttachments", attData)
            end
        end

        local item = character:GetInventory():HasItem(PLUGIN.attachmentTranslate[attachment] or attachment)
        if (!item) then
            ErrorNoHalt("Attachment not found in inventory!")
            return
        end
        attData[slot] = {attachment = attachment, slot = slot, itemID = item:GetID()}
        item:Transfer(nil, nil, nil, client, nil, true)

        weapon.ixItem:SetData("WeaponAttachments", attData)
    end

    return true
end

function PLUGIN:RefundAttachment(weapon, character, itemID)
    if (!ix.item.instances[itemID]) then
        local query = mysql:Select("ix_items")
            query:Select("item_id")
            query:Select("unique_id")
            query:Select("data")
            query:Where("item_id", itemID)
            query:Callback(function(result)
                if (istable(result)) then
                    local data = util.JSONToTable(result[1].data or "[]")
                    local uniqueID = result[1].unique_id
                    local itemTable = ix.item.list[uniqueID]

                    if (itemTable and itemID) then
                        local item = ix.item.New(uniqueID, itemID)
                        item.data = data or {}
                        item.invID = 0

                        local x, y, bagInv = character:GetInventory():FindEmptySlot(item.width, item.height)
                        if (x and y) then
                            local id = bagInv and bagInv:GetID() or character:GetInventory():GetID()
                            item:Transfer(id, x, y)
                        else
                            local itemEntity = item:Spawn(weapon.Owner)
                            itemEntity.ixItemID = itemID
                        end
                    end
                end
            end)
        query:Execute()
    else
        local item = ix.item.instances[itemID]
        if (item.invID != 0) then return end
        local x, y, bagInv = character:GetInventory():FindEmptySlot(item.width, item.height)
        if (x and y) then
            local id = bagInv and bagInv:GetID() or character:GetInventory():GetID()
            item:Transfer(id, x, y)
        else
            local itemEntity = item:Spawn(weapon.Owner)
            itemEntity.ixItemID = itemID
            item.invID = 0
        end
    end
end

local function isPlayerBag(character, bagInv)
    for _, v in pairs(character:GetInventory().slots) do
		for _, v2 in pairs(v) do
			if (istable(v2)) then
				v2.data = v2.data or {}
				if (v2.data.id and v2.data.id == bagInv) then
                    return true
                end
            end
        end
    end

    for _, v in pairs(ix.item.inventories[character:GetEquipInventory()].slots) do
		for _, v2 in pairs(v) do
			if (istable(v2)) then
				v2.data = v2.data or {}
				if (v2.data.id and v2.data.id == bagInv) then
                    return true
                end
            end
        end
    end

    return false
end

function PLUGIN:RefundAmmoItem(weapon, character, itemID, ammo, invPos)
    if (!ix.item.instances[itemID]) then
        local query = mysql:Select("ix_items")
            query:Select("item_id")
            query:Select("unique_id")
            query:Select("data")
            query:Where("item_id", itemID)
            query:Callback(function(result)
                if (istable(result)) then
                    local data = util.JSONToTable(result[1].data or "[]")
                    local uniqueID = result[1].unique_id
                    local itemTable = ix.item.list[uniqueID]

                    if (itemTable and itemID) then
                        local item = ix.item.New(uniqueID, itemID)
                        item.data = data or {}
                        item.invID = 0

                        local x, y, bagInv
                        if (invPos and invPos[1] and ix.item.inventories[invPos[1]] and ix.item.inventories[invPos[1]]:CanItemFit(invPos[2], invPos[3], 1, 1)) then
                            if (invPos[1] == character:GetInventory():GetID() or isPlayerBag(character, invPos[1])) then
                                x, y, bagInv = invPos[2], invPos[3], ix.item.inventories[invPos[1]]
                            end
                        end

                        if (!x or !y) then
                            x, y, bagInv = character:GetInventory():FindEmptySlot(item.width, item.height)
                        end

                        if (x and y) then
                            local id = bagInv and bagInv:GetID() or character:GetInventory():GetID()
                            item:Transfer(id, x, y)
                        else
                            local itemEntity = item:Spawn(character:GetPlayer())
                            itemEntity.ixItemID = itemID
                        end

                        item:SetAmmo(ammo)
                    end
                end
            end)
        query:Execute()
    else
        local item = ix.item.instances[itemID]
        if (item.invID != 0) then return end

        local x, y, bagInv
        if (invPos and invPos[1] and ix.item.inventories[invPos[1]] and ix.item.inventories[invPos[1]]:CanItemFit(invPos[2], invPos[3], 1, 1)) then
            if (invPos[1] == character:GetInventory():GetID() or isPlayerBag(character, invPos[1])) then
                x, y, bagInv = invPos[2], invPos[3], ix.item.inventories[invPos[1]]
            end
        end

        if (!x or !y) then
            x, y, bagInv = character:GetInventory():FindEmptySlot(item.width, item.height)
        end

        if (x and y) then
            local id = bagInv and bagInv:GetID() or character:GetInventory():GetID()
            item:Transfer(id, x, y)
        else
            local itemEntity = item:Spawn(weapon.Owner)
            itemEntity.ixItemID = itemID
            item.invID = 0
        end

        item:SetAmmo(ammo)
    end
end


function PLUGIN:DenyWeaponFire(weapon)
    if ((!weapon.ixDeniedSound or weapon.ixDeniedSound < CurTime()) and IsValid(weapon.Owner)) then
        weapon.ixDeniedSound = CurTime() + 2
        weapon.Owner:EmitSound("buttons/combine_button_locked.wav")
    end
end