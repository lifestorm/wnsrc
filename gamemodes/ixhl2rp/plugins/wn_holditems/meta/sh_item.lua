--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ITEM = ix.meta.item

function ITEM:IsHoldable()
    return ix.holdItems:CanHold(self.uniqueID) or self.holdData
end

function ITEM:InitializeHoldable()
    if self:IsHoldable() then
        self.functions.hold = {
            name = "Umieść ten przedmiot w ręce",
            tip = "Możesz wizualnie wyświetlić ten przedmiot.",
            icon = "icon16/bullet_green.png",
            --[[isMulti = true,
            multiOptions = function(item, player)
                if !item.useAllHoldTypes then
                    return {
                        {
                            name = ix.holdItems.holdTypes["rhand"].name,
                            data = ix.holdItems.holdTypes["rhand"]
                        }
                    }
                end

                local holdTypes = {}
                for hID, hType in pairs(ix.holdItems.holdTypes) do
                    holdTypes[#holdTypes + 1] = {
                        name = hType.name,
                        data = hType
                    }
                end

                return holdTypes
            end,--]]
            OnRun = function(item)
                local client = item.player
                local entity = item.entity

                local holdTypeData = item.holdType or ix.holdItems.holdTypes["rhand"]

                if (!IsValid(client) or IsValid(entity) or !client:Alive()) then return false end

                if ix.holdItems.forbiddenFactions[client:Team()] then
                    client:NotifyLocalized("Twoja frakcja nie może trzymać przedmiotów.")
                    return
                end

                if client:GetActiveWeapon():GetClass() != "ix_hands" then
                    client:NotifyLocalized("Już coś trzymasz w rękach.")
                    return false
                end

                if client.ixHoldingItemEnt and IsValid(client.ixHoldingItemEnt) then
                    client:NotifyLocalized("Już trzymasz przedmiot!")
                    return false
                end

                --[[if !item.useAllHoldTypes and holdTypeData.id != "rhand" then
                    client:NotifyLocalized("You can hold this item only in your right hand.")
                    return false
                end--]]

                client:TakeHoldableItem(item, ix.holdItems:CanHold(item.uniqueID) and ix.holdItems:CanHold(item.uniqueID).holdData or item.holdData, holdTypeData)

                return false
            end,
            OnCanRun = function(item)
                local client = item.player
                local entity = item.entity

                return IsValid(client) and !IsValid(entity) and !item:GetData("holdBy", false) and !ix.holdItems.forbiddenFactions[client:Team()] and true or false
            end
        }
        self.functions.hputback = {
            name = "Odłóż ten przedmiot",
            tip = "Przestań wyświetlać ten przedmiot.",
            icon = "icon16/bullet_red.png",
            OnRun = function(item)
                local client = item.player
                local entity = item.entity

                if (!IsValid(client) or IsValid(entity)) then return false end

                client:PutHoldableItemBack(item)

                return false
            end,
            OnCanRun = function(item)
                local client = item.player
                local entity = item.entity

                return IsValid(client) and !IsValid(entity) and item:GetData("holdBy", false) and IsValid(item:GetData("holdBy", false)) and true or false
            end
        }
    end
end