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

PLUGIN.waypoints = {}

util.AddNetworkString("SetupWaypoints")
util.AddNetworkString("UpdateWaypoint")

function PLUGIN:RemoveWaypoints()
	self.waypoints = {}

	ix.combineNotify:AddNotification("NTC:// Updating Visual Uplink index", Color(0, 200, 150, 255))

	net.Start("SetupWaypoints")
		net.WriteBool(false)
	net.Broadcast()
end

function PLUGIN:UpdateWaypoint(index, newValue)
	if (newValue == nil) then
		table.remove(self.waypoints, index)

		net.Start("SetupWaypoints")
			net.WriteBool(true)
			net.WriteTable(self.waypoints)
		net.Broadcast()
	else
		self.waypoints[index] = newValue

		net.Start("UpdateWaypoint")
			net.WriteTable({index, newValue})
		net.Broadcast()
	end

	ix.combineNotify:AddNotification("NTC:// Updating Visual Uplink index", Color(0, 200, 150, 255))
end

function PLUGIN:AddWaypoint(waypoint)
	local index = table.insert(self.waypoints, waypoint)

	ix.combineNotify:AddNotification("NTC:// Updating Visual Uplink index", Color(0, 200, 150, 255))

	net.Start("UpdateWaypoint")
		net.WriteTable({index, waypoint})
	net.Broadcast()
end

function PLUGIN:GetWaypointColor(colorName)
	return Schema.colors[colorName]
end
