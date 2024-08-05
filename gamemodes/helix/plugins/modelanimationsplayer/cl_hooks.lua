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

PLUGIN.menu = PLUGIN.menu or nil
PLUGIN.selectedSequence = PLUGIN.selectedSequence or nil

netstream.Hook("ixModelAnimationsShowMenu", function(ply)
    if (!CAMI.PlayerHasAccess(LocalPlayer(), "Helix - " .. PLUGIN.name, nil)) then return end

    if (!PLUGIN.menu) then
        PLUGIN.menu = vgui.Create("ixModelAnimationsList")

        return
    end

    PLUGIN.menu:Remove()
    PLUGIN.menu = nil
end)