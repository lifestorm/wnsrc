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
ENT.PrintName = "Assassin Synth"
ENT.Author = "Zippy"

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
    local EyeGlowMat = Material("particle/particle_glow_02")
    function ENT:Draw()

        self:DrawModel()
        local pos1 = self:GetAttachment(2).Pos
        local pos2 = self:GetAttachment(3).Pos
        render.SetMaterial(EyeGlowMat)
        render.DrawSprite(pos1, 3, 3, Color(0,150,0))
        render.DrawSprite(pos2, 3, 3, Color(0,150,0))

    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------