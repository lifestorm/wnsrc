--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"
ENT.PrintName = "Combine Stalker"
ENT.Author = "Zippy"

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if CLIENT then
    local laser2mat = Material("trails/laser")

    local beam_colors = {
        repair_beam = Color(255,0,0),
        medium_beam = Color(255,70,0),
        strong_beam = Color(255,175,0),
    }

    function ENT:Draw()
        self:DrawModel()

        if self:GetNWBool("StalkerFiringLaser") == true then
            if !self.CurrentLaserPos then
                self.CurrentLaserPos = self:GetNWVector("StalkerLaserPos")
            end
            self.CurrentLaserPos = LerpVector(0.1, self.CurrentLaserPos, self:GetNWVector("StalkerLaserPos"))

            local tr = util.TraceLine({
                start = self:GetAttachment(1).Pos,
                endpos = self:GetAttachment(1).Pos + (self.CurrentLaserPos - self:GetAttachment(1).Pos):GetNormalized()*10000,
                mask = MASK_SHOT,
                filter = self,
            })

            render.SetMaterial(laser2mat)
            render.DrawBeam(self:GetAttachment(1).Pos, tr.HitPos, 8, 0, 1, beam_colors[self:GetNWString("StalkerBeamType")])
        else
            self.CurrentLaserPos = nil
        end
    end

    function ENT:Think() end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------