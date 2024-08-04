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

TFA.NZombies = TFA.NZombies or {}

if TFA.NZombies.Patch == nil then
	TFA.NZombies.Patch = true --Change this if you need to
end

local cv_melee_scaling, cv_melee_basefactor, cv_melee_berserkscale
local nzombies = string.lower(engine.ActiveGamemode() or "") == "nzombies"

if nZombies or NZombies or NZ then
	nzombies = true
end

if nzombies then
	cv_melee_scaling = CreateConVar("sv_tfa_nz_melee_scaling", "1", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED}, "0.5x means if zombies have 4x health, melee does 2x damage")
	cv_melee_basefactor = CreateConVar("sv_tfa_nz_melee_multiplier", "0.65", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED}, "Base damage scale for TFA Melees.")
	cv_melee_berserkscale = CreateConVar("sv_tfa_nz_melee_immunity", "0.67", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED}, "Take X% damage from zombies while you're melee.")
	--cv_melee_juggscale = CreateConVar("sv_tfa_nz_melee_juggernaut", "1.5", {FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED}, "Do X% damage to zombies while you're jug.")
	hook.Add("TFA_AnimationRate","NZBase",function(wep,act,rate)
		if wep:OwnerIsValid() and wep:GetOwner().HasPerk and wep:GetOwner():HasPerk("speed") and wep.SpeedColaActivities[ act ] then
			rate = rate * wep.SpeedColaFactor
		end
		if wep:OwnerIsValid() and wep:GetOwner().HasPerk and wep:GetOwner():HasPerk("dtap") and wep.DTapActivities[ act ] then
			rate = rate * wep.DTapSpeed
		end
		if wep:OwnerIsValid() and wep:GetOwner().HasPerk and wep:GetOwner():HasPerk("dtap2") and wep.DTapActivities[ act ] then
			rate = rate * wep.DTap2Speed
		end
		return rate
	end)
	hook.Add("TFA_Deploy","NZBase",function(wep)
		local pap = wep:GetPaP()
		wep.OldPaP = pap
		local spd2 = wep:OwnerIsValid() and wep:GetOwner().HasPerk and wep:GetOwner():HasPerk("speed")
		if pap and pap ~= wep.OldPaP then
			if AddPackAPunchName and wep.NZPaPName and not wep.HasAddedNZName then
				AddPackAPunchName( wep.ClassName, wep.NZPaPName )
				wep.HasAddedNZName = true
			end
			if wep.NZPaPName and wep:GetPaP() then
				wep.PrintName = wep.NZPaPName
				wep:SetNW2String("PrintName",wep.NZPaPName)
			end
			local pn = wep:GetNW2String("PrintName")
			if pn and pn ~= "" then
				wep.PrintName = pn
			end
			wep:ClearStatCache()
			timer.Simple(0.1,function()
				if IsValid(wep) then
					wep:ClearStatCache()
				end
			end)
		end
		if spd2 ~= wep.OldSpCola then
			wep:ClearStatCache()
		end
		wep.OldSpCola = spd2
	end)
	hook.Add("TFA_Initialize", "NZBase", function(wep)
		timer.Simple(0.1, function() -- timers for everything YAY
			if not IsValid(wep) then return end

			wep.Primary_TFA.Ammo = game.GetAmmoName(wep:GetPrimaryAmmoType())
			wep:ClearStatCache("Primary.Ammo")
		end)
	end)
end
--[[
local function SpreadFix()

	local GAMEMODE = gmod.GetGamemode() or GAMEMODE
	if not GAMEMODE then return end

	print("[TFA] Patching NZombies")
	if TFA.NZombies.Patch then return end

	local ghosttraceentities = {
		["wall_block"] = true,
		["invis_wall"] = true,
		["player"] = true
	}

	function GAMEMODE:EntityFireBullets(ent, data)
		-- Fire the PaP shooting sound if the weapon is PaP'd
		--print(wep, wep.pap)
		if ent:IsPlayer() and IsValid(ent:GetActiveWeapon()) then
			local wep = ent:GetActiveWeapon()
			if wep.pap and ( not wep.IsMelee ) and ( not wep.IsKnife ) then
				wep:EmitSound("nz/effects/pap_shoot_glock20.wav", 105, 100)
			end
		end

		if ent:IsPlayer() and ent:HasPerk("dtap2") then
			data.Num = data.Num * 2
		end

		-- Perform a trace that filters out entities from the table above
		local tr = util.TraceLine({
			start = data.Src,
			endpos = data.Src + (data.Dir * data.Distance),
			filter = function(entv)
				if ghosttraceentities[entv:GetClass()] and not entv:IsPlayer() then
					return true
				else
					return false
				end
			end
		})

		--PrintTable(tr)
		-- If we hit anything, move the source of the bullets up to that point
		if IsValid(tr.Entity) and tr.Fraction < 1 then
			local tr2 = util.TraceLine({
				start = data.Src,
				endpos = data.Src + (data.Dir * data.Distance),
				filter = function(entv)
					if ghosttraceentities[entv:GetClass()] then
						return false
					else
						return true
					end
				end
			})

			data.Src = tr2.HitPos - data.Dir * 5

			return true
		end

		if ent:IsPlayer() and ent:HasPerk("dtap2") then return true end
	end
end
]]
--
local function MeleeFix()
	hook.Add("EntityTakeDamage", "TFA_MeleeScaling", function(target, dmg)
		if not TFA.NZombies.Patch then return end
		if not nzRound then return end
		local ent = dmg:GetInflictor()

		if not ent:IsWeapon() and ent:IsPlayer() then
			ent = ent:GetActiveWeapon()
		end

		if not IsValid(ent) or not ent:IsWeapon() then return end

		if ent.IsTFAWeapon and (dmg:IsDamageType(DMG_CRUSH) or dmg:IsDamageType(DMG_CLUB) or dmg:IsDamageType(DMG_SLASH)) then
			local scalefactor = cv_melee_scaling:GetFloat()
			local basefactor = cv_melee_basefactor:GetFloat()
			dmg:ScaleDamage(((nzRound:GetZombieHealth() - 75) / 75 * scalefactor + 1) * basefactor)
			--if IsValid(ent:GetOwner()) and ent:GetOwner():IsPlayer() and ent:GetOwner():HasPerk("jugg") then
			--	dmg:ScaleDamage(cv_melee_juggscale:GetFloat())
			--end
		end
	end)

	hook.Add("EntityTakeDamage", "TFA_MeleeReceiveLess", function(target, dmg)
		if not TFA.NZombies.Patch then return end

		if target:IsPlayer() and target.GetActiveWeapon then
			local wep = target:GetActiveWeapon()

			if IsValid(wep) and wep.IsTFAWeapon and (wep.IsKnife or wep.IsMelee or wep.Primary.Reach) then
				dmg:ScaleDamage(cv_melee_berserkscale:GetFloat())
			end
		end
	end)

	hook.Add("EntityTakeDamage", "TFA_MeleePaP", function(target, dmg)
		if not TFA.NZombies.Patch then return end
		local ent = dmg:GetInflictor()

		if IsValid(ent) then
			local wep

			if ent:IsPlayer() then
				wep = ent:GetActiveWeapon()
			elseif ent:IsWeapon() then
				wep = ent
			end

			if IsValid(wep) and wep.IsTFAWeapon and (wep.Primary.Attacks or wep.IsMelee or wep.Primary.Reach) and wep:GetPaP() then
				dmg:ScaleDamage(2)
			end
		end
	end)
end

local function NZPatch()
	if not TFA.NZombies.Patch then return end
	nzombies = string.lower(engine.ActiveGamemode() or "") == "nzombies"

	if nZombies or NZombies or NZ or NZombies then
		nzombies = true
	end

	if nzombies then
		--SpreadFix()
		MeleeFix()
	end
end

hook.Add("InitPostEntity", "TFA_NZPatch", NZPatch)
NZPatch()