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

pk_pills.register("rollermine", {
    printName = "Rollermine",
    side = "hl_combine",
    type = "phys",
    model = "models/roller.mdl",
    model2 = "models/roller_spikes.mdl",
    default_rp_cost = 3000,
    driveType = "roll",
    driveOptions = {
        power = 8000,
        jump = 15000,
        burrow = 6
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if ent:GetMoveType() ~= MOVETYPE_VPHYSICS then return end

            if ent:GetModel() == ent.formTable.model then
                ent:PillSound("bladesOut")
                ent:PillLoopSound("charge")
            else
                ent:PillSound("bladesIn")
                ent:PillLoopStop("charge")
            end

            ent:SetModel(ent:GetModel() == ent.formTable.model and ent.formTable.model2 or ent.formTable.model)
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillDie()
        end
    },
    diesOnExplode = true,
    damageFromWater = -1,
    die = function(ply, ent)
        local explode = ents.Create("env_explosion")
        explode:SetPos(ent:GetPos())
        explode:Spawn()
        explode:SetOwner(ply)
        explode:SetKeyValue("iMagnitude", "100")
        explode:Fire("Explode", 0, 0)
    end,
    sounds = {
        jump = "npc/roller/mine/rmine_predetonate.wav",
        burrow = "npc/roller/mine/combine_mine_deactivate1.wav",
        contact = "npc/roller/mine/rmine_explode_shock1.wav",
        bladesIn = pk_pills.helpers.makeList("npc/roller/mine/rmine_blades_in#.wav", 3),
        bladesOut = pk_pills.helpers.makeList("npc/roller/mine/rmine_blades_out#.wav", 3),
        loop_move = "npc/roller/mine/rmine_moveslow_loop1.wav",
        loop_charge = "npc/roller/mine/rmine_seek_loop2.wav"
    },
    moveSoundControl = function(ply, ent)
        local MineSpeed = ent:GetVelocity():Length()
        if MineSpeed > 50 then return math.Clamp(MineSpeed / 2, 100, 150) end
    end,
    contact = function(ply, ent, other)
        if ent:GetModel() == ent.formTable.model2 then return 25, DMG_SHOCK, 20000 end
    end
})

pk_pills.register("cityscanner", {
    printName = "City Scanner",
    side = "hl_combine",
    type = "phys",
    model = "models/Combine_Scanner.mdl",
    default_rp_cost = 1000,
    driveType = "fly",
    driveOptions = {
        speed = 6
    },
    aim = {
        xPose = "flex_horz",
        yPose = "flex_vert",
        nocrosshair = true
    },
    pose = {
        dynamo_wheel = function(ply, ent, old) return old + 10 end,
        tail_control = function(ply, ent) return ent:GetPhysicsObject():GetVelocity().z / 6 end
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillSound("pic")
        end
    },
    seqInit = "idle",
    health = 30,
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/scanner/scanner_scan_loop1.wav",
        die = "npc/scanner/scanner_explode_crash2.wav",
        pic = "npc/scanner/scanner_photo1.wav"
    }
})

pk_pills.register("manhack", {
    printName = "Manhack",
    side = "hl_combine",
    type = "phys",
    model = "models/manhack.mdl",
    default_rp_cost = 2000,
    driveType = "fly",
    driveOptions = {
        speed = 6,
        tilt = 20
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if not ent.blades then
                ent:PillSound("toggleBlades")
                ent:PillLoopSound("blades")
            else
                ent:PillSound("toggleBlades")
                ent:PillLoopStop("blades")
            end

            ent.blades = not ent.blades
        end
    },
    pose = {
        Panel1 = function(ply, ent, old)
            if ent.blades and old < 90 then return old + 20 end
            if not ent.blades and old > 0 then return old - 20 end
        end,
        Panel2 = function(ply, ent, old)
            if ent.blades and old < 90 then return old + 20 end
            if not ent.blades and old > 0 then return old - 20 end
        end,
        Panel3 = function(ply, ent, old)
            if ent.blades and old < 90 then return old + 20 end
            if not ent.blades and old > 0 then return old - 20 end
        end,
        Panel4 = function(ply, ent, old)
            if ent.blades and old < 90 then return old + 20 end
            if not ent.blades and old > 0 then return old - 20 end
        end
    },
    bodyGroups = {1, 2},
    seqInit = "fly",
    health = 25,
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/manhack/mh_engine_loop1.wav",
        loop_blades = "npc/manhack/mh_blade_loop1.wav",
        toggleBlades = "npc/manhack/mh_blade_snick1.wav",
        cut_flesh = pk_pills.helpers.makeList("npc/manhack/grind_flesh#.wav", 3),
        cut = pk_pills.helpers.makeList("npc/manhack/grind#.wav", 5),
        die = "npc/manhack/gib.wav"
    },
    collide = function(ply, ent, collide)
        if ent.blades and collide.HitNormal.z < 0.5 and collide.HitNormal.z > -0.5 then
            local force = -collide.HitNormal
            --GTFO
            ent:GetPhysicsObject():ApplyForceCenter(force * 1000)
            --Give Damage
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(25)
            dmginfo:SetAttacker(ply)
            dmginfo:SetDamageForce(force * -10000)
            collide.HitEntity:TakeDamageInfo(dmginfo)

            if (collide.HitEntity:IsPlayer() or collide.HitEntity:IsNPC() or collide.HitEntity:GetClass() == "pill_ent_phys") then
                ent:PillSound("cut_flesh")
            else
                ent:PillSound("cut")
            end
        end
    end,
    contactForceHorizontal = true
})

pk_pills.register("clawscanner", {
    printName = "Claw Scanner",
    side = "hl_combine",
    type = "phys",
    model = "models/Shield_Scanner.mdl",
    default_rp_cost = 3000,
    driveType = "fly",
    driveOptions = {
        speed = 6
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if ent:GetSequence() == ent:LookupSequence("HoverClosed") then
                --NOT calling this twice will result in bugged animations. Fuck your animations, Valve.
                ent:PillAnim("OpenUp", true)
                ent:PillAnim("OpenUp", true)
                local mine

                timer.Simple(1, function()
                    if not IsValid(ent) then return end
                    --Make a mine
                    local attach = ent:LookupAttachment("claw")
                    mine = ents.Create("pill_hopper")
                    local angpos = ent:GetAttachment(attach)
                    mine:SetPos(angpos.Pos)
                    mine:SetAngles(angpos.Ang)
                    mine:SetParent(ent)
                    mine:Spawn()
                    mine:SetOwner(ply)
                    mine:Fire("setparentattachment", "claw", 0.01)
                    ent:PillSound("minepop")
                end)

                timer.Simple(3, function()
                    if not IsValid(ent) then return end
                    ent:PillAnim("CloseUp", true)
                    mine:SetParent(nil)
                    mine:PhysicsInit(SOLID_VPHYSICS)
                    local phys = mine:GetPhysicsObject()

                    if (phys:IsValid()) then
                        phys:Wake()
                    end

                    ent:PillSound("minedrop")

                    timer.Simple(2, function()
                        if not IsValid(ent) then return end
                        ent:PillAnim("HoverClosed", true)
                    end)
                end)
            end
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillSound("pic")
        end
    },
    seqInit = "HoverClosed",
    health = 30,
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/scanner/combat_scan_loop6.wav",
        die = "npc/scanner/scanner_explode_crash2.wav",
        minepop = "npc/ichthyosaur/snap.wav",
        minedrop = pk_pills.helpers.makeList("npc/scanner/combat_scan#.wav", 5),
        pic = "npc/scanner/scanner_photo1.wav"
    }
})

pk_pills.register("cturret", {
    printName = "Combine Turret",
    side = "hl_combine",
    type = "phys",
    model = "models/combine_turrets/floor_turret.mdl",
    default_rp_cost = 2000,
    spawnOffset = Vector(0, 0, 5),
    camera = {
        offset = Vector(0, 0, 60)
    },
    aim = {
        xPose = "aim_yaw",
        yPose = "aim_pitch",
        attachment = "eyes"
    },
    canAim = function(ply, ent) return ent.active end,
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .1,
        damage = 4,
        spread = .01,
        anim = "fire",
        tracer = "AR2Tracer"
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
                ent:PillLoopSound("alarm")

                timer.Simple(1, function()
                    if not IsValid(ent) then return end
                    ent:PillLoopStop("alarm")
                end)
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
    diesOnExplode = true,
    damageFromWater = -1,
    sounds = {
        loop_alarm = "npc/turret_floor/alarm.wav",
        shoot = pk_pills.helpers.makeList("npc/turret_floor/shoot#.wav", 3),
        deploy = "npc/turret_floor/deploy.wav",
        retract = "npc/turret_floor/retract.wav",
        die = "npc/turret_floor/die.wav",
        auto_ping = "npc/turret_floor/ping.wav",
        auto_ping_func = function(ply, ent) return ent.active and not ent.loopingSounds["alarm"]:IsPlaying() and (not ent.lastAttack or ent.lastAttack + .2 < CurTime()), 1 end
    }
})

pk_pills.register("mortar_synth", {
    printName = "Mortar Synth",
    side = "hl_combine",
    type = "phys",
    model = "models/mortarsynth.mdl",
    default_rp_cost = 8000,
    sphericalPhysics = 30,
    driveType = "hover",
    driveOptions = {
        speed = 6,
        height = 50
    },
    attack = {
        mode = "auto",
        delay = 1,
        func = function(ply, ent)
            --if ent.attacking then return end
            ent:PillAnim("Mortar_Shoot", true)
            ent:SetPlaybackRate(2)

            --ent.attacking=true
            timer.Simple(.5, function()
                if not IsValid(ent) then return end
                ent:PillSound("fire")
                local angs = ply:EyeAngles()
                angs.p = angs.p - 45
                local nade = ents.Create("pill_proj_energy_grenade")
                nade:SetPos(ent:LocalToWorld(Vector(50, 0, 50)))
                nade:SetAngles(angs)
                nade:SetOwner(ply)
                nade:Spawn()
            end)
        end
    },
    --[[timer.Simple(1,function()
				if !IsValid(ent) then return end
				ent.attacking=nil
			end)]]
    health = 400,
    sounds = {
        loop_move = "npc/scanner/combat_scan_loop6.wav",
        fire = "npc/env_headcrabcanister/launch.wav"
    }
})
