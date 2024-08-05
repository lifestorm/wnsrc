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

pk_pills.register("dog", {
    printName = "Dog",
    type = "ply",
    model = "models/dog.mdl",
    default_rp_cost = 10000,
    camera = {
        dist = 300
    },
    hull = Vector(120, 120, 100),
    anims = {
        default = {
            idle = "idle01",
            walk = "walk_all",
            run = "run_all",
            melee = "throw"
        }
    },
    sounds = {
        melee = "npc/dog/dog_servo6.wav",
        melee_hit = pk_pills.helpers.makeList("physics/metal/metal_box_impact_hard#.wav", 3),
        step = pk_pills.helpers.makeList("npc/dog/dog_footstep#.wav", 4)
    },
    aim = {
        xPose = "head_yaw",
        yPose = "head_pitch"
    },
    reload = function(ply, ent)
        pk_pills.common.melee(ply, ent, {
            delay = .5,
            range = 150,
            dmg = 50
        })
    end,
    movePoseMode = "yaw",
    moveSpeed = {
        walk = 150,
        run = 500
    },
    jumpPower = 0,
    loadout = {"weapon_physcannon"},
    hideWeapons = true,
    health = 1200
})

pk_pills.register("hero_infiltrator", {
    printName = "The Infiltrator",
    type = "ply",
    model = "models/barney.mdl",
    default_rp_cost = 10000,
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
            change = "helmet_reveal"
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
            --g_attack="gesture_shoot_ar2",
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
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch"
    },
    moveSpeed = {
        walk = 60,
        run = 200,
        ducked = 40
    },
    loadout = {"pill_wep_holstered", "weapon_ar2", "weapon_shotgun", "weapon_smg1"},
    ammo = {
        AR2 = 100,
        Buckshot = 100,
        smg1 = 100
    },
    health = 1000,
    validHoldTypes = {"smg", "ar2", "shotgun"},
    movePoseMode = "yaw",
    flashlight = function(ply, ent)
        if not ply:IsOnGround() then return end
        ent:PillAnim("change", true)

        if ent.disguised then
            ent.disguised = nil

            timer.Simple(1, function()
                if IsValid(ent.disguise_faceplate) then
                    ent.disguise_faceplate:Fire("setparentattachment", "faceplate_attachment", 0)
                end

                if IsValid(ent) then
                    pk_pills.setAiTeam(ply, "default")
                end
            end)

            timer.Simple(2, function()
                if IsValid(ent.disguise_faceplate) then
                    ent.disguise_faceplate:Remove()
                end

                if IsValid(ent.disguise_helmet) then
                    ent.disguise_helmet:Remove()
                end
            end)
        else --helmet_attachment faceplate_attachment
            ent.disguised = true
            ent.disguise_faceplate = ents.Create("prop_dynamic")
            ent.disguise_faceplate:SetModel("models/barneyhelmet_faceplate.mdl")
            ent.disguise_faceplate:SetPos(ply:GetPos())
            ent.disguise_faceplate:SetParent(ent:GetPuppet())
            ent.disguise_faceplate:Spawn()
            ent.disguise_faceplate:Fire("setparentattachment", "faceplate_attachment", 0)
            ent.disguise_helmet = ents.Create("prop_dynamic")
            ent.disguise_helmet:SetModel("models/barneyhelmet.mdl")
            ent.disguise_helmet:SetPos(ply:GetPos())
            ent.disguise_helmet:SetParent(ent:GetPuppet())
            ent.disguise_helmet:Spawn()
            ent.disguise_helmet:Fire("setparentattachment", "helmet_attachment", 0)

            timer.Simple(1, function()
                if IsValid(ent.disguise_faceplate) then
                    ent.disguise_faceplate:Fire("setparentattachment", "helmet_attachment", 0)
                end

                if IsValid(ent) then
                    pk_pills.setAiTeam(ply, "hl_infiltrator")
                end
            end)
        end
    end
})

pk_pills.register("hero_monk", {
    printName = "The Monk",
    type = "ply",
    model = "models/monk.mdl",
    default_rp_cost = 10000,
    anims = {
        default = {
            idle = "lineidle02",
            walk = "walk_all",
            run = "run_all",
            crouch = "Crouch_idleD",
            crouch_walk = "Crouch_walk_aLL",
            glide = "jump_holding_glide",
            jump = "jump_holding_jump",
            g_attack = "gesture_shoot_smg1",
            g_reload = "gesture_reload_smg1"
        },
        smg = {
            idle = "Idle_SMG1_Aim_Alert",
            walk = "walkAIMALL1",
            run = "run_alert_aiming_all",
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
        },
        crossbow = {
            idle = "Idle_SMG1_Aim_Alert",
            walk = "walkAIMALL1_ar2",
            run = "run_aiming_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all",
            g_attack = "gesture_shoot_ar2",
            g_reload = "gesture_reload_ar2"
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
    loadout = {"pill_wep_holstered", "weapon_shotgun", "pill_wep_annabelle"},
    ammo = {
        Buckshot = 100,
        ["357"] = 100
    },
    health = 1000,
    validHoldTypes = {"smg", "ar2", "shotgun", "crossbow"},
    movePoseMode = "yaw"
})

pk_pills.register("hero_overseer", {
    printName = "The Overseer",
    type = "ply",
    model = "models/gman_high.mdl",
    default_rp_cost = 20000,
    anims = {
        default = {
            idle = "idle",
            walk = "walk_all",
            run = "sprint_all", --pace_all
            crouch = "Crouch_idleD",
            crouch_walk = "Crouch_walk_aLL",
            glide = "jump_holding_glide",
            jump = "jump_holding_jump",
            melee = "swing",
            cloak = "open_door_away",
            teleport = "tiefidget"
        }
    },
    sounds = {
        --melee=pk_pills.helpers.makeList("npc/zombie/zo_attack#.wav",2),
        melee_hit = pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav", 3),
        melee_miss = pk_pills.helpers.makeList("npc/zombie/claw_miss#.wav", 2),
        cloak = "buttons/combine_button1.wav",
        uncloak = "buttons/combine_button1.wav",
        teleport = "ambient/machines/teleport4.wav"
    },
    cloak = {
        max = -1
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
        func = function(a, b, c)
            if not b.iscloaked then
                pk_pills.common.melee(a, b, c)
            end
        end,
        delay = .3,
        range = 40,
        dmg = 1000
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if not ply:OnGround() then return end
            ent:PillAnim("cloak", true)

            timer.Simple(1, function()
                if not IsValid(ent) then return end
                ent:ToggleCloak()
            end)
        end
    },
    --[[
			if ent.cloaked then
				ent.cloaked=nil

				timer.Simple(1,function()
					if !IsValid(ent) then return end
					ent:PillSound("cloak")
					ent:GetPuppet():SetMaterial()
					ent:GetPuppet():DrawShadow(true)
					pk_pills.setAiTeam(ply,"default")
				end)
			else
				ent.cloaked=true

				timer.Simple(1,function()
					if !IsValid(ent) or !IsValid(ent:GetPuppet()) then return end
					ent:PillSound("cloak")
					ent:GetPuppet():SetMaterial("Models/effects/vol_light001")
					ent:GetPuppet():DrawShadow(false)
					pk_pills.setAiTeam(ply,"harmless")
				end)
			end]]
    reload = function(ply, ent)
        if not ply:OnGround() then return end
        ent:PillAnim("teleport", true)

        timer.Simple(1, function()
            if not IsValid(ent) then return end
            local tracein = {}
            tracein.maxs = Vector(16, 16, 72)
            tracein.mins = Vector(-16, -16, 0)
            tracein.start = ply:EyePos()
            tracein.endpos = ply:EyePos() + ply:EyeAngles():Forward() * 9999
            tracein.filter = {ply, ent, ent:GetPuppet()}
            local traceout = util.TraceHull(tracein)
            ply:SetPos(traceout.HitPos)
            ent:PillSound("teleport")
        end)
    end
})

pk_pills.register("hero_hacker", {
    printName = "The Hacker",
    type = "ply",
    model = "models/alyx.mdl",
    default_rp_cost = 10000,
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
            g_reload = "gesture_reload_smg1"
        },
        smg = {
            idle = "Idle_SMG1_Aim_Alert",
            walk = "walkAIMALL1",
            run = "run_aiming_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all"
        },
        ar2 = {
            idle = "idle_ar2_aim",
            walk = "walkAIMALL1_ar2",
            run = "run_aiming_ar2_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all",
            --g_attack="gesture_shoot_ar2",
            g_reload = "gesture_reload_ar2"
        },
        shotgun = {
            idle = "idle_ar2_aim",
            walk = "walkAIMALL1_ar2",
            run = "run_aiming_ar2_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all",
            g_attack = "gesture_shoot_shotgun",
            g_reload = "gesture_reload_ar2"
        },
        pistol = {
            idle = "Pistol_idle_aim",
            walk = "walk_aiming_p_all",
            run = "run_aiming_p_all"
        }
    },
    sounds = {
        hack = "buttons/blip1.wav",
        nohack = "buttons/button2.wav"
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
    loadout = {"pill_wep_holstered", "pill_wep_alyxgun", "weapon_shotgun"},
    ammo = {
        smg1 = 300
    },
    health = 1000,
    validHoldTypes = {"pistol", "smg", "ar2", "shotgun"},
    movePoseMode = "yaw",
    flashlight = function(ply, ent)
        local tr = ply:GetEyeTrace()
        local hackables = {"npc_turret_floor", "npc_rollermine", "npc_manhack"}

        if (tr.HitPos:Distance(tr.StartPos) < 100 and table.HasValue(hackables, tr.Entity:GetClass())) and pk_pills.getAiTeam(tr.Entity) ~= "default" then
            pk_pills.setAiTeam(tr.Entity, "default")
            ent:PillSound("hack")

            if tr.Entity:GetClass() ~= "npc_turret_floor" then
                tr.Entity:GetPhysicsObject():SetVelocity(ply:GetAimVector() * 100)
            end
        else
            ent:PillSound("nohack")
        end
    end
})

pk_pills.register("hero_physicist", {
    printName = "The Physicist",
    type = "ply",
    model = "models/Kleiner.mdl",
    default_rp_cost = 10000,
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
            g_reload = "gesture_reload_smg1"
        },
        smg = {
            idle = "Idle_SMG1_Aim_Alert",
            walk = "walkAIMALL1",
            run = "run_aiming_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all"
        },
        ar2 = {
            idle = "idle_ar2_aim",
            walk = "walkAIMALL1_ar2",
            run = "run_aiming_ar2_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all",
            --g_attack="gesture_shoot_ar2",
            g_reload = "gesture_reload_ar2"
        },
        shotgun = {
            idle = "idle_ar2_aim",
            walk = "walkAIMALL1_ar2",
            run = "run_aiming_ar2_all",
            crouch = "crouch_aim_smg1",
            crouch_walk = "Crouch_walk_aiming_all",
            g_attack = "gesture_shoot_shotgun",
            g_reload = "gesture_reload_ar2"
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
    loadout = {"pill_wep_holstered", "weapon_shotgun", "pill_wep_translocator"},
    ammo = {
        AR2 = 100,
        Buckshot = 100,
        smg1 = 100
    },
    health = 1000,
    validHoldTypes = {"smg", "ar2", "shotgun"},
    movePoseMode = "yaw"
})
