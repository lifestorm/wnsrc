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
local ix = ix

PLUGIN.corpses = {}

PLUGIN.hitGroupName = {
	[HITGROUP_HEAD] = "head",
	[HITGROUP_CHEST] = "chest",
	[HITGROUP_STOMACH] = "stomach",
	[HITGROUP_LEFTARM] = "left arm",
	[HITGROUP_RIGHTARM] = "right arm",
	[HITGROUP_LEFTLEG] = "left leg",
	[HITGROUP_RIGHTLEG] = "right leg",
	[HITGROUP_GEAR] = "gear",
}

PLUGIN.HitGroupBonesCache = {
	{"ValveBiped.Bip01_R_UpperArm", HITGROUP_RIGHTARM},
	{"ValveBiped.Bip01_R_Forearm", HITGROUP_RIGHTARM},
	{"ValveBiped.Bip01_L_UpperArm", HITGROUP_LEFTARM},
	{"ValveBiped.Bip01_L_Forearm", HITGROUP_LEFTARM},
	{"ValveBiped.Bip01_R_Thigh", HITGROUP_RIGHTLEG},
	{"ValveBiped.Bip01_R_Calf", HITGROUP_RIGHTLEG},
	{"ValveBiped.Bip01_R_Foot", HITGROUP_RIGHTLEG},
	{"ValveBiped.Bip01_R_Hand", HITGROUP_RIGHTARM},
	{"ValveBiped.Bip01_L_Thigh", HITGROUP_LEFTLEG},
	{"ValveBiped.Bip01_L_Calf", HITGROUP_LEFTLEG},
	{"ValveBiped.Bip01_L_Foot", HITGROUP_LEFTLEG},
	{"ValveBiped.Bip01_L_Hand", HITGROUP_LEFTARM},
	{"ValveBiped.Bip01_Pelvis", HITGROUP_STOMACH},
	{"ValveBiped.Bip01_Spine2", HITGROUP_CHEST},
	{"ValveBiped.Bip01_Spine1", HITGROUP_CHEST},
	{"ValveBiped.Bip01_Head1", HITGROUP_HEAD},
	{"ValveBiped.Bip01_Neck1", HITGROUP_HEAD}
}

function PLUGIN:CalculateRagdollHitGroup(ragdoll, position)
	local dist, hitGroup
	for _, v in pairs(self.HitGroupBonesCache) do
		local bone = ragdoll:LookupBone(v[1]);
		if (bone) then
			local bonePosition = ragdoll:GetBonePosition(bone)
			if (bonePosition) then
				local distance = bonePosition:DistToSqr(position)
				if (!dist or distance < dist) then
					dist = distance
					hitGroup = v[2]
				end
			end
		end
	end

	if (hitGroup) then
		return hitGroup
	else
		return HITGROUP_GENERIC
	end
end

ix.log.AddType("playerDeath", function(client)
	return -1
end, FLAG_DANGER)

ix.log.AddType("playerDeathNew", function(client, ...)
	local arg = {...}
	return string.format("%s has killed %s%s.", arg[1], client:Name(), arg[2] and (" with " .. arg[2]) or "")
end, FLAG_DANGER)

ix.log.AddType("weaponBalanceResult", function(attacker, result, victim, hitgroup, finalDamage, critChance)
	return string.format("%s has %s %s%s dealing %d damage (CritChance was %.2f).",
		attacker:IsPlayer() and attacker:Name() or attacker:GetClass(),
		result == "crit" and "critically hit" or "hit",
		victim:IsPlayer() and victim:Name() or victim:GetClass(),
		(PLUGIN.hitGroupName[hitgroup] and " in the "..PLUGIN.hitGroupName[hitgroup]) or "",
		finalDamage,
		critChance)
end)

ix.log.AddType("weaponBalanceDebugOutput", function(attacker, hitBoxCrit, armorMod, weaponSkillMod, rangeSkillMod, effRangeMod, dodgeMod)
	if (ix.config.Get("weaponBalanceDebugOutput")) then
		return string.format("[DEBUG-WEPBAL] baseCrit: %.2f; armorMod: %.2f; weaponSkillMod: %.2f; rangeSkillMod: %.2f; effRangeMod: %.2f; dodgeMod: %.2f",
        hitBoxCrit, armorMod, weaponSkillMod, rangeSkillMod, effRangeMod, dodgeMod)
	else
		return -1
	end
end)

ix.log.AddType("weaponMeleeBalanceDebugOutput", function(attacker, baseCrit, armorMod, dodgeMod)
	if (ix.config.Get("weaponBalanceDebugOutput")) then
		return string.format("[DEBUG-WEPBAL] baseCrit: %.2f; armorMod: %.2f; dodgeMod: %.2f",
        baseCrit, armorMod, dodgeMod)
	else
		return -1
	end
end)

ix.log.AddType("weaponBalanceDebugRolls", function(attacker, critChance, critRoll, result)
	if (ix.config.Get("weaponBalanceDebugRolls")) then
		return string.format("[DEBUG-WEPBAL] Chance: %.3f; Roll: %.3f; Result: %s;",
            critChance, critRoll, string.utf8upper(result))
	else
		return -1
	end
end)

--[[
	Below code is taken from the Persistent Corpses plugin made by `impulse, available here under the MIT license: https://github.com/nebulouscloud/helix-plugins/blob/master/persistent_corpses.lua
	Copyright 2018 - 2020 Igor Radovanovic
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]
function PLUGIN:HandlePlayerDeathFallback(victim, damage)
	-- Custom death log to show correct killer/weapon
	local attacker = damage:GetAttacker()
	local weapon = damage:GetInflictor()
	ix.log.Add(victim, "playerDeathNew",
		attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass(), IsValid(weapon) and weapon:GetClass())

	victim:Kill()
end

function PLUGIN:CleanupCorpses(maxCorpses)
	maxCorpses = maxCorpses or ix.config.Get("corpseMax", 8)
	local toRemove = {}

	if (#self.corpses > maxCorpses) then
		for k, v in ipairs(self.corpses) do
			if (!IsValid(v)) then
				toRemove[#toRemove + 1] = k
			elseif (#self.corpses - #toRemove > maxCorpses) then
				v:Remove()
				toRemove[#toRemove + 1] = k
			end
		end
	end

	for k, _ in ipairs(toRemove) do
		table.remove(self.corpses, k)
	end
end