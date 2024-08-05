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

pk_pills.register("parakeet", {
    parent = "bird_pigeon",
    printName = "Parakeet",
    visColorRandom = true,
    reload = function(ply, ent)
        local egg = ents.Create("prop_physics")
        egg:SetModel("models/props_phx/misc/egg.mdl")
        local ang = ply:EyeAngles()
        ang.p = 0
        egg:SetPos(ply:EyePos() + ang:Forward() * 30)
        egg:Spawn()
        local phys = egg:GetPhysicsObject()

        if IsValid(phys) then
            phys:SetVelocity(ply:GetVelocity() + ply:EyeAngles():Forward() * 800 + (ply:IsOnGround() and Vector(0, 0, 600) or Vector()))
        end

        egg:Fire("FadeAndRemove", nil, 10)
    end,
    sounds = {
        vocalize = pk_pills.helpers.makeList("ambient/levels/canals/swamp_bird#.wav", 6)
    }
})

local dragon_attacks = {
    function(ply, pos)
        local thing = ents.Create("pill_proj_prop")
        thing:SetModel(table.Random{"models/props_lab/monitor02.mdl", "models/props_junk/CinderBlock01a.mdl", "models/props_junk/sawblade001a.mdl", "models/props_junk/harpoon002a.mdl", "models/props_junk/watermelon01.mdl", "models/props_c17/FurnitureWashingmachine001a.mdl", "models/props_c17/FurnitureFridge001a.mdl", "models/props_c17/FurnitureBathtub001a.mdl", "models/props_wasteland/prison_toilet01.mdl", "models/props_vehicles/carparts_tire01a.mdl"})
        thing:SetPos(pos)
        thing:SetAngles(ply:EyeAngles())
        thing:Spawn()
        thing:SetPhysicsAttacker(ply)
    end,
    function(ply, pos)
        local thing = ents.Create("prop_physics")
        thing:SetModel(table.Random{"models/props_c17/oildrum001_explosive.mdl", "models/props_junk/propane_tank001a.mdl", "models/props_junk/gascan001a.mdl"})
        thing:SetPos(pos)
        thing:SetAngles(ply:EyeAngles())
        thing:Spawn()
        thing:SetPhysicsAttacker(ply)
        thing:Ignite(100)
        local phys = thing:GetPhysicsObject()

        if IsValid(phys) then
            phys:Wake()
            phys:EnableGravity(false)
            phys:EnableDrag(false)
            phys:SetDamping(0, 0)
            phys:SetVelocity(ply:EyeAngles():Forward() * 3000)
        end
    end,
    function(ply, pos)
        local thing = ents.Create("pill_proj_energy_grenade")
        thing:SetPos(pos)
        thing:SetAngles(ply:EyeAngles() + Angle(-50 + math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(-10, 10)))
        thing:Spawn()
        thing:SetOwner(ply)
    end,
    function(ply, pos)
        local rocket = ents.Create("rpg_missile")
        rocket:SetPos(pos)
        rocket:SetAngles(ply:EyeAngles())
        rocket:SetSaveValue("m_flDamage", 200)
        rocket:SetOwner(ply)
        rocket:SetVelocity(ply:EyeAngles():Forward() * 1500)
        rocket:Spawn()
    end,
    function(ply, pos)
        local bomb = ents.Create("grenade_helicopter")
        bomb:SetPos(pos)
        bomb:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
        bomb:Spawn()
        bomb:SetPhysicsAttacker(ply)
        bomb:GetPhysicsObject():AddVelocity(ply:EyeAngles():Forward() * 3000)
    end,
    function(ply, pos)
        local nade = ents.Create("npc_grenade_frag")
        nade:SetPos(pos)
        nade:SetAngles(ply:EyeAngles())
        nade:Spawn()
        nade:SetOwner(ply)
        nade:Fire("SetTimer", 3, 0)
        nade:GetPhysicsObject():SetVelocity((ply:EyeAngles():Forward() + Vector(0, 0, .2)) * 3000)
    end,
    function(ply, pos)
        local ball = ents.Create("prop_combine_ball")
        ball:SetPos(pos)
        ball:SetAngles(ply:EyeAngles())
        ball:Spawn()
        ball:SetOwner(ply)
        ball:SetSaveValue('m_flRadius', 12)
        ball:SetSaveValue("m_nState", 3)
        ball:SetSaveValue("m_nMaxBounces", 10)
        ball:GetPhysicsObject():SetVelocity(ply:EyeAngles():Forward() * 3000)
    end
}

pk_pills.register("dagent", {
    printName = "Dragon Agent",
    side = "wild",
    type = "ply",
    default_rp_cost = 20000,
    visColorRandom = true,
    model = "models/player/combine_super_soldier.mdl",
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    anims = {
        default = {
            idle = "idle_magic",
            walk = "walk_magic",
            run = "run_magic",
            crouch = "cidle_magic",
            crouch_walk = "cwalk_magic",
            glide = "jump_magic",
            jump = "jump_magic",
            swim = "swimming_magic"
        }
    },
    attack = {
        mode = "auto",
        delay = .2,
        func = function(ply, ent)
            ent:PillSound("attack", true)
            table.Random(dragon_attacks)(ply, ply:GetShootPos() + ply:EyeAngles():Forward() * 100)
        end
    },
    moveSpeed = {
        walk = 60,
        run = 600,
        ducked = 60
    },
    sounds = {
        attack = "weapons/gauss/fire1.wav"
    },
    jumpPower = 800,
    movePoseMode = "xy",
    health = 10000
})

pk_pills.register("dingus", {
    printName = "Dingus",
    side = "harmless",
    type = "ply",
    default_rp_cost = 1000,
    visColorRandom = true,
    model = "models/player/soldier_stripped.mdl",
    visMat = "models/debug/debugwhite",
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    camera = {
        offset = Vector(0, 0, 50)
    },
    hull = Vector(15, 15, 50),
    duckBy = 10,
    anims = {
        default = {
            idle = "idle_magic",
            walk = "walk_magic",
            run = "run_magic",
            crouch = "cidle_magic",
            crouch_walk = "cwalk_magic",
            glide = "jump_magic",
            jump = "jump_magic",
            swim = "swimming_magic"
        }
    },
    attack = {
        mode = "auto",
        delay = .2,
        func = function(ply, ent)
            ent:PillSound("attack", true)
            local ball = ents.Create("sent_ball")
            ball:SetPos(ply:GetShootPos() + ply:EyeAngles():Forward() * 150)
            ball:SetBallSize(100)
            ball:Spawn()
            local color = ent:GetPuppet():GetColor()
            ball:SetBallColor(Vector(color.r / 255, color.g / 255, color.b / 255))
            ball:GetPhysicsObject():SetVelocity(ply:EyeAngles():Forward() * 1000)

            timer.Simple(5, function()
                if IsValid(ball) then
                    ball:Remove()
                end
            end)
        end
    },
    attack2 = {
        mode = "auto",
        delay = 1,
        func = function(ply, ent)
            ent:PillSound("donger")
        end
    },
    moveSpeed = {
        walk = 40,
        run = 300,
        ducked = 20
    },
    modelScale = .8,
    sounds = {
        attack = "weapons/physcannon/energy_bounce1.wav",
        donger = pk_pills.helpers.makeList("birdbrainswagtrain/dingus#.wav", 9),
        donger_pitch = 80
    },
    jumpPower = 400,
    movePoseMode = "xy",
    health = 80
})

pk_pills.register("error", {
    printName = "ERROR",
    side = "harmless",
    type = "ply",
    model = "models/error.mdl",
    noragdoll = true,
    default_rp_cost = 800,
    camera = {
        offset = Vector(0, 0, 25),
        dist = 100
    },
    hull = Vector(80, 80, 80),
    anims = {},
    moveSpeed = {
        walk = 200,
        run = 400
    },
    jumpPower = 500,
    health = 128
})
--[[
pk_pills.register("chicken",{
	printName="Chicken",
	side="harmless",
	type="ply",
	model="models/chicken/chicken.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	noragdoll=true,
	default_rp_cost=800,
	camera={
		offset=Vector(0,0,5),
		dist=80
	},
	hull=Vector(15,15,15),
	anims={
		default={
			idle="idle01",
			walk="walk01",
			run="run01",
			glide="flap_falling"
		}
	},
	moveSpeed={
		walk=20,
		run=120
	},
	noFallDamage=true,
	health=30
})

pk_pills.register("turbochicken",{
	printName="Fubar's Little Helper",
	parent="chicken",
	attachments={"models/antlers/antlers.mdl"},
	default_rp_cost=8000,
	camera={
		offset=Vector(0,0,40),
		dist=300
	},
	hull=Vector(90,90,90),
	modelScale=6,
	moveSpeed={
		walk=120,
		run=800
	},
	jumpPower=800,
	health=300
})
]]
