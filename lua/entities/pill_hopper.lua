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
ENT.PrintName = "Hopper"

--[[
Light
0 - None
1 - Blue
2 - Yellow
3 - Green
4 - Red

Legs
0 - Open
1 - Close
2 - Moving
]]
function ENT:Initialize()
    if SERVER then
        --Physics
        self:SetModel("models/props_combine/combine_mine01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
        end

        self.armed = false
        self.armCounter = 0
        self.held = false
        self.critical = false
        self.friendly = false
        self.alertSound = CreateSound(self, "npc/roller/mine/combine_mine_active_loop1.wav")
        --self:SetLegs(2)
        self:SetLight(1)
    end
end

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Light")
    self:NetworkVar("Int", 1, "Legs")
end

function ENT:Think()
    if SERVER then
        --CurTime()
        if not self.armed and self:GetVelocity():Length() < 10 and not self.held then
            local tr = util.QuickTrace(self:GetPos(), Vector(0, 0, -15), self)

            if tr.Hit then
                if self.armCounter < 5 then
                    self.armCounter = self.armCounter + 1
                else
                    local trUp = util.QuickTrace(self:GetPos(), self:LocalToWorldAngles(Angle(-90, 0, 0)):Forward() * 15, self)

                    if trUp.Hit then
                        self:GetPhysicsObject():ApplyForceCenter(Vector(0, 0, 3000))
                        self:GetPhysicsObject():AddAngleVelocity(VectorRand() * 500)
                        self:EmitSound("npc/roller/mine/rmine_blip3.wav", 100, 100)
                    else
                        local trDown = util.QuickTrace(self:GetPos(), self:LocalToWorldAngles(Angle(90, 0, 0)):Forward() * 15, self)

                        if trDown.Hit then
                            self.armed = true
                            self:SetLight(0)
                            self:SetLegs(1)
                            self:EmitSound("npc/roller/blade_cut.wav", 100, 100)
                            local weld = constraint.Weld(self, trDown.Entity, 0, 0, 5000, true)

                            if weld then
                                weld:CallOnRemove("DeMine", function()
                                    if not self.held and not self.critical then
                                        self:SetLight(1)
                                        self:SetLegs(0)
                                        self.armed = false
                                    end
                                end)
                            end
                        end
                    end

                    self.armCounter = 0
                end
            end
            --print("AHH")
        end

        if self:GetPhysicsObject():HasGameFlag(FVPHYSICS_PLAYER_HELD) ~= self.held then
            if not self.held then
                self:SetLight(2)
                self:SetLegs(2)
                self.held = true
                self.armed = false
                self.friendly = true
                self.critical = false
                self.alertSound:Stop()
            else
                --print(self:GetVelocity():Length())
                if self:GetVelocity():Length() > 500 then
                    self:SetLight(4)
                    self.critical = true
                else
                    self:SetLight(1)
                    self:SetLegs(0)
                end

                self.held = false
            end
        end

        if self.armed then
            local near = ents.FindInSphere(self:GetPos(), 200)
            local goGreen = false
            local goRed = false

            for _, e in pairs(near) do
                local t = pk_pills.getAiTeam(e)

                if t then
                    if t == (self.friendly and "default" or "hl_combine") or t == "harmless" then
                        goGreen = true
                    else
                        goRed = true

                        if self:GetPos():Distance(e:GetPos()) < 100 then
                            constraint.RemoveAll(self)
                            self:SetLight(4)
                            self:SetLegs(0)
                            self.alertSound:Stop()
                            self.critical = true
                            self:EmitSound("npc/roller/blade_in.wav", 100, 100)

                            timer.Simple(.01, function()
                                self:GetPhysicsObject():ApplyForceCenter(Vector(0, 0, 5000) + (e:GetPos() + e:GetVelocity() * .8 - self:GetPos()) * 10)
                                self:GetPhysicsObject():AddAngleVelocity(VectorRand() * 200)
                            end)
                        end

                        break
                    end
                end
            end

            if not self.critical then
                if goRed then
                    self:SetLight(4)
                    self.alertSound:Play()
                elseif goGreen then
                    self:SetLight(3)
                    self.alertSound:Stop()
                else
                    self:SetLight(0)
                    self.alertSound:Stop()
                end
            end
        end
    else
        local legState = self:GetLegs()
        local legPose = 65

        if legState == 1 then
            legPose = 0
        elseif legState == 2 then
            legPose = (math.sin(CurTime() * 8) + 1) * 32.5
        end

        self:SetPoseParameter('blendstates', legPose)
    end
end

function ENT:PhysicsCollide()
    if self.critical then
        self:Splode()
    end
end

function ENT:Splode()
    self:Remove()
    local explode = ents.Create("env_explosion")
    explode:SetPos(self:GetPos())
    explode:Spawn()
    --explode:SetOwner(self:GetOwner())
    explode:SetKeyValue("iMagnitude", "100")
    explode:SetOwner(self:GetOwner())
    explode:Fire("Explode", 0, 0)
end

function ENT:Draw()
    self:DrawModel()
    local lightState = self:GetLight()
    local lightColor

    if lightState == 1 then
        lightColor = Color(0, 0, 255)
    elseif lightState == 2 then
        lightColor = Color(255, 255, 0)
    elseif lightState == 3 then
        lightColor = Color(0, 255, 0)
    elseif lightState == 4 then
        lightColor = Color(255, 0, 0)
    end

    if lightColor then
        --print("draw")
        --PrintTable(lightColor)
        cam.Start3D(EyePos(), EyeAngles())
        render.SetMaterial(Material("sprites/light_glow02_add"))
        render.DrawSprite(self:LocalToWorld(Vector(0, 0, 12)), 64, 64, lightColor) --color
        cam.End3D()
    end
end
