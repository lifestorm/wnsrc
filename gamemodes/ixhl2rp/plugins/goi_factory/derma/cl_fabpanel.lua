--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local screenMat = Material("vgui/terminal_yellow.png", "smooth")
local frameMat = Material("vgui/gradient-d", "smooth")
local cmbLabel = Material("willardnetworks/datafile/licensedisabled2.png", "smooth")
local cmbLogo = Material("vgui/icons/cmb_logo.png", "smooth")
local wnLogo = Material("vgui/icons/wi_logo.png", "smooth")
local defClr = Color(255, 223, 136)
local redClr = Color(200, 36, 36)
local greenClr = Color(36, 200, 61)
local backgroundColor = Color(9, 9, 9, 75)

local PANEL = {}

AccessorFunc(PANEL, "terminalEntity", "TerminalEntity")
AccessorFunc(PANEL, "usedBy", "UsedBy")
AccessorFunc(PANEL, "disc", "Disc")

local scrwSrn, scrhSrn = 1300, 970

local function CreateButton(name, text, path, font, alignment)
	name:SetContentAlignment(alignment or 4)
	name:SetTextInset(alignment and 0 or 10, 0)
	name:SetFont(font or "WNTerminalMediumText")
	name:SetText(string.utf8upper(text))
	name.Paint = function(self, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawRect(0, 0, w, h)
	end
end

function PANEL:CreateNextPrev(parent, buttonFont, buttonAlign, prevFunc, nextFunc, bHorizontal, manualWidth)
	local nextButton = parent:Add("DButton")
	CreateButton(nextButton, "next", buttonFont, buttonAlign)
	nextButton.DoClick = nextFunc

	local prevButton = parent:Add("DButton")
	CreateButton(prevButton, "previous", buttonFont, buttonAlign)
	prevButton.DoClick = prevFunc

	if !bHorizontal then
		nextButton:Dock(TOP)
		nextButton:SetTall(parent:GetTall() / 2.1)
		nextButton:DockMargin(2, 2, 2, 2)
		prevButton:Dock(FILL)
		prevButton:DockMargin(2, 2, 2, 2)
	else
		prevButton:Dock(LEFT)
		prevButton:DockMargin(5, 5, 5, 5)
		prevButton:SetWide(manualWidth or parent:GetWide() / 2)
		nextButton:Dock(FILL)
		nextButton:DockMargin(5, 5, 5, 5)
	end
end

function PANEL:CreateDivider(parent, dock, bVertical)
	local divider = parent:Add("Panel")
	divider:Dock(dock)
	divider:DockMargin(8, 8, 8, 8)
	divider:SetHeight(10)
	divider.bVertical = bVertical
	divider.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		if !bVertical then
			surface.DrawLine(0, h * 0.5, w, h * 0.5)
		else
			surface.DrawLine(w * 0.5, 0, w * 0.5, h)
		end
	end

	return divider
end

function PANEL:CreateAnimatedFrame(parent, dock, dockL, dockT, dockR, dockB, frameClr, callback)
	local panel = parent:Add("Panel")
	AccessorFunc(panel, "color", "Color")

	panel:DockMargin(dockL, dockT, dockR, dockB)
	panel:Dock(dock)
	panel:InvalidateParent(true)

	panel:SetColor(frameClr)

	local wCoef = 0
	local hCoef = 0
	local anim = self:NewAnimation( 0.75, 0, -1)
	anim.Think = function( s, pnl, fraction )
		wCoef = fraction
	end
	local anim2 = self:NewAnimation( 0.8, 0.85, -1, function( s, pnl )
		if callback then
			callback()
		end
	end )
	anim2.Think = function( s, pnl, fraction )
		hCoef = fraction
	end

	panel.Paint = function(s, w, h)
		w = w * wCoef
		h = h * hCoef

		local clr = s:GetColor()
		clr.a = 100

		surface.SetDrawColor(43, 42, 42, 200)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(clr)
		surface.SetMaterial(frameMat)
		surface.DrawTexturedRect(0, h * 0.95, w, h * 0.05)

		surface.SetDrawColor(clr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	return panel
end

function PANEL:PurgeInnerContent()
	for _, pnl in pairs(self.innerContent:GetChildren()) do
		pnl:Remove()
	end
end

function PANEL:CreateLock()
	self.lockPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.lockPanel) then return end

		self.lockPanel:ColorTo(redClr, 0.5)

		self:GetTerminalEntity():EmitSound("buttons/button8.wav", 55, 100, 1, nil, 0, 11)

		self.bottomWarning = self.lockPanel:Add("DLabel")
		self.bottomWarning:SetFont("WNTerminalLargeText")
		self.bottomWarning:SetText(string.utf8upper("this terminal is occupied"))
		self.bottomWarning:SetTextColor(redClr)
		self.bottomWarning:Dock(BOTTOM)
		self.bottomWarning:DockMargin(0, 0, 0, 32)
		self.bottomWarning:SetContentAlignment(5)
		self.bottomWarning:SizeToContents()
		self.bottomWarning:SetAlpha(0)

		self.warningIcon = self.lockPanel:Add("DLabel")
		self.warningIcon:SetFont("WNTerminalVeryLargeText")
		self.warningIcon:SetTextColor(redClr)
		self.warningIcon:SetText("!")
		self.warningIcon:SetContentAlignment(5)
		self.warningIcon:Center()
		self.warningIcon:SetAlpha(0)
		self.warningIcon:SizeToContents()
		self.warningIcon.Paint = function(s, w, h)
			surface.SetDrawColor(redClr)
			surface.DrawCircle(26, 133, 75)
		end

		local alphishRedClr = redClr
		alphishRedClr.a = 50
		self.upperWarning = self.lockPanel:Add("DLabel")
		self.upperWarning:Dock(TOP)
		self.upperWarning:DockMargin(1, 64, 1, 0)
		self.upperWarning:SetHeight(self:GetParent():GetTall() * 0.1)
		self.upperWarning:SetContentAlignment(5)
		self.upperWarning:SetFont("WNTerminalMediumText")
		self.upperWarning:SetText(string.utf8upper("[PLEASE BE PATIENT // WAIT FOR YOUR TURN]"))
		self.upperWarning:SetTextColor(defClr)
		self.upperWarning.Paint = function(s, w, h)
			surface.SetDrawColor(redClr)
			surface.DrawRect(0, 0, w, h)

			surface.SetMaterial(cmbLabel)
			surface.SetDrawColor(alphishRedClr)
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.upperWarning:SetAlpha(0)

		for _, child in pairs(self.lockPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:InitializeBootupSequence()
	self.wnLogo = self.innerContent:Add("Panel")
	self.wnLogo:SetSize(500, 500)
	self.wnLogo:CenterHorizontal(0.25)
	self.wnLogo:CenterVertical(0.5)
	self.wnLogo.Paint = function(s, w, h)
		surface.SetMaterial(wnLogo)
		surface.SetDrawColor(defClr)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.wnLogo:SetAlpha(0)

	self.cmbLogo = self.innerContent:Add("Panel")
	self.cmbLogo:SetSize(400, 500)
	self.cmbLogo:CenterHorizontal(0.75)
	self.cmbLogo:CenterVertical(0.5)
	self.cmbLogo.Paint = function(s, w, h)
		surface.SetMaterial(cmbLogo)
		surface.SetDrawColor(defClr)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.cmbLogo:SetAlpha(0)

	self.indicator = self.innerContent:Add("Panel")
	self.indicator:SetWide(2)
	self.indicator:SetHeight(self.innerContent:GetTall() - 2)
	self.indicator:Center()
	self.indicator:SetAlpha(0)

	local defClrAlphish = defClr
	defClrAlphish.a = 100
	self.indicator.Paint = function(s, w, h)
		surface.SetDrawColor(defClrAlphish)
		surface.DrawRect(0, 0, w, h)
	end

	for _, child in pairs(self.innerContent:GetChildren()) do
		child:AlphaTo(255, 0.25, 0, function()
			self:GetTerminalEntity():EmitSound("wn_goi/terminal_turnon.mp3", 55, 100, 1, CHAN_VOICE, 0, 11)
		end)
	end

	self.indicator:SizeTo(-1, 0, 1, 0.25, -1, function()
		self.cmbLogo:MoveTo(self.innerContent:GetWide() / 2.72, self.cmbLogo:GetY(), 1)
		self.cmbLogo:AlphaTo(0, 0.15, 0.5)
		self.wnLogo:MoveTo(self.innerContent:GetWide() / 3.5, self.wnLogo:GetY(), 1, 0, -1, function()
			self.wnLogo:AlphaTo(0, 0.25, 1.5, function()
				for _, child in pairs(self.innerContent:GetChildren()) do
					child:Remove()
				end
				self:Proceed()
			end)
		end)
	end)
end

function PANEL:OnDiscDetach()
	if (self.fabricatingPanel) then
		self:PurgeInnerContent()
		self:CreateFabricating()
	end
end

function PANEL:OnDiscAttach()
	if (self.fabricatingPanel) then
		self:PurgeInnerContent()
		self:CreateFabricating()
	end
end

function PANEL:FillDiscInteraction(parent)
	local itemID = self:GetDisc()
	if !itemID then return end

	local item = ix.item.list[itemID]
	self.itemIcon = parent:Add("SpawnIcon")
	self.itemIcon:SetSize(176, 176)
	self.itemIcon:SetModel(item.model)
	self.itemIcon:Center()
	self.itemIcon.PaintOver = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local itemName = parent:Add("DLabel")
	itemName:Dock(TOP)
	itemName:DockMargin(0, 16, 0, 0)
	itemName:SetContentAlignment(5)
	itemName:SetFont("WNTerminalMediumText")
	itemName:SetText(string.utf8upper("encoded item: " .. item.name))
	itemName:SetTextColor(defClr)
	itemName:SizeToContents()
	self:CreateDivider(parent, TOP)

	local fabricateButtonPanel = parent:Add("Panel")
	fabricateButtonPanel:Dock(BOTTOM)
	fabricateButtonPanel:SetTall(64)
	fabricateButtonPanel:DockMargin(128, 0, 128, 16)
	fabricateButtonPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local fabButton = fabricateButtonPanel:Add("DButton")
	CreateButton(fabButton, "SYNTHESIZE", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	fabButton:Dock(FILL)
	fabButton:DockMargin(8, 8, 450, 8)
	fabButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("buttons/button4.wav", 55, 100, 1, nil, 0, 11)

		net.Start("ix.terminal.Fabricate")
			net.WriteEntity(self:GetTerminalEntity())
			net.WriteBool(false)
			net.WriteInt(1, 5)
		net.SendToServer()
	end

	local fabButtonMass = fabricateButtonPanel:Add("DButton")
	CreateButton(fabButtonMass, "BULK SYNTHESIZE", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	fabButtonMass:Dock(FILL)
	fabButtonMass:DockMargin(450, 8, 8, 8)
	fabButtonMass.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("buttons/button4.wav", 55, 100, 1, nil, 0, 11)

		net.Start("ix.terminal.Fabricate")
			net.WriteEntity(self:GetTerminalEntity())
			net.WriteBool(true)
			net.WriteInt(5, 5)
		net.SendToServer()
	end

	local resinLabel = parent:Add("DLabel")
	resinLabel:Dock(BOTTOM)
	resinLabel:DockMargin(0, 0, 0, 8)
	resinLabel:SetContentAlignment(5)
	resinLabel:SetFont("WNTerminalMediumText")
	resinLabel:SetText(string.utf8upper("resin amount required: " .. ix.fabrication:Get(itemID).mainMaterialCost))
	resinLabel:SetTextColor(defClr)
	resinLabel:SizeToContents()
end

function PANEL:CreateFabricating()
	self:PurgeInnerContent()
	self.fabricatingPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.fabricatingPanel) then return end

		self:GetTerminalEntity():EmitSound("buttons/button6.wav", 55, 100, 1, nil, 0, 11)

		local returnButton = self.fabricatingPanel:Add("DButton")
		CreateButton(returnButton, "RETURN", "buttonnoarrow.png", "WNTerminalLargeText", 5)
		returnButton:Dock(TOP)
		returnButton:SetTall(128)
		returnButton:DockMargin(8, 8, 8, 8)
		returnButton.DoClick = function(s)
			if s.bClosing then return end
			s.bClosing = true

			self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)
			self.fabricatingPanel:AlphaTo(0, 0.5, 0, function()
				self:PurgeInnerContent()
				self:CreateSelector()
			end)
		end
		returnButton:SetAlpha(0)

		if (!self:GetDisc() or self:GetDisc() == "") then
			local errorLabel = self.fabricatingPanel:Add("DLabel")
			errorLabel:SetContentAlignment(5)
			errorLabel:SetFont("WNTerminalLargeText")
			errorLabel:SetText(string.utf8upper("encoded data\ndisk required!"))
			errorLabel:SetTextColor(defClr)
			errorLabel:SetAlpha(0)
			errorLabel:SizeToContents()
			errorLabel:CenterHorizontal(0.525)
			errorLabel:CenterVertical(0.5)
			for _, child in pairs(self.fabricatingPanel:GetChildren()) do
				child:AlphaTo(255, 0.95)
			end
			return
		end

		local upperLabel = self.fabricatingPanel:Add("DLabel")
		upperLabel:Dock(TOP)
		upperLabel:SetContentAlignment(5)
		upperLabel:SetFont("WNTerminalLargeText")
		upperLabel:SetText(string.utf8upper("encoded info"))
		upperLabel:SetTextColor(defClr)
		upperLabel:SetAlpha(0)
		upperLabel:SizeToContents()

		local d = self:CreateDivider(self.fabricatingPanel, TOP)
		d:SetAlpha(0)

		self.eFab = self.fabricatingPanel:Add("Panel")
		self.eFab:Dock(FILL)
		self.eFab:DockMargin(16, 16, 16, 48)
		self.eFab:InvalidateParent(true)
		self.eFab.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self.eFab:SetAlpha(0)
		self:FillDiscInteraction(self.eFab)

		for _, child in pairs(self.fabricatingPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:FillRecycleInteraction(parent)
	local fcLabel = parent:Add("DLabel")
	fcLabel:Dock(TOP)
	fcLabel:DockMargin(0, 32, 0, 0)
	fcLabel:SetContentAlignment(5)
	fcLabel:SetFont("WNTerminalMediumText")
	fcLabel:SetText(string.utf8upper("fabricator controls"))
	fcLabel:SetTextColor(defClr)
	fcLabel:SizeToContents()

	local wLabel = parent:Add("DLabel")
	wLabel:Dock(TOP)
	wLabel:DockMargin(0, 8, 0, 0)
	wLabel:SetContentAlignment(5)
	wLabel:SetFont("WNTerminalMediumText")
	wLabel:SetText(string.utf8upper("[keep your hands away from fabricator depot]"))
	wLabel:SetTextColor(defClr)
	wLabel:SizeToContents()

	local buttonsPanel = parent:Add("Panel")
	buttonsPanel:Dock(FILL)
	buttonsPanel:DockMargin(parent:GetWide() / 3, 8, parent:GetWide() / 3, 16)
	buttonsPanel:InvalidateParent(true)
	buttonsPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local toggleDepot = buttonsPanel:Add("DButton")
	CreateButton(toggleDepot, "open\n/\nclose", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	toggleDepot:Dock(LEFT)
	toggleDepot:SetWide(buttonsPanel:GetWide() / 2.15)
	toggleDepot:DockMargin(8, 8, 4, 8)
	toggleDepot.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("buttons/button4.wav", 55, 100, 1, nil, 0, 11)

		net.Start("ix.terminal.ToggleDepot")
			net.WriteEntity(self:GetTerminalEntity())
		net.SendToServer()
	end

	local recycle = buttonsPanel:Add("DButton")
	CreateButton(recycle, "recycle", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	recycle:Dock(FILL)
	recycle:DockMargin(4, 8, 8, 8)
	recycle.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("buttons/button4.wav", 55, 100, 1, nil, 0, 11)

		net.Start("ix.terminal.Recycle")
			net.WriteEntity(self:GetTerminalEntity())
		net.SendToServer()
	end
end

function PANEL:CreateRecycling()
	self:PurgeInnerContent()
	self.recyclingPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.recyclingPanel) then return end

		self:GetTerminalEntity():EmitSound("buttons/button6.wav", 55, 100, 1, nil, 0, 11)

		local returnButton = self.recyclingPanel:Add("DButton")
		CreateButton(returnButton, "RETURN", "buttonnoarrow.png", "WNTerminalLargeText", 5)
		returnButton:Dock(TOP)
		returnButton:SetTall(128)
		returnButton:DockMargin(8, 8, 8, 8)
		returnButton.DoClick = function(s)
			if s.bClosing then return end
			s.bClosing = true

			self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)
			self.recyclingPanel:AlphaTo(0, 0.5, 0, function()
				self:PurgeInnerContent()
				self:CreateSelector()
			end)
		end
		returnButton:SetAlpha(0)

		local upperLabel = self.recyclingPanel:Add("DLabel")
		upperLabel:Dock(TOP)
		upperLabel:SetContentAlignment(5)
		upperLabel:SetFont("WNTerminalLargeText")
		upperLabel:SetText(string.utf8upper("recycling"))
		upperLabel:SetTextColor(defClr)
		upperLabel:SetAlpha(0)
		upperLabel:SizeToContents()

		local d = self:CreateDivider(self.recyclingPanel, TOP)
		d:SetAlpha(0)

		self.recControl = self.recyclingPanel:Add("Panel")
		self.recControl:Dock(FILL)
		self.recControl:DockMargin(16, 16, 16, 48)
		self.recControl:InvalidateParent(true)
		self.recControl.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self.recControl:SetAlpha(0)
		self:FillRecycleInteraction(self.recControl)

		for _, child in pairs(self.recyclingPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:CreateOptionButtons(parent)
	local bClosing = false

	local fabricate = parent:Add("DButton")
	CreateButton(fabricate, "FABRICATE", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	fabricate:Dock(LEFT)
	fabricate:DockMargin(8, 16, 4, 16)
	fabricate:SetWide(parent:GetWide() / 3)
	fabricate.DoClick = function(s)
		if bClosing then return end
		bClosing = true

		self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)
		self.selectorPanel:AlphaTo(0, 0.5, 0, function()
			self:CreateFabricating()
		end)
	end

	local recycle = parent:Add("DButton")
	CreateButton(recycle, "RECYCLE", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	recycle:Dock(LEFT)
	recycle:DockMargin(4, 32, 4, 32)
	recycle:SetWide(parent:GetWide() / 3)
	recycle.DoClick = function(s)
		if bClosing then return end
		bClosing = true

		self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)
		self.selectorPanel:AlphaTo(0, 0.5, 0, function()
			self:CreateRecycling()
		end)
	end

	local bioprocessing = parent:Add("DButton")
	CreateButton(bioprocessing, "BIOPROCESS", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	bioprocessing:Dock(FILL)
	bioprocessing:DockMargin(4, 16, 8, 16)
	bioprocessing.DoClick = function(s)
		if bClosing then return end
		bClosing = true

		self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)
		self.selectorPanel:AlphaTo(0, 0.5, 0, function()
			self:CreateBioprocess()
		end)
	end
end

function PANEL:FillBioPanel(parent)
	local nextPrev = parent:Add("Panel")
	nextPrev:Dock(TOP)
	nextPrev:SetTall(80)
	nextPrev:InvalidateParent(true)
	nextPrev.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local incrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		self.itemIcon:Increment()
	end
	local decrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		self.itemIcon:Decrement()
	end
	self:CreateNextPrev(nextPrev, nil, nil, decrementFunc, incrementFunc, true)

	local bioprocessButtonPanel = parent:Add("Panel")
	bioprocessButtonPanel:Dock(BOTTOM)
	bioprocessButtonPanel:SetTall(64)
	bioprocessButtonPanel:DockMargin(128, 0, 128, 16)
	bioprocessButtonPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local bioButton = bioprocessButtonPanel:Add("DButton")
	CreateButton(bioButton, "SYNTHESIZE", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	bioButton:Dock(FILL)
	bioButton:DockMargin(8, 8, 450, 8)
	bioButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("buttons/button4.wav", 55, 100, 1, nil, 0, 11)

		net.Start("ix.terminal.Bioprocess")
			net.WriteEntity(self:GetTerminalEntity())
			net.WriteString(self.itemIcon.fabID)
			net.WriteBool(false)
			net.WriteInt(1, 5)
		net.SendToServer()
	end

	local bioButtonMass = bioprocessButtonPanel:Add("DButton")
	CreateButton(bioButtonMass, "BULK SYNTHESIZE", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	bioButtonMass:Dock(FILL)
	bioButtonMass:DockMargin(450, 8, 8, 8)
	bioButtonMass.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("buttons/button4.wav", 55, 100, 1, nil, 0, 11)

		net.Start("ix.terminal.Bioprocess")
			net.WriteEntity(self:GetTerminalEntity())
			net.WriteString(self.itemIcon.fabID)
			net.WriteBool(true)
			net.WriteInt(5, 5)
		net.SendToServer()
	end

	local itemInfo = parent:Add("Panel")
	itemInfo:Dock(LEFT)
	itemInfo:DockMargin(0, 0, 0, 0)
	itemInfo:SetWide(400)

	local itemName = itemInfo:Add("DLabel")
	itemName:Dock(TOP)
	itemName:DockMargin(16, 16, 0, 8)
	itemName:SetContentAlignment(5)
	itemName:SetFont("WNTerminalMediumText")
	itemName:SetText("")
	itemName:SetTextColor(defClr)

	local itemMats = itemInfo:Add("DLabel")
	itemMats:Dock(TOP)
	itemMats:DockMargin(16, 16, 0, 8)
	itemMats:SetContentAlignment(5)
	itemMats:SetFont("WNTerminalMediumText")
	itemMats:SetText("")
	itemMats:SetTextColor(defClr)

	local itemP = itemInfo:Add("DLabel")
	itemP:Dock(TOP)
	itemP:DockMargin(16, 16, 0, 8)
	itemP:SetContentAlignment(5)
	itemP:SetFont("WNTerminalMediumText")
	itemP:SetText("")
	itemP:SetTextColor(defClr)

	self.itemIcon = parent:Add("SpawnIcon")
	self.itemIcon:SetSize(176, 176)
	self.itemIcon:SetModel("models/Gibs/HGIBS.mdl")
	self.itemIcon:CenterHorizontal(0.5)
	self.itemIcon:CenterVertical(0.55)
	self.itemIcon.PaintOver = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	self.itemIcon.SetItem = function(s, fabPos)
		s.fabID = self.biofabs[fabPos].id
		s.fab = self.biofabs[fabPos].fab
		s.fabPos = fabPos
		s:OnItemChanged()
	end

	self.itemIcon.OnItemChanged = function(s)
		local curItem = ix.item.list[s.fabID]
		s:SetModel(curItem.model)
		itemName:SetText(string.utf8upper(curItem.name))
		itemMats:SetText(string.utf8upper("biopaste cost: " .. s.fab.mainMaterialCost))
		itemP:SetText("[ " .. s.fabPos .. " / " .. #self.biofabs .. " ]")
	end

	self.itemIcon.Increment = function(s)
		if self.biofabs[s.fabPos + 1] then
			s:SetItem(s.fabPos + 1)
		end
	end

	self.itemIcon.Decrement = function(s)
		if self.biofabs[s.fabPos - 1] then
			s:SetItem(s.fabPos - 1)
		end
	end

	self.itemIcon:SetItem(1)
end

function PANEL:CreateBioprocess()
	self:PurgeInnerContent()
	self.bioprocessPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.bioprocessPanel) then return end

		self:GetTerminalEntity():EmitSound("buttons/button6.wav", 55, 100, 1, nil, 0, 11)

		local returnButton = self.bioprocessPanel:Add("DButton")
		CreateButton(returnButton, "RETURN", "buttonnoarrow.png", "WNTerminalLargeText", 5)
		returnButton:Dock(TOP)
		returnButton:SetTall(128)
		returnButton:DockMargin(8, 8, 8, 8)
		returnButton.DoClick = function(s)
			if s.bClosing then return end
			s.bClosing = true

			self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)
			self.bioprocessPanel:AlphaTo(0, 0.5, 0, function()
				self:PurgeInnerContent()
				self:CreateSelector()
			end)
		end
		returnButton:SetAlpha(0)

		local upperLabel = self.bioprocessPanel:Add("DLabel")
		upperLabel:Dock(TOP)
		upperLabel:SetContentAlignment(5)
		upperLabel:SetFont("WNTerminalLargeText")
		upperLabel:SetText(string.utf8upper("bioprocessing"))
		upperLabel:SetTextColor(defClr)
		upperLabel:SetAlpha(0)
		upperLabel:SizeToContents()

		local d = self:CreateDivider(self.bioprocessPanel, TOP)
		d:SetAlpha(0)

		self.bioPanel = self.bioprocessPanel:Add("Panel")
		self.bioPanel:Dock(FILL)
		self.bioPanel:DockMargin(16, 16, 16, 48)
		self.bioPanel:InvalidateParent(true)
		self.bioPanel.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self.bioPanel:SetAlpha(0)
		self:FillBioPanel(self.bioPanel)

		for _, child in pairs(self.bioprocessPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:CreateSelector()
	self.selectorPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.selectorPanel) then return end

		self:GetTerminalEntity():EmitSound("buttons/combine_button1.wav", 55, 100, 1, nil, 0, 11)

		local upperLabel = self.selectorPanel:Add("DLabel")
		upperLabel:Dock(TOP)
		upperLabel:DockMargin(0, 36, 0, 6)
		upperLabel:SetContentAlignment(5)
		upperLabel:SetFont("WNTerminalLargeText")
		upperLabel:SetText("PROCEEDING")
		upperLabel:SetTextColor(defClr)
		upperLabel:SetAlpha(0)
		upperLabel:SizeToContents()

		local d = self:CreateDivider(self.selectorPanel, TOP)
		d:SetAlpha(0)

		self.sButtonPanel = self.selectorPanel:Add("Panel")
		self.sButtonPanel:Dock(FILL)
		self.sButtonPanel:DockMargin(106, 36, 106, 112)
		self.sButtonPanel:InvalidateParent(true)
		self.sButtonPanel:SetAlpha(0)
		self.sButtonPanel.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self:CreateOptionButtons(self.sButtonPanel)

		for _, child in pairs(self.selectorPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:Proceed()
	if (!self:IsUsedByLocalPlayer()) then
		self:CreateLock()
	else
		self:CreateSelector()
	end
end

function PANEL:IsUsedByLocalPlayer()
	return self:GetUsedBy() == LocalPlayer()
end

function PANEL:SortBiofabs()
	self.biofabs = {}
	for id, fab in pairs(ix.fabrication.list) do
		if fab.category != "bio" then continue end

		self.biofabs[#self.biofabs + 1] = {
			id = id,
			fab = fab,
			fabPos = #self.biofabs + 1
		}
	end
end

function PANEL:Init()
	self:SetSize(scrwSrn, scrhSrn)
	self:SetPos(0, 0)
	self:SetAlpha(0)

	self.innerContent = self:Add("Panel")
	self.innerContent:Dock(FILL)
	self.innerContent:DockMargin(84, 94, 84, 78)
	self.innerContent:InvalidateParent(true)
	self:SetPaintedManually( true )

	self:SortBiofabs()

	self:AlphaTo(255, 0.5, 0, function()
		self:InitializeBootupSequence()
	end)
end

function PANEL:Destroy()
	self:AlphaTo(0, 0.5, 0, function(animData, pnl)
		self:GetTerminalEntity().terminalPanel = nil
		pnl:Remove()
	end)
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 200)
	surface.SetMaterial(screenMat)
	surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("ixFabricator", PANEL, "Panel")