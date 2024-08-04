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

-- AI Options
if CLIENT then
	hook.Add("PopulateMenuBar", "NPCOptions_MenuBar_TFA", function(menubarV)
		local m = menubarV:AddOrGetMenu("#menubar.npcs")
		local wpns = m:AddSubMenu("#tfa.menubar.npcs.weapon")
		wpns:SetDeleteSelf(false)

		wpns:AddCVar("#menubar.npcs.defaultweapon", "gmod_npcweapon", "")
		wpns:AddCVar("#menubar.npcs.noweapon", "gmod_npcweapon", "none")
		wpns:AddSpacer()

		local weaponCats = {}

		for _, wep in pairs(weapons.GetList()) do
			if wep and wep.Spawnable and weapons.IsBasedOn(wep.ClassName, "tfa_gun_base") then
				local cat = wep.Category or "Other"
				weaponCats[cat] = weaponCats[cat] or {}

				table.insert(weaponCats[cat], {
					["class"] = wep.ClassName,
					["title"] = wep.PrintName or wep.ClassName
				})
			end
		end

		local catKeys = table.GetKeys(weaponCats)
		table.sort(catKeys, function(a, b) return a < b end)

		for _, k in ipairs(catKeys) do
			local v = weaponCats[k]
			local wpnSub = wpns:AddSubMenu(k)
			wpnSub:SetDeleteSelf(false)
			table.SortByMember(v, "title", true)

			for _, b in ipairs(v) do
				wpnSub:AddCVar(b.title, "gmod_npcweapon", b.class)
			end
		end
	end)
else
	local npcWepList = list.GetForEdit("NPCUsableWeapons")

	hook.Add("PlayerSpawnNPC", "TFACheckNPCWeapon", function(plyv, npcclassv, wepclassv)
		if type(wepclassv) ~= "string" or wepclassv == "" then return end

		if not npcWepList[wepclassv] then -- do not copy the table
			local wep = weapons.GetStored(wepclassv)

			if wep and (wep.Spawnable and not wep.AdminOnly) and weapons.IsBasedOn(wep.ClassName, "tfa_gun_base") then
				npcWepList[wepclassv] = {
					["class"] = wep.ClassName,
					["title"] = wep.PrintName or wep.ClassName
				}
			end
		end
	end)
end
