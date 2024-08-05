
function PLUGIN:CharacterLoaded(character)
    if (character:GetStashInventory() == 0) then
        ix.inventory.New(character:GetID(), "personalStash", function(inventory)
            inventory.vars.isBag = true
            inventory.vars.isContainer = true
            inventory.vars.isStash = true

            character:SetStashInventory(inventory:GetID())
        end)
    end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
    local stashName = character:GetStashName()
    if (stashName == "") then return end

    -- check if character's stash still exists
    for _, v in ipairs(self.stashes) do
        if (string.utf8lower(v[4]) == stashName) then
            return
        end
    end

    character:SetStashName("")
    ix.log.Add(client, "stashLocationReset", stashName)
end

function PLUGIN:ShouldRestoreInventory(charID, invID, invType)
    if (invType == "personalStash") then
        ix.inventory.Restore(tonumber(invID), self.STASH_WIDTH, self.STASH_HEIGHT, function(inventory)
            inventory.vars.isBag = true
            inventory.vars.isContainer = true
            inventory.vars.isStash = true

            inventory:SetOwner(charID)
        end)
        return false
    end
end

function PLUGIN:OnItemTransferred(item, oldInv, newInv)
    if (!newInv.owner or !newInv.vars.isStash) then
        return
    end

    local character = ix.char.loaded[newInv.owner]
    ix.log.Add(character:GetPlayer(), "inventoryRemove", character:GetName(), item:GetName(), item:GetID())
end

function PLUGIN:PlayerPushedPlayer(pusher, victim)
    local victimStash = victim:GetCharacter():GetStashInventory()

    if (ix.item.inventories[victimStash]) then
        ix.storage.Close(ix.item.inventories[victimStash])
    end
end