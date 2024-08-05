--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.waypoint = ix.waypoint or {}
ix.waypoint.types = ix.waypoint.types or {}

local PLUGIN = PLUGIN

function ix.waypoint.AddWaypoint(position, text, color, time, addedBy, ...)
	if (!position or !isvector(position) or !position.Add) then
		ErrorNoHalt("[WAYPOINTS] Invalid position given "..(position or nil))
		return
	end
	position:Add(Vector(0, 0, 30))
	color = color or color_white
	time = time or 8

	local waypoint = {
		pos = position,
		text = text,
		color = color,
		addedBy = addedBy,
		arguments = {...},
		time = CurTime() + time
	}

	PLUGIN:AddWaypoint(waypoint)
end