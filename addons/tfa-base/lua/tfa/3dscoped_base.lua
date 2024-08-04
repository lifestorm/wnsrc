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

local SWEP = {}

local BaseClass = baseclass.Get("tfa_gun_base")

local scopecvar = GetConVar("cl_tfa_3dscope")
local scopeshadowcvar = GetConVar("cl_tfa_3dscope_overlay")

local sp = game.SinglePlayer()

function SWEP:Do3DScope()
	if scopecvar then
		return scopecvar:GetBool()
	else
		if self:OwnerIsValid() and self:GetOwner().GetInfoNum then
			return self:GetOwner():GetInfoNum("cl_tfa_3dscope", 1) == 1
		else
			return true
		end
	end
end

function SWEP:Do3DScopeOverlay()
	if scopeshadowcvar then
		return scopeshadowcvar:GetBool()
	else
		return false
	end
end

function SWEP:UpdateScopeType(force)
	if not self.HasInitialized then return end

	local target = self.Secondary_TFA or self.Secondary

	if self.Scoped_3D and force then
		self.Scoped = true
		self.Scoped_3D = false

		if target.ScopeZoom_Backup then
			target.ScopeZoom = target.ScopeZoom_Backup
		else
			target.ScopeZoom = 90 / self:GetStatRawL("Secondary.OwnerFOV") -- M9K/Older TFA Base compatibility
		end

		if self.BoltAction_3D then
			self.BoltAction = true
			self.BoltAction_3D = nil

			self:ClearStatCache("BoltAction")
		end

		self:SetStatRawL("Secondary.OwnerFOV", 90 / self:GetStatRawL("Secondary.ScopeZoom"))
		self.IronSightsSensitivity = 1
	end

	if self:Do3DScope() then
		self.Scoped = false
		self.Scoped_3D = true

		if not target.ScopeZoom_Backup then
			target.ScopeZoom_Backup = target.ScopeZoom
		end

		if self.BoltAction then
			self.BoltAction_3D = true
			self.BoltAction = self.BoltAction_Forced or false
			self.Primary.DisableChambering = true
			self.FireModeName = "tfa.firemode.bolt"
		end

		if target.ScopeZoom and target.ScopeZoom > 0 then
			if CLIENT then
				self.RTScopeFOV = 90 / target.ScopeZoom * (target.ScopeScreenScale or 0.392592592592592)
			end

			-- target.IronFOV_Backup = self:GetStatRawL("Secondary.OwnerFOV", 70)
			-- self:SetStatRawL("Secondary.OwnerFOV", 70)
			-- self:ClearStatCacheL("Secondary.OwnerFOV")

			if CLIENT then
				self.IronSightsSensitivity = self:Get3DSensitivity()
			end

			target.ScopeZoom = false
		end
	else
		self.Scoped = true
		self.Scoped_3D = false

		if target.ScopeZoom_Backup then
			target.ScopeZoom = target.ScopeZoom_Backup
		else
			target.ScopeZoom = 4
		end

		if self.BoltAction_3D then
			self.BoltAction = true
			self.BoltAction_3D = nil

			self:ClearStatCache("BoltAction")
		end

		self:SetStatRawL("Secondary.OwnerFOV", 90 / target.ScopeZoom)
		self.IronSightsSensitivity = 1

		self:ClearStatCacheL("Secondary.OwnerFOV")
	end
end

function SWEP:Initialize(...)
	local unsetA = self.Primary_TFA == nil
	local unsetB = self.Secondary_TFA == nil

	self.Primary_TFA = self.Primary_TFA or self.Primary
	self.Secondary_TFA = self.Secondary_TFA or self.Secondary
	self:UpdateScopeType()

	if unsetA then
		self.Primary_TFA = nil
	end

	if unsetB then
		self.Secondary_TFA = nil
	end

	BaseClass.Initialize(self, ...)

	timer.Simple(0, function()
		if IsValid(self) and self:OwnerIsValid() then
			self:UpdateScopeType()
		end
	end)
end

function SWEP:Deploy(...)
	if SERVER and self:OwnerIsValid() and sp then
		self:CallOnClient("UpdateScopeType", "")
	end

	self:UpdateScopeType()

	timer.Simple(0, function()
		if IsValid(self) and self:OwnerIsValid() then
			self:UpdateScopeType()
		end
	end)

	return BaseClass.Deploy(self,...)
end

local flipcv = GetConVar("cl_tfa_viewmodel_flip")
local cd = {}
local crosscol = Color(255, 255, 255, 255)
SWEP.RTOpaque = true

local cv_cc_r = GetConVar("cl_tfa_hud_crosshair_color_r")
local cv_cc_g = GetConVar("cl_tfa_hud_crosshair_color_g")
local cv_cc_b = GetConVar("cl_tfa_hud_crosshair_color_b")
local cv_cc_a = GetConVar("cl_tfa_hud_crosshair_color_a")

SWEP.defaultscrvec = Vector()

function SWEP:RTCode(rt, scrw, scrh)
	local legacy = self.ScopeLegacyOrientation
	local rttw = ScrW()
	local rtth = ScrH()

	if not self:VMIV() then return end

	if not self.myshadowmask then
		self.myshadowmask = surface.GetTextureID(self.ScopeShadow or "vgui/scope_shadowmask_test")
	end

	if not self.myreticule then
		self.myreticule = Material(self.ScopeReticule or "scope/gdcw_scopesightonly")
	end

	if not self.mydirt then
		self.mydirt = Material(self.ScopeDirt or "vgui/scope_dirt")
	end

	local vm = self.OwnerViewModel

	if not self.LastOwnerPos then
		self.LastOwnerPos = self:GetOwner():GetShootPos()
	end

	local owoff = self:GetOwner():GetShootPos() - self.LastOwnerPos

	self.LastOwnerPos = self:GetOwner():GetShootPos()

	local scrpos

	if self.RTScopeAttachment and self.RTScopeAttachment > 0 then
		vm:SetupBones()
		local att = vm:GetAttachment( self.RTScopeAttachment or 1 )
		if not att then return end
		local pos = att.Pos - owoff
		cam.Start3D()
		cam.End3D()
		scrpos = pos:ToScreen()
	else
		self.defaultscrvec.x = scrw / 2
		self.defaultscrvec.y = scrh / 2
		scrpos = self.defaultscrvec
	end

	scrpos.x = scrpos.x - scrw / 2 + self.ScopeOverlayTransforms[1]
	scrpos.y = scrpos.y - scrh / 2 + self.ScopeOverlayTransforms[2]
	scrpos.x = scrpos.x / scrw * 1920
	scrpos.y = scrpos.y / scrw * 1920
	scrpos.x = math.Clamp(scrpos.x, -1024, 1024)
	scrpos.y = math.Clamp(scrpos.y, -1024, 1024)
	--scrpos.x = scrpos.x * ( 2 - self:GetIronSightsProgress()*1 )
	--scrpos.y = scrpos.y * ( 2 - self:GetIronSightsProgress()*1 )
	scrpos.x = scrpos.x * self.ScopeOverlayTransformMultiplier
	scrpos.y = scrpos.y * self.ScopeOverlayTransformMultiplier

	if not self.scrpos then
		self.scrpos = scrpos
	end

	self.scrpos.x = math.Approach(self.scrpos.x, scrpos.x, (scrpos.x - self.scrpos.x) * FrameTime() * 10)
	self.scrpos.y = math.Approach(self.scrpos.y, scrpos.y, (scrpos.y - self.scrpos.y) * FrameTime() * 10)
	scrpos = self.scrpos
	render.OverrideAlphaWriteEnable(true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-512, -512, 1024, 1024)
	render.OverrideAlphaWriteEnable(true, true)

	local ang = legacy and self:GetOwner():EyeAngles() or vm:GetAngles()

	if self.RTScopeAttachment and self.RTScopeAttachment > 0 then
		vm:SetupBones()
		local AngPos = vm:GetAttachment( self.RTScopeAttachment )

		if AngPos then
			ang = AngPos.Ang

			if flipcv:GetBool() then
				ang.y = -ang.y
			end

			for _, v in pairs(self.ScopeAngleTransforms) do
				if v[1] == "P" then
					ang:RotateAroundAxis(ang:Right(), v[2])
				elseif v[1] == "Y" then
					ang:RotateAroundAxis(ang:Up(), v[2])
				elseif v[1] == "R" then
					ang:RotateAroundAxis(ang:Forward(), v[2])
				end
			end
		end
	else
		local isang = self:GetStatL("IronSightsAngle") * self:GetIronSightsProgress()

		ang:RotateAroundAxis(ang:Forward(), -isang.z)
		ang:RotateAroundAxis(ang:Right(), -isang.x)
		ang:RotateAroundAxis(ang:Up(), -isang.y)

		ang:RotateAroundAxis(ang:Forward(), isang.z)
	end

	cd.angles = ang
	cd.origin = self:GetOwner():GetShootPos()

	if not self.RTScopeOffset then
		self.RTScopeOffset = {0, 0}
	end

	if not self.RTScopeScale then
		self.RTScopeScale = {1, 1}
	end

	local rtow, rtoh = self.RTScopeOffset[1], self.RTScopeOffset[2]
	local rtw, rth = rttw * self.RTScopeScale[1], rtth * self.RTScopeScale[2]

	cd.x = 0
	cd.y = 0
	cd.w = rtw
	cd.h = rth
	cd.fov = self.RTScopeFOV
	cd.drawviewmodel = false
	cd.drawhud = false
	render.Clear(0, 0, 0, 255, true, true)
	render.SetScissorRect(0 + rtow, 0 + rtoh, rtw + rtow, rth + rtoh, true)

	if self:GetIronSightsProgress() > 0.01 and self.Scoped_3D then
		render.RenderView(cd)
	end

	render.SetScissorRect(0, 0, rtw, rth, false)
	render.OverrideAlphaWriteEnable(false, true)
	cam.Start2D()
	draw.NoTexture()
	surface.SetTexture(self.myshadowmask)
	surface.SetDrawColor(color_white)

	if self:Do3DScopeOverlay() then
		surface.DrawTexturedRect(scrpos.x + rtow - rtw / 2, scrpos.y + rtoh - rth / 2, rtw * 2, rth * 2)
	end

	if self.ScopeReticule_CrossCol then
		crosscol.r = cv_cc_r:GetFloat()
		crosscol.g = cv_cc_g:GetFloat()
		crosscol.b = cv_cc_b:GetFloat()
		crosscol.a = cv_cc_a:GetFloat()
		surface.SetDrawColor(crosscol)
	end

	surface.SetMaterial(self.myreticule)
	local tmpborderw = rtw * (1 - self.ScopeReticule_Scale[1]) / 2
	local tmpborderh = rth * (1 - self.ScopeReticule_Scale[2]) / 2
	surface.DrawTexturedRect(rtow + tmpborderw, rtoh + tmpborderh, rtw - tmpborderw * 2, rth - tmpborderh * 2)
	surface.SetDrawColor(color_black)
	draw.NoTexture()

	if self:Do3DScopeOverlay() then
		surface.DrawRect(scrpos.x - 2048 + rtow, -1024 + rtoh, 2048, 2048)
		surface.DrawRect(scrpos.x + rtw + rtow, -1024 + rtoh, 2048, 2048)
		surface.DrawRect(-1024 + rtow, scrpos.y - 2048 + rtoh, 2048, 2048)
		surface.DrawRect(-1024 + rtow, scrpos.y + rth + rtoh, 2048, 2048)
	end

	surface.SetDrawColor(ColorAlpha(color_black, 255 - 255 * (math.Clamp(self:GetIronSightsProgress() - 0.75, 0, 0.25) * 4)))
	surface.DrawRect(-1024 + rtow, -1024 + rtoh, 2048, 2048)
	surface.SetMaterial(self.mydirt)
	surface.SetDrawColor(ColorAlpha(color_white, 128))
	surface.DrawTexturedRect(0, 0, rtw, rth)
	surface.SetDrawColor(ColorAlpha(color_white, 64))
	surface.DrawTexturedRectUV(rtow, rtoh, rtw, rth, 2, 0, 0, 2)
	cam.End2D()
end

return SWEP
