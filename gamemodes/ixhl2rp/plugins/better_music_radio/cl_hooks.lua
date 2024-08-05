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
-- vars for the radio displays
PLUGIN.pitch = 180
PLUGIN.yaw = 270
PLUGIN.roll = 270
PLUGIN.x = 8.7
PLUGIN.y = -14
PLUGIN.z = 17

-- stores the vector that the signal lines are pointing to, per entity
-- tracks update targets for lerping
local mradioSigLines = {}
local leftMostSigLine = Vector(56, 62, 0)
local possibleSigLineTargets = {
    [1] = Vector(103, 62, 0),
    [2] = Vector(95,  55, 0),
    [3] = Vector(89,  52, 0),
    [4] = Vector(98,  57, 0),
    [5] = Vector(101, 59, 0),
}

-- stores the X that the frequency cursor should be at
-- stores data used for lerping on frequency changes
local mradioFreqLines = {}

-- used to illuminate a 'hitbox' around the interactable 3d2d elements
local hitboxTargets = {
    volume = {
        x = 69,
        y = 181,
        w = 25,
        h = 25,
        shouldDraw = false
    },
    onOff = {
        x = 160,
        y = 130,
        w = 40,
        h = 30,
        shouldDraw = false
    },
    dial = {
        x = 280,
        y = 170,
        w = 50,
        h = 50,
        shouldDraw = false
    },
}

local function drawActiveHitbox()
    for _, hitbox in pairs(hitboxTargets) do
        if (hitbox.shouldDraw) then
            surface.SetDrawColor(180, 21, 0, 120)
            surface.DrawOutlinedRect(hitbox.x, hitbox.y, hitbox.w, hitbox.h, 2)
        end
    end
end

-- lerp between current and desired line position; draw
local function drawMRadioSigLine(ent)
    local idx = ent:EntIndex()
    if (!mradioSigLines[idx] or !istable(mradioSigLines[idx])) then
        return
    end

    local lineDat = mradioSigLines[idx]
    lineDat.lineLastV = LerpVector(math.Clamp((SysTime() - (lineDat.lastUpdate or SysTime())) / 15, 0, 1),
        lineDat.lineLastV or leftMostSigLine,
        lineDat.lineNextV or leftMostSigLine)

    if (ent:IsPlayingMusic()) then
        render.DrawLine(Vector(83, 75, 0),
            lineDat.lineLastV, Color(255, 0, 0), true)
    end
end

-- update the desired position of the line
local function updateMRadioSigLine(ent)
    local idx = ent:EntIndex()
    if (!mradioSigLines[idx] or !istable(mradioSigLines[idx])) then
        mradioSigLines[idx] = {}
        mradioSigLines[idx].lineLastV = leftMostSigLine
        mradioSigLines[idx].lineNextV = possibleSigLineTargets[1]
        mradioSigLines[idx].lastUpdate = SysTime()
    end

    if (ent:IsPlayingMusic()) then
        -- pick a random place towards the right to point to
        mradioSigLines[idx].lineNextV = possibleSigLineTargets[math.random(1,
            table.Count(possibleSigLineTargets))]

    else
        mradioSigLines[idx].lineNextV = leftMostSigLine
    end

    mradioSigLines[idx].lastUpdate = SysTime()
end

local function drawMRadioDLight(ent, pos)
    if (ent:IsPlayingMusic()) then
        local dlight = DynamicLight(ent:EntIndex())
        if (dlight) then
            dlight.pos = pos
            dlight.r = 124
            dlight.g = 107
            dlight.b = 72
            dlight.brightness = 1
            dlight.decay = 256
            dlight.size = 128
            dlight.dietime = CurTime() + 1
            dlight.style = 6 -- strobe
	    end
    end
end

local function drawMRadioSigLevel(ent, pos, angle, scale, alpha)
    surface.SetTextColor(0, 0, 0, alpha)

    -- top left background
    if (ent:IsPlayingMusic()) then
        surface.SetDrawColor(209, 179, 120)
    else
        surface.SetDrawColor(12, 12, 12)
    end

    surface.DrawRect(46, 34, 76, 46)
    surface.SetDrawColor(0, 0, 0)
    surface.DrawOutlinedRect(46, 34, 76, 46, 2)

    surface.SetTextPos(48, 35)
    surface.SetFont("radioSurfaceSm")
    surface.DrawText("SIGNAL LEVEL")

    surface.SetTextPos(75, 65)
    surface.SetFont("radioSurfaceXs")
    surface.DrawText("dBm")

    -- draw the db guides
    local curDBm, _x, _y, symb
    surface.SetDrawColor(0, 0, 0, alpha - 50)
    for i=1, 5 do
        curDBm = -30 + (10 * i) -- -20, -10, 0, +10, +20
        _x = 38 + (13 * i)

        if (i == 3) then
            _y = 48
        elseif (i == 2 or i == 4) then
            _y = 50
        else
            _y = 52
        end

        if (i >= 4) then
            symb = "+"
        elseif (i == 3) then
            symb = " " -- fix spacing for 0dbm
        else
            symb = ""
        end

        surface.SetTextPos(_x, _y)
        surface.DrawText(symb..curDBm)
    end

    -- draw the vert guidelines
    local markerAlpha = alpha - 50
    if (!ent:IsPlayingMusic()) then
        markerAlpha = 0
    end

    for i=1, 20 do
        if (i > 10 and i <= 15) then
            surface.SetDrawColor(2, 220, 17, markerAlpha)
        elseif (i > 15) then
            surface.SetDrawColor(255, 0, 0, markerAlpha)
        else
            surface.SetDrawColor(14, 15, 41, markerAlpha)
        end

        surface.DrawRect(52 + (3 * i), 61, 1, 2)
    end

    surface.SetDrawColor(0, 0, 0, alpha)
    surface.DrawOutlinedRect(50, 46, 68, 30, 1)
end

local function drawMRadioFreqDialLine(ent, pos, ang, scale, alpha, freq)
    if (!ent:IsPlayingMusic()) then return end

    local idx = ent:EntIndex()
    if (!mradioFreqLines[idx] or !istable(mradioFreqLines[idx])) then
        return
    end

    local lineDat = mradioFreqLines[idx]
    lineDat.lineLastX = Lerp(math.Clamp((SysTime() - (lineDat.lastUpdate or SysTime())) / 20, 0, 1),
        lineDat.lineLastX, lineDat.lineNextX)

    surface.SetDrawColor(255, 0, 0, alpha + 40)
    surface.DrawRect(lineDat.lineLastX, 47, 4, 21)
end

local function updateMRadioFreqDialLine(ent)
    local idx = ent:EntIndex()
    if (!mradioFreqLines[idx] or !istable(mradioFreqLines[idx])) then
        mradioFreqLines[idx] = {}
        mradioFreqLines[idx].lineLastX = 220
        mradioFreqLines[idx].lineNextX = 220
        mradioFreqLines[idx].lastUpdate = SysTime()
    end

    if (ent:IsPlayingMusic()) then
        -- pick a random place towards the right to point to
        local ch = ent:GetChan()
        if (ch and string.len(ch) > 0) then
            local chan = ix.musicRadio:GetChannel(ch)
            if (chan and istable(chan)) then
                mradioFreqLines[idx].lineNextX = chan.freqMap.dispX or 220
            end
        end
    else
        mradioFreqLines[idx].lineNextX = 220
    end

    mradioFreqLines[idx].lastUpdate = SysTime()
end

local function drawMRadioOnOff(ent, pos, ang, scale, alpha)
    surface.SetDrawColor(30, 32, 28, 129)
    surface.DrawRect(166, 136, 30, 20)
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawOutlinedRect(166, 136, 30, 20, 1)

    surface.SetFont("radioSurfaceSmLight")

    surface.SetTextColor(0, 0, 0)
    if (ent:IsPlayingMusic()) then
        surface.SetTextColor(40, 180, 0, alpha - 35)
    end
    surface.SetTextPos(171, 137)
    surface.DrawText("ON")
end

local function drawMRadioVolume(ent, pos, ang, scale, alpha)
    surface.SetDrawColor(0, 0, 0, alpha - 70)

    surface.SetFont("radioSurfaceSm")
    local function _drawMRadioVolumeButton(x, y, text, bOn)
        surface.SetTextColor(141, 141, 141, alpha - 30)
        surface.SetTextPos(x + 2, y - 1)

        if (bOn and ent:IsPlayingMusic()) then
            surface.SetTextColor(35, 175, 23, alpha)
        end
        surface.DrawText(text)
    end

    local onButton = ent:GetIlluminatedVolButton()
    local volButtons = {
        [1] = { x = 53, y = 202 },
        [2] = { x = 50, y = 191 },
        [3] = { x = 53, y = 180 },
        [4] = { x = 61, y = 170 },
        [5] = { x = 72, y = 164 },
        [6] = { x = 84, y = 166 },
        [7] = { x = 95, y = 172 },
        [8] = { x = 101, y = 181 },
        [9] = { x = 104, y = 191 },
        [10] = { x = 99, y = 202 },
    }

    for key, button in ipairs(volButtons) do
        if (key == onButton) then
            _drawMRadioVolumeButton(button.x, button.y, tostring(key), true)
        else
            _drawMRadioVolumeButton(button.x, button.y, tostring(key), false)
        end
    end
end

local function drawMRadioSurface(ent, pos, ang, scale)
    local backlightAlphaPulse = 150
    if (ent:IsPlayingMusic()) then
        backlightAlphaPulse = 255 - math.Clamp(
            math.floor(math.sin(CurTime() * 120) * 100) - 10,
            10,
            30
        )
    end

    drawMRadioSigLevel(ent, pos, angle, scale, backlightAlphaPulse)
    drawMRadioSigLine(ent)

    -- large display center
    if (ent.IsPlayingMusic and ent:IsPlayingMusic()) then
        surface.SetDrawColor(209, 179, 120)
    else
        surface.SetDrawColor(12, 12, 12)
    end
    surface.DrawRect(160, 34, 340, 68)
    surface.SetDrawColor(10, 10, 10)
    surface.DrawOutlinedRect(160, 34, 340, 68, 2)

    -- draw the frequency info
    surface.SetDrawColor(0, 0, 0, backlightAlphaPulse)
    surface.DrawOutlinedRect(180, 77, 280, 18, 2)
    surface.SetFont("radioSurfaceSm")
    local xStep = 50
    for i=1, 6 do
        surface.SetTextPos(135 + (xStep * i), 80)
        surface.DrawText(tostring(500 + (50 * i)))
        surface.DrawRect(135 + (xStep * i) + 10, 69, 4, 8) -- center
        if (i == 1) then
            -- draw first guideline
            surface.DrawRect(184, 73, 2, 4)
        end
        if (i < 6) then
            -- draw four guidelines right of current (unless at end)
            surface.DrawRect(135 + (xStep * i) + 22.5, 73, 2, 4)
            surface.DrawRect(135 + (xStep * i) + 35, 73, 2, 4)
            surface.DrawRect(135 + (xStep * i) + 47.5, 73, 2, 4)
        end
    end

    surface.SetDrawColor(0, 0, 0, backlightAlphaPulse)
    surface.DrawOutlinedRect(180, 45, 280, 35, 2)

    drawMRadioFreqDialLine(ent, pos, angle, scale, backlightAlphaPulse)
    -- draw the light from the backlight
    drawMRadioDLight(ent, ent:LocalToWorld(Vector(10, 5, 1)))

    -- draw the toggle on/off button
    drawMRadioOnOff(ent, pos, ang, scale, backlightAlphaPulse)

    -- draw the volume button
    drawMRadioVolume(ent, pos, ang, scale, backlightAlphaPulse)
end

do
	-- step one: use consolas for everything
	-- step two: profit???
    surface.CreateFont("radioSurfaceXs", {
		font = "Consolas",
		size = 9,
		extended = true,
		weight = 400,
        antialias = true,
	})

	surface.CreateFont("radioSurfaceSm", {
		font = "Consolas",
		size = 12,
		extended = true,
		weight = 400,
        antialias = true,
	})

    surface.CreateFont("radioSurfaceSmLight", {
		font = "Open Sans Bold",
		size = 18,
		extended = true,
		weight = 200,
        antialias = true,
	})

	surface.CreateFont("radioSurfaceReg", {
		font = "Consolas",
		size = 16,
		extended = true,
		weight = 400,
        antialias = true,
	})

	surface.CreateFont("radioSurfaceBold", {
		font = "Consolas",
		extended = true,
		size = 20,
		weight = 800,
		antialias = true,
	})

    timer.Create("UpdateMusicRadioDisplayData", 0.15, 0, function()
        for _, ent in ipairs(ents.FindByClass("wn_musicradio")) do
            if (ent and ent.IsPlayingMusic) then
                updateMRadioSigLine(ent)
                updateMRadioFreqDialLine(ent)
            end
        end
    end)
end

hook.Add("PostDrawOpaqueRenderables", "draw_music_radio_ui", function()
    local epos
    local eang
    local lpos
    local lang
    local scale = 0.05 -- dat nice scale for good text (still not enough)
    local distsqr = 500 ^ 2
    local client = LocalPlayer()

    for _, ent in ipairs(ents.FindByClass("wn_musicradio")) do
        if (client:GetPos():DistToSqr(ent:GetPos()) < distsqr) then
            if (!ent or !IsEntity(ent)) then
                continue
            end

            epos = ent:GetPos()
            eang = ent:GetAngles()

            if (!epos or !isvector(epos) or !eang or !isangle(eang)) then
                continue
            end

            --[[
                Set the pos and angle so that they match the face of the radio prop
                And so that they align to the top left corner
                And are local to the entity in worldspace
            ]]
            lpos = ent:LocalToWorld(Vector(PLUGIN.x, PLUGIN.y, PLUGIN.z))
            lang = ent:LocalToWorldAngles(Angle(PLUGIN.pitch, PLUGIN.yaw, PLUGIN.roll))
            cam.Start3D2D(lpos, lang, scale)
                drawMRadioSurface(ent, lpos, lang, scale)
            cam.End3D2D()
            -- do the same thing, but a bit further forward, for the hitbox rectangles
            lpos2 = ent:LocalToWorld(Vector(PLUGIN.x + 0.9, PLUGIN.y, PLUGIN.z))
            cam.Start3D2D(lpos2, lang, scale)
                drawActiveHitbox()
            cam.End3D2D()
        end
    end
end)

--[[
    this code is sus
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣤⣤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡿⠛⠉⠙⠛⠛⠛⠛⠻⢿⣿⣷⣤⡀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⠋⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠈⢻⣿⣿⡄⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⣸⣿⡏⠀⠀⠀⣠⣶⣾⣿⣿⣿⠿⠿⠿⢿⣿⣿⣿⣄⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⣿⣿⠁⠀⠀⢰⣿⣿⣯⠁⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣷⡄⠀ 
⠀⠀⣀⣤⣴⣶⣶⣿⡟⠀⠀⠀⢸⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣷⠀ 
⠀⢰⣿⡟⠋⠉⣹⣿⡇⠀⠀⠀⠘⣿⣿⣿⣿⣷⣦⣤⣤⣤⣶⣶⣶⣶⣿⣿⣿⠀ 
⠀⢸⣿⡇⠀⠀⣿⣿⡇⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀ 
⠀⣸⣿⡇⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠉⠻⠿⣿⣿⣿⣿⡿⠿⠿⠛⢻⣿⡇⠀⠀ 
⠀⣿⣿⠁⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣧⠀⠀ 
⠀⣿⣿⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀ 
⠀⣿⣿⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀ 
⠀⢿⣿⡆⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀ 
⠀⠸⣿⣧⡀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠃⠀⠀ 
⠀⠀⠛⢿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⣰⣿⣿⣷⣶⣶⣶⣶⠶⠀⢠⣿⣿⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⣿⣿⡇⠀⣽⣿⡏⠁⠀⠀⢸⣿⡇⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⣿⣿⠀⠀⠀⠀⠀⣿⣿⡇⠀⢹⣿⡆⠀⠀⠀⣸⣿⠇⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⢿⣿⣦⣄⣀⣠⣴⣿⣿⠁⠀⠈⠻⣿⣿⣿⣿⡿⠏⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⠿⠿⠿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]
function PLUGIN:Think()
    -- we're checking every frame if the player is looking at a radio?? 
    -- someone cooked here
    local tr = LocalPlayer():GetEyeTrace()
    if (tr.Entity and IsValid(tr.Entity) and tr.Entity:GetClass() == "wn_musicradio") then
        local volButton  = tr.Entity:GetAbsolutePanelButtonPosition(80, 170)
        local onButton   = tr.Entity:GetAbsolutePanelButtonPosition(135, 150)
        local dialButton = tr.Entity:GetAbsolutePanelButtonPosition(190, 170)

        hitboxTargets.volume.shouldDraw = false
        hitboxTargets.onOff.shouldDraw = false
        hitboxTargets.dial.shouldDraw = false

        if (tr.HitPos:Distance(volButton) <= 2) then
            if (tr.Entity:IsPlayingMusic()) then
                hitboxTargets.volume.shouldDraw = true
            end
        elseif (tr.HitPos:Distance(onButton) <= 2) then
            hitboxTargets.onOff.shouldDraw = true
        elseif (tr.HitPos:Distance(dialButton) <= 2) then
            if (tr.Entity:IsPlayingMusic()) then
                hitboxTargets.dial.shouldDraw = true
            end
        end
    end
end
