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
ENT.Author = "Zippy"
ENT.PrintName = "Strider Synth"
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local laser2mat = Material("effects/blueblacklargebeam")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
    function ENT:ExpandLaser(time,size)
        if self.ExpandingLaser then return end
        self.ExpandingLaser = true

        self.LaserWidth = 0
    
        local reps = 33
        timer.Create("VJ_Z_StriderLaserWidthTimer" .. self:EntIndex(), time/reps, reps, function() if IsValid(self) then
            self.LaserWidth = math.Clamp( self.LaserWidth + size/reps , 0, size)
        end end)

        -- timer.Simple(time, function() if IsValid(self) then
        --     self.ExpandingLaser = false
        -- end end)
    end

    function ENT:Draw()
        self:DrawModel()

        if self:GetNWBool("StriderChargingCannon") == true then
            if !self.LaserExpanded then
                self:ExpandLaser(1.1, 12)
            end

            local tr = util.TraceLine({
                start = self:GetAttachment(9).Pos,
                endpos = self:GetAttachment(9).Pos + (self:GetNWVector("StriderCannonBeamPos") - self:GetAttachment(9).Pos):GetNormalized()*10000,
                mask = MASK_SHOT,
                filter = self,
            })

            render.SetMaterial(laser2mat)
            render.DrawBeam(self:GetAttachment(9).Pos, tr.HitPos, self.LaserWidth, 0, 1)
        else
            self.LaserExpanded = false
            self.ExpandingLaser = false
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------