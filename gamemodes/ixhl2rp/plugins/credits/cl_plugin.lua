--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local netstream = netstream
local vgui = vgui


local PLUGIN = PLUGIN

netstream.Hook("EditEventCredits", function(creditsMembers)
    PLUGIN.creditsMembers = creditsMembers
    vgui.Create("ixEventCreditsEditor")
end)

netstream.Hook("ShowcaseEventCredits", function(creditsMembers, shouldShowCredits)
    PLUGIN.creditsMembers = creditsMembers or {}
    local credits = vgui.Create("ixEventCredits")
    if !shouldShowCredits then
        credits:AlphaTo(255, 3, 0, function()
            credits:FadeInLogo()
        end)
    else
        credits:AlphaTo(255, 3, 0, function()
            credits:FadeInCredits()
        end)
    end
end)