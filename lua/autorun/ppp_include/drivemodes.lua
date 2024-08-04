--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

pk_pills.registerDrive("roll", {
    think = function(ply, ent, options)
        local aimYaw = Angle(0, ply:EyeAngles().y, 0)
        local moveDir = Vector(0, 0, 0)

        if (ply:KeyDown(IN_FORWARD)) then
            moveDir = moveDir + aimYaw:Forward()
        end

        if (ply:KeyDown(IN_BACK)) then
            moveDir = moveDir - aimYaw:Forward()
        end

        if (ply:KeyDown(IN_MOVERIGHT)) then
            moveDir = moveDir + aimYaw:Right()
        end

        if (ply:KeyDown(IN_MOVELEFT)) then
            moveDir = moveDir - aimYaw:Right()
        end

        local phys = ent:GetPhysicsObject()
        if not IsValid(phys) then return end
        local center = ent:LocalToWorld(phys:GetMassCenter())
        moveDir:Normalize()

        if options.rotcap then
            local av = phys:GetAngleVelocity()
            local abs = math.abs(av.x) + math.abs(av.y) + math.abs(av.z)
            if abs > options.rotcap then return end
        end

        phys:ApplyForceOffset(moveDir * options.power, center + Vector(0, 0, 1))
        phys:ApplyForceOffset(moveDir * -options.power, center + Vector(0, 0, -1))
    end,
    key = function(ply, ent, options, key)
        if key == IN_JUMP and options.jump then
            local shouldJump = false

            if (ent:GetMoveType() == MOVETYPE_NONE) then
                ent:SetMoveType(MOVETYPE_VPHYSICS)
                ent:SetPos(ent:GetPos() + Vector(0, 0, ent:BoundingRadius() + options.burrow))
                shouldJump = true
            else
                local trace = util.QuickTrace(ent:GetPos(), Vector(0, 0, -ent:BoundingRadius() + 2), ent)

                if trace.Hit then
                    shouldJump = true
                end
            end

            if shouldJump then
                ent:GetPhysicsObject():ApplyForceCenter(Vector(0, 0, options.jump))
                ent:PillSound("jump")
            end
        elseif key == IN_DUCK and options.burrow and ent:GetMoveType() == MOVETYPE_VPHYSICS then
            local trace = util.QuickTrace(ent:GetPos(), Vector(0, 0, -ent:BoundingRadius() + 2), ent)

            if trace.Hit and (trace.MatType == MAT_DIRT or trace.MatType == MAT_SAND) then
                ent:PillSound("burrow")
                local p = ent:GetPos()
                ent:SetPos(Vector(p.x, p.y, trace.HitPos.z - options.burrow))
                ent:SetMoveType(MOVETYPE_NONE)

                if ent.formTable.model then
                    ent:SetModel(ent.formTable.model)
                end

                ent:PillLoopStopAll()
            end
        end
    end
})

pk_pills.registerDrive("fly", {
    think = function(ply, ent, options)
        local phys = ent:GetPhysicsObject()
        if not IsValid(phys) then return end

        if phys:IsGravityEnabled() then
            phys:EnableGravity(false)
        end

        --Lateral Movement
        local move = Vector(0, 0, 0)
        local rotatedAngle = ent:GetAngles()
        local aim = Angle(0, ply:EyeAngles().y, 0)

        if options.spin then
            rotatedAngle = aim
        end

        if options.rotation then
            rotatedAngle:RotateAroundAxis(rotatedAngle:Up(), options.rotation)
        end

        if options.rotation2 then
            rotatedAngle:RotateAroundAxis(rotatedAngle:Right(), options.rotation2)
        end

        if options.rocketMode then
            move = rotatedAngle:Forward() * options.speed
            aim.p = math.Clamp(ply:EyeAngles().p, -50, 50)
        else
            if not options.tilt then
                if (ply:KeyDown(IN_FORWARD)) then
                    move = rotatedAngle:Forward() * options.speed
                elseif (ply:KeyDown(IN_BACK)) then
                    move = move + rotatedAngle:Forward() * -options.speed
                end

                if (ply:KeyDown(IN_MOVERIGHT)) then
                    move = move + rotatedAngle:Right() * options.speed
                elseif (ply:KeyDown(IN_MOVELEFT)) then
                    move = move + rotatedAngle:Right() * -options.speed
                end

                aim.p = math.Clamp(ply:EyeAngles().p, -30, 30)
            else
                local baseDir = aim

                if (ply:KeyDown(IN_FORWARD)) then
                    move = baseDir:Forward() * options.speed
                    aim.p = options.tilt or 0
                elseif (ply:KeyDown(IN_BACK)) then
                    move = move + baseDir:Forward() * -options.speed
                    aim.p = -options.tilt or 0
                end

                if (ply:KeyDown(IN_MOVERIGHT)) then
                    move = move + baseDir:Right() * options.speed
                    aim.r = options.tilt or 0
                elseif (ply:KeyDown(IN_MOVELEFT)) then
                    move = move + baseDir:Right() * -options.speed
                    aim.r = -options.tilt or 0
                end
            end

            --UpDown
            if (ply:KeyDown(IN_JUMP)) then
                move = move + Vector(0, 0, options.speed * 2 / 3)
            elseif (ply:KeyDown(IN_DUCK)) then
                move = move + Vector(0, 0, -options.speed * 2 / 3)
            end
        end

        phys:AddVelocity(move - phys:GetVelocity() * .02)

        if options.rotation then
            aim:RotateAroundAxis(aim:Up(), -options.rotation)
        end

        if options.rotation2 then
            aim:RotateAroundAxis(aim:Right(), -options.rotation2)
        end

        --[[if options.spin then
			aim=ent.spinAng or Angle(0,0,0)
			aim=aim+Angle(0,-options.spin,0)
			ent.spinAng=aim
		end]]
        local localAim = ent:WorldToLocalAngles(aim)

        if options.spin then
            localAim = Angle(0, -options.spin, 0)
        end

        local moveAng = Vector(0, 0, 0)
        moveAng.y = localAim.p * 3
        moveAng.z = localAim.y * 3
        moveAng.x = localAim.r * 3
        phys:AddAngleVelocity(-1 * phys:GetAngleVelocity() + moveAng)
    end,
    --return LocalAim
    key = function(ply, ent, options, key) end
})

pk_pills.registerDrive("hover", {
    think = function(ply, ent, options)
        --UpDown
        if not ply:KeyDown(IN_DUCK) then
            local phys = ent:GetPhysicsObject()
            if not IsValid(phys) then return end
            --Lateral movement
            local move = Vector(0, 0, 0)
            local rotatedAngle = ent:GetAngles()

            if (ply:KeyDown(IN_FORWARD)) then
                move = rotatedAngle:Forward() * options.speed
            elseif (ply:KeyDown(IN_BACK)) then
                move = move + rotatedAngle:Forward() * -options.speed
            end

            if (ply:KeyDown(IN_MOVERIGHT)) then
                move = move + rotatedAngle:Right() * options.speed
            elseif (ply:KeyDown(IN_MOVELEFT)) then
                move = move + rotatedAngle:Right() * -options.speed
            end

            phys:AddVelocity(move - phys:GetVelocity() * .02)
            --Hovering
            local tr = util.QuickTrace(ent:GetPos(), Vector(0, 0, -1) * (options.height or 100), ent)

            if tr.Hit then
                phys:AddVelocity(Vector(0, 0, 10))
            end

            local aim = Angle(0, ply:EyeAngles().y, 0)
            local localAim = ent:WorldToLocalAngles(aim)
            local moveAng = Vector(0, 0, 0)
            moveAng.y = localAim.p * 3
            moveAng.z = localAim.y * 3
            moveAng.x = localAim.r * 3
            phys:AddAngleVelocity(-1 * phys:GetAngleVelocity() + moveAng)
        end
    end,
    key = function(ply, ent, options, key) end
})

pk_pills.registerDrive("swim", {
    think = function(ply, ent, options)
        local phys = ent:GetPhysicsObject()

        if not ent.setupBuoyancy then
            phys:SetBuoyancyRatio(.135)
            ent.setupBuoyancy = true
        end

        local speed

        if ent:WaterLevel() > 1 then
            speed = options.speed
        else
            speed = options.speed / 3

            if math.Rand(0, 1) > .9 then
                ent:TakeDamage(1)
            end
        end

        --Lateral Movement
        local move = Vector(0, 0, 0)
        local rotatedAngle = ent:GetAngles()
        local aim = Angle(0, ply:EyeAngles().y, 0)

        if (ply:KeyDown(IN_FORWARD)) then
            move = rotatedAngle:Forward()
        elseif (ply:KeyDown(IN_BACK)) then
            move = move - rotatedAngle:Forward()
        end

        if (ply:KeyDown(IN_MOVERIGHT)) then
            move = move + rotatedAngle:Right()
        elseif (ply:KeyDown(IN_MOVELEFT)) then
            move = move - rotatedAngle:Right()
        end

        aim.p = math.Clamp(ply:EyeAngles().p, -80, 80)
        phys:AddVelocity(move * speed)
        local localAim = ent:WorldToLocalAngles(aim)
        local moveAng = Vector(0, 0, 0)
        moveAng.y = localAim.p * 3
        moveAng.z = localAim.y * 3
        moveAng.x = localAim.r * 3
        phys:AddAngleVelocity(-1 * phys:GetAngleVelocity() + moveAng)
    end,
    --return LocalAim
    key = function(ply, ent, options, key) end
})

pk_pills.registerDrive("strider", {
    think = function(ply, ent, options)
        local h = ent:GetPoseParameter("body_height")

        if h < 200 then
            h = 200
            ent:SetPoseParameter("body_height", h)
        end

        --UpDown
        if ply:KeyDown(IN_JUMP) and h < 500 then
            h = h + 5
            ent:SetPoseParameter("body_height", h)
        elseif ply:KeyDown(IN_DUCK) and h > 200 then
            h = h - 5
            ent:SetPoseParameter("body_height", h)
        end

        local run = ply:KeyDown(IN_SPEED)
        local phys = ent:GetPhysicsObject()
        local aim = Angle(0, ply:EyeAngles().y, 0)
        local move = Vector(0, 0, 0)

        if (ply:KeyDown(IN_FORWARD)) then
            move = aim:Forward()
        elseif (ply:KeyDown(IN_BACK)) then
            move = move - aim:Forward()
        end

        if (ply:KeyDown(IN_MOVERIGHT)) then
            move = move + aim:Right()
        elseif (ply:KeyDown(IN_MOVELEFT)) then
            move = move - aim:Right()
        end

        move:Normalize()

        if (move:Length() > 0) then
            ent:PillAnim("walk_all")

            if run then
                ent:SetPlaybackRate(2)
            else
                ent:SetPlaybackRate(1)
            end

            ent:SetPoseParameter("move_yaw", ent:WorldToLocalAngles(move:Angle()).y)

            --Stepping
            --Step Sounds
            if not ent.lastStep then
                ent.lastStep = 0
            end

            if ent.lastStep == 0 and ent:GetCycle() > 1 / 3 then
                ent.lastStep = 1
                ent:PillSound("step")
            elseif ent.lastStep == 1 and ent:GetCycle() > 2 / 3 then
                ent.lastStep = 2
                ent:PillSound("step")
            elseif ent.lastStep == 2 and ent:GetCycle() < 2 / 3 then
                ent.lastStep = 0
                ent:PillSound("step")
            end
        else
            ent:SetPlaybackRate(1)
            ent:PillAnim("Idle01")
        end

        --Datass
        local tr = util.QuickTrace(ent:GetPos(), Vector(0, 0, -1) * h, ent)

        if tr.Hit then
            phys:AddVelocity(-ent:GetVelocity() + Vector(0, 0, 2000 * (1 - tr.Fraction)) + move * (run and 200 or 100))
        end

        local localAim = ent:WorldToLocalAngles(aim)
        local moveAng = Vector(0, 0, 0)
        moveAng.y = localAim.p * 3
        moveAng.z = localAim.y * 3
        moveAng.x = localAim.r * 3
        phys:AddAngleVelocity(-1 * phys:GetAngleVelocity() + moveAng)
    end,
    key = function(ply, ent, options, key) end
})
