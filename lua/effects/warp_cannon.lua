--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--Most of the credit for this goes to the people who made/helped with the strider cannon SWEP:
--  http://www.garrysmod.org/downloads/?a=view&id=31329
local flashMat = Material("Effects/blueblackflash")
local pinchMat = Material("Effects/strider_pinch_dudv")
local beamMat = Material("Effects/blueblacklargebeam")

function EFFECT:Init(effectdata)
    self.ent = effectdata:GetEntity()
    self.hitPos = effectdata:GetOrigin()
    self.startTime = CurTime()
    self.cycle = 0
end

function EFFECT:Think()
    if not IsValid(self.ent) then return false end
    self:SetPos(self.ent:GetAttachment(self.ent:GetModel() == "models/combine_strider.mdl" and self.ent:LookupAttachment("BigGun") or self.ent:LookupAttachment("bellygun")).Pos)
    self:SetRenderBoundsWS(self:GetPos(), self.hitPos)
    if CurTime() - self.startTime > 2.4 then return false end

    return true
end

function EFFECT:Render()
    local cycleF = (CurTime() - self.startTime) / 1.2
    --flash
    render.SetMaterial(flashMat)

    if cycleF < .5 then
        render.DrawSprite(self:GetPos(), cycleF * 100, cycleF * 100, Color(0, 0, 0, 255))
    elseif cycleF < 1 then
        render.DrawSprite(self:GetPos(), cycleF * 100, cycleF * 100, Color(cycleF * 255, cycleF * 255, cycleF * 255, 255))
    else
        render.DrawSprite(self:GetPos(), 50, 50, Color(255, 255, 255, 255))
    end

    if cycleF < 1 then
        --pinch
        pinchMat:SetFloat("$refractamount", cycleF)
        render.SetMaterial(pinchMat)
        render.UpdateRefractTexture()
        render.DrawSprite(self:GetPos(), cycleF * 150, cycleF * 150)

        --Beam
        if cycleF > .5 then
            render.SetMaterial(beamMat)
            render.DrawBeam(self:GetPos(), self.hitPos, cycleF * 2, 0, 0, Color(255, 255, 255, (cycleF - .5) * 255))
        end
    elseif cycleF < 1.1 then
        --fired beam
        render.SetMaterial(beamMat)
        render.DrawBeam(LerpVector((cycleF - 1) * 10, self:GetPos(), self.hitPos), self.hitPos, (cycleF - 1) * 500, 0, 0)
    end
end
