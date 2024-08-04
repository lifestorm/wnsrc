--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()
local combineMdls = {"models/combine_soldier.mdl", "models/combine_soldier_prisonguard.mdl", "models/combine_super_soldier.mdl", "models/police.mdl", "models/zombie/zombie_soldier.mdl", "models/player/combine_soldier.mdl", "models/player/combine_soldier_prisonguard.mdl", "models/player/combine_super_soldier.mdl", "models/player/police.mdl", "models/player/police_fem.mdl", "models/player/zombie_soldier.mdl"}

pk_pills.register("headcrab", {
    printName = "Headcrab",
    side = "hl_zombie",
    zombie = "zombie",
    type = "ply",
    model = "models/headcrabclassic.mdl",
    default_rp_cost = 6000,
    camera = {
        offset = Vector(0, 0, 5),
        dist = 75
    },
    hull = Vector(20, 20, 10),
    anims = {
        default = {
            idle = "idle01",
            walk = "run1",
            jump = "jumpattack_broadcast",
            swim = "drown",
            burrow_in = "burrowin",
            burrow_loop = "burrowidle",
            burrow_out = "burrowout"
        }
    },
    sounds = {
        jump = pk_pills.helpers.makeList("npc/headcrab/attack#.wav", 3),
        bite = "npc/headcrab/headbite.wav",
        burrow_in = "npc/antlion/digdown1.wav",
        burrow_out = "npc/antlion/digup1.wav",
        step = pk_pills.helpers.makeList("npc/headcrab_poison/ph_step#.wav", 4)
    },
    moveSpeed = {
        walk = 30,
        run = 60
    },
    jumpPower = 300,
    jump = function(ply, ent)
        v = ply:EyeAngles():Forward()
        v.z = 0
        v:Normalize()
        ply:SetVelocity(v * 200)
        ent:PillSound("jump")
        ent.canBite = true
    end,
    glideThink = function(ply, ent)
        if ent.canBite then
            local aim = ply:GetAimVector()
            aim.z = 0
            aim:Normalize()
            local tracedata = {}
            tracedata.start = ply:EyePos()
            tracedata.endpos = ply:EyePos() + aim * 5 + Vector(0, 0, -5)
            tracedata.filter = ply
            tracedata.mins = Vector(-8, -8, -8)
            tracedata.maxs = Vector(8, 8, 8)
            local trace = util.TraceHull(tracedata)

            if IsValid(trace.Entity) then
                local crabbed = trace.Entity

                if crabbed:IsNPC() or crabbed:IsPlayer() then
                    ent:PillSound("bite")
                end

                if crabbed:Health() <= ent.formTable.biteDmg and not crabbed:IsFlagSet(FL_GODMODE) then
                    local crabbed_actual

                    if pk_pills.getMappedEnt(crabbed) then
                        crabbed_actual = pk_pills.getMappedEnt(crabbed)
                    else
                        crabbed_actual = crabbed
                    end

                    if crabbed_actual:LookupBone("ValveBiped.Bip01_Head1") and crabbed_actual:LookupBone("ValveBiped.Bip01_L_Foot") and crabbed_actual:LookupBone("ValveBiped.Bip01_R_Foot") then
                        local mdl

                        if pk_pills.getMappedEnt(crabbed) then
                            local crabbedpill = pk_pills.getMappedEnt(crabbed)

                            if crabbedpill.subModel then
                                mdl = crabbedpill.subModel --doesnt work
                            else
                                mdl = crabbedpill:GetPuppet():GetModel()
                            end
                        else
                            mdl = crabbed:GetModel()
                        end

                        local t = ent.formTable.zombie

                        if t == "zombie" and pk_pills.hasPack("ep1") and table.HasValue(combineMdls, mdl) then
                            t = "ep1_zombine"
                        end

                        local newPill = pk_pills.apply(ply, t)
                        local dbl = ents.Create("pill_attachment_zed")
                        dbl:SetParent(newPill:GetPuppet())
                        dbl:SetModel(mdl)
                        dbl:Spawn()
                        newPill.subModel = mdl

                        if crabbed:IsNPC() or crabbed:IsPlayer() then
                            ply:SetPos(crabbed:GetPos())
                            ply:SetEyeAngles(crabbed:EyeAngles())
                        else
                            ent:PillSound("bite")
                        end

                        if crabbed:IsPlayer() then
                            crabbed:KillSilent()
                        else
                            crabbed:Remove()
                        end
                    else
                        crabbed:TakeDamage(10000, ply, ply)
                    end
                else
                    crabbed:TakeDamage(ent.formTable.biteDmg, ply, ply)
                end

                ent.canBite = nil
            end
        end
    end,
    land = function(ply, ent)
        ent.canBite = nil
    end,
    biteDmg = 60,
    canBurrow = true,
    health = 40
})

pk_pills.register("headcrab_fast", {
    parent = "headcrab",
    printName = "Fast Headcrab",
    zombie = "zombie_fast",
    type = "ply",
    model = "models/headcrab.mdl",
    default_rp_cost = 8000,
    anims = {
        default = {
            jump = "attack"
        }
    },
    moveSpeed = {
        walk = 100,
        run = 200
    },
    canBurrow = false
})

pk_pills.register("headcrab_poison", {
    parent = "headcrab",
    printName = "Poison Headcrab",
    zombie = "zombie_poison",
    type = "ply",
    model = "models/headcrabblack.mdl",
    default_rp_cost = 7000,
    anims = {
        default = {
            jump = false,
            poison_jump = "tele_attack_a",
            run = "scurry"
        }
    },
    sounds = {
        rattle = pk_pills.helpers.makeList("npc/headcrab_poison/ph_rattle#.wav", 3),
        jump = pk_pills.helpers.makeList("npc/headcrab_poison/ph_jump#.wav", 3),
        bite = pk_pills.helpers.makeList("npc/headcrab_poison/ph_poisonbite#.wav", 3)
    },
    moveSpeed = {
        run = 100
    },
    jumpPower = 0,
    jump = function(ply, ent)
        if ent.poison_jump_blocked then return end
        v = ply:EyeAngles():Forward()
        v.z = 0
        v:Normalize()
        ent:PillSound("rattle")
        ent:PillAnim("poison_jump")
        ent.poison_jump_blocked = true

        timer.Simple(1.6, function()
            if not IsValid(ent) then return end
            ent.poison_jump_blocked = false
            ent:PillSound("jump")
            ply:SetVelocity(v * 200 + Vector(0, 0, 300))
            ent.canBite = true
        end)
    end,
    biteDmg = 100,
    canBurrow = false
})
