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

local function all_humans()
    --{model="models/Combine_Super_Soldier.mdl"},
    --{model="models/Combine_Soldier_PrisonGuard.mdl"},
    --{model="models/Combine_Soldier.mdl"},
    --{model="models/Police.mdl"}
    return {
        {
            model = "models/Humans/Group01/male_01.mdl"
        },
        {
            model = "models/Humans/Group01/male_02.mdl"
        },
        {
            model = "models/Humans/Group01/male_03.mdl"
        },
        {
            model = "models/Humans/Group01/male_04.mdl"
        },
        {
            model = "models/Humans/Group01/male_05.mdl"
        },
        {
            model = "models/Humans/Group01/male_06.mdl"
        },
        {
            model = "models/Humans/Group01/male_07.mdl"
        },
        {
            model = "models/Humans/Group01/male_08.mdl"
        },
        {
            model = "models/Humans/Group01/male_09.mdl"
        },
        {
            model = "models/Humans/Group02/male_01.mdl"
        },
        {
            model = "models/Humans/Group02/male_02.mdl"
        },
        {
            model = "models/Humans/Group02/male_03.mdl"
        },
        {
            model = "models/Humans/Group02/male_04.mdl"
        },
        {
            model = "models/Humans/Group02/male_05.mdl"
        },
        {
            model = "models/Humans/Group02/male_06.mdl"
        },
        {
            model = "models/Humans/Group02/male_07.mdl"
        },
        {
            model = "models/Humans/Group02/male_08.mdl"
        },
        {
            model = "models/Humans/Group02/male_09.mdl"
        },
        {
            model = "models/Humans/Group03/male_01.mdl"
        },
        {
            model = "models/Humans/Group03/male_02.mdl"
        },
        {
            model = "models/Humans/Group03/male_03.mdl"
        },
        {
            model = "models/Humans/Group03/male_04.mdl"
        },
        {
            model = "models/Humans/Group03/male_05.mdl"
        },
        {
            model = "models/Humans/Group03/male_06.mdl"
        },
        {
            model = "models/Humans/Group03/male_07.mdl"
        },
        {
            model = "models/Humans/Group03/male_08.mdl"
        },
        {
            model = "models/Humans/Group03/male_09.mdl"
        },
        {
            model = "models/Humans/Group03m/male_01.mdl"
        },
        {
            model = "models/Humans/Group03m/male_02.mdl"
        },
        {
            model = "models/Humans/Group03m/male_03.mdl"
        },
        {
            model = "models/Humans/Group03m/male_04.mdl"
        },
        {
            model = "models/Humans/Group03m/male_05.mdl"
        },
        {
            model = "models/Humans/Group03m/male_06.mdl"
        },
        {
            model = "models/Humans/Group03m/male_07.mdl"
        },
        {
            model = "models/Humans/Group03m/male_08.mdl"
        },
        {
            model = "models/Humans/Group03m/male_09.mdl"
        },
        {
            model = "models/Humans/Group01/female_01.mdl"
        },
        {
            model = "models/Humans/Group01/female_02.mdl"
        },
        {
            model = "models/Humans/Group01/female_03.mdl"
        },
        {
            model = "models/Humans/Group01/female_04.mdl"
        },
        {
            model = "models/Humans/Group01/female_06.mdl"
        },
        {
            model = "models/Humans/Group01/female_07.mdl"
        },
        {
            model = "models/Humans/Group02/female_01.mdl"
        },
        {
            model = "models/Humans/Group02/female_02.mdl"
        },
        {
            model = "models/Humans/Group02/female_03.mdl"
        },
        {
            model = "models/Humans/Group02/female_04.mdl"
        },
        {
            model = "models/Humans/Group02/female_06.mdl"
        },
        {
            model = "models/Humans/Group02/female_07.mdl"
        },
        {
            model = "models/Humans/Group03/female_01.mdl"
        },
        {
            model = "models/Humans/Group03/female_02.mdl"
        },
        {
            model = "models/Humans/Group03/female_03.mdl"
        },
        {
            model = "models/Humans/Group03/female_04.mdl"
        },
        {
            model = "models/Humans/Group03/female_06.mdl"
        },
        {
            model = "models/Humans/Group03/female_07.mdl"
        },
        {
            model = "models/Humans/Group03m/female_01.mdl"
        },
        {
            model = "models/Humans/Group03m/female_02.mdl"
        },
        {
            model = "models/Humans/Group03m/female_03.mdl"
        },
        {
            model = "models/Humans/Group03m/female_04.mdl"
        },
        {
            model = "models/Humans/Group03m/female_06.mdl"
        },
        {
            model = "models/Humans/Group03m/female_07.mdl"
        },
        {
            model = "models/barney.mdl"
        },
        {
            model = "models/monk.mdl"
        },
        {
            model = "models/gman_high.mdl"
        },
        {
            model = "models/alyx.mdl"
        },
        {
            model = "models/Kleiner.mdl"
        },
        {
            model = "models/Eli.mdl"
        },
        {
            model = "models/mossman.mdl"
        },
        {
            model = "models/odessa.mdl"
        },
        {
            model = "models/breen.mdl"
        }
    }
end

pk_pills.register("jake_e", {
    printName = "WE LOVE JAKE",
    model = false,
    options = all_humans,
    parent = "zombie_fast",
    anims = {
        default = {
            idle = "fear_reaction_idle",
            run = "run_protected_all",
            jump = "cower",
            glide = "cower_idle",
            jump_attack = "cower",
            glide_attack = "cower_idle",
            attack = "walkaimall1",
            climb = "lineidle02",
            climb_start = "jump_holding_jump",
            release = "swing"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Spine"] = {
            rot = Angle(90, 0, 0)
        },
        ["ValveBiped.Bip01_Head1"] = {
            scale = Vector(2, 2, 2),
            rot = Angle(90, 0, 0)
        }
    },
    crab = "melon"
})

pk_pills.register("jake_k", {
    printName = "JAKE IS THE BEST",
    model = false,
    options = all_humans,
    parent = "antlion",
    modelScale = 1,
    anims = {
        default = {
            idle = "sit_ground",
            walk = "walk_all",
            run = "run_protected_all",
            fly = "run_protected_all",
            jump = "run_protected_all",
            glide = "run_protected_all",
            melee1 = "meleeattack01",
            melee2 = "meleeattack01",
            melee3 = "meleeattack01",
            charge_start = "jump_holding_land",
            charge_loop = "crouchrunall1",
            charge_hit = "kick_door",
            burrow_in = "idle_to_sit_ground",
            burrow_out = "sit_ground_to_idle",
            burrow_loop = "injured1"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Pelvis"] = {
            scale = Vector(2, 2, 2),
            rot = Angle(0, 0, 20),
            pos = Vector(0, 0, 0)
        },
        ["ValveBiped.Bip01_Spine"] = {
            scale = Vector(2, 2, 1)
        },
        ["ValveBiped.Bip01_Spine1"] = {
            scale = Vector(2, 2, 1)
        },
        ["ValveBiped.Bip01_Spine2"] = {
            scale = Vector(2, 2, 1)
        },
        ["ValveBiped.Bip01_Spine4"] = {
            scale = Vector(2, 2, 1)
        },
        ["ValveBiped.Bip01_Head1"] = {
            scale = Vector(4, 4, 1),
            rot = Angle(0, 20, 0)
        },
        ["ValveBiped.Bip01_L_Clavicle"] = {
            pos = Vector(0, 0, 10)
        },
        ["ValveBiped.Bip01_R_Clavicle"] = {
            pos = Vector(0, 0, -10)
        }
    },
    --["ValveBiped.Bip01_R_Forearm"]={pos=Vector(-100,0,-100),scale=Vector(1,100,1)},
    --["ValveBiped.Bip01_L_Forearm"]={pos=Vector(-100,0,100),scale=Vector(1,100,1)},
    --["ValveBiped.Bip01_R_Foot"]={pos=Vector(20,0,0)},
    --["ValveBiped.Bip01_L_Foot"]={pos=Vector(20,0,0)},
    --[[moveSpeed={
		walk=100,
		run=400
	},]]
    movePoseMode = "yaw"
})

--jumpPower=400,
--health=40,
--muteSteps=true
pk_pills.register("jake_a", {
    printName = "JAKE IS A COOL GUY",
    side = "harmless",
    type = "ply",
    model = false,
    options = all_humans,
    camera = {
        --offset=Vector(0,0,40),
        dist = 300
    },
    hull = Vector(200, 200, 100),
    modelScale = 2,
    anims = {
        default = {
            idle = "lineidle01",
            walk = "walk_all",
            run = "run_protected_all",
            jump = "jump_holding_jump"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Pelvis"] = {
            scale = Vector(2, 2, 2),
            rot = Angle(0, 0, 90),
            pos = Vector(0, 0, 0)
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
            scale = Vector(4, 4, 4),
            rot = Angle(0, 90, 0)
        },
        ["ValveBiped.Bip01_L_Clavicle"] = {
            pos = Vector(0, 0, 10)
        },
        ["ValveBiped.Bip01_R_Clavicle"] = {
            pos = Vector(0, 0, -10)
        },
        ["ValveBiped.Bip01_R_Forearm"] = {
            pos = Vector(50, 0, 0)
        },
        ["ValveBiped.Bip01_L_Forearm"] = {
            pos = Vector(50, 0, 0)
        },
        ["ValveBiped.Bip01_R_Foot"] = {
            pos = Vector(20, 0, 0)
        },
        ["ValveBiped.Bip01_L_Foot"] = {
            pos = Vector(20, 0, 0)
        }
    },
    moveSpeed = {
        walk = 100,
        run = 400
    },
    movePoseMode = "yaw",
    jumpPower = 400,
    health = 40,
    muteSteps = true
})

pk_pills.register("jake_j", {
    printName = "GIVE US JAKE",
    model = false,
    options = all_humans,
    parent = "bird_pigeon",
    modelScale = .2,
    anims = {
        default = {
            idle = "sit_ground",
            walk = "walk_all",
            run = "run_protected_all",
            fly = "run_protected_all",
            jump = "run_protected_all",
            glide = "run_protected_all",
            eat = "preskewer"
        }
    },
    boneMorphs = {
        ["ValveBiped.Bip01_Pelvis"] = {
            scale = Vector(2, 2, 2),
            rot = Angle(0, 0, 20),
            pos = Vector(0, 0, 0)
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
            scale = Vector(4, 4, 4),
            rot = Angle(0, 20, 0)
        },
        ["ValveBiped.Bip01_L_Clavicle"] = {
            pos = Vector(0, 0, 10)
        },
        ["ValveBiped.Bip01_R_Clavicle"] = {
            pos = Vector(0, 0, -10)
        },
        ["ValveBiped.Bip01_R_Forearm"] = {
            pos = Vector(-100, 0, -100),
            scale = Vector(1, 100, 1)
        },
        ["ValveBiped.Bip01_L_Forearm"] = {
            pos = Vector(-100, 0, 100),
            scale = Vector(1, 100, 1)
        }
    },
    --["ValveBiped.Bip01_R_Foot"]={pos=Vector(20,0,0)},
    --["ValveBiped.Bip01_L_Foot"]={pos=Vector(20,0,0)},
    --[[moveSpeed={
		walk=100,
		run=400
	},]]
    movePoseMode = "yaw"
})

--jumpPower=400,
--health=40,
--muteSteps=true
pk_pills.register("jake_2", {
    printName = "~ALL HAIL JAKE~",
    parent = "hero_overseer",
    model = false,
    options = all_humans,
    anims = {
        default = {
            idle = "fear_reaction_idle"
        }
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if not ply:OnGround() then return end
            ent:PillSound("clang")
            local puppet = ent:GetPuppet()

            for i = 1, puppet:GetBoneCount() do
                puppet:ManipulateBonePosition(i, puppet:GetManipulateBonePosition(i) + VectorRand() * 2)
            end
        end
    },
    sounds = {
        clang = "weapons/crowbar/crowbar_impact1.wav"
    }
})

pk_pills.register("jake_car", {
    printName = "~JAKE'S CAR~",
    parent = "wheelbarrow",
    model = false,
    options = function()
        return {
            {
                model = "models/props_vehicles/car002a_physics.mdl"
            },
            {
                model = "models/props_vehicles/car001b_hatchback.mdl"
            },
            {
                model = "models/props_vehicles/car001a_hatchback.mdl"
            },
            {
                model = "models/props_vehicles/car002b_physics.mdl"
            },
            {
                model = "models/props_vehicles/car003a_physics.mdl"
            },
            {
                model = "models/props_vehicles/car003b_physics.mdl"
            },
            {
                model = "models/props_vehicles/car004a_physics.mdl"
            },
            {
                model = "models/props_vehicles/car004b_physics.mdl"
            },
            {
                model = "models/props_vehicles/car005a_physics.mdl"
            },
            {
                model = "models/props_vehicles/car005b_physics.mdl"
            },
            {
                model = "models/props_vehicles/van001a_physics.mdl"
            }
        }
    end,
    driveOptions = {
        speed = 5000
    },
    camera = {
        dist = 500
    }
})
