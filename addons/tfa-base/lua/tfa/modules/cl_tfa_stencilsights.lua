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

-- stencil functions
local useStencils = render.SupportsPixelShaders_2_0() and render.SupportsVertexShaders_2_0()

local function defineCanvas(ref)
	render.UpdateScreenEffectTexture()
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_REPLACE)
	render.SetStencilWriteMask(255)
	render.SetStencilTestMask(255)
	render.SetStencilReferenceValue(ref or 54)
end

local function drawOn()
	render.SetStencilCompareFunction(STENCIL_EQUAL)
end

local function stopCanvas()
	render.SetStencilEnable(false)
end

-- main draw functions
local CachedMaterials = {}

local DrawFunctions = {}

do -- Flat reticle, stays at center or moves with recoil
	local function ScreenScaleH(num)
		return num * (ScrH() / 480)
	end

	DrawFunctions[TFA.Enum.RETICLE_FLAT] = function(vm, ply, wep, SightElementTable)
		local ReticleMaterial = wep:GetStat("StencilSight_ReticleMaterial")
		if not ReticleMaterial then return end

		if type(ReticleMaterial) == "string" then
			CachedMaterials[ReticleMaterial] = CachedMaterials[ReticleMaterial] or Material(ReticleMaterial, "noclamp nocull smooth")
			ReticleMaterial = CachedMaterials[ReticleMaterial]
		end

		local ReticleSize = wep:GetStat("StencilSight_ReticleSize")
		if not ReticleSize then return end

		if wep:GetStat("StencilSight_ScaleReticleByScreenHeight", true) then
			ReticleSize = ScreenScaleH(ReticleSize)
		end

		if wep:GetStat("StencilSight_ScaleReticleByProgress", true) then
			ReticleSize = ReticleSize * wep.IronSightsProgress
		end

		local w, h = ScrW(), ScrH()

		local x, y = w * .5, h * .5
		if wep:GetStat("StencilSight_FollowRecoil", true) then
			x, y = TFA.LastCrosshairPosX or x, TFA.LastCrosshairPosY or y
		end

		local TargetColor = wep:GetStat("StencilSight_ReticleTint", color_white)

		if wep:GetStat("StencilSight_ReticleTintBySightColor", false) and IsValid(wep:GetOwner()) then
			local Owner = wep:GetOwner()

			local _GetNWVector = Owner.GetNW2Vector or Owner.GetNWVector

			local ColorVec = _GetNWVector(Owner, "TFAReticuleColor")

			if ColorVec then
				TargetColor = Color(ColorVec.x, ColorVec.y, ColorVec.z)
			end
		end

		if wep:GetStat("StencilSight_FadeReticleByProgress", false) then
			TargetColor = ColorAlpha(TargetColor, wep.IronSightsProgress * 255)
		end

		cam.Start2D(0, 0, w, h)
			surface.SetMaterial(ReticleMaterial)
			surface.SetDrawColor(TargetColor)
			surface.DrawTexturedRect(x - ReticleSize * .5, y - ReticleSize * .5, ReticleSize, ReticleSize)
		cam.End2D()
	end
end

do -- Model reticle, for when you don't have an attach point
	if IsValid(TFA.SightReticleEnt) then
		TFA.SightReticleEnt:Remove()
		TFA.SightReticleEnt = nil
	end

	TFA.SightReticleEnt = ClientsideModel("models/error.mdl", RENDERGROUP_VIEWMODEL)
	TFA.SightReticleEnt:SetNoDraw(true)

	local SightReticleEnt = TFA.SightReticleEnt

	DrawFunctions[TFA.Enum.RETICLE_MODEL] = function(vm, ply, wep, SightElementTable)
		if not SightElementTable.reticle then return end

		local SightElementModel = SightElementTable.curmodel

		SightReticleEnt:SetModel(SightElementTable.reticle)
		if SightReticleEnt:GetModel() == "models/error.mdl" then return end

		local matrix = Matrix()
		matrix:Scale(SightElementTable.size)
		SightReticleEnt:EnableMatrix("RenderMultiply", matrix)

		if SightReticleEnt:GetParent() ~= SightElementModel then
			SightReticleEnt:SetParent(SightElementModel)
			SightReticleEnt:SetPos(SightElementModel:GetPos())
			SightReticleEnt:SetAngles(SightElementModel:GetAngles())

			if not SightReticleEnt:IsEffectActive(EF_BONEMERGE) then
				SightReticleEnt:AddEffects(EF_BONEMERGE)
				SightReticleEnt:AddEffects(EF_BONEMERGE_FASTCULL)
			end
		end

		if wep.ViewModelFlip then render.CullMode(MATERIAL_CULLMODE_CW) end
		if wep:GetStat("StencilSight_FadeReticleByProgress", false) then
			local oldBlend = render.GetBlend()

			render.SetBlend(wep.IronSightsProgress)
			SightReticleEnt:DrawModel()
			render.SetBlend(oldBlend)
		else
			SightReticleEnt:DrawModel()
		end
		if wep.ViewModelFlip then render.CullMode(MATERIAL_CULLMODE_CCW) end

		if wep:GetStat("StencilSight_EnableQuad") then
			DrawFunctions[TFA.Enum.RETICLE_QUAD](vm, ply, wep, SightElementTable)
		end
	end
end

do -- Quad/Attach reticle, TFA INS2 method
	local function GetTargetPosition(wep, SightElementTable)
		local TargetEntity = SightElementTable.curmodel
		if not IsValid(TargetEntity) then return end

		local Type = wep:GetStat("StencilSight_PositionType", TFA.Enum.SIGHTSPOS_ATTACH)

		local pos, ang

		if Type == TFA.Enum.SIGHTSPOS_ATTACH then
			local AttachmentID = wep:GetStat("StencilSight_ReticleAttachment")
			if not AttachmentID then return end

			if type(AttachmentID) == "string" then
				AttachmentID = TargetEntity:LookupAttachment(AttachmentID)
			end

			if not AttachmentID or AttachmentID <= 0 then return end

			local Attachment = TargetEntity:GetAttachment(AttachmentID)
			if not Attachment.Pos or not Attachment.Ang then return end

			pos, ang = Attachment.Pos, Attachment.Ang
		elseif Type == TFA.Enum.SIGHTSPOS_BONE then
			local BoneID = wep:GetStat("StencilSight_ReticleBone")

			if type(BoneID) == "string" then
				BoneID = TargetEntity:LookupBone(BoneID)
			end

			if not BoneID or BoneID < 0 then return end

			pos, ang = TargetEntity:GetBonePosition(BoneID)

			if pos == TargetEntity:GetPos() then
				pos = TargetEntity:GetBoneMatrix(BoneID):GetTranslation()
				ang = TargetEntity:GetBoneMatrix(BoneID):GetAngles()
			end
		else
			return
		end

		local OffsetPos = wep:GetStat("StencilSight_ReticleOffsetPos")
		if OffsetPos then
			pos = pos + ang:Right() * OffsetPos.x + ang:Forward() * OffsetPos.y + ang:Up() * OffsetPos.z
		end

		local OffsetAng = wep:GetStat("StencilSight_ReticleOffsetAng")
		if OffsetAng then
			ang:RotateAroundAxis(ang:Right(), OffsetAng.p)
			ang:RotateAroundAxis(ang:Up(), OffsetAng.y)
			ang:RotateAroundAxis(ang:Forward(), OffsetAng.r)
		end

		return pos, ang
	end

	DrawFunctions[TFA.Enum.RETICLE_QUAD] = function(vm, ply, wep, SightElementTable)
		local ReticleMaterial = wep:GetStat("StencilSight_ReticleMaterial")
		if not ReticleMaterial then return end

		if type(ReticleMaterial) == "string" then
			CachedMaterials[ReticleMaterial] = CachedMaterials[ReticleMaterial] or Material(ReticleMaterial, "noclamp nocull smooth")
			ReticleMaterial = CachedMaterials[ReticleMaterial]
		end

		local ReticleSize = wep:GetStat("StencilSight_ReticleSize")
		if not ReticleSize then return end

		if wep:GetStat("StencilSight_ScaleReticleByProgress", false) then
			ReticleSize = ReticleSize * wep.IronSightsProgress
		end

		local TargetColor = wep:GetStat("StencilSight_ReticleTint", color_white)

		if wep:GetStat("StencilSight_ReticleTintBySightColor", false) and IsValid(wep:GetOwner()) then
			local Owner = wep:GetOwner()

			local _GetNWVector = Owner.GetNW2Vector or Owner.GetNWVector

			local ColorVec = _GetNWVector(Owner, "TFAReticuleColor")

			if ColorVec then
				TargetColor = Color(ColorVec.x, ColorVec.y, ColorVec.z)
			end
		end

		if wep:GetStat("StencilSight_FadeReticleByProgress", false) then
			TargetColor = ColorAlpha(TargetColor, wep.IronSightsProgress * 255)
		end

		local p, a = GetTargetPosition(wep, SightElementTable)
		if not p or not a then return end

		render.OverrideDepthEnable(true, true)

		render.SetMaterial(ReticleMaterial)
		render.DrawQuadEasy(p, a:Forward() * -1, ReticleSize, ReticleSize, TargetColor, 180 + a.r * (wep.ViewModelFlip and 1 or -1))

		render.OverrideDepthEnable(false, false)
	end
end

-- hook logic
if IsValid(TFA.SightMaskEnt) then
	TFA.SightMaskEnt:Remove()
	TFA.SightMaskEnt = nil
end

TFA.SightMaskEnt = ClientsideModel("models/error.mdl", RENDERGROUP_VIEWMODEL)
TFA.SightMaskEnt:SetNoDraw(true)

local SightMaskEnt = TFA.SightMaskEnt

local function DrawSight(vm, ply, wep)
	if not IsValid(wep) or not wep.IsTFAWeapon then return end

	local wep2 = wep:GetTable()

	if wep2.TFA_IsDrawingStencilSights then return end
	wep2.TFA_IsDrawingStencilSights = true

	if not wep2.GetStat(wep, "StencilSight") then wep2.TFA_IsDrawingStencilSights = false return end
	if wep2.IronSightsProgress < wep2.GetStat(wep, "StencilSight_MinPercent", 0.05) then wep2.TFA_IsDrawingStencilSights = false return end

	local SightElementName = wep2.GetStat(wep, "StencilSight_VElement")
	if not SightElementName or not wep2.GetStat(wep, "VElements." .. SightElementName .. ".active") then wep2.TFA_IsDrawingStencilSights = false return end

	local SightElementTable = wep2.VElements[SightElementName]
	if not SightElementTable then wep2.TFA_IsDrawingStencilSights = false return end

	local SightElementModel = SightElementTable.curmodel
	if not IsValid(SightElementModel) then wep2.TFA_IsDrawingStencilSights = false return end

	if useStencils then
		defineCanvas()

		local SightMaskModel = SightElementModel

		if wep2.GetStat(wep, "StencilSight_UseMask", false) and SightElementTable.mask then
			SightMaskEnt:SetModel(SightElementTable.mask)

			if SightMaskEnt:GetModel() ~= "models/error.mdl" then
				SightMaskModel = SightMaskEnt

				local matrix = Matrix()
				matrix:Scale(SightElementTable.size)
				SightMaskEnt:EnableMatrix("RenderMultiply", matrix)

				if SightMaskEnt:GetParent() ~= SightElementModel then
					SightMaskEnt:SetParent(SightElementModel)
					SightMaskEnt:SetPos(SightElementModel:GetPos())
					SightMaskEnt:SetAngles(SightElementModel:GetAngles())

					if not SightMaskEnt:IsEffectActive(EF_BONEMERGE) then
						SightMaskEnt:AddEffects(EF_BONEMERGE)
						SightMaskEnt:AddEffects(EF_BONEMERGE_FASTCULL)
					end
				end
			end
		end

		if wep.ViewModelFlip then render.CullMode(MATERIAL_CULLMODE_CW) end
		local oldBlend = render.GetBlend()
		render.SetBlend(0)
			SightMaskModel:DrawModel()
		render.SetBlend(oldBlend)
		if wep.ViewModelFlip then render.CullMode(MATERIAL_CULLMODE_CCW) end

		drawOn()
	end

	local funcType = wep2.GetStat(wep, "StencilSight_ReticleType", TFA.Enum.RETICLE_FLAT)

	if DrawFunctions[funcType] then
		ProtectedCall(function()
			DrawFunctions[funcType](vm, ply, wep, SightElementTable)
		end)
	end

	if useStencils then
		stopCanvas()
	end

	wep2.TFA_IsDrawingStencilSights = false
end

hook.Add("PostDrawViewModel", "TFA_DrawStencilSight", DrawSight)