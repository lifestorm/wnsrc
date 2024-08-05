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

local TFA_PocketBlock = {}
TFA_PocketBlock["tfa_ammo_357"] = true
TFA_PocketBlock["tfa_ammo_ar2"] = true
TFA_PocketBlock["tfa_ammo_buckshot"] = true
TFA_PocketBlock["tfa_ammo_c4"] = true
TFA_PocketBlock["tfa_ammo_frags"] = true
TFA_PocketBlock["tfa_ammo_ieds"] = true
TFA_PocketBlock["tfa_ammo_nervegas"] = true
TFA_PocketBlock["tfa_ammo_nuke"] = true
TFA_PocketBlock["tfa_ammo_pistol"] = true
TFA_PocketBlock["tfa_ammo_proxmines"] = true
TFA_PocketBlock["tfa_ammo_rockets"] = true
TFA_PocketBlock["tfa_ammo_smg"] = true
TFA_PocketBlock["tfa_ammo_smg1_grenade"] = true
TFA_PocketBlock["tfa_ammo_smg1_grenade_large"] = true
TFA_PocketBlock["tfa_ammo_sniper_rounds"] = true
TFA_PocketBlock["tfa_ammo_stickynades"] = true
TFA_PocketBlock["tfa_ammo_winchester"] = true

local function TFA_PockBlock(ply, wep) --Get it, because cockblock, hehe.....  so mature.
	if not IsValid(wep) then return end
	local class = wep:GetClass()
	if TFA_PocketBlock[class] then return false end
end

hook.Add("canPocket", "TFA_PockBlock", TFA_PockBlock)
