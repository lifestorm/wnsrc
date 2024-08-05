--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local net = net
local vgui = vgui

net.Receive("ixBodygroupView", function()
    local target = net.ReadEntity()
    local proxyColors = net.ReadTable()
    local panel = vgui.Create("ixBodygroupView")
    panel:SetViewModel(target:GetModel())
    panel:SetTarget(target, proxyColors)
end)
