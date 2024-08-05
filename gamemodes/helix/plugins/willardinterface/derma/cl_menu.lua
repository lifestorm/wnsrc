--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local animationTime = 1

DEFINE_BASECLASS("ixSubpanelParent")
local PANEL = {}

AccessorFunc(PANEL, "bCharacterOverview", "CharacterOverview", FORCE_BOOL)

function PANEL:Init()
	if (IsValid(ix.gui.menu)) then
		ix.gui.menu:Remove()
	end

	ix.gui.menu = self

	-- properties
	self.manualChildren = {}
	self.noAnchor = CurTime() + 0.4
	self.anchorMode = true

	self.currentAlpha = 0
	self.currentBlur = 0

	-- setup
	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	
	-- Main panel
	self.topbar = self:Add("Panel")
	self.topbar:SetSize(ScrW(), ScreenScale(50 / 3))
	self.topbar.Paint = function( panel, width, height )
		-- background dim
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, self.topbar:GetWide(), self.topbar:GetTall())
	end

	local arrow = self.topbar:Add("DImageButton")
	arrow:SetImage("willardnetworks/tabmenu/navicons/left_arrow.png")
	arrow:SetSize(ScreenScale(20 / 3), ScreenScale(20 / 3))
	arrow:Dock(LEFT)
	arrow:DockMargin(ScreenScale(50 / 3), ScreenScale(15 / 3), math.Clamp(ScreenScale(100 / 3), 0, 100), ScreenScale(15 / 3))
	arrow.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
		vgui.Create("ixCharMenu")
	end
	
	local exit = self.topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(ScreenScale(20 / 3), ScreenScale(20 / 3))
	exit:Dock(RIGHT)
	exit:DockMargin(ScreenScale(100 / 3), ScreenScale(15 / 3), ScreenScale(50 / 3), ScreenScale(15 / 3))
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end	

	local l, _, r, _ = arrow:GetDockMargin()
	local l2, _, r2, _ = exit:GetDockMargin()
	local arrowWide = arrow:GetWide()
	local exitWide = exit:GetWide()
	
	-- tabs
	self.tabs = self.topbar:Add("Panel")
	self.tabs.buttons = {}
	self.tabs:Dock(LEFT)
	self.tabs:SetSize(self.topbar:GetWide() - l - r - l2 - r2 - arrowWide - exitWide, ScreenScale(50 / 3))
	self:PopulateTabs()

	self:MakePopup()
	self:OnOpened()
end

function PANEL:OnOpened()
	self:SetAlpha(0)

	self:CreateAnimation(animationTime, {
		target = {currentAlpha = 255},
		easing = "outQuint",

		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end
	})
end

function PANEL:GetActiveTab()
	return (self:GetActiveSubpanel() or {}).subpanelName
end

function PANEL:TransitionSubpanel(id)
	local lastSubpanel = self:GetActiveSubpanel()

	-- don't transition to the same panel
	if (IsValid(lastSubpanel) and lastSubpanel.subpanelID == id) then
		return
	end

	local subpanel = self:GetSubpanel(id)

	if (IsValid(subpanel)) then
		if (!subpanel.bPopulated) then
			local info = subpanel.info
			subpanel.Paint = nil

			if (istable(info) and info.Create) then
				info:Create(subpanel)
			elseif (isfunction(info)) then
				info(subpanel)
			end

			hook.Run("MenuSubpanelCreated", subpanel.subpanelName, subpanel)
			subpanel.bPopulated = true
		end

		self:SetActiveSubpanel(id)
	end

	subpanel = self:GetActiveSubpanel()

	local info = subpanel.info
	local bHideBackground = istable(info) and (info.bHideBackground != nil and info.bHideBackground or false) or false

	if (bHideBackground) then
		self:HideBackground()
	else
		self:ShowBackground()
	end

	-- call hooks if we've changed subpanel
	if (IsValid(lastSubpanel) and istable(lastSubpanel.info) and lastSubpanel.info.OnDeselected) then
		lastSubpanel.info:OnDeselected(lastSubpanel)
	end

	if (IsValid(subpanel) and istable(subpanel.info) and subpanel.info.OnSelected) then
		subpanel.info:OnSelected(subpanel)
	end

	ix.gui.lastMenuTab = id
end

function PANEL:HideBackground()
	self:CreateAnimation(animationTime, {
		index = 2,
		target = {currentBlur = 0},
		easing = "outQuint"
	})
end

function PANEL:ShowBackground()
	self:CreateAnimation(animationTime, {
		index = 2,
		target = {currentBlur = 1},
		easing = "outQuint"
	})
end

function PANEL:PopulateTabs()
	local default
	local tabs = {}
	
	hook.Run("CreateMenuButtons", tabs)
	
	for name, info in SortedPairsByMemberValue(tabs, "RowNumber", false) do
		local bTable = istable(info)
		local buttonColor = (bTable and info.buttonColor) or Color(163, 57, 59, 255)
		local bDefault = (bTable and info.bDefault) or false

		-- setup subpanels without populating them so we can retain the order
		local subpanel = self:AddSubpanel(name, true)
		local id = subpanel.subpanelID
		subpanel.info = info
		subpanel:SetPaintedManually(true)
		subpanel:SetTitle(nil)
		subpanel:SetSize(ScrW(), ScrH())

		-- this is called while the subpanel has not been populated
		subpanel.Paint = function(panel, width, height)
		end
		
		local button = self.tabs:Add("ixMenuSelectionButton")
		button:SetText("")
		
		if (info.Right) then
			button:Dock(RIGHT)
		else
			button:Dock(LEFT)
		end
		
		button:SetButtonList(self.tabs.buttons)
		button:SetBackgroundColor(buttonColor)
		button.id = id
		button.OnSelected = function()
			self:TransitionSubpanel(id)
		end
		
		local icon = button:Add("DImage")
		icon:SetImage(tostring(info.Icon))
		icon:SetSize(ScreenScale(info.Width / 3), ScreenScale(info.Height / 3))
		
		local iconWidth = ScreenScale(info.Width / 3) or 0
		local iconHeight = ScreenScale(info.Height / 3) or 0
		
		local title = button:Add("DLabel")
		title:SetFont("MenuFontNoClamp")
		title:SetText(L(name))
		title:SizeToContents()
		title:SetPos(button:GetWide() * 0.5 - title:GetWide() * 0.5 + iconWidth * 0.5 + ScreenScale(4 / 3), button:GetTall() * 0.5 - title:GetTall() * 0.5)
		
		icon:MoveLeftOf(title)
		local x, y = icon:GetPos()
		
		icon:SetPos(x - ScreenScale(8 / 3), button:GetTall() * 0.5 - iconHeight * 0.5)
		
		if (bTable and info.PopulateTabButton) then
			info:PopulateTabButton(button)
		end

		if (bDefault) then
			default = button
		end
	end

	if (ix.gui.lastMenuTab) then
		for i = 1, #self.tabs.buttons do
			local button = self.tabs.buttons[i]

			if (button.id == ix.gui.lastMenuTab) then
				default = button
				break
			end
		end
	end

	if (!IsValid(default) and #self.tabs.buttons > 0) then
		default = self.tabs.buttons[1]
	end

	if (IsValid(default)) then
		default:SetSelected(true)
		self:SetActiveSubpanel(default.id, 0)
	end
	

	self.topbar:MoveToFront()
end

function PANEL:AddManuallyPaintedChild(panel)
	panel:SetParent(self)
	panel:SetPaintedManually(panel)

	self.manualChildren[#self.manualChildren + 1] = panel
end

function PANEL:OnKeyCodePressed(key)
	self.noAnchor = CurTime() + 0.5

	if (key == KEY_TAB) then
		self:Remove()
	end
end

function PANEL:Think()
	if (self.bClosing) then
		return
	end

	local bTabDown = input.IsKeyDown(KEY_TAB)

	if (bTabDown and (self.noAnchor or CurTime() + 0.4) < CurTime() and self.anchorMode) then
		self.anchorMode = false
	end

	if ((!self.anchorMode and !bTabDown) or gui.IsGameUIVisible()) then
		self:Remove()
	end
end

function PANEL:Paint(width, height)

	surface.SetDrawColor(Color(63, 58, 115, 220))
	surface.DrawRect(0, 0, width, height)

	Derma_DrawBackgroundBlur( self, self.startTime )

	BaseClass.Paint(self, width, height)
	self:PaintSubpanels(width, height)

	for i = 1, #self.manualChildren do
		self.manualChildren[i]:PaintManual()
	end

	if (IsValid(ix.gui.inv1) and ix.gui.inv1.childPanels) then
		for i = 1, #ix.gui.inv1.childPanels do
			local panel = ix.gui.inv1.childPanels[i]

			if (IsValid(panel)) then
				panel:PaintManual()
			end
		end
	end

	if (bShouldScale) then
		cam.PopModelMatrix()
	end
end

function PANEL:Remove()
	local id = ix.gui.lastMenuTab
	if self:GetSubpanel(id) then
		if self:GetSubpanel(id).info.model then
			self:GetSubpanel(id).info.model:Remove()
		end
	end
		
	if IsValid(ix.gui.characterpanel) then
		if ix.gui.characterpanel.model then
			ix.gui.characterpanel.model:Remove()
		end
	end
	
	if IsValid(ix.gui.inventoryModel) then
		ix.gui.inventoryModel:Remove()
	end
	
	if IsValid(ix.gui.craftingpanel) then
		if ix.gui.craftingpanel.model then
			ix.gui.craftingpanel.model:Remove()
		end
	end
	
	if IsValid(ix.gui.barteringpanel) then
		if ix.gui.barteringpanel.model then
			ix.gui.barteringpanel.model:Remove()
		end
	end
	
	if IsValid(ix.gui.medicalpanel) then
		if ix.gui.medicalpanel.model then
			ix.gui.medicalpanel.model:Remove()
		end
	end

	self.bClosing = true
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)

	-- remove input from opened child panels since they grab focus
	if (IsValid(ix.gui.inv1) and ix.gui.inv1.childPanels) then
		for i = 1, #ix.gui.inv1.childPanels do
			local panel = ix.gui.inv1.childPanels[i]

			if (IsValid(panel)) then
				panel:SetMouseInputEnabled(false)
				panel:SetKeyboardInputEnabled(false)
			end
		end
	end

	CloseDermaMenus()
	gui.EnableScreenClicker(false)

	self:CreateAnimation(animationTime * 0.5, {
		index = 2,
		target = {currentBlur = 0},
		easing = "outQuint"
	})

	self:CreateAnimation(animationTime * 0.5, {
		target = {currentAlpha = 0},
		easing = "outQuint",

		-- we don't animate the blur because blurring doesn't draw things
		-- with amount < 1 very well, resulting in jarring transition
		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end,

		OnComplete = function(animation, panel)
			if (IsValid(panel.projectedTexture)) then
				panel.projectedTexture:Remove()
			end

			BaseClass.Remove(panel)
		end
	})
end

vgui.Register("ixMenu", PANEL, "ixSubpanelParent")

if (IsValid(ix.gui.menu)) then
	ix.gui.menu:Remove()
end

ix.gui.lastMenuTab = nil
