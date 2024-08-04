--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local Color = Color
local isstring = isstring
local netstream = netstream
local player = player


local ix = ix

ix.combineNotify = ix.combineNotify or {}

function ix.combineNotify:AddNotification(text, color, location, waypointPos, receivers, ...)
	if (ix.config.Get("suitsNoConnection")) then return end

	color = color or color_white

	if (location and !isstring(location)) then
		location = location:GetLocation()
	end

	if (waypointPos) then
		ix.waypoint.AddWaypoint(waypointPos, text, color, 30, nil, ...)
	end

	netstream.Start(receivers or player.GetAll(), "CombineDisplayMessage", text, color, location, {...})
end

function ix.combineNotify:AddObjectiveNotification(text, color, location, waypointPos, receivers, ...)
	if (ix.config.Get("suitsNoConnection")) then return end

	color = color or color_white

	if (location and !isstring(location)) then
		location = location:GetLocation()
	end

	if (waypointPos) then
		ix.waypoint.AddWaypoint(waypointPos, text, color, 30, nil, ...)
	end

	netstream.Start(receivers or player.GetAll(), "CombineDisplayMessage", text, color, location, {...}, true)
end

local color_red = Color(255, 0, 0, 255)

function ix.combineNotify:AddImportantNotification(text, color, target, waypointPos, receivers, ...)
	if (ix.config.Get("suitsNoConnection")) then return end

	color = color or color_red

	local posActual
	if (target and target.IsPlayer and target:IsPlayer() and target.GetLocation) then
		local location = target:GetLocation()
		if (ix.area.stored[location]) then
			-- genius way of getting center
			posActual = LerpVector(0.5,
				ix.area.stored[location].startPosition, ix.area.stored[location].endPosition)
		end
	end

	if (posActual) then
		ix.waypoint.AddWaypoint(posActual, text, color, 60, nil, ...)
	end

	netstream.Start(receivers or player.GetAll(), "ImportantCombineDisplayMessage", text, color, location, {...})
end
