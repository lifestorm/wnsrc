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

local vector_up = Vector(0, 0, 1)
local math = math
local render = render
local LerpVector = LerpVector

--[[
Function Name:  ComputeSmokeLighting
Syntax: self:ComputeSmokeLighting(pos, nrm, pcf).
Returns:  Nothing.
Notes:	Used to light the muzzle smoke trail, by setting its PCF Control Point 1
Purpose:  FX
]]--
function SWEP:ComputeSmokeLighting( pos, nrm, pcf )
	if not IsValid(pcf) then return end
	local licht = render.ComputeLighting(pos, nrm)
	local lichtFloat = math.Clamp((licht.r + licht.g + licht.b) / 3, 0, TFA.Particles.SmokeLightingClamp) / TFA.Particles.SmokeLightingClamp
	local lichtFinal = LerpVector(lichtFloat, TFA.Particles.SmokeLightingMin, TFA.Particles.SmokeLightingMax)
	pcf:SetControlPoint(1, lichtFinal)
end

--[[
Function Name:  SmokePCFLighting
Syntax: self:SmokePCFLighting().
Returns:  Nothing.
Notes:	Used to loop through all of our SmokePCF tables and call ComputeSmokeLighting on them
Purpose:  FX
]]--
function SWEP:SmokePCFLighting()
	local mzPos = self:GetMuzzlePos()
	if not mzPos or not mzPos.Pos then return end
	local pos = mzPos.Pos
	if self.SmokePCF then
		for _, v in pairs(self.SmokePCF) do
			self:ComputeSmokeLighting(pos, vector_up, v)
		end
	end
	if not self:VMIV() then return end
	local vm = self.OwnerViewModel
	if vm.SmokePCF then
		for _, v in pairs(vm.SmokePCF) do
			self:ComputeSmokeLighting(pos, vector_up, v)
		end
	end
end

--[[
Function Name:  FireAnimationEvent
Syntax: self:FireAnimationEvent( position, angle, event id, options).
Returns:  Nothing.
Notes:	Used to capture and disable viewmodel animation events, unless you disable that feature.
Purpose:  FX
]]--
function SWEP:FireAnimationEvent(pos, ang, event, options)
	if self.CustomMuzzleFlash or not self.MuzzleFlashEnabled then
		-- Disables animation based muzzle event
		if (event == 21) then return true end
		-- Disable thirdperson muzzle flash
		if (event == 5003) then return true end

		-- Disable CS-style muzzle flashes, but chance our muzzle flash attachment if one is given.
		if (event == 5001 or event == 5011 or event == 5021 or event == 5031) then
			if self.AutoDetectMuzzleAttachment then
				self.MuzzleAttachmentRaw = math.Clamp(math.floor((event - 4991) / 10), 1, 4)
				self:ShootEffectsCustom(true)
			end

			return true
		end
	end

	if (self.LuaShellEject and event ~= 5004) then return true end
end

--[[
Function Name:  MakeMuzzleSmoke
Syntax: self:MakeMuzzleSmoke( entity, attachment).
Returns:  Nothing.
Notes:	Deprecated. Used to make the muzzle smoke effect, clientside.
Purpose:  FX
]]--

local limit_particle_cv  = GetConVar("cl_tfa_fx_muzzlesmoke_limited")

function SWEP:MakeMuzzleSmoke(entity, attachment)
	if ( not limit_particle_cv ) or limit_particle_cv:GetBool() then
		self:CleanParticles()
	end
	local ht = self.DefaultHoldType and self.DefaultHoldType or self.HoldType

	if (CLIENT and TFA.GetMZSmokeEnabled() and IsValid(entity) and attachment and attachment ~= 0) then
		ParticleEffectAttach(self.SmokeParticles[ht], PATTACH_POINT_FOLLOW, entity, attachment)
	end
end

--[[
Function Name:  ImpactEffect
Syntax: self:ImpactEffect( position, normal (ang:Up()), materialt ype).
Returns:  Nothing.
Notes:	Used to make the impact effect.  See utilities code for CanDustEffect.
Purpose:  FX
]]--

function SWEP:DoImpactEffect(tr, dmgtype)
	if tr.HitSky then return true end
	local ib = self.BashBase and IsValid(self) and self:GetBashing()
	local dmginfo = DamageInfo()
	dmginfo:SetDamageType(dmgtype)

	if dmginfo:IsDamageType(DMG_SLASH) or (ib and self.Secondary_TFA.BashDamageType == DMG_SLASH and tr.MatType ~= MAT_FLESH and tr.MatType ~= MAT_ALIENFLESH) or (self and self.DamageType and self.DamageType == DMG_SLASH) then
		util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

		return true
	end

	if ib and self.Secondary_TFA.BashDamageType == DMG_GENERIC then return true end
	if ib then return end

	if IsValid(self) then
		self:ImpactEffectFunc(tr.HitPos, tr.HitNormal, tr.MatType)
	end

	if self.ImpactDecal and self.ImpactDecal ~= "" then
		util.Decal(self.ImpactDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

		return true
	end
end

local impact_cl_enabled = GetConVar("cl_tfa_fx_impact_enabled")
local impact_sv_enabled = GetConVar("sv_tfa_fx_impact_override")

function SWEP:ImpactEffectFunc(pos, normal, mattype)
	local enabled

	if impact_cl_enabled then
		enabled = impact_cl_enabled:GetBool()
	else
		enabled = true
	end

	if impact_sv_enabled and impact_sv_enabled:GetInt() >= 0 then
		enabled = impact_sv_enabled:GetBool()
	end

	if enabled then
		local fx = EffectData()
		fx:SetOrigin(pos)
		fx:SetNormal(normal)

		if self:CanDustEffect(mattype) then
			TFA.Effects.Create("tfa_dust_impact", fx)
		end

		if self:CanSparkEffect(mattype) then
			TFA.Effects.Create("tfa_metal_impact", fx)
		end

		local scal = math.sqrt(self:GetStatL("Primary.Damage") / 30)
		if mattype == MAT_FLESH then
			scal = scal * 0.25
		end
		fx:SetEntity(self:GetOwner())
		fx:SetMagnitude(mattype or 0)
		fx:SetScale( scal )
		TFA.Effects.Create("tfa_bullet_impact", fx)

		if self.ImpactEffect then
			TFA.Effects.Create(self.ImpactEffect, fx)
		end
	end
end