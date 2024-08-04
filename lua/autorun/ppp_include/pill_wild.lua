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

pk_pills.register("ichthyosaur", {
    printName = "Ichthyosaur",
    side = "wild",
    type = "phys",
    model = "models/Ichthyosaur.mdl",
    default_rp_cost = 600,
    camera = {
        dist = 350
    },
    seqInit = "swim",
    sphericalPhysics = 30,
    driveType = "swim",
    driveOptions = {
        speed = 10
    },
    aim = {
        xPose = "sidetoside",
        yPose = "upanddown",
        nocrosshair = true
    },
    attack = {
        mode = "trigger",
        func = function(ply, ent)
            if ent:GetSequence() ~= ent:LookupSequence("swim") then return end
            ent:PillAnim("attackstart", true)

            timer.Simple(.5, function()
                if not IsValid(ent) then return end

                local tr = util.TraceHull({
                    start = ent:GetPos(),
                    endpos = ent:GetPos() + ent:GetAngles():Forward() * 200,
                    filter = {ent},
                    mins = Vector(-5, -5, -5),
                    maxs = Vector(5, 5, 5)
                })

                if IsValid(tr.Entity) then
                    local dmg = DamageInfo()
                    dmg:SetAttacker(ply)
                    dmg:SetInflictor(ent)
                    dmg:SetDamageType(DMG_SLASH)
                    dmg:SetDamage(50)
                    tr.Entity:TakeDamageInfo(dmg)
                    ent:PillAnim("attackend", true)
                    ent:PillSound("bite")

                    timer.Simple(1.8, function()
                        if not IsValid(ent) then return end
                        ent:PillAnim("swim", true)
                    end)
                else
                    ent:PillAnim("attackmiss", true)

                    timer.Simple(.5, function()
                        if not IsValid(ent) then return end
                        ent:PillAnim("swim", true)
                    end)
                end
            end)
        end
    },
    attack2 = {
        mode = "trigger",
        func = function(ply, ent)
            ent:PillSound("vocalize")
        end
    },
    health = 400,
    sounds = {
        loop_move = "npc/ichthyosaur/water_breath.wav",
        vocalize = pk_pills.helpers.makeList("npc/ichthyosaur/attack_growl#.wav", 3),
        bite = "npc/ichthyosaur/snap.wav"
    }
})

pk_pills.register("barnacle", {
    printName = "Barnacle",
    side = "harmless",
    type = "phys",
    model = "models/barnacle.mdl",
    boxPhysics = {Vector(-10, -10, -20), Vector(10, 10, 0)},
    default_rp_cost = 1000,
    userSpawn = {
        type = "ceiling",
        offset = Vector(0, 0, 2)
    },
    spawnFrozen = true,
    camera = {
        offset = Vector(0, 0, -50),
        dist = 100,
        underslung = true
    },
    seqInit = "idle01",
    attack = {
        mode = "auto",
        delay = 0,
        func = function(ply, ent)
            if ent.busy then return end

            if not IsValid(ent.tongue) then
                ent.tongue = ents.Create("pill_barnacle_tongue")
                ent.tongue:SetPos(ent:GetPos() + Vector(0, 0, -40))
                ent.tongue:Spawn()
                ent:DeleteOnRemove(ent.tongue)
                constraint.NoCollide(ent, ent.tongue, 0, 0)
                ent.tongue_constraint, ent.tongue_vis = constraint.Elastic(ent, ent.tongue, 0, 0, Vector(0, 0, -30), Vector(0, 0, 0), 20000, 4000, 0, "cable/rope", 1, true)
                ent.tongue_len = 20
            elseif IsValid(ent.tongue_constraint) then
                ent.tongue_len = ent.tongue_len + 1
                ent.tongue_constraint:Fire("SetSpringLength", ent.tongue_len, 0)
                ent.tongue_vis:Fire("SetLength", ent.tongue_len, 0)
            end
        end
    },
    attack2 = {
        mode = "auto",
        delay = 0,
        func = function(ply, ent)
            if ent.busy then return end

            if not IsValid(ent.tongue) or ent.tongue_len <= 20 then
                ent:PillAnim("attack_smallthings", true)
                ent:PillAnim("attack_smallthings", true)
                ent.busy = true

                timer.Simple(.8, function()
                    if not IsValid(ent) then return end

                    local tr = util.TraceHull({
                        start = ent:GetPos() + Vector(0, 0, -10),
                        endpos = ent:GetPos() + Vector(0, 0, -60),
                        filter = {ent, ply, (IsValid(ent.tongue) and ent.tongue or nil)},
                        mins = Vector(-10, -10, -10),
                        maxs = Vector(10, 10, 10)
                    })

                    if (tr.HitNonWorld) then
                        if tr.Entity:IsRagdoll() then
                            local effectdata = EffectData()
                            effectdata:SetOrigin(ent:GetPos() + Vector(0, 0, -30))
                            effectdata:SetNormal(Vector(0, 0, -1))
                            effectdata:SetMagnitude(1)
                            effectdata:SetScale(10)
                            effectdata:SetColor(0)
                            effectdata:SetFlags(3)
                            util.Effect("bloodspray", effectdata)
                            ent:PillSound("chompgib")
                            tr.Entity:Remove()

                            for k, v in pairs{"models/Gibs/HGIBS.mdl", "models/Gibs/HGIBS_rib.mdl", "models/Gibs/HGIBS_scapula.mdl", "models/Gibs/HGIBS_spine.mdl"} do
                                local d = ents.Create("prop_physics")
                                d:SetModel(v)
                                d:SetPos(ent:GetPos() + Vector(0, 0, -30))
                                d:Spawn()
                                d:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
                                d:Fire("Kill", nil, 10)
                                local p = d:GetPhysicsObject()

                                if IsValid(p) then
                                    p:ApplyForceCenter(VectorRand() * 1000)
                                end
                            end
                        else
                            tr.Entity:TakeDamage(20, ply, ent)
                            ent:PillSound("chomp")
                        end
                    end
                end)

                timer.Simple(1.5, function()
                    if not IsValid(ent) then return end
                    ent:PillAnim("idle01", true)
                    ent.busy = false
                end)
            elseif IsValid(ent.tongue_constraint) then
                ent.tongue_len = ent.tongue_len - 1
                ent.tongue_constraint:Fire("SetSpringLength", ent.tongue_len, 0)
                ent.tongue_vis:Fire("SetLength", ent.tongue_len, 0)
            end
        end
    },
    reload = function(ply, ent)
        if IsValid(ent.tongue) then
            if constraint.RemoveConstraints(ent.tongue, "Weld") then
                ent:PillSound("drop")
            end
        end
    end,
    boneMorphs = {
        ["Barnacle.tongue1"] = {
            scale = Vector(0, 0, 0),
            pos = Vector(0, 0, 50)
        },
        ["Barnacle.tongue2"] = {
            scale = Vector(0, 0, 0)
        },
        ["Barnacle.tongue3"] = {
            scale = Vector(0, 0, 0)
        },
        ["Barnacle.tongue4"] = {
            scale = Vector(0, 0, 0)
        },
        ["Barnacle.tongue5"] = {
            scale = Vector(0, 0, 0)
        },
        ["Barnacle.tongue6"] = {
            scale = Vector(0, 0, 0)
        },
        ["Barnacle.tongue7"] = {
            scale = Vector(0, 0, 0)
        },
        ["Barnacle.tongue8"] = {
            scale = Vector(0, 0, 0)
        }
    },
    health = 35,
    sounds = {
        chomp = "npc/barnacle/barnacle_crunch3.wav",
        chompgib = "player/pl_fallpain1.wav",
        drop = "npc/barnacle/barnacle_bark1.wav"
    }
})
