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

--[[Thanks to Clavus.  Like seriously, SCK was brilliant. Even though you didn't include a license anywhere I could find, it's only fit to credit you.]]
--

local vector_origin = Vector()

--[[
Function Name:  InitMods
Syntax: self:InitMods().  Should be called only once for best performance.
Returns:  Nothing.
Notes:  Creates the VElements and WElements table, and sets up mods.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:InitMods()
	--Create a new table for every weapon instance.
	self.SWEPConstructionKit = true

	self.ViewModelElements = self:CPTbl(self.ViewModelElements)
	self.WorldModelElements = self:CPTbl(self.WorldModelElements)
	self.ViewModelBoneMods = self:CPTbl(self.ViewModelBoneMods)

	-- i have no idea how this gonna behave without that with SWEP Construction kit
	-- so we gonna leave this thing alone and precache everything
	self:CreateModels(self.ViewModelElements, true) -- create viewmodels
	self:CreateModels(self.WorldModelElements) -- create worldmodels

	--Build the bones and such.
	if self:OwnerIsValid() then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			--self:ResetBonePositions(vm)
			if (self.ShowViewModel == nil or self.ShowViewModel) then
				vm:SetColor(Color(255, 255, 255, 255))
				--This hides the viewmodel, FYI, lol.
			else
				vm:SetMaterial("Debug/hsv")
			end
		end
	end
end

--[[
Function Name:  UpdateProjectedTextures
Syntax: self:UpdateProjectedTextures().  Automatically called already.
Returns:  Nothing.
Notes:  This takes care of our flashlight and laser.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--

function SWEP:UpdateProjectedTextures(view)
	self:DrawLaser(view)
	self:DrawFlashlight(view)
end

--[[
Function Name:  ViewModelDrawn
Syntax: self:ViewModelDrawn().  Automatically called already.
Returns:  Nothing.
Notes:  This draws the mods.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:PreDrawViewModel(vm, wep, ply)
	self:ProcessBodygroups()

	--vm:SetupBones()

	if self:GetHidden() then
		render.SetBlend(0)
	end
end

SWEP.CameraAttachmentOffsets = {{"p", 0}, {"y", 0}, {"r", 0}}
SWEP.CameraAttachment = nil
SWEP.CameraAttachments = {"camera", "attach_camera", "view", "cam", "look"}
SWEP.CameraAngCache = nil
local tmpvec = Vector(0, 0, -2000)

do
	local reference_table

	local function rendersorter(a, b)
		local ar, br = reference_table[a], reference_table[b]

		if ar == br then
			return a > b
		end

		return ar > br
	end

	local function inc_references(lookup, name, entry, output, level)
		output[name] = (output[name] or 0) + level
		local elemother = lookup[entry.rel]

		if elemother then
			inc_references(lookup, entry.rel, elemother, output, level + 1)
		end
	end

	function SWEP:RebuildModsRenderOrder()
		self.vRenderOrder = {}
		self.wRenderOrder = {}
		self.VElementsBodygroupsCache = {}
		self.WElementsBodygroupsCache = {}

		local ViewModelElements = self:GetStatRaw("ViewModelElements", TFA.LatestDataVersion)
		local WorldModelElements = self:GetStatRaw("WorldModelElements", TFA.LatestDataVersion)

		if istable(ViewModelElements) then
			local target = self.vRenderOrder
			reference_table = {}

			for k, v in pairs(ViewModelElements) do
				if v.type == "Model" then
					table.insert(target, k)
					inc_references(ViewModelElements, k, v, reference_table, 10000)
				elseif v.type == "Sprite" or v.type == "Quad" or v.type == "Bodygroup" then
					table.insert(target, k)
					inc_references(ViewModelElements, k, v, reference_table, 1)
				end
			end

			table.sort(target, rendersorter)
		end

		if istable(WorldModelElements) then
			local target2 = self.wRenderOrder
			reference_table = {}

			for k, v in pairs(WorldModelElements) do
				if v.type == "Model" then
					table.insert(target2, 1, k)
					inc_references(WorldModelElements, k, v, reference_table, 10000)
				elseif v.type == "Sprite" or v.type == "Quad" or v.type == "Bodygroup" then
					table.insert(target2, k)
					inc_references(WorldModelElements, k, v, reference_table, 1)
				end
			end

			table.sort(target2, rendersorter)
		end

		return self.vRenderOrder, self.wRenderOrder
	end
end

function SWEP:RemoveModsRenderOrder()
	self.vRenderOrder = nil
end

local drawfn, drawself, fndrawpos, fndrawang, fndrawsize

local function dodrawfn()
	drawfn(drawself, fndrawpos, fndrawang, fndrawsize)
end

local next_setup_bones = 0

function TFA._IncNextSetupBones()
	next_setup_bones = next_setup_bones + 1
end

function TFA._GetNextSetupBones()
	return next_setup_bones
end

local mirror_scale = Vector(1, -1, 1)
local normal_scale = Vector(1, 1, 1)

local mirror = Matrix()

local DRAW_AND_SETUP = 0
local ONLY_DRAW = 1
local ONLY_SETUP = 2

local function draw_element_closure(self, self2, name, index, vm, ViewModelElements, element, nodraw)
	if self2.GetStatL(self, "ViewModelElements." .. name .. ".active") == false then return end

	local pos, ang = self:GetBoneOrientation(ViewModelElements, element, vm, nil, true)
	if not pos and not element.bonemerge then return end

	self:PrecacheElement(element, true)

	local model = element.curmodel
	local sprite = element.spritemat

	local dodraw = nodraw == DRAW_AND_SETUP or nodraw == ONLY_DRAW
	local dosetup = nodraw == DRAW_AND_SETUP or nodraw == ONLY_SETUP

	if element.type == "Model" and IsValid(model) then
		if not element.bonemerge and dosetup then
			mirror:Identity()

			if self2.ViewModelFlip then
				model:SetPos(pos + ang:Forward() * element.pos.x - ang:Right() * element.pos.y + ang:Up() * element.pos.z)

				ang:RotateAroundAxis(ang:Up(), -element.angle.y)
				ang:RotateAroundAxis(ang:Right(), element.angle.p)
				ang:RotateAroundAxis(ang:Forward(), -element.angle.r)

				mirror:Scale(mirror_scale)
				mirror:Scale(element.size)
			else
				model:SetPos(pos + ang:Forward() * element.pos.x + ang:Right() * element.pos.y + ang:Up() * element.pos.z)

				ang:RotateAroundAxis(ang:Up(), element.angle.y)
				ang:RotateAroundAxis(ang:Right(), element.angle.p)
				ang:RotateAroundAxis(ang:Forward(), element.angle.r)

				mirror:Scale(normal_scale)
				mirror:Scale(element.size)
			end

			model:SetAngles(ang)
			model:EnableMatrix("RenderMultiply", mirror)
		end

		if dodraw then
			if element.surpresslightning then
				render.SuppressEngineLighting(true)
			end

			local material = self:GetStatL("ViewModelElements." .. name .. ".material")

			if not material or material == "" then
				model:SetMaterial("")
			elseif model:GetMaterial() ~= material then
				model:SetMaterial(material)
			end

			local skin = self:GetStatL("ViewModelElements." .. name .. ".skin")

			if skin and skin ~= model:GetSkin() then
				model:SetSkin(skin)
			end

			if not self2.SCKMaterialCached_V[name] then
				self2.SCKMaterialCached_V[name] = true

				local materialtable = self:GetStatL("ViewModelElements." .. name .. ".materials", {})
				local entmats = table.GetKeys(model:GetMaterials())

				for _, k in ipairs(entmats) do
					model:SetSubMaterial(k - 1, materialtable[k] or "")
				end
			end
		end

		if dosetup then
			if not self2.VElementsBodygroupsCache[index] then
				self2.VElementsBodygroupsCache[index] = #model:GetBodyGroups() - 1
			end

			if self2.VElementsBodygroupsCache[index] then
				for _b = 0, self2.VElementsBodygroupsCache[index] do
					local newbg = self2.GetStatL(self, "ViewModelElements." .. name .. ".bodygroup." .. _b, 0) -- names are not supported, use overridetable

					if model:GetBodygroup(_b) ~= newbg then
						model:SetBodygroup(_b, newbg)
					end
				end
			end

			if element.bonemerge then
				model:SetPos(pos)
				model:SetAngles(ang)

				if element.rel and ViewModelElements[element.rel] and IsValid(ViewModelElements[element.rel].curmodel) then
					element.parModel = ViewModelElements[element.rel].curmodel
				else
					element.parModel = self2.OwnerViewModel or self
				end

				if model:GetParent() ~= element.parModel then
					model:SetParent(element.parModel)
				end

				if not model:IsEffectActive(EF_BONEMERGE) then
					model:AddEffects(EF_BONEMERGE)
					model:AddEffects(EF_BONEMERGE_FASTCULL)
					model:SetMoveType(MOVETYPE_NONE)
					model:SetLocalPos(vector_origin)
					model:SetLocalAngles(angle_zero)
				end
			elseif model:IsEffectActive(EF_BONEMERGE) then
				model:RemoveEffects(EF_BONEMERGE)
				model:SetParent(NULL)
			end
		end

		if dodraw then
			render.SetColorModulation(element.color.r / 255, element.color.g / 255, element.color.b / 255)
			render.SetBlend(element.color.a / 255)
		end

		if dosetup and model.tfa_next_setup_bones ~= next_setup_bones then
			model:InvalidateBoneCache()
			model:SetupBones()
			model.tfa_next_setup_bones = next_setup_bones
		end

		if dodraw then
			if self2.ViewModelFlip then
				render.CullMode(MATERIAL_CULLMODE_CW)
			end

			model:DrawModel()

			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if self2.ViewModelFlip then
				render.CullMode(MATERIAL_CULLMODE_CCW)
			end

			if element.surpresslightning then
				render.SuppressEngineLighting(false)
			end
		end
	elseif dodraw and element.type == "Sprite" and sprite then
		local drawpos = pos + ang:Forward() * element.pos.x + ang:Right() * element.pos.y + ang:Up() * element.pos.z
		render.SetMaterial(sprite)
		render.DrawSprite(drawpos, element.size.x, element.size.y, element.color)
	elseif dodraw and element.type == "Quad" and element.draw_func then
		local drawpos = pos + ang:Forward() * element.pos.x + ang:Right() * element.pos.y + ang:Up() * element.pos.z
		ang:RotateAroundAxis(ang:Up(), element.angle.y)
		ang:RotateAroundAxis(ang:Right(), element.angle.p)
		ang:RotateAroundAxis(ang:Forward(), element.angle.r)

		cam.Start3D2D(drawpos, ang, element.size)
		render.PushFilterMin(TEXFILTER.ANISOTROPIC)
		render.PushFilterMag(TEXFILTER.ANISOTROPIC)

		drawfn, drawself, fndrawpos, fndrawang, fndrawsize = element.draw_func, self, nil, nil, nil
		ProtectedCall(dodrawfn)

		render.PopFilterMin()
		render.PopFilterMag()
		cam.End3D2D()
	end
end

function SWEP:ViewModelDrawn()
	local self2 = self:GetTable()
	render.SetBlend(1)

	if self2.DrawHands then
		self2.DrawHands(self)
	end

	local vm = self.OwnerViewModel
	if not IsValid(vm) then return end
	if not self:GetOwner().GetHands then return end

	if self2.UseHands then
		local hands = self:GetOwner():GetHands()

		if IsValid(hands) then
			if not self2.GetHidden(self) then
				hands:SetParent(vm)
			else
				hands:SetParent(nil)
				hands:SetPos(tmpvec)
			end
		end
	end

	self2.UpdateBonePositions(self, vm)

	if not self2.CameraAttachment then
		self2.CameraAttachment = -1

		for _, v in ipairs(self2.CameraAttachments) do
			local attid = vm:LookupAttachment(v)

			if attid and attid > 0 then
				self2.CameraAttachment = attid
				break
			end
		end
	end

	if self2.CameraAttachment and self2.CameraAttachment > 0 then
		local angpos = vm:GetAttachment(self2.CameraAttachment)

		if angpos and angpos.Ang then
			local angv = angpos.Ang
			local off = vm:WorldToLocalAngles(angv)
			local spd = 15
			local cycl = vm:GetCycle()
			local dissipatestart = 0
			self2.CameraAngCache = self2.CameraAngCache or off

			for _, v in pairs(self2.CameraAttachmentOffsets) do
				local offtype = v[1]
				local offang = v[2]

				if offtype == "p" then
					off:RotateAroundAxis(off:Right(), offang)
				elseif offtype == "y" then
					off:RotateAroundAxis(off:Up(), offang)
				elseif offtype == "r" then
					off:RotateAroundAxis(off:Forward(), offang)
				end
			end

			if self2.ViewModelFlip then
				off = Angle()
			end

			local actind = vm:GetSequenceActivity(vm:GetSequence())

			if (actind == ACT_VM_DRAW or actind == ACT_VM_HOLSTER_EMPTY or actind == ACT_VM_DRAW_SILENCED) and vm:GetCycle() < 0.05 then
				self2.CameraAngCache.p = 0
				self2.CameraAngCache.y = 0
				self2.CameraAngCache.r = 0
			end

			if (actind == ACT_VM_HOLSTER or actind == ACT_VM_HOLSTER_EMPTY) and cycl > dissipatestart then
				self2.CameraAngCache.p = self2.CameraAngCache.p * (1 - cycl) / (1 - dissipatestart)
				self2.CameraAngCache.y = self2.CameraAngCache.y * (1 - cycl) / (1 - dissipatestart)
				self2.CameraAngCache.r = self2.CameraAngCache.r * (1 - cycl) / (1 - dissipatestart)
			end

			self2.CameraAngCache.p = math.ApproachAngle(self2.CameraAngCache.p, off.p, (self2.CameraAngCache.p - off.p) * FrameTime() * spd)
			self2.CameraAngCache.y = math.ApproachAngle(self2.CameraAngCache.y, off.y, (self2.CameraAngCache.y - off.y) * FrameTime() * spd)
			self2.CameraAngCache.r = math.ApproachAngle(self2.CameraAngCache.r, off.r, (self2.CameraAngCache.r - off.r) * FrameTime() * spd)
		else
			self2.CameraAngCache.p = 0
			self2.CameraAngCache.y = 0
			self2.CameraAngCache.r = 0
		end
	end

	local ViewModelElements = self:GetStatRawL("ViewModelElements")
	local ViewModelBodygroups = self:GetStatRawL("ViewModelBodygroups")

	if ViewModelElements and self2.HasInitAttachments then
		-- ViewModelElements = self:GetStatL("ViewModelElements")
		-- self:CreateModels(ViewModelElements, true)

		self2.SCKMaterialCached_V = self2.SCKMaterialCached_V or {}

		if not self2.vRenderOrder then
			self:RebuildModsRenderOrder()
		end

		vm:InvalidateBoneCache()
		vm:SetupBones()
		next_setup_bones = next_setup_bones + 1

		for index = 1, #self2.vRenderOrder do
			local name = self2.vRenderOrder[index]
			local element = ViewModelElements[name]

			if not element then
				self:RebuildModsRenderOrder()
				break
			end

			if element.type == "Bodygroup" then
				if element.index and element.value_active then
					ViewModelBodygroups[element.index] = self2.GetStatL(self, "ViewModelElements." .. name .. ".active") and element.value_active or (element.value_inactive or 0)
				end

				goto CONTINUE
			end

			if element.hide then goto CONTINUE end

			if element.type == "Quad" and element.draw_func_outer then goto CONTINUE end
			if not element.bone and not element.attachment then goto CONTINUE end

			draw_element_closure(self, self2, name, index, vm, ViewModelElements, element, element.translucent == true and ONLY_SETUP or DRAW_AND_SETUP)

			::CONTINUE::
		end
	end

	if not self2.UseHands and self2.ViewModelDrawnPost then
		self:ViewModelDrawnPost()
		self:ViewModelDrawnPostFinal()
	end

	if self2.ShellEjectionQueue ~= 0 then
		for i = 1, self2.ShellEjectionQueue do
			self:MakeShell(true)
		end

		self2.ShellEjectionQueue = 0
	end
end

function SWEP:ViewModelDrawnPostFinal()
	local self2 = self:GetTable()
	local vm = self.OwnerViewModel
	if not IsValid(vm) then return end

	local ViewModelElements = self:GetStatRawL("ViewModelElements")
	if not ViewModelElements then return end

	for index = 1, #self2.vRenderOrder do
		local name = self2.vRenderOrder[index]
		local element = ViewModelElements[name]

		if element.hide or not element.translucent then goto CONTINUE end

		if element.type == "Quad" and element.draw_func_outer then goto CONTINUE end
		if not element.bone and not element.attachment then goto CONTINUE end

		draw_element_closure(self, self2, name, index, vm, ViewModelElements, element, ONLY_DRAW)

		::CONTINUE::
	end
end

function SWEP:ViewModelDrawnPost()
	local self2 = self:GetTable()
	if not self2.VMIV(self) then return end

	if not self.ViewModelFlip then
		self2.CacheSightsPos(self, self.OwnerViewModel, false)
	end

	local ViewModelElements = self:GetStatRaw("ViewModelElements", TFA.LatestDataVersion)

	if not ViewModelElements or not self2.vRenderOrder then return end

	for index = 1, #self2.vRenderOrder do
		local name = self2.vRenderOrder[index]
		local element = ViewModelElements[name]

		if element.type == "Quad" and element.draw_func_outer and not element.hide and (element.bone or element.attachment and element.attachment ~= "") and self:GetStatL("ViewModelElements." .. name .. ".active") ~= false then
			local pos, ang = self:GetBoneOrientation(ViewModelElements, element, self2.OwnerViewModel)

			if pos then
				local drawpos = pos + ang:Forward() * element.pos.x + ang:Right() * element.pos.y + ang:Up() * element.pos.z

				ang:RotateAroundAxis(ang:Up(), element.angle.y)
				ang:RotateAroundAxis(ang:Right(), element.angle.p)
				ang:RotateAroundAxis(ang:Forward(), element.angle.r)

				drawfn, drawself, fndrawpos, fndrawang, fndrawsize = element.draw_func_outer, self, drawpos, ang, element.size
				ProtectedCall(dodrawfn)
			end
		end
	end
end

--[[
Function Name:  DrawWorldModel
Syntax: self:DrawWorldModel().  Automatically called already.
Returns:  Nothing.
Notes:  This draws the world model, plus its attachments.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:DrawWorldModel()
	local self2 = self:GetTable()

	local skinStat = self2.GetStatL(self, "Skin")
	if isnumber(skinStat) then
		if self:GetSkin() ~= skinStat then
			self:SetSkin(skinStat)
		end
	end

	if not self2.MaterialCached_W and self2.GetStatL(self, "MaterialTable_W") then
		self2.MaterialCached_W = {}
		self:SetSubMaterial()

		local collectedKeys = table.GetKeys(self2.GetStatL(self, "MaterialTable_W"))
		table.Merge(collectedKeys, table.GetKeys(self2.GetStatL(self, "MaterialTable")))

		for _, k in ipairs(collectedKeys) do
			if (k == "BaseClass") then goto CONTINUE end

			local v = self2.GetStatL(self, "MaterialTable_W")[k]

			if not self2.MaterialCached_W[k] then
				self:SetSubMaterial(k - 1, v)
				self2.MaterialCached_W[k] = true
			end

			::CONTINUE::
		end
	end

	local ply = self:GetOwner()
	local validowner = IsValid(ply)

	if validowner then
		-- why? this tanks FPS because source doesn't have a chance to setup bones when it needs to
		-- instead we ask it to do it `right now`
		-- k then
		ply:SetupBones()
		ply:InvalidateBoneCache()
		self:InvalidateBoneCache()
	end

	if self2.ShowWorldModel == nil or self2.ShowWorldModel or not validowner then
		self2.WorldModelOffsetUpdate(self, ply)
		self2.ProcessBodygroups(self)

		self:DrawModel()
	end

	self:SetupBones()
	self2.UpdateWMBonePositions(self)

	self:DrawWElements()

	if IsValid(self) and self.IsTFAWeapon and (self:GetOwner() ~= LocalPlayer() or not self:IsFirstPerson()) then
		self2.UpdateProjectedTextures(self, false)
	end
end

function SWEP:DrawWElements()
	local self2 = self:GetTable()

	local WorldModelElements = self2.GetStatRaw(self, "WorldModelElements", TFA.LatestDataVersion)

	if not WorldModelElements then return end

	if not self2.SCKMaterialCached_W then
		self2.SCKMaterialCached_W = {}
	end

	if not self2.wRenderOrder then
		self2.RebuildModsRenderOrder(self)
	end

	local ply = self:GetOwner()
	local validowner = IsValid(ply)

	for index = 1, #self2.wRenderOrder do
		local name = self2.wRenderOrder[index]
		local element = WorldModelElements[name]

		if not element then
			self2.RebuildModsRenderOrder(self)
			break
		end

		if element.type == "Bodygroup" then
			if element.index and element.value_active then
				self2.WorldModelBodygroups[element.index] = self2.GetStatL(self, "WorldModelElements." .. name .. ".active") and element.value_active or (element.value_inactive or 0)
			end

			goto CONTINUE
		end

		if element.hide then goto CONTINUE end
		if self2.GetStatL(self, "WorldModelElements." .. name .. ".active") == false then goto CONTINUE end

		local bone_ent = (validowner and ply:LookupBone(element.bone or "ValveBiped.Bip01_R_Hand")) and ply or self
		local pos, ang

		if element.bone then
			pos, ang = self2.GetBoneOrientation(self, WorldModelElements, element, bone_ent)
		else
			pos, ang = self2.GetBoneOrientation(self, WorldModelElements, element, bone_ent, "ValveBiped.Bip01_R_Hand")
		end

		if not pos and not element.bonemerge then goto CONTINUE end

		self2.PrecacheElement(self, element, true)

		local model = element.curmodel
		local sprite = element.spritemat

		if element.type == "Model" and IsValid(model) then
			if element.bonemerge then
				model:SetPos(pos)
				model:SetAngles(ang)
			else
				model:SetPos(pos + ang:Forward() * element.pos.x + ang:Right() * element.pos.y + ang:Up() * element.pos.z)

				ang:RotateAroundAxis(ang:Up(), element.angle.y)
				ang:RotateAroundAxis(ang:Right(), element.angle.p)
				ang:RotateAroundAxis(ang:Forward(), element.angle.r)

				model:SetAngles(ang)
			end

			local material = self2.GetStatL(self, "WorldModelElements." .. name .. ".material")

			if not material or material == "" then
				model:SetMaterial("")
			elseif model:GetMaterial() ~= material then
				model:SetMaterial(material)
			end

			local skin = self2.GetStatL(self, "WorldModelElements." .. name .. ".skin")

			if skin and skin ~= model:GetSkin() then
				model:SetSkin(skin)
			end

			if not self2.SCKMaterialCached_W[name] then
				self2.SCKMaterialCached_W[name] = true

				local materialtable = self2.GetStatL(self, "WorldModelElements." .. name .. ".materials", {})
				local entmats = table.GetKeys(model:GetMaterials())

				for _, k in ipairs(entmats) do
					model:SetSubMaterial(k - 1, materialtable[k] or "")
				end
			end

			if not self2.WElementsBodygroupsCache[index] then
				self2.WElementsBodygroupsCache[index] = #model:GetBodyGroups() - 1
			end

			if self2.WElementsBodygroupsCache[index] then
				for _b = 0, self2.WElementsBodygroupsCache[index] do
					local newbg = self2.GetStatL(self, "WorldModelElements." .. name .. ".bodygroup." .. _b, 0) -- names are not supported, use overridetable

					if model:GetBodygroup(_b) ~= newbg then
						model:SetBodygroup(_b, newbg)
					end
				end
			end

			if element.surpresslightning then
				render.SuppressEngineLighting(true)
			end

			if element.bonemerge then
				if element.rel and WorldModelElements[element.rel] and IsValid(WorldModelElements[element.rel].curmodel) and WorldModelElements[element.rel].bone ~= "oof" then
					element.parModel = WorldModelElements[element.rel].curmodel
				else
					element.parModel = self
				end

				if model:GetParent() ~= element.parModel then
					model:SetParent(element.parModel)
				end

				if not model:IsEffectActive(EF_BONEMERGE) then
					model:AddEffects(EF_BONEMERGE)
					model:SetLocalPos(vector_origin)
					model:SetLocalAngles(angle_zero)
				end
			elseif model:IsEffectActive(EF_BONEMERGE) then
				model:RemoveEffects(EF_BONEMERGE)
				model:SetParent(nil)
			end

			render.SetColorModulation(element.color.r / 255, element.color.g / 255, element.color.b / 255)
			render.SetBlend(element.color.a / 255)

			model:DrawModel()

			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if element.surpresslightning then
				render.SuppressEngineLighting(false)
			end
		elseif element.type == "Sprite" and sprite then
			local drawpos = pos + ang:Forward() * element.pos.x + ang:Right() * element.pos.y + ang:Up() * element.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, element.size.x, element.size.y, element.color)
		elseif element.type == "Quad" and element.draw_func then
			local drawpos = pos + ang:Forward() * element.pos.x + ang:Right() * element.pos.y + ang:Up() * element.pos.z
			ang:RotateAroundAxis(ang:Up(), element.angle.y)
			ang:RotateAroundAxis(ang:Right(), element.angle.p)
			ang:RotateAroundAxis(ang:Forward(), element.angle.r)
			cam.Start3D2D(drawpos, ang, element.size)

			drawfn, drawself, fndrawpos, fndrawang, fndrawsize = element.draw_func, self, nil, nil, nil
			ProtectedCall(dodrawfn)

			cam.End3D2D()
		end

		::CONTINUE::
	end
end

function SWEP:WorldModelOffsetUpdate(ply)
	if not IsValid(ply) then
		self:SetRenderOrigin(nil)
		self:SetRenderAngles(nil)

		local WorldModelOffset = self:GetStatRawL("WorldModelOffset")

		if WorldModelOffset and WorldModelOffset.Scale then
			self:SetModelScale(WorldModelOffset.Scale, 0)
		end

		return
	end


	local WorldModelOffset = self:GetStatRawL("WorldModelOffset")

		-- THIS IS DANGEROUS
	if WorldModelOffset and WorldModelOffset.Pos and WorldModelOffset.Ang then
		-- TO DO ONLY CLIENTSIDE
		-- since this will break hitboxes!
		local handBone = ply:LookupBone("ValveBiped.Bip01_R_Hand")

		if handBone then
			--local pos, ang = ply:GetBonePosition(handBone)
			local pos, ang
			local mat = ply:GetBoneMatrix(handBone)

			if mat then
				pos, ang = mat:GetTranslation(), mat:GetAngles()
			else
				pos, ang = ply:GetBonePosition(handBone)
			end

			local opos, oang, oscale = WorldModelOffset.Pos, WorldModelOffset.Ang, WorldModelOffset.Scale

			pos = pos + ang:Forward() * opos.Forward + ang:Right() * opos.Right + ang:Up() * opos.Up
			ang:RotateAroundAxis(ang:Up(), oang.Up)
			ang:RotateAroundAxis(ang:Right(), oang.Right)
			ang:RotateAroundAxis(ang:Forward(), oang.Forward)
			self:SetRenderOrigin(pos)
			self:SetRenderAngles(ang)
			--if WorldModelOffset.Scale and ( !self2.MyModelScale or ( WorldModelOffset and self2.MyModelScale!=WorldModelOffset.Scale ) ) then
			self:SetModelScale(oscale or 1, 0)
			--end
		end
	end
end

--[[
Function Name:  GetBoneOrientation
Syntax: self:GetBoneOrientation( base bone mod table, bone mod table, entity, bone override ).
Returns:  Position, Angle.
Notes:  This is a very specific function for a specific purpose, and shouldn't be used generally to get a bone's orientation.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:GetBoneOrientation(basetabl, tabl, ent, bone_override, isVM, isAttachment, isNonRoot)
	local bone, pos, ang

	if not IsValid(ent) then return Vector(), Angle() end

	if not isNonRoot and tabl.rel and tabl.rel ~= "" and not tabl.bonemerge then
		local v = basetabl[tabl.rel]
		if not v then return Vector(), Angle() end

		local boneName = tabl.bone

		if tabl.attachment and tabl.attachment ~= "" and v.curmodel:LookupAttachment(tabl.attachment) ~= 0 then
			pos, ang = self:GetBoneOrientation(basetabl, v, v.curmodel, tabl.attachment, isVM, true, true)

			if pos and ang then return pos, ang end
		elseif v.curmodel and ent ~= v.curmodel and (v.bonemerge or (boneName and boneName ~= "" and v.curmodel:LookupBone(boneName))) then
			pos, ang = self:GetBoneOrientation(basetabl, v, v.curmodel, boneName, isVM, false, true)

			if pos and ang then return pos, ang end
		else
			--As clavus states in his original code, don't make your elements named the same as a bone, because recursion.
			pos, ang = self:GetBoneOrientation(basetabl, v, ent, nil, isVM, false, true)

			if pos and ang then
				pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z

				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				-- For mirrored viewmodels.  You might think to scale negatively on X, but this isn't the case.

				return pos, ang
			end
		end
	end

	if isAttachment == nil then isAttachment = tabl.attachment ~= nil end

	if isnumber(bone_override) then
		bone = bone_override
	elseif isAttachment then
		bone = ent:LookupAttachment(bone_override or tabl.attachment)
	else
		bone = ent:LookupBone(bone_override or tabl.bone) or 0
	end

	if not bone or bone == -1 then return end
	pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)

	if ent.tfa_next_setup_bones ~= next_setup_bones then
		ent:InvalidateBoneCache()
		ent:SetupBones()
		ent.tfa_next_setup_bones = next_setup_bones
	end

	if isAttachment then
		-- mmmm yes tasty LuaVM memory
		-- GC screams in agony
		local get = ent:GetAttachment(bone)

		if get then
			pos, ang = get.Pos, get.Ang
		end
	else

		local m = ent:GetBoneMatrix(bone)

		if m then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end
	end

	local owner = self:GetOwner()

	if isVM and self.ViewModelFlip then
		ang.r = -ang.r
	end

	return pos, ang
end
--[[
Function Name:  CleanModels
Syntax: self:CleanModels( elements table ).
Returns:   Nothing.
Notes:  Removes all existing models.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:CleanModels(input)
	if not istable(input) then return end

	for _, v in pairs(input) do
		if (v.type == "Model" and v.curmodel) then
			if IsValid(v.curmodel) then
				v.curmodel:Remove()
			end

			v.curmodel = nil
		elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spritemat or v.cursprite ~= v.sprite)) then
			v.cursprite = nil
			v.spritemat = nil
		end
	end
end

function SWEP:PrecacheElementModel(element, is_vm)
	element.curmodel = ClientsideModel(element.model, RENDERGROUP_OTHER)
	element.curmodel.tfa_gun_parent = self
	element.curmodel.tfa_gun_clmodel = true

	if self.SWEPConstructionKit then
		TFA.RegisterClientsideModel(element.curmodel, self)
	end

	if not IsValid(element.curmodel) then
		element.curmodel = nil
		return
	end

	element.curmodel:SetPos(self:GetPos())
	element.curmodel:SetAngles(self:GetAngles())
	element.curmodel:SetParent(self)
	element.curmodel:SetOwner(self)
	element.curmodel:SetNoDraw(true)

	if element.material then
		element.curmodel:SetMaterial(element.material or "")
	end

	if element.skin then
		element.curmodel:SetSkin(element.skin)
	end

	local matrix = Matrix()
	matrix:Scale(element.size)

	element.curmodel:EnableMatrix("RenderMultiply", matrix)
	element.curmodelname = element.model
	element.view = is_vm == true

	-- // make sure we create a unique name based on the selected options
end

do
	local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}

	function SWEP:PrecacheElementSprite(element, is_vm)
		if element.vmt then
			element.spritemat = Material(element.sprite)
			element.cursprite = element.sprite
			return
		end

		local name = "tfa-" .. element.sprite .. "-"

		local params = {
			["$basetexture"] = element.sprite
		}

		for _, element_property in ipairs(tocheck) do
			if (element[element_property]) then
				params["$" .. element_property] = 1
				name = name .. "1"
			else
				name = name .. "0"
			end
		end

		element.cursprite = element.sprite
		element.spritemat = CreateMaterial(name, "UnlitGeneric", params)
	end
end

function SWEP:PrecacheElement(element, is_vm)
	if element.type == "Model" and element.model and (not IsValid(element.curmodel) or element.curmodelname ~= element.model) and element.model ~= "" then
		if IsValid(element.curmodel) then
			element.curmodel:Remove()
		end

		self:PrecacheElementModel(element, is_vm)
	elseif (element.type == "Sprite" and element.sprite and element.sprite ~= "" and (not element.spritemat or element.cursprite ~= element.sprite)) then
		self:PrecacheElementSprite(element, is_vm)
	end
end

--[[
Function Name:  CreateModels
Syntax: self:CreateModels( elements table ).
Returns:   Nothing.
Notes:  Creates the elements for whatever you give it.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:CreateModels(input, is_vm)
	if not istable(input) then return end

	for _, element in pairs(input) do
		self:PrecacheElement(element, is_vm)
	end
end

--[[
Function Name:  UpdateBonePositions
Syntax: self:UpdateBonePositions( viewmodel ).
Returns:   Nothing.
Notes:   Updates the bones for a viewmodel.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
local bpos, bang
local onevec = Vector(1, 1, 1)
local getKeys = table.GetKeys

local function appendTable(t, t2)
	for i = 1, #t2 do
		t[#t + 1] = t2[i]
	end
end

SWEP.ChildrenScaled = {}
SWEP.ViewModelBoneMods_Children = {}

function SWEP:ScaleChildBoneMods(ent,bone,cumulativeScale)
	if self.ChildrenScaled[bone] then
		return
	end
	self.ChildrenScaled[bone] = true
	local boneid = ent:LookupBone(bone)
	if not boneid then return end
	local curScale = (cumulativeScale or Vector(1,1,1)) * 1
	if self.ViewModelBoneMods[bone] then
		curScale = curScale * self.ViewModelBoneMods[bone].scale
	end
	local ch = ent:GetChildBones(boneid)
	if ch and #ch > 0 then
		for _, boneChild in ipairs(ch) do
			self:ScaleChildBoneMods(ent,ent:GetBoneName(boneChild),curScale)
		end
	end
	if self.ViewModelBoneMods[bone] then
		self.ViewModelBoneMods[bone].scale = curScale
	else
		self.ViewModelBoneMods_Children[bone] = {
			["pos"] = vector_origin,
			["angle"] = angle_zero,
			["scale"] = curScale * 1
		}
	end
end

local vmbm_old_count = 0

function SWEP:UpdateBonePositions(vm)
	local self2 = self:GetTable()
	local vmbm = self2.GetStatL(self, "ViewModelBoneMods")

	local vmbm_count = 0

	if vmbm then
		vmbm_count = table.Count(vmbm)
	end

	if vmbm_old_count ~= vmbm_count then
		self:ResetBonePositions()
	end

	vmbm_old_count = vmbm_count

	if vmbm then
		local stat = self:GetStatus()

		if not self2.BlowbackBoneMods then
			self2.BlowbackBoneMods = {}
			self2.BlowbackCurrent = 0
		end

		if not self2.HasSetMetaVMBM then
			for k,v in pairs(self2.ViewModelBoneMods) do
				if (k == "BaseClass") then goto CONTINUE end -- do not name your bones like this pls

				local scale = v.scale

				if scale and scale.x ~= 1 or scale.y ~= 1 or scale.z ~= 1 then
					self:ScaleChildBoneMods(vm, k)
				end

				::CONTINUE::
			end

			for _,v in pairs(self2.BlowbackBoneMods) do
				v.pos_og = v.pos
				v.angle_og = v.angle
				v.scale_og = v.scale or onevec
			end

			self2.HasSetMetaVMBM = true
			self2.ViewModelBoneMods["wepEnt"] = self

			setmetatable(self2.ViewModelBoneMods, {__index = function(t,k)
				if not IsValid(self) then return end
				if self2.ViewModelBoneMods_Children[k] then return self2.ViewModelBoneMods_Children[k] end
				if not self2.BlowbackBoneMods[k] then return end
				if not ( self2.SequenceEnabled[ACT_VM_RELOAD_EMPTY] and TFA.Enum.ReloadStatus[stat] and self2.Blowback_PistolMode ) then
					self2.BlowbackBoneMods[k].pos = self2.BlowbackBoneMods[k].pos_og * self2.BlowbackCurrent
					self2.BlowbackBoneMods[k].angle = self2.BlowbackBoneMods[k].angle_og * self2.BlowbackCurrent
					self2.BlowbackBoneMods[k].scale = Lerp(self2.BlowbackCurrent, onevec, self2.BlowbackBoneMods[k].scale_og)
					return self2.BlowbackBoneMods[k]
				end
			end})
		end

		if not ( self2.SequenceEnabled[ACT_VM_RELOAD_EMPTY] and TFA.Enum.ReloadStatus[stat] and self2.Blowback_PistolMode ) then
			self2.BlowbackCurrent = math.Approach(self2.BlowbackCurrent, 0, self2.BlowbackCurrent * FrameTime() * 30)
		end

		local keys = getKeys(vmbm)
		appendTable(keys, getKeys(self2.GetStatL(self, "BlowbackBoneMods") or self2.BlowbackBoneMods))
		appendTable(keys, getKeys(self2.ViewModelBoneMods_Children))

		for _,k in pairs(keys) do
			if k == "wepEnt" then goto CONTINUE end

			local v = vmbm[k] or self2.GetStatL(self, "ViewModelBoneMods." .. k)
			if not v then goto CONTINUE end

			local vscale, vangle, vpos = v.scale, v.angle, v.pos

			local bone = vm:LookupBone(k)
			if not bone then goto CONTINUE end

			local b = self2.GetStatL(self, "BlowbackBoneMods." .. k)

			if b then
				vscale = Lerp(self2.BlowbackCurrent, vscale, vscale * b.scale)
				vangle = vangle + b.angle * self2.BlowbackCurrent
				vpos = vpos + b.pos * self2.BlowbackCurrent
			end

			if vm:GetManipulateBoneScale(bone) ~= vscale then
				vm:ManipulateBoneScale(bone, vscale)
			end

			if vm:GetManipulateBoneAngles(bone) ~= vangle then
				vm:ManipulateBoneAngles(bone, vangle)
			end

			if vm:GetManipulateBonePosition(bone) ~= vpos then
				vm:ManipulateBonePosition(bone, vpos)
			end

			::CONTINUE::
		end
	elseif self2.BlowbackBoneMods then
		for bonename, tbl in pairs(self2.BlowbackBoneMods) do
			local bone = vm:LookupBone(bonename)

			if bone and bone >= 0 then
				bpos = tbl.pos * self2.BlowbackCurrent
				bang = tbl.angle * self2.BlowbackCurrent
				vm:ManipulateBonePosition(bone, bpos)
				vm:ManipulateBoneAngles(bone, bang)
			end
		end
	end
end

--[[
Function Name:  ResetBonePositions
Syntax: self:ResetBonePositions( viewmodel ).
Returns:   Nothing.
Notes:   Resets the bones for a viewmodel.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:ResetBonePositions(val)
	if SERVER then
		self:CallOnClient("ResetBonePositions", "")

		return
	end

	local vm = self:GetOwner():GetViewModel()
	if not IsValid(vm) then return end
	if (not vm:GetBoneCount()) then return end

	for i = 0, vm:GetBoneCount() do
		vm:ManipulateBoneScale(i, Vector(1, 1, 1))
		vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
		vm:ManipulateBonePosition(i, vector_origin)
	end
end

--[[
Function Name:  UpdateWMBonePositions
Syntax: self:UpdateWMBonePositions( worldmodel ).
Returns:   Nothing.
Notes:   Updates the bones for a worldmodel.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:UpdateWMBonePositions()
	if not self.WorldModelBoneMods then
		self.WorldModelBoneMods = {}
	end

	local WM_BoneMods = self:GetStatL("WorldModelBoneMods", self.WorldModelBoneMods)

	if next(WM_BoneMods) then
		for bone = 0, self:GetBoneCount() - 1 do
			local bonemod = WM_BoneMods[self:GetBoneName(bone)]
			if not bonemod then goto CONTINUE end

			local childscale
			local cur = self:GetBoneParent(bone)

			while (cur ~= -1) do
				local par = WM_BoneMods[self:GetBoneName(cur)]

				if par then
					childscale = (childscale or onevec) * (par.scale or onevec)
				end

				cur = self:GetBoneParent(cur)
			end

			local s = (bonemod.scale or onevec)
			if childscale then
				s = s * childscale
			end

			if self:GetManipulateBoneScale(bone) ~= s then
				self:ManipulateBoneScale(bone, s)
			end

			local a = bonemod.angle or angle_zero

			if self:GetManipulateBoneAngles(bone) ~= a then
				self:ManipulateBoneAngles(bone, a)
			end

			local p = bonemod.pos or vector_origin

			if self:GetManipulateBonePosition(bone) ~= p then
				self:ManipulateBonePosition(bone, p)
			end

			::CONTINUE::
		end
	end
end

--[[
Function Name:  ResetWMBonePositions
Syntax: self:ResetWMBonePositions( worldmodel ).
Returns:   Nothing.
Notes:   Resets the bones for a worldmodel.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]
--
function SWEP:ResetWMBonePositions(wm)
	if SERVER then
		self:CallOnClient("ResetWMBonePositions", "")

		return
	end

	if not wm then
		wm = self
	end

	if not IsValid(wm) then return end

	for i = 0, wm:GetBoneCount() - 1 do
		wm:ManipulateBoneScale(i, Vector(1, 1, 1))
		wm:ManipulateBoneAngles(i, Angle(0, 0, 0))
		wm:ManipulateBonePosition(i, vector_origin)
	end
end
