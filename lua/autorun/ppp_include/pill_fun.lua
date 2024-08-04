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

pk_pills.register("birdbrainswagtrain", {
    printName = "Bird Brain Swag Train",
    side = "wild",
    type = "phys",
    model = "models/props_trainstation/train001.mdl",
    default_rp_cost = 100000,
    spawnOffset = Vector(0, 0, 200),
    camera = {
        offset = Vector(80, 0, 0),
        dist = 2000
    },
    driveType = "fly",
    driveOptions = {
        speed = 100,
        rotation = 90
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillSound("horn")
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if not ent.lastcar then
                ent.lastcar = ent
            end

            if not IsValid(ent.lastcar) then return end
            local t = math.random(2, 4)

            if t == 4 then
                t = 5
            end

            local pos = ent.lastcar:LocalToWorld(Vector(0, -650, 0))
            if not util.IsInWorld(pos) then return end
            local car = ents.Create("prop_physics")
            car:SetModel("models/props_trainstation/train00" .. t .. ".mdl")
            car:SetPos(pos)
            car:SetAngles(ent.lastcar:GetAngles())
            car:Spawn()
            car:GetPhysicsObject():EnableGravity(false)
            ent:DeleteOnRemove(car)
            ent:PillFilterCam(car)
            constraint.Ballsocket(ent.lastcar, car, 0, 0, Vector(0, 300, 0), 0, 0, 1)
            ent.lastcar = car
            ent:PillSound("newCar")
        end
    },
    health = 99999,
    sounds = {
        horn = "ambient/alarms/razortrain_horn1.wav",
        newCar = "ambient/machines/wall_crash1.wav"
    }
})

pk_pills.register("landshark", {
    parent = "ichthyosaur",
    printName = "Landshark",
    default_rp_cost = 50000,
    driveType = "hover",
    driveOptions = {
        speed = 50,
        height = 75
    }
})

pk_pills.register("turbobird", {
    parent = "bird_seagull",
    printName = "Turbobird",
    default_rp_cost = 50000,
    side = "wild",
    camera = {
        offset = Vector(0, 0, 40),
        dist = 200
    },
    hull = Vector(50, 50, 50),
    modelScale = 5,
    health = 1337,
    moveSpeed = {
        walk = 100,
        run = 300
    },
    aim = {},
    anims = {
        default = {
            fly_rate = .5,
            kaboom = "reference"
        }
    },
    sounds = {
        vocalize = "npc/metropolice/vo/dontmove.wav",
        loop_windup = "vehicles/Crane/crane_extend_loop1.wav",
        fire = pk_pills.helpers.makeList("npc/metropolice/pain#.wav", 4)
    },
    attack = {
        mode = "auto",
        func = function(ply, ent)
            ent:PillSound("fire")
            local rocket = ents.Create("pill_proj_rocket")
            rocket:SetModel("models/crow.mdl")
            rocket:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 100)
            rocket:SetAngles(ply:EyeAngles())
            rocket.sound = "ambient/levels/canals/windmill_wind_loop1.wav"
            rocket.trail = "trails/lol.vmt"
            rocket.tcolor = HSVToColor(math.Rand(0, 360), 1, 1)
            rocket:Spawn()
            rocket:SetOwner(ply)
        end,
        delay = .3
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ent.splodin then return end
            ent:PillAnim("kaboom", true)
            ent:PillSound("vocalize")
            ent:PillLoopSound("windup")
            ent.splodin = true

            timer.Simple(3, function()
                if not IsValid(ent) then return end
                local explode = ents.Create("env_explosion")
                explode:SetPos(ply:GetPos())
                explode:Spawn()
                explode:SetOwner(ply)
                explode:SetKeyValue("iMagnitude", "300")
                explode:Fire("Explode", 0, 0)
                ply:Kill()
            end)
        end
    }
})

pk_pills.register("melon", {
    printName = "Melon",
    type = "phys",
    side = "harmless",
    model = "models/props_junk/watermelon01.mdl",
    default_rp_cost = 800,
    health = 69,
    driveType = "roll",
    driveOptions = {
        power = 300,
        jump = 5000,
        burrow = 6
    },
    sounds = {
        jump = "npc/headcrab_poison/ph_jump1.wav",
        burrow = "npc/antlion/digdown1.wav",
        loop_move = "npc/fast_zombie/gurgle_loop1.wav"
    },
    moveSoundControl = function(ply, ent)
        local MineSpeed = ent:GetVelocity():Length()
        if MineSpeed > 50 then return math.Clamp(MineSpeed / 2, 100, 150) end
    end
})

pk_pills.register("haxman", {
    printName = "Dr. Hax",
    type = "ply",
    side = "wild",
    model = "models/breen.mdl",
    default_rp_cost = 20000,
    aim = {},
    anims = {
        default = {
            idle = "idle_angry_melee",
            walk = "walk_all",
            run = "sprint_all", --pace_all
            crouch = "Crouch_idleD",
            crouch_walk = "Crouch_walk_aLL",
            glide = "jump_holding_glide",
            jump = "jump_holding_jump",
            throw = "swing"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Head1"] = {
            scale = Vector(3, 3, 3)
        }
    },
    sounds = {
        throw = "vo/npc/male01/hacks01.wav"
    },
    moveSpeed = {
        walk = 100,
        run = 1000,
        ducked = 40
    },
    jumpPower = 1000,
    movePoseMode = "yaw",
    health = 10000,
    noFallDamage = true,
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if not ply:OnGround() then return end
            local computer = ents.Create("pill_proj_prop")
            computer:SetModel("models/props_lab/monitor02.mdl")
            computer:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 100)
            computer:SetAngles(ply:EyeAngles())
            computer:Spawn()
            computer:SetPhysicsAttacker(ply)
            ent:PillAnim("throw", true)
            ent:PillSound("throw")
        end
    }
})

pk_pills.register("crate", {
    printName = "Crate",
    side = "harmless",
    type = "phys",
    model = "models/props_junk/wood_crate001a.mdl",
    default_rp_cost = 200,
    spawnOffset = Vector(0, 0, 30),
    health = 30
})

pk_pills.register("lamp", {
    printName = "Lamp",
    side = "harmless",
    type = "phys",
    model = "models/props_interiors/Furniture_Lamp01a.mdl",
    default_rp_cost = 200,
    spawnOffset = Vector(0, 0, 38),
    health = 30
})

pk_pills.register("cactus", {
    printName = "Cactus",
    side = "harmless",
    type = "phys",
    model = "models/props_lab/cactus.mdl",
    default_rp_cost = 200,
    spawnOffset = Vector(0, 0, 10),
    health = 30
})

pk_pills.register("cone", {
    printName = "Traffic Cone",
    side = "harmless",
    type = "phys",
    model = "models/props_junk/TrafficCone001a.mdl",
    default_rp_cost = 200,
    spawnOffset = Vector(0, 0, 25),
    health = 30
})

pk_pills.register("phantom", {
    printName = "Phantom",
    side = "harmless",
    type = "phys",
    model = "models/Gibs/HGIBS.mdl",
    default_rp_cost = 30000,
    spawnOffset = Vector(0, 0, 50),
    camera = {
        distFromSize = true
    },
    sounds = {
        swap = "weapons/bugbait/bugbait_squeeze1.wav",
        nope = "vo/Citadel/br_no.wav",
        spook = "ambient/creatures/town_child_scream1.wav"
    },
    aim = {},
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            local tr = util.QuickTrace(ent:GetPos(), ply:EyeAngles():Forward() * 1000, ent)
            local prop = tr.Entity

            if IsValid(prop) and prop:GetClass() == "prop_physics" and hook.Call("PhysgunPickup", GAMEMODE, ply, prop) then
                local mymdl = ent:GetModel()
                local mypos = ent:GetPos()
                local myangs = ent:GetAngles()
                ent:SetModel(prop:GetModel())
                ent:PhysicsInit(SOLID_VPHYSICS)
                ent:SetMoveType(MOVETYPE_VPHYSICS)
                ent:SetSolid(SOLID_VPHYSICS)
                ent:SetPos(prop:GetPos())
                ent:SetAngles(prop:GetAngles())
                ent:PhysWake()
                prop:SetModel(mymdl)
                prop:PhysicsInit(SOLID_VPHYSICS)
                prop:SetMoveType(MOVETYPE_VPHYSICS)
                prop:SetSolid(SOLID_VPHYSICS)
                prop:SetPos(mypos)
                prop:SetAngles(myangs)
                prop:PhysWake()
                ent:PillSound("swap")
            else
                ent:PillSound("nope")
            end
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillSound("spook")
        end
    },
    driveType = "fly",
    driveOptions = {
        speed = 10
    },
    health = 666
})

pk_pills.register("steelball", {
    printName = "Ball of Steel",
    side = "harmless",
    type = "phys",
    model = "models/hunter/misc/sphere375x375.mdl",
    default_rp_cost = 15000,
    camera = {
        offset = Vector(0, 0, 0),
        dist = 1000
    },
    spawnOffset = Vector(0, 0, 60),
    driveType = "roll",
    driveOptions = {
        power = 300000,
        jump = 200000
    },
    visMat = "phoenix_storms/stripes",
    physMat = "metal",
    health = 30000
})

pk_pills.register("doggie", {
    printName = "Doggie",
    side = "harmless",
    type = "ply",
    model = "models/balloons/balloon_dog.mdl",
    noragdoll = true,
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 5),
        dist = 80
    },
    hull = Vector(10, 10, 15),
    anims = {},
    moveSpeed = {
        walk = 120,
        run = 240
    },
    visColorRandom = true,
    health = 75
})

pk_pills.register("skeeter", {
    printName = "Skeeter",
    side = "harmless",
    type = "ply",
    model = "models/odessa.mdl",
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 5),
        dist = 40
    },
    hull = Vector(5, 5, 10),
    duckBy = 5,
    modelScale = .2,
    anims = {
        default = {
            idle = "cower_idle",
            walk = "walk_panicked_all",
            run = "run_all_panicked",
            crouch = "arrestidle",
            --crouch_walk="crouchrunall1", pos rot scale
            glide = "spreadwallidle",
            jump = "jump_holding_jump"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Head1"] = {
            pos = Vector(5, 0, 0)
        },
        ["ValveBiped.Bip01_L_Thigh"] = {
            pos = Vector(10, 0, 0)
        },
        ["ValveBiped.Bip01_R_Thigh"] = {
            pos = Vector(-10, 0, 0)
        }
    },
    moveSpeed = {
        walk = 30,
        run = 90
    },
    movePoseMode = "yaw",
    jumpPower = 400,
    health = 2,
    noFallDamage = true
})

pk_pills.register("doge", {
    printName = "Doge",
    side = "harmless",
    type = "phys",
    sphericalPhysics = 20,
    default_rp_cost = 30000,
    sprite = {
        mat = "pillsprites/shibe.png",
        --color=Color(255,255,0),
        size = 60,
        offset = Vector(0, 0, 10)
    },
    --model="models/Gibs/HGIBS.mdl",
    spawnOffset = Vector(0, 0, 50),
    camera = {},
    --distFromSize=true
    sounds = {
        swap = "weapons/bugbait/bugbait_squeeze1.wav",
        nope = "vo/Citadel/br_no.wav",
        spook = "ambient/creatures/town_child_scream1.wav"
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            local effectdata = EffectData()
            effectdata:SetOrigin(ent:GetPos())
            util.Effect("wow_doge", effectdata, true, true)
            ent:PillSound("wow")
        end
    },
    driveType = "fly",
    driveOptions = {
        speed = 10
    },
    sounds = {
        wow = "birdbrainswagtrain/wow.wav"
    },
    health = 420
})
