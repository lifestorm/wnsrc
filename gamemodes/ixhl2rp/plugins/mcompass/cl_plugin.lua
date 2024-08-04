--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Credits to Raven for the original mCompass.

surface.CreateFont("exo_compass_Numbers_2.2", {
	font = "Exo",
	size = math.Round((ScrH() * 0.03) / 2.2),
	antialias = true
})

surface.CreateFont("exo_compass_Distance-Display-Numbers_2.2", {
	font = "Exo",
	size = (ScrH() * (0.03 / 2.2)) * 1,
	antialias = true
})

surface.CreateFont("exo_compass_Letters", {
	font = "Exo",
	size = (ScrH() * (0.03 / 1.2)) * 1,
	antialias = true
})

local function v(arg)
	local arg = tonumber(arg)

	return math.Clamp(arg and arg or 255, 0, 255)
end

local displayDistanceFontTable = {}

-- Function that handles fonts for the spot marker.
local function markerScaleFunc(markerSizeScale)
	local returnVal
	local n = math.Round(markerSizeScale)
	
	if (!oldMarkerSizeScale or oldMarkerSizeScale != n) then
		if (displayDistanceFontTable[n]) then
			returnVal = displayDistanceFontTable[n].name
		else
			local newFontName = tostring("exo_compass_DDN_" .. n)

			displayDistanceFontTable[n] = {
				name = newFontName,
				size = n
			}

			surface.CreateFont(newFontName, {
				font = "Exo",
				size = n,
				antialias = true
			})

			returnVal = displayDistanceFontTable[n].name
		end

		oldMarkerSizeScale = n
	else
		return displayDistanceFontTable[oldMarkerSizeScale].name
	end

	return returnVal
end

local mat2 = Material("compass/compass_marker_02")

local function GetTextSize(font, text)
	surface.SetFont(font)
	local w, h = surface.GetTextSize(text)

	return w, h
end

local adv_compass_tbl = {
	[0] = "N",
	[45] = "NE",
	[90] = "E",
	[135] = "SE",
	[180] = "S",
	[225] = "SW",
	[270] = "W",
	[315] = "NW",
	[360] = "N"
}

function PLUGIN:HUDPaint()
	local client = LocalPlayer()

	if (client:Team() != FACTION_OTA or !ix.option.Get("enableCompass", true)) then return end

	local ang = client:GetAngles()
	local compassX, compassY = ScrW() * 0.5, ScrH() * 0.05
	local width, height = ScrW() * 0.3, ScrH() * 0.03
	local cl_spacing = 2
	local ratio = 2.2
	local color = Color(255, 255, 255)
	local minMarkerSize = ScrH() * (0.5 / 45)
	local maxMarkerSize = ScrH() * (1 / 35)
	local offset = 0

	spacing = (width * cl_spacing) / 360
	numOfLines = width / spacing
	fadeDistMultiplier = 1
	fadeDistance = (width / 2) / fadeDistMultiplier

	compassBearingTextW, compassBearingTextH = GetTextSize("exo_compass_Numbers_" .. ratio, math.Round(360 - ((ang.y - offset) % 360)))

	for i = math.Round(-ang.y) % 360, (math.Round(-ang.y) % 360) + numOfLines do
		local x = ((compassX - (width / 2)) + (((i + ang.y) % 360) * spacing))
		local value = math.abs(x - compassX)
		local calc = 1 - ((value + (value - fadeDistance)) / (width / 2))
		local calculation = 255 * math.Clamp(calc, 0.001, 1)

		local i_offset = -(math.Round(i - offset - (numOfLines / 2))) % 360
		
		if (i_offset % 15 == 0 and i_offset >= 0) then
			local a = i_offset
			local text = adv_compass_tbl[360 - (a % 360)] and adv_compass_tbl[360 - (a % 360)] or 360 - (a % 360)
			local font = type(text) == "string" and "exo_compass_Letters" or "exo_compass_Numbers_" .. ratio
			local w, h = GetTextSize(font, text)
			local col = Color(color.r, color.g, color.b, calculation)

			surface.SetDrawColor(col)
			surface.SetTextColor(col)
			surface.SetFont(font)

			surface.SetDrawColor(col)
			surface.DrawLine(x, compassY, x, compassY + height * 0.5)

			surface.SetTextPos(x - w / 2, compassY + height * 0.55)
			surface.DrawText(text)

			surface.SetDrawColor(col)
			surface.DrawLine(x, compassY, x, compassY + height * 0.5)
		end

		if (i_offset % 5 == 0 and i_offset % 15 != 0) then
			surface.SetDrawColor(color)
			surface.DrawLine(x, compassY, x, compassY + height * 0.25)
		end
	end
	
	for _, player in ipairs(player.GetAll()) do
		if (client == player or (player:Team() != FACTION_CP and player:Team() != FACTION_OTA)) then continue end

		local spotPos = (player:GetPos())
		local d = client:GetPos():Distance(spotPos)
		local currentVar = 1 - (d / (300 / 0.01905)) -- Converting 300m to gmod units
		local markerScale = Lerp(currentVar, minMarkerSize, maxMarkerSize)
		local font = markerScaleFunc(markerScale)

		local yAng = ang.y - (spotPos - client:GetPos()):GetNormalized():Angle().y
		local markerSpot = math.Clamp(((compassX + (width / 2 * cl_spacing)) - (((-yAng - offset - 180) % 360) * spacing)), compassX - (width / 2), compassX + (width / 2))

		local markerColor = Color(255, 0, 0)

		if (player:Team() == FACTION_CP) then
			markerColor = Color(0, 100, 255)
		end
		
		if (client:GetNetVar("ProtectionTeam") and player:GetNetVar("ProtectionTeam") and client:GetNetVar("ProtectionTeam") == player:GetNetVar("ProtectionTeam")) then
			if (player:GetNetVar("ProtectionTeamOwner")) then
				markerColor = Color(255, 255, 0)
			else
				markerColor = Color(0, 175, 0)
			end
		end
		
		surface.SetMaterial(mat2)
		surface.SetDrawColor(markerColor)
		surface.DrawTexturedRect(markerSpot - markerScale/2, compassY - markerScale - markerScale/2, markerScale, markerScale)
	end

	-- Middle Triangle
	local triangleSize = 8
	local triangleHeight = compassY
	local triangle = {
		{x = compassX - triangleSize/2, y = triangleHeight - (triangleSize * 2)},
		{x = compassX + triangleSize/2, y = triangleHeight - (triangleSize * 2)},
		{x = compassX, y = triangleHeight - triangleSize},
	}

	surface.SetDrawColor(255, 255, 255)
	draw.NoTexture()
	surface.DrawPoly(triangle)

	local text = math.Round(-ang.y - offset) % 360
	local font = "exo_compass_Numbers_" .. ratio
	local w, h = GetTextSize(font, text)

	surface.SetFont(font)
	surface.SetTextColor(Color(255, 255, 255))
	surface.SetTextPos(compassX - w/2, compassY - h - (triangleSize * 2))
	surface.DrawText(text)
end
