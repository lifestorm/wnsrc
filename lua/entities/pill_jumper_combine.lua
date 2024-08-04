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
ENT.PrintName = "Combine Jumper"
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
    if SERVER then
        --Physics
        --self:SetModel("models/combine_soldier.mdl")
        self:PhysicsInit(SOLID_BBOX)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_BBOX)
        --self.myNpc="npc_combine_s"
        --self.myWeapon="weapon_smg1"
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
        end

        self.dropping = false
        self.falltime = 0
        self:ResetSequence(self:LookupSequence("dropship_deploy"))

        timer.Simple(2.4, function()
            if not IsValid(self) then return end
            self:SetParent()
            self:PhysicsInit(SOLID_BBOX)
            local phys = self:GetPhysicsObject()

            if (phys:IsValid()) then
                phys:Wake()
            end

            self:SetSequence(self:LookupSequence("jump_holding_glide"))
            self.dropping = true
        end)
    end
end

function ENT:Think()
    if SERVER then
        if self.dropping then
            self.falltime = self.falltime + 1
            local tr = util.QuickTrace(self:GetPos(), Vector(0, 0, -15), self)

            if tr.Hit then
                local dude = ents.Create(self.myNpc)
                dude:SetModel(self:GetModel())
                dude:SetSkin(self:GetSkin())
                dude:SetPos(self:GetPos())
                dude:SetAngles(Angle(0, self:GetAngles().y, 0))
                dude:SetKeyValue("additionalequipment", self.myWeapon)
                dude:Spawn()

                if self.falltime > 50 then
                    dude:GetActiveWeapon():Remove()
                    dude:Fire("BecomeRagdoll", "", 0)
                else
                    local p = self:GetPos() + self:GetForward() * 300 + Vector(math.random(-200, 200), math.random(-200, 200), 0)

                    timer.Simple(.1, function()
                        if not IsValid(dude) then return end
                        dude:SetSchedule(SCHED_FORCED_GO)
                    end)
                end

                self:Remove()
            end
        end
    end

    self:NextThink(CurTime())

    return true
end

function ENT:Draw()
    if IsValid(self:GetParent()) then
        self:SetRenderOrigin(self:GetParent():LocalToWorld(self:GetNetworkOrigin() + Vector(-200, 0, 0) * (1 - self:GetCycle())))
    else
        self:SetRenderOrigin(self:GetNetworkOrigin())
    end

    self:DrawModel()
end
