--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


--luacheck: ignore global Derma_Select
function Derma_Select(text, title, list, defaultText, confirmText, confirmCallback, cancelText, cancelCallback)
	local panel = vgui.Create("DFrame")
	panel:SetTitle(title or "Selection Title")
	panel:SetDraggable(false)
	panel:ShowCloseButton(false)
	panel:SetDrawOnTop(true)
	DFrameFixer(panel)

	local innerPanel = vgui.Create("DPanel", panel)
	innerPanel:SetPaintBackground(false)

	local textPanel = vgui.Create("DLabel", innerPanel)
	textPanel:SetText(text or "Selection Text")
	textPanel:SetFont("MenuFontNoClamp")
	textPanel:SizeToContents()
	textPanel:SetContentAlignment(5)
	textPanel:SetTextColor(color_white)

	local buttonPanel = vgui.Create("DPanel", panel)
	buttonPanel:SetTall(SScaleMin(30 / 3))
	buttonPanel:SetPaintBackground(false)

	local button = vgui.Create("DButton", buttonPanel)
	button:SetText(confirmText or "OK")
	button:SetFont("MenuFontNoClamp")
	button:SizeToContents()
	button:SetTall(SScaleMin(25 / 3))
	button:SetWide(button:GetWide() + SScaleMin(20 / 3))
	button:SetPos(SScaleMin(5 / 3), SScaleMin(5 / 3))
	button:SetDisabled(true)
	button:SetTextColor(Color(255, 255, 255, 30))
	button.DoClick = function()
		local text1, value = panel.comboBox:GetSelected()
		if (confirmCallback) then
			confirmCallback(value, text1)
		end
		panel:Close()
	end

	local comboBox = vgui.Create("DComboBox", innerPanel)
	comboBox:SetValue(defaultText)
	comboBox:SetTall(SScaleMin(25 / 3))
	comboBox:SetTextInset( SScaleMin(8 / 3), 0 )
	comboBox:SetFont("MenuFontNoClamp")
	comboBox.OnSelect = function()
		panel.button:SetDisabled(false)
		panel.button:SetTextColor(Color(255, 255, 255, 255))
	end

	comboBox.PerformLayout = function(self)
		self.DropButton:SetSize( SScaleMin(15 / 3), SScaleMin(15 / 3))
		self.DropButton:AlignRight( 4 )
		self.DropButton:CenterVertical()

		-- Make sure the text color is updated
		DButton.PerformLayout( self, self:GetWide(), self:GetTall() )
	end

	for _, v in pairs(list) do
		comboBox:AddChoice(v.text, v.value)
	end

	local buttonCancel = vgui.Create("DButton", buttonPanel)
	buttonCancel:SetText(cancelText or "Cancel")
	buttonCancel:SizeToContents()
	buttonCancel:SetTall(SScaleMin(25 / 3))
	buttonCancel:SetFont("MenuFontNoClamp")
	buttonCancel:SetWide(button:GetWide() + SScaleMin(20 / 3))
	buttonCancel:SetPos(SScaleMin(5 / 3), SScaleMin(5 / 3))
	buttonCancel.DoClick = function()
		local text1, value = panel.comboBox:GetSelected()
		if (cancelCallback) then
			cancelCallback(text1, value)
		end
		panel:Close()
	end
	buttonCancel:MoveRightOf(button, SScaleMin(5 / 3))

	buttonPanel:SetWide(button:GetWide() + SScaleMin(5 / 3) + buttonCancel:GetWide() + SScaleMin(10 / 3))

	local w, h = textPanel:GetSize()
	w = math.max(w, SScaleMin(400 / 3))

	panel:SetSize(w + SScaleMin(50 / 3), h + SScaleMin(25 / 3) + SScaleMin(75 / 3) + SScaleMin(10 / 3))
	panel:Center()

	innerPanel:StretchToParent(SScaleMin(5 / 3), SScaleMin(25 / 3), SScaleMin(5 / 3), SScaleMin(45 / 3))

	textPanel:StretchToParent(SScaleMin(5 / 3), SScaleMin(5 / 3), SScaleMin(5 / 3), SScaleMin(35 / 3))

	comboBox:StretchToParent(SScaleMin(5 / 3), nil, SScaleMin(5 / 3), nil)
	comboBox:AlignBottom(5)
	comboBox:RequestFocus()
	comboBox:MoveToFront()

	buttonPanel:CenterHorizontal()
	buttonPanel:AlignBottom(8)

	panel.button = button
	panel.comboBox = comboBox
end
