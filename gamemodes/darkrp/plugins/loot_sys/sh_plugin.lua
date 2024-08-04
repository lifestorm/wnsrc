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

PLUGIN.name = "Loot System"
PLUGIN.author = "Naast"
PLUGIN.description = "Adds lootable containers with editable loot tables."

ix.loot = ix.loot or {}

ix.loot.LootLockpicks = {"fubar", "crowbar", "sledgehammer"} // tools which is breaching the containers
 
ix.config.Add("LootChance", 50, "La chance d'obtenir plus d'articles d'une boîte lors de son ouverture. IL n'est PAS utilisé lors de l'ouverture à l'aide d'outils spéciaux.", nil, {
    data = {min = 30, max = 100},
    category = "Loot"
})
ix.config.Add("PlayersToLoot", 8, "Le nombre de joueurs requis pour pouvoir obtenir le butin des conteneurs.", nil, {
    data = {min = 1, max = 30},
    category = "Loot"
})
ix.config.Add("lootTimer", 1, "Combien de temps faudra-t-il avant de mettre à jour tous les conteneurs sur la map? (En minutes)", nil, {
    data = {min = 1, max = 360},
    category = "Loot"
})
ix.config.Add("lootDelete", 15, "Combien de temps faudra-t-il avant de retirer les objets tombés des conteneurs ? (En secondes)", nil, {
    data = {min = 5, max = 360},
    category = "Loot"
})

ix.command.Add("CreateLootContainerSpawn", {
    description = "Crée un point d'apparition de butin.",
    adminOnly = true,
    arguments = {
        ix.type.text    
    },
    OnRun = function(self, client, container)
        local curStat
        for k, v in pairs(ix.loot.entities) do   
            if k == container then 
                curStat = true
                client:Notify("Vous avez créé le spawnner.")
                break
            else
                curStat = false
            end
        end
        if not curStat then return client:Notify("Type de conteneur non valide.") end
        local spawner = ents.Create("ix_containerspawn")
        spawner:SetPos(client:GetEyeTrace().HitPos) 
        local angles = (client:GetEyeTrace().HitPos - client:GetPos()):Angle()
		angles.r = 0
		angles.p = 0
		angles.y = angles.y + 180
        spawner:SetAngles(angles)
        spawner:SetLootType(container)
        spawner:Spawn()
    end  
}) 

ix.command.Add("RemoveLootSpawner", {
    description = "Supprime tous les générateurs de butin dans la zone que vous regardez, dans le rayon que vous avez défini.",
    adminOnly = true,
    arguments = {
        ix.type.number    
    },
    OnRun = function(self, client, rangeToFind)
        local dlt = 0
        for k, v in ipairs(ents.FindInSphere(client:GetEyeTrace().HitPos, rangeToFind)) do   
            if v:GetClass() == "ix_containerspawn" then 
                v:Remove()
                dlt = dlt + 1 
            end 
        end
        
        client:Notify("vous venez de supprimer " .. dlt .. " spawners.")
    end 
})
ix.loot.entities = {
    ["Basic"] = "ix_basiccontainer",
    ["Ammo"] = "ix_ammunitioncontainer",
    ["Advanced"] = "ix_advancedcontainer",
    ["InfestationControl"] = "ix_infestationcontainer",
    ["Supply"] = "ix_supplycontainer",
    ["Military"] = "ix_militarycontainer",
    ["CMB"] = "ix_cmbcontainer"
}
ix.loot.tables = {
    ["Basic"] = {
        ["Tier_I"] = {"junk_carton", "junk_keyboard", "junk_shoe", "junk_mug", "crafting_water", "junk_jar", "junk_plastic_bucket", "junk_plantpot", "junk_empty_vodka", "junk_computerparts", "junk_brown_bottle", "junk_receiver", "junk_empty_wine", "junk_jug", "junk_takeaway"},
        ["Tier_II"] = {"comp_metal", "comp_plastic", "comp_wood", "comp_electronics", "comp_cloth", "comp_glass", "comp_nails_screws"},
        ["Tier_III"] = {"comp_adhesive", "comp_purifier", "comp_stiched_cloth", "comp_refined_plastic", "comp_reshaped_metal", "comp_improved_nails_screws"}           
    },
    ["Ammo"] = {
        ["Tier_I"] = {"bullets_pistol", "magazine_makeshift_15rnd", "magazine_makeshift_8rnd", "magazine_popper_6rnd", "magazine_usp_15rnd", "magazine_fiveseven_20rnd"},
        ["Tier_II"] = {"bullets_357", "bullets_smg1", "magazine_model870_8rnd", "magazine_mp_30rnd"},
        ["Tier_III"] = {"bullets_buckshot", "bullets_assaultrifle", "magazine_ak_30rnd", "magazine_556_30rnd"}   
    },
    ["Advanced"] = {
        ["Tier_I"] = {"junk_carton", "junk_keyboard", "junk_shoe", "junk_mug", "crafting_water", "junk_jar", "junk_plastic_bucket", "junk_plantpot", "junk_empty_vodka", "junk_computerparts", "junk_brown_bottle", "junk_receiver", "junk_empty_wine", "junk_jug", "junk_takeaway"},
        ["Tier_II"] = {"comp_purifier", "comp_stiched_cloth", "comp_adhesive", "comp_refined_plastic", "comp_reshaped_metal", "comp_improved_nails_screws"},
        ["Tier_III"] = {"comp_refined_metal", "comp_strong_adhesive", "comp_military_electronics", "comp_wooden_craftwork", "comp_fabric", "comp_charcoal", "torso_medical_rebel_uniform"}           
    },
    ["InfestationControl"] = {
        ["Tier_I"] = {"cont_lock_t1", "watervalve", "waterbottle", "infestation_detector", "tool_spoon", "flashlight"},
        ["Tier_II"] = {"ic_hydrocarbon_foam", "tool_wrench", "tool_knife", "lighter", "hatchet", "comp_syringe", "torso_blue_rebel_uniform", "torso_green_rebel_uniform"},
        ["Tier_III"] = {"worker_uniform", "torso_labcoat", "ic_caustic_solution", "ic_anti_xenian_viviral", "tool_toolkit"}     
    },
    ["Supply"] = {
        ["Tier_I"] = {"makeshift_bandage", "disinfectant_bottle", "bandage", "basic_red", "basic_yellow", "basic_green", "basic_blue", "disinfected_bandage"},
        ["Tier_II"] = {"adrenaline", "bloodbag", "bloodstabilizer", "improved_blue", "improved_red", "improved_green", "improved_yellow", "morphine"},
        ["Tier_III"] = {"surgerykit", "quality_yellow", "quality_green", "quality_red", "quality_blue", "firstaid", "torso_medical_rebel_uniform", "torso_blue_rebel_uniform", "torso_green_rebel_uniform"}           
    },
    ["Military"] = {
        ["Tier_I"] = {"cont_lock_t1", "smallbag", "largebag", "head_military_cap", "flashlight", "flash_grenade", "smoke_grenade", "tool_toolkit", "comp_weapon_parts", "old_radio", "usp", "torso_blue_kevlar", "torso_green_kevlar"},
        ["Tier_II"] = {"firstaid", "bloodbag", "tool_repair", "lockbreacher", "comp_grenadecase", "comp_explosive", "comp_weapon_parts", "frag_grenade", "flare", "head_helmet", "head_boonie_hat", "head_gasmask2", "fiveseven"},
        ["Tier_III"] = {"handheld_radio", "incendiary_grenade", "dummy_emp", "highquality_filter", "torso_medical_kevlar", "zippolighter", "comp_charcoal_refill", "mp5a3", "mp7a1", "torso_green_kevlar_t2"}           
    },
    ["CMB"] = {
        ["Tier_I"] = {"smallbag", "cont_lock_t1", "flash_grenade", "flare", "torso_blue_kevlar", "torso_green_kevlar"},
        ["Tier_II"] = {"largebag", "highquality_filter", "handheld_radio", "frag_grenade", "torso_medical_rebel_uniform", "rappel_gear", "torso_green_kevlar_t2"},
        ["Tier_III"] = {"comp_weapon_parts", "incendiary_grenade", "dummy_emp", "torso_medical_kevlar", "expo_energycell", "dummy_biolock_ociw"}           
    }, 
}
function ix.loot.CheckDist(client, ent)
    local dist = ent:GetPos():Distance(client:GetPos())
    return dist 
end
function ix.loot:IsHavingTool(inv)
    for _, tool in ipairs(ix.loot.LootLockpicks) do  
        if inv:HasItem(tool) then 
            return inv:HasItem(tool)
        end
    end
end 
function ix.loot:IsHavingKey(inv, key) 
    if inv:HasItem(key) then 
        return inv:HasItem(key)
    else
        return false
    end
end
function PLUGIN:ValidateItems(items)
    local curStat
    for itemCount, item in ipairs(items) do   
        local toValidate = ix.item.Get(item)
        if toValidate == nil or table.IsEmpty(toValidate) then 
            return false 
        else
            curStat = true
        end
    end
    if curStat then return true end
end
function PLUGIN:CalculateLoot(tbl, noRandom, noAddLoot)
    local chance 
    if noRandom then 
        chance = 100 
    else
        chance = ix.config.Get("LootChance", 30) 
    end
    if noAddLoot then 
        chance = 0 
    end
    local itemsToDrop = {}
    local tier1, tier2, tier3 = tbl["Tier_I"], tbl["Tier_II"], tbl["Tier_III"]
    local allItems = tier1, tier2, tier3
    if not tbl then return end
    if not self:ValidateItems(allItems) then return error( "ERREUR : Vous avez configuré des items non valides.", 1 ) end
    itemsToDrop[#itemsToDrop + 1] = tier1[math.random(1, #tier1)]

    if math.random(1, 100) <= chance then 
        itemsToDrop[#itemsToDrop + 1] = tier2[math.random(1, #tier2)]
        itemsToDrop[#itemsToDrop + 1] = tier3[math.random(1, #tier3)]
    end
    return itemsToDrop
end 
ix.util.Include("derma/cl_interact.lua")
ix.util.Include("derma/cl_interactbutton.lua")
ix.util.Include("sv_plugin.lua")