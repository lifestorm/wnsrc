--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]



function PLUGIN:TFA_Attachment_Attached(weapon, attachmentID, attachmentTable, category, attachmentIndex, forced)
    local character = weapon.Owner:GetCharacter()
    if (weapon.ixItem and character) then
        for _, v in pairs(weapon.ixItem.atts) do
			if (v == attachmentID) then
                local data = weapon.ixItem:GetData("tfa_default_atts_uneq", {})
                data[v] = nil
                weapon.ixItem:SetData("tfa_default_atts_uneq", data)
                return
            end
		end

        local attData = weapon.ixItem:GetData("tfa_atts", {})
        if (attData[category]) then
            if (attData[category].att == attachmentID) then
                return
            else
                self:RefundAttachment(weapon, character, attData[category].itemID)
                attData[category] = nil
                weapon.ixItem:SetData("tfa_atts", attData)
            end
        end

        local item = character:GetInventory():HasItem(self.attnTranslate[attachmentID] or attachmentID)
        if (!item) then return end
        attData[category] = {att = attachmentID, itemID = item:GetID()}
        item:Transfer(nil, nil, nil, weapon.Owner, nil, true)

        weapon.ixItem:SetData("tfa_atts", attData)
    end
end

function PLUGIN:TFA_Attachment_Detached(weapon, attid, atttable, category, attindex, forced)
    local character = weapon.Owner:GetCharacter()
    if (weapon.ixItem and character) then
        for _, v in pairs(weapon.ixItem.atts) do
			if (v == attid) then
                local data = weapon.ixItem:GetData("tfa_default_atts_uneq", {})
                data[v] = true
                weapon.ixItem:SetData("tfa_default_atts_uneq", data)
                return
            end
		end

        local attData = weapon.ixItem:GetData("tfa_atts", {})

        local itemID = attData[category].itemID
        self:RefundAttachment(weapon, character, itemID)

        attData[category] = nil

        if (!table.IsEmpty(attData)) then
            weapon.ixItem:SetData("tfa_atts", attData)
        else
            weapon.ixItem:SetData("tfa_atts", nil)
        end
    end
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

function PLUGIN:DenyWeaponFire(weapon)
    if ((!weapon.ixDeniedSound or weapon.ixDeniedSound < CurTime()) and IsValid(weapon.Owner)) then
        weapon.ixDeniedSound = CurTime() + 2
        weapon.Owner:EmitSound("buttons/combine_button_locked.wav")
    end
end

function PLUGIN:TFA_PreCanPrimaryAttack(weapon)
    if (weapon.ixItem and weapon.ixItem:GetData("BioLocked")) then
        self:DenyWeaponFire(weapon)
        return false
    end
end

function PLUGIN:TFA_SecondaryAttack(weapon)
    if (weapon.ixItem and weapon.ixItem:GetData("BioLocked")) then
        self:DenyWeaponFire(weapon)
        return true -- signal we 'handled' the attack
    end
end

local swing_threshold = 0.3
local function M_TIME(client)
	local wep = client:GetActiveWeapon()
	if (!IsValid(wep) or !wep.TFA_NMRIH_MELEE or wep:GetStatus() != TFA.Enum.STATUS_IDLE) then return end
	if (client.HasTFANMRIMSwing) then return end

    if (client:KeyDown(IN_ATTACK)) then
        if (client.LastNMRIMSwing == nil) then
			client.HasTFANMRIMSwing = false
            if (hook.Run("CanDoHeavyMeleeAttack", wep) == false) then
				client.LastNMRIMSwing = math.huge
			else
				client.LastNMRIMSwing = CurTime() + swing_threshold
			end
        elseif (client.LastNMRIMSwing and CurTime() > client.LastNMRIMSwing and IsValid(wep) and wep.IsTFAWeapon) then
			client.HasTFANMRIMSwing = true
			client:GetActiveWeapon():PrimaryAttack(true, true)
			client.LastNMRIMSwing = CurTime()
		end
	end
end

hook.Add("PlayerTick","TFANMRIH_M",M_TIME)
