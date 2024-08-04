--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local maxballsize = 150
local ball_expand_speed = 1.25

local mat_warp = Material("particle/warp2_warp")
local mat_ball = Material("sprites/strider_blackball")

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Expand(time,size)
    self.BallScale = 0

    local reps = 50
    timer.Create("VJ_Z_BallWidthTimer" .. self.Ent:EntIndex(), time/reps, reps, function() if IsValid(self) then
        self.BallScale = math.Clamp( self.BallScale + size/reps , 0, size)
    end end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Init(data)
    local expand_time = data:GetMagnitude()

    self.Start = data:GetStart()
    self.Ent = data:GetEntity()
    self.Attachment = data:GetAttachment()

    self.DeathTime = CurTime()+expand_time
    self.ScaleMult = data:GetScale()

    self:SetRenderBoundsWS(self.Start - Vector(15,15,15), self.Start + Vector(15,15,15))

    self:Expand(expand_time,maxballsize*self.ScaleMult)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think()

    if IsValid(self.Ent) && self.Attachment > 0 then
        self.Start = self.Ent:GetAttachment(self.Attachment).Pos
        self:SetRenderBoundsWS(self.Start - Vector(15,15,15), self.Start + Vector(15,15,15))
    end

    if !IsValid(self.Ent) or self.DeathTime < CurTime() then
        return false
    end

    return true

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Render()

    render.SetMaterial(mat_warp)
    render.DrawSprite(self.Start,self.BallScale ^ 1.15,self.BallScale ^ 1.15, Color(255,255,255,100))

    render.SetMaterial(mat_ball)
    render.DrawSprite(self.Start,self.BallScale*0.66,self.BallScale*0.66)

    return true

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------