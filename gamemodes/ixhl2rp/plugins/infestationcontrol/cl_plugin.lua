--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


net.Receive("ixInfestationZoneCreate", function()
    vgui.Create("ixInfestationZoneCreate")
end)

net.Receive("ixInfestationZoneNetwork", function()
    local storedTable = net.ReadTable()

    ix.infestation.stored = storedTable
end)
