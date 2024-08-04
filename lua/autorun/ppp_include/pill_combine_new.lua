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

pk_pills.register("ccamera", {
    printName = "Combine Camera",
    side = "hl_combine",
    type = "phys",
    model = "models/combine_camera/combine_camera.mdl",
    boxPhysics = {Vector(-10, -10, -20), Vector(10, 10, 0)},
    userSpawn = {
        type = "ceiling"
    },
    spawnFrozen = true,
    camera = {
        offset = Vector(0, 0, -50),
        dist = 100,
        underslung = true
    },
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    canAim = function(ply, ent) return ent.active end,
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if ent.active and not ent.busy then
                ent:PillSound("pic")
            end
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ent.busy then return end

            if ent.active then
                ent:PillAnim("retract")
                ent:PillSound("retract")
                ent.active = false
            else
                ent:PillAnim("deploy")
                ent:PillSound("deploy")
            end

            ent.busy = true

            timer.Simple(.2, function()
                if not IsValid(ent) then return end

                if ent:GetSequence() == ent:LookupSequence("deploy") then
                    ent.active = true
                end

                ent.busy = false
            end)
        end
    },
    health = 40,
    sounds = {
        deploy = "npc/turret_floor/deploy.wav",
        retract = "npc/turret_floor/retract.wav",
        die = "npc/turret_floor/die.wav",
        pic = "npc/scanner/scanner_photo1.wav"
    }
})

pk_pills.register("cturret_ceiling", {
    printName = "Combine Ceiling Turret",
    parent = "ccamera",
    model = "models/combine_turrets/ceiling_turret.mdl",
    aim = {
        attachment = "eyes"
    },
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .1,
        damage = 4,
        spread = .01,
        anim = "fire",
        tracer = "AR2Tracer"
    },
    sounds = {
        shoot = pk_pills.helpers.makeList("npc/turret_floor/shoot#.wav", 3)
    }
})

pk_pills.register("ccrawler", {
    printName = "Combine Flea Drone",
    side = "hl_combine",
    type = "ply",
    model = "models/combine_turrets/ground_turret.mdl",
    noragdoll = true,
    default_rp_cost = 4000,
    camera = {
        offset = Vector(0, 0, 30),
        dist = 80
    },
    hull = Vector(30, 30, 20),
    anims = {},
    moveSpeed = {
        walk = 100,
        run = 300
    },
    boneMorphs = {
        ["Ground_turret.mesh2"] = {
            rot = Angle(0, 180, 0)
        },
        ["Ground_turret.Gun"] = {
            rot = Angle(0, 0, 0),
            pos = Vector(0, -3, 39)
        }
    },
    aim = {
        attachment = "eyes",
        simple = true
    },
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .2,
        damage = 5,
        spread = .02,
        tracer = "AR2Tracer"
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ply:IsOnGround() then
                ply:TakeDamage(30, ply)
                local v = ply:EyeAngles():Forward() * 600 + Vector(0, 0, 600)
                ply:SetLocalVelocity(v)
                ent:PillSound("jump")
                local start = 20
                local endd = 10
                ent.trail = util.SpriteTrail(ent, 0, Color(100, 100, 100), false, start, endd, 4, 1 / (start + endd) * .5, "trails/smoke.vmt")
            end
        end
    },
    land = function(ply, ent)
        if IsValid(ent.trail) then
            ent.trail:Remove()
        end
    end,
    sounds = {
        shoot = "weapons/pistol/pistol_fire3.wav",
        jump = "weapons/grenade_launcher1.wav"
    },
    noFallDamage = true,
    muteSteps = true,
    health = 150
})
--[[
pk_pills.register("bmturret",{
	printName="Mini Turret",
	type="phys",
	model="models/turret/miniturret.mdl",
	boxPhysics={Vector(-20,-20,-20),Vector(20,20,20)},
	userSpawn= {
		type="wall",
		ang=Angle(90,0,0)
	},
	seqInit="deploy",
	spawnFrozen=true,
	camera={
		offset=Vector(0,0,60),
		dist=80
	},
	aim={
		attachment="0",
	},
	canAim=function(ply,ent)
		return ent:GetCycle()==1
	end,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.1,
		damage=4,
		spread=.01,
		tracer="Tracer"
	},
	boneMorphs = {
		["Bone01"]=function(ply,ent)
			local a= ent:WorldToLocalAngles(ply:EyeAngles())
			if ent:GetCycle()==1 then
				return {rot=Angle(a.y,0,0)}
			end
		end,
		["Bone03"]=function(ply,ent)
			local a= ent:WorldToLocalAngles(ply:EyeAngles())
			if ent:GetCycle()==1 then
				return {rot=Angle(0,a.p,0)}
			end
		end
	},
	health=80,
	sounds={
		shoot="weapons/smg1/smg1_fire1.wav"
	}
})

pk_pills.register("bmturret2",{
	printName="Gatling Turret",
	parent="bmturret",
	type="phys",
	model="models/turret/turret.mdl",
	camera={
		offset=Vector(0,0,80),
		dist=100
	},
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.05,
		damage=6,
		spread=.01,
		tracer="AR2Tracer"
	},
	boneMorphs = {
		["Dummy02"]=function(ply,ent)
			local a= ent:WorldToLocalAngles(ply:EyeAngles())
			if ent:GetCycle()==1 then
				return {rot=Angle(a.y,0,0)}
			end
		end,
		["Dummy05"]=function(ply,ent)
			local a= ent:WorldToLocalAngles(ply:EyeAngles())
			if ent:GetCycle()==1 then
				return {rot=Angle(0,a.p,0)}
			end
		end
	},
	health=160,
	sounds={
		shoot="weapons/ar2/fire1.wav"
	}
})
]]
