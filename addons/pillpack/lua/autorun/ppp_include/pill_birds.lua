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

pk_pills.register("bird_crow", {
    printName = "Crow",
    side = "harmless",
    type = "ply",
    model = "models/crow.mdl",
    default_rp_cost = 1000,
    camera = {
        offset = Vector(0, 0, 5),
        dist = 40
    },
    hull = Vector(10, 10, 10),
    anims = {
        default = {
            idle = "Idle01",
            walk = "Walk",
            run = "Run",
            glide = "Soar",
            fly = "Fly01",
            eat = "Eat_A",
            jump = "Takeoff"
        }
    },
    moveSpeed = {
        walk = 15,
        run = 40
    },
    health = 20,
    moveMod = function(ply, ent, mv, cmd)
        if not ply:IsOnGround() then
            local angs = mv:GetAngles()

            if cmd:KeyDown(IN_JUMP) then
                angs.p = -30
                mv:SetVelocity(angs:Forward() * 300)

                if SERVER then
                    ent:PillAnimTick("fly")
                end
            elseif cmd:KeyDown(IN_DUCK) then
                angs.p = 30
                mv:SetVelocity(angs:Forward() * 300)

                if SERVER then
                    ent:PillAnimTick("fly")
                end
            else
                angs.p = 10
                mv:SetVelocity(angs:Forward() * 500)
            end
        end
    end,
    land = function(ply, ent)
        ent:PillLoopStop("fly")
    end,
    sounds = {
        vocalize = pk_pills.helpers.makeList("npc/crow/alert#.wav", 2, 3),
        loop_fly = "npc/crow/flap2.wav"
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillSound("vocalize")
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ply:IsOnGround() then
                ent:PillAnim("eat", true)

                timer.Simple(1, function()
                    if not IsValid(ent) then return end

                    if ply:Health() < 10 then
                        ply:SetHealth(10)
                    end
                end)

                timer.Simple(2, function()
                    if not IsValid(ent) then return end
                    ply:SetHealth(20)
                end)
            end
        end
    }
})

pk_pills.register("bird_pigeon", {
    parent = "bird_crow",
    printName = "Pigeon",
    model = "models/pigeon.mdl",
    sounds = {
        vocalize = pk_pills.helpers.makeList("ambient/creatures/pigeon_idle#.wav", 4)
    }
})

pk_pills.register("bird_seagull", {
    parent = "bird_crow",
    printName = "Seagull",
    model = "models/seagull.mdl",
    sounds = {
        vocalize = pk_pills.helpers.makeList("ambient/creatures/seagull_idle#.wav", 3)
    },
    flapSoundPitch = 50,
    anims = {
        default = {
            fly = "Fly"
        }
    },
    health = 50,
    attack2 = {
        mode = ""
    }
})
