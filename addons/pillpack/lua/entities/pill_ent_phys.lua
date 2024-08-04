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
    --self:NetworkVar("Int",0,"PillHealth")
    self:NetworkVar("Entity", 1, "PillAimEnt")
end

function ENT:SetPillHealth(h)
    local ply = self:GetPillUser()

    if IsValid(ply) then
        ply:SetHealth(h)
    end
end

function ENT:GetPillHealth(h)
    local ply = self:GetPillUser()
    if IsValid(ply) then return ply:Health() end
end

function ENT:Initialize()
    pk_pills.mapEnt(self:GetPillUser(), self)
    self.formTable = pk_pills.getPillTable(self:GetPillForm())
    local ply = self:GetPillUser()

    if not self.formTable or not IsValid(ply) then
        self:Remove()

        return
    end

    ply:SetRenderMode(RENDERMODE_NONE)

    if SERVER then
        local model = self.formTable.model
        local skin = self.formTable.skin
        local visMat = self.formTable.visMat

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

                if pickedOption.visMat then
                    visMat = pickedOption.visMat
                end
            else
                local pickedOption = table.Random(options)

                if not model then
                    model = pickedOption.model
                end

                if not skin then
                    skin = pickedOption.skin
                end

                if not visMat then
                    visMat = pickedOption.visMat
                end
            end
        end

        self:SetModel(model or "models/props_junk/watermelon01.mdl")

        if skin then
            self:SetSkin(skin)
        end

        --Physics
        if self.formTable.sphericalPhysics then
            self:PhysicsInitSphere(self.formTable.sphericalPhysics)
            self:GetPhysicsObject():SetMass(250)
        elseif self.formTable.boxPhysics then
            self:PhysicsInitBox(self.formTable.boxPhysics[1], self.formTable.boxPhysics[2])
            self:GetPhysicsObject():SetMass(250)
        else
            self:PhysicsInit(SOLID_VPHYSICS)
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:SetSolid(SOLID_VPHYSICS)
        end

        if self.formTable.spawnFrozen then
            self:GetPhysicsObject():EnableMotion(false)
        end

        ply:DeleteOnRemove(self)
        --ply:PhysicsInit(SOLID_NONE)
        ply:SetMoveType(MOVETYPE_NONE)
        ply:SetSolid(SOLID_NONE)
        ply:GodEnable()
        ply:SetArmor(0)
        ply:StripWeapons()
        ply:RemoveAllAmmo()

        if ply:FlashlightIsOn() then
            ply:Flashlight(false)
        end

        pk_pills.setAiTeam(ply, "harmless")

        if self.formTable.health then
            ply:SetHealth(self.formTable.health)
            ply:SetMaxHealth(self.formTable.health)
        end

        local phys = self:GetPhysicsObject()

        if IsValid(phys) then
            phys:Wake()

            if self.formTable.physMat then
                phys:SetMaterial(self.formTable.physMat)
            end
        end

        self.drive = {
            functions = pk_pills.getDrive(self.formTable.driveType),
            options = self.formTable.driveOptions
        }

        self.loopingSounds = {}

        if self.formTable.sounds then
            for k, v in pairs(self.formTable.sounds) do
                if v == false then continue end

                if string.sub(k, 1, 5) == "loop_" then
                    self.loopingSounds[string.sub(k, 6)] = CreateSound(self, v)
                elseif string.sub(k, 1, 5) == "auto_" and isstring(v) then
                    local func

                    func = function()
                        if IsValid(self) then
                            local f = self.formTable.sounds[k .. "_func"]
                            if not f then return end
                            local play, time = f(ply, self)

                            if play then
                                self:PillSound(k)
                            end

                            timer.Simple(time, func)
                        end
                    end

                    func()
                end
            end

            if self.loopingSounds.move and not self.formTable.moveSoundControl then
                self:PillLoopSound("move")
            end
        end

        --[[if self.formTable.health then
			self:SetPillHealth(self.formTable.health)
		end]]
        if self.formTable.seqInit then
            self:PillAnim(self.formTable.seqInit, true)
        end

        if visMat then
            self:SetMaterial(visMat)
        end

        if self.formTable.subMats then
            for k, v in pairs(self.formTable.subMats) do
                self:SetSubMaterial(k, v)
            end
        end

        if self.formTable.modelScale then
            self:SetModelScale(self.formTable.modelScale, .1)
        end

        if self.formTable.trail then
            local t = self.formTable.trail
            local start = t.width or 40
            local endd = start / 2
            util.SpriteTrail(self, 0, t.color or Color(255, 255, 255), false, start, endd, t.length or 4, 1 / (start + endd) * .5, t.texture)
        end

        if self.formTable.bodyGroups then
            for _, v in pairs(self.formTable.bodyGroups) do
                self:SetBodygroup(v, 1)
            end
        end

        local mins, maxs = self:GetCollisionBounds()
        local points = {Vector(mins.x, 0, 0), Vector(0, mins.y, 0), Vector(0, 0, mins.z), Vector(maxs.x, 0, 0), Vector(0, maxs.y, 0), Vector(0, 0, maxs.z)}
        self:AddFlags(FL_OBJECT)
        pk_pills.setAiTeam(self, self.formTable.side or "default")
        self:SetOwner(ply)
        --self:SetPhysicsAttacker(ply)
        self:SetPlaybackRate(1)
    else
        if ply == LocalPlayer() then
            --Compatibility with gm+
            if gmp and gmp.Enabled:GetBool() then
                ply.pk_pill_gmpEnabled = true
                --RunConsoleCommand("gmp_enabled","0")
            end

            --Compatibility with Gmod Legs
            --ply.ShouldDisableLegs=true
            self.camTraceFilter = {self}
        end
    end
end

function ENT:PhysicsUpdate()
    if SERVER and self.drive.functions then
        self.drive.functions.think(self:GetPillUser(), self, self.drive.options)
    end
end

function ENT:OnRemove()
    local ply = self:GetPillUser()

    if SERVER then
        self:PillLoopStopAll()
    end

    if not pk_pills.unmapEnt(self:GetPillUser(), self) then
        if SERVER then
            pk_pills.setAiTeam(ply, "default")
            ply:SetRenderMode(RENDERMODE_NORMAL)

            if not self.dead then
                local angs = ply:EyeAngles()
                ply:Spawn()
                ply:SetEyeAngles(angs)
                ply:SetPos(self:GetPos())
                local phys = self:GetPhysicsObject()

                if phys:IsValid() then
                    ply:SetVelocity(phys:GetVelocity())
                end
            else
                ply:KillSilent()
            end
        else
            if ply == LocalPlayer() then
                if ply.pk_pill_gmpEnabled then
                    ply.pk_pill_gmpEnabled = nil
                end
            end
        end
    end
end

if CLIENT then
    --Clientside think hook-used for pose params
    function ENT:Think()
        if self.formTable then
            if self.formTable.renderOffset then
                local offset = self.formTable.renderOffset(self:GetPillUser(), self)
                self:SetRenderOrigin(self:GetNetworkOrigin() + offset)
            end
        end

        self:NextThink(CurTime())

        return true
    end
else
    function ENT:Think()
        local ply = self:GetPillUser()
        if not IsValid(ply) then return end
        ply:SetPos(self:GetPos())

        if self.formTable.pose then
            for k, f in pairs(self.formTable.pose) do
                local old = self:GetPoseParameter(k)
                local new = f(self:GetPillUser(), self, old)

                if new then
                    self:SetPoseParameter(k, new)
                end
            end
        end

        if self.formTable.aim and not self.formTable.aim.usesSecondaryEnt or IsValid(self:GetPillAimEnt()) then
            local aimEnt = self.formTable.aim.usesSecondaryEnt and self:GetPillAimEnt() or self

            if self.formTable.aim.xPose and self.formTable.aim.yPose then
                if not self.formTable.canAim or self.formTable.canAim(ply, self) then
                    local ang = ply:EyeAngles()
                    local locang = aimEnt:WorldToLocalAngles(ang)
                    local xOffset = self.formTable.aim.xOffset or 0

                    if not self.formTable.aim.xInvert then
                        aimEnt:SetPoseParameter(self.formTable.aim.xPose, math.NormalizeAngle(locang.y + xOffset))
                    else
                        aimEnt:SetPoseParameter(self.formTable.aim.xPose, math.NormalizeAngle(-locang.y + xOffset))
                    end

                    if not self.formTable.aim.yInvert then
                        aimEnt:SetPoseParameter(self.formTable.aim.yPose, locang.p)
                    else
                        aimEnt:SetPoseParameter(self.formTable.aim.yPose, -locang.p)
                    end
                elseif not self.formTable.useDefAim or self.formTable.useDefAim(ply, self) then
                    aimEnt:SetPoseParameter(self.formTable.aim.xPose, self.formTable.aim.xDef or 0)
                    aimEnt:SetPoseParameter(self.formTable.aim.yPose, 0)
                end
            end
        end

        if self.formTable.boneMorphs then
            for k, v in pairs(self.formTable.boneMorphs) do
                local b = self:LookupBone(k)

                if b then
                    if isfunction(v) then
                        v = v(ply, self)
                    end

                    if not istable(v) then continue end

                    if v.pos then
                        self:ManipulateBonePosition(b, v.pos)
                    end

                    if v.rot then
                        self:ManipulateBoneAngles(b, v.rot)
                    end

                    if v.scale then
                        self:ManipulateBoneScale(b, v.scale)
                    end
                end
            end
        end

        if self.formTable.moveSoundControl then
            local p = self.formTable.moveSoundControl(ply, self)

            if p then
                self:PillLoopSound("move", nil, p)
            else
                self:PillLoopStop("move")
            end
        end

        if (self.formTable.damageFromWater and self:WaterLevel() > 1) then
            if self.formTable.damageFromWater == -1 then
                self:PillDie()
            else
                --TODO APPLY DAMAGE
            end
        end

        if ply:KeyDown(IN_ATTACK) and self.formTable.attack and self.formTable.attack.mode == "auto" then
            if not self.formTable.aim or not self.formTable.aim.usesSecondaryEnt or IsValid(self:GetPillAimEnt()) then
                self:PillLoopSound("attack")
            else
                self:PillLoopStop("attack")
            end

            if (not self.lastAttack or self.formTable.attack.delay < CurTime() - self.lastAttack) then
                self.formTable.attack.func(ply, self, self.formTable.attack)
                self.lastAttack = CurTime()
            end
        else
            self:PillLoopStop("attack")
        end

        if ply:KeyDown(IN_ATTACK2) and self.formTable.attack2 and self.formTable.attack2.mode == "auto" then
            if not self.formTable.aim or not self.formTable.aim.usesSecondaryEnt or IsValid(self:GetPillAimEnt()) then
                self:PillLoopSound("attack2")
            else
                self:PillLoopStop("attack2")
            end

            if not self.lastAttack2 or self.formTable.attack2.delay < CurTime() - self.lastAttack2 then
                self.formTable.attack2.func(ply, self, self.formTable.attack2)
                self.lastAttack2 = CurTime()
            end
        else
            self:PillLoopStop("attack2")
        end

        self:NextThink(CurTime())

        return true
    end

    function ENT:DoKeyPress(ply, key)
        if self.drive.functions then
            self.drive.functions.key(ply, self, self.drive.options, key)
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
    end

    function ENT:StartTouch(TouchEnt)
        if not IsValid(TouchEnt:GetPhysicsObject()) then return end

        if (TouchEnt:IsPlayer() or TouchEnt:IsNPC() or TouchEnt:GetClass() == "pill_ent_phys") and TouchEnt:GetPhysicsObject():GetMaterial() ~= "metal" then
            if self.formTable.contact then
                local dmg_amt, dmg_type, dmg_force = self.formTable.contact(self:GetPillUser(), self, TouchEnt)

                if dmg_amt then
                    local dmg = DamageInfo()
                    dmg:SetDamage(20)
                    dmg:SetDamagePosition(self:GetPos())
                    dmg:SetAttacker(self:GetPillUser())

                    if dmg_type then
                        dmg:SetDamageType(dmg_type)
                    end

                    if dmg_force then
                        local force_vector = (TouchEnt:GetPos() - self:GetPos())

                        if self.formTable.contactForceHorizontal then
                            force_vector.z = 0
                        end

                        force_vector:Normalize()
                        force_vector = force_vector * dmg_force
                        dmg:SetDamageForce(force_vector)
                        self:GetPhysicsObject():ApplyForceCenter(-force_vector)
                    end

                    TouchEnt:TakeDamageInfo(dmg)
                    self:PillSound("contact")
                end
            end
        end
    end

    function ENT:PhysicsCollide(collide, phys)
        if self.formTable.collide then
            self.formTable.collide(self:GetPillUser(), self, collide)
        end
    end

    function ENT:OnTakeDamage(dmg)
        if (self.formTable.diesOnExplode and dmg:GetDamageType() == DMG_BLAST) then
            self:PillDie()
        end

        if self.formTable.health then
            if not self.formTable.onlyTakesExplosiveDamage then
                local newHealth = self:GetPillHealth() - dmg:GetDamage()

                if newHealth <= 0 then
                    self:PillDie()
                else
                    self:SetPillHealth(newHealth)
                end
            elseif dmg:GetDamageType() == DMG_BLAST then
                local newHealth = self:GetPillHealth() - 1

                if newHealth <= 0 then
                    self:PillDie()
                else
                    self:SetPillHealth(newHealth)
                end
            end
        end
    end

    function ENT:PillDie()
        if self.dead then return end

        if self.formTable.die then
            self.formTable.die(self:GetPillUser(), self)
        end

        self:GetPillUser():SetPos(self:GetPos()) --This makes the post-death camera position correctly
        self:PillSound("die")
        self:Remove()
        self.dead = true
        pk_pills.handeDeathCommon(self)
    end

    function ENT:PillAnim(seq, force)
        if force then
            --self:ResetSequenceInfo()
            self:ResetSequence(self:LookupSequence(seq))
        else
            self:SetSequence(self:LookupSequence(seq))
        end
    end

    function ENT:PillFilterCam(ent)
        net.Start("pk_pill_filtercam")
        net.WriteEntity(self)
        net.WriteEntity(ent)
        net.Send(self:GetPillUser())
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
            sound.Play(s, self:GetPos(), self.formTable.sounds[name .. "_level"] or 100, self.formTable.sounds[name .. "_pitch"] or 100, 1)
        else
            self:EmitSound(s, self.formTable.sounds[name .. "_level"] or 100, self.formTable.sounds[name .. "_pitch"] or 100)
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
    if not self.loopingSounds then return end

    for _, v in pairs(self.loopingSounds) do
        v:Stop()
    end
end

function ENT:Draw()
    if self:GetPillUser() ~= LocalPlayer() or pk_pills.convars.cl_thirdperson:GetBool() then
        if self.formTable.sprite then
            if not self.spriteMat then
                self.spriteMat = Material(self.formTable.sprite.mat)
            end

            local size = self.formTable.sprite.size or 40
            cam.Start3D(EyePos(), EyeAngles())
            render.SetMaterial(self.spriteMat)
            render.DrawSprite(self:GetPos() + (self.formTable.sprite.offset or Vector(0, 0, 0)), size, size, self.formTable.sprite.color or Color(255, 255, 255))
            cam.End3D()
        else
            self:DrawModel()
        end
    end
end
