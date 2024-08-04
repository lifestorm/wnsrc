--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- ZAPC
-- Copyright (c) 2012 Zaubermuffin
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-- Local > global!
local Color = Color
local surface = surface
local draw = draw
local LocalPlayer = LocalPlayer
local math = math
local IsValid = IsValid
local util = util
local render = render
local TimedSin = TimedSin
local Lerp = Lerp

include('shared.lua')

-- CC
local ZAPC_VIEW_UNRELATED, ZAPC_VIEW_DRIVER, ZAPC_VIEW_GUNNER, ZAPC_VIEW_PASSENGER = ZAPC_VIEW_UNRELATED, ZAPC_VIEW_DRIVER, ZAPC_VIEW_GUNNER, ZAPC_VIEW_PASSENGER
local ZAPC_MAX_HEALTH = ZAPC_MAX_HEALTH
local ZAPC_PRIMARY_RELOAD_TIME, ZAPC_SECONDARY_RELOAD_TIME = ZAPC_PRIMARY_RELOAD_TIME, ZAPC_SECONDARY_RELOAD_TIME
local ZAPC_MAX_PASSENGERS = ZAPC_MAX_PASSENGERS

local ZAPC_HUD_OKAY = Color(8, 91, 181, 255) --Color(44, 110, 235, 255) -- full health
local ZAPC_HUD_OKAY_BG = Color(149, 214, 243, 80)
local ZAPC_HUD_NOT_OKAY = Color(227, 0, 0, 255) -- absolutely dead
local ZAPC_HUD_NOT_OKAY_BG = Color(120, 0, 0, 120)

local ZAPC_HUD_HEALTH_FLASH_TIME = 0.5 -- seconds the interface flashes red after you were hit.
local ZAPC_HUD_BULLET_WARNING_FLASH_FREQ = 1.5 -- the smaller the slower.
local ZAPC_MIN_ZOOM = 75 -- FOV when unzoomed
local ZAPC_MAX_ZOOM = 25 -- FOV when zoomed
local ZAPC_ZOOM_RATE = 2.5 -- FOV/Tick

-- Get rid of them.
for k, v in pairs(_G) do
	if type(k) == 'string' and k:find('^ZAPC_') then
		_G[k] = nil
	end
end

-- Are we somehow related to the APC?
local ViewMode = 0
-- The APC
local ZAPC = nil
-- Driver, gunner, passengers
local Driver, Gunner, Passengers = nil, nil, {}
-- Bullets we have and the last reload actions
local Bullets, LastPrimary, LastSecondary, NextPrimary, NextSecondary = 0, 0, 0, 0, 0
-- Health of the APC
local Health = 0
-- Last time we were hit by something.
local LastHealthLoss = 0
-- OH GOD
local Destructing = false
-- Hatch
local HatchOpened = false
-- The last velocity we had - to avoid that the user interface is whopping around too badly, we're cheating a little.
local lastVel = 0

-- Our "zoom" status.
local Zoom = 75

-- The viewmode. This used to be gmod_vehicle_viewmode but got dropped in a "recent" update.
-- Since we still want this to be possible, I'll re-add it.
local viewmode = CreateClientConVar('zapc_viewmode', 1, true, false)

-- Create the fonts.
-- For whatever reason Garry decided it was a sweet idea to make Trebuchet24/18 additive in GM13. :|
surface.CreateFont("ZAPC_HUD",
{
	font		= "Trebuchet MS",
	size		= 24,
	antialias	= true,
	weight		= 600
})

surface.CreateFont("ZAPC_HUDSmall",
{
	font		= "Trebuchet MS",
	size		= 18,
	antialias	= true,
	weight		= 600
})

local function LimitPitch(ang)
	return math.Clamp(ang, -45, 45)
end

local function ProcessAngle(ang)
	local apcAngles = ZAPC:GetAngles()
	ang.pitch = LimitPitch(math.NormalizeAngle(ang.pitch - apcAngles.pitch))
	ang.yaw = math.NormalizeAngle(ang.yaw + apcAngles.yaw + 180)
	ang.roll = math.NormalizeAngle(ang.roll)
	return ang
end

local function CalcView(ply, origin, angles, fov)
	-- unrelated or unknown APC.
	if not IsValid(ZAPC) or ViewMode == ZAPC_VIEW_UNRELATED then
		return
	end
	
	-- Gunner.
	if ViewMode == ZAPC_VIEW_GUNNER then
		-- Get the attachment.
		local att = ZAPC:GetAttachment(ZAPC:LookupAttachment('gun_def'))
		-- In case att doesn't exist...
		if not att then
			return
		end

		local trace = util.TraceLine({ start = att.Pos, endpos = att.Pos + att.Ang:Up()*5, mask = MASK_SOLID_BRUSHONLY})
		local view = {}
		view.origin = trace.HitPos
		if viewmode:GetInt() == 1 then
			view.angles = ProcessAngle(LocalPlayer():EyeAngles())
		else
			view.angles = att.Ang
		end
		view.fov = Zoom
		return view
	elseif ViewMode == ZAPC_VIEW_DRIVER or ViewMode == ZAPC_VIEW_PASSENGER then
		-- The next line is a lie.
		angles = LocalPlayer():EyeAngles()
		
		local view = {}
		-- Third person
		if viewmode:GetInt() ==  1 or ViewMode == ZAPC_VIEW_PASSENGER then
			-- This seems to be 25/35 all the time since a few updates (for whatever reason)
			angles.pitch = 25
			-- This should always be zero.
			angles.roll = 0
		
			-- If we fuck up, hardcore.
			if tostring(angles.yaw):find('#', 1, true) then
				angles.yaw = ZAPC:GetAngles().yaw+90
				-- Try to "fix" it ourselves...
				LocalPlayer():SetEyeAngles(angles)
			end
		
			local trace = util.TraceLine({ start = origin + ZAPC:GetUp()*5, endpos = origin - angles:Forward() * 350, mask = MASK_SOLID_BRUSHONLY })
			view = {}
			view.origin = trace.HitPos + trace.HitNormal * 5
			view.angles = angles
			view.fov = fov
		-- First person
		else
			view = { origin = ZAPC:GetPos()+ZAPC:GetUp()*50-ZAPC:GetRight()*100, angles = (-ZAPC:GetRight()):Angle(), fov = 90 }
		end
		return view		
	end
end
hook.Add('CalcView', '_ZAPC.CalcView', CalcView)

-- UI
-- Returns a table to be used with draw.TexturedQuad when working with fixed stuff.
-- Let's call it SPRITE.
local function TexTable(fileName, _color, _x, _y, _w, _h)
	local m, w, h = Material(fileName)
	local tbl = { material = Material(fileName), color = _color, x = _x, y = _y, w = _w, h = _h }
	return tbl
end

-- Draws the texture table.
local function DrawMaterial(tbl, overrideX, overrideY)
	surface.SetMaterial(tbl.material)
	surface.DrawTexturedRect(overrideX and overrideX or tbl.x, overrideY and overrideY or tbl.y, tbl.w, tbl.h)
end

-- Textures we are going to use.
local CHAIR_GUNNER_TABLE = TexTable('zapc_hud/seat_gunner.png', nil, 10, 20, 64, 64)
local CHAIR_DRIVER_TABLE = TexTable('zapc_hud/seat_driver.png', nil, 42, 80, 64, 64)
local CHAIR_PASSENGER_TABLE = TexTable('zapc_hud/seat.png', nil, 10, 140, 64, 64)

local SHELL_TABLE = TexTable('zapc_hud/rocket.png', nil, -30, ScrH() - 190, 128, 128)
local CROSSHAIR_TABLE = TexTable('zapc_hud/crosshair.png', nil, ScrW()/2 - 32, ScrH()/2 - 32, 128, 128)

-- Returns the name of somebody.
local function Nick(ply)
	return IsValid(ply) and ((ply.GetCharacterName and ply:GetCharacterName()) or (ply.GetRPName and ply:GetRPName()) or ply:Nick()) or '(Empty)'
end

-- Draws.. a box.
local function DrawBox(x, y, w, h, color)
	surface.SetDrawColor(color.r, color.g, color.b, color.a)
	surface.DrawRect(x, y, w, h)
end

-- baboom.
local function LerpColor(fract, from, to)
	return Color(to.r - (to.r-from.r)*fract, to.g - (to.g-from.g)*fract, to.b - (to.b-from.b)*fract, to.a-(to.a-from.a)*fract)
end


-- "Temporary" helper function.
local function MaxTextSize(currentWidth, currentHeight, text, x, y)
	local w, h = surface.GetTextSize(text)
	x, y = x or 0, y or 0
	if currentWidth < w + x then
		currentWidth = w + x
	end
	
	if currentHeight < h + y then
		currentHeight = h + y
	end
	
	return currentWidth, currentHeight
end

-- woop woop woop woooop
local function HUDPaint()
	if not IsValid(ZAPC) or ViewMode == ZAPC_VIEW_UNRELATED then
		return
	end
	
	-- The prisoner one is easy!
	if ViewMode == ZAPC_VIEW_PASSENGER then
		if not HatchOpened then
			draw.SimpleText('You are inside the APC. The hatch was locked.', 'ZAPC_HUD', ScrW()/2, ScrH()/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		return
	end
	
	-- The color we draw stuff in. TODO: Change this to some fancy fading.
	local healthFraction = math.Clamp(math.TimeFraction(0, ZAPC_MAX_HEALTH(), Health), 0, 1)
	-- If we are destructing, we're using SINUS instead!
	local Bullets, NextPrimary, NextSecondary = Bullets, NextPrimary, NextSecondary
	local velocity = (7*lastVel + math.min(1, math.TimeFraction(0, 650, ZAPC:GetVelocity():Length()))) / 8 -- abuse of TimeFraction, sue me
	lastVel = velocity

	if Destructing then
		healthFraction = math.sin(CurTime()*5)/2 + 0.5
		Bullets = math.floor(math.sin(CurTime()*3)*25 + 25)
		NextPrimary = CurTime() - ZAPC_PRIMARY_RELOAD_TIME()*(math.sin(CurTime()*6)/2+0.5)
		NextSecondary = CurTime() - ZAPC_SECONDARY_RELOAD_TIME()*(math.sin(CurTime()*5)/2+0.5)
		velocity = math.sin(CurTime()*10)/2 + 0.5
		HatchOpened = math.sin(CurTime()*30)/4 > 0
	end
	

	local colorFrac = healthFraction - math.Clamp(1-math.TimeFraction(LastHealthLoss, LastHealthLoss + ZAPC_HUD_HEALTH_FLASH_TIME, CurTime()), 0, healthFraction)
	local color = LerpColor(colorFrac, ZAPC_HUD_OKAY, ZAPC_HUD_NOT_OKAY)
	local bgColor = LerpColor(colorFrac, ZAPC_HUD_OKAY_BG, ZAPC_HUD_NOT_OKAY_BG)
	
	-- Some constants, move them out later
	local gunnerTextX, gunnerTextY = 80, 40
	local driverTextX, driverTextY = 112, 100
	local hatchTextX, hatchTextY = 75, 170
	
	-- Get the size of the box. As of now, no fancy resizing effect.
	-- Gunner
	surface.SetFont('ZAPC_HUD')
	local boxX, boxY = 5, 15
	boxW, boxH = 205 + boxX, 195 + boxY -- minimum box size
	boxW, boxH = MaxTextSize(boxW, boxH, Nick(Gunner), gunnerTextX, gunnerTextY)
	-- Driver
	boxW, boxH = MaxTextSize(boxW, boxH, Nick(Driver), driverTextX, driverTextY)
	
	-- Any passenger we might have
	surface.SetFont('ZAPC_HUDSmall')
	for k, v in pairs(Passengers) do
		boxW, boxH = MaxTextSize(boxW, boxH, Nick(v), 75, 170 + k*22)
	end
	
	-- For the main interface.
	draw.RoundedBoxEx(8, boxX, boxY, boxW - boxX + 5, boxH - boxY + 5, bgColor, true, true, true, true)
	-- The bottom-left
	draw.RoundedBoxEx(8, 5, ScrH() - 195, 105, 175, bgColor, true, true, true, false)
	draw.RoundedBoxEx(8, 110, ScrH() - 70, 450, 50, bgColor, false, true, false, true)
	-- And the right one
	draw.RoundedBoxEx(8, ScrW() - 75, 8, 70, ScrH() - 16, bgColor, true, true, true, true)
	
	-- Set the surface color.
	surface.SetDrawColor(color)
	
	-- Draw the seats.
	DrawMaterial(CHAIR_PASSENGER_TABLE)
	DrawMaterial(CHAIR_GUNNER_TABLE)
	DrawMaterial(CHAIR_DRIVER_TABLE)
	
	-- The names for those.
	draw.SimpleText(Nick(Gunner), 'ZAPC_HUD', gunnerTextX, gunnerTextY, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.SimpleText(Nick(Driver), 'ZAPC_HUD', driverTextX, driverTextY, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	for k, v in pairs(Passengers) do
		draw.SimpleText(Nick(v), 'ZAPC_HUDSmall', 75, 170 + k*22, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	-- Draw the status
	draw.SimpleText('Hatch ' .. (HatchOpened and 'opened' or 'locked'), 'ZAPC_HUD', hatchTextX, hatchTextY, HatchOpened and ZAPC_HUD_NOT_OKAY or color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	-- Bullets.
	local x, y = 20, ScrH() - 50

	local bulletColor = Color(color.r, color.g, color.b, color.a)
	local da = 0
	
	if Bullets == 0 then
		bulletColor = Color(color.r, color.g, color.b, 0)
	elseif Bullets <= 20 then
		bulletColor = LerpColor(math.Clamp(math.TimeFraction(10, 20, Bullets), 0, 1),  color, ZAPC_HUD_NOT_OKAY)
		da = TimedSin(ZAPC_HUD_BULLET_WARNING_FLASH_FREQ * (1.2-math.TimeFraction(1, 20, Bullets)), 0, 25, 0)*2 + -25 -- don't call your god damn parameters "min" and "max" if you aren't going to stick to it
	end
	
	local bulletTextColor = Color(bulletColor.r, bulletColor.g, bulletColor.b, bulletColor.a > 0 and (bulletColor.a + da) or 255) -- If we're reloading, just use full transparency.
	
	for i = 1, 50 do
		bulletColor.a = ((i <= Bullets and 255) or 120) + da
		draw.RoundedBoxEx(4, x, y, 8, 12, bulletColor, true, true, false, false)
		x = x + 10
	end
	
	draw.SimpleText(tostring(Bullets), 'ZAPC_HUD', 525, ScrH() - 30, bulletTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	
	-- The reloading bar.
	local reloadProgress = math.min(math.TimeFraction(LastPrimary, NextPrimary, CurTime()), 1.0)
	DrawBox(20, ScrH() - 35, Lerp(reloadProgress, 0, 500), 5, bulletTextColor)
	
	reloadProgress = math.min(math.TimeFraction(LastSecondary, NextSecondary, CurTime()), 1.0)
	
	local reloadColor = LerpColor(reloadProgress, color, ZAPC_HUD_NOT_OKAY)
	surface.SetDrawColor(reloadColor)
	-- Not using that weird, ugly thing that was in the old APC. Clipping for teh win.
	render.SetScissorRect(SHELL_TABLE.x, SHELL_TABLE.y + SHELL_TABLE.h * (1-reloadProgress), SHELL_TABLE.x + SHELL_TABLE.w, SHELL_TABLE.y + SHELL_TABLE.h, true)
	DrawMaterial(SHELL_TABLE)
	render.SetScissorRect(0, 0, 0, 0, false)
	
	draw.SimpleText(tostring(math.floor(reloadProgress * 100)) .. '%', 'ZAPC_HUD', 50, ScrH() - 73, reloadColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	-- Velocity
	local vel = Lerp(velocity, 0, ScrH()-30)
	DrawBox(ScrW() - 30, ScrH() - 15 - vel, 15, vel, color)
	
	-- Health
	local hbar = Lerp(healthFraction, 0, ScrH() - 30)
	DrawBox(ScrW() - 65, ScrH() - 15 - hbar, 25, hbar, color)
	
	-- Crossbar, if gunner
	if ViewMode == ZAPC_VIEW_GUNNER then
		local attach = ZAPC:GetAttachment(ZAPC:LookupAttachment('muzzle'))
		local p = util.TraceLine({ start = attach.Pos - 15 * attach.Ang:Forward() + attach.Ang:Right(), endpos = attach.Pos - 15 * attach.Ang:Forward() + attach.Ang:Right() + attach.Ang:Forward()*16384, filter = { ZAPC }, mask = MASK_SHOT }).HitPos:ToScreen()
		surface.SetDrawColor(color.r, color.g, color.b, color.a*0.8)
		DrawMaterial(CROSSHAIR_TABLE, p.x - CROSSHAIR_TABLE.w/2, p.y - CROSSHAIR_TABLE.h/2)
	end
end
hook.Add('HUDPaint', '_ZAPC.HUDPaint', HUDPaint)

local function PreDrawHUD()
	if ViewMode == ZAPC_VIEW_PASSENGER and not HatchOpened then
		local color = ZAPC:GetColor()
		surface.SetDrawColor(color.r/5, color.g/5, color.b/5, 230)
		-- noo idea!
		surface.DrawRect(-ScrW(), -ScrH(), ScrW()*2, ScrH()*2)
	end
end
hook.Add('PreDrawHUD', '_ZAPC.PreDrawHUD', PreDrawHUD)

-- I feel bad for abusing this like that.
local ToytownMaterial = Material('pp/toytown-top')
ToytownMaterial:SetTexture('$fbtexture', render.GetScreenEffectTexture())

local function RenderScreenspaceEffects()
	if ViewMode == ZAPC_VIEW_PASSENGER and not HatchOpened then
		cam.Start2D()
		surface.SetMaterial(ToytownMaterial)
		surface.SetDrawColor(255, 255, 255, 255)
			for i = 1, 25 do
				render.UpdateScreenEffectTexture()
				surface.DrawTexturedRect(0, 0, ScrW(), ScrH()*2.5)
			end
		cam.End2D()
	end
end
hook.Add('RenderScreenspaceEffects', '_ZAPC.RenderScreenspaceEffects', RenderScreenspaceEffects)

local function Tick()
	if ViewMode == ZAPC_VIEW_GUNNER then
		Zoom = math.Clamp(Zoom + (LocalPlayer():KeyDown(IN_ZOOM) and -ZAPC_ZOOM_RATE or ZAPC_ZOOM_RATE), ZAPC_MAX_ZOOM, ZAPC_MIN_ZOOM)
	end
end
hook.Add('Tick', '_ZAPC.Tick', Tick)

local function PlayerBindPress(ply, bind, pressed)
	if ViewMode ~= ZAPC_VIEW_UNRELATED and bind:find('+duck') and pressed then
		RunConsoleCommand('zapc_viewmode', math.abs(viewmode:GetInt()-1))
		return true
	end
end
hook.Add('PlayerBindPress', '_ZAPC.PlayerBindPress', PlayerBindPress)

local function HUDShouldDraw(name)
	if ViewMode ~= ZAPC_VIEW_UNRELATED and (name == 'CHudHealth' or name == 'CHudBattery') then
		return false
	end
end
hook.Add('HUDShouldDraw', '_ZAPC.HUDShouldDraw', HUDShouldDraw)

-- Notifications for "new" players.
local function Notify(str, length, delay)
	timer.Simple(delay or 0, function()
		notification.AddLegacy(str, NOTIFY_HINT, length)
	end)
end

local notifyDriver, notifyGunner = true, true

local function DoDriverNotifications()
	notifyDriver = false
	Notify('Driver: To start the engine and release the breaks, press the left mouse button (+attack)', 10)
--~ 	Notify('Driver: To switch to the lower/higher gear, press the right mouse button (+attack2)', 8, 8)
	Notify('Driver: To switch seats, press shift (+speed)', 10, 14)
	Notify('Driver: To open or close the hatch, press Alt (+walk)', 10, 22)
	Notify('Driver: To toggle the siren, press R (+reload)', 10, 30)
end

local function DoGunnerNotifications()
	notifyGunner = false
	Notify('Gunner: To fire the turret, press your left mouse button (+attack)', 10)
	Notify('Gunner: To fire rockets, press your right mouse button (+attack2)', 10)
	Notify('Gunner: To reload, press R (+reload)', 8, 8)
end

--[[ User Messages ]]--
-- Updates ViewMode, if necessary.
usermessage.Hook('ZAPC_VU', function(msg) 
	ViewMode = tonumber(msg:ReadChar()) 
	
	-- Don't deal with notification stuff if we're disabled.
	if GetConVarNumber( "cl_showhints" ) == 0 then
		return
	end
	
	if notifyDriver and ViewMode == ZAPC_VIEW_DRIVER then
		DoDriverNotifications()
	elseif notifyGunner and ViewMode == ZAPC_VIEW_GUNNER then
		DoGunnerNotifications()
	end
end)

-- The APC we (were) last in.
usermessage.Hook('ZAPC_AU', function(msg) ZAPC = msg:ReadEntity() LocalPlayer():SetEyeAngles(Angle(25, ZAPC:GetAngles().yaw + 90, 0)) LastHealthLoss = 0 Destructing = false lastVel = 0 end) -- reset the health loss because the interface weirds around otherwise.
-- Bullet.
usermessage.Hook('ZAPC_BU', function(msg) Bullets = tonumber(msg:ReadChar()) end)
-- Actions.
usermessage.Hook('ZAPC_LPU', function() LastPrimary, NextPrimary = CurTime(), CurTime() + ZAPC_PRIMARY_RELOAD_TIME() end)
usermessage.Hook('ZAPC_LSU', function() LastSecondary, NextSecondary = CurTime(), CurTime() + ZAPC_SECONDARY_RELOAD_TIME() end)
-- Guys inside the APC.
usermessage.Hook('ZAPC_PU', function(msg) Driver = msg:ReadEntity() Gunner = msg:ReadEntity() Passengers = {} for i = 1, ZAPC_MAX_PASSENGERS() do local ent = msg:ReadEntity() if IsValid(ent) then table.insert(Passengers, ent) end end end)
-- Health
usermessage.Hook('ZAPC_HU', function(msg) Health = msg:ReadShort() LastHealthLoss = CurTime() end)
-- Destructoid
usermessage.Hook('ZAPC_SD', function(msg) Destructing = true end)
-- Hatch opening update.
usermessage.Hook('ZAPC_HOU', function(msg) HatchOpened = msg:ReadBool() end)

--[[ Debugging the APC and other addons. ]]--
local function WrapRelated(event, key)
	local func = hook.GetTable()[event][key]
	if not func then
		return
	end
	
	hook.Add(event, key, function(...) if ViewMode == ZAPC_VIEW_UNRELATED then return func(...) end end)
end

local function Initialize()
	--[[
	The official
	HALL OF STOOPID
	]]--
	
	-- 107985981, disrespecting about everyone as soon as a NWVar was set
	WrapRelated('CalcView', "RenderWithDifferentNearPlane")
end
hook.Add('Initialize', '_ZAPC.Initialize', Initialize)


-- In case this happens again, here's a few debuggers.
local function DumpHooks(ply, cmd, args)
	if IsValid(ply) and not game.SinglePlayer() then
		return
	end
	
	local hooks = { 'CalcView', 'HUDPaint', 'PreDrawHUD', 'PlayerBindPress' }
	
	print("\n[ZAPC] Dumping possible client hook collisions...")
	for _, h in pairs(hooks) do
		print("[ZAPC]   " .. h)
		for k, v in pairs(hook.GetTable()[h]) do
			print('[ZAPC]     "' .. tostring(k) .. '"')
		end
		print()
	end
	
	print("[ZAPC] Hooks dumped.")
end
concommand.Add('zapc_dumphooks_cl', DumpHooks, nil, "Dumps all hooks that could possibly cause havok on the client.")