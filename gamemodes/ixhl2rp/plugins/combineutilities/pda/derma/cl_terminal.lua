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
	netstream.Start("SyncStoredNewspapers")

	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self.Paint = function(this, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 150))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( this, 1 )
	end

	ix.gui.terminalPanel = self
	self.panel = self:Add("EditablePanel")
	self.panel:SetSize(0, SScaleMin(2 / 3))
	self.width, self.height = SScaleMin(700 / 3) + 3, SScaleMin(438 / 3) + 3
	self.panel:SizeTo(self.width, SScaleMin(2 / 3), 0.5, 0) -- Line to width
	timer.Simple(0.5, function()
		self.panel:SizeTo(self.width, self.height, 0.5, 0) -- Line to height
	end)
	self.panel:SetPos(ScrW() * 0.5 - self.width * 0.5, ScrH() * 0.5 - self.height * 0.5)

	self.panel:MakePopup()
	self.panel.Paint = function(this, w, h)
		surface.SetDrawColor(Color(16, 16, 16, 220))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(150, 150, 150, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.panel)

	local loadingVideoPanel = self.panel:Add("EditablePanel")
	loadingVideoPanel:SetSize(self.width - 2, self.height - 2)
	loadingVideoPanel:SetPos(1, 1)

	-- Preload loading video
	local loadingVideo = loadingVideoPanel:Add("DHTML")
	loadingVideo:Dock(FILL)
	loadingVideo:OpenURL("https://willard.network/hl2rp_imgs/fruityterminal/index.html") -- Loading video url
	loadingVideo:SetVisible(false)

	local cover = loadingVideoPanel:Add("EditablePanel")
	cover:Dock(FILL)

	local exit = cover:Add("DImageButton")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:SetPos(SScaleMin(5 / 3), SScaleMin(5 / 3))
	exit:SetImage("willardnetworks/tabmenu/navicons/exit-grey.png")
	exit.DoClick = function()
		netstream.Start("ClosePanelsTerminal", LocalPlayer().activeTerminal)
		LocalPlayer().activeTerminal = nil
		LocalPlayer().genericData = nil
		LocalPlayer().activeCID = nil
		LocalPlayer().messageList = nil
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local cid = cover:Add("DLabel")
	local cidText = LocalPlayer().activeCID or "00000"
	cid:SetFont("MenuFontNoClamp")
	cid:SetTextColor(Color(89, 115, 105, 255))
	cid:SetText("##"..cidText)
	cid:SizeToContents()
	cid:SetAlpha(0)
	cid:AlphaTo(255, 1, 2)
	cid:SetPos(SScaleMin(44 / 3), SScaleMin(61 / 3))

	self.activeCID = LocalPlayer().activeCID

	self.fullSizeSeconds = 1

	timer.Simple(self.fullSizeSeconds, function()
		if loadingVideo then
			loadingVideo:SetVisible(true)
		end

		if IsValid(self) then
			self:CreateTerminalPanel()
		end
	end)
end

function PANEL:CreateTerminalPanel()
	if self.mainPanel then
		self.mainPanel:Remove()
	end

	self.mainPanel = self.panel:Add("EditablePanel")
	self.mainPanel:Dock(FILL)
	self.mainPanel:DockMargin(SScaleMin(132 / 3), SScaleMin(60 / 3), SScaleMin(124 / 3), 0)
	self.mainPanel:SetAlpha(0)
	self.mainPanel:AlphaTo(255, 1, 1)

	self:CreateMainButtons()
end

local function CreateButton(parent, text)
	parent:Dock(TOP)
	parent:SetSize(SScaleMin(150 / 3), SScaleMin(50 / 3))
	parent:SetText(string.utf8upper(text))
	parent:SetFont("MenuFontNoClamp")
	parent:SetContentAlignment(5)
	parent:DockMargin(0, 0, 0, -1)

	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end
end

function PANEL:CreateMainButtons()
	local genericData = LocalPlayer().genericData
	LocalPlayer().genericData.socialCredits = !LocalPlayer().genericData.combine and math.Clamp(tonumber(LocalPlayer().genericData.socialCredits), 0, 200) or tonumber(LocalPlayer().genericData.socialCredits)
	local name = self.mainPanel:Add("DLabel")
	name:SetFont("EvenLargerTitlesFontNoClamp")
	name:Dock(TOP)
	name:SetText(genericData.name or "NIEPRAWIDŁOWE IMIĘ")
	name:SetContentAlignment(5)
	name:SizeToContents()
	name:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))

	local content = self.mainPanel:Add("EditablePanel")
	content:Dock(FILL)

	self.leftSide = content:Add("EditablePanel")
	self.leftSide:Dock(LEFT)
	self.leftSide:SetWide((self.width - SScaleMin(132 / 3) - SScaleMin(124 / 3)) * 0.5)

	self.rightSide = content:Add("EditablePanel")
	self.rightSide:Dock(FILL)

	local viewGenericData = self.leftSide:Add("DButton")
	CreateButton(viewGenericData, "dane")
	viewGenericData.DoClick = function()
		self:RemoveButtons()
		self:CreateBackPanel()
		self:CreateGenericData()
		surface.PlaySound("helix/ui/press.wav")
	end

	local communion = self.rightSide:Add("DButton")
	CreateButton(communion, "pismo do CAB")
	local canClickCommunion = true
	local clickCount = 0
	communion.DoClick = function()
		if canClickCommunion then
			if LocalPlayer().genericData.socialCredits < ix.config.Get("communionSCRequirement", 150) and !LocalPlayer().genericData.bypassCommunion then
				LocalPlayer().activeTerminal:EmitSound("buttons/combine_button_locked.wav")
				canClickCommunion = false
				clickCount = clickCount + 1

				if clickCount >= 15 then
					local genericName = genericData.name
					local cid = LocalPlayer().activeCID or "00000"
					netstream.Start("BreakAttemptSpottedTerminal", genericName, cid, LocalPlayer().activeTerminal)
				end

				timer.Simple(0.5, function()
					canClickCommunion = true
				end)

				return
			end

			surface.PlaySound("helix/ui/press.wav")

			self:RemoveButtons()
			self:CreateBackPanel()
			self:CreateCommunion()
		end
	end

	local credits = self.leftSide:Add("DButton")
	CreateButton(credits, "kredyty")
	credits.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateBackPanel()
		self:CreateCredits()
	end

	local newspapers = self.rightSide:Add("DButton")
	CreateButton(newspapers, "gazety")
	newspapers.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateBackPanel()
		self:CreateNewspapers()
	end

	local housing = self.leftSide:Add("DButton")
	CreateButton(housing, "mieszkania")
	housing.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateBackPanel()
		self:CreateHousing(false)
	end

	if LocalPlayer().genericData.shop then
		local shop = self.rightSide:Add("DButton")
		CreateButton(shop, "shop")
		shop.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			self:RemoveButtons()
			self:CreateBackPanel()
			self:CreateHousing(true)
		end
	end

	local reportCrime = vgui.Create("DButton", LocalPlayer().genericData.shop and self.leftSide or self.rightSide)
	CreateButton(reportCrime, "wezwij CP")
	reportCrime.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateBackPanel()
		self:CreateCrimeReport()
	end


	local sendLetter = vgui.Create("DButton", LocalPlayer().genericData.shop and self.rightSide or self.leftSide)
	CreateButton(sendLetter, "wiadomości")
	sendLetter.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateBackPanel()
		self:CreateLetterSending()
	end
end

function PANEL:CreateCommunion()
	local genericData = LocalPlayer().genericData
	local send = self.mainPanel:Add("DButton")
	CreateButton(send, "wyślij wiadomość")
	send.DoClick = function()
		self:RemoveButtons()
		self:CreateBackPanel()

		if (self.back) then
			self.back.DoClick = function()
				self:RemoveButtons()
				self:CreateBackPanel()
				self:CreateCommunion()
			end
		end

		self.communionPanel = self.mainPanel:Add("EditablePanel")
		self.communionPanel:MakePopup()
		local x, y = self.panel:GetPos()
		self.communionPanel:SetPos(x + SScaleMin(132 / 3), y + SScaleMin(23 / 3) + SScaleMin(60 / 3))
		self.communionPanel:SetSize(self.width - SScaleMin(256 / 3), SScaleMin(250 / 3) - SScaleMin(23 / 3))

		local textEntry = self.communionPanel:Add("DTextEntry")
		textEntry:Dock(TOP)
		textEntry:SetTall(self.communionPanel:GetTall() - SScaleMin(23 / 3))
		textEntry:SetMultiline( true )
		textEntry:SetVerticalScrollbarEnabled( true )
		textEntry:SetEnterAllowed( true )
		textEntry:SetFont("MenuFontNoClamp")
		textEntry:SetTextColor(Color(200, 200, 200, 255))
		textEntry:SetCursorColor(Color(200, 200, 200, 255))
		textEntry.Paint = function(this, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
			surface.DrawOutlinedRect(0, 0, w, h)

			this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
		end

		local sendCommunion = self.communionPanel:Add("DButton")
		sendCommunion:Dock(FILL)
		sendCommunion:SetText("WYŚLIJ")
		sendCommunion:SetFont("MenuFontNoClamp")
		sendCommunion:SetContentAlignment(6)
		sendCommunion:SetTextInset(SScaleMin(5 / 3), 0)
		sendCommunion.Paint = function(this, w, h)
			surface.SetDrawColor(Color(150, 150, 150, 150))
			surface.DrawLine(0, 1, w, 1)
		end

		sendCommunion.DoClick = function()
			if LocalPlayer().messageList then
				if istable(LocalPlayer().messageList) then
					local timestamp = os.date( "%d.%m.%Y" )
					local newMessage = {
						["message_cid"] = LocalPlayer().activeCID,
						["message_date"] = timestamp,
						["message_poster"] = genericData.name,
						["message_text"] = textEntry:GetText()
					}

					table.insert(LocalPlayer().messageList, newMessage)
				end
			end

			netstream.Start("AddCAMessage", genericData.name, LocalPlayer().activeCID, textEntry:GetText(), LocalPlayer().activeTerminal)
			self.back.DoClick()
		end
	end

	self.view = self.mainPanel:Add("DButton")
	CreateButton(self.view, "wyświetl wiadomości")
	self.view.DoClick = function()
		self:RemoveButtons()
		self:CreateBackPanel()
		surface.PlaySound("helix/ui/press.wav")

		if (self.back) then
			self.back.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")
				self:RemoveButtons()
				self:CreateBackPanel()
				self:CreateCommunion()
			end
		end

		local messagePanel = self.mainPanel:Add("DScrollPanel")
		messagePanel:Dock(TOP)
		messagePanel:DockMargin(0, SScaleMin(2 / 3), 0, 0)
		messagePanel:SetTall(SScaleMin(250 / 3) - SScaleMin(25 / 3))

		if istable(LocalPlayer().messageList) then
			for _, v in pairs(LocalPlayer().messageList) do
				local message = messagePanel:Add("DButton")
				CreateButton(message, v["message_date"].." | "..string.utf8sub(v["message_text"], 1, 20).."..")
				if v["message_reply"] then
					message:SetTextColor(Color(210, 255, 255, 255))
				else
					message:SetTextColor(Color(255, 205, 205, 255))
				end

				message:SetContentAlignment(4)
				message:SetTextInset(SScaleMin(5 / 3), 0)

				message.DoClick = function()
					self:RemoveButtons()
					self:CreateBackPanel()
					surface.PlaySound("helix/ui/press.wav")

					if (self.back) then
						self.back.DoClick = function()
							self:RemoveButtons()
							self:CreateBackPanel()
							self:CreateCommunion()
							if (self.view) then
								self.view.DoClick()
							end
						end
					end

					local textEntry = self.mainPanel:Add("DTextEntry")
					textEntry:Dock(TOP)
					textEntry:DockMargin(0, SScaleMin(2 / 3), 0, 0)
					textEntry:SetTall(SScaleMin(250 / 3) - SScaleMin(25 / 3) - SScaleMin(23 / 3))
					textEntry:SetTextColor(Color(200, 200, 200, 255))
					textEntry:SetMultiline( true )
					textEntry:SetFont("MenuFontNoClamp")
					textEntry:SetVerticalScrollbarEnabled( true )
					textEntry:SetCursorColor(Color(200, 200, 200, 255))
					textEntry:SetValue(v["message_text"])
					textEntry.Paint = function(this, w, h)
						surface.SetDrawColor(Color(0, 0, 0, 100))
						surface.DrawRect(0, 0, w, h)

						surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
						surface.DrawOutlinedRect(0, 0, w, h)

						this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
					end

					local viewReply = self.mainPanel:Add("DButton")
					viewReply:Dock(TOP)
					viewReply:SetTall(SScaleMin(23 / 3))
					viewReply:SetText("WYŚWIETL ODPOWIEDŹ")
					viewReply:SetFont("MenuFontNoClamp")
					viewReply:SetContentAlignment(6)
					viewReply:SetTextInset(SScaleMin(5 / 3), 0)

					viewReply.Paint = function(this, w, h)
						surface.SetDrawColor(Color(150, 150, 150, 150))
						surface.DrawLine(0, 1, w, 1)
					end

					viewReply.DoClick = function()
						if !v["message_reply"] then
							viewReply:SetText("BRAK ODPOWIEDZI")
							return
						end

						surface.PlaySound("helix/ui/press.wav")

						viewReply.DoClick = function() end
						viewReply:SetText("")

						textEntry:SetValue(v["message_reply"])
					end
				end
			end
		end
	end
end

function PANEL:Think()
	if IsValid(self.communionPanel) then
		self.communionPanel:MoveToFront()
	end

	if !self.scroller or !IsValid(self.scroller) then
		if !timer.Exists("PlayRandomScrollingSounds") then return end
		timer.Remove("PlayRandomScrollingSounds")
	end
end

function PANEL:CreateCredits()
	local creditsPanel = self.mainPanel:Add("EditablePanel")
	creditsPanel:SetPos(0, SScaleMin(23 / 3))
	creditsPanel:SetSize(self.width - SScaleMin(256 / 3), SScaleMin(250 / 3) - SScaleMin(23 / 3))

	local credits = creditsPanel:Add("DLabel")
	credits:SetFont("CharCreationBoldTitleNoClamp")
	credits:SetText(LocalPlayer().idCardCredits.." Kredytów") -- Change this to credits when that is on the CID
	credits:SetContentAlignment(5)
	credits:SizeToContents()
	credits:Center()

	local send = creditsPanel:Add("DButton")
	CreateButton(send, "wyślij kredyty")
	send:Dock(BOTTOM)
	send.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateBackPanel()
		self:CreateTransaction()
	end
end

function PANEL:CreateTransaction()
	local cid, amount

	local cidRow = self.mainPanel:Add("EditablePanel")
	cidRow:Dock(TOP)
	cidRow:SetTall(SScaleMin(38 / 3))
	cidRow:DockMargin(0, SScaleMin(5 / 3), SScaleMin(5 / 3), SScaleMin(10 / 3))
	cidRow.Paint = function(this, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 150))
		surface.DrawLine(0, h - 1, w, h - 1)
	end

	local cidLabel = cidRow:Add("DLabel")
	cidLabel:SetContentAlignment(5)
	cidLabel:SetFont("MenuFontBoldNoClamp")
	cidLabel:Dock(LEFT)
	cidLabel:DockMargin(SScaleMin(5 / 3), 0, 0, 0)
	cidLabel:SetText("CID: #")
	cidLabel:SizeToContents()

	local cidEnter = cidRow:Add("DButton")
	CreateButton(cidEnter, "wprowadź cid")
	cidEnter:Dock(RIGHT)
	cidEnter.DoClick = function()
		Derma_StringRequest("Wprowadź CID", "Wprowadź CID odbiorcy.", "", function(text)
			cidLabel:SetText("CID: #"..text)
			cidLabel:SizeToContents()

			cid = text

			if (cid and amount) then
				self.send:SetDisabled(false)
			end
		end)
	end

	local amountRow = self.mainPanel:Add("EditablePanel")
	amountRow:Dock(TOP)
	amountRow:SetTall(SScaleMin(38 / 3))
	amountRow:DockMargin(0, SScaleMin(5 / 3), SScaleMin(5 / 3), SScaleMin(10 / 3))
	amountRow.Paint = function(this, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 150))
		surface.DrawLine(0, h - 1, w, h - 1)
	end

	local amountLabel = amountRow:Add("DLabel")
	amountLabel:SetContentAlignment(5)
	amountLabel:SetFont("MenuFontBoldNoClamp")
	amountLabel:Dock(LEFT)
	amountLabel:DockMargin(SScaleMin(5 / 3), 0, 0, 0)
	amountLabel:SetText("0 Kredytów")
	amountLabel:SizeToContents()

	local amountEnter = amountRow:Add("DButton")
	CreateButton(amountEnter, "wprowadź ilość")
	amountEnter:Dock(RIGHT)
	amountEnter.DoClick = function()
		Derma_StringRequest("Wprowadź ilość", "Wprowadź liczbę kredytów do wysłania.", "", function(text)
			local enterAmount = tonumber(text)

      if (enterAmount and enterAmount > 0) then
				local money = LocalPlayer().idCardCredits

				if (enterAmount > money) then
					enterAmount = money
				end

				amountLabel:SetText(enterAmount.." Kredytów")
				amountLabel:SizeToContents()
				amount = enterAmount

				if (cid and amount) then
					self.send:SetDisabled(false)
				end
			end
		end)
	end

	self.send = self.mainPanel:Add("DButton")
	CreateButton(self.send, "wyślij")
	self.send:Dock(TOP)
	self.send.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateCredits()

		netstream.Start("ixSendCredits", LocalPlayer().idCardId, cid, amount, LocalPlayer().activeCID)
	end

	self.send:SetDisabled(true)
end

function PANEL:CreateBackPanel()
	self.back = self.mainPanel:Add("DButton")
	self.back:SetContentAlignment(4)
	self.back:SetFont("MenuFontNoClamp")
	self.back:Dock(TOP)
	self.back:SetTall(SScaleMin(20 / 3))
	self.back:DockMargin(0, 0, 0, 0 - SScaleMin(2 / 3))
	self.back:SetText("POWRÓT")
	self.back.Paint = function(this, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 150))
		surface.DrawLine(0, h - 1, w, h - 1)
	end

	self.back:SetTextInset(SScaleMin( 5 / 3 ), 0)
	self.back.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateMainButtons()
	end
end

function PANEL:CreateGenericData()
	local genericData = LocalPlayer().genericData
	local data = {
        ["Imię"] = genericData.name,
        ["Kredyty społeczne"] = genericData.socialCredits,
        ["Opis genetyczny"] = genericData.geneticDesc,
        ["Zawód"] = genericData.occupation,
        ["Status"] = genericData.designatedStatus,
        --["Business Permit"] = genericData.permits
    }

    if (LocalPlayer():IsVortigaunt()) then
        data["Kredyty społeczne"] = nil

        if (genericData.cohesionPoints) then
            data["Punkty kohezji"] = !genericData.combine and math.Clamp(tonumber(genericData.cohesionPoints), 0, 200) or tonumber(genericData.cohesionPoints)
        else
            data["Punkty kohezji"] = !genericData.combine and math.Clamp(tonumber(genericData.socialCredits), 0, 200) or tonumber(genericData.socialCredits)
        end
    else
        data["Kredyty społeczne"] = !genericData.combine and math.Clamp(tonumber(genericData.socialCredits), 0, 200) or tonumber(genericData.socialCredits)
    end
	for title, text in SortedPairs(data) do
		local row = self.mainPanel:Add("EditablePanel")
		row:Dock(TOP)
		row:SetTall(SScaleMin(38 / 3))
		row.Paint = function(this, w, h)
			surface.SetDrawColor(Color(150, 150, 150, 150))
			surface.DrawLine(0, h - 1, w, h - 1)
		end

		local textRow = row:Add("DLabel")
		textRow:SetContentAlignment(5)
		textRow:SetFont("MenuFontNoClamp")
		textRow:Dock(RIGHT)
		textRow:DockMargin(0, 0, SScaleMin(5 / 3), 0)
		if isbool(text) then
			if text then
				textRow:SetText("TAK")
			else
				textRow:SetText("NIE")
			end
		else
			textRow:SetText(string.len(text) > 42 and string.Left(text, 42).."..." or text)
		end
		textRow:SizeToContents()

		local titleRow = row:Add("DLabel")
		titleRow:SetContentAlignment(5)
		titleRow:SetFont("MenuFontBoldNoClamp")
		titleRow:Dock(LEFT)
		titleRow:DockMargin(SScaleMin(5 / 3), 0, 0, 0)
		titleRow:SetText(title..":")
		titleRow:SizeToContents()
	end
end

function PANEL:CreateNewspapers()
	self.newspaperPanel = self.mainPanel:Add("DScrollPanel")
	self.newspaperPanel:SetPos(0, SScaleMin(23 / 3))
	self.newspaperPanel:SetSize(self.width - SScaleMin(256 / 3), SScaleMin(250 / 3) - SScaleMin(23 / 3))

	netstream.Start("ixWritingGetUnionNewspapers", true)
end

function PANEL:CreateStoredNewspapers(newspapers)
	local padding = SScaleMin(20 / 3)
	local canRead = LocalPlayer():GetCharacter():GetCanread()
	for _, data1 in SortedPairs(newspapers, true) do
		local data = util.JSONToTable(data1["unionnewspaper_data"])
		local writingID = data.unionDatabase
		local entryPanel = self.newspaperPanel:Add("EditablePanel")
		entryPanel:Dock(TOP)
		entryPanel:SetTall(SScaleMin(50 / 3))
		entryPanel.Paint = function(_, w, h)
			surface.SetDrawColor(Color(150, 150, 150, 255))
			surface.DrawLine(0, h - 1, w, h - 1)
		end

		local top = entryPanel:Add("EditablePanel")
		top:Dock(TOP)
		top:SetTall(SScaleMin(50 / 3) / 2)

		local title = top:Add("DLabel")
		title:Dock(LEFT)
		title:SetFont("MenuFontLargerBoldNoFix")
		title:SetText(canRead and data.bigHeadline or Schema:ShuffleText(data.bigHeadline))
		title:SetTextColor(color_white)
		title:SizeToContents()
		title:DockMargin(padding, SScaleMin(2 / 3), 0, 0)

		local bottom = entryPanel:Add("EditablePanel")
		bottom:Dock(FILL)

		local subtitle = bottom:Add("DLabel")
		subtitle:Dock(LEFT)
		subtitle:SetFont("MenuFontLargerNoClamp")
		subtitle:SetText(canRead and data.subHeadline or Schema:ShuffleText(data.subHeadline))
		subtitle:SizeToContents()
		subtitle:SetContentAlignment(4)
		subtitle:DockMargin(padding, 0, 0, SScaleMin(7 / 3))

		local viewNewspaper = bottom:Add("DButton")
		viewNewspaper:Dock(RIGHT)
		viewNewspaper:SetFont("MenuFontLargerNoClamp")
		viewNewspaper:SetText("WYŚWIETL")
		viewNewspaper:SizeToContents()
		viewNewspaper:SetContentAlignment(6)
		viewNewspaper:DockMargin(0, 0, padding, SScaleMin(7 / 3))
		viewNewspaper.Paint = nil
		viewNewspaper.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			netstream.Start("ixWritingGetUnionWritingData", writingID)
		end
	end
end

function PANEL:CreateHousing(bShop)
	if self.housingPanel and IsValid(self.housingPanel) then
		self.housingPanel:Remove()
	end

	self.housingPanel = self.mainPanel:Add("EditablePanel")
	self.housingPanel:SetPos(0, SScaleMin(20 / 3))
	self.housingPanel:SetSize(self.width - SScaleMin(256 / 3), SScaleMin(250 / 3) - SScaleMin(20 / 3))

	if !bShop then
		if !LocalPlayer().genericData.housing then
			self:CreateHousingRequestButtons()
			return
		end
	end

	netstream.Start("RequestAssignedApartmentInfo", LocalPlayer().activeCID, bShop)
end

function PANEL:RevertBackToHousing()
	if (self.back) then
		self.back.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			self:ClearHousing()
			self:CreateHousingInfo(self.appTable, self.appID, self.bShop)

			self.back.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")
				self:RemoveButtons()
				self:CreateMainButtons()
			end
		end
	end
end

function PANEL:CreateHousingInfo(appTable, appID, bShop)
	self.appTable = appTable
	self.appID = appID
	self.bShop = bShop
	local appName = self.housingPanel:Add("DLabel")
	appName:Dock(TOP)
	appName:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))
	if (appTable.name) then
		local name = string.len(appTable.name) > 27 and (string.Left(appTable.name, 25).."...") or appTable.name
		local appType = appTable.type and (" | "..string.upper(appTable.type)) or ""
		appName:SetText(name..appType)
	else
		appName:SetText("NIENAZWANY")
	end
	appName:SetFont("TitlesFontNoClamp")
	appName:SetContentAlignment(5)
	appName:SizeToContents()

	local infoTable = self.housingPanel:Add("EditablePanel")
	infoTable:Dock(FILL)
	infoTable.Paint = function(_, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 255))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.DrawLine(self.housingPanel:GetWide() * 0.5 - 1, 0, self.housingPanel:GetWide() * 0.5 - 1, h)
	end

	local leftSide = infoTable:Add("EditablePanel")
	leftSide:Dock(LEFT)
	leftSide:SetWide(self.housingPanel:GetWide() * 0.5)

	local housing = ix.plugin.list["housing"]
	local remainingRent = (housing and housing:GetRemainingRent(appTable) or appTable.rent)

	self:CreateHousingLeftSidePart(leftSide, "CAŁKOWITY CZYNSZ", tostring(appTable.rent) or "0")
	self:CreateHousingLeftSidePart(leftSide, "CZYNSZ INDYWIDUALNY", appTable.rent and table.Count(appTable.tenants) > 1 and tostring(math.ceil(appTable.rent / table.Count(appTable.tenants))) or tostring(appTable.rent))
	self:CreateHousingLeftSidePart(leftSide, "CZYNSZ NALEŻNY DO", os.date("%d/%m/%Y", appTable.rentDue) or "N/A")
	self:CreateHousingLeftSidePart(leftSide, "POZOSTAŁY CZYNSZ", remainingRent)

	local rightSide = infoTable:Add("EditablePanel")
	rightSide:Dock(FILL)

	local rightSideButtonAmount = 3
	local bHeight = (leftSide:GetChildren()[1]:GetTall() * #leftSide:GetChildren()) / rightSideButtonAmount
	local tenants = rightSide:Add("DButton")
	CreateButton(tenants, "NAJEMCY")
	tenants:SetTall(bHeight)
	tenants.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:ClearHousing()
		self:RevertBackToHousing()

		for itemCID, tTenant in pairs(self.appTable.tenants) do
			local appPayments = self.appTable.payments[itemCID] or false
			local tenantPanel = self:CreateHousingLeftSidePart(self.housingPanel, "CID: "..itemCID, " | ID klucza: "..((!tTenant.key or tTenant.key == true) and "N/A" or tTenant.key), true)
			local lastPayment = tenantPanel:Add("DLabel")
			lastPayment:SetContentAlignment(6)
			lastPayment:SetText("OSTATNIA WPŁATA: "..(appPayments and (appPayments.date and os.date( "%d/%m/%Y" , appPayments.date )) or "NIGDY"))
			lastPayment:SetFont("MenuFontBoldNoClamp")
			lastPayment:SizeToContents()
			lastPayment:Dock(RIGHT)
			lastPayment:DockMargin(0, 0, SScaleMin(10 / 3), 0)
		end
	end
	if appTable.tenants[LocalPlayer():GetCharacter():GetGenericdata().cid] then
		local payments = rightSide:Add("DButton")
		CreateButton(payments, "PŁATNOŚCI")
		payments:SetTall(bHeight)
		payments.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			self:CreatePaymentPanel(appTable, appID)
		end
	end
	if bShop then
		local employees = rightSide:Add("DButton")
		CreateButton(employees, "PRACOWNICY")
		employees:SetTall(bHeight)
		employees.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			self:CreateEmployeePanel(appTable, appID)
		end
	end
	if !bShop then
		local request = rightSide:Add("DButton")
		CreateButton(request, "WNIOSKUJ O NOWE MIESZKANIE")
		request:SetTall(bHeight)
		request.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			self:ClearHousing()
			self:RevertBackToHousing()
			self:CreateHousingRequestButtons()
		end
	end
end
local function CreateBottomOrTopTextOrButton(parent, text, bTop)
	local labelText = parent:Add("DButton")
	labelText:SetTextColor(Color(255, 255, 255, 255))
	labelText:SetFont("MenuFontNoClamp")
	labelText:SetText(text)
	labelText:Dock(RIGHT)
	labelText:DockMargin(0, 0, SScaleMin(10 / 3), 0)
	labelText:SizeToContents()
	labelText.Paint = nil

	return labelText
end
local function CreateRow(parent, title, text, date, bSecondInRow, bUpdateable)
	parent:SetSize(parent:GetParent():GetWide(), SScaleMin(64 / 3))
	parent:Dock(TOP)
	parent.Paint = function(this, w, h)
		surface.SetDrawColor(150, 150, 150, 255)
		surface.DrawOutlinedRect(0, 0, w, h,1)
	end

	local top = parent:Add("EditablePanel")
	top:SetSize(parent:GetWide(), parent:GetTall() * 0.5)
	top:Dock(TOP)
	top.Paint = nil

	local topTitle = top:Add("DLabel")
	topTitle:SetTextColor(Color(255, 255, 255, 255))
	topTitle:SetFont("MenuFontNoClamp")
	topTitle:SetText(string.upper(title)..":")
	topTitle:Dock(LEFT)
	topTitle:DockMargin(SScaleMin(20 / 3), SScaleMin(5 / 3), 0, 0)
	topTitle:SizeToContents()

	parent.bottom = parent:Add("EditablePanel")
	parent.bottom:SetSize(parent:GetWide(), parent:GetTall() * 0.45)
	parent.bottom:Dock(TOP)
	parent.bottom.Paint = nil
	parent.bottom:SetName( "bottom" )

	parent.bottom.titleText = parent.bottom:Add("DLabel")
	parent.bottom.titleText:SetTextColor(Color(255, 255, 255, 255))
	parent.bottom.titleText:SetFont("MenuFontNoClamp")
	parent.bottom.titleText:SetText(text)
	parent.bottom.titleText:Dock(LEFT)
	parent.bottom.titleText:DockMargin(SScaleMin(20 / 3), 0, 0, 0)
	parent.bottom.titleText:SizeToContents()

end
function PANEL:CreateEmployeePanel(appTable, appID)
	self:ClearHousing()
	self:RevertBackToHousing()

	self.employeeList = self.housingPanel:Add("DScrollPanel")
	self.employeeList:Dock(TOP)
	self.employeeList:DockMargin(-1, 0, -1, 0)
	self.employeeList:SetHeight(SScaleMin(140 / 3))

	self.counter = 0
	for cid, tEmployee in pairs(appTable.employees) do
		print(cid)
		PrintTable(tEmployee)
		if istable(cid) then cid = tonumber(cid) end
		self.counter = self.counter + 1
		local cidLabelEmployee = self.employeeList:Add("EditablePanel")
		CreateRow(cidLabelEmployee, "cid: | id klucza ", (!cid and "N/A" or cid).." | "..(tEmployee.key == true and "OCZEKUJĄCE ID KLUCZA" or tEmployee.key or "N/A") , false)
		local remove = CreateBottomOrTopTextOrButton(cidLabelEmployee.bottom, "USUŃ", false)
		remove.DoClick = function()
			if !cid or !appTable.tenants[LocalPlayer():GetCharacter():GetGenericdata().cid] then return LocalPlayer():NotifyLocalized("Nie możesz tego zrobić.") end
			cidLabelEmployee:Remove()
			netstream.Start("RemoveEmployee", cid, appID)
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end
	end

	local addEmployee = self.housingPanel:Add("DButton")
	CreateButton(addEmployee, "Dodaj pracownika")
	addEmployee:SetTall(SScaleMin(32 / 3))
	addEmployee.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if !appTable.tenants[LocalPlayer():GetCharacter():GetGenericdata().cid] then return LocalPlayer():NotifyLocalized("Nie możesz tego zrobić.") end
		Derma_StringRequest("Wprowadź CID", "Wprowadź CID osoby którą chcesz dodać do sklepu.", "", function(text)
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
			netstream.Start("AddEmployee", appID, tonumber(text))
		end)
	end
	addEmployee:Dock(BOTTOM)
end
function PANEL:CreatePaymentPanel(appTable, appID)
	local housing = ix.plugin.list["housing"]
	local remainingRent = (housing and housing:GetRemainingRent(appTable) or appTable.rent)

	self:ClearHousing()
	self:RevertBackToHousing()

	local payFull = self.housingPanel:Add("DButton")
	CreateButton(payFull, "ZAPŁAĆ PEŁEN CZYNSZ ( "..appTable.rent.." )")
	if (remainingRent < tonumber(appTable.rent)) then
		payFull:SetTextColor(Color(150, 150, 150, 255))
	else
		payFull.DoClick = function()
			self:PayRent(tonumber(appTable.rent), appID)
		end
	end

	local individualRent = (math.ceil(tonumber(appTable.rent) / table.Count(appTable.tenants)))
	local payIndividual = self.housingPanel:Add("DButton")
	CreateButton(payIndividual, "ZAPŁAĆ ZA SIEBIE ( "..individualRent.." )")
	if (remainingRent < individualRent) then
		payIndividual:SetTextColor(Color(150, 150, 150, 255))
	else
		payIndividual.DoClick = function()
			self:PayRent(individualRent, appID)
		end
	end

	local payRemaining = self.housingPanel:Add("DButton")
	CreateButton(payRemaining, "ZAPŁAĆ SALDO ( "..remainingRent.." )")
	if (remainingRent <= 0) then
		payRemaining:SetTextColor(Color(150, 150, 150, 255))
	else
		payRemaining.DoClick = function()
			self:PayRent(remainingRent, appID)
		end
	end

	local autoPay = self.housingPanel:Add("DButton")
	CreateButton(autoPay, "AUTO-ZAPŁATA CZYNSZU: "..(appTable.tenants[LocalPlayer().activeCID].autoPay and "WŁĄCZONA" or "WYŁĄCZONA"))
	autoPay.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if !appTable.tenants[LocalPlayer().activeCID].autoPay then
			autoPay:SetText("AUTO-ZAPŁATA CZYNSZU: WŁĄCZONA")
			appTable.tenants[LocalPlayer().activeCID].autoPay = true
		else
			autoPay:SetText("AUTO-ZAPŁATA CZYNSZU: WYŁĄCZONA")
			appTable.tenants[LocalPlayer().activeCID].autoPay = false
		end

		netstream.Start("SetTenantAutoPayment", appID, LocalPlayer().activeCID, appTable.tenants[LocalPlayer().activeCID].autoPay)
	end

	for _, v in pairs(self.housingPanel:GetChildren()) do
		v:SetTall(SScaleMin(40 / 3))
	end

	local paymentsMade = self.housingPanel:Add("DScrollPanel")
	paymentsMade:Dock(FILL)
	paymentsMade.Paint = function(_, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	for cid, tPayment in pairs(appTable.payments) do
		local payPart = self:CreateHousingLeftSidePart(paymentsMade, "CID: "..cid, " | ILOŚĆ: "..tPayment.amount or "0", true, 30)
		local paymentDate = payPart:Add("DLabel")
		paymentDate:SetContentAlignment(6)
		paymentDate:SetText("ZAPŁACONO: "..os.date( "%d/%m/%Y", tPayment.date) or os.time())
		paymentDate:SetFont("MenuFontBoldNoClamp")
		paymentDate:SizeToContents()
		paymentDate:Dock(RIGHT)
		paymentDate:DockMargin(0, 0, SScaleMin(10 / 3), 0)
	end
end

function PANEL:PayRent(amount, appID)
	surface.PlaySound("helix/ui/press.wav")
	local cid = self.activeCID
	netstream.Start("PayRent", amount, appID, cid)

	self:RevertBackToNormal()
end

function PANEL:RevertBackToNormal()
	self.back.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateMainButtons()
	end
end

function PANEL:PaymentSuccess(amount)
	LocalPlayer().idCardCredits = LocalPlayer().idCardCredits - amount
end

function PANEL:CreateHousingLeftSidePart(parent, title, text, bNoColon, height)
	local part = parent:Add("EditablePanel")
	part:Dock(TOP)
	part:SetTall(height and SScaleMin(height / 3) or SScaleMin(48 / 3))
	part:DockMargin(0, -1, 0, 0)
	part.Paint = function(this, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local titleHousing = part:Add("DLabel")
	titleHousing:SetFont("MenuFontBoldNoClamp")
	titleHousing:SetText(title..(!bNoColon and ": " or "")..text or "")
	titleHousing:SizeToContents()
	titleHousing:Center()

	local _, y = titleHousing:GetPos()
	titleHousing:SetPos(SScaleMin(10 / 3), y)

	return part
end

function PANEL:ClearHousing()
	for _, v in pairs(self.housingPanel:GetChildren()) do
		v:Remove()
	end
end

function PANEL:CreateHousingRequestButtons()
	self.requestButtons = {}
	self:CreateHousingRequestButton()

	if self:GetShowPButton() then
		self:CreateHousingRequestButton(true)
	end
end

function PANEL:GetShowPButton()
	local housing = ix.plugin.list["housing"]
	if !housing then return end

	local loyaltyStatus = LocalPlayer().genericData.loyaltyStatus
	local tier = tonumber(housing:GetNumbersFromText(loyaltyStatus))
	local tierNeeded = tonumber(housing:GetNumbersFromText(ix.config.Get("priorityHousingTierNeeded", "POZIOM 4 (NIEBIESKI)")))
	if ix.config.Get("priorityHousingTierNeeded", "POZIOM 4 (NIEBIESKI)") == "CZŁONEK CAB" then
		tierNeeded = 7
	end

	if loyaltyStatus == "CZŁONEK CAB" then
		return true
	end

	if (!tier or !isnumber(tier)) then
		return false
	end

	if (isnumber(tier) and tier < tierNeeded) then
		return false
	end

	return true
end

function PANEL:CreateHousingRequestButton(bPriority)
	local genericData = LocalPlayer().genericData
	local request = self.housingPanel:Add("DButton")
	CreateButton(request, genericData.housing and "wnioskuj o nowe"..((self:GetShowPButton() and bPriority) and " priorytetowe" or " normalne").." mieszkanie (35 kredytów)" or "wnioskuj o"..((self:GetShowPButton() and bPriority) and " priorytetowe" or " normalne").." mieszkanie (35 kredytów)")
	request.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if genericData.housing then
			Derma_Query("Czy na pewno chcesz wnioskować o nowe mieszkanie?", ((self:GetShowPButton() and bPriority) and "Priorytetowe " or "Normalne ").."mieszkanie", "Tak", function()
				self:SendHousingRequest(bPriority)
			end, "Nie")
			return
		end

		self:SendHousingRequest(bPriority)
	end

	self.requestButtons[#self.requestButtons + 1] = request
end

function PANEL:SendHousingRequest(bPriority)
	for _, v in pairs(self.requestButtons) do
		v:Remove()
	end

	surface.PlaySound("helix/ui/press.wav")
	netstream.Start("ixApartmentsRequest", LocalPlayer().activeCID, bPriority and "priorytetowy" or "normalny")
end

function PANEL:CreateHousingFail(text)
	local fail = self.housingPanel:Add("DLabel")
	fail:SetText(text or "NIE ZNALEZIONO MIESZKANIA")
	fail:SetFont("TitlesFontNoClamp")
	fail:SizeToContents()
	fail:Center()

	surface.PlaySound("HL1/fvox/buzz.wav")
end

function PANEL:CreateHousingScroller(foundApartment, appNames)
	self.scroller = self.housingPanel:Add("EditablePanel")
	local outliner = self.housingPanel:Add("EditablePanel")
	outliner:SetSize(self.housingPanel:GetWide(), SScaleMin(50 / 3))
	outliner:Center()
	outliner:SetAlpha(0)
	outliner:AlphaTo(255, 1, 0)
	outliner.Paint = function(_, w, h)
		surface.SetDrawColor(ColorAlpha(color_white, 100))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local height = 0
	local extraApps = 10

	for _ = 1, extraApps do
		for _, tApp in pairs(appNames) do
			local appName = self.scroller:Add("DLabel")
			appName:Dock(TOP)
			appName:SetContentAlignment(5)
			appName:SetText(string.upper(tApp.name) or "")
			appName:SetFont("TitlesFontNoClamp")
			appName:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))
			appName:SizeToContents()

			height = height + appName:GetTall() + SScaleMin(20 / 3)
		end
	end

	self.scroller:SetSize(self.housingPanel:GetWide(), height)
	self.scroller:MoveTo(0, -height + (height / extraApps), 3, 0, 1, function()
		self.scroller:AlphaTo(0, 1, 0, function()
			self.scroller:Remove()
			self:CreateFoundHousing(appNames, foundApartment, outliner)
		end)
	end)

	local randomSounds = table.Random({
		"ambient/machines/keyboard_fast1_1second.wav",
		"ambient/machines/keyboard_fast2_1second.wav",
		"ambient/machines/keyboard_fast3_1second.wav"
	})

	surface.PlaySound(randomSounds)

	timer.Create("PlayRandomScrollingSounds", 1, 2, function()
		surface.PlaySound(randomSounds)
	end)

	self:RevertBackToNormal()
end

function PANEL:CreateFoundHousing(appNames, foundApartment, outliner)
	surface.PlaySound("ambient/machines/keyboard7_clicks_enter.wav")

	local found = outliner:Add("DLabel")
	found:SetText("PRZYDZIELONE MIESZKANIE:")
	found:SetFont("TitlesFontNoClamp")
	found:SetContentAlignment(5)
	found:SizeToContents()
	found:Dock(TOP)
	found:DockMargin(0, SScaleMin(10 / 3), 0, 0)
	found:SetAlpha(0)
	found:AlphaTo(255, 1, 0)

	local found3 = outliner:Add("DLabel")
	found3:SetText("KLUCZ JEST W AUTOMACIE ODBIORCZYM")
	found3:SetFont("TitlesFontNoClamp")
	found3:SetContentAlignment(5)
	found3:SizeToContents()
	found3:Dock(BOTTOM)
	found3:DockMargin(0, 0, 0, SScaleMin(10 / 3))
	found3:SetAlpha(0)
	found3:AlphaTo(255, 1, 0)

	local found2 = outliner:Add("DLabel")
	found2:SetText((string.len(appNames[foundApartment].name) < 40 and string.upper(appNames[foundApartment].name) or string.Left(string.upper(appNames[foundApartment].name), 37).."...") or "")
	found2:SetFont("TitlesFontNoClamp")
	found2:SetContentAlignment(5)
	found2:SizeToContents()
	found2:Dock(BOTTOM)
	found2:DockMargin(0, 0, 0, SScaleMin(10 / 3))
	found2:SetAlpha(0)
	found2:AlphaTo(255, 1, 0)

	outliner:SetTall(found:GetTall() + found2:GetTall() + found3:GetTall() + SScaleMin(30 / 3))
	outliner:Center()

	LocalPlayer().genericData.housing = foundApartment
end

function PANEL:CreateCrimeReport()
	if self.crimeReportPanel and IsValid(self.crimeReportPanel) then
		self.crimeReportPanel:Remove()
	end

	self.crimeReportPanel = self.mainPanel:Add("EditablePanel")
	self.crimeReportPanel:SetPos(0, SScaleMin(20 / 3))
	self.crimeReportPanel:SetSize(self.width - SScaleMin(256 / 3), SScaleMin(250 / 3) - SScaleMin(20 / 3))

	local textEntry = self.crimeReportPanel:Add("DTextEntry")
	textEntry:Dock(FILL)
	textEntry:SetMultiline( true )
	textEntry:SetVerticalScrollbarEnabled( true )
	textEntry:SetEnterAllowed( true )
	textEntry:SetFont("MenuFontNoClamp")
	textEntry:SetTextColor(Color(200, 200, 200, 255))
	textEntry:SetCursorColor(Color(200, 200, 200, 255))
    textEntry:SetPlaceholderText("Kto, co, kiedy, gdzie, jak?")
    textEntry:SetPlaceholderColor(Color(200, 200, 200, 255))

    textEntry.Paint = function(this, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
		surface.DrawOutlinedRect(0, 0, w, h)

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

	local submit = self.crimeReportPanel:Add("DButton")
	CreateButton(submit, "wyślij")
	submit:Dock(BOTTOM)
	submit.DoClick = function()
		netstream.Start("TerminalReportCrime", LocalPlayer().genericData.name, LocalPlayer().activeCID, textEntry:GetText(), LocalPlayer().activeTerminal)

		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateMainButtons()
	end
end

function PANEL:CreateLetterSending()
	if self.letterSending and IsValid(self.letterSending) then
		self.letterSending:Remove()
	end

	self.letterSending = self.mainPanel:Add("Panel")
	self.letterSending:SetPos(0, SScaleMin(20 / 3))
	self.letterSending:SetSize(self.width - SScaleMin(256 / 3), SScaleMin(250 / 3) - SScaleMin(20 / 3))
	self.letterSending:DockMargin(0, 0, 0, 0)

	local character = LocalPlayer():GetCharacter()
	if !character then return end

	local inventory = character:GetInventory()
	if !inventory then return end

	local paperItems = inventory:GetItemsByUniqueID("paper")
	if table.IsEmpty(paperItems) then
		local noLetters = self.letterSending:Add("DLabel")
		noLetters:SetFont("MenuFontNoClamp")
		noLetters:SetText("NIE MA DO CIEBIE ŻADNYCH LISTÓW")
		noLetters:SizeToContents()
		noLetters:SetPos(self.letterSending:GetWide() / 2 - noLetters:GetWide() / 2, self.letterSending:GetTall() / 2 - noLetters:GetTall() / 2)
		return
	end

	local letterScroll = self.letterSending:Add("DScrollPanel")
	letterScroll:SetSize(self.width - SScaleMin(256 / 3), SScaleMin(250 / 3) - SScaleMin(20 / 3))
	self.letterButtons = {}

	for _, v in pairs(paperItems) do
		local paperItem = letterScroll:Add("DButton")
		CreateButton(paperItem, v:GetName())

		paperItem.DoClick = function()
			Derma_StringRequest("Wprowadź imię lub CID", "Do wysłania wiadomości potrzebne jest imię lub CID odbiorcy.", "", function(text)
				text = text:Trim()

				surface.PlaySound("helix/ui/press.wav")
				netstream.Start("FindLetterRecepient", text, v:GetID())

				for _, v2 in pairs(self.letterButtons) do
					v2:SetVisible(false)
				end

				self.searchingRecepient = self.letterSending:Add("DLabel")
				self.searchingRecepient:SetFont("MenuFontNoClamp")
				self.searchingRecepient:SetText("Wyszukiwanie odbiorcy, proszę czekać...")
				self.searchingRecepient:SizeToContents()
				self.searchingRecepient:SetPos(self.letterSending:GetWide() / 2 - self.searchingRecepient:GetWide() / 2, self.letterSending:GetTall() / 2 - self.searchingRecepient:GetTall() / 2)
			end)
		end

		self.letterButtons[#self.letterButtons + 1] = paperItem
	end
end

function PANEL:LetterRecepientFound(id, name, cid, itemID)
	if !id or !name or !cid then return end
	if self.searchingRecepient and IsValid(self.searchingRecepient) then
		self.searchingRecepient:Remove()
	end

	Derma_Query("Znaleziony odbiorca to " .. name .. ", a CID należący do tej osoby to #" .. cid .. ".", "Znaleziono odbiorcę",
	"Kontynuuj", function()
		local fromCID = LocalPlayer().activeCID or "00000"
		local genericData = LocalPlayer().genericData
		local fromName = genericData.name or ""

		netstream.Start("SendLetterToID", id, itemID, fromCID, fromName)
		surface.PlaySound("helix/ui/press.wav")
		self:RemoveButtons()
		self:CreateMainButtons()
	end, "Anuluj", function()
		for _, v2 in pairs(self.letterButtons) do
			v2:SetVisible(true)
		end
	end)
end

netstream.Hook("AddEmployeeToList", function(appTable, cid, appID)
	if ix.gui.terminalPanel and IsValid(ix.gui.terminalPanel) then
		if istable(cid) then cid = tonumber(cid) end
		ix.gui.terminalPanel.counter = ix.gui.terminalPanel.counter + 1
		local tEmployee = appTable.employees[cid]
		local cidLabelEmployee = ix.gui.terminalPanel.employeeList:Add("EditablePanel")
		CreateRow(cidLabelEmployee, "cid: | id klucza ", (!cid and "N/A" or cid).." | "..(tEmployee.key == true and "OCZEKUJĄCY ID KLUCZA" or tEmployee.key or "N/A") , false)
		local remove = CreateBottomOrTopTextOrButton(cidLabelEmployee.bottom, "USUŃ", false)
		remove.DoClick = function()
			if !cid or !appTable.tenants[LocalPlayer():GetCharacter():GetGenericdata().cid] then return LocalPlayer():NotifyLocalized("Nie możesz tego zrobić.") end
			cidLabelEmployee:Remove()
			netstream.Start("RemoveEmployee", cid, appID)
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end
	end
end)

netstream.Hook("ReplyLetterRecepient", function(id, name, cid, itemID)
	if ix.gui.terminalPanel and IsValid(ix.gui.terminalPanel) then
		if !ix.gui.terminalPanel.letterSending or ix.gui.terminalPanel.letterSending and !ix.gui.terminalPanel.letterSending:IsVisible() then return end
		ix.gui.terminalPanel:LetterRecepientFound(id, name, cid, itemID)
	end
end)

netstream.Hook("SendHousingErrorMessage", function(text)
	if ix.gui.terminalPanel and IsValid(ix.gui.terminalPanel) then
		ix.gui.terminalPanel:ClearHousing()
		ix.gui.terminalPanel:CreateHousingFail(text)
	end
end)

netstream.Hook("ReplyApartmentInfo", function(appTable, appID, bShop)
	if ix.gui.terminalPanel and IsValid(ix.gui.terminalPanel) then
		if !appTable or !appID then
			ix.gui.terminalPanel:CreateHousingRequestButtons()
			return
		end

		ix.gui.terminalPanel:CreateHousingInfo(appTable, appID, bShop)
	end
end)

netstream.Hook("TerminalUpdateHousing", function(foundApartment, appNames, genericData)
	if ix.gui.terminalPanel and IsValid(ix.gui.terminalPanel) then
		ix.gui.terminalPanel:CreateHousingScroller(foundApartment, appNames)
		LocalPlayer().genericData = genericData
		ix.gui.terminalPanel:PaymentSuccess(35)
	end
end)

netstream.Hook("UpdateHousingPaymentPanel", function(appTable, appID, amount)
	if ix.gui.terminalPanel and IsValid(ix.gui.terminalPanel) then
		ix.gui.terminalPanel.appTable = appTable
		ix.gui.terminalPanel:CreatePaymentPanel(appTable, appID)
		ix.gui.terminalPanel:PaymentSuccess(amount)
	end
end)

netstream.Hook("TerminalUpdateCredits", function(amount)
	if ix.gui.terminalPanel and IsValid(ix.gui.terminalPanel) then
		ix.gui.terminalPanel:PaymentSuccess(amount)
		ix.gui.terminalPanel:RemoveButtons()
		ix.gui.terminalPanel:CreateCredits()
	end
end)

function PANEL:RemoveButtons()
	if (self.mainPanel) then
		for _, v in pairs(self.mainPanel:GetChildren()) do
			v:Remove()
		end
	end
end

vgui.Register("ixTerminal", PANEL, "EditablePanel")
