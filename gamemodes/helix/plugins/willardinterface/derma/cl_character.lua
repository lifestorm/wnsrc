--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local audioFadeInTime = 2
local animationTime = 0.5

-- character menu panel
DEFINE_BASECLASS("ixSubpanelParent")
local PANEL = {}

function PANEL:Init()
	self:UpdateLocations()
	self:SetSize(self:GetParent():GetSize())
	self:SetPos(0, 0)
	self:SetZPos(5)

	self.childPanels = {}
	self.subpanels = {}
	self.activeSubpanel = ""

	self.currentDimAmount = 0
	self.currentY = 0
	self.currentScale = 1
	self.currentAlpha = 255
	self.targetDimAmount = 0
	self.targetScale = 0
end

function PANEL:Dim(length, callback)
	length = length or animationTime
	self.currentDimAmount = 0

	self:CreateAnimation(length, {
		target = {
			currentDimAmount = self.targetDimAmount,
			currentScale = self.targetScale,
			OnComplete = callback
		},
		easing = "outCubic"
	})

	self:OnDim()
end

function PANEL:UpdateLocations()
    for i = 1, #ix.characters do
        local id = ix.characters[i]
        local foundCharacter = ix.char.loaded[id]

        if (!foundCharacter) then
            continue
        end

        local location = foundCharacter.vars.location or false
        local locationConfig = ix.config.Get("Location", false) or false

        if location and locationConfig then
            if location != locationConfig then
                table.remove(ix.characters, i)
            end
        end
    end
end

function PANEL:Undim(length, callback)
	length = length or animationTime
	self.currentDimAmount = self.targetDimAmount

	self:CreateAnimation(length, {
		target = {
			currentDimAmount = 0,
			currentScale = 1
		},
		easing = "outCubic",
		OnComplete = callback
	})

	self:OnUndim()
end

function PANEL:OnDim()
end

function PANEL:OnUndim()
end

function PANEL:Paint(width, height)
	local amount = self.currentDimAmount
	local bShouldScale = self.currentScale != 1
	local matrix

	-- draw child panels with scaling if needed
	if (bShouldScale) then
		matrix = Matrix()
		matrix:Scale(Vector(1, 1, 0.0001) * self.currentScale)
		matrix:Translate(Vector(
			ScrW() * 0.5 - (ScrW() * self.currentScale * 0.5),
			ScrH() * 0.5 - (ScrH() * self.currentScale * 0.5),
			1
		))

		cam.PushModelMatrix(matrix)
		self.currentMatrix = matrix
	end

	BaseClass.Paint(self, width, height)

	if (bShouldScale) then
		cam.PopModelMatrix()
		self.currentMatrix = nil
	end

	if (amount > 0) then
		local color = Color(0, 0, 0, amount)

		surface.SetDrawColor(color)
		surface.DrawRect(0, 0, width, height)
	end
end

vgui.Register("ixCharMenuPanel", PANEL, "ixSubpanelParent")

-- main character menu panel
PANEL = {}

AccessorFunc(PANEL, "bUsingCharacter", "UsingCharacter", FORCE_BOOL)

function PANEL:Init()
	ix.gui.wnMainMenu = self

	ix.panelCreationActive = false
	self:SetSize(ScrW(), ScrH())
end

function PANEL:CreateMainPanel(logoData, buttonData)
	local logoPanel = self:Add("Panel")
	logoPanel:SetSize(self:GetSize())

	local newHeight = 0

	local logoMargin = SScaleMin(40 / 3)
	local shouldDefault = logoData and (logoData.bDefault or !logoData.path) or false
	local hasData = logoData.width and logoData.height and logoData.path and true

	local panelName = ((shouldDefault or !hasData) and "ixWillardCreditsLogoSmall" or "DImage")
	local logoImage = logoPanel:Add(panelName)
	local logoW = SScaleMin(hasData and logoData.width / 3 or 125 / 3)
	local logoH = SScaleMin(hasData and logoData.height / 3 or 128 / 3)

	logoImage:SetSize(logoW, logoH)
	logoImage:Dock(TOP)

	if !shouldDefault and hasData then
		logoImage:SetImage("willardnetworks/"..logoData.path..".png")
	end

	logoImage:DockMargin(logoPanel:GetWide() * 0.5 - logoImage:GetWide() * 0.5, 0, logoPanel:GetWide() * 0.5 -
	logoImage:GetWide() * 0.5, logoMargin)

	newHeight = newHeight + logoImage:GetTall() + (logoMargin)

	local titleLabel = logoPanel:Add("DLabel")
	titleLabel:SetTextColor(color_white)
	titleLabel:SetFont("MainMenuNewTitleFont")
	titleLabel:SetText(string.utf8upper(ix.config.Get("menuTitle") or "Willard Networks"))
	titleLabel:SetContentAlignment(5)
	titleLabel:SizeToContents()
	titleLabel:Dock(TOP)
	titleLabel:DockMargin(0, 0, 0, SScaleMin(15 / 3))

	newHeight = newHeight + titleLabel:GetTall() + SScaleMin(15 / 3)

	self.buttonList = logoPanel:Add("Panel")
	self.buttonList:Dock(TOP)

	self.buttonWidth = 0
	self:CreateButtons(buttonData)

	self.buttonList:SetSize(self.buttonWidth, SScaleMin(30 / 3))
	self.buttonList:DockMargin(logoPanel:GetWide() * 0.5 - self.buttonList:GetWide() * 0.5, 0,
	logoPanel:GetWide() * 0.5 - self.buttonList:GetWide() * 0.5, 0)

	newHeight = newHeight + self.buttonList:GetTall()

	logoPanel:SetTall(newHeight)
	logoPanel:Center()
	local x, y = logoPanel:GetPos()
	logoPanel:SetPos(x, y - SScaleMin(100 / 3))
end

function PANEL:UpdateChildPanels(parent)
	if parent.loadCharacterPanel then
		parent.loadCharacterPanel.aFontColor = self.aFontColor
		parent.loadCharacterPanel.aFontHoverColor = self.aFontHoverColor
		parent.loadCharacterPanel.aFontLockedButtonColor = self.aFontLockedButtonColor

		if parent.loadCharacterPanel.back then
			parent.loadCharacterPanel.back:SetTextColor(self.aFontColor)
		end
	end

	if parent.newCharacterPanel then
		parent.newCharacterPanel.aFontColor = self.aFontColor
		parent.newCharacterPanel.aFontHoverColor = self.aFontHoverColor
		parent.newCharacterPanel.aFontLockedButtonColor = self.aFontLockedButtonColor

		if parent.newCharacterPanel.factionBack then
			parent.newCharacterPanel.factionBack:SetTextColor(self.aFontColor)
		end
	end
end

function PANEL:CreateButtons(buttonData)
	local parent = self:GetParent()
	local buttonHeight = SScaleMin(30 / 3)

	local fontColor = buttonData["Font Color"] or Color(196, 196, 196, 255)
	local fontHoverColor = buttonData["Font Hover Color"] or Color(255, 255, 255, 255)
	local fontLockedButtonColor = buttonData["Font Locked Button Color"] or Color(90, 90, 90, 255)

	self.aFontColor = Color(fontColor.r, fontColor.g, fontColor.b, fontColor.a)
	self.aFontHoverColor = Color(fontHoverColor.r, fontHoverColor.g, fontHoverColor.b, fontHoverColor.a)
	self.aFontLockedButtonColor = Color(fontLockedButtonColor.r, fontLockedButtonColor.g, fontLockedButtonColor.b, fontLockedButtonColor.a)

	local bHasCharacter = #ix.characters > 0
	self.bUsingCharacter = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()

	local function PaintButton(this, text, boolLoad, charCreationDisabled, shouldMargin)
		this:SetText(text)
		this:SetFont("MainMenuNewButtonFont")
		this:SetTextColor(self.aFontColor)
		this:SetContentAlignment(5)
		this:DockMargin(0, 0, (!shouldMargin and SScaleMin(30 / 3) or 0), 0)
		self.buttonWidth = self.buttonWidth + (!shouldMargin and SScaleMin(30 / 3) or 0)

		if (!bHasCharacter and boolLoad) or charCreationDisabled then
			this:SetDisabled(true)
			this:SetTextColor(self.aFontLockedButtonColor)
		end

		this.Paint = nil
	end

	local function OnCursor(name, boolLoad, charCreationDisabled)
		name.OnCursorEntered = function()
			if (!bHasCharacter and boolLoad) then
				if self.loadButtonTitle and IsValid(self.loadButtonTitle) then
					self.loadButtonTitle:SetTextColor(self.aFontLockedButtonColor)
				end

				return
			end

			if charCreationDisabled then
				name:SetTextColor(self.aFontLockedButtonColor)
				return
			end

			surface.PlaySound("helix/ui/rollover.wav")
			name:SetTextColor(self.aFontHoverColor)
		end

		name.OnCursorExited = function()
			if (!bHasCharacter and boolLoad) then
				if self.loadButtonTitle and IsValid(self.loadButtonTitle) then
					self.loadButtonTitle:SetTextColor(self.aFontLockedButtonColor)
				end
				return
			end

			if charCreationDisabled then
				name:SetTextColor(self.aFontLockedButtonColor)
				return
			end

			name:SetTextColor(self.aFontColor)
		end
	end

	-- create character button
	local createButton = self.buttonList:Add("DButton")
	createButton:SetTall(buttonHeight)
	createButton:Dock(LEFT)

	local charCreation = ix.config.Get("CharCreationDisabled") and
	!CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Character Creation Bypass")
	PaintButton(createButton, "NEW ARRIVAL", nil, charCreation)
	OnCursor(createButton, nil, charCreation)

	createButton:SizeToContents()
	self.buttonWidth = self.buttonWidth + createButton:GetWide()

	createButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")

		if !LocalPlayer():GetData("QuizCompleted", false) then
			if ix.gui.quizAnswering then
				if ix.gui.quizAnswering.Remove then
					ix.gui.quizAnswering:Remove()
				end
			end

			vgui.Create("ixQuizMenu")
			netstream.Start("RequestQuizzes", false)
			return
		end

		local maximum = hook.Run("GetMaxPlayerCharacter", LocalPlayer()) or ix.config.Get("maxCharacters", 5)
		-- don't allow creation if we've hit the character limit
		if (#ix.characters >= maximum) then
			self:GetParent():ShowNotice(3, L("maxCharacters"))
			return
		end
		self:Dim()
		parent.newCharacterPanel:SetActiveSubpanel("faction", 0)
		parent.newCharacterPanel:SlideUp()
	end

	-- load character button
	self.loadButton = self.buttonList:Add("DButton")
	self.loadButton:SetTall(buttonHeight)
	self.loadButton:Dock(LEFT)

	PaintButton(self.loadButton, "CHARACTERS", true)
	OnCursor(self.loadButton, true)

	self.loadButton:SizeToContents()
	self.buttonWidth = self.buttonWidth + self.loadButton:GetWide()

	self.loadButton.DoClick = function()
		self:Dim()
		parent.loadCharacterPanel:SlideUp()
		surface.PlaySound("helix/ui/press.wav")
	end

	-- community button
	local communityButton = self.buttonList:Add("DButton")
	communityButton:SetTall(buttonHeight)
	communityButton:Dock(LEFT)
	PaintButton(communityButton, "INFO")

	OnCursor(communityButton)

	communityButton:SizeToContents()
	self.buttonWidth = self.buttonWidth + communityButton:GetWide()

	communityButton.DoClick = function()
		gui.OpenURL("https://willard.network/")
		surface.PlaySound("helix/ui/press.wav")
	end

	-- content button
	local contentButton = self.buttonList:Add("DButton")
	contentButton:SetText("")
	contentButton:SetTall(buttonHeight)
	contentButton:Dock(LEFT)
	PaintButton(contentButton, "CONTENT")

	OnCursor(contentButton)

	contentButton:SizeToContents()
	self.buttonWidth = self.buttonWidth + contentButton:GetWide()

	contentButton.DoClick = function()
		gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2145501003")
		surface.PlaySound("helix/ui/press.wav")
	end

	-- leave/return button
	self.returnButton = self.buttonList:Add("DButton")
	self.returnButton:SetTall(buttonHeight)
	self.returnButton:Dock(LEFT)
	PaintButton(self.returnButton, "", false, false, true)

	OnCursor(self.returnButton)

	self.returnButton:SizeToContents()

	self:UpdateReturnButton()
	self.buttonWidth = self.buttonWidth + self.returnButton:GetWide()

	self.returnButton.DoClick = function()
		if (self.bUsingCharacter) then
			parent:Close()
		else
			RunConsoleCommand("disconnect")
		end

		surface.PlaySound("helix/ui/press.wav")
	end
end

function PANEL:UpdateReturnButton(bValue)
	if (bValue == nil) then
		bValue = self.bUsingCharacter
	end

	if self.returnButton and IsValid(self.returnButton) then
		self.returnButton:SetText(bValue and "RETURN" or "EXIT")
		self.returnButton:SizeToContents()
	end
end

function PANEL:OnDim()
	-- disable input on this panel since it will still be in the background while invisible - prone to stray clicks if the
	-- panels overtop slide out of the way
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
end

function PANEL:OnUndim()
	self:SetMouseInputEnabled(true)
	self:SetKeyboardInputEnabled(true)

	-- we may have just deleted a character so update the status of the return button
	self.bUsingCharacter = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()
	self:UpdateReturnButton()
end

function PANEL:OnClose()
	for _, v in pairs(self:GetChildren()) do
		if (IsValid(v)) then
			v:SetVisible(false)
		end
	end
end

vgui.Register("ixCharMenuMain", PANEL, "ixCharMenuPanel")

-- container panel
PANEL = {}

function PANEL:Init()
	if (IsValid(ix.gui.loading)) then
		ix.gui.loading:Remove()
	end

	if (IsValid(ix.gui.characterMenu)) then
		if (IsValid(ix.gui.characterMenu.channel)) then
			ix.gui.characterMenu.channel:Stop()
		end

		ix.gui.characterMenu:Remove()
	end

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)

	-- main menu panel
	self.mainPanel = self:Add("ixCharMenuMain")
	self.mainPanel.avoidPadding = true

	-- new character panel
	self.newCharacterPanel = self:Add("ixCharMenuNew")
	self.newCharacterPanel:SlideDown(0)

	-- load character panel
	self.loadCharacterPanel = self:Add("ixCharMenuLoad")
	self.loadCharacterPanel:SlideDown(0)

	net.Start("RequestMainMenuInfo")
	net.SendToServer()

	-- notice bar
	self.notice = self:Add("ixNoticeBar")

	-- finalization
	self:MakePopup()
	self.currentAlpha = 255
	self.volume = 0

	ix.gui.characterMenu = self

	if (!IsValid(ix.gui.intro)) then
		self:PlayMusic()
	end

	hook.Run("OnCharacterMenuCreated", self)
end

function PANEL:PlayMusic()
	local path = "sound/" .. ix.config.Get("music")
	local url = path:match("http[s]?://.+")
	local play = url and sound.PlayURL or sound.PlayFile
	path = url and url or path

	play(path, "noplay", function(channel, error, message)
		if (!IsValid(channel)) then
			return
		end

		channel:SetVolume(self.volume or 0)
		channel:Play()

		if IsValid(self) then
			self.channel = channel

			self:CreateAnimation(audioFadeInTime, {
				index = 10,
				target = {volume = 1},

				Think = function(animation, panel)
					if (IsValid(panel.channel)) then
						panel.channel:SetVolume(self.volume * 0.5)
					end
				end
			})
		end
	end)
end

function PANEL:ShowNotice(type, text)
	self.notice:SetType(type)
	self.notice:SetText(text)
	self.notice:Show()
end

function PANEL:HideNotice()
	if (IsValid(self.notice) and !self.notice:GetHidden()) then
		self.notice:Slide("up", 0.5, true)
	end
end

function PANEL:OnCharacterDeleted(character)
	if (#ix.characters == 0) then
		self.mainPanel:Undim() -- undim since the load panel will slide down
	end

	self.loadCharacterPanel:OnCharacterDeleted(character)
end

function PANEL:OnCharacterLoadFailed(error)
	self.loadCharacterPanel:SetMouseInputEnabled(true)
	self.loadCharacterPanel:SlideUp()
	self:ShowNotice(3, error)
end

function PANEL:IsClosing()
	return self.bClosing
end

function PANEL:Close(bFromMenu)
	self.bClosing = true
	self.bFromMenu = bFromMenu

	local fadeOutTime = animationTime * 8

	self:CreateAnimation(fadeOutTime, {
		index = 1,
		target = {currentAlpha = 0},

		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end,

		OnComplete = function(animation, panel)
			panel:Remove()
		end
	})

	self:CreateAnimation(fadeOutTime - 0.1, {
		index = 10,
		target = {volume = 0},

		Think = function(animation, panel)
			if (IsValid(panel.channel)) then
				panel.channel:SetVolume(self.volume * 0.5)
			end
		end,

		OnComplete = function(animation, panel)
			if (IsValid(panel.channel)) then
				panel.channel:Stop()
				panel.channel = nil
			end
		end
	})

	-- hide children if we're already dimmed
	if (bFromMenu) then
		for _, v in pairs(self:GetChildren()) do
			if (IsValid(v)) then
				v:SetVisible(false)
			end
		end
	else
		-- fade out the main panel quicker because it significantly blocks the screen
		self.mainPanel.currentAlpha = 255

		self.mainPanel:CreateAnimation(animationTime * 2, {
			target = {currentAlpha = 0},
			easing = "outQuint",

			Think = function(animation, panel)
				panel:SetAlpha(panel.currentAlpha)
			end,

			OnComplete = function(animation, panel)
				panel:SetVisible(false)
			end
		})
	end

	-- relinquish mouse control
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	gui.EnableScreenClicker(false)
end

function PANEL:Paint(width, height)
	if ix.gui.background_url then
		local mat = Material(ix.gui.background_url)
		local w, h = width, height
		local x, y = 0, 0

		local ratioW = width / mat:Width()
		local ratioH = height / mat:Height()

		if ratioW < 1 then
			w = mat:Width() * ratioH
			x = (w - width) / -2
		else
			h = mat:Height() * ratioW
			y = (h - height) / -2
		end

		surface.SetMaterial(mat)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(x, y, w, h)
	else
		surface.SetDrawColor(Color(63, 58, 115, 100))
		surface.DrawRect(0, 0, width, height)

		Derma_DrawBackgroundBlur( self, 1 )
	end

	--[[surface.SetDrawColor(0, 0, 0, 150)
	surface.DrawTexturedRect(0, 0, width, height)
	ix.util.DrawBlur(self, Lerp((255 - 100) / 255, 0, 10))]]--
end

function PANEL:PaintOver(width, height)
	if (self.bClosing and self.bFromMenu) then
		surface.SetDrawColor(color_black)
		surface.DrawRect(0, 0, width, height)
	end
end

vgui.Register("ixCharMenu", PANEL, "EditablePanel")

if (IsValid(ix.gui.characterMenu)) then
	ix.gui.characterMenu:Remove()

	--TODO: REMOVE ME
	ix.gui.characterMenu = vgui.Create("ixCharMenu")
end

netstream.Hook("SendCharacterPanelNotify", function(error)
	if ix.gui.characterMenu and IsValid(ix.gui.characterMenu) then
		ix.gui.characterMenu:ShowNotice(3, error)
	end
end)
