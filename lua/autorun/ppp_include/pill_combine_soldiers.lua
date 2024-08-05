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

pk_pills.register("csoldier", {
    printName = "Combine Soldier",
    type = "ply",
    model = "models/Combine_Soldier.mdl",
    default_rp_cost = 5000,
    skin = 0,
    options = function()
        return {
            {
                model = "models/Combine_Soldier.mdl"
            },
            {
                model = "models/Combine_Soldier_PrisonGuard.mdl"
            }
        }
    end,
    side = "hl_combine",
    voxSet = "combine",
    anims = {
        default = {
            idle = "Idle_Unarmed",
            walk = "WalkUnarmed_all",
            run = "Run_turretCarry_ALL",
            crouch = "CrouchIdle",
            crouch_walk = "Crouch_WalkALL",
            glide = "jump_holding_glide",
            jump = "jump_holding_jump",
            throw = "grenThrow",
            rappel = "rappelloop",
            land = "jump_holding_land",
            g_attack = "gesture_shoot_ar2",
            g_reload = "gesture_reload"
        },
        smg = {
            idle = "CombatIdle1_SMG1",
            walk = "Walk_aiming_all",
            run = "RunAIMALL1",
            crouch = "crouch_aim_sm1",
            g_reload = "gesture_reload_SMG1"
        },
        ar2 = {
            idle = "CombatIdle1",
            walk = "Walk_aiming_all",
            run = "RunAIMALL1"
        },
        shotgun = {
            idle = "CombatIdle1_SG",
            walk = "Walk_aiming_all_SG",
            run = "RunAIMALL1_SG",
            g_attack = "gesture_shoot_shotgun"
        }
    },
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ply:IsOnGround() then end
        end
    },
    flashlight = function(ply, ent)
        if not ply:IsOnGround() and not ent.grappleEnd then
            local tr = ply:GetEyeTrace()

            if (tr.Fraction < 0.01) then
                ent.grappleEnd = tr.HitPos
                ent.grappleSliding = true
                local effectdata = EffectData()
                effectdata:SetOrigin(ent.grappleEnd)
                effectdata:SetEntity(ent)
                util.Effect("rappel_line", effectdata, true, true)
                ent:PillSound("rappel_start")
                ent:PillLoopSound("rappel")
            end
        elseif ply:IsOnGround() then
            ent:PillAnim("throw", true)

            if not ent.formTable.throwsManhack then
                timer.Simple(.75, function()
                    if not IsValid(ent) then return end
                    local nade = ents.Create("npc_grenade_frag")
                    nade:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 50)
                    nade:SetAngles(ply:EyeAngles())
                    nade:Spawn()
                    nade:SetOwner(ply)
                    nade:Fire("SetTimer", 3, 0)
                    nade:GetPhysicsObject():SetVelocity((ply:EyeAngles():Forward() + Vector(0, 0, .4)) * 1000)
                end)
            else
                timer.Simple(1, function()
                    if not IsValid(ent) then return end
                    local hax = ents.Create("npc_manhack")
                    hax:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 100)
                    hax:SetAngles(ply:EyeAngles())
                    hax:Spawn()
                    hax:GetPhysicsObject():SetVelocity(Vector(0, 0, 500))
                end)
            end
        end
    end,
    moveMod = function(ply, ent, mv, cmd)
        --garbage code... vertical velocity predicted, lateral velocity not
        if SERVER and ent.grappleEnd then
            ent:PillAnimTick("rappel")
            local targetVel = -500

            if ply:KeyDown(IN_JUMP) then
                if ent.grappleSliding then
                    ent:PillLoopStop("rappel")
                    ent:PillSound("rappel_brake")
                    ent.grappleSliding = false
                end

                targetVel = 0
            else
                if not ent.grappleSliding then
                    ent:PillLoopSound("rappel")
                    ent.grappleSliding = true
                end
            end

            if mv:GetVelocity().z < targetVel then
                local latforce = (ent.grappleEnd - mv:GetOrigin()) * .05
                latforce.z = 0
                mv:SetVelocity(mv:GetVelocity() + latforce)
                local curvel = mv:GetVelocity()
                curvel.z = targetVel
                mv:SetVelocity(curvel)
            end
        end

        --dumb
        if CLIENT and ent:GetPuppet():GetSequence() == ent:GetPuppet():LookupSequence("rappelloop") then
            local targetVel = -500

            if ply:KeyDown(IN_JUMP) then
                targetVel = 0
            end

            if mv:GetVelocity().z < targetVel then
                local curvel = mv:GetVelocity()
                curvel.z = targetVel
                mv:SetVelocity(curvel)
            end
        end
    end,
    land = function(ply, ent)
        if ent.grappleEnd then
            ent.grappleEnd = nil
            ent.grappleSliding = nil
            ent:PillAnim("land", true)
            ent:PillLoopStop("rappel")
        end
    end,
    moveSpeed = {
        walk = 60,
        run = 200,
        ducked = 40
    },
    loadout = {"weapon_ar2", "pill_wep_holstered"},
    ammo = {
        AR2 = 90
    },
    validHoldTypes = {"ar2", "shotgun", "smg"},
    movePoseMode = "yaw",
    health = 150,
    sounds = {
        rappel_start = "weapons/crossbow/fire1.wav",
        rappel_brake = "physics/metal/sawblade_stick1.wav",
        loop_rappel = "weapons/tripwire/ropeshoot.wav",
        step = pk_pills.helpers.makeList("npc/combine_soldier/gear#.wav", 6)
    }
})

pk_pills.register("csoldier_shotgunner", {
    parent = "csoldier",
    printName = "Combine Shotgunner",
    skin = 1,
    loadout = {"weapon_shotgun"},
    ammo = {
        AR2 = 0,
        Buckshot = 30
    }
})

--[[)
pk_pills.register("csoldier_guard",{
	parent="csoldier",
	printName="Prison Soldier",
	model="models/Combine_Soldier_PrisonGuard.mdl",
	options=false
})

pk_pills.register("csoldier_guard_shotgunner",{
	parent="csoldier_shotgunner",
	printName="Prison Shotgunner",
	model="models/Combine_Soldier_PrisonGuard.mdl"
})]]
pk_pills.register("csoldier_elite", {
    parent = "csoldier",
    printName = "Combine Elite",
    model = "models/Combine_Super_Soldier.mdl",
    default_rp_cost = 6000,
    options = false,
    ammo = {
        AR2AltFire = 6
    },
    health = 300
})

pk_pills.register("csoldier_police", {
    parent = "csoldier",
    printName = "Metrocop",
    model = "models/Police.mdl",
    options = false,
    anims = {
        default = {
            idle = "busyidle2",
            walk = "walk_all",
            run = "run_all",
            crouch = "Crouch_idle_pistol",
            crouch_walk = "Crouch_all",
            throw = "deploy"
        },
        smg = {
            idle = "smg1angryidle1",
            walk = "walk_aiming_SMG1_all",
            run = "run_aiming_SMG1_all",
            crouch = "crouch_idle_smg1",
            g_reload = "gesture_reload_smg1",
            g_attack = "gesture_shoot_smg1"
        },
        pistol = {
            idle = "pistolangryidle2",
            walk = "walk_aiming_pistol_all",
            run = "run_aiming_pistol_all",
            g_reload = "gesture_reload_pistol",
            g_attack = "gesture_shoot_pistol"
        },
        melee = {
            idle = "batonangryidle1",
            walk = "walk_hold_baton_angry",
            g_attack = "swinggesture"
        }
    },
    sounds = {
        step = pk_pills.helpers.makeList("npc/metropolice/gear#.wav", 6)
    },
    throwsManhack = true,
    validHoldTypes = {"melee", "pistol", "smg"},
    loadout = {"weapon_stunstick", "weapon_pistol", "weapon_smg1", "pill_wep_holstered"},
    ammo = {
        AR2 = 0,
        pistol = 54,
        smg1 = 90
    },
    health = 100
})
