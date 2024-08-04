--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

hook.Add( "LVS:ARMED:Initialize", "[LVS] - Armed [Fake Physics]", function()
	if SERVER then
		AddCSLuaFile("simfphys/cl_armedvehicles_specialcam.lua")
		AddCSLuaFile("simfphys/cl_armedvehicles_tankextras.lua")
		AddCSLuaFile("simfphys/cl_armedvehicles_xhair.lua")

		include("simfphys/sv_armedvehicles_handler.lua")

		return
	end

	include("simfphys/cl_armedvehicles_specialcam.lua")
	include("simfphys/cl_armedvehicles_tankextras.lua")
	include("simfphys/cl_armedvehicles_xhair.lua")
end)