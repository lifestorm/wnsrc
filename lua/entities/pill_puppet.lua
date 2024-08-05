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
ENT.Type = "ai"
ENT.Base = "base_entity"

function ENT:Initialize()
    self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:Draw()
    self:DrawModel()
end

function ENT:DrawTranslucent()
    self:Draw()
end
