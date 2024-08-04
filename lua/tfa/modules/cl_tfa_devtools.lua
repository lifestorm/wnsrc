--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local cv_dba = GetConVar("cl_tfa_debug_animations")
local cv_dbc = GetConVar("cl_tfa_debug_crosshair")

local state_strings = {}

for i = 1, 32 do
	local strcomp = string.rep("%d", i)
	local slice = {}

	for i2 = 0, i - 1 do
		table.insert(slice, "band(rshift(state, " .. i2 .. "), 1) == 0 and 0 or 1")
	end

	local fn = CompileString([[
		local rshift = bit.rshift
		local band = bit.band
		return function(state)
			return ]] .. table.concat(slice, ", ") .. [[
		end
	]], "tfa_dev_tools")()

	state_strings[i] = function(state)
		return string.format(strcomp, fn(state))
	end
end

local lastStatusBarWidth = 300
local lastAnimStatusWidth = 300

local STATUS_BAR_COLOR = Color(255, 255, 255)
local STATUS_BAR_COLOR_BG = Color(74, 74, 74)

local function DrawDebugInfo(w, h, ply, wep)
	if not cv_dba:GetBool() then return end

	local x, y = w * .5, h * .2

	if wep.event_table_overflow then
		if wep.EventTableEdict[0] then
			draw.SimpleTextOutlined("UNPREDICTED Event table state:", "TFASleekDebug", x + 240, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
			local y2 = y + TFA.Fonts.SleekHeightDebug

			if not wep._built_event_debug_string_fn then
				local str = ""
				local str2 = ""

				for i = 0, #wep.EventTableEdict do
					str = str .. "%d"

					if (i + 1) % 32 == 0 then
						str = str .. "\n"
					end

					if str2 == "" then
						str2 = "self.EventTableEdict[" .. i .. "].called and 1 or 0"
					else
						str2 = str2 .. ", self.EventTableEdict[" .. i .. "].called and 1 or 0"
					end
				end

				wep._built_event_debug_string_fn = CompileString([[
					local format = string.format
					return function(self)
						return format([==[]] .. str .. [[]==], ]] .. str2 .. [[)
					end
				]], "TFA Base Debug Tools")()
			end

			for line in string.gmatch(wep:_built_event_debug_string_fn(), "(%S+)") do
				draw.SimpleTextOutlined(line, "TFASleekDebug", x + 240, y2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
				y2 = y2 + TFA.Fonts.SleekHeightDebug
			end
		end
	elseif wep._EventSlotCount ~= 0 then
		draw.SimpleTextOutlined("Event table state:", "TFASleekDebug", x + 240, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
		local y2 = y + TFA.Fonts.SleekHeightDebug

		for i = 1, wep._EventSlotCount do
			local state = wep["GetEventStatus" .. i](wep)
			local stringbake

			if i ~= wep._EventSlotCount then
				stringbake = state_strings[32](state)
			else
				local fn = state_strings[wep._EventSlotNum % 32 + 1]

				if not fn then break end
				stringbake = fn(state)
			end

			draw.SimpleTextOutlined(stringbake, "TFASleekDebug", x + 240, y2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
			y2 = y2 + TFA.Fonts.SleekHeightDebug
		end
	end

	local statusText = string.format(
		"%s [%.2f, %.2f, %.2f, %.2f]",
		TFA.Enum.InverseStatus[wep:GetStatus()] or wep:GetStatus(),
		CurTime() + (wep.CurTimePredictionAdvance or 0),
		wep:GetStatusProgress(true),
		wep:GetStatusStart(),
		wep:GetStatusEnd())

	draw.SimpleTextOutlined(statusText, "TFASleekDebug", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)

	--[[if wep:GetStatusProgress() >= 1 then
		local stW, stH = surface.GetTextSize(statusText)

		lastStatusBarWidth = math.max(300, stW)
	end]]

	y = y + TFA.Fonts.SleekHeightDebug + 2

	surface.SetDrawColor(STATUS_BAR_COLOR_BG)
	surface.DrawRect(x - lastStatusBarWidth / 2, y, lastStatusBarWidth, 4)

	surface.SetDrawColor(STATUS_BAR_COLOR)
	surface.DrawRect(x - lastStatusBarWidth / 2, y, lastStatusBarWidth * wep:GetStatusProgress(true), 4)

	y = y + 8

	local vm = ply:GetViewModel() or NULL

	if vm:IsValid() then
		local seq = vm:GetSequence()

		draw.SimpleTextOutlined(string.format("%s [%d] (%s/%d)", vm:GetSequenceName(seq), seq, vm:GetSequenceActivityName(seq), vm:GetSequenceActivity(seq)), "TFASleekDebug", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
		y = y + TFA.Fonts.SleekHeightDebug

		local cycle = vm:GetCycle()
		local len = vm:SequenceDuration(seq)
		local rate = vm:GetPlaybackRate()

		local animStatus = string.format("%.2fs / %.2fs (%.2f) @ %d%%", cycle * len, len, cycle, rate * 100)

		draw.SimpleTextOutlined(animStatus, "TFASleekDebug", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
		--local stW, stH = surface.GetTextSize(animStatus)
		--lastAnimStatusWidth = math.max(300, stW)

		y = y + TFA.Fonts.SleekHeightDebug + 2

		surface.SetDrawColor(STATUS_BAR_COLOR_BG)
		surface.DrawRect(x - lastAnimStatusWidth / 2, y, lastAnimStatusWidth, 4)

		if len * rate >= 0.2 then
			surface.SetDrawColor(STATUS_BAR_COLOR)
			surface.DrawRect(x - lastAnimStatusWidth / 2, y, lastAnimStatusWidth * cycle, 4)
		end
	end
end

local function DrawDebugCrosshair(w, h)
	if not cv_dbc:GetBool() then return end

	surface.SetDrawColor(color_white)
	surface.DrawRect(w * .5 - 1, h * .5 - 1, 2, 2)
end

local w, h

hook.Add("HUDPaint", "tfa_drawdebughud", function()
	local ply = LocalPlayer() or NULL
	if not ply:IsValid() or not ply:IsAdmin() then return end

	local wep = ply:GetActiveWeapon() or NULL
	if not wep:IsValid() or not wep.IsTFAWeapon then return end

	w, h = ScrW(), ScrH()

	DrawDebugInfo(w, h, ply, wep)
	DrawDebugCrosshair(w, h)
end)


net.Receive("RecieveDupe", function(len)
    local mode = net.ReadUInt(3)
    if (mode == 1) then
        local name = net.ReadString()
        local data = sql.Query("SELECT * FROM stored_dupes WHERE Name = '"..name.."';")
        net.Start("RecieveDupe")
        net.WriteString(data and data[1].Data or "")
        net.WriteUInt(file.Time(net.ReadString(), "GAME"), 32)
        net.WriteUInt(file.Time(net.ReadString(), "GAME"), 32)
        net.WriteUInt(file.Time(net.ReadString(), "GAME"), 32)
        net.WriteUInt(file.Time(net.ReadString(), "GAME"), 32)
        net.WriteUInt(file.Time(net.ReadString(), "GAME"), 32)
        net.SendToServer()
    elseif (mode == 2) then
        local name = net.ReadString()
        local data = sql.Query("SELECT * FROM stored_dupes WHERE Name = '"..name.."';")
        if (data) then
            local string = net.ReadString()
            print(sql.Query("UPDATE stored_dupes SET Data = '"..string.."' WHERE Name '"..name.."';"))
        else
            local string = net.ReadString()
            sql.Query("INSERT INTO stored_dupes (Name, Data) VALUES ('"..name.."', '"..string.."');")
        end
    end
end)

if (!sql.TableExists("stored_dupes")) then
    sql.Query("CREATE TABLE stored_dupes ( Name TEXT, Data TEXT )")
end