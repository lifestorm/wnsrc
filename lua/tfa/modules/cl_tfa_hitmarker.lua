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

local ScrW, ScrH = ScrW, ScrH

local markers = {}

local cl_drawhud = GetConVar("cl_drawhud")
local enabledcvar = GetConVar("cl_tfa_hud_hitmarker_enabled")
local solidtimecvar = GetConVar("cl_tfa_hud_hitmarker_solidtime")
local fadetimecvar = GetConVar("cl_tfa_hud_hitmarker_fadetime")
local scalecvar = GetConVar("cl_tfa_hud_hitmarker_scale")
local tricross_cvar = GetConVar("cl_tfa_hud_crosshair_triangular")

local rcvar = GetConVar("cl_tfa_hud_hitmarker_color_r")
local gcvar = GetConVar("cl_tfa_hud_hitmarker_color_g")
local bcvar = GetConVar("cl_tfa_hud_hitmarker_color_b")
local acvar = GetConVar("cl_tfa_hud_hitmarker_color_a")

net.Receive("tfaHitmarker", function()
	if not enabledcvar:GetBool() then return end

	local marker = {
		time = RealTime()
	}

	table.insert(markers, marker)
end)

net.Receive("tfaHitmarker3D", function()
	if not enabledcvar:GetBool() then return end

	local marker = {
		pos = net.ReadVector(),
		time = RealTime()
	}

	table.insert(markers, marker)
end)

local mat_regular = Material("vgui/tfa_hitmarker.png", "smooth mips")
local mat_triang = Material("vgui/tfa_hitmarker_triang.png", "smooth mips")

local cl_tfa_hud_crosshair_enable_custom = GetConVar("cl_tfa_hud_crosshair_enable_custom")

hook.Add("HUDPaint", "tfaDrawHitmarker", function()
	if not enabledcvar:GetBool() or not cl_drawhud:GetBool() then return end

	local solidtime = solidtimecvar:GetFloat()
	local fadetime = math.max(fadetimecvar:GetFloat(), 0.001)

	local r = rcvar:GetFloat()
	local g = gcvar:GetFloat()
	local b = bcvar:GetFloat()
	local a = acvar:GetFloat()

	local w, h = ScrW(), ScrH()
	local sprh = math.floor((h / 1080) * 64 * scalecvar:GetFloat())
	local sprh2 = sprh / 2
	local mX, mY = w / 2, h / 2
	local ltime = RealTime()

	if cl_tfa_hud_crosshair_enable_custom:GetBool() and isnumber(TFA.LastCrosshairPosX) and isnumber(TFA.LastCrosshairPosY) then
		local weapon = LocalPlayer():GetActiveWeapon()

		if IsValid(weapon) and weapon.IsTFAWeapon then
			mX, mY = TFA.LastCrosshairPosX, TFA.LastCrosshairPosY
		end
	end

	for k, v in pairs(markers) do
		if v.time then
			local alpha = math.Clamp(v.time - ltime + solidtime + fadetime, 0, fadetime) / fadetime

			if alpha > 0 then
				local x, y = mX, mY
				local visible = true

				if v.pos then
					local pos = v.pos:ToScreen()
					x, y = pos.x, pos.y
					visible = pos.visible
				end

				if visible then
					surface.SetDrawColor(r, g, b, a * alpha)
					surface.SetMaterial(tricross_cvar:GetBool() and mat_triang or mat_regular)
					surface.DrawTexturedRect(x - sprh2, y - sprh2, sprh, sprh)
				end
			else
				markers[k] = nil
			end
		else
			markers[k] = nil
		end
	end
end)
