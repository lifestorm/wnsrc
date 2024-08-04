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

PLUGIN.stashes = PLUGIN.stashes or {}

ix.log.AddType("stashMoneyTake", function(client, name, amount, total)
    return string.format("%s has taken %d %s from their '%s' stash (%d %s left).",
        client:GetName(), amount, ix.currency.plural, name, total, ix.currency.plural)
end)

ix.log.AddType("stashMoneyGive", function(client, name, amount, total)
    return string.format("%s has given %d %s to their '%s' stash (%d %s stored now).",
        client:GetName(), amount, ix.currency.plural, name, total, ix.currency.plural)
end)

function PLUGIN:OpenInventory(activator, targetChar, entity, inventory, bIsAdmin)
    local name = entity:GetClass() == "ix_stash" and entity:GetDisplayName() or entity:Name()

    ix.storage.Open(activator, inventory, {
        name = name,
        entity = entity,
        bMultipleUsers = false,
        searchTime = bIsAdmin and 0 or ix.config.Get("containerOpenTime", 0.7),
        data = {money = targetChar:GetStashMoney()},
        OnPlayerClose = function()
            if (inventory:GetFilledSlotCount() == 0 and targetChar:GetStashMoney() == 0) then
                targetChar:SetStashName("")
            end
            ix.log.Add(activator, "stashClose", name)
        end,
        OnMoneyGive = function(client, inv, amount)
            amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, targetChar:GetMoney())
            if (amount == 0) then
                return
            end

            targetChar:SetMoney(targetChar:GetMoney() - amount)

            local total = targetChar:GetStashMoney() + amount
            targetChar:SetStashMoney(total)

            ix.log.Add(client, "stashMoneyGive", name, amount, total)

            return amount, total
        end,
        OnMoneyTake = function(client, inv, amount)
            amount = math.Clamp(math.Round(tonumber(amount) or 0), 0, targetChar:GetStashMoney())
            if (amount == 0) then
                return
            end

            targetChar:SetMoney(targetChar:GetMoney() + amount)

            local total = targetChar:GetStashMoney() - amount
            targetChar:SetStashMoney(total)

            ix.log.Add(client, "stashMoneyTake", name, amount, total)

            return amount, total
        end
    })

    ix.log.Add(activator, "stashOpen", name, bIsAdmin)
end

ix.log.AddType("stashOpen", function(client, stashName, bIsAdmin)
    return string.format("%s %s the '%s' stash.", client:Name(), bIsAdmin and "admin-viewed" or "opened", stashName)
end, FLAG_NORMAL)

ix.log.AddType("stashClose", function(client, stashName)
    return string.format("%s closed the '%s' stash.", client:Name(), stashName)
end, FLAG_NORMAL)

ix.log.AddType("stashLocationReset", function(client, stashName)
    return string.format("%s their '%s' stash no longer exists, location reset.", client:Name(), stashName)
end, FLAG_NORMAL)

ix.log.AddType("stashName", function(client, name)
    return string.format("%s has set a stash name to '%s'.", client:Name(), name)
end)

ix.log.AddType("stashCreate", function(client, stashModel)
    return string.format("%s created a stash (%s).", client:Name(), stashModel)
end, FLAG_NORMAL)

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_stash", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.motion = false
			data.model = entity:GetModel()
            data.name = entity:GetDisplayName()
		end,
		OnRestore = function(entity, data) --OnRestore
			entity:SetModel(data.model)
            entity:SetSolid(SOLID_VPHYSICS)
            entity:PhysicsInit(SOLID_VPHYSICS)

            if (data.name) then
                entity:SetDisplayName(data.name)
            end

            local physObj = entity:GetPhysicsObject()
            if (IsValid(physObj)) then
                physObj:EnableMotion()
                physObj:Sleep()
            end
		end,
	})
end

function PLUGIN:SaveStashes()
    local data = {}
    for _, v in ipairs(ents.FindByClass("ix_stash")) do
        data[#data + 1] = {
            v:GetPos(),
            v:GetAngles(),
            v:GetModel(),
            v:GetDisplayName(),
        }
    end
    self:SetData(data)
    self.stashes = data
end

function PLUGIN:SaveData()
    if (!ix.shuttingDown) then
        self:SaveStashes()
    end
end

function PLUGIN:LoadData()
    if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

    local data = self:GetData()
    if (data) then
        for _, v in ipairs(data) do
            local entity = ents.Create("ix_stash")
            entity:SetPos(v[1])
            entity:SetAngles(v[2])
            entity:Spawn()
            entity:SetModel(v[3])
            entity:SetSolid(SOLID_VPHYSICS)
            entity:PhysicsInit(SOLID_VPHYSICS)

            if (v[4]) then
                entity:SetDisplayName(v[4])
            end

            local physObject = entity:GetPhysicsObject()
            if (IsValid(physObject)) then
                physObject:EnableMotion()
            end
        end
        self.stashes = data
    end
end