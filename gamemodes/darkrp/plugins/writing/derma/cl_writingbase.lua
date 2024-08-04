--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PANEL = {}
local PLUGIN = PLUGIN
local padding = SScaleMin(20 / 3)

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self:MakePopup()
	Schema:AllowMessage(self)

	self.Paint = function(this, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 150))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( this, 1 )
	end
	
	self.selectorButtons = {}
	self.optionPanels = {}
	self.textEntries = {}
	self.labels = {}
	self.options = {}
	self.images = {}
	self.previewEnabled = false

	self.charHandwriting = LocalPlayer():GetCharacter():GetHandwriting()

	if !self.charHandwriting or self.charHandwriting and !PLUGIN.validHandwriting[self.charHandwriting] then
		self.charHandwriting = "BookChilanka"
	end
end

function PANEL:CreateMainPanel(width, height, bNewspaper)
	local mainPanel = self:Add(bNewspaper and "DScrollPanel" or "Panel")
	mainPanel:SetSize(width, height)
	mainPanel:Center()

	return mainPanel
end

function PANEL:CreateOptionPanel(parent, dock)
	local optionPanel = parent:Add("Panel")
	optionPanel:Dock(dock)
	optionPanel:SetTall(SScaleMin(30 / 3))
	optionPanel:DockMargin(0, (dock == TOP and 0 or padding), 0, (dock == BOTTOM and 0 or padding))
	
	self.optionPanels[#self.optionPanels + 1] = optionPanel

	return optionPanel
end

function PANEL:CreateDividerLine(parent, dock)
	local dividerLine = parent:Add("DShape")
	dividerLine:SetWide(1)
	dividerLine:Dock(dock)
	dividerLine:DockMargin(padding, padding / 4, padding, padding / 4)
	dividerLine:SetType("Rect")
	dividerLine:SetColor(color_white)

	return dividerLine
end

function PANEL:Populate(itemID, identifier, data)
end

function PANEL:CreateOption(parent, dock, text, callback, mL, mT, mR, mB)
	local option = parent:Add("DButton")
	option:Dock(dock)
	option:SetText(text or "")
	option:SetContentAlignment(5)
	option:SetFont("MenuFontLargerBoldNoFix")
	option:SizeToContents()
	option:DockMargin(mL or 0, mT or 0, mR or 0, mB or 0)
	option.Paint = nil
	option.DoClick = function(button)
		surface.PlaySound("helix/ui/press.wav")
		if (callback) then
			callback(button)
		end
	end

	self.options[#self.options + 1] = option

	return option
end

function PANEL:CreateExitButton(parent, dock, mL, mT, mR, mB)
	local option = self:CreateOption(parent, dock, "EXIT", function()
		self:Remove()
	end, mL, mT, mR, mB)

	return option
end

function PANEL:ConvertTextEntryToLabel(parent, textEntry)
	textEntry:SetVisible(false)

	local label = parent:Add("DLabel")
	label:SetText(textEntry:GetValue())
	label:SetFont(textEntry:GetFont())
	label:SetTall(textEntry:GetTall())
	label:Dock(textEntry:GetDock())
	label:SetContentAlignment(textEntry.bAlignTopLeft and 7 or textEntry.bAlignLeft and 4 or textEntry.bAlignRight and 4 or 5)

	local dmL, dmT, dmR, dmB = textEntry:GetDockMargin()
	label:SetPos(textEntry:GetPos())
	label:DockMargin(((textEntry.bAlignLeft or textEntry.bAlignTopLeft) and (dmL + SScaleMin(2 / 3)) or dmL), dmT, dmR, dmB)
	label:SetTextColor(textEntry:GetTextColor())
	label:SetZPos(textEntry:GetZPos())

	self.labels[#self.labels + 1] = label

	return label
end

function PANEL:TogglePreview(button)
	if self.previewEnabled then
		if (button) then
			button:SetText("PREVIEW")
			button:SizeToContents()
		end

		for _, textPanel in pairs(self.textEntries) do
			textPanel:SetVisible(true)
			textPanel:SetKeyboardInputEnabled(true)
			textPanel:SetCursorColor(Color(0, 0, 0, 255))

			textPanel.shouldVoidPlaceholder = false
		end

		for _, label in pairs(self.labels) do
			label:SetVisible(false)
		end

		for _, selector in pairs(self.selectorButtons) do
			if IsValid(selector) then
				if IsValid(selector.temp) then
					selector.temp:SetVisible(false)
				end

				selector:SetVisible(true)
			end
		end

		for _, option in pairs(self.options) do
			if option:GetText() == "EXIT" then continue end

			option:SetVisible(true)
		end

		self.previewEnabled = false
	else
		if (button) then
			button:SetText("STOP PREVIEW")
			button:SizeToContents()
		end

		for _, textPanel in pairs(self.textEntries) do
			if !IsValid(textPanel) then continue end
			if textPanel.fixedHeight then
				self:ConvertTextEntryToLabel(textPanel:GetParent(), textPanel)
			else
				textPanel:SetKeyboardInputEnabled(false)
				textPanel:SetCursorColor(Color(0, 0, 0, 0))
			end

			textPanel.shouldVoidPlaceholder = true
		end

		for _, selector in pairs(self.selectorButtons) do
			if IsValid(selector) then
				local temp = selector:GetParent():Add("Panel")
				temp:Dock(selector:GetDock())
				temp:SetSize(selector:GetSize())
				temp:SetZPos(selector:GetZPos())
				temp:DockMargin(selector:GetDockMargin())

				selector:SetVisible(false)
				selector.temp = temp

				selector:SetVisible(false)
			end
		end

		for _, option in pairs(self.options) do
			if !IsValid(option) then continue end
			if option:GetText() == "EXIT" then continue end
			option:SetVisible(false)
		end

		self.previewEnabled = true
	end
end

function PANEL:CreateTextEntry(parent, width, height, dock, mL, mT, mR, mB, pos, font, maxChars, bMultiline, bEditable, text, color, placeholderText)
	local textEntry = parent:Add("DTextEntry")
	textEntry:Dock(!dock and NODOCK or dock)
	textEntry:MoveToFront()
	textEntry:SetMultiline(bMultiline or false)
	textEntry:SetFont(font)
	textEntry:SetText(text or "")
	textEntry:SetPos(pos or 0, 0)
	textEntry:SetSize(width or 0, height or 0)
	if (height) then textEntry.fixedHeight = true end

	textEntry:SetTextColor(color or color_black)
	textEntry:DockMargin(mL or 0, mT or 0, mR or 0, mB or 0)
	textEntry:SetKeyboardInputEnabled(bEditable or true)
	textEntry:SetPlaceholderText(placeholderText or "")
	textEntry:SetPlaceholderColor(color_black)

	if (!bEditable) then
		textEntry:SetCursorColor(Color(0, 0, 0, 0))
	end

	textEntry.Paint = function(this, w, h)
		if !this.shouldVoidPlaceholder then
			if ( this.GetPlaceholderText and this.GetPlaceholderColor and this:GetPlaceholderText() and this:GetPlaceholderText():Trim() != "" and this:GetPlaceholderColor() and ( !this:GetText() or this:GetText() == "" ) ) then

				local oldText = this:GetText()

				local str = this:GetPlaceholderText()
				if ( str:StartWith( "#" ) ) then str = str:utf8sub( 2 ) end
				str = language.GetPhrase( str )

				this:SetText( str )
				this:DrawTextEntryText( this:GetPlaceholderColor(), this:GetHighlightColor(), this:GetCursorColor() )
				this:SetText( oldText )

				return
			end
		end

		this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
	end

	textEntry.AllowInput = function()
		local value = textEntry:GetValue()
		if (string.utf8len(value) > maxChars) then
		  return true
		end
	end

	self.textEntries[#self.textEntries + 1] = textEntry

	return textEntry
end

function PANEL:CreateLinkedImage(parent, width, height, dock, mL, mT, mR, mB, pos, url)
	local image = parent:Add("HTML")
	image:SetSize(width or 0, height or 0)
	image:DockMargin(mL or 0, mT or 0, mR or 0, mB or 0)
	image:Dock(!dock and NODOCK or dock)
	image:SetPos(pos or 0, 0)
	image:SetHTML("<html style='margin:0; padding:0; overflow: hidden;'> <body style ='overflow: hidden; padding: 0; margin: 0;'>  <img src='"..url.."' style='width:100%; height:auto;'> </body> <footer style='margin:0; padding:0; overflow: hidden;'></footer> </html>")

	self.images[#self.images + 1] = image

	return image
end

function PANEL:CreateSelectorButton(parent, width, height, dock, mL, mT, mR, mB, pos, text, callback)
	local selectorButton = parent:Add("DButton")
	selectorButton:SetSize(width or 0, height or 0)
	selectorButton:Dock(!dock and NODOCK or dock)
	selectorButton:DockMargin(mL or 0, mT or 0, mR or 0, mB or 0)
	selectorButton:SetPos(pos or 0, 0)
	selectorButton:SetText(text or "")
	selectorButton:SetFont("MenuFontNoClamp")
	selectorButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if (callback) then
			callback()
		end
	end

	self.selectorButtons[#self.selectorButtons + 1] = selectorButton

	return selectorButton
end

vgui.Register("ixWritingBase", PANEL, "EditablePanel")