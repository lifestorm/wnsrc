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

function ENT:Initialize()
    self:AddCallback("BuildBonePositions", self.BoneItUp)

    if SERVER then
        self:AddEffects(bit.bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL)) --fastcull seems to fix laggy bullshit garbage
    end

    self:GetParent():SetSubMaterial(0, "models/effects/vol_light001")
end

function ENT:BoneItUp(boneCount)
    local boneId = self:LookupBone("ValveBiped.Bip01_Head1")
    if not boneId then return end
    local matrix = self:GetBoneMatrix(boneId)
    if not matrix then return end
    matrix:Scale(Vector(.01, .01, .01))
    self:SetBoneMatrix(boneId, matrix)
end
