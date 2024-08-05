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

local scrwSrn, scrhSrn = 1780, 870

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
	self.indicator:SetWide(25)
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
		self.wnLogo:MoveTo(self.innerContent:GetWide() / 3, self.wnLogo:GetY(), 1, 0, -1, function()
			self.wnLogo:AlphaTo(0, 0.25, 1.5, function()
				for _, child in pairs(self.innerContent:GetChildren()) do
					child:Remove()
				end
				self:Proceed()
			end)
		end)
	end)
end

function PANEL:BuildEncodingPanel()
	self.encodingPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.encodingPanel) then return end

		self:GetTerminalEntity():EmitSound("buttons/combine_button7.wav", 55, 100, 1, nil, 0, 11)

		local upperLabel = self.encodingPanel:Add("DLabel")
		upperLabel:SetFont("WNTerminalLargeText")
		upperLabel:SetText(string.utf8upper("scanning and encoding..."))
		upperLabel:SetTextColor(defClr)
		upperLabel:Dock(TOP)
		upperLabel:DockMargin(0, 32, 0, 0)
		upperLabel:SetContentAlignment(5)
		upperLabel:SizeToContents()
		upperLabel:SetAlpha(0)

		local bottomLabel = self.encodingPanel:Add("DLabel")
		bottomLabel:SetFont("WNTerminalMediumText")
		bottomLabel:SetText(string.utf8upper("don't put your hands in terminal depot"))
		bottomLabel:SetTextColor(defClr)
		bottomLabel:Dock(BOTTOM)
		bottomLabel:DockMargin(0, 0, 0, 32)
		bottomLabel:SetContentAlignment(5)
		bottomLabel:SizeToContents()
		bottomLabel:SetAlpha(0)

		self:CreateDivider(self.encodingPanel, TOP)
		self:CreateDivider(self.encodingPanel, BOTTOM)

		local barPanel = self.encodingPanel:Add("Panel")
		barPanel:Dock(FILL)
		barPanel:DockMargin(32, 32, 32, 32)
		barPanel.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		barPanel:SetAlpha(0)

		local bar = barPanel:Add("Panel")
		bar:Dock(FILL)
		bar:DockMargin(16, 16, 16, 16)
		bar.Paint = function(s, w, h)
			surface.SetDrawColor(defClr)
			surface.DrawRect(0, 0, w, h)
		end
		bar:SizeTo(0, -1, self:GetTerminalEntity().scanTimer - 2, 1, 1, function()
			bar:SetAlpha(0)
			self.encodingPanel:AlphaTo(0, 0.5, 0.5, function()
				self:PurgeInnerContent()
				self:Proceed()
			end)
		end)

		for _, child in pairs(self.encodingPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:Encode()
	self:PurgeInnerContent()
	self:BuildEncodingPanel()
end

function PANEL:OnDiscAttach()
	if self.discPanel then
		self.discPanel:ColorTo(greenClr, 0.5, 0, function()
			if (IsValid(self.bottomLabel) and IsValid(self.upperLabel)) then
				self.bottomLabel:AlphaTo(0, 0.25)
				self.upperLabel:AlphaTo(0, 0.25)
			end

			self:GetTerminalEntity():EmitSound("buttons/combine_button5.wav", 55, 100, 1, nil, 0, 11)
			self.discPanel:AlphaTo(0, 0.5, 1, function()
				self.discPanel:Remove()
				self:ToInteraction()
			end)
		end)
	end
end

function PANEL:OnDiscDetach()
	self:SetDisc(nil)
	self:PurgeInnerContent()
	self:RequestDisc()
end

function PANEL:RequestDisc()
	self.discPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.discPanel) then return end

		self:GetTerminalEntity():EmitSound("buttons/combine_button1.wav", 55, 100, 1, nil, 0, 11)

		self.bottomLabel = self.discPanel:Add("DLabel")
		self.bottomLabel:SetFont("WNTerminalLargeText")
		self.bottomLabel:SetText(string.utf8upper("empty data disc is required"))
		self.bottomLabel:SetTextColor(defClr)
		self.bottomLabel:Dock(BOTTOM)
		self.bottomLabel:DockMargin(0, 0, 0, 32)
		self.bottomLabel:SetContentAlignment(5)
		self.bottomLabel:SizeToContents()
		self.bottomLabel:SetAlpha(0)

		local defClrAlphish = defClr
		defClrAlphish.a = 100
		self.upperLabel = self.discPanel:Add("DLabel")
		self.upperLabel:Dock(TOP)
		self.upperLabel:DockMargin(1, 64, 1, 0)
		self.upperLabel:SetHeight(self:GetParent():GetTall() * 0.1)
		self.upperLabel:SetContentAlignment(5)
		self.upperLabel:SetFont("WNTerminalMediumText")
		self.upperLabel:SetText(string.utf8upper("[INSERT EMPTY DATA DISK TO PROCEED // ENCODING DATA CENTRE]"))
		self.upperLabel:SetTextColor(defClr)
		self.upperLabel.Paint = function(s, w, h)
			surface.SetDrawColor(self.discPanel:GetColor())
			surface.DrawRect(0, 0, w, h)

			surface.SetMaterial(cmbLabel)
			surface.SetDrawColor(self.discPanel:GetColor())
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.upperLabel:SetAlpha(0)

		self.cmbLogo = self.discPanel:Add("Panel")
		self.cmbLogo:SetSize(400, 500)
		self.cmbLogo:Center()
		self.cmbLogo.Paint = function(s, w, h)
			surface.SetMaterial(cmbLogo)
			surface.SetDrawColor(self.discPanel:GetColor())
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.cmbLogo:SetAlpha(0)

		for _, child in pairs(self.discPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:Proceed()
	if (!self:IsUsedByLocalPlayer()) then
		self:CreateLock()
	else
		if (!self:GetDisc()) then
			self:RequestDisc()
		else
			self:ToInteraction()
		end
	end
end

function PANEL:BuildInteraction(parent)
	if self:GetDisc() != "" then
		local errorLabel = parent:Add("DLabel")
		errorLabel:Dock(FILL)
		errorLabel:SetContentAlignment(5)
		errorLabel:SetFont("WNTerminalMediumText")
		errorLabel:SetText(string.utf8upper("inserted disc already has \n an item encoded"))
		errorLabel:SetTextColor(defClr)
		return
	end

	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 8, 0, 0)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText(string.utf8upper("encoding process"))
	upperLabel:SetTextColor(defClr)
	self:CreateDivider(parent, TOP)

	local bottomLabel = parent:Add("DLabel")
	bottomLabel:Dock(BOTTOM)
	bottomLabel:DockMargin(0, 0, 0, 16)
	bottomLabel:SetContentAlignment(5)
	bottomLabel:SetFont("WNTerminalMediumSmallerText")
	bottomLabel:SetText(string.utf8upper("insert required item in terminal and confirm scan"))
	bottomLabel:SetTextColor(defClr)
	self:CreateDivider(parent, BOTTOM)

	local confirmPanel = parent:Add("Panel")
	confirmPanel:Dock(FILL)
	confirmPanel:DockMargin(256, 64, 256, 64)
	confirmPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local confirmLabel = confirmPanel:Add("DLabel")
	confirmLabel:Dock(TOP)
	confirmLabel:DockMargin(0, 16, 0, 0)
	confirmLabel:SetContentAlignment(5)
	confirmLabel:SetFont("WNTerminalMediumSmallerText")
	confirmLabel:SetText(string.utf8upper("proceed encoding?"))
	confirmLabel:SetTextColor(defClr)
	confirmLabel:SizeToContents()
	self:CreateDivider(confirmPanel, TOP)

	local confirmButton = confirmPanel:Add("DButton")
	CreateButton(confirmButton, "CONFIRM SCAN", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	confirmButton:Dock(FILL)
	confirmButton:DockMargin(8, 8, 8, 8)
	confirmButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)

		net.Start("ix.terminal.Scan")
			net.WriteEntity(self:GetTerminalEntity())
		net.SendToServer()
	end
end

function PANEL:ToInteraction()
	self.interactionPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.interactionPanel) then return end

		self:GetTerminalEntity():EmitSound("buttons/combine_button1.wav", 55, 100, 1, nil, 0, 11)

		self.interact = self.interactionPanel:Add("Panel")
		self.interact:SetWide(self.interactionPanel:GetWide() * 0.6)
		self.interact:SetTall(self.interactionPanel:GetTall() / 1.65)
		self.interact:Center()
		self.interact.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self.interact:InvalidateParent(true)
		self.interact:SetAlpha(0)
		self:BuildInteraction(self.interact)

		for _, child in pairs(self.interactionPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:OnDataDiscInsert(dData)
	if self.discPanel then
		self.bottomLabel:AlphaTo(0, 0.5)
		self.upperLabel:AlphaTo(0, 0.5)

		self.discPanel:ColorTo(greenClr, 0.5, 0, function()
			self:GetTerminalEntity():EmitSound("buttons/combine_button5.wav", 55, 100, 1, nil, 0, 11)
			self.discPanel:AlphaTo(0, 0.5, 1, function()
				self.discPanel:Remove()
			end)
		end)
	end
end

function PANEL:OnDiscRemoved()
	self:PurgeInnerContent()
	self:RequestDisc()
end

function PANEL:IsUsedByLocalPlayer()
	return self:GetUsedBy() == LocalPlayer()
end

function PANEL:Init()
	self:SetSize(scrwSrn, scrhSrn)
	self:SetPos(0, 0)
	self:SetAlpha(0)

	self.innerContent = self:Add("Panel")
	self.innerContent:Dock(FILL)
	self.innerContent:DockMargin(118, 84, 118, 70)
	self.innerContent:InvalidateParent(true)
	self:SetPaintedManually( true )

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
	surface.SetDrawColor(255, 255, 255, 100)
	surface.SetMaterial(screenMat)
	surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("ixDataEncoder", PANEL, "Panel")