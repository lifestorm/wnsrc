--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local npc_sides = {
    npc_advisor = "hl_combine",
    npc_alyx = "default",
    npc_antlion = "hl_antlion",
    npc_antlion_grub = "hl_antlion",
    npc_antlionguard = "hl_antlion",
    npc_barnacle = "wild",
    npc_antlion_worker = "hl_antlion",
    npc_barney = "default",
    npc_breen = "hl_combine",
    npc_citizen = "default",
    npc_clawscanner = "hl_combine",
    npc_combine_camera = "hl_combine",
    npc_combine_s = "hl_combine",
    npc_combinedropship = "hl_combine",
    npc_combinegunship = "hl_combine",
    npc_crow = "harmless",
    npc_cscanner = "hl_combine",
    npc_dog = "default",
    npc_eli = "default",
    npc_fastzombie = "hl_zombie",
    npc_fastzombie_torso = "hl_zombie",
    npc_fisherman = "default",
    npc_gman = "harmless",
    npc_headcrab = "hl_zombie",
    npc_headcrab_black = "hl_zombie",
    npc_headcrab_fast = "hl_zombie",
    npc_helicopter = "hl_combine",
    npc_hunter = "hl_combine",
    npc_ichthyosaur = "wild",
    npc_kleiner = "default",
    npc_magnusson = "default",
    npc_manhack = "hl_combine",
    npc_metropolice = "hl_combine",
    npc_monk = "default",
    npc_mossman = "default",
    npc_pigeon = "harmless",
    npc_poisonzombie = "hl_zombie",
    npc_rollermine = "hl_combine",
    npc_seagull = "harmless",
    npc_sniper = "hl_combine",
    npc_stalker = "hl_combine",
    npc_strider = "hl_combine",
    npc_turret_ceiling = "hl_combine",
    npc_turret_floor = "hl_combine",
    npc_turret_ground = "hl_combine",
    npc_vortigaunt = "default",
    npc_zombie = "hl_zombie",
    npc_zombie_torso = "hl_zombie",
    npc_zombine = "hl_zombie"
}

local side_relationships = {
    default = {
        hl_combine = D_HT,
        hl_antlion = D_HT,
        hl_zombie = D_HT,
        hl_infiltrator = D_LI
    },
    hl_combine = {
        default = D_HT,
        hl_antlion = D_HT,
        hl_zombie = D_HT,
        hl_infiltrator = D_LI
    },
    hl_antlion = {
        default = D_HT,
        hl_combine = D_HT,
        hl_zombie = D_HT,
        hl_infiltrator = D_HT
    },
    hl_zombie = {
        default = D_HT,
        hl_combine = D_HT,
        hl_antlion = D_HT,
        hl_infiltrator = D_HT
    }
}

local team_map = {}

--AI TEAMS
function setAiTeam(ent, side)
    if ent:IsPlayer() and side == "default" then
        team_map[ent] = nil
    else
        team_map[ent] = side
    end

    for _, npc in pairs(ents.FindByClass("npc_*")) do
        if npc == ent or not npc.AddEntityRelationship or not IsValid(npc) then continue end
        local otherSide = getAiTeam(npc)

        --if otherSide==nil then continue end
        if side == otherSide or side == "harmless" then
            npc:AddEntityRelationship(ent, D_LI, 99)
        elseif side == "wild" then
            npc:AddEntityRelationship(ent, D_HT, 99)
        else
            local relationship = (side_relationships[otherSide] or {})[side]

            if relationship then
                npc:AddEntityRelationship(ent, relationship, 99)
            end
        end

        if ent:IsNPC() then
            if otherSide == side or otherSide == "harmless" then
                ent:AddEntityRelationship(npc, D_LI, 99)
            elseif side == "wild" then
                ent:AddEntityRelationship(npc, D_HT, 99)
            else
                local relationship = (side_relationships[side] or {})[otherSide]

                if relationship then
                    ent:AddEntityRelationship(npc, relationship, 99)
                end
            end
        end
    end

    if ent:IsNPC() then
        for _, ply in pairs(player.GetAll()) do
            local otherSide = getAiTeam(ply)

            if otherSide == side or otherSide == "harmless" then
                ent:AddEntityRelationship(ply, D_LI, 99)
            elseif side == "wild" then
                ent:AddEntityRelationship(ply, D_HT, 99)
            else
                local relationship = (side_relationships[side] or {})[otherSide]

                if relationship then
                    ent:AddEntityRelationship(ply, relationship, 99)
                end
            end
        end
    end

    if not ent:IsPlayer() and ent:GetTable() then
        ent:CallOnRemove("ClearAiTeam", function()
            team_map[ent] = nil
        end)
    end
end

function getAiTeam(ent)
    local side
    side = team_map[ent]
    if side then return side end
    side = npc_sides[ent:GetClass()]
    if side then return side end
    --if ent.formTable then side=ent.formTable.side end
    --if side then return side end
    if ent:IsPlayer() then return "default" end

    return "harmless"
end

hook.Add("OnEntityCreated", "pk_pill_npc_spawn", function(npc)
    if npc.AddEntityRelationship then
        local otherSide = getAiTeam(npc)
        if otherSide == nil then return end

        for ent, side in pairs(team_map) do
            if not IsValid(ent) then continue end --This really shouldn't happen. But it does. ):

            if side == otherSide or side == "harmless" then
                npc:AddEntityRelationship(ent, D_LI, 99)
            elseif side == "wild" then
                npc:AddEntityRelationship(ent, D_HT, 99)
            else
                local relationship = (side_relationships[otherSide] or {})[side]
                if relationship == nil then continue end
                npc:AddEntityRelationship(ent, relationship, 99)
            end

            --TODO CHECK AGAINST ALL NPCS, NOT JUST ONES IN THIS LIST -- THIS MIGHT ACTUALLY BE RIGHT
            if ent:IsNPC() then
                if otherSide == side or otherSide == "harmless" then
                    ent:AddEntityRelationship(npc, D_LI, 99)
                elseif side == "wild" then
                    ent:AddEntityRelationship(npc, D_HT, 99)
                else
                    local relationship = (side_relationships[side] or {})[otherSide]
                    if relationship == nil then continue end
                    ent:AddEntityRelationship(npc, relationship, 99)
                end
            end
        end
    end
end)

hook.Add("PlayerDisconnected", "pk_pill_clearplayerteam", function(ply)
    team_map[ply] = nil
end)
