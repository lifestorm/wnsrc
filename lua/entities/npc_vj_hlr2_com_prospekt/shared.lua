--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Base 			= "npc_vj_hlr2_com_soldier"
ENT.Type 			= "ai"
ENT.PrintName 		= "Overwatch Prison Guard"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Half-Life Resurgence"

if CLIENT && GetConVar("vj_hlr2_combine_eyeglow"):GetInt() == 1 then
    local mat = Material("sprites/light_glow02_add")
    local vecOrigin = Vector(4.5,5,1.75)
    local size = 8
    local col = Color(255,253,123)
    function ENT:CustomOnDraw()
        local bone = self:LookupBone("ValveBiped.Bip01_Head1")
        local pos,ang = self:GetBonePosition(bone)
        local glowOrigin = pos + ang:Forward() * vecOrigin.x + ang:Right() * vecOrigin.y + ang:Up() * vecOrigin.z

        render.SetMaterial(mat)
        for i = 1, 2 do
            if i == 2 then
                glowOrigin = pos + ang:Forward() * vecOrigin.x + ang:Right() * vecOrigin.y + ang:Up() * -vecOrigin.z
            end
            render.DrawSprite(glowOrigin, size, size, col)
            render.DrawSprite(glowOrigin, size, size, col)
        end
    end
end