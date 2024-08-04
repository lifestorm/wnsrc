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

local changes = TFA_BASE_VERSION_CHANGES or ""
local cvar_changelog = GetConVar("sv_tfa_changelog")

local sp = game.SinglePlayer()
local pdatavar = "tfa_base_version_" .. util.CRC(game.GetIPAddress())

local function CheckAndDisplayChangeLog(ply)
	if not IsValid(ply) then return end

	if not cvar_changelog:GetBool() then return end

	if not sp or not ply:IsAdmin() then return end

	local version = tonumber(ply:GetPData(pdatavar))

	if not version or version < TFA_BASE_VERSION then
		chat.AddText("Updated to TFA Base Version: " .. TFA_BASE_VERSION_STRING)

		if changes ~= "" then
			chat.AddText(changes)
		end
	end

	ply:SetPData(pdatavar, TFA_BASE_VERSION)
end

hook.Add("HUDPaint", "TFA_DISPLAY_CHANGELOG", function()
	if not LocalPlayer():IsValid() then return end

	CheckAndDisplayChangeLog(LocalPlayer())

	hook.Remove("HUDPaint", "TFA_DISPLAY_CHANGELOG")
end)
