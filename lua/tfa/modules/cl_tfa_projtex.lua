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

local ply = LocalPlayer()
local LocalPlayer = LocalPlayer

hook.Add("PreRender", "TFACleanupProjectedTextures", function()
	if not IsValid(ply) then
		ply = LocalPlayer()
		if not IsValid(ply) then return end
	end

	local wep = ply:GetActiveWeapon()

	if not IsValid(wep) or not wep.IsTFAWeapon then
		if IsValid(ply.TFAFlashlightGun) then
			ply.TFAFlashlightGun:Remove()
		end

		if IsValid(ply.TFALaserDot) then
			ply.TFALaserDot:Remove()
		end
	end
end)

hook.Add("PrePlayerDraw", "TFACleanupProjectedTextures", function(plyv)
	local wep = plyv:GetActiveWeapon()

	if not IsValid(wep) or not wep.IsTFAWeapon then
		if IsValid(plyv.TFAFlashlightGun) then
			plyv.TFAFlashlightGun:Remove()
		end

		if IsValid(plyv.TFALaserDot) then
			plyv.TFALaserDot:Remove()
		end
	end
end)
