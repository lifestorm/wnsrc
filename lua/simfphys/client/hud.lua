--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if not file.Exists( "includes/circles/circles.lua", "LUA" ) then return end

local circles = include("includes/circles/circles.lua")

local CircleMain
local CircleMainRed
local CircleRedLine

local screenw = ScrW()
local screenh = ScrH()
local Widescreen = (screenw / screenh) > (4 / 3)
local sizex = screenw * (Widescreen and 1 or 1.32)
local sizey = screenh
local xpos = sizex * 0.02
local ypos = sizey * 0.8
local x = xpos * (Widescreen and 43.5 or 32)
local y = ypos * 1.015
local radius = 0.085 * sizex
local startang = 105

local lights_on = Material( "simfphys/hud/low_beam_on" )
local lights_on2 = Material( "simfphys/hud/high_beam_on" )
local lights_off = Material( "simfphys/hud/low_beam_off" )
local fog_on = Material( "simfphys/hud/fog_light_on" )
local fog_off = Material( "simfphys/hud/fog_light_off" )
local cruise_on = Material( "simfphys/hud/cc_on" )
local cruise_off = Material( "simfphys/hud/cc_off" )
local hbrake_on = Material( "simfphys/hud/handbrake_on" )
local hbrake_off = Material( "simfphys/hud/handbrake_off" )
local HUD_1 = Material( "simfphys/hud/hud" )
local HUD_2 = Material( "simfphys/hud/hud_center" )
local HUD_3 = Material( "simfphys/hud/hud_center_red" )
local ForceSimpleHud = not file.Exists( "materials/simfphys/hud/hud.vmt", "GAME" ) -- lets check if the background material exists, if not we will force the old hud to prevent fps drop
local smHider = 0

local ShowHud = false
local ShowHud_ms = false
local AltHud = false
local Hudmph = false
local Hudmpg = false
local Hudreal = false
local hasCounterSteerEnabled = false
local slushbox = false
local hudoffset_x = 0
local hudoffset_y = 0

local turnmenu = KEY_COMMA

cvars.AddChangeCallback( "cl_simfphys_hud", function( convar, oldValue, newValue ) ShowHud = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_hud_offset_x", function( convar, oldValue, newValue ) hudoffset_x = newValue end)
cvars.AddChangeCallback( "cl_simfphys_hud_offset_y", function( convar, oldValue, newValue ) hudoffset_y = newValue end)
cvars.AddChangeCallback( "cl_simfphys_althud", function( convar, oldValue, newValue ) AltHud = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_hudmph", function( convar, oldValue, newValue ) Hudmph = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_hudmpg", function( convar, oldValue, newValue ) Hudmpg = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_hudrealspeed", function( convar, oldValue, newValue ) Hudreal = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_ctenable", function( convar, oldValue, newValue ) hasCounterSteerEnabled = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_auto", function( convar, oldValue, newValue ) slushbox = tonumber( newValue )~=0 end)
cvars.AddChangeCallback( "cl_simfphys_key_turnmenu", function( convar, oldValue, newValue ) turnmenu = tonumber( newValue ) end)

ShowHud = GetConVar( "cl_simfphys_hud" ):GetBool()
hudoffset_x = GetConVar( "cl_simfphys_hud_offset_x" ):GetFloat()
hudoffset_y = GetConVar( "cl_simfphys_hud_offset_y" ):GetFloat()
AltHud = GetConVar( "cl_simfphys_althud" ):GetBool()
Hudmph = GetConVar( "cl_simfphys_hudmph" ):GetBool()
Hudmpg = GetConVar( "cl_simfphys_hudmpg" ):GetBool()
Hudreal = GetConVar( "cl_simfphys_hudrealspeed" ):GetBool()
hasCounterSteerEnabled = GetConVar( "cl_simfphys_ctenable" ):GetBool()
slushbox = GetConVar( "cl_simfphys_auto" ):GetBool()
turnmenu = GetConVar( "cl_simfphys_key_turnmenu" ):GetInt()

local function DrawCircle( X, Y, radius )
	local segmentdist = 360 / ( 2 * math.pi * radius / 2 )
	
	for a = 0, 360 - segmentdist, segmentdist do
		surface.DrawLine( X + math.cos( math.rad( a ) ) * radius, Y - math.sin( math.rad( a ) ) * radius, X + math.cos( math.rad( a + segmentdist ) ) * radius, Y - math.sin( math.rad( a + segmentdist ) ) * radius )
	end
end

local sm_throttle = 0
local s_smoothrpm = 0

local function drawsimfphysHUD(vehicle)
	if not ShowHud then return end
	
	if vehicle:GetNWBool( "simfphys_NoHud", false ) then return end
	
	local maxrpm = vehicle:GetLimitRPM()
	local rpm = vehicle:GetRPM()
	local throttle = math.Round(vehicle:GetThrottle() * 100,0)
	local revlimiter = vehicle:GetRevlimiter() and (maxrpm > 2500) and (throttle > 0)
	
	local SimpleHudIsForced = vehicle:GetNWBool( "simfphys_NoRacingHud", false )
	
	local powerbandend = math.min(vehicle:GetPowerBandEnd(), maxrpm - 1)

	local redline = math.max(rpm - powerbandend,0) / (maxrpm - powerbandend)

	local Active = vehicle:GetActive() and "" or "!"
	local speed = vehicle:GetVelocity():Length()
	local mph = math.Round(speed * 0.0568182,0)
	local kmh = math.Round(speed * 0.09144,0)
	local wiremph = math.Round(speed * 0.0568182 * 0.75,0)
	local wirekmh = math.Round(speed * 0.09144 * 0.75,0)
	local cruisecontrol = vehicle:GetIsCruiseModeOn()
	local gear = vehicle:GetGear()
	local DrawGear = not slushbox and (gear == 1 and "R" or gear == 2 and "N" or (gear - 2)) or (gear == 1 and "R" or gear == 2 and "N" or "(".. (gear - 2)..")")
	
	local o_x = hudoffset_x * screenw
	local o_y = hudoffset_y * screenh
	
	local fuel = vehicle:GetFuel() / vehicle:GetMaxFuel()
	local fueltype = vehicle:GetFuelType()
	local fueltype_color = color_white

	if fueltype == FUELTYPE_ELECTRIC then
		fueltype_color = Color(0,127,255,150)

	elseif fueltype == FUELTYPE_PETROL then
		fueltype_color = Color(240,200,0,150)

	elseif fueltype == FUELTYPE_DIESEL then
		fueltype_color = Color(255,60,0,150)
	end

	if AltHud and not ForceSimpleHud and not SimpleHudIsForced then
		local LightsOn = vehicle:GetLightsEnabled()
		local LampsOn = vehicle:GetLampsEnabled()
		local FogLightsOn = vehicle:GetFogLightsEnabled()
		local HandBrakeOn = vehicle:GetHandBrakeEnabled()
		
		s_smoothrpm = s_smoothrpm or 0
		s_smoothrpm = math.Clamp(s_smoothrpm + (rpm - s_smoothrpm) * 0.3,0,maxrpm)
		
		local endang = startang + math.Round( (s_smoothrpm/maxrpm) * 255, 0)
		local c_ang = math.cos( math.rad(endang) )
		local s_ang = math.sin( math.rad(endang) )
		local ang_pend = startang + math.Round( (powerbandend / maxrpm) * 255, 0)
		local r_rpm = math.floor(maxrpm / 1000) * 1000
		local in_red = s_smoothrpm < powerbandend
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		
		local mat = LightsOn and (LampsOn and lights_on2 or lights_on) or lights_off
		surface.SetMaterial( mat )
		surface.DrawTexturedRect( x + radius * 1.15 + o_x, y - radius * 0.1 + o_y, sizex * 0.014, sizex * 0.014 )
		
		local mat = FogLightsOn and fog_on or fog_off
		surface.SetMaterial( mat )
		surface.DrawTexturedRect( x + radius * 1.12 + o_x, y - radius * 0.43 + o_y, sizex * 0.018, sizex * 0.018 )
		
		local mat = cruisecontrol and cruise_on or cruise_off
		surface.SetMaterial( mat )
		surface.DrawTexturedRect( x + radius * 1.11 + o_x, y - radius * 0.75 + o_y, sizex * 0.02, sizex * 0.02 )
		
		local mat = HandBrakeOn and hbrake_on or hbrake_off
		surface.SetMaterial( mat )
		surface.DrawTexturedRect( x + radius * 1.13 + o_x, y - radius * 1 + o_y, sizex * 0.018, sizex * 0.018 )
		
		
		surface.SetMaterial( HUD_1 )
		surface.DrawTexturedRect( x - radius + o_x, y - radius + 1 + o_y, radius * 2, radius * 2)
		
		surface.SetMaterial( in_red and HUD_2 or HUD_3 )
		surface.DrawTexturedRect( x - radius + o_x, y - radius + 1 + o_y, radius * 2, radius * 2)
		
		draw.NoTexture()

		if not CircleMain then
			CircleMain = circles.New(CIRCLE_OUTLINED, radius, 0, 0, radius / 6.66)
			CircleMain:SetColor( Color(255,255,255,150) )
		end
		CircleMain:SetX( x + o_x )
		CircleMain:SetY( y + o_y )
		CircleMain:SetStartAngle( startang  )
		CircleMain:SetEndAngle( math.min(endang,ang_pend) )
		CircleMain()

		if not CircleRedLine then
			CircleRedLine = circles.New(CIRCLE_OUTLINED, radius, 0, 0, radius / 6.66)
			CircleRedLine:SetColor( Color(120,0,0,230) )
		end
		CircleRedLine:SetX( x + o_x )
		CircleRedLine:SetY( y + o_y )
		CircleRedLine:SetStartAngle( ang_pend  )
		CircleRedLine:SetEndAngle( 360 )
		CircleRedLine()

		if not CircleMainRed then
			CircleMainRed = circles.New(CIRCLE_OUTLINED, radius, 0, 0, radius / 6.66)
			CircleMainRed:SetColor( Color(255,0,0,140) )
		end
		CircleMainRed:SetX( x + o_x )
		CircleMainRed:SetY( y + o_y )
		CircleMainRed:SetStartAngle( math.Round(ang_pend - 1,0)  )
		CircleMainRed:SetEndAngle( startang + (s_smoothrpm / maxrpm) * 255 )
		CircleMainRed()

		--draw.Arc(x + o_x,y + o_y,radius,radius / 6.66,startang,math.min(endang,ang_pend),1,Color(255,255,255,150),true)
		--draw.Arc(x + o_x,y + o_y,radius,radius / 6.66,ang_pend,360,1,Color(120,0,0,230),true)
		--draw.Arc(x + o_x,y + o_y,radius,radius / 6.66,math.Round(ang_pend - 1,0),startang + (s_smoothrpm / maxrpm) * 255,1,Color(255,0,0,140),true)
		--draw.Arc(x + o_x,y + o_y,radius / 3.5,radius / 66,startang,360,15,Color(255,255,255,50),true)
		--draw.Arc(x + o_x,y + o_y,radius,radius / 6.66,startang,ang_pend,1,Color(150,150,150,50),true)
		--draw.Arc(x + o_x,y + o_y,radius / 5,radius / 70,0,360,15,center_ncol,true)

		local step = 0
		for i = 0,maxrpm,250 do
			step = step + 1
			
			local anglestep = (255 / maxrpm) * i
			
			local n_col_on
			local n_col_off
			if (i < powerbandend) then
				n_col_off = Color(150, 150, 150, 150)
				n_col_on = Color(255, 255, 255, 255)
			else
				n_col_off = Color( 150, 0, 0, 150)
				n_col_on = Color( 255, 0, 0, 255 )
			end
			local u_col = (s_smoothrpm > i) and n_col_on or n_col_off
			surface.SetDrawColor( u_col )
			
			local cos_a = math.cos( math.rad(startang + anglestep) )
			local sin_a = math.sin( math.rad(startang + anglestep) )
			
			if step > 4 then
				step = 1
				surface.DrawLine( x + cos_a * radius / 1.3 + o_x, y + sin_a * radius / 1.3 + o_y, x + cos_a * radius + o_x, y + sin_a * radius + o_y)
				local printnumber = tostring(i / 1000)
				draw.SimpleText(printnumber, "simfphysfont3", x + cos_a * radius / 1.5 + o_x, y + sin_a * radius / 1.5 + o_y,u_col, 1, 1 )
			else
				surface.DrawLine( x + cos_a * radius / 1.05 + o_x, y + sin_a * radius / 1.05 + o_y, x + cos_a * radius + o_x, y + sin_a * radius + o_y)
			end
		end
		
		local center_ncol = in_red and Color(0,254,235,200) or Color( 255, 0, 0, 255 )
		
		surface.SetDrawColor( in_red and Color(255,255,255,255) or Color( 255, 0, 0, 255 ) )
		surface.DrawLine( x + c_ang * radius / 3.5 + o_x, y + s_ang * radius / 3.5 + o_y, x + c_ang * radius + o_x, y + s_ang * radius + o_y)
		surface.SetDrawColor( 255, 255, 255, 255 )
		
		draw.SimpleText( (gear == 1 and "R" or gear == 2 and "N" or (gear - 2)), "simfphysfont2", x * 0.999 + o_x, y * 0.996 + o_y, center_ncol, 1, 1 )
		
		local print_text = Hudmph and "MPH" or "KM/H"
		draw.SimpleText( print_text, "simfphysfont3", x + radius * 0.82 + o_x, y + radius * 0.16 + o_y, Color(255,255,255,50), 1, 1 )
		
		local printspeed = Hudmph and (Hudreal and mph or wiremph) or (Hudreal and kmh or wirekmh)
		
		local digit_1  =  printspeed % 10
		local digit_2 =  (printspeed - digit_1) % 100
		local digit_3  = (printspeed - digit_1 - digit_2) % 1000
		
		local col_on = Color(150,150,150,50)
		local col_off = Color(255,255,255,150)
		local col1 = (printspeed > 0) and col_off or col_on
		local col2 = (printspeed >= 10) and col_off or col_on
		local col3 = (printspeed >= 100) and col_off or col_on
		
		draw.SimpleText( digit_1, "simfphysfont4", x + radius * 0.84 + o_x, y + radius * 0.65 + o_y, col1, 1, 1 )
		draw.SimpleText( digit_2/ 10, "simfphysfont4", x + radius * 0.48 + o_x, y + radius * 0.65 + o_y, col2, 1, 1 )
		draw.SimpleText( digit_3 / 100, "simfphysfont4", x + radius * 0.12 + o_x, y + radius * 0.65 +  o_y, col3, 1, 1 )
		
		sm_throttle = sm_throttle + (throttle - sm_throttle) * 0.1
		local t_size = (sizey * 0.1)
		surface.SetDrawColor( Color(150,150,150,50) )
		surface.DrawRect( x + radius * 1.22 + o_x, y + radius * 0.36 + o_y, radius * 0.08, sizey * 0.1 )
		surface.SetDrawColor( Color(255,255,255,150) )
		surface.DrawRect( x + radius * 1.22 + o_x, y + radius * 0.36 + t_size - t_size * math.min(sm_throttle / 100,1) + o_y, radius * 0.08, t_size * math.min(sm_throttle / 100,1) )
		
		local fueluse = vehicle:GetFuelUse()
		
		if fueluse == -1 then return end
		
		local r = math.Round( radius, 0)
		surface.SetDrawColor( Color(150,150,150,50) )
		surface.DrawRect( x + o_x + r * fuel, y + o_y + r, r * (1 - fuel), r * 0.04 )
		surface.DrawLine( x + o_x - r * 0.85, y + o_y + r * 1.04 - 2, x + o_x, y + o_y + r * 1.04 - 2)
		
		surface.SetDrawColor( fueltype_color )
		surface.DrawRect( x + o_x, y + o_y + r, r * fuel, r * 0.04 )

		if fueltype ~= FUELTYPE_PETROL and fueltype ~= FUELTYPE_DIESEL then return end
	
		local ecospeed = (Hudreal and kmh or wirekmh)
		local calc_fueluse = (100 / ecospeed) * fueluse * 60
		if Hudmpg then
			calc_fueluse = 235.214 / calc_fueluse
		end
		local print_fueluse = (ecospeed > 0 and vehicle:GetFuel() > 0) and tostring( math.Round( calc_fueluse,0) ) or "N/A"
		--draw.SimpleText( tostring( math.Round( fueluse,2) ).." L/min", "simfphysfont3", x + o_x + radius, y + o_y + radius * 1.04, Color(150,150,150,150), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
		draw.SimpleText( print_fueluse, "simfphysfont3", x + o_x - radius * 0.85, y + o_y + radius * 0.85, Color(150,150,150,150), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		draw.SimpleText( Hudmpg and "MPG" or "L/100KM", "simfphysfont3", x + o_x - radius * 0.85, y + o_y + radius * 1.02, Color(150,150,150,150), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		
		return
	end
	
	local s_xpos = xpos
	local s_ypos = ypos
	local Col = color_white
	
	if SimpleHudIsForced then
		o_x = 0
		o_y = 0
		s_xpos = screenw * 0.5 - sizex * 0.115 - sizex * 0.032
		s_ypos = screenh - sizey * 0.092 - sizey * 0.02
	end

	if cruisecontrol then
		draw.SimpleText( "cruise", "simfphysfont", s_xpos + sizex * 0.115 + o_x, s_ypos + sizey * 0.035 + o_y, Color( 255, 127, 0, 255 ), 2, 1 )
	end

	draw.SimpleText( "Throttle: "..throttle.." %", "simfphysfont", s_xpos + o_x, s_ypos + sizey * 0.035 + o_y, Col, 0, 1)

	local ColRPM = Color( 255, 255 * (1 - redline), 255 * (1 - redline), 255 )

	draw.SimpleText( "RPM: "..math.Round(rpm,0)..Active, "simfphysfont", s_xpos + o_x, s_ypos + sizey * 0.012 + o_y, ColRPM, 0, 1 )
	
	draw.SimpleText( "GEAR:", "simfphysfont", s_xpos + sizex * 0.062 + o_x, s_ypos + sizey * 0.012 + o_y, Col, 0, 1 )
	draw.SimpleText( DrawGear, "simfphysfont", s_xpos + sizex * 0.11 + o_x, s_ypos + sizey * 0.012 + o_y, Col, 2, 1 )
	
	draw.SimpleText( (Hudreal and mph or wiremph).." mph", "simfphysfont", s_xpos + o_x, s_ypos + sizey * 0.062 + o_y, Col, 0, 1 )
	
	draw.SimpleText( (Hudreal and kmh or wirekmh).." kmh", "simfphysfont", s_xpos + sizex * 0.11 + o_x, s_ypos + sizey * 0.062 + o_y, Col, 2, 1 )

	local fueluse = vehicle:GetFuelUse()
	if fueluse == -1 then return end

	local r = math.Round(sizey * 0.075,0)
	surface.SetDrawColor( Color(0,0,0,80) )
	surface.DrawRect( s_xpos + o_x - sizex * 0.007, s_ypos + o_y, sizex * 0.0025, r * (1 - fuel) )
	surface.SetDrawColor( fueltype_color )
	surface.DrawRect( s_xpos + o_x - sizex * 0.007, s_ypos + o_y + r * (1 - fuel), sizex * 0.0025, r * fuel )
end

local turnmode = 0
local turnmenu_wasopen = false

local function drawTurnMenu( vehicle )
	
	if input.IsKeyDown( GetConVar( "cl_simfphys_keyforward" ):GetInt() ) or  input.IsKeyDown( GetConVar( "cl_simfphys_key_air_forward" ):GetInt() ) then
		turnmode = 0
	end
	
	if input.IsKeyDown( GetConVar( "cl_simfphys_keyleft" ):GetInt() ) or input.IsKeyDown( GetConVar( "cl_simfphys_key_air_left" ):GetInt() ) then
		turnmode = 2
	end
	
	if input.IsKeyDown( GetConVar( "cl_simfphys_keyright" ):GetInt() ) or input.IsKeyDown( GetConVar( "cl_simfphys_key_air_right" ):GetInt() ) then
		turnmode = 3
	end
	
	if input.IsKeyDown( GetConVar( "cl_simfphys_keyreverse" ):GetInt() ) or input.IsKeyDown( GetConVar( "cl_simfphys_key_air_reverse" ):GetInt() ) then
		turnmode = 1
	end
	
	local cX = ScrW() / 2
	local cY = ScrH() / 2
	
	local sx = sizex * 0.065
	local sy = sizex * 0.065
	
	local selectorX = (turnmode == 2 and (-sx - 1) or 0) + (turnmode == 3 and (sx + 1) or 0)
	local selectorY = (turnmode == 0 and (-sy - 1) or 0)
	
	draw.RoundedBox( 8, cX - sx * 0.5 - 1 + selectorX, cY - sy * 0.5 - 1 + selectorY, sx + 2, sy + 2, Color( 240, 200, 0, 255 ) )
	draw.RoundedBox( 8, cX - sx * 0.5 + selectorX, cY - sy * 0.5 + selectorY, sx, sy, Color( 50, 50, 50, 255 ) )
	
	draw.RoundedBox( 8, cX - sx * 0.5, cY - sy * 0.5, sx, sy, Color( 0, 0, 0, 100 ) )
	draw.RoundedBox( 8, cX - sx * 0.5, cY - sy * 1.5 - 1, sx, sy, Color( 0, 0, 0, 100 ) )
	draw.RoundedBox( 8, cX - sx * 1.5 - 1, cY - sy * 0.5, sx, sy, Color( 0, 0, 0, 100 ) )
	draw.RoundedBox( 8, cX + sx * 0.5 + 1, cY - sy * 0.5, sx, sy, Color( 0, 0, 0, 100 ) )
	
	surface.SetDrawColor( 240, 200, 0, 100 ) 
	--X
	if turnmode == 0 then
		surface.SetDrawColor( 240, 200, 0, 255 ) 
	end
	surface.DrawLine( cX - sx * 0.3, cY - sy - sy * 0.3, cX + sx * 0.3, cY - sy + sy * 0.3 )
	surface.DrawLine( cX + sx * 0.3, cY - sy - sy * 0.3, cX - sx * 0.3, cY - sy + sy * 0.3 )
	surface.SetDrawColor( 240, 200, 0, 100 ) 
	
	-- <=
	if turnmode == 2 then
		surface.SetDrawColor( 240, 200, 0, 255 ) 
	end
	surface.DrawLine( cX - sx + sx * 0.3, cY - sy * 0.15, cX - sx + sx * 0.3, cY + sy * 0.15 )
	surface.DrawLine( cX - sx + sx * 0.3, cY + sy * 0.15, cX - sx, cY + sy * 0.15 )
	surface.DrawLine( cX - sx + sx * 0.3, cY - sy * 0.15, cX - sx, cY - sy * 0.15 )
	surface.DrawLine( cX - sx, cY - sy * 0.3, cX - sx, cY - sy * 0.15 )
	surface.DrawLine( cX - sx, cY + sy * 0.3, cX - sx, cY + sy * 0.15 )
	surface.DrawLine( cX - sx, cY + sy * 0.3, cX - sx - sx * 0.3, cY )
	surface.DrawLine( cX - sx, cY - sy * 0.3, cX - sx - sx * 0.3, cY )
	surface.SetDrawColor( 240, 200, 0, 100 ) 
	
	-- =>
	if turnmode == 3 then
		surface.SetDrawColor( 240, 200, 0, 255 ) 
	end
	surface.DrawLine( cX + sx - sx * 0.3, cY - sy * 0.15, cX + sx - sx * 0.3, cY + sy * 0.15 )
	surface.DrawLine( cX + sx - sx * 0.3, cY + sy * 0.15, cX + sx, cY + sy * 0.15 )
	surface.DrawLine( cX + sx - sx * 0.3, cY - sy * 0.15, cX + sx, cY - sy * 0.15 )
	surface.DrawLine( cX + sx, cY - sy * 0.3, cX + sx, cY - sy * 0.15 )
	surface.DrawLine( cX + sx, cY + sy * 0.3, cX + sx, cY + sy * 0.15 )
	surface.DrawLine( cX + sx, cY + sy * 0.3, cX + sx + sx * 0.3, cY )
	surface.DrawLine( cX + sx, cY - sy * 0.3, cX + sx + sx * 0.3, cY )
	surface.SetDrawColor( 240, 200, 0, 100 ) 
	
	-- ^
	if turnmode == 1 then
		surface.SetDrawColor( 240, 200, 0, 255 ) 
	end
	surface.DrawLine( cX, cY - sy * 0.4, cX + sx * 0.4, cY + sy * 0.3 )
	surface.DrawLine( cX, cY - sy * 0.4, cX - sx * 0.4, cY + sy * 0.3 )
	surface.DrawLine( cX + sx * 0.4, cY + sy * 0.3, cX - sx * 0.4, cY + sy * 0.3 )
	surface.DrawLine( cX, cY - sy * 0.26, cX + sx * 0.3, cY + sy * 0.24 )
	surface.DrawLine( cX, cY - sy * 0.26, cX - sx * 0.3, cY + sy * 0.24 )
	surface.DrawLine( cX + sx * 0.3, cY + sy * 0.24, cX - sx * 0.3, cY + sy * 0.24 )
	
	surface.SetDrawColor( 255, 255, 255, 255 ) 
end

hook.Add( "HUDPaint", "simfphys_HUD", function()
	local ply = LocalPlayer()
	local turnmenu_isopen = false
	
	if not IsValid( ply ) or not ply:Alive() then turnmenu_wasopen = false return end

	local vehicle = ply:GetVehicle()
	local vehiclebase = ply:GetSimfphys()
	
	if not IsValid( vehicle ) or not IsValid( vehiclebase ) then 
		ply.oldPassengersmf = {}
		
		turnmenu_wasopen = false
		smHider = 0
		return
	end

	if not ply:IsDrivingSimfphys() then turnmenu_wasopen = false return end
	
	drawsimfphysHUD( vehiclebase )
	
	if vehiclebase.HasTurnSignals and input.IsKeyDown( turnmenu ) then
		turnmenu_isopen = true
		
		drawTurnMenu( vehiclebase )
	end
	
	if turnmenu_isopen ~= turnmenu_wasopen then
		turnmenu_wasopen = turnmenu_isopen
		
		if turnmenu_isopen then
			turnmode = 0
		else			
			net.Start( "simfphys_turnsignal" )
				net.WriteEntity( vehiclebase )
				net.WriteInt( turnmode, 32 )
			net.SendToServer()
			
			if turnmode == 1 or turnmode == 2 or turnmode == 3 then
				vehiclebase:EmitSound( "simulated_vehicles/sfx/turnsignal_start.ogg" )
			else
				vehiclebase:EmitSound( "simulated_vehicles/sfx/turnsignal_end.ogg" )
			end
		end
	end
end)

local bgcol = Color(120,120,120,255)
local framecol = Color(0,0,0,255)
local textcol = Color(210,210,210,255)

hook.Add("HUDPaint", "simfphys_vehicleditorinfo", function()
	local ply = LocalPlayer()
	
	if ply:InVehicle() then return end
	
	local wep = ply:GetActiveWeapon()
	if not IsValid( wep ) or wep:GetClass() ~= "gmod_tool" or ply:GetInfo("gmod_toolmode") ~= "simfphyseditor" then return end

	local trace = ply:GetEyeTrace()
	
	local Ent = trace.Entity
	
	if not simfphys.IsCar( Ent ) then return end
	
	local vInfo = Ent:GetVehicleInfo()
	
	if not istable( vInfo ) or not vInfo["maxspeed"] or not vInfo["horsepower"] or not vInfo["weight"] or not vInfo["torque"] then return end
	
	local SpeedMul = Hudmph and (Hudreal and 0.0568182 or 0.0568182 * 0.75) or (Hudreal and 0.09144 or 0.09144 * 0.75)
	local SpeedSuffix = Hudmph and "mph" or "km/h"
	local toSize = Hudreal and (1/0.75) or 1
	local nameSize = Hudreal and "\n\nNote: values are based on playersize" or ""
	local TopSpeed = math.Round( vInfo["maxspeed"] * SpeedMul )
	local HP = math.Round( vInfo["horsepower"] * toSize )
	local Weight = math.Round( vInfo["weight"] )
	local PowerToWeight = math.Round(Weight / HP,1)
	local PeakTorque = math.Round( vInfo["torque"] * toSize )
	
	local text = "Peak Power: "..HP.." HP".."\nPeak Torque: "..PeakTorque.." Nm\nTop Speed: "..tostring( TopSpeed )..SpeedSuffix.." (theoretical max)".."\nWeight: "..Weight.." kg ("..PowerToWeight.." kg / HP)"..nameSize

	local pos = Ent:LocalToWorld( Ent:OBBCenter() ):ToScreen()

	local x = 0
	local y = 0
	local padding = 10
	local offset = 50
	
	surface.SetFont( "simfphysworldtip" )
	local w, h = surface.GetTextSize( text )
	
	x = pos.x - w 
	y = pos.y - h 
	
	x = x - offset
	y = y - offset

	draw.RoundedBox( 8, x-padding-2, y-padding-2, w+padding*2+4, h+padding*2+4, framecol )
	
	
	local verts = {}
	verts[1] = { x=x+w/1.5-2, y=y+h+2 }
	verts[2] = { x=x+w+2, y=y+h/2-1 }
	verts[3] = { x=pos.x-offset/2+2, y=pos.y-offset/2+2 }

	draw.NoTexture()
	surface.SetDrawColor( framecol )
	surface.DrawPoly( verts )
	
	
	draw.RoundedBox( 8, x-padding, y-padding, w+padding*2, h+padding*2, bgcol )
	
	local verts = {}
	verts[1] = { x=x+w/1.5, y=y+h }
	verts[2] = { x=x+w, y=y+h/2 }
	verts[3] = { x=pos.x-offset/2, y=pos.y-offset/2 }
	
	draw.NoTexture()
	surface.SetDrawColor( bgcol )
	surface.DrawPoly( verts )
	
	
	draw.DrawText( text, "simfphysworldtip", x + w/2, y, textcol, TEXT_ALIGN_CENTER )
end)

