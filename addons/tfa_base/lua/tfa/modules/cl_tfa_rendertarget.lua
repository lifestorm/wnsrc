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

TFA.DrawingRenderTarget = false

local props = {
	["$translucent"] = 1
}

local TFA_RTMat = CreateMaterial("tfa_rtmaterial", "UnLitGeneric", props) --Material("models/weapons/TFA/shared/optic")
local TFA_RTScreen, TFA_RTScreenO = {}, {}
local tgt
local old_bt
local ply, vm, wep
local w, h
local qualitySizes

local function callFunc()
	if wep.RTCode then
		wep:RTCode(TFA_RTMat, w, h)
	end

	if wep:GetStatL("RTDrawEnabled") then
		wep:CallAttFunc("RTCode", TFA_RTMat, w, h)
	end
end

hook.Add("OnScreenSizeChanged", "TFA_rendertargets", function()
	qualitySizes = nil
	TFA_RTScreen, TFA_RTScreenO = {}, {}
end)

local function TFARenderScreen()
	ply = GetViewEntity()

	if not IsValid(ply) or not ply:IsPlayer() then
		ply = LocalPlayer()

		return
	end

	if not IsValid(vm) then
		vm = ply:GetViewModel()

		return
	end

	wep = ply:GetActiveWeapon()

	if not IsValid(wep) or not wep.IsTFAWeapon then return end

	if not wep.MaterialCached then
		wep.MaterialCached = true
		wep.MaterialCached_V = nil
		wep.MaterialCached_W = nil
	end

	local skinStat = wep:GetStatL("Skin")
	if isnumber(skinStat) then
		if vm:GetSkin() ~= skinStat then
			vm:SetSkin(skinStat)
		end
	end

	if wep:GetStatL("MaterialTable_V") and not wep.MaterialCached_V then
		wep.MaterialCached_V = {}
		vm:SetSubMaterial()
		local collectedKeys = table.GetKeys(wep:GetStatL("MaterialTable_V"))
		table.Merge(collectedKeys, table.GetKeys(wep:GetStatL("MaterialTable")))

		for _, k in pairs(collectedKeys) do
			if k ~= "BaseClass" then
				local v = wep:GetStatL("MaterialTable_V")[k]

				if not wep.MaterialCached_V[k] then
					vm:SetSubMaterial(k - 1, v)
					wep.MaterialCached_V[k] = true
				end
			end
		end
	end

	if not (wep:GetStatL("RTDrawEnabled") or wep.RTCode ~= nil) then return end
	w, h = ScrW(), ScrH()

	if not qualitySizes then
		qualitySizes = {
			[0] = h,
			[1] = math.Round(h * 0.5),
			[2] = math.Round(h * 0.25),
			[3] = math.Round(h * 0.125),
		}
	end

	local quality = TFA.RTQuality()

	if wep:GetStatL("RTOpaque") then
		tgt = TFA_RTScreenO[quality]

		if not tgt then
			local size = qualitySizes[quality]
			tgt = GetRenderTargetEx("TFA_RT_ScreenO_" .. size, size, size, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SHARED, 0, CREATERENDERTARGETFLAGS_UNFILTERABLE_OK, IMAGE_FORMAT_RGB888)
			TFA_RTScreenO[quality] = tgt
		end
	else
		tgt = TFA_RTScreen[quality]

		if not tgt then
			local size = qualitySizes[quality]
			tgt = GetRenderTargetEx("TFA_RT_Screen_" .. size, size, size, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SHARED, 0, CREATERENDERTARGETFLAGS_UNFILTERABLE_OK, IMAGE_FORMAT_RGBA8888)
			TFA_RTScreen[quality] = tgt
		end
	end

	TFA.LastRTUpdate = CurTime() + 0.01

	render.PushRenderTarget(tgt)
	render.Clear(0, 0, 0, 255, true, true)

	TFA.DrawingRenderTarget = true
	render.CullMode(MATERIAL_CULLMODE_CCW)
	ProtectedCall(callFunc)
	TFA.DrawingRenderTarget = false

	render.SetScissorRect(0, 0, 0, 0, false)
	render.PopRenderTarget()

	if old_bt ~= tgt then
		TFA_RTMat:SetTexture("$basetexture", tgt)
		old_bt = tgt
	end

	if wep:GetStatL("RTMaterialOverride", -1) >= 0 then
		wep:GetOwner():GetViewModel():SetSubMaterial(wep:GetStatL("RTMaterialOverride"), "!tfa_rtmaterial")
	end
end

hook.Remove("PostRender", "TFASCREENS")

hook.Add("PreRender", "TFASCREENS", function()
	if not TFA.RT_DRAWING then
		TFA.RT_DRAWING = true
		TFARenderScreen()
		TFA.RT_DRAWING = false
	end
end)

TFA.RT_DRAWING = false
