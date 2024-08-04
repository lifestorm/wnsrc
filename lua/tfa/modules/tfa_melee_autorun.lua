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

local vector_origin = Vector()

local timed_blocking_cv = GetConVar("sv_tfa_melee_blocking_timed")
local angle_mult_cv = GetConVar("sv_tfa_melee_blocking_anglemult")
local deflect_cv = GetConVar("sv_tfa_melee_blocking_deflection")
local stun_cv = GetConVar("sv_tfa_melee_blocking_stun_enabled")
local stuntime_cv = GetConVar("sv_tfa_melee_blocking_stun_time")

local bul = {
	HullSize = 5,
	Num = 1,
	Tracer = 1,
	AmmoType = "",
	TracerName = "Tracer",
	Spread = Vector(0.05,0.05,0),
	Distance = 56756
}

local function CanDeflect()
	return true
end

local function DeflectBullet( ent, dmginfo, olddmg )
	if dmginfo:IsDamageType( DMG_BULLET ) and CanDeflect() and ent.FireBullets then
		bul.Src = ent:GetShootPos()
		bul.Dir = ent:EyeAngles():Forward()
		bul.Damage = olddmg
		bul.Force = olddmg / 10
		local atk = dmginfo:GetAttacker()
		if IsValid( atk ) and atk.TFALastTracer then
			bul.Tracer = atk.TFALastTracer
		end
		ent:FireBullets( bul, false )
		dmginfo:ScaleDamage(0)
	end
end

local stuntime = 0.65

local function StunNPC( npc, ply )
	if stun_cv and not stun_cv:GetBool() then return end
	if ( not IsValid( npc ) ) or ( not npc:IsNPC() ) then
		return
	end
	if npc.ClearSchedule then
		npc:ClearSchedule()
	end
	if npc.SetEnemy then
		npc:SetEnemy(nil)
	end
	if npc.AddEntityRelationship and IsValid(ply) then
		local oldrel = npc.GetRelationship and npc:GetRelationship(ply) or D_HT
		npc:AddEntityRelationship( ply, D_NU, 99)
		stuntime = stuntime_cv:GetFloat()
		timer.Simple( stuntime , function()
			if IsValid(npc) and npc:IsNPC() and IsValid(ply) then
				npc:AddEntityRelationship( ply, oldrel, 99)
			end
		end)
	end
	if npc.ClearEnemyMemory then
		npc:ClearEnemyMemory()
	end
end

local function BlockDamageNew( ent, dmginfo )
	if not ent:IsPlayer() then return end
	if dmginfo:IsDamageType( DMG_DROWNRECOVER ) or dmginfo:IsDamageType(DMG_DIRECT) then return end
	local wep
	wep = ent:GetActiveWeapon()

	if (wep.IsTFAWeapon and wep.BlockDamageTypes and wep:GetStatus() == TFA.Enum.STATUS_BLOCKING) then
		local canblock = false
		for _,v in ipairs(wep.BlockDamageTypes) do
			if dmginfo:IsDamageType(v) then canblock = true end
		end
		if canblock then
			local damageinflictor, blockthreshold
			damageinflictor = dmginfo:GetInflictor()

			if (not IsValid(damageinflictor)) then
				damageinflictor = dmginfo:GetAttacker()
			end

			blockthreshold = ( wep.BlockCone or 135 ) / 2
			if angle_mult_cv then
				blockthreshold = blockthreshold * angle_mult_cv:GetFloat()
			end
			if ( IsValid(damageinflictor) and ( math.abs(math.AngleDifference( ent:EyeAngles().y, ( damageinflictor:GetPos() - ent:GetPos() ):Angle().y )) <= blockthreshold)) then
				local fac = math.Clamp( ( CurTime() - wep:GetBlockStart() - wep.BlockTimeWindow ) / wep.BlockTimeFade, 0, 1)
				local dmgscale
				if ( not timed_blocking_cv ) or timed_blocking_cv:GetBool() then
					dmgscale = Lerp(fac, wep.BlockDamageMaximum, wep.BlockDamageMinimum)
				else
					dmgscale = wep.BlockDamageMaximum
				end
				local olddmg = dmginfo:GetDamage()
				dmgscale = math.min( dmgscale, wep.BlockDamageCap / dmginfo:GetDamage() )
				--print(fac)
				dmginfo:ScaleDamage(dmgscale)
				dmginfo:SetDamagePosition(vector_origin)
				dmginfo:SetDamageType( bit.bor( dmginfo:GetDamageType(), DMG_DROWNRECOVER ) )
				wep:EmitSound(wep.BlockSound or "")

				if wep.ChooseBlockAnimation then
					wep:ChooseBlockAnimation()
				end

				if deflect_cv and deflect_cv:GetInt() == 2 then
					DeflectBullet( ent, dmginfo, olddmg )
				end

				if dmginfo:GetDamage() < 1 then
					if deflect_cv and deflect_cv:GetInt() == 1 and wep.BlockCanDeflect then
						DeflectBullet( ent, dmginfo, olddmg )
					end
					StunNPC( dmginfo:GetAttacker(), ent )
					return true
				end
				return
			end
		end
	end
end


hook.Add("EntityFireBullets","TFA_Melee_LogTracer",function(ent,bulv) --Record tracer for blocking
	ent.TFALastTracer = bulv.TracerName or ""
end)

local npc_dmg_scale_cv = GetConVar("sv_tfa_melee_damage_npc")
local ply_dmg_scale_cv = GetConVar("sv_tfa_melee_damage_ply")

hook.Add("EntityTakeDamage", "TFA_Melee_Scaling", function( ent, dmginfo )
	local wep = dmginfo:GetInflictor()
	if not IsValid(wep) then return end
	if wep:IsPlayer() then wep = wep:GetActiveWeapon() end
	if not IsValid(wep) or not wep:IsWeapon() then return end
	if not wep.BlockDamageCap then return end
	if ent:IsNPC() then
		dmginfo:ScaleDamage( npc_dmg_scale_cv:GetFloat() )
	elseif ent:IsPlayer() then
		dmginfo:ScaleDamage( ply_dmg_scale_cv:GetFloat() )
	end
end) --Cancel
hook.Add("EntityTakeDamage", "aaa_TFA_Melee_Block", function( ent, dmginfo )
	return BlockDamageNew( ent, dmginfo )
end) --Cancel
hook.Add("ScalePlayerDamage", "aaa_TFA_Melee_Block", function( ent, _, dmginfo ) --Cancel
	return BlockDamageNew( ent, dmginfo )
end)

game.AddAmmoType({
	name = "TFMSwordHitGenericSlash",
	dmgtype = DMG_SLASH,
	tracer = TRACER_NONE
})

local function TFMPlayerSpawn(ply)
	ply:SetNW2Vector("TFM_SwordPosition", Vector(1, 1, 1))
	ply:SetNW2Vector("TFM_SwordNormal", Vector(1, 1, 1))
	ply:SetNW2Bool("TFM_IsSprinting", false)
	ply:SetNW2Bool("TFM_IsBlocking", false)
	ply:SetNW2Bool("TFM_IsSwinging", false)
	ply:SetNW2Float("TFM_SwingStart", CurTime())
end

hook.Add("PlayerSpawn", "TFM_PlayerSpawn", TFMPlayerSpawn)

hook.Add("EntityTakeDamage", "TFM_Block", function(ent, dmginfo) --Legacy
	if ent:IsPlayer() then
		local wep
		wep = ent:GetActiveWeapon()

		if (wep.IsTFAWeapon and wep.BlockAngle) and (dmginfo:IsDamageType(DMG_SLASH) or dmginfo:IsDamageType(DMG_CLUB) or (wep.NinjaMode and wep.NinjaMode == true and (dmginfo:IsDamageType(DMG_CRUSH) or dmginfo:IsDamageType(DMG_BULLET)))) and wep:GetIronSights() then
			local damageinflictor, blockthreshold
			damageinflictor = dmginfo:GetInflictor()

			if (not IsValid(damageinflictor)) then
				damageinflictor = dmginfo:GetAttacker()
			end

			blockthreshold = wep.BlockAngle / 2 or 90

			if (IsValid(damageinflictor) and (math.abs((ent:GetAimVector():Angle() - (damageinflictor:GetPos() - ent:GetPos()):Angle()).y) <= blockthreshold)) or (math.abs((ent:GetAimVector():Angle() - (dmginfo:GetDamagePosition() - ent:GetPos()):Angle()).y) <= blockthreshold) then
				local fac = math.Clamp((CurTime() - wep:GetBlockStart() - wep.BlockWindow) / wep.BlockFadeTime, 0, 1)
				local dmgscale
				if ( not timed_blocking_cv ) or timed_blocking_cv:GetBool() then
					dmgscale = Lerp(fac, wep.BlockMaximum, wep.BlockMinimum)
				else
					dmgscale = wep.BlockMaximum
				end
				--print(fac)
				dmginfo:ScaleDamage(dmgscale)
				dmginfo:SetDamagePosition(vector_origin)
				wep:EmitSound(wep.Primary.Sound_Impact_Metal)

				if wep.BlockAnim then
					wep:BlockAnim()
				end
			end
		end
	end
end)
--Getting the position and angle of an attachment and sending it back to the server is wayyy too laggy.  Must be pre-coded.
--[[
if SERVER then
	util.AddNetworkString( "TFM_SAPacket" )
	net.Receive("TFM_SAPacket", function()
		local ply;
		ply = net.ReadEntity()
		local pos;
		pos = net.ReadVector()
		local norm;
		norm = net.ReadNormal()
		if IsValid(ply) then
			if pos and norm then
				ply:SetNW2Vector("TFM_SwordPosition",pos)
				ply:SetNW2Vector("TFM_SwordNormal",norm)
			end
		end
	end)
end
]]
--