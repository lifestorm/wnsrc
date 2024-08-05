--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local errorModel = "models/error.mdl"
local PANEL = {}

AccessorFunc(PANEL, "animationTime", "AnimationTime", FORCE_NUMBER)

local function SetCharacter(self, character)
	self.character = character

	if (character) then
		self:SetModel(character:GetModel())
		self:SetSkin(character:GetData("skin", 0))

		for i = 0, (self:GetNumBodyGroups() - 1) do
			self:SetBodygroup(i, 0)
		end

		local bodygroups = character:GetData("groups", nil)
		if (istable(bodygroups)) then
			for k, v in pairs(bodygroups) do
				self:SetBodygroup(k, v)
			end
		end
	else
		self:SetModel(errorModel)
	end
end

local function GetCharacter(self)
	return self.character
end

function PANEL:Init()
	self.activeCharacter = ClientsideModel(errorModel)
	self.activeCharacter:SetNoDraw(true)
	self.activeCharacter.SetCharacter = SetCharacter
	self.activeCharacter.GetCharacter = GetCharacter

	self.animationTime = 0.5

	self.shadeY = 0
	self.shadeHeight = 0

	self.cameraPosition = Vector(80, 0, 35)
	self.cameraAngle = Angle(0, 180, 0)
	self.lastPaint = 0
end

function PANEL:ResetSequence(model, lastModel)
	local sequence = model:LookupSequence("reference")

	if (sequence <= 0) then
		sequence = model:SelectWeightedSequence(ACT_IDLE)
	end

	if (sequence > 0) then
		model:ResetSequence(sequence)
	else
		local found = false

		for _, v in ipairs(model:GetSequenceList()) do
			if ((v:utf8lower():find("idle") or v:utf8lower():find("fly")) and v != "idlenoise") then
				model:ResetSequence(v)
				found = true

				break
			end
		end

		if (!found) then
			model:ResetSequence(4)
		end
	end

	model:SetIK(false)

	-- copy cycle if we can to avoid a jarring transition from resetting the sequence
	if (lastModel) then
		model:SetCycle(lastModel:GetCycle())
	end
end

function PANEL:RunAnimation(model)
	model:FrameAdvance((RealTime() - self.lastPaint) * 0.5)
end

function PANEL:LayoutEntity(model)
	model:SetIK(false)
	self:RunAnimation(model)

	if self.activeCharacter:GetModel() == "models/willardnetworks/vortigaunt.mdl" then
		if model:LookupBone("ValveBiped.head") then
			local headpos = model:GetBonePosition(model:LookupBone("ValveBiped.head"))
			model:SetEyeTarget(headpos-Vector(-15, 0, 0))
			return
		end
	end

	for i = 2, 7 do
		model:SetFlexWeight( i, 0 )
	end

	for i = 0, 1 do
		model:SetFlexWeight( i, 1 )
	end
end

function PANEL:SetActiveCharacter(character)
	self.shadeY = self:GetTall()
	self.shadeHeight = self:GetTall()

	-- set character immediately if we're an error (something isn't selected yet)
	if (self.activeCharacter:GetModel() == errorModel) then
		self.activeCharacter:SetCharacter(character)
		self:ResetSequence(self.activeCharacter)

		return
	end
end

function PANEL:Paint(width, height)
	local x, y = self:LocalToScreen(0, 0)

	cam.Start3D(self.cameraPosition, self.cameraAngle, 70, x, y, width, height)
		render.SetColorMaterial()
		render.SetColorModulation(1, 1, 1)
		render.SuppressEngineLighting(true)
		render.SetLightingOrigin(self.activeCharacter:GetPos())

		-- setup lighting
		render.SetModelLighting(0, 1.5, 1.5, 1.5)

		for i = 1, 4 do
			render.SetModelLighting(i, 0.4, 0.4, 0.4)
		end
		render.SetModelLighting(5, 0.04, 0.04, 0.04)

		-- clip anything out of bounds
		local curparent = self
		local rightx = self:GetWide()
		local leftx = 0
		local topy = 0
		local bottomy = self:GetTall()
		local previous = curparent

		while (curparent:GetParent() != nil) do
			local lastX, lastY = previous:GetPos()
			curparent = curparent:GetParent()

			topy = math.Max(lastY, topy + lastY)
			leftx = math.Max(lastX, leftx + lastX)
			bottomy = math.Min(lastY + previous:GetTall(), bottomy + lastY)
			rightx = math.Min(lastX + previous:GetWide(), rightx + lastX)

			previous = curparent
		end

		ix.util.ResetStencilValues()

		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)
		render.SetStencilReferenceValue(1)

		render.SetStencilFailOperation(STENCIL_KEEP)
		render.SetStencilZFailOperation(STENCIL_KEEP)

		self:LayoutEntity(self.activeCharacter)

		render.SetScissorRect(leftx, topy + self.shadeHeight, rightx, bottomy, true)
		self.activeCharacter:DrawModel()

		render.SetScissorRect(leftx, topy, rightx, bottomy, true)

		render.SetStencilCompareFunction(STENCIL_EQUAL)
		render.SetStencilPassOperation(STENCIL_KEEP)

		render.SetStencilEnable(false)

		render.SetScissorRect(0, 0, 0, 0, false)
		render.SuppressEngineLighting(false)
	cam.End3D()

	self.lastPaint = RealTime()
end

function PANEL:OnRemove()
	self.activeCharacter:Remove()
end

vgui.Register("ixCharMenuCarousel", PANEL, "Panel")

-- character load panel
PANEL = {}

AccessorFunc(PANEL, "animationTime", "AnimationTime", FORCE_NUMBER)
AccessorFunc(PANEL, "backgroundFraction", "BackgroundFraction", FORCE_NUMBER)

function PANEL:Init()
	local parent = self:GetParent()

	self.animationTime = 1
	self.backgroundFraction = 1

	-- main panel
	self.panel = self:AddSubpanel("main")
	self.panel:SetSize(parent:GetSize())
	self.panel:SetTitle("")
	self.panel.OnSetActive = function()
		self:CreateAnimation(self.animationTime, {
			index = 2,
			target = {backgroundFraction = 1},
			easing = "outQuint",
		})
	end

	self.aFontColor = parent.mainPanel.aFontColor or Color(196, 196, 196, 255)
	self.aFontHoverColor = parent.mainPanel.aFontHoverColor or Color(255, 255, 255, 255)
	self.aFontLockedButtonColor = parent.mainPanel.aFontLockedButtonColor or Color(90, 90, 90, 255)

	self.panel.avoidPadding = true

	-- Character Count
	local Count = 0

	for _, _ in pairs(ix.characters) do
		Count = Count + 1
	end

	self.CharacterCount = Count

	local charImageH = SScaleMin(500 / 3)
	local charPanelW = SScaleMin(300 / 3)
	local charTextH = SScaleMin(80 / 3)
	local margin = SScaleMin(20 / 3)

	local panelLoad = self.panel:Add("Panel")

	local titleLabel = panelLoad:Add("DLabel")
	titleLabel:SetTextColor(color_white)
	titleLabel:SetFont("MainMenuNewTitleFont")
	titleLabel:SetText(string.utf8upper("Characters"))
	titleLabel:SizeToContents()
	titleLabel:SetContentAlignment(5)
	titleLabel:Dock(TOP)
	titleLabel:DockMargin(0, 0, 0, SScaleMin(50 / 3))

	local panelLoadWBelowEqual4 = (self.CharacterCount) * charPanelW + ((self.CharacterCount - 1) * margin)
	local panelLoad4 = (4) * charPanelW + ((4 - 1) * margin)

	if panelLoadWBelowEqual4 < titleLabel:GetWide() then panelLoadWBelowEqual4 = titleLabel:GetWide() end
	if panelLoad4 < titleLabel:GetWide() then panelLoad4 = titleLabel:GetWide() end

	if self.CharacterCount <= 4 then
		panelLoad:SetSize(panelLoadWBelowEqual4, titleLabel:GetTall() + SScaleMin(50 / 3) + SScaleMin(590 / 3) + (margin * 3) + SScaleMin(30 / 3))
	else
		panelLoad:SetSize(panelLoad4, titleLabel:GetTall() + SScaleMin(50 / 3) + SScaleMin(590 / 3) + (margin * 3) + SScaleMin(30 / 3))
	end

	panelLoad:Center()

	self.charactersPanel = panelLoad:Add("Panel")
	self.charactersPanel:SetSize(panelLoad:GetWide(), SScaleMin(590 / 3))
	self.charactersPanel:Dock(TOP)

	self.characterImages = self.charactersPanel:Add("Panel")
	self.characterText = self.charactersPanel:Add("Panel")

	if self.CharacterCount == 1 then
		self.characterImages:SetSize(charPanelW, charImageH)
		self.characterText:SetSize(charPanelW, charTextH + margin)
	else
		self.characterImages:SetSize((self.CharacterCount) * charPanelW + ((self.CharacterCount - 1) * margin), charImageH)
		self.characterText:SetSize((self.CharacterCount) * charPanelW + ((self.CharacterCount - 1) * margin), charTextH + margin + (margin * 0.5) + SScaleMin(10 / 3))
	end

	self.characterImages:Center()
	local x, y = self.characterImages:GetPos()
	self.characterImages:SetPos(x, 0)

	self.characterText:Center()
	x, y = self.characterText:GetPos()
	self.characterText:SetPos(x, self.characterImages:GetTall())

	if self.CharacterCount > 4 then
		self.characterText:SetPos(0, self.characterImages:GetTall())
		self.characterImages:SetPos(0, 0)

		self.nextButton = self.panel:Add("DImageButton")

		self.nextButton:SetSize(SScaleMin(32 / 3), SScaleMin(32 / 3))
		self.nextButton:SetImage("willardnetworks/charselect/arrow_right.png")

		self.nextButton:Center()
		x, y = self.nextButton:GetPos()
		self.nextButton:MoveRightOf(panelLoad)
		local x2, y2 = self.nextButton:GetPos()

		self.nextButton:SetPos(x2 + margin, y)

		self.nextButton.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
			self.nextButton:SetColor( Color( 210, 210, 210, 255 ) )
		end

		self.nextButton.OnCursorExited = function()
			self.nextButton:SetColor( Color( 255, 255, 255, 255 ) )
		end

		self.nextButton.DoClick = function()
			x, y = self.characterImages:GetPos()
			x2, y2 = self.characterText:GetPos()
			local pos1, pos2 = math.Round(math.abs( x )), math.Round(((self.CharacterCount - 5) * (charPanelW + margin)))

			if pos1 == pos2 or math.abs(pos1 - pos2) <= charPanelW - 10 then
				self.nextButton:SetVisible(false)
			end

			self.characterImages:MoveTo( x - (charPanelW + margin), y, 0.1, 0, 1 )
			self.characterText:MoveTo( x2 - (charPanelW + margin), y2, 0.1, 0, 1 )
			surface.PlaySound("helix/ui/press.wav")

			if IsValid(self.previousButton) then
				return
			else
				self.previousButton = self.panel:Add("DImageButton")
				self.previousButton:SetSize(SScaleMin(32 / 3), SScaleMin(32 / 3))
				self.previousButton:SetImage("willardnetworks/charselect/arrow_left.png")

				self.previousButton:Center()
				x, y = self.previousButton:GetPos()
				self.previousButton:MoveLeftOf(panelLoad)
				x2, y2 = self.previousButton:GetPos()

				self.previousButton:SetPos(x2 - margin, y)

				self.previousButton.OnCursorEntered = function()
					surface.PlaySound("helix/ui/rollover.wav")
					self.previousButton:SetColor( Color( 210, 210, 210, 255 ) )
				end

				self.previousButton.OnCursorExited = function()
					self.previousButton:SetColor( Color( 255, 255, 255, 255 ) )
				end

				self.previousButton.DoClick = function()
					x, y = self.characterImages:GetPos()
					x2, y2 = self.characterText:GetPos()

					if IsValid(self.nextButton) then
						self.nextButton:SetVisible(true)
					end

					surface.PlaySound("helix/ui/press.wav")
					self.characterImages:MoveTo( x + (charPanelW + margin), y, 0.1, 0, 1 )
					self.characterText:MoveTo( x2 + (charPanelW + margin), y2, 0.1, 0, 1 )

					if IsValid(self.previousButton) then
						pos1, pos2 = math.Round(x, 0), math.Round((0 - (charPanelW + margin)), 0)
						if pos1 == pos2 or math.abs(pos1 - pos2) <= charPanelW - 10 then
							self.previousButton:Remove()
						end
					end
				end
			end
		end
	end

	for i = 1, #ix.characters do
		local id = ix.characters[i]
		local character = ix.char.loaded[id]

		if (!character) then
			continue
		end

		local index = character:GetFaction()
		local faction = ix.faction.indices[index]

		local image = self.characterImages:Add("DImageButton")
		image:SetKeepAspect(true)
		image:SetImage(faction.selectImage or "willardnetworks/charselect/citizen2.png")
		image:Dock(LEFT)

		if i == 1 then
			image:DockMargin(0, 0, 0, 0)
		else
			image:DockMargin(0, 0, margin, 0)
		end

		image.id = character:GetID()
		image:MoveToBack()
		image:SetSize( charPanelW, charImageH )
		image.PaintOver = function(self, w, h)
			surface.SetDrawColor(Color(73, 82, 87, 255))
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local model = image:Add("ixCharMenuCarousel")
		model:SetActiveCharacter(character)
		model:SetSize(SScaleMin(649 / 3), SScaleMin(540 / 3))
		model:SetPos(0 - SScaleMin(169 / 3))

		self.characterTextPanel = self.characterText:Add("Panel")
		self.characterTextPanel:Dock(RIGHT)
		self.characterTextPanel:SetWide(charPanelW)
		self.characterTextPanel.id = character:GetID()

		if i == 1 then
			self.characterTextPanel:DockMargin(0, 0, 0, 0)
		else
			self.characterTextPanel:DockMargin(0, 0, margin, 0)
		end

		local nameText = self.characterTextPanel:Add("DLabel")
		nameText:SetFont("WNMenuFontNoClamp")

		if string.utf8len( character:GetName() ) > 17 then
			nameText:SetText(string.utf8upper(string.utf8sub(character:GetName(), 1, 16) .."..."))
		else
			nameText:SetText(string.utf8upper(character:GetName()))
		end

		nameText:SizeToContents()
		nameText:Dock(TOP)
		nameText:DockMargin(0, SScaleMin(10 / 3), 0, 0)
		nameText:SetContentAlignment(5)

		local factionText = self.characterTextPanel:Add("DLabel")
		factionText:SetFont("WNMenuFontNoClamp")
		if (faction.name) == "Overwatch Transhuman Arm" then
			factionText:SetText("OVERWATCH SOLDIER")
		else
			factionText:SetText(string.utf8upper(faction.name))
		end

		factionText:SizeToContents()
		factionText:Dock(TOP)
		factionText:SetContentAlignment(5)
		factionText:SetTextColor(Color(200, 200, 200, 200))

		local buttons = self.characterTextPanel:Add("Panel")
		buttons:SetSize(self.characterTextPanel:GetWide(), margin)
		buttons:Dock(TOP)
		buttons:DockMargin(0, margin * 0.5, 0, 0)

		local centerButtons = buttons:Add("Panel")
		centerButtons:SetSize((margin * 2) + SScaleMin(15 / 3), buttons:GetTall())
		centerButtons:Center()

		local loadChar = centerButtons:Add("DImageButton")
		loadChar:SetSize(margin, margin)
		loadChar:SetImage("willardnetworks/charselect/check.png")
		loadChar:Dock(LEFT)

		loadChar.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
			loadChar:SetColor( Color( 210, 210, 210, 255 ) )
		end

		loadChar.OnCursorExited = function()
			loadChar:SetColor( Color( 255, 255, 255, 255 ) )
		end

		loadChar.DoClick = function()
			self.character = character
			self:SetMouseInputEnabled(false)
			self:Slide("down", self.animationTime, function()
				net.Start("ixCharacterChoose")
					net.WriteUInt(self.character:GetID(), 32)
				net.SendToServer()
			end, true)
		end

		local deleteButton = centerButtons:Add("DImageButton")
		deleteButton:SetSize(margin, margin)
		deleteButton:SetImage("willardnetworks/charselect/delete.png")
		deleteButton:Dock(RIGHT)

		deleteButton.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
			deleteButton:SetColor( Color( 210, 210, 210, 255 ) )
		end

		deleteButton.OnCursorExited = function()
			deleteButton:SetColor( Color( 255, 255, 255, 255 ) )
		end

		deleteButton.DoClick = function()
			self.character = character
			self:SetActiveSubpanel("delete")
			if self.deleteModel and IsValid(self.deleteModel) then
				self.deleteModel.overrideProxyColors = character:GetProxyColors()
			end
		end
	end

	if (ix.config.Get("CharCreationDisabled", false) and !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Character Creation Bypass") and #ix.characters == 0) then
        Derma_Query( "Do you want to connect to the city server?", "You don't have any characters at this location.", "YES", function()
            RunConsoleCommand("connect", 'hl2rp.willard.network')
        end, "NO")
    end

	local backPanel = panelLoad:Add("Panel")
	backPanel:Dock(TOP)
	backPanel:SetSize(panelLoad:GetWide(), SScaleMin(30 / 3))
	backPanel:DockMargin(0, margin * 2, 0, 0)

	self.back = backPanel:Add("DButton")
	self.back:SetText(string.utf8upper("Back"))
	self.back:SetContentAlignment(6)
	self.back:SetSize(SScaleMin(90 / 3), SScaleMin(30 / 3))
	self.back:SetTextColor(self.aFontColor)
	self.back:SetFont("MainMenuNewButtonFont")
	self.back:Center()
	self.back:SetTextInset(SScaleMin(10 / 3), 0)

	self.back.Paint = function( self, w, h )
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/back_arrow.png"))
		surface.DrawTexturedRect(SScaleMin(10 / 3), (SScaleMin(30 / 3) * 0.5) - (margin * 0.5), margin, margin)
	end

	self.back.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
		self.back:SetTextColor(self.aFontHoverColor)
	end

	self.back.OnCursorExited = function()
		self.back:SetTextColor(self.aFontColor)
	end

	self.back.DoClick = function()
		self:SlideDown()
		parent.mainPanel:Undim()
	end

-- character deletion panel
	self.delete = self:AddSubpanel("delete")
	self.delete:SetTitle(nil)
	self.delete.OnSetActive = function()
	self.delete.avoidPadding = true
		self.deleteModel:SetModel(self.character:GetModel())
		if self.character:GetData("skin") then
			self.deleteModel.Entity:SetSkin(self.character:GetData("skin"))
		end

		local bodygroups = self.character:GetData("groups", nil)

		if (istable(bodygroups)) then
			for k, v in pairs(bodygroups) do
				if self.deleteModel.Entity then
					self.deleteModel.Entity:SetBodygroup(k, v)
				end
			end
		end

		self:CreateAnimation(self.animationTime, {
			index = 2,
			target = {backgroundFraction = 0},
			easing = "outQuint"
		})
	end

	local deleteInfo = self.delete:Add("Panel")
	deleteInfo:SetSize(parent:GetWide() * 0.5, parent:GetTall())
	deleteInfo:Dock(LEFT)

	self.deleteModel = deleteInfo:Add("ixModelPanel")
	self.deleteModel:Dock(FILL)
	self.deleteModel:SetModel(errorModel)
	self.deleteModel:SetFOV(78)
	self.deleteModel.PaintModel = self.deleteModel.Paint

	local deleteNag = self.delete:Add("Panel")
	deleteNag:SetTall(parent:GetTall() * 0.6)
	deleteNag:Dock(BOTTOM)

	local deleteTitle = deleteNag:Add("DLabel")
	deleteTitle:SetFont("WNMenuTitleNoClamp")
	deleteTitle:SetText(string.utf8upper("are you sure?"))
	deleteTitle:SetTextColor(Color(243, 69, 42, 255))
	deleteTitle:SizeToContents()
	deleteTitle:Dock(TOP)

	local deleteText = deleteNag:Add("DLabel")
	deleteText:SetFont("WNSmallerMenuTitleNoClamp")
	deleteText:SetText("This character will be irrevocably removed!")
	deleteText:SetTextColor(color_white)
	deleteText:SetContentAlignment(7)
	deleteText:Dock(TOP)
	deleteText:SizeToContents()

	local yesnoPanel = deleteNag:Add("Panel")
	yesnoPanel:Dock(TOP)
	yesnoPanel:SetTall(SScaleMin(60 / 3))
	yesnoPanel:DockMargin(0, margin, 0, 0)

	local yes = yesnoPanel:Add("DButton")
	yes:Dock(LEFT)
	yes:SetWide(SScaleMin(100 / 3))
	yes:DockMargin(0, 0, SScaleMin(40 / 3), 0)
	yes:SetFont("WNSmallerMenuTitleNoClamp")
	yes:SetText(string.utf8upper("yes"))
	yes.Paint = function(self, w, h) end
	yes:SetContentAlignment(4)
	yes.DoClick = function()

		self.CharacterCount = self.CharacterCount - 1

		local id = self.character:GetID()

		parent:ShowNotice(1, L("deleteComplete", self.character:GetName()))

		self:SetActiveSubpanel("main")

		net.Start("ixCharacterDelete")
			net.WriteUInt(id, 32)
		net.SendToServer()

		for k, v in pairs(self.characterImages:GetChildren()) do
			if v.id == id then
				v:Remove()
			end
		end

		for k, v in pairs(self.characterText:GetChildren()) do
			if v.id == id then
				v:Remove()
			end
		end

		if self.CharacterCount == 1 then
			self.characterImages:SetSize(charPanelW, charImageH)
			self.characterText:SetSize(charPanelW, charTextH + margin)
		else
			self.characterImages:SetSize((self.CharacterCount) * charPanelW + ((self.CharacterCount - 1) * margin), charImageH)
			self.characterText:SetSize((self.CharacterCount) * charPanelW + ((self.CharacterCount - 1) * margin), charTextH + margin)
		end

		if self.CharacterCount > 4 then
			self.characterImages:SetPos(0, 0)
			self.characterText:SetPos(0, self.characterImages:GetTall())
		else
			if IsValid(self.nextButton) then
				self.nextButton:Remove()
			end

			if IsValid(self.previousButton) then
				self.previousButton:Remove()
			end

			self.characterImages:Center()
			local x, y = self.characterImages:GetPos()
			self.characterImages:SetPos(x, 0)

			self.characterText:Center()
			local x, y = self.characterText:GetPos()
			self.characterText:SetPos(x, self.characterImages:GetTall())
		end

		if IsValid(self.characterTextPanel) then
			if self.CharacterCount == 1 then
				self.characterTextPanel:DockMargin(0, 0, 0, 0)
			end
		end
	end

	local no = yesnoPanel:Add("DButton")
	no:Dock(LEFT)
	no:SetWide(SScaleMin(100 / 3))
	no:SetFont("WNSmallerMenuTitleNoClamp")
	no:SetText(string.utf8upper("no"))
	no:SetContentAlignment(6)
	no.Paint = function(self, w, h) end
	no.DoClick = function()
		self:SetActiveSubpanel("main")
	end

	-- finalize setup
	self:SetActiveSubpanel("main", 0)
end

function PANEL:OnCharacterDeleted(character)
	local parent = self:GetParent()
	local bHasCharacter = #ix.characters > 0

	if (self.bActive and #ix.characters == 0) then
		self:SlideDown()
		parent.mainPanel.loadButton:SetDisabled(true)
		parent.mainPanel.loadButton:SetTextColor(self.aFontLockedButtonColor)


		parent.mainPanel.loadButton.OnCursorEntered = function()
			if (!bHasCharacter) then
				parent.mainPanel.loadButton:SetTextColor(self.aFontLockedButtonColor)
				return
			end
		end

		parent.mainPanel.loadButton.OnCursorExited = function()
			if (!bHasCharacter) then
				parent.mainPanel.loadButton:SetTextColor(self.aFontLockedButtonColor)
				return
			end
		end
	end
end

function PANEL:OnSlideUp()
	self.bActive = true
end

function PANEL:OnSlideDown()
	self.bActive = false
end

function PANEL:Paint(width, height)
end

vgui.Register("ixCharMenuLoad", PANEL, "ixCharMenuPanel")
