--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function ix.factionBudget:GetFBCredits(id)
    return ix.factionBudget:GetFB(id).credits
end

function ix.factionBudget:SetFBCredits(id, credits)
    ix.factionBudget.list[id].credits = math.Clamp(credits, 0, 50000)
end

function ix.factionBudget:AddFBCredits(id, credits)
    local curCreds = ix.factionBudget:GetFBCredits(id)
    ix.factionBudget.list[id].credits = math.Clamp(curCreds + credits, 0, 50000)
end

function ix.factionBudget:TakeFBCredits(id, credits)
    local curCreds = ix.factionBudget:GetFBCredits(id)
    ix.factionBudget.list[id].credits = math.Clamp(curCreds - credits, 0, 50000)
end

function ix.factionBudget:HasCredits(id, credits)
    local curCreds = ix.factionBudget:GetFBCredits(id)
    if curCreds >= credits then
        return true
    end

    return false
end

function ix.factionBudget:SaveBudgets()
    ix.data.Set("factionBudgets", ix.factionBudget.list, false, true)

    ix.city:UpdateCWUTerminals()
end

function ix.factionBudget:LoadBudgets()
    ix.factionBudget:InitializeFactionBudgets()

    local budgetList = ix.data.Get("factionBudgets", false, false, true)
    if budgetList then
        for k, v in pairs(budgetList) do
            if ix.factionBudget.list[k] then
                ix.factionBudget.list[k] = v
            end
        end
    end
end