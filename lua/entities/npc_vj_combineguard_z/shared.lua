--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Combine Guard"
ENT.Author 			= "Zippy"

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local laser2mat = Material("effects/blueblacklargebeam")
local laserwidth = 4

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

        if self:GetNWBool("VJCombGuardZGunCharging") == true then
            if !self.LaserExpanded then
                self:ExpandLaser(1, 20)
            end

            if !self.ClientFirePosUpdated then
                self.ClientFirePos = self:GetNWVector("VJCombGuardZFirePos")
                self.ClientFirePosUpdated = true
            end
        
            render.SetMaterial(laser2mat)
            render.SetShadowsDisabled(true)
            render.DrawBeam(self:GetAttachment(1).Pos, self.ClientFirePos, self.LaserWidth, 0, 1, Color(255,255,255))

        else
            self.LaserExpanded = false
            self.ExpandingLaser = false
            self.ClientFirePosUpdated = false
        end

    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
    if self.HasGibDeathParticles == true then -- Taken from black mesa SNPCs I think Xdddddd
        local bloodeffect = EffectData()
        bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
        bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
        bloodeffect:SetScale(200)
        util.Effect("VJ_Blood1",bloodeffect)
    end

    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/eye_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,55)),Ang = self:GetAngles() + Angle(0,-90,0),Vel = self:GetRight() * math.Rand(50,50) + self:GetForward() * math.Rand(-200,200)})
    if self:GetModel() != "models/combine_super_soldier.mdl" && self:GetModel() != "models/vj_fassassin_z.mdl" then
        self:CreateGibEntity("obj_vj_gib","models/gibs/humans/eye_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,55)),Ang = self:GetAngles() + Angle(0,-90,0),Vel = self:GetRight() * math.Rand(50,50) + self:GetForward() * math.Rand(-200,200)})
    end

    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/brain_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,60)),Ang = self:GetAngles() + Angle(0,-90,0)})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/heart_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,35))})
    for i = 1, 2 do
        self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
    end
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------