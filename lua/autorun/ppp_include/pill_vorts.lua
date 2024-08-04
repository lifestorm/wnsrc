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

pk_pills.register("vort", {
    printName = "Vortigaunt",
    type = "ply",
    model = "models/vortigaunt.mdl",
    default_rp_cost = 8000,
    voxSet = "vort",
    camera = {
        dist = 200
    },
    anims = {
        default = {
            idle = "Idle01",
            walk = "Walk_all",
            run = "Run_all",
            melee1 = "MeleeHigh1",
            melee2 = "MeleeHigh2",
            melee3 = "MeleeHigh3",
            melee4 = "MeleeLow",
            attackRanged = "zapattack1"
        }
    },
    sounds = {
        melee = pk_pills.helpers.makeList("npc/vort/claw_swing#.wav", 2),
        melee_hit = pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav", 3),
        loop_ranged_charge = "npc/vort/attack_charge.wav",
        ranged_fire = "npc/vort/attack_shoot.wav",
        step = pk_pills.helpers.makeList("npc/vort/vort_foot#.wav", 4)
    },
    aim = {
        xPose = "head_yaw",
        yPose = "head_pitch"
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            local superpowers = ent.formTable.superpowers
            ent:PillAnim("attackRanged", true)
            ent:PillLoopSound("ranged_charge")
            local puppet = ent:GetPuppet()
            ParticleEffectAttach("vortigaunt_charge_token", PATTACH_POINT_FOLLOW, puppet, puppet:LookupAttachment("leftclaw"))
            ParticleEffectAttach("vortigaunt_charge_token", PATTACH_POINT_FOLLOW, puppet, puppet:LookupAttachment("rightclaw"))

            timer.Simple(1.5, function()
                if not IsValid(ent) then return end
                ent:PillLoopStop("ranged_charge")
                ent:PillSound("ranged_fire")
                local tr = ply:GetEyeTrace()
                local attachment = puppet:GetAttachment(puppet:LookupAttachment("leftclaw"))
                puppet:StopParticles()

                if attachment then
                    util.ParticleTracerEx(superpowers and "weapon_combine_ion_cannon" or "vortigaunt_beam", attachment.Pos, tr.HitPos, true, puppet:EntIndex(), puppet:LookupAttachment("leftclaw"))
                end

                if superpowers then
                    ParticleEffect("weapon_combine_ion_cannon_explosion", tr.HitPos, Angle(0, 0, 0))
                    sound.Play("ambient/explosions/explode_1.wav", tr.HitPos, 75, 100, 1)
                    util.BlastDamage(ent, ply, tr.HitPos, 200, 400)
                else
                    util.BlastDamage(ent, ply, tr.HitPos, 10, 400)
                end
            end)
        end
    },
    attack2 = {
        mode = "trigger",
        func = pk_pills.common.melee,
        animCount = 4,
        delay = .5,
        range = 40,
        dmg = 25
    },
    movePoseMode = "yaw",
    moveSpeed = {
        walk = 100,
        run = 300
    },
    duckBy = 0,
    jumpPower = 0,
    health = 120
})

pk_pills.register("vort_slave", {
    parent = "vort",
    side = "hl_combine",
    printName = "Vortigaunt Slave",
    model = "models/vortigaunt_slave.mdl"
})
