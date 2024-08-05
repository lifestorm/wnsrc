--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.factionBudget = ix.factionBudget or {}
ix.factionBudget.list = ix.factionBudget.list or {}

function ix.factionBudget:RegisterFB(id, factionName)
    if !isstring(id) then return end
    id = string.utf8upper(id)

    ix.factionBudget.list[id] = {
        id = id,
        name = factionName,
        credits = 0
    }
end

function ix.factionBudget:GetFB(id)
    return ix.factionBudget.list[id]
end

-- never use "INF" in any case. it breaks every faction with any ID that is "INF". 

function ix.factionBudget:InitializeFactionBudgets()
    ix.factionBudget:RegisterFB("CWRU", "Research Union")
    ix.factionBudget:RegisterFB("CWU", "Civil Workers Union")
    ix.factionBudget:RegisterFB("CPU", "Civil Protection")
    ix.factionBudget:RegisterFB("CCA", "Civil Administration")
    ix.factionBudget:RegisterFB("CMU", "Medical Union")
    ix.factionBudget:RegisterFB("BOE", "Enlightenment")
    ix.factionBudget:RegisterFB("SCO", "Security Council")
end