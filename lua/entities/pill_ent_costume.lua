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
ENT.Type = "anim"
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "PillForm")
    self:NetworkVar("Entity", 0, "PillUser")
    self:NetworkVar("Entity", 1, "Puppet")
    self:NetworkVar("Float", 0, "ChargeTime")
    self:NetworkVar("Angle", 0, "ChargeAngs")
    self:NetworkVar("Float", 1, "CloakLeft")
end

function ENT:Initialize()
    self.formTable = pk_pills.getPillTable(self:GetPillForm())
    local ply = self:GetPillUser()

    if not self.formTable or not IsValid(ply) then
        if SERVER then self:Remove() end

        return
    end

    local hull = self.formTable.hull or Vector(32, 32, 72)
    local duckBy = self.formTable.duckBy or (self.formTable.hull and 0 or 36)
    ply:SetHull(-Vector(hull.x / 2, hull.y / 2, 0), Vector(hull.x / 2, hull.y / 2, hull.z))
    ply:SetHullDuck(-Vector(hull.x / 2, hull.y / 2, 0), Vector(hull.x / 2, hull.y / 2, hull.z - duckBy or 0))
    ply:SetRenderMode(RENDERMODE_NONE)
    --Do this so weapon equips are not blocked
    pk_pills.mapEnt(ply, nil)

    if SERVER then
        self:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
        self:SetPos(ply:GetPos())
        self:SetParent(ply)
        self:DrawShadow(false)
        ply:StripWeapons()
        ply:RemoveAllAmmo()

        if self.formTable.flies then
            ply:SetMoveType(MOVETYPE_FLY)
        else
            ply:SetMoveType(MOVETYPE_WALK)
        end

        if ply:FlashlightIsOn() then
            ply:Flashlight(false)
        end

        ply:Freeze(false)
        ply:SetNotSolid(false)
        ply:DrawViewModel(false)
        --ply:DrawWorldModel(false)
        local camOffset = self.formTable.camera and self.formTable.camera.offset or Vector(0, 0, 64)
        --clside this?
        ply:SetStepSize(hull.z / 4)
        ply:SetViewOffset(camOffset)
        ply:SetViewOffsetDucked(camOffset - Vector(0, 0, duckBy))
        local speed = self.formTable.moveSpeed or {}
        ply:SetWalkSpeed(speed.walk or 200)
        ply:SetRunSpeed(speed.run or speed.walk or 500)

        if speed.ducked then
            ply:SetCrouchedWalkSpeed(speed.ducked / (speed.walk or 200))
        elseif duckBy == 0 then
            ply:SetCrouchedWalkSpeed(1)
        else
            ply:SetCrouchedWalkSpeed(.3)
        end

        ply:SetJumpPower(self.formTable.jumpPower or 200)
        self.loopingSounds = {}

        if self.formTable.sounds then
            for k, v in pairs(self.formTable.sounds) do
                if string.sub(k, 1, 5) == "loop_" then
                    self.loopingSounds[string.sub(k, 6)] = CreateSound(self, v)
                elseif string.sub(k, 1, 5) == "auto_" and isstring(v) then
                    local func

                    func = function()
                        if IsValid(self) then
                            local f = self.formTable.sounds[k .. "_func"]
                            if not f then return end
                            local play, time = f(self:GetPillUser(), self)

                            if play then
                                self:PillSound(k)
                            end

                            timer.Simple(time, func)
                        end
                    end

                    func()
                end
            end

            if self.loopingSounds.move then
                self:PillLoopSound("move")
            end
        end

        if self.formTable.health then
            self:GetPillUser():SetHealth(self.formTable.health)
            self:GetPillUser():SetMaxHealth(self.formTable.health)
        else
            self:GetPillUser():GodEnable()
        end

        ply:SetArmor(0)

        if self.formTable.loadout then
            for _, v in pairs(self.formTable.loadout) do
                ply:Give(v)
            end
        end

        if self.formTable.ammo then
            for k, v in pairs(self.formTable.ammo) do
                ply:SetAmmo(v, k)
            end
        end

        --[[if self.formTable.seqInit then
			self:PillAnim(self.formTable.seqInit,true)
		end]]
        --[[if self.formTable.bodyGroups then
			for _,v in pairs(self.formTable.bodyGroups) do
				self:SetBodygroup(v,1)
			end
		end]]
        --self:SetPlaybackRate(1)
        pk_pills.setAiTeam(ply, self.formTable.side or "default")
        local model = self.formTable.model
        local skin = self.formTable.skin
        local attachments = self.formTable.attachments

        if self.formTable.options then
            local options = self.formTable.options()

            if self.option and options[self.option] then
                local pickedOption = options[self.option]

                if pickedOption.model then
                    model = pickedOption.model
                end

                if pickedOption.skin then
                    skin = pickedOption.skin
                end

                if pickedOption.attachments then
                    attachments = pickedOption.attachments
                end
            else
                local pickedOption = table.Random(options)

                if not model then
                    model = pickedOption.model
                end

                if not skin then
                    skin = pickedOption.skin
                end

                if not attachments then
                    attachments = pickedOption.attachments
                end
            end
        end

        local puppet = ents.Create("pill_puppet")
        puppet:SetModel(model or "models/Humans/corpse1.mdl")

        if skin then
            puppet:SetSkin(skin)
        end

        if attachments then
            for _, mdl in pairs(attachments) do
                local a = ents.Create("pill_attachment")
                a:SetParent(puppet)
                a:SetModel(mdl)
                a:Spawn()
            end
        end

        if self.formTable.visColor then
            puppet:SetColor(self.formTable.visColor)
        elseif self.formTable.visColorRandom then
            puppet:SetColor(HSVToColor(math.Rand(0, 360), 1, 1))
        end

        if self.formTable.visMat then
            puppet:SetMaterial(self.formTable.visMat)
        end

        if self.formTable.bodyGroups then
            for _, v in pairs(self.formTable.bodyGroups) do
                if v then
                    puppet:SetBodygroup(v, 1)
                end
            end
        end

        if self.formTable.modelScale then
            puppet:SetModelScale(self.formTable.modelScale, .1)
        end

        if self.formTable.boneMorphs then
            for k, v in pairs(self.formTable.boneMorphs) do
                local b = puppet:LookupBone(k)

                if b then
                    if v.pos then
                        puppet:ManipulateBonePosition(b, v.pos)
                    end

                    if v.rot then
                        puppet:ManipulateBoneAngles(b, v.rot)
                    end

                    if v.scale then
                        puppet:ManipulateBoneScale(b, v.scale)
                    end
                end
            end
        end

        if self.formTable.cloak then
            self:SetCloakLeft(self.formTable.cloak.max)
        end

        --puppet:SetParent(self)
        puppet:Spawn()
        self:DeleteOnRemove(puppet)
        self:SetPuppet(puppet)
    end

    pk_pills.mapEnt(ply, self)
    --self:SetPlaybackRate(1)
end

function ENT:OnRemove()
    local ply = self:GetPillUser()

    if SERVER then
        self:PillLoopStopAll()
    end

    local newType = pk_pills.unmapEnt(self:GetPillUser(), self)

    if newType ~= "ply" and IsValid(ply) then
        ply:ResetHull()

        if SERVER then
            ply:SetViewOffset(Vector(0, 0, 64))
            ply:SetViewOffsetDucked(Vector(0, 0, 28))
            ply:SetStepSize(18)
            -- Not sure if this chunk is needed... leaving it for now.
            ply:Freeze(false)

            if ply:Alive() then
                ply:SetMoveType(MOVETYPE_WALK)
            end

            ply:SetNotSolid(false)

            if ply:Alive() then
                -- Just respawn the player to reset most stuff.
                local angs = ply:EyeAngles()
                local pos = ply:GetPos()
                local vel = ply:GetVelocity()
                local hp = ply:Health()
                ply:StripWeapons()
                ply:StripAmmo()
                ply:Spawn()
                ply:SetEyeAngles(angs)
                ply:SetPos(pos)
                ply:SetVelocity(vel)
                ply:SetHealth(hp)
            end

            if not newType then
                ply:SetRenderMode(RENDERMODE_NORMAL)
                pk_pills.setAiTeam(ply, "default")
            end
        elseif not newType then
            if ply == LocalPlayer() then
                if ply.pk_pill_gmpEnabled then
                    ply.pk_pill_gmpEnabled = nil
                    --RunConsoleCommand("gmp_enabled","1")
                end
                --ply.ShouldDisableLegs=nil
            end
        end
    end
end

function ENT:Think()
    local ply = self:GetPillUser()
    local puppet = self:GetPuppet()
    if not IsValid(puppet) or not IsValid(ply) then return end
    local vel = ply:GetVelocity():Length()

    if SERVER then
        --Anims
        local anims = table.Copy(self.formTable.anims.default or {})
        table.Merge(anims, (IsValid(ply:GetActiveWeapon()) and self.formTable.anims[ply:GetActiveWeapon():GetHoldType()]) or (self.forceAnimSet and self.formTable.anims[self.forceAnimSet]) or {})
        local anim
        --local useSeqVel=true
        local overrideRate

        if (not self.anim or not anims[self.anim]) then
            self.animFreeze = nil
            self.animStart = nil
        end

        if self.animFreeze and not self.plyFrozen then
            ply:SetWalkSpeed(ply:GetWalkSpeed() / 2)
            ply:SetRunSpeed(ply:GetWalkSpeed() / 2)
            self.plyFrozen = true
        elseif not self.animFreeze and self.plyFrozen then
            local speed = self.formTable.moveSpeed or {}
            ply:SetWalkSpeed(speed.walk or 200)
            ply:SetRunSpeed(speed.run or speed.walk or 500)
            self.plyFrozen = nil
        end

        if self.anim and anims[self.anim] then
            anim = anims[self.anim]
            overrideRate = anims[self.anim .. "_rate"] or 1
            local cycle = puppet:GetCycle()

            if not self.animStart then
                if cycle == 1 or (self.animCycle and self.animCycle > cycle) or (string.lower(anim) ~= string.lower(puppet:GetSequenceName(puppet:GetSequence()))) then
                    self.anim = nil
                    self.animCycle = nil

                    if self.animFreeze then
                        self.animFreeze = nil
                    end
                elseif self.animCycle then
                    self.animCycle = cycle
                end
            end
        elseif self.tickAnim and anims[self.tickAnim] then
            anim = anims[self.tickAnim]
            overrideRate = anims[self.tickAnim .. "_rate"] or 1
            self.tickAnim = nil
        elseif self.burrowed then
            anim = anims["burrow_loop"]
        elseif ply:WaterLevel() > 2 then
            anim = anims["swim"] or anims["glide"] or anims["idle"]
        elseif ply:IsOnGround() then
            if ply:Crouching() then
                if vel > ply:GetCrouchedWalkSpeed() / 4 then
                    anim = anims["crouch_walk"] or anims["crouch"] or anims["walk"] or anims["idle"]
                else
                    anim = anims["crouch"] or anims["idle"]
                end
            else
                if vel > (ply:GetWalkSpeed() + ply:GetRunSpeed()) / 2 then
                    anim = anims["run"] or anims["walk"] or anims["idle"]
                elseif vel > ply:GetWalkSpeed() / 4 then
                    anim = anims["walk"] or anims["idle"]
                else
                    anim = anims["idle"]
                end
            end
        else
            anim = anims["glide"] or anims["idle"]
        end

        if anim == anims["idle"] or anim == anims["crouch"] then
            overrideRate = 1
        end

        if (anim and puppet:GetSequence() ~= puppet:LookupSequence(anim)) or self.animStart or (self.formTable.autoRestartAnims and puppet:GetCycle() == 1) then
            puppet:ResetSequence(puppet:LookupSequence(anim))
            puppet:SetCycle(0)
            self.animCycle = 0
        end

        self.animStart = nil
        local seq_vel = puppet:GetSequenceGroundSpeed(puppet:GetSequence())

        --if true then
        if self.formTable.movePoseMode ~= "xy" and self.formTable.movePoseMode ~= "xy-bot" and not overrideRate then
            local rate = overrideRate or vel / seq_vel

            --goofy limitation (floods console with errors if above 12!)
            if rate > 12 then
                rate = 12
            end

            puppet:SetPlaybackRate(rate)
        else
            --puppet:SetPlaybackRate(1)
        end

        --print(puppet:GetCycle())
        if self.formTable.movePoseMode then
            --
            if self.formTable.movePoseMode == "yaw" then
                local move_dir = puppet:WorldToLocalAngles(ply:GetVelocity():Angle())
                puppet:SetPoseParameter("move_yaw", move_dir.y)
            elseif self.formTable.movePoseMode == "xy" then
                if not overrideRate then
                    local localvel = ply:WorldToLocal(ply:GetPos() + ply:GetVelocity())
                    local maxdim = math.Max(math.abs(localvel.x), math.abs(localvel.y))
                    local clampedvel = maxdim == 0 and Vector(0, 0, 0) or localvel / maxdim
                    puppet:SetPoseParameter("move_x", clampedvel.x)
                    puppet:SetPoseParameter("move_y", -clampedvel.y)
                    seq_vel = puppet:GetSequenceGroundSpeed(puppet:GetSequence())

                    if seq_vel ~= 0 then
                        puppet:SetPoseParameter("move_x", math.Clamp(localvel.x / seq_vel, -.99, .99))
                        puppet:SetPoseParameter("move_y", math.Clamp(-localvel.y / seq_vel, -.99, .99))
                    end
                    --print(puppet:GetPlaybackRate())
                else
                    puppet:SetPoseParameter("move_x", 0)
                    puppet:SetPoseParameter("move_y", 0)
                end
            elseif self.formTable.movePoseMode == "xy-bot" then
                if not overrideRate then
                    local localvel = ply:WorldToLocal(ply:GetPos() + ply:GetVelocity())
                    local maxdim = math.Max(math.abs(localvel.x), math.abs(localvel.y))
                    local clampedvel = maxdim == 0 and Vector(0, 0, 0) or localvel / maxdim
                    local move_dir = puppet:WorldToLocalAngles(ply:GetVelocity():Angle())
                    puppet:SetPoseParameter("move_x", clampedvel.x)
                    puppet:SetPoseParameter("move_y", -clampedvel.y)
                    puppet:SetPoseParameter("move_yaw", move_dir.y)
                    puppet:SetPoseParameter("move_scale", 1)
                    seq_vel = puppet:GetSequenceGroundSpeed(puppet:GetSequence())

                    if seq_vel ~= 0 then
                        puppet:SetPoseParameter("move_x", math.Clamp(localvel.x / seq_vel, -.99, .99))
                        puppet:SetPoseParameter("move_y", math.Clamp(-localvel.y / seq_vel, -.99, .99))
                        puppet:SetPoseParameter("move_scale", math.Clamp(localvel:Length() / seq_vel, -.99, .99))
                    end
                    --print(puppet:GetPlaybackRate())
                else
                    puppet:SetPoseParameter("move_x", 0)
                    puppet:SetPoseParameter("move_y", 0)
                    puppet:SetPoseParameter("move_yaw", 0)
                    puppet:SetPoseParameter("move_scale", 0)
                end
            end
        end

        --Aimage
        if self.formTable.aim then
            if self.formTable.aim.xPose then
                local yaw = math.AngleDifference(ply:EyeAngles().y, puppet:GetAngles().y)

                if self.formTable.aim.xInvert then
                    yaw = -yaw
                end

                puppet:SetPoseParameter(self.formTable.aim.xPose, yaw)
            end

            if self.formTable.aim.yPose then
                local pitch = math.AngleDifference(ply:EyeAngles().p, puppet:GetAngles().p)

                if self.formTable.aim.yInvert then
                    pitch = -pitch
                end

                puppet:SetPoseParameter(self.formTable.aim.yPose, pitch)
            end
        end

        --gliding and landing
        if not ply:IsOnGround() and ply:WaterLevel() == 0 and self.formTable.glideThink then
            self.formTable.glideThink(ply, self)
        end

        if not ply:IsOnGround() and not self.touchingWater and ply:WaterLevel() > 0 and self.formTable.land then
            self.formTable.land(ply, self)
        end

        --water death
        self.touchingWater = ply:WaterLevel() > 1

        if (self.formTable.damageFromWater and self.touchingWater) then
            if self.formTable.damageFromWater == -1 then
                --self:PillDie()
                ply:Kill()
            else
                ply:TakeDamage(self.formTable.damageFromWater)
                --TODO APPLY DAMAGE
            end
        end

        --tick attack
        if ply:KeyDown(IN_ATTACK) and self.formTable.attack and self.formTable.attack.mode == "tick" then
            self.formTable.attack.func(ply, self, self.formTable.attack)
        end

        if ply:KeyDown(IN_ATTACK2) and self.formTable.attack2 and self.formTable.attack2.mode == "tick" then
            self.formTable.attack2.func(ply, self, self.formTable.attack2)
        end

        --auto attack
        if ply:KeyDown(IN_ATTACK) and self.formTable.attack and self.formTable.attack.mode == "auto" then
            if not self.formTable.aim then
                self:PillLoopSound("attack")
            else
                self:PillLoopStop("attack")
            end

            if (not self.lastAttack or (self.formTable.attack.interval or self.formTable.attack.delay) < CurTime() - self.lastAttack) then
                self.formTable.attack.func(ply, self, self.formTable.attack)
                self.lastAttack = CurTime()
            end
        else
            self:PillLoopStop("attack")
        end

        if ply:KeyDown(IN_ATTACK2) and self.formTable.attack2 and self.formTable.attack2.mode == "auto" then
            if not self.formTable.aim then
                self:PillLoopSound("attack2")
            else
                self:PillLoopStop("attack2")
            end

            if not self.lastAttack2 or (self.formTable.attack2.interval or self.formTable.attack2.delay) < CurTime() - self.lastAttack2 then
                self.formTable.attack2.func(ply, self, self.formTable.attack2)
                self.lastAttack2 = CurTime()
            end
        else
            self:PillLoopStop("attack2")
        end

        --charge
        if self:GetChargeTime() ~= 0 then
            if ply:OnGround() then
                local charge = self.formTable.charge
                local angs = ply:EyeAngles()
                self:PillAnimTick("charge_loop")
                local hit_ent = ply:TraceHullAttack(ply:EyePos(), ply:EyePos() + angs:Forward() * 100, Vector(-20, -20, -20), Vector(20, 20, 20), charge.dmg, DMG_CRUSH, 1, true)

                if IsValid(hit_ent) then
                    self:PillAnim("charge_hit", true)
                    self:PillGesture("charge_hit")
                    self:PillSound("charge_hit")
                    self:SetChargeTime(0)
                    self:PillLoopStop("charge")
                end
            else
                self:SetChargeTime(0)
                self:PillLoopStop("charge")
            end
        end

        --Cloak
        if self.formTable.cloak then
            local cloak = self.formTable.cloak

            if self.iscloaked then
                local cloakamt = self:GetCloakLeft()

                if cloakamt ~= -1 then
                    cloakamt = cloakamt - FrameTime()

                    if cloakamt < 0 then
                        cloakamt = 0
                        self:ToggleCloak()
                    end

                    self:SetCloakLeft(cloakamt)
                end
            else
                local cloakamt = self:GetCloakLeft()

                if cloakmt ~= -1 and cloakamt < cloak.max then
                    cloakamt = cloakamt + FrameTime() * cloak.rechargeRate

                    if cloakamt > cloak.max then
                        cloakamt = cloak.max
                    end

                    self:SetCloakLeft(cloakamt)
                end
            end

            local color = self:GetPuppet():GetColor()

            if self.iscloaked then
                if color.a > 0 then
                    color.a = color.a - 5
                    self:GetPuppet():SetColor(color)
                end
            else
                if color.a < 255 then
                    color.a = color.a + 5
                    self:GetPuppet():SetColor(color)
                end
            end

            --PrintTable(color)
            if IsValid(self.wepmdl) and self.wepmdl:GetColor().a ~= color.a then
                self.wepmdl:SetColor(color)
            end
        end

        --if !IsValid(ply) then self:NextThink(CurTime()) return true end
        --wepon-no longer SO hackey
        if not self.formTable.hideWeapons then
            local realWep = self:GetPillUser():GetActiveWeapon()

            --&&self:GetPillUser()!=ply or pk_pills.var_thirdperson:GetBool()) then
            if IsValid(realWep) and realWep:GetModel() ~= "" then
                --hiding the real thing [BROKEN]
                --[[if realWep:GetRenderMode()!=RENDERMODE_NONE then
					realWep:SetRenderMode(RENDERMODE_NONE)
				end]]
                if realWep.pill_attachment then
                    if IsValid(self.wepmdl) then
                        self.wepmdl:Remove()
                    end

                    self.wepmdl = ents.Create("pill_attachment_wep")
                    self.wepmdl:SetParent(self:GetPuppet())
                    self.wepmdl:SetModel(realWep:GetModel())
                    self.wepmdl.attachment = realWep.pill_attachment
                    self.wepmdl:Spawn()

                    if realWep.pill_offset then
                        self.wepmdl:SetWepOffset(realWep.pill_offset)
                    end

                    if realWep.pill_angle then
                        self.wepmdl:SetWepAng(realWep.pill_angle)
                    end

                    realWep.pill_proxy = self.wepmdl
                elseif not IsValid(self.wepmdl) then
                    self.wepmdl = ents.Create("pill_attachment_wep")
                    self.wepmdl:SetParent(self:GetPuppet())
                    self.wepmdl:SetModel(realWep:GetModel())
                    self.wepmdl:Spawn()
                    realWep.pill_proxy = self.wepmdl
                elseif self.wepmdl:GetModel() ~= realWep:GetModel() then
                    self.wepmdl:SetModel(realWep:GetModel())
                end
            elseif IsValid(self.wepmdl) then
                self.wepmdl:Remove()
            end
        end
    else
        if self:GetPillUser() ~= LocalPlayer() or pk_pills.convars.cl_thirdperson:GetBool() then
            puppet:SetNoDraw(false)
        else
            puppet:SetNoDraw(true)
        end

        local realWep = self:GetPillUser():GetActiveWeapon()

        if IsValid(realWep) and realWep:GetModel() ~= "" and not realWep:GetNoDraw() then
            realWep:SetNoDraw(true)
        end
    end

    --Align pos and angles with player
    if SERVER then
        puppet:SetPos(ply:GetPos())
    else
        puppet:SetRenderOrigin(ply:GetPos())
    end

    if vel > 0 or math.abs(math.AngleDifference(puppet:GetAngles().y, ply:EyeAngles().y)) > 60 then
        local angs = ply:EyeAngles()
        angs.p = 0

        if SERVER then
            puppet:SetAngles(angs)
        else
            --puppet:SetAngles(angs)
            puppet:SetRenderAngles(angs)
        end
    end

    self:NextThink(CurTime())

    return true
end

if SERVER then
    function ENT:DoKeyPress(ply, key)
        if self.animFreeze then return end

        if self:GetChargeTime() ~= 0 then
            self:SetChargeTime(0)
            self:PillLoopStop("charge")

            return
        end

        if key == IN_ATTACK and self.formTable.attack and self.formTable.attack.mode == "trigger" then
            self.formTable.attack.func(ply, self, self.formTable.attack)
        end

        if key == IN_ATTACK2 and self.formTable.attack2 and self.formTable.attack2.mode == "trigger" then
            self.formTable.attack2.func(ply, self, self.formTable.attack2)
        end

        if key == IN_RELOAD and self.formTable.reload then
            self.formTable.reload(ply, self)
        end

        if key == IN_DUCK then
            if self.formTable.canBurrow then
                if not self.burrowed then
                    local trace = util.QuickTrace(ply:GetPos(), Vector(0, 0, -1), ply)

                    if trace.Hit and (trace.MatType == MAT_DIRT or trace.MatType == MAT_SAND or trace.MatType == MAT_GRASS) then
                        self:PillAnim("burrow_in")
                        self:PillSound("burrow_in")
                        ply:SetLocalVelocity(Vector(0, 0, 0))
                        ply:SetMoveType(MOVETYPE_NONE)
                        ply:SetNotSolid(true)
                        self.burrowed = true
                        self:GetPuppet():DrawShadow(false)
                        --local p=ply:GetPos()
                        --ent:SetPos(Vector(p.x,p.y,trace.HitPos.z-options.burrow))
                        --ent:SetMoveType(MOVETYPE_NONE)
                        --if ent.formTable.model then ent:SetModel(ent.formTable.model) end
                        --ent:PillSound("burrow")
                        --ent:PillLoopStopAll()
                    end
                else
                    self:PillAnim("burrow_out")
                    self:PillSound("burrow_out")
                    ply:SetMoveType(MOVETYPE_WALK)
                    ply:SetNotSolid(false)
                    self.burrowed = nil
                    self:GetPuppet():DrawShadow(true)
                end
            end
        end
    end

    function ENT:DoJump()
        if self.formTable.jump then
            self.formTable.jump(self:GetPillUser(), self)
        end
    end

    function ENT:PillDie()
        local ply = self:GetPillUser()

        if self.formTable.die then
            self.formTable.die(ply, self)
        end

        self:PillSound("die")

        if IsValid(self:GetPuppet()) and not self.formTable.noragdoll then
            local r = ents.Create("prop_ragdoll")
            r:SetModel(self.subModel or self:GetPuppet():GetModel())
            r:SetPos(ply:GetPos())
            r:SetAngles(ply:GetAngles())
            --r:SetOwner(ply)
            r:Spawn()
            r:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
            r:Fire("FadeAndRemove", nil, 10)
        end

        self:Remove()
        pk_pills.handeDeathCommon(self)
    end

    --[[function ENT:PillDie()
		if self.dead then return end
		self:GetPillUser():KillSilent()
		if self.formTable.die then
			self.formTable.die(self:GetPillUser(),self)
		end
		self:PillSound("die")
		self:Remove()
		self.dead=true
	end]]
    function ENT:PillAnim(name, freeze)
        self.anim = name
        self.animStart = true
        self.animFreeze = true
    end

    function ENT:PillAnimTick(name)
        self.tickAnim = name
    end

    function ENT:PillGesture(name)
        local ply = self:GetPillUser()
        local puppet = self:GetPuppet()
        if not IsValid(puppet) then return end
        local anims = table.Copy(self.formTable.anims.default or {})
        table.Merge(anims, IsValid(ply:GetActiveWeapon()) and self.formTable.anims[ply:GetActiveWeapon():GetHoldType()] or {})
        local gesture = anims["g_" .. name]

        if gesture then
            puppet:RestartGesture(puppet:GetSequenceActivity(puppet:LookupSequence(gesture)))
        end
    end

    function ENT:PillChargeAttack()
        if not self:GetPillUser():OnGround() or self.burrowed then return end
        self:PillAnim("charge_start", true)
        self:PillSound("charge_start")

        local function doStart()
            if not IsValid(self) then return end
            self:SetChargeTime(CurTime())
            local angs = self:GetPillUser():EyeAngles()
            angs.p = 0
            self:SetChargeAngs(angs)
            self:PillLoopSound("charge")
        end

        if self.formTable.charge.delay then
            timer.Simple(self.formTable.charge.delay, doStart)
        else
            doStart()
        end
    end

    function ENT:PillFilterCam(ent)
        net.Start("pk_pill_filtercam")
        net.WriteEntity(self)
        net.WriteEntity(ent)
        net.Send(self:GetPillUser())
    end
else
    function ENT:GetPillHealth()
        return self:GetPillUser():Health()
    end
end

--The "bulk" parameter should only be used if you plan to play a ton of sounds in quick succession.
function ENT:PillSound(name, bulk)
    if not self.formTable.sounds then return end
    local s = self.formTable.sounds[name]

    if (istable(s)) then
        s = table.Random(s)
    end

    if isstring(s) then
        if bulk then
            sound.Play(s, self:GetPos(), self.formTable.sounds[name .. "_level"] or (name == "step" and 75 or 100), self.formTable.sounds[name .. "_pitch"] or 100, 1)
        else
            self:EmitSound(s, self.formTable.sounds[name .. "_level"] or (name == "step" and 75 or 100), self.formTable.sounds[name .. "_pitch"] or 100)
        end

        return true
    end
end

function ENT:PillLoopSound(name, volume, pitch)
    if not self.loopingSounds[name] then return end
    local s = self.loopingSounds[name]

    if s:IsPlaying() then
        if volume then
            s:ChangeVolume(volume)
        end

        if pitch then
            s:ChangePitch(pitch, .1)
        end
    else
        if volume or pitch then
            s:PlayEx(volume or 1, pitch or 100)
        else
            s:Play()
        end
    end
end

function ENT:PillLoopStop(name)
    if not self.loopingSounds[name] then return end
    local s = self.loopingSounds[name]
    s:FadeOut(.1)
end

function ENT:PillLoopStopAll()
    if self.loopingSounds then
        for _, v in pairs(self.loopingSounds) do
            v:Stop()
        end
    end
end

function ENT:ToggleCloak()
    local ply = self:GetPillUser()

    if self.iscloaked then
        self.iscloaked = nil
        self:PillSound("uncloak")
        pk_pills.setAiTeam(ply, self.formTable.side or "default")
    else
        local cloakleft = self:GetCloakLeft()

        if cloakleft > 0 or cloakleft == -1 then
            self.iscloaked = true
            self:PillSound("cloak")
            pk_pills.setAiTeam(ply, "harmless")
        end
    end
end

function ENT:Draw()
    --Align pos and angles with player
    --[[local puppet = self:GetPuppet()
	local ply = self:GetPillUser()
	local vel=ply:GetVelocity():Length()

	if IsValid(puppet) then
		puppet:SetRenderOrigin(ply:GetPos())

		if vel>0||math.abs(math.AngleDifference(puppet:GetAngles().y,ply:EyeAngles().y))>60 then
			local angs=ply:EyeAngles()
			angs.p=0

			puppet:SetRenderAngles(angs)
		end
	end

	puppet:DrawModel()]]
end
