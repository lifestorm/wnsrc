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

if engine.ActiveGamemode() ~= "terrortown" then return end

-- luacheck: globals WEAPON_NONE WEAPON_MELEE WEAPON_PISTOL WEAPON_HEAVY WEAPON_NADE WEAPON_CARRY WEAPON_EQUIP1 WEAPON_EQUIP2 WEAPON_ROLE WEAPON_EQUIP WEAPON_UNARMED ROLE_INNOCENT ROLE_TRAITOR ROLE_DETECTIVE ROLE_NONE
WEAPON_NONE = WEAPON_NONE or 0
WEAPON_MELEE = WEAPON_MELEE or 1
WEAPON_PISTOL = WEAPON_PISTOL or 2
WEAPON_HEAVY = WEAPON_HEAVY or 3
WEAPON_NADE = WEAPON_NADE or 4
WEAPON_CARRY = WEAPON_CARRY or 5
WEAPON_EQUIP1 = WEAPON_EQUIP1 or 6
WEAPON_EQUIP2 = WEAPON_EQUIP2 or 7
WEAPON_ROLE = WEAPON_ROLE or 8
WEAPON_EQUIP = WEAPON_EQUIP or WEAPON_EQUIP1
WEAPON_UNARMED = WEAPON_UNARMED or -1
ROLE_INNOCENT = ROLE_INNOCENT or 0
ROLE_TRAITOR = ROLE_TRAITOR or 1
ROLE_DETECTIVE = ROLE_DETECTIVE or 2
ROLE_NONE = ROLE_NONE or ROLE_INNOCENT

local KindTable = {
	[0] = WEAPON_MELEE,
	[1] = WEAPON_PISTOL,
	[2] = WEAPON_HEAVY,
	[3] = WEAPON_HEAVY,
	[4] = WEAPON_HEAVY,
	[5] = WEAPON_EQUIP1,
	[6] = WEAPON_EQUIP2
}

local TypeStrings = {
	[WEAPON_NONE] = "Invalid",
	[WEAPON_MELEE] = "Melee",
	[WEAPON_PISTOL] = "Pistol",
	[WEAPON_HEAVY] = "Heavy",
	[WEAPON_NADE] = "Grenade",
	[WEAPON_CARRY] = "Carry",
	[WEAPON_EQUIP1] = "Equipment",
	[WEAPON_EQUIP2] = "Equipment",
	[WEAPON_ROLE] = "Role"
}

local function PatchWep(wep)
	if not weapons.IsBasedOn(wep, "tfa_gun_base") then return end
	if wep:find("base") then return end

	local tbl = weapons.GetStored(wep)
	if not tbl then return end

	tbl.AllowSprintAttack = true -- no sprinting ever, running convar is a dumb idea

	if (not tbl.Kind) or (not isnumber(tbl.Kind)) then
		tbl.Kind = KindTable[tbl.Slot or 2] or WEAPON_HEAVY

		if (tbl.ProjectileVelocity and tbl.ProjectileVelocity < 1000 and tbl.ProjectileVelocity > 0) or string.find(tbl.Base or "", "nade") then
			tbl.Kind = WEAPON_NADE
		end

		if tbl.IsMelee then
			tbl.Kind = WEAPON_MELEE
		end

		if not tbl.Spawnable then
			tbl.Kind = WEAPON_NONE
		end
	end

	--if not tbl.Icon then
	--	tbl.Icon = nil--"vgui/entities/" .. wep
	--end
	tbl.model = tbl.model or tbl.WorldModel

	if not tbl.CanBuy then
		--if tbl.Spawnable then
		--	tbl.CanBuy = { ROLE_TRAITOR, ROLE_DETECTIVE }
		--else
		tbl.CanBuy = {}
		--end
	end

	for _, v in pairs(tbl.CanBuy) do
		if v ~= ROLE_TRAITOR and v ~= ROLE_DETECTIVE then
			table.RemoveByValue(tbl.CanBuy, v)
		end
	end

	if (not tbl.Icon) or (string.len(tbl.Icon) <= 0) then
		tbl.Icon = nil
		if file.Exists("materials/entities/" .. wep .. ".png", "GAME") then
			tbl.Icon = "entities/" .. wep .. ".png"
		elseif file.Exists("materials/vgui/entities/" .. wep .. ".vmt", "GAME") then
			tbl.Icon = "vgui/entities/" .. wep
		end
	end

	if tbl.LimitedStock == nil then
		tbl.LimitedStock = false
	end

	if not tbl.EquipMenuData then
		tbl.EquipMenuData = {
			["type"] = TypeStrings[tbl.Kind],
			["desc"] = tbl.PrintName or wep
		}
	end

	if tbl.IsSilent == nil then
		tbl.IsSilent = false
	end

	if tbl.NoSights == nil then
		if tbl.data then
			tbl.NoSights = tbl.Secondary.IronSightsEnabled == false or tbl.data and tbl.data.ironsights ~= 0 or false
		end

		if tbl.NoSights == nil then
			tbl.NoSights = false
		end
	end

	if tbl.AutoSpawnable == nil then
		tbl.AutoSpawnable = tbl.Spawnable
	end
end

local function Patch()
	for _, v in pairs(weapons.GetList()) do
		local wep = v.ClassName

		if wep then
			PatchWep(wep)
		end
	end
end

if SERVER then
	hook.Add("Initialize", "TFAPatchTTT", Patch)
end
if CLIENT then
	hook.Add("HUDPaint", "TFAPatchTTT", function()
		if LocalPlayer():IsValid() then
			Patch()
			hook.Remove("HUDPaint","TFAPatchTTT")
		end
	end)
end
