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

pk_pills.register("citizen_m", {
    printName = "Male Citizen",
    type = "ply",
    voxSet = "citm",
    default_rp_cost = 600,
    options = function()
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
            }
        }
    end,
    anims = {
        default = {
            idle = "idle_angry",
            walk = "walk_all",
            run = "run_all",
            crouch = "Crouch_idleD",
            crouch_walk = "Crouch_walk_aLL",
            glide = "jump_holding_glide",
            jump = "jump_holding_jump",
            g_attack = "gesture_shoot_smg1",
            g_reload = "gesture_reload_smg1",
            dropItem = "Heal"
        },
        smg = {
            idle = "Idle_SMG1_Aim_Alert",
            walk = "walkAIMALL1",
            run = "run_aiming_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all"
        },
        ar2 = {
            idle = "idle_angry_Ar2",
            walk = "walkAIMALL1_ar2",
            run = "run_aiming_ar2_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all",
            g_attack = "gesture_shoot_ar2",
            g_reload = "gesture_reload_ar2"
        },
        shotgun = {
            idle = "Idle_Angry_Shotgun",
            walk = "walkAIMALL1_ar2",
            run = "run_aiming_ar2_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all",
            g_attack = "gesture_shoot_shotgun",
            g_reload = "gesture_reload_ar2"
        }
    },
    flashlight = function(ply, ent)
        if ply:IsOnGround() and ent.formTable.drops then
            ent:PillAnim("dropItem", true)

            timer.Simple(1.25, function()
                if not IsValid(ent) then return end
                local ang = ply:EyeAngles()
                ang.p = 0
                local item = ents.Create(table.Random(ent.formTable.drops))
                item:SetPos(ply:EyePos() + ang:Forward() * 70)
                item:Spawn()
            end)
        end
    end,
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    moveSpeed = {
        walk = 60,
        run = 200,
        ducked = 40
    },
    loadout = {"pill_wep_holstered"},
    health = 100,
    validHoldTypes = {"smg", "ar2", "shotgun"},
    movePoseMode = "yaw"
})

pk_pills.register("refugee_m", {
    parent = "citizen_m",
    printName = "Male Refugee",
    default_rp_cost = 4000,
    options = function()
        return {
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
            }
        }
    end,
    loadout = {nil, "weapon_smg1"},
    ammo = {
        smg1 = 50
    }
})

pk_pills.register("rebel_m", {
    parent = "citizen_m",
    printName = "Male Rebel",
    drops = {"item_ammo_pistol", "item_ammo_smg1", "item_ammo_ar2", "item_box_buckshot"},
    default_rp_cost = 5000,
    options = function()
        return {
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
            }
        }
    end,
    loadout = {nil, "weapon_ar2", "weapon_shotgun"},
    ammo = {
        AR2 = 50,
        Buckshot = 50
    }
})

pk_pills.register("medic_m", {
    parent = "citizen_m",
    printName = "Male Medic",
    drops = {"item_healthkit"},
    default_rp_cost = 6000,
    options = function()
        return {
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
            }
        }
    end,
    loadout = {nil, "weapon_smg1"},
    ammo = {
        smg1 = 50
    }
})

pk_pills.register("citizen_f", {
    parent = "citizen_m",
    printName = "Female Citizen",
    voxSet = "citf",
    options = function()
        return {
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
            }
        }
    end
})

pk_pills.register("refugee_f", {
    parent = "refugee_m",
    printName = "Female Refugee",
    voxSet = "citf",
    options = function()
        return {
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
            }
        }
    end
})

pk_pills.register("rebel_f", {
    parent = "rebel_m",
    printName = "Female Rebel",
    voxSet = "citf",
    options = function()
        return {
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
            }
        }
    end
})

pk_pills.register("medic_f", {
    parent = "medic_m",
    printName = "Female Medic",
    voxSet = "citf",
    options = function()
        return {
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
            }
        }
    end
})
