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

local supports
local cl_tfa_fx_dof, cl_tfa_fx_dof_hd
local fmat = CreateMaterial("TFA_DOF_Material4", "Refract", {
	["$model"] = "1",
	["$alpha"] = "1",
	["$alphatest"] = "1",
	["$normalmap"] = "effects/flat_normal",
	["$refractamount"] = "0.1",
	["$vertexalpha"] = "1",
	["$vertexcolor"] = "1",
	["$translucent"] = "1",
	["$forcerefract"] = "0",
	["$bluramount"] = "1.5",
	["$nofog"] = "1"
})

local fmat2 = CreateMaterial("TFA_DOF_Material5", "Refract", {
	["$model"] = "1",
	["$alpha"] = "1",
	["$alphatest"] = "1",
	["$normalmap"] = "effects/flat_normal",
	["$refractamount"] = "0.1",
	["$vertexalpha"] = "1",
	["$vertexcolor"] = "1",
	["$translucent"] = "1",
	["$forcerefract"] = "0",
	["$bluramount"] = "0.9",
	["$nofog"] = "1"
})

local fmat3 = CreateMaterial("TFA_DOF_Material16", "Refract", {
	["$model"] = "1",
	["$alpha"] = "1",
	["$alphatest"] = "1",
	["$normalmap"] = "effects/flat_normal",
	["$refractamount"] = "0.1",
	["$vertexalpha"] = "1",
	["$vertexcolor"] = "1",
	["$translucent"] = "1",
	["$forcerefract"] = "0",
	["$bluramount"] = "0.8",
	["$nofog"] = "1"
})

local white = CreateMaterial("TFA_DOF_White", "UnlitGeneric", {
	["$alpha"] = "0",
	["$basetexture"] = "models/debug/debugwhite"
})

TFA.LastRTUpdate = TFA.LastRTUpdate or UnPredictedCurTime()

hook.Add("PreDrawViewModel", "TFA_DrawViewModel", function(vm, plyv, wep)
	if not vm or not plyv or not wep then return end
	if not wep.IsTFAWeapon then return end

	if supports == nil then
		supports = render.SupportsPixelShaders_1_4() and render.SupportsPixelShaders_2_0() and render.SupportsVertexShaders_2_0()

		if not supports then
			print("[TFA] Your videocard does not support pixel shaders! DoF of Iron Sights is disabled!")
		end
	end

	if not supports then return end

	if not cl_tfa_fx_dof then
		cl_tfa_fx_dof = GetConVar("cl_tfa_fx_ads_dof")
	end

	if not cl_tfa_fx_dof or not cl_tfa_fx_dof:GetBool() then return end
	if not wep.AllowIronSightsDoF then return end
	local aimingDown = wep:GetIronSightsProgress() > 0.4
	local scoped = TFA.LastRTUpdate > UnPredictedCurTime() or wep:GetStatL("Scoped")

	if aimingDown and not scoped then
		if hook.Run("TFA_AllowDoFDraw", wep, plyv, vm) == false then return end
		wep.__TFA_AimDoFFrame = FrameNumber()
		render.ClearStencil()
		render.SetStencilEnable(true)
		render.SetStencilTestMask(0)
		render.SetStencilWriteMask(1)
		render.SetStencilReferenceValue(1)
		render.SetStencilCompareFunction(STENCIL_ALWAYS)
		render.OverrideColorWriteEnable(true, true)
		render.SetStencilZFailOperation(STENCIL_KEEP)
		render.SetStencilPassOperation(STENCIL_REPLACE)
		render.SetStencilFailOperation(STENCIL_KEEP)
	end
end)

local transparent = Color(0, 0, 0, 0)
local color_white = Color(255, 255, 255)
local STOP = false

local function DrawDOF(muzzledata,fwd2)
	local w, h = ScrW(), ScrH()
	render.SetMaterial(fmat)
	cam.Start2D()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(fmat)
	surface.DrawTexturedRect(0, 0, w, h)
	cam.End2D()

	if muzzledata then
		-- :POG:
		render.SetMaterial(fmat2)

		for i = 28, 2, -1 do
			render.UpdateScreenEffectTexture()
			render.DrawSprite(muzzledata.Pos - fwd2 * i * 3, 200, 200, color_white)
		end
	end

	render.SetMaterial(fmat3)
	cam.Start2D()
	surface.SetMaterial(fmat3)

	for i = 0, 32 do
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(0, h / 1.6 + h / 2 * i / 32, w, h / 2)
	end

	cam.End2D()
end

hook.Add("PostDrawViewModel", "TFA_DrawViewModel", function(vm, plyv, wep)
	if not wep.IsTFAWeapon then return end

	if not supports then
		wep:ViewModelDrawnPost()
		return
	end

	if not cl_tfa_fx_dof then
		cl_tfa_fx_dof = GetConVar("cl_tfa_fx_ads_dof")
	end

	if not cl_tfa_fx_dof_hd then
		cl_tfa_fx_dof_hd = GetConVar("cl_tfa_fx_ads_dof_hd")
	end

	if not cl_tfa_fx_dof or not cl_tfa_fx_dof:GetBool() then
		wep:ViewModelDrawnPost()
		return
	end

	if not wep.AllowIronSightsDoF then
		wep:ViewModelDrawnPost()
		return
	end

	local aimingDown = wep:GetIronSightsProgress() > 0.4
	local eangles = EyeAngles()
	local fwd2 = vm:GetAngles():Forward()
	local scoped = TFA.LastRTUpdate > UnPredictedCurTime()

	if aimingDown and not scoped and wep.__TFA_AimDoFFrame == FrameNumber() then
		fmat:SetFloat("$alpha", wep:GetIronSightsProgress())
		local muzzle = hook.Run("TFA_GetDoFMuzzleAttachmentID", wep, plyv, vm) or vm:LookupAttachment("muzzle")
		local muzzleflash = vm:LookupAttachment("muzzleflash")
		local muzzledata

		if muzzle and muzzle ~= 0 then
			muzzledata = vm:GetAttachment(muzzle)
		elseif wep.MuzzleAttachmentRaw then
			muzzledata = vm:GetAttachment(wep.MuzzleAttachmentRaw)
		elseif muzzleflash and muzzleflash ~= 0 then
			muzzledata = vm:GetAttachment(muzzleflash)
		end

		local hands = plyv:GetHands()

		if IsValid(hands) and wep.UseHands then
			render.OverrideColorWriteEnable(true, false)
			STOP = true
			local candraw = hook.Run("PreDrawPlayerHands", hands, vm, plyv, wep)
			STOP = false
			if candraw ~= true then
				if wep.ViewModelFlip then
					render.CullMode(MATERIAL_CULLMODE_CW)
				end

				hands:DrawModel()

				if wep.ViewModelFlip then
					render.CullMode(MATERIAL_CULLMODE_CCW)
				end
			end

			render.OverrideColorWriteEnable(false, false)
		end

		if muzzledata then
			render.SetStencilPassOperation(STENCIL_ZERO)
			render.SetMaterial(white)
			render.DrawSprite(muzzledata.Pos - fwd2 * 6 + eangles:Up() * 4, 30, 30, transparent)
			render.SetStencilPassOperation(STENCIL_REPLACE)
		end

		render.SetStencilTestMask(1)
		render.SetStencilWriteMask(2)
		render.SetStencilCompareFunction(STENCIL_EQUAL)
		render.SetStencilPassOperation(STENCIL_REPLACE)
		render.UpdateScreenEffectTexture()
		render.PushFilterMin(TEXFILTER.ANISOTROPIC)
		render.PushFilterMag(TEXFILTER.ANISOTROPIC)
		if cl_tfa_fx_dof_hd and cl_tfa_fx_dof_hd:GetBool() then
			DrawDOF(muzzledata,fwd2)
		else
			DrawToyTown(3,ScrH() * 2 / 3 )
		end
		render.PopFilterMin()
		render.PopFilterMag()
		--render.PopRenderTarget()
		render.SetStencilEnable(false)
	end

	wep:ViewModelDrawnPost()
end)

hook.Add("PreDrawPlayerHands", "TFA_DrawViewModel", function(hands, vm, plyv, wep)
	if STOP then return end
	if not wep.IsTFAWeapon then return end
	if not supports then return end

	if not cl_tfa_fx_dof then
		cl_tfa_fx_dof = GetConVar("cl_tfa_fx_ads_dof")
	end

	if not cl_tfa_fx_dof or not cl_tfa_fx_dof:GetBool() then return end
	if not wep.AllowIronSightsDoF then return end
	if TFA.LastRTUpdate > UnPredictedCurTime() then return end
	if wep:GetIronSightsProgress() > 0.4 then return true end
end)

hook.Add("PostDrawPlayerHands", "TFA_DrawViewModel", function(hands, vm, plyv, wep)
	if not wep.IsTFAWeapon then return end

	wep:ViewModelDrawnPostFinal()
end)
