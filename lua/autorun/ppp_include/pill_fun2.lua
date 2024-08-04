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

pk_pills.register("giraffe", {
    printName = "Giraffe",
    side = "harmless",
    type = "ply",
    model = "models/mossman.mdl",
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 220),
        dist = 400
    },
    hull = Vector(50, 50, 230),
    duckBy = 150,
    modelScale = 2,
    anims = {
        default = {
            idle = "man_gun",
            walk = "walk_holding_package_all",
            run = "run_aiming_p_all",
            crouch = "coverlow_l",
            crouch_walk = "crouchrunall1",
            glide = "sit_chair",
            jump = "cower"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Head1"] = {
            pos = Vector(50, 25, 0),
            scale = Vector(2, 2, 2)
        }
    },
    moveSpeed = {
        walk = 300,
        run = 900
    },
    movePoseMode = "yaw",
    jumpPower = 400,
    health = 600
})

pk_pills.register("hula", {
    printName = "Hula",
    side = "harmless",
    type = "ply",
    model = "models/props_lab/huladoll.mdl",
    noragdoll = true,
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 5),
        dist = 80
    },
    hull = Vector(5, 5, 6),
    anims = {
        default = {
            idle = "idle",
            shake = "shake"
        }
    },
    attack = {
        mode = "auto",
        delay = .2,
        func = function(ply, ent)
            ent:PillAnim("shake")
        end
    },
    moveSpeed = {
        walk = 40,
        run = 100
    },
    health = 5
})

pk_pills.register("wheelbarrow", {
    printName = "Wheelbarrow",
    side = "harmless",
    type = "phys",
    model = "models/props_junk/Wheebarrow01a.mdl",
    default_rp_cost = 3000,
    camera = {
        dist = 120
    },
    driveType = "hover",
    driveOptions = {
        speed = 5,
        height = 40
    }
})

pk_pills.register("goover", {
    printName = "Goover",
    side = "harmless",
    type = "phys",
    default_rp_cost = 800,
    options = function()
        return {
            {
                model = "models/maxofs2d/balloon_gman.mdl"
            },
            {
                model = "models/maxofs2d/balloon_mossman.mdl"
            }
        }
    end,
    driveType = "fly",
    driveOptions = {
        speed = 20
    },
    health = 50
})

pk_pills.register("baby", {
    printName = "Baby",
    side = "harmless",
    type = "phys",
    model = "models/props_c17/doll01.mdl",
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 5),
        dist = 80
    },
    driveType = "hover",
    driveOptions = {
        speed = 3,
        height = 20
    },
    health = 15
})

pk_pills.register("facepunch", {
    printName = "Facepunch",
    side = "wild",
    type = "phys",
    camera = {
        dist = 300
    },
    default_rp_cost = 18000,
    model = "models/props_phx/facepunch_logo.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 60,
        rotation2 = 90
    },
    sounds = {
        fire = "physics/metal/metal_box_impact_hard2.wav"
    },
    attack = {
        mode = "auto",
        delay = .33,
        func = function(ply, ent)
            ent:PillSound("fire")
            local bomb = ents.Create("pill_proj_bomb")
            bomb:SetModel("models/props_phx/facepunch_barrel.mdl")
            bomb:SetPos(ent:GetPos() + ply:EyeAngles():Forward() * 100)
            bomb:SetAngles(ply:EyeAngles())
            bomb:SetOwner(ply)
            bomb:Spawn()
        end
    },
    health = 11111
})

pk_pills.register("rpg", {
    printName = "RPG",
    side = "harmless",
    type = "phys",
    default_rp_cost = 5000,
    model = "models/weapons/w_missile_closed.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 30,
        rocketMode = true
    },
    aim = {},
    damageFromWater = -1,
    sounds = {
        loop_move = "weapons/rpg/rocket1.wav"
    },
    trail = {
        texture = "trails/smoke.vmt",
        width = 10
    },
    collide = function(ply, ent, collide)
        ply:Kill()
    end,
    die = function(ply, ent)
        local explode = ents.Create("env_explosion")
        explode:SetPos(ent:GetPos())
        explode:Spawn()
        explode:SetOwner(ply)
        explode:SetKeyValue("iMagnitude", "100")
        explode:Fire("Explode", 0, 0)
    end
})

pk_pills.register("rocket", {
    parent = "rpg",
    printName = "Rocket",
    default_rp_cost = 10000,
    model = false,
    options = function()
        return {
            {
                model = "models/props_phx/amraam.mdl"
            },
            {
                model = "models/props_phx/ww2bomb.mdl"
            },
            {
                model = "models/props_phx/torpedo.mdl"
            },
            {
                model = "models/props_phx/mk-82.mdl"
            }
        }
    end,
    aim = {},
    camera = {
        dist = 300
    },
    driveOptions = {
        speed = 60
    },
    die = function(ply, ent)
        local pos = ent:GetPos()

        local splode = function()
            if not IsValid(ply) then return end
            local explode = ents.Create("env_explosion")
            explode:SetPos(pos + VectorRand() * 100)
            explode:Spawn()
            explode:SetOwner(ply)
            explode:SetKeyValue("iMagnitude", "100")
            explode:Fire("Explode", 0, 0)
        end

        splode()

        for i = 1, 4 do
            timer.Simple(i / 5, splode)
        end
    end
})

pk_pills.register("rocket2", {
    parent = "rocket",
    printName = "Super Rocket",
    default_rp_cost = 20000,
    model = "models/props_phx/rocket1.mdl",
    options = false,
    camera = {
        dist = 600
    },
    aim = {},
    driveOptions = {
        speed = 90,
        rotation2 = 90
    },
    die = function(ply, ent)
        local pos = ent:GetPos()

        local splode = function()
            if not IsValid(ply) then return end
            local explode = ents.Create("env_explosion")
            explode:SetPos(pos + VectorRand() * 500)
            explode:Spawn()
            explode:SetOwner(ply)
            explode:SetKeyValue("iMagnitude", "100")
            explode:Fire("Explode", 0, 0)
        end

        splode()

        for i = 1, 19 do
            timer.Simple(i / 10, splode)
        end
    end
})

pk_pills.register("sawblade", {
    printName = "Saw Blade",
    side = "wild",
    type = "phys",
    default_rp_cost = 9000,
    model = "models/props_junk/sawblade001a.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 10,
        spin = 200
    },
    sounds = {
        loop_move = "vehicles/v8/third.wav",
        cut = "physics/metal/sawblade_stick1.wav"
    },
    collide = function(ply, ent, collide)
        if collide.HitNormal.z < 0.5 and collide.HitNormal.z > -0.5 then
            local force = -collide.HitNormal
            --GTFO
            ent:GetPhysicsObject():ApplyForceCenter(force * 20000)
            --Give Damage
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(100)
            dmginfo:SetAttacker(ply)
            dmginfo:SetDamageForce(force * -10000)
            collide.HitEntity:TakeDamageInfo(dmginfo)
            ent:PillSound("cut")
        end
    end,
    contactForceHorizontal = true,
    health = 500
})

pk_pills.register("carousel", {
    printName = "Carousel",
    side = "wild",
    type = "phys",
    camera = {
        dist = 300
    },
    default_rp_cost = 12000,
    model = "models/props_c17/playground_carousel01.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 20,
        spin = 100
    },
    health = 1000
})

pk_pills.register("chopper", {
    printName = "Chopper",
    side = "wild",
    type = "phys",
    camera = {
        dist = 300
    },
    default_rp_cost = 12000,
    model = "models/props_c17/TrapPropeller_Blade.mdl",
    driveType = "fly",
    driveOptions = {
        speed = 20,
        spin = -300
    },
    health = 1000
})

pk_pills.register("propeller", {
    printName = "Propeller",
    side = "wild",
    type = "phys",
    camera = {
        dist = 200
    },
    default_rp_cost = 8000,
    options = function()
        return {
            {
                model = "models/props_phx/misc/propeller2x_small.mdl"
            },
            {
                model = "models/props_phx/misc/propeller3x_small.mdl"
            }
        }
    end,
    driveType = "fly",
    driveOptions = {
        speed = 20,
        spin = -300
    },
    health = 600
})

pk_pills.register("turbine", {
    printName = "Turbine",
    side = "wild",
    type = "phys",
    camera = {
        dist = 200
    },
    default_rp_cost = 8000,
    options = function()
        return {
            {
                model = "models/props_phx/misc/paddle_small.mdl"
            },
            {
                model = "models/props_phx/misc/paddle_small2.mdl"
            }
        }
    end,
    driveType = "fly",
    driveOptions = {
        speed = 20,
        spin = -300
    },
    health = 600
})

pk_pills.register("dorf", {
    printName = "Dorf",
    side = "harmless",
    type = "ply",
    model = "models/Eli.mdl",
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 40),
        dist = 60
    },
    hull = Vector(20, 20, 50),
    modelScale = .5,
    anims = {
        default = {
            idle = "lineidle01",
            walk = "walk_all",
            run = "run_all_panicked",
            jump = "jump_holding_jump"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Pelvis"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Spine"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Spine1"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Spine2"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Spine4"] = {
            scale = Vector(2, 2, 2)
        },
        ["ValveBiped.Bip01_Head1"] = {
            scale = Vector(4, 4, 4)
        },
        ["ValveBiped.Bip01_L_Clavicle"] = {
            pos = Vector(0, 0, 10)
        },
        ["ValveBiped.Bip01_R_Clavicle"] = {
            pos = Vector(0, 0, -10)
        }
    },
    moveSpeed = {
        walk = 60,
        run = 150
    },
    movePoseMode = "yaw",
    jumpPower = 200,
    health = 40
})

pk_pills.register("babyguardian", {
    printName = "Baby Guardian",
    parent = "antlion_guard",
    side = "harmless",
    type = "ply",
    default_rp_cost = 15000,
    camera = {
        offset = Vector(0, 0, 20),
        dist = 60
    },
    hull = Vector(30, 30, 30),
    modelScale = .25,
    moveSpeed = {
        walk = 90,
        run = 90
    },
    attack = {
        range = 50,
        dmg = 25
    },
    charge = {
        vel = 300,
        dmg = 50
    },
    movePoseMode = "yaw",
    jumpPower = 500,
    health = 200
})

pk_pills.register("headcrab_jumbo", {
    printName = "Jumbo Crab",
    parent = "headcrab_poison",
    side = "harmless",
    type = "ply",
    default_rp_cost = 15000,
    camera = {
        offset = Vector(0, 0, 40),
        dist = 300
    },
    hull = Vector(200, 200, 75),
    modelScale = 5,
    moveSpeed = {
        walk = 100,
        run = 200
    },
    sounds = {
        step = {"npc/antlion_guard/foot_heavy1.wav", "npc/antlion_guard/foot_heavy2.wav", "npc/antlion_guard/foot_light1.wav", "npc/antlion_guard/foot_light2.wav"}
    },
    jump = false,
    glideThink = false,
    movePoseMode = "yaw",
    health = 1000
})
