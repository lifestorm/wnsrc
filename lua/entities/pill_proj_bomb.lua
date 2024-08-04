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
ENT.PrintName = "Bomb"

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "Particle")
end

function ENT:Initialize()
    if SERVER then
        if self.sphere then
            self:PhysicsInitSphere(self.sphere)
        else
            self:PhysicsInit(SOLID_VPHYSICS)
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:SetSolid(SOLID_VPHYSICS)
        end

        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableDrag(false)
            phys:SetDamping(0, 0)
            phys:SetVelocity(self:GetAngles():Forward() * (self.speed or 1000))
        end

        if self.sticky then
            self:SetCustomCollisionCheck(true)
        end

        timer.Simple(self.fuse or 3, function()
            if IsValid(self) then
                if self.sticky then
                    self.armed = true
                    ParticleEffect("stickybomb_pulse_red", self:GetPos(), Angle(0, 0, 0))
                else
                    self:Remove()
                end
            end
        end)
    end

    if self:GetParticle() ~= "" then
        ParticleEffectAttach(self:GetParticle(), PATTACH_ABSORIGIN_FOLLOW, self, 0)
    end
end

function ENT:OnRemove()
    if SERVER then
        if self.sticky and not self.armed then return end

        if self.tf2 then
            ParticleEffect("ExplosionCore_MidAir", self:GetPos(), Angle(0, 0, 0))
            self:EmitSound("weapons/explode1.wav")
            util.BlastDamage(self, self:GetOwner(), self:GetPos(), 100, 100)
        else
            local explode = ents.Create("env_explosion")
            explode:SetPos(self:GetPos())
            explode:Spawn()
            explode:SetKeyValue("iMagnitude", "100")
            explode:Fire("Explode", 0, 0)
            explode:SetOwner(self:GetOwner())
        end
    end
end

function ENT:Think()
    if SERVER and self.sticky then
        if not IsValid(self:GetOwner()) or not self:GetOwner():Alive() then
            self.armed = false
            self:Remove()
        end

        if self.armed and self:GetOwner():KeyDown(IN_ATTACK2) then
            self:Remove()
        end

        self:NextThink(CurTime())

        return true
    end
end

function ENT:StartTouch(ent)
    if not self.sticky and (ent:IsNPC() or ent:IsPlayer() or ent:GetClass() == "pill_ent_phys") then
        self:Remove()
    end
end

function ENT:PhysicsCollide(colData, collider)
    if self.sticky and self:GetPhysicsObject():IsMotionEnabled() then
        self:GetPhysicsObject():EnableMotion(false)

        if not colData.HitEntity:IsWorld() then
            self:SetParent(colData.HitEntity)
        end
    end
end

hook.Add("ShouldCollide", "pk_pill_bomberman", function(bomb, other)
    if bomb:GetClass() == "pill_proj_bomb" then
    elseif other:GetClass() == "pill_proj_bomb" then
        local temp = bomb
        bomb = other
        other = temp
    else
        return
    end

    if other:GetClass() == "pill_proj_bomb" or other:IsNPC() or other:IsPlayer() then return false end
end)
