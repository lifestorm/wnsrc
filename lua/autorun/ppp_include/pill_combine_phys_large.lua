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

pk_pills.register("hunter_chopper", {
    printName = "Hunter-Chopper",
    side = "hl_combine",
    type = "phys",
    model = "models/Combine_Helicopter.mdl",
    default_rp_cost = 20000,
    spawnOffset = Vector(0, 0, 200),
    camera = {
        offset = Vector(80, 0, 0),
        dist = 1000
    },
    driveType = "fly",
    driveOptions = {
        speed = 20,
        tilt = 20
    },
    seqInit = "idle",
    aim = {
        xPose = "weapon_yaw",
        yPose = "weapon_pitch",
        yInvert = true,
        attachment = "Muzzle"
    },
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .02,
        damage = 10,
        spread = .05,
        tracer = "HelicopterTracer"
    },
    attack2 = {
        mode = "auto",
        func = function(ply, ent)
            ent:PillSound("dropBomb")
            local bomb = ents.Create("grenade_helicopter")
            bomb:SetPos(ent:LocalToWorld(Vector(-60, 0, -60)))
            bomb:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
            bomb:Spawn()
            bomb:SetPhysicsAttacker(ply)
            local randVec = VectorRand()
            randVec.z = 0
            bomb:GetPhysicsObject():AddVelocity(ent:GetVelocity() + randVec * 100)
        end,
        delay = .5
    },
    reload = function(ply, ent)
        if ent.lastrocket and ent.lastrocket + 1 > CurTime() then return end
        ent:PillSound("rocket")
        local rocket = ents.Create("rpg_missile")
        rocket:SetPos(ent:LocalToWorld(Vector(0, 80, -80)))
        rocket:SetAngles(ply:EyeAngles())
        rocket:SetSaveValue("m_flDamage", 200)
        rocket:SetOwner(ply)
        rocket:SetVelocity(ent:GetVelocity())
        rocket:Spawn()
        rocket = ents.Create("rpg_missile")
        rocket:SetPos(ent:LocalToWorld(Vector(0, -80, -80)))
        rocket:SetAngles(ply:EyeAngles())
        rocket:SetSaveValue("m_flDamage", 200)
        rocket:SetOwner(ply)
        rocket:SetVelocity(ent:GetVelocity())
        rocket:Spawn()
        ent.lastrocket = CurTime()
    end,
    health = 5600,
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/attack_helicopter/aheli_rotor_loop1.wav",
        loop_attack = "npc/attack_helicopter/aheli_weapon_fire_loop3.wav",
        dropBomb = "npc/attack_helicopter/aheli_mine_drop1.wav",
        die = pk_pills.helpers.makeList("ambient/explosions/explode_#.wav", 9),
        rocket = "weapons/grenade_launcher1.wav"
    }
})

pk_pills.register("gunship", {
    printName = "Combine Gunship",
    side = "hl_combine",
    type = "phys",
    model = "models/gunship.mdl",
    default_rp_cost = 20000,
    spawnOffset = Vector(0, 0, 200),
    camera = {
        offset = Vector(80, 0, 0),
        dist = 1000
    },
    driveType = "fly",
    driveOptions = {
        speed = 20,
        tilt = 20
    },
    seqInit = "prop_turn",
    aim = {
        xPose = "flex_horz",
        yPose = "flex_vert",
        attachment = "Muzzle"
    },
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .1,
        damage = 10,
        spread = .02,
        tracer = "HelicopterTracer"
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ent.usingWarpCannon then return end
            local fireAngs = ent:GetAngles()
            fireAngs.p = 45
            fireAngs.r = 0
            local tr = util.QuickTrace(ent:GetPos(), ent:GetPos() + fireAngs:Forward() * 99999, ent)
            local effectdata = EffectData()
            effectdata:SetEntity(ent)
            effectdata:SetOrigin(tr.HitPos)
            util.Effect("warp_cannon", effectdata, true, true)
            ent:PillSound("warp_charge") --belly_cannon

            timer.Simple(1.2, function()
                if not IsValid(ent) then return end
                ent:PillSound("warp_fire")
                util.BlastDamage(ent, ply, tr.HitPos, 200, 1000)

                if IsValid(tr.Entity) then
                    local phys = tr.Entity:GetPhysicsObject()

                    if IsValid(phys) then
                        phys:ApplyForceCenter(ply:EyeAngles():Forward() * 9 ^ 7)
                    end
                end
            end)

            ent.usingWarpCannon = true

            timer.Simple(2.4, function()
                if not IsValid(ent) then return end
                ent.usingWarpCannon = nil
            end)
        end
    },
    pose = {
        fin_accel = function(ply, ent, old)
            local vel = WorldToLocal(ent:GetVelocity(), Angle(), Vector(0, 0, 0), ent:GetAngles())

            return vel.x / 800
        end,
        fin_sway = function(ply, ent, old)
            local vel = WorldToLocal(ent:GetVelocity(), Angle(), Vector(0, 0, 0), ent:GetAngles())

            return -vel.y / 800
        end,
        antenna_accel = function(ply, ent, old)
            local vel = WorldToLocal(ent:GetVelocity(), Angle(), Vector(0, 0, 0), ent:GetAngles())

            return vel.x / 2000
        end,
        antenna_sway = function(ply, ent, old)
            local vel = WorldToLocal(ent:GetVelocity(), Angle(), Vector(0, 0, 0), ent:GetAngles())

            return -vel.y / 2000
        end
    },
    health = 5,
    onlyTakesExplosiveDamage = true,
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/combine_gunship/engine_whine_loop1.wav",
        loop_attack = "npc/combine_gunship/gunship_weapon_fire_loop6.wav",
        die = pk_pills.helpers.makeList("ambient/explosions/explode_#.wav", 9),
        warp_charge = "npc/strider/charging.wav",
        warp_fire = "npc/strider/fire.wav"
    }
})

pk_pills.register("dropship", {
    printName = "Combine Dropship",
    side = "hl_combine",
    type = "phys",
    model = "models/Combine_dropship.mdl",
    default_rp_cost = 10000,
    spawnOffset = Vector(0, 0, 200),
    camera = {
        offset = Vector(0, 0, 200),
        dist = 1000
    },
    driveType = "fly",
    driveOptions = {
        speed = 30,
        tilt = 20
    },
    aim = {
        xPose = "weapon_yaw",
        yPose = "weapon_pitch",
        yInvert = true,
        attachment = "Muzzle",
        usesSecondaryEnt = true
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if IsValid(ent.container) then
                ent.container:Deploy()
            end
        end
    },
    attack2 = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .1,
        damage = 4,
        spread = .01,
        tracer = "HelicopterTracer"
    },
    reload = function(ply, ent)
        if IsValid(ent.container) then
            ent.container:SetParent()
            ent.container:PhysicsInit(SOLID_VPHYSICS)
            ent.container:SetMoveType(MOVETYPE_VPHYSICS)
            ent.container:SetSolid(SOLID_VPHYSICS)
            ent.container:SetPos(ent:GetPos())
            ent.container:SetAngles(ent:GetAngles())
            ent.container:GetPhysicsObject():Wake()
            ent:SetPillAimEnt(nil)
            ent:PillSound("drop")
            ent:PillLoopStop("deploy")
            ent.container = nil
        else
            local tr = util.TraceHull({
                start = ent:GetPos(),
                endpos = ent:GetPos() + Vector(0, 0, -200),
                filter = {ent},
                mins = Vector(-50, -50, -50),
                maxs = Vector(50, 50, 50)
            })

            local grabent = tr.Entity

            if IsValid(grabent) then
                if (grabent:GetClass() == "pill_dropship_container") then
                    grabent:SetPos(ent:GetPos())
                    grabent:SetAngles(ent:GetAngles())
                    grabent:SetParent(ent)
                    grabent:Fire("setparentattachment", "cargo_anim")
                    ent:SetPillAimEnt(grabent)
                    ent:PillFilterCam(grabent)
                    ent:PillSound("grab")
                    ent.container = grabent
                elseif (grabent:GetClass() == "pill_dropship_strider" and not grabent.droppedfrom) then
                    grabent:SetPos(ent:GetPos())
                    grabent:SetAngles(ent:GetAngles())
                    grabent:SetParent(ent)
                    grabent:Fire("setparentattachment", "cargo_anim")
                    ent:PillFilterCam(grabent)
                    ent:PillSound("grab")
                    ent.container = grabent
                elseif (grabent:GetClass() == "npc_strider") then
                    local strider_grabbed = ents.Create("pill_dropship_strider")
                    strider_grabbed:SetPos(ent:GetPos())
                    strider_grabbed:SetAngles(ent:GetAngles())
                    strider_grabbed:Spawn()
                    strider_grabbed:SetParent(ent)
                    strider_grabbed:Fire("setparentattachment", "cargo_anim")
                    ent:PillFilterCam(strider_grabbed)
                    ent:PillSound("grab")
                    ent.container = strider_grabbed
                    grabent:Remove()
                end
            end
        end
    end,
    seqInit = "idle",
    pose = {
        body_accel = function(ply, ent, old)
            local vel = WorldToLocal(ent:GetVelocity(), Angle(), Vector(0, 0, 0), ent:GetAngles())

            return vel.x / 800
        end,
        body_sway = function(ply, ent, old)
            local vel = WorldToLocal(ent:GetVelocity(), Angle(), Vector(0, 0, 0), ent:GetAngles())

            return -vel.y / 800
        end
    },
    damageFromWater = -1,
    sounds = {
        loop_move = "npc/combine_gunship/dropship_engine_near_loop1.wav",
        loop_attack2 = "npc/combine_gunship/gunship_fire_loop1.wav",
        loop_deploy = "npc/combine_gunship/dropship_dropping_pod_loop1.wav",
        alert_empty = "npc/attack_helicopter/aheli_damaged_alarm1.wav",
        grab = "vehicles/Crane/crane_magnet_switchon.wav",
        drop = "vehicles/Crane/crane_magnet_release.wav",
        die = pk_pills.helpers.makeList("ambient/explosions/explode_#.wav", 9)
    }
})

pk_pills.register("advisor", {
    printName = "Advisor",
    side = "hl_combine",
    type = "phys",
    model = "models/advisor.mdl",
    default_rp_cost = 8000,
    camera = {
        dist = 250
    },
    seqInit = "Idle01",
    sphericalPhysics = 50,
    driveType = "fly",
    driveOptions = {
        speed = 10
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if ent:GetSequence() ~= ent:LookupSequence("Idle01") then return end
            ent:PillAnim("attackL", true)

            local tr = util.TraceHull({
                start = ent:GetPos(),
                endpos = ent:GetPos() + ent:GetAngles():Forward() * 200,
                filter = {ent},
                mins = Vector(-25, -25, -25),
                maxs = Vector(25, 25, 25)
            })

            if IsValid(tr.Entity) then
                local dmg = DamageInfo()
                dmg:SetAttacker(ply)
                dmg:SetInflictor(ent)
                dmg:SetDamageType(DMG_SLASH)
                dmg:SetDamage(50)
                tr.Entity:TakeDamageInfo(dmg)
                ent:PillSound("hit")
            end

            timer.Simple(.5, function()
                if not IsValid(ent) then return end
                ent:PillAnim("Idle01", true)
            end)
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ent:GetSequence() ~= ent:LookupSequence("Idle01") then return end
            ent:PillAnim("attackR", true)

            local tr = util.TraceHull({
                start = ent:GetPos(),
                endpos = ent:GetPos() + ent:GetAngles():Forward() * 200,
                filter = {ent},
                mins = Vector(-25, -25, -25),
                maxs = Vector(25, 25, 25)
            })

            if IsValid(tr.Entity) then
                local dmg = DamageInfo()
                dmg:SetAttacker(ply)
                dmg:SetInflictor(ent)
                dmg:SetDamageType(DMG_SLASH)
                dmg:SetDamage(50)
                tr.Entity:TakeDamageInfo(dmg)
                ent:PillSound("hit")
            end

            timer.Simple(.5, function()
                if not IsValid(ent) then return end
                ent:PillAnim("Idle01", true)
            end)
        end
    },
    health = 1000,
    sounds = {
        loop_move = "ambient/levels/citadel/citadel_ambient_voices1.wav",
        hit = pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav", 3)
    }
})

pk_pills.register("strider", {
    printName = "Strider",
    side = "hl_combine",
    type = "phys",
    model = "models/combine_strider.mdl",
    default_rp_cost = 20000,
    camera = {
        dist = 750
    },
    seqInit = "Idle01",
    driveType = "strider",
    aim = {
        xInvert = true,
        xPose = "minigunYaw",
        yPose = "minigunPitch",
        attachment = "MiniGun",
        fixTracers = true,
        simple = true,
        overrideStart = Vector(80, 0, -40)
    },
    attack = {
        mode = "auto",
        func = pk_pills.common.shoot,
        delay = .2,
        damage = 30,
        spread = .02,
        tracer = "HelicopterTracer"
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            if ent.usingWarpCannon then return end
            local tr = util.QuickTrace(ent:LocalToWorld(Vector(80, 0, -40)), ply:EyeAngles():Forward() * 99999, ent)
            local effectdata = EffectData()
            effectdata:SetEntity(ent)
            effectdata:SetOrigin(tr.HitPos)
            util.Effect("warp_cannon", effectdata, true, true)
            ent:PillSound("warp_charge")

            timer.Simple(1.2, function()
                if not IsValid(ent) then return end
                ent:PillSound("warp_fire")
                util.BlastDamage(ent, ply, tr.HitPos, 200, 1000)

                if IsValid(tr.Entity) then
                    local phys = tr.Entity:GetPhysicsObject()

                    if IsValid(phys) then
                        phys:ApplyForceCenter(ply:EyeAngles():Forward() * 9 ^ 7)
                    end
                end
            end)

            ent.usingWarpCannon = true

            timer.Simple(2.4, function()
                if not IsValid(ent) then return end
                ent.usingWarpCannon = nil
            end)
        end
    },
    renderOffset = function(ply, ent)
        local h = ent:GetPoseParameter("body_height") * 500

        return Vector(0, 0, 500 - h)
    end,
    health = 7,
    onlyTakesExplosiveDamage = true,
    sounds = {
        step = pk_pills.helpers.makeList("npc/strider/strider_step#.wav", 6),
        shoot = "npc/strider/strider_minigun.wav",
        warp_charge = "npc/strider/charging.wav",
        warp_fire = "npc/strider/fire.wav"
    }
})
