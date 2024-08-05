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

function PANEL:Init()
	self:SetSize(SScaleMin(1179 / 3), SScaleMin(1116 / 3))
	self:MakePopup()
	self:Center()

	Schema:AllowMessage(self)

	self.content = self:Add("DScrollPanel")
	self.content:SetSize(SScaleMin(800 / 3), SScaleMin(740 / 3))
	self.content:Center()

	self.contentPanels = {}

	local topPanel = self.content:Add("Panel")
	topPanel:Dock(TOP)
	topPanel:SetTall(SScaleMin(32 / 3))
	topPanel.Paint = function(this, w, h)
		self:DrawBottomLine(w, h)
	end

	local title = topPanel:Add("DLabel")
	title:Dock(LEFT)
	title:SetText("GENERIC TRANSACTION LOG")
	title:SetFont("LargerTitlesFontNoClamp")
	title:SizeToContents()

	local exit = topPanel:Add("DButton")
	exit:Dock(RIGHT)
	exit:SetWide(SScaleMin(24 / 3))
	exit:DockMargin(0, SScaleMin(4 / 3), 0, SScaleMin(4 / 3))
	exit:SetText("")
	exit.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/tabmenu/navicons/exit.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	exit.DoClick = function()
		self:Remove()
	end
end

function PANEL:DrawBottomLine(w, h)
	surface.SetDrawColor(color_white)
	surface.DrawLine(0, h - 1, w, h - 1)
end

function PANEL:CreateContentPanel(height, bShouldCreateBottomLine)
	local contentPanel = self.content:Add("Panel")
	contentPanel:Dock(TOP)
	contentPanel:SetTall(height)

	if bShouldCreateBottomLine then
		contentPanel.Paint = function(this, w, h)
		   self:DrawBottomLine(w, h)
		end
	end

	self.contentPanels[#self.contentPanels + 1] = contentPanel

	return contentPanel
end

function PANEL:CreateContent(data, bShowReadButton)
	if (data and !table.IsEmpty(data)) then
		for _, tData in pairs(data) do
			local transPanel = self:CreateContentPanel(SScaleMin(140 / 3), true)

			-- LEFT SIDE
			local leftPanel = transPanel:Add("Panel")
			transPanel.leftPanel = leftPanel
			leftPanel:SetTall(transPanel:GetTall())
			leftPanel:Dock(LEFT)
			leftPanel.Paint = function(this, w, h)
				surface.SetDrawColor(color_white)
				surface.DrawLine(w, 1, w, h - 1)
			end

			leftPanel.datePanel = self:CreateText(leftPanel, os.date("%d/%m/%y", tData.datetime), TOP, 4)
			leftPanel.datePanel:SetTall(SScaleMin(50 / 3))
			leftPanel.timePanel = self:CreateText(leftPanel, os.date("%H:%M:%S", tData.datetime), TOP, 4)

			if (bShowReadButton) then
				leftPanel.readUnRead = leftPanel:Add("DButton")
				leftPanel.readUnRead:Dock(FILL)
				leftPanel.readUnRead:SetText(tonumber(tData.read) == 1 and "READ" or "UNREAD")
				leftPanel.readUnRead:SetFont("TitlesFontNoClamp")
				leftPanel.readUnRead:SizeToContents()
				leftPanel.readUnRead:SetContentAlignment(4)
				leftPanel.readUnRead.Paint = nil
				leftPanel.readUnRead.DoClick = function()
					if (tData.read == 1) then
						tData.read = 0
					else
						tData.read = 1
					end
					leftPanel.readUnRead:SetText(tonumber(tData.read) == 1 and "READ" or "UNREAD")
					netstream.Start("ixTransactionSetRead", tData.id, false, tData.read == 1, tData.pos)
				end
			end
			leftPanel:SetWidth(SScaleMin(90 / 3))

			-- RIGHT SIDE
			local rightPanel = transPanel:Add("Panel")
			transPanel.rightPanel = rightPanel
			rightPanel:Dock(FILL)
			-- INFO ROW
			rightPanel.transInfoPanel = rightPanel:Add("Panel")
			rightPanel.transInfoPanel:Dock(TOP)
			rightPanel.transInfoPanel:SetTall(SScaleMin(50 / 3))
			self:CreateText(rightPanel.transInfoPanel, tData.sender_name.." | CID: "..tData.sender_cid, LEFT, 4, Color(171, 27, 27, 255))
			self:CreateText(rightPanel.transInfoPanel, "➔", FILL, 5, Color(169, 171, 27, 255))
			self:CreateText(rightPanel.transInfoPanel, tData.receiver_name.." | CID: "..tData.receiver_cid, RIGHT, 6, Color(63, 171, 27, 255))
			-- AMOUNT ROW
			rightPanel.descPanel = rightPanel:Add("Panel")
			rightPanel.descPanel:Dock(TOP)
			rightPanel.descPanel.amountLabel = self:CreateText(rightPanel.descPanel, "AMOUNT: "..tData.amount.." ", RIGHT, 6, Color(169, 171, 27, 255))
			rightPanel.descPanel.amountLabel:DockMargin(0, 0, 0, SScaleMin(5 / 3))
			rightPanel.descPanel.reasonLabel = self:CreateText(rightPanel.descPanel, "REASON: ", LEFT, 5, Color(169, 171, 27, 255))
			rightPanel.descPanel.reasonLabel:DockMargin(0, 0, 0, SScaleMin(5 / 3))
			rightPanel.descPanel:SetTall(rightPanel.descPanel.amountLabel:GetTall())

			rightPanel.reasonPanel = rightPanel:Add("Panel")
			rightPanel.reasonPanel:Dock(TOP)
			rightPanel.reasonPanel:SetTall(SScaleMin(50 / 3))
			rightPanel.reasonPanel:DockMargin(0, SScaleMin(10 / 3), 0, 0)
			rightPanel.reasonPanel.reasonTextEntry = rightPanel.reasonPanel:Add("DTextEntry")
			rightPanel.reasonPanel.reasonTextEntry:Dock(FILL)
			rightPanel.reasonPanel.reasonTextEntry:SetText(tData.reason)
			rightPanel.reasonPanel.reasonTextEntry:SetEditable(true)
			rightPanel.reasonPanel.reasonTextEntry:SetVerticalScrollbarEnabled(true)
			rightPanel.reasonPanel.reasonTextEntry:SetMultiline(true)
			rightPanel.reasonPanel.reasonTextEntry:SetFont("MenuFontNoClamp")
			rightPanel.reasonPanel.reasonTextEntry:SetTextColor( color_white )
			rightPanel.reasonPanel.reasonTextEntry:SetCursorColor( color_white )
			rightPanel.reasonPanel.reasonTextEntry.Paint = function(this, w, h)
				surface.SetDrawColor(20, 20, 20, 75)
				surface.DrawRect(0, 0, w, h)

				this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
			end

			-- Because scrollbar won't be useable unless textentry is editable thanks derma
			local coverForTextEntry = rightPanel.reasonPanel:Add("Panel")
			coverForTextEntry:Dock(FILL)
			coverForTextEntry:DockMargin(0, 0, 19, 0)
		end
	end
end

function PANEL:CreateText(parent, text, dock, contentAlignment, color)
	local label = parent:Add("DLabel")
	label:Dock(dock)
	label:SetText(text or "")
	label:SetFont("TitlesFontNoClamp")
	label:SetTextColor(color or color_white)
	label:SetContentAlignment(contentAlignment)
	label:SizeToContents()

	return label
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(color_white)
	surface.SetMaterial(Material("willardnetworks/posterminal.png"))
	surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("ixCIDTransactionLog", PANEL, "EditablePanel")
