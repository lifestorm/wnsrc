--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Base 			= "npc_vj_hunterchopper_z"
ENT.Type 			= "ai"
ENT.PrintName 		= "Gunship Synth"
ENT.Author 			= "Zippy"

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local laser2mat = Material("sprites/strider_bluebeam")
local laserdotmat = Material("particle/particle_glow_03")
local laserwidth = 4

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
    function ENT:Draw()

        self:DrawModel()

        if self:GetNWBool("VJGunshipZDoingBCannon") == true then

            local lasertracer = util.TraceLine({
                start = self:GetAttachment(4).Pos,
                endpos = self:GetAttachment(4).Pos - Vector(0,0,10000),
                mask = MASK_NPCWORLDSTATIC,
                filter = self,
            })
        
            render.SetMaterial(laser2mat)
            render.SetShadowsDisabled(true)
            render.DrawBeam(self:GetAttachment(4).Pos, lasertracer.HitPos, laserwidth*2, 0, 1, Color(255,255,255))

            if lasertracer.Hit then
                render.SetMaterial(laserdotmat)
                render.DrawSprite(lasertracer.HitPos, laserwidth*3, laserwidth*3, Color(0,200,255))
            end
        end

    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------