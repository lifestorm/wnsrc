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

--[[function ENT:SetupDataTables()
	self:NetworkVar("Vector",0,"WepOffset")
	self:NetworkVar("Angle",0,"WepAng")
end]]
function ENT:Initialize()
    if SERVER then
        self:AddEffects(bit.bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL))
    end
end

function ENT:Think()
    self:NextThink(CurTime())

    return true
end
