--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

function ix.scalestuff:ScaleEntity(ent, size)
    if (IsValid(ent) and !ent:IsNPC() and !ent:IsPlayer() and isnumber(size)) then
        for _, v in ipairs(PLUGIN.disallowedClasses) do
            if (ent:GetClass() == v) then
                return
            end
        end

        ent:SetModelScale(size, 0.01)
        ent:DrawShadow(false)
        ent:Activate()
        ent:SetSolid(SOLID_BBOX)
        ent:SetMoveType(MOVETYPE_NONE)

        ent.scaledSize = size
    end
end
