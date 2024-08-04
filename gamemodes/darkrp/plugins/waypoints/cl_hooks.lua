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

function PLUGIN:HUDPaint()
	if (!hook.Run("CanPlayerSeeWaypoints", LocalPlayer())) then
		return
	end

	local height = draw.GetFontHeight("BudgetLabel")
	local clientPos = LocalPlayer():EyePos()

	for index, waypoint in pairs(self.waypoints) do
		if (waypoint.time < CurTime()) then
			self.waypoints[index] = nil

			continue
		end

		local screenPos = waypoint.pos:ToScreen()
		local color = waypoint.color
		local text = waypoint.text
		local x, y = screenPos.x, screenPos.y

		surface.SetDrawColor(color)

		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/waypoint1.png"))
		surface.DrawTexturedRectRotated(x, y, 50, 50, CurTime() * -150)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/waypoint2.png"))
		surface.DrawTexturedRectRotated(x, y, 50, 50, CurTime() * 150)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/waypoint3.png"))
		surface.DrawTexturedRectRotated(x, y, 50, 50, CurTime() * -150)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/waypoint4.png"))
		surface.DrawTexturedRectRotated(x, y, 50, 50, CurTime() * 150)

		surface.SetFont("BudgetLabel")
		surface.SetTextColor(color)

		local width = surface.GetTextSize(text)

		surface.SetTextPos(x - width / 2, y - 30 - height)
		surface.DrawText(text)

		if (!waypoint.noDistance) then
			local distanceText = tostring(math.Round(clientPos:Distance(waypoint.pos) * 0.01905, 2)) .. "m"
			
			width = surface.GetTextSize(distanceText)
			surface.SetTextPos(x - width / 2, y + 30)
			surface.DrawText(distanceText)
		end
	end
end

net.Receive("SetupWaypoints", function()
	local bWaypoints = net.ReadBool()
	if (!bWaypoints) then
		PLUGIN.waypoints = {}
		return
	end

	local data = net.ReadTable()
	for index, waypoint in pairs(data) do
		local text = waypoint.text
		-- check for any phrases and replace the text
		if (text:sub(1, 1) == "@") then
			waypoint.text = ":: " .. L(text:sub(2), waypoint.arguments and unpack(waypoint.arguments) or nil) .. " ::"
		else
			waypoint.text = ":: " .. text .. " ::"
		end

		data[index] = waypoint
	end

	PLUGIN.waypoints = data
end)

net.Receive("UpdateWaypoint", function()
	local data = net.ReadTable()
	if (data[2] != nil) then
		local text = data[2].text
		-- check for any phrases and replace the text
		if (text:sub(1, 1) == "@") then
			data[2].text = ":: " .. L(text:sub(2), data[2].arguments and unpack(data[2].arguments) or nil) .. " ::"
		else
		    data[2].text = ":: " .. text .. " ::"
		end
	end

	PLUGIN.waypoints[data[1]] = data[2]
end)
