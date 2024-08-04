--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local function damagedbackfire( length )
	local veh = net.ReadEntity()
	if not IsValid( veh ) then return end
	veh:Backfire( true )
end
net.Receive("simfphys_backfire", damagedbackfire)
