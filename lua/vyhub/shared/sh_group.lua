--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

VyHub.Group = VyHub.Group or {}

function VyHub.Group:get(groupname)
    if VyHub.groups_mapped == nil then
        return nil
    end

    return VyHub.groups_mapped[groupname]
end