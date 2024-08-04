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
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
    self:NetworkVar("Vector", 0, "WepOffset")
    self:NetworkVar("Angle", 0, "WepAng")
end

function ENT:Initialize()
    if SERVER then
        if self.attachment then
            self:Fire("setparentattachment", "anim_attachment_RH", 0)
        else
            self:AddEffects(bit.bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL))
        end

        self:SetRenderMode(RENDERMODE_TRANSALPHA)
    end
end

function ENT:Think()
    self:NextThink(CurTime())

    return true
end

function ENT:Draw()
    local offset = self:GetWepOffset()
    local ang = self:GetWepAng()

    if offset ~= Vector(0, 0, 0) then
        self:SetRenderOrigin(self:LocalToWorld(offset))
    end

    if ang ~= Angle(0, 0, 0) then
        self:SetRenderAngles(self:LocalToWorldAngles(ang))
    end

    self:DrawModel()
end
