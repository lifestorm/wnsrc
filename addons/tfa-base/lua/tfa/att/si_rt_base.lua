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

if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "RT Scope Base"
ATTACHMENT.Description = {}

ATTACHMENT.WeaponTable = {
	["RTDrawEnabled"] = true,

	-- ["RTScopeFOV"] = 90 / 1 / 2, -- Default FOV / Scope Zoom / screenscale
	-- ["RTScopeAttachment"] = -1,

	-- ["RTReticleMaterial"] = Material("scope/gdcw_acog"),
	-- ["RTReticleColor"] = color_white,
	-- ["RTReticleScale"] = 1,

	-- ["RTShadowMaterial"] = Material("vgui/scope_shadowmask_test"),
	-- ["RTShadowColor"] = color_white,
	-- ["RTShadowScale"] = 2,
}

local cd = {}

local fallbackReticle = Material("scope/gdcw_scopesightonly")
local fallbackShadow = Material("vgui/scope_shadowmask_test")

local flipcv = GetConVar("cl_tfa_viewmodel_flip")

function ATTACHMENT:RTCode(wep, rt, scrw, scrh)
	if not wep.OwnerIsValid or not wep:VMIV() then return end

	local rtw, rth = rt:Width(), rt:Height()

	-- clearing view
	render.OverrideAlphaWriteEnable(true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-rtw, -rth, rtw * 2, rth * 2)

	local vm = wep.OwnerViewModel

	local ang = vm:GetAngles()

	local isang = wep:GetStatL("IronSightsAngle") * wep:GetIronSightsProgress()

	ang:RotateAroundAxis(ang:Forward(), -isang.z)
	ang:RotateAroundAxis(ang:Right(), -isang.x)
	ang:RotateAroundAxis(ang:Up(), -isang.y)

	ang:RotateAroundAxis(ang:Forward(), isang.z)

	local scopeAtt = wep:GetStatL("RTScopeAttachment", -1)

	if scopeAtt > 0 then
		local AngPos = vm:GetAttachment(scopeAtt)

		if AngPos then
			ang = AngPos.Ang

			if flipcv:GetBool() then
				ang.y = -ang.y
			end
		end
	end

	cd.angles = ang
	cd.origin = wep:GetOwner():GetShootPos()
	cd.x = 0
	cd.y = 0
	cd.w = rtw
	cd.h = rth
	cd.fov = wep:GetStatL("RTScopeFOV", 90 / wep:GetStatL("ScopeZoom", 1) / 2)
	cd.drawviewmodel = false
	cd.drawhud = false

	-- main RT render view
	render.Clear(0, 0, 0, 255, true, true)
	render.SetScissorRect(0, 0, rtw, rth, true)

	if wep:GetIronSightsProgress() > 0.005 then
		render.RenderView(cd)
	end

	render.SetScissorRect(0, 0, rtw, rth, false)
	render.OverrideAlphaWriteEnable(false, true)

	cam.Start2D()

	-- ADS transition darkening
	draw.NoTexture()
	surface.SetDrawColor(ColorAlpha(color_black, 255 * (1 - wep:GetIronSightsProgress())))
	surface.DrawRect(0, 0, rtw, rth)

	surface.SetMaterial(wep:GetStatL("RTReticleMaterial", fallbackReticle))
	surface.SetDrawColor(wep:GetStatL("RTReticleColor", color_white))
	local retScale = wep:GetStatL("RTReticleScale", 1)
	surface.DrawTexturedRect(rtw / 2 - rtw * retScale / 2, rth / 2 - rth * retScale / 2, rtw * retScale, rth * retScale)

	surface.SetMaterial(wep:GetStatL("RTShadowMaterial", fallbackShadow))
	surface.SetDrawColor(wep:GetStatL("RTShadowColor", color_white))
	local shadScale = wep:GetStatL("RTShadowScale", 2)
	surface.DrawTexturedRect(rtw / 2 - rtw * shadScale / 2, rth / 2 - rth * shadScale / 2, rtw * shadScale, rth * shadScale)

	cam.End2D()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
