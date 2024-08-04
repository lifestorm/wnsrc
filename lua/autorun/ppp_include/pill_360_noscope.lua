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

--Made by SkyLight http://steamcommunity.com/id/_I_I_I_I_I/, had to be indented manually because copy/pasta from github didn't.  Copy pastad of Parakeet's code.  
--Formatted and edited by Parakeet
pk_pills.register("professional", {
    printName = "Lab Gamer",
    type = "ply",
    default_rp_cost = 1337666420,
    model = "models/player/hostage/hostage_04.mdl",
    anims = {
        default = {
            idle = "idle_pistol",
            walk = "menu_walk",
            run = "run_pistol",
            crouch = "cidle_pistol",
            crouch_walk = "cwalk_pistol",
            glide = "swimming_pistol",
            jump = "jump_pistol",
            g_attack = "taunt_laugh", --flinch_head_02
            g_reload = "gesture_agree",
            dropItem = "Heal"
        }
    },
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    moveSpeed = {
        walk = 60,
        run = 200,
        ducked = 40
    },
    loadout = {"pill_wep_pro"},
    ammo = {
        Buckshot = 100,
        ["357"] = 100
    },
    health = 1,
    validHoldTypes = {"smg", "ar2", "shotgun", "crossbow", "pistol"},
    movePoseMode = "xy"
})

pk_pills.register("pubbie", {
    printName = "Pub Scrub",
    type = "ply",
    default_rp_cost = 8008135,
    options = function()
        return {
            {
                model = "models/player/urban.mdl"
            },
            {
                model = "models/player/gasmask.mdl"
            },
            {
                model = "models/player/riot.mdl"
            },
            {
                model = "models/player/swat.mdl"
            },
            {
                model = "models/player/guerilla.mdl"
            },
            {
                model = "models/player/arctic.mdl"
            },
            {
                model = "models/player/phoenix.mdl"
            },
            {
                model = "models/player/leet.mdl"
            }
        }
    end,
    anims = {
        default = {
            idle = "idle_pistol",
            walk = "walk_pistol",
            run = "run_pistol",
            crouch = "cidle_pistol",
            crouch_walk = "cwalk_pistol",
            glide = "swimming_pistol",
            jump = "jump_pistol",
            g_attack = "flinch_head_02",
            g_reload = "reload_pistol",
            dropItem = "Heal"
        },
        smg = {
            idle = "idle_smg1",
            walk = "walk_smg1",
            run = "run_smg1",
            crouch = "cidle_smg1",
            crouch_walk = "cwalk_smg1"
        },
        ar2 = {
            idle = "idle_ar2",
            walk = "walk_ar2",
            run = "run_ar2",
            crouch = "cidle_ar2",
            crouch_walk = "cwalk_ar2"
        }
    },
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    moveSpeed = {
        walk = 60,
        run = 200,
        ducked = 40
    },
    loadout = {"pill_wep_alyxgun"},
    ammo = {
        smg1 = 300
    },
    health = 100,
    validHoldTypes = {"smg", "ar2", "shotgun", "crossbow", "pistol"},
    movePoseMode = "xy"
})

pk_pills.register("casual", {
    printName = "Casual",
    type = "ply",
    default_rp_cost = 1234567,
    options = function()
        return {
            {
                model = "models/player/hostage/hostage_01.mdl"
            },
            {
                model = "models/player/hostage/hostage_02.mdl"
            },
            {
                model = "models/player/hostage/hostage_03.mdl"
            }
        }
    end,
    anims = {
        default = {
            idle = "idle_smg1",
            walk = "walk_smg1",
            run = "run_smg1",
            crouch = "cidle_smg1",
            crouch_walk = "cwalk_smg1",
            glide = "swimming_smg1",
            jump = "jump_smg1",
            g_attack = "flinch_head_02",
            g_reload = "reload_smg1",
            dropItem = "Heal"
        }
    },
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    moveSpeed = {
        walk = 60,
        run = 200,
        ducked = 40
    },
    loadout = {"weapon_smg1"},
    ammo = {
        smg1 = 150,
        smg1_grenade = 5
    },
    health = 150,
    validHoldTypes = {"smg", "ar2", "shotgun", "crossbow", "pistol"},
    movePoseMode = "xy"
})
