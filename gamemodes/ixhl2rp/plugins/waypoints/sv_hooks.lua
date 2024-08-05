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

function PLUGIN:PlayerLoadedCharacter(client, character, currentChar)
	net.Start("SetupWaypoints")
		net.WriteBool(true)
		net.WriteTable(self.waypoints)
	net.Send(client)
end

timer.Create("ixWaypointUpdate", 60, 0, function()
	local curTime = CurTime()
	local toRemove = {}

	for k, waypoint in pairs(PLUGIN.waypoints) do
		if (waypoint.time < curTime) then
			table.insert(toRemove, k)
		end
	end

	if (#toRemove > 0) then
		table.sort(toRemove)

		for i = #toRemove, 1, -1 do
			table.remove(PLUGIN.waypoints, toRemove[i])
		end

		ix.combineNotify:AddNotification("NTC:// Updating Visual Uplink index", Color(0, 200, 150, 255))

		net.Start("SetupWaypoints")
			net.WriteBool(true)
			net.WriteTable(PLUGIN.waypoints)
		net.Broadcast()
	end
end)
