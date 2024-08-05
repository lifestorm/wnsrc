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
helpers = {}

function helpers.makeList(str, n1, n2)
    if not n2 then
        n2 = n1
        n1 = 1
    end

    local lst = {}

    for i = n1, n2 do
        table.insert(lst, string.Replace(str, "#", tostring(i)))
    end

    return lst
end

common = {}

if SERVER then
    function common.shoot(ply, ent, tbl)
        local aim = ent.formTable.aim
        if ent.formTable.canAim and not ent.formTable.canAim(ply, ent) then return end
        if aim.usesSecondaryEnt and not IsValid(ent:GetPillAimEnt()) then return end
        local aimEnt = aim.usesSecondaryEnt and ent:GetPillAimEnt() or (ent.formTable.type == "ply" and ent:GetPuppet()) or ent
        local start

        if aim.attachment then
            start = aimEnt:GetAttachment(aimEnt:LookupAttachment(aim.attachment))
        elseif aim.offset then
            local a = ply:EyeAngles()
            a.p = 0

            start = {
                Pos = ply:EyePos() + a:Forward() * aim.offset,
                Ang = ply:EyeAngles()
            }
        else
            return
        end

        local bullet = {}

        -- PLZ FIX
        if aim.overrideStart then
            bullet.Src = ent:LocalToWorld(aim.overrideStart)
        else
            if not start then return end
            bullet.Src = start.Pos
        end

        --debugoverlay.Sphere(bullet.Src,10,1, Color(0,0,255), true)
        --[[bullet.Src = start.Pos]]
        bullet.Attacker = ply

        if aim.simple then
            bullet.Dir = ply:EyeAngles():Forward()
        else
            bullet.Dir = start.Ang:Forward()
        end

        if tbl.spread then
            bullet.Spread = Vector(tbl.spread, tbl.spread, 0)
        end

        bullet.Num = tbl.num
        bullet.Damage = tbl.damage
        bullet.Force = tbl.force
        bullet.Tracer = tbl.tracer and not aim.fixTracers and 1 or 0

        if aim.fixTracers then
            bullet.Callback = function(_ply, tr, dmg)
                local ed = EffectData()
                ed:SetStart(tr.StartPos)
                ed:SetOrigin(tr.HitPos)
                ed:SetScale(5000)
                util.Effect(tbl.tracer, ed)
            end
        else
            bullet.TracerName = tbl.tracer
        end

        --[[bullet.Callback=function(ply,tr,dmg)
			if tr.HitPos then
				debugoverlay.Sphere(tr.HitPos,50,5, Color(0,255,0), true)
			end
		end]]
        aimEnt:FireBullets(bullet)

        --Animation
        if tbl.anim then
            ent:PillAnim(tbl.anim, true)
        end

        --Sound
        ent:PillSound("shoot", true)
    end

    function common.melee(ply, ent, tbl)
        if not ply:IsOnGround() then return end

        if tbl.animCount then
            ent:PillAnim("melee" .. math.random(tbl.animCount), true)
        else
            ent:PillAnim("melee", true)
        end

        ent:PillGesture("melee")
        ent:PillSound("melee")

        timer.Simple(tbl.delay, function()
            if not IsValid(ent) then return end

            if ply:TraceHullAttack(ply:EyePos(), ply:EyePos() + ply:EyeAngles():Forward() * tbl.range, Vector(-10, -10, -10), Vector(10, 10, 10), tbl.dmg, DMG_SLASH, 1, true) then
                ent:PillSound("melee_hit")
            else
                ent:PillSound("melee_miss")
            end
        end)
    end
end
