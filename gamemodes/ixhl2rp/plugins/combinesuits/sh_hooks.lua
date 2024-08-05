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


function PLUGIN:CanPlayerEquipItem(client, item)
	if (item.isCombineMask) then
        local character = client:GetCharacter()
        if (!character) then return false end

        local suit = ix.item.instances[character:GetCombineSuit()]
		if (!suit) then
            return false
        end
	end
end

function PLUGIN:CanPlayerUnequipItem(client, item)
    if (item == client:GetActiveCombineSuit() and client:HasActiveCombineMask()) then
        return false
    end
end

function PLUGIN:CanPlayerDropItem(client, item)
    if (item == client:GetActiveCombineSuit() and client:HasActiveCombineMask()) then
        return false
    end
end

function PLUGIN:SetupAreaProperties()
	ix.area.AddProperty("nexus", ix.type.bool, false)
end

-- A function to get whether a player has a flashlight.
function PLUGIN:PlayerSwitchFlashlight(client, enabled)
    local character = client:GetCharacter()
    if (!character) then return false end

    local item = ix.item.instances[character:GetCombineSuit()]
    if (item) then
        return true
    end
end

function PLUGIN:CanPlayerAddWaypoint(client)
    if (client:HasActiveCombineMask() or client:IsDispatch()) then
        return true
    end
end

function PLUGIN:CanPlayerUpdateWaypoints(client)
    if (client:IsDispatch()) then
        return true
    elseif (client:HasActiveCombineMask() and client:IsCombineRankAbove("RL")) then
        return true
    end
end

function PLUGIN:CanPlayerRemoveWaypoints(client)
    if (client:IsDispatch()) then
        return true
    elseif (client:HasActiveCombineMask() and client:IsCombineRankAbove("RL")) then
        return true
    end
end

function PLUGIN:CanPlayerSeeWaypoints(client)
    if (client:HasActiveCombineMask() or client:IsDispatch()) then
        return true
    end
end

function PLUGIN:CheckCanTransferToEquipSlots(itemTable, oldInv, inventory)
	local client = itemTable.player or (oldInv and oldInv.GetOwner and oldInv:GetOwner()) or itemTable.GetOwner and itemTable:GetOwner()
	if client and IsValid(client) then
		if client:HasActiveCombineMask() and itemTable:GetData("suitActive") then
			return false, "You need to remove your mask first!"
		end

		if oldInv and oldInv.vars and oldInv.vars.equipSlots then
			local headApparel = oldInv:GetItemAt(1, 1)
			if headApparel and headApparel.base and headApparel.base == "base_maskcp" then
				if itemTable.base == "base_combinesuit" then
					return false, "You need to remove your mask first!"
				end
			end
		end
	end
end