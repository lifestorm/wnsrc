--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

DEFINE_BASECLASS("EditablePanel")
local PANEL = {}

local NextTime = 1
local padding = SScaleMin(20 / 3)
local function CreateButton(parent, text)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(50 / 3))
	parent:SetText(string.utf8upper(text))
	parent:SetFont("MenuFontLargerBoldNoFix")
	parent:SetContentAlignment(4)
	parent:DockMargin(0, 0, 0, -1)
	parent:SetTextInset(padding, 0)

	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end
end

local function PlayClickSound()
	net.Start( "ClickSound" )
	net.SendToServer()
end

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self.Paint = function(this, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 150))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( this, 1 )
	end

	ix.gui.medicalComputer = self

	-- Main panel
	self.panel = self:Add("EditablePanel")
	self.panel:SetSize(SScaleMin(800 / 3) + 3, SScaleMin(600 / 3) + 3)
	self.panel:Center()
	self.panel:MakePopup()
	self.panel.Paint = function(_, w, h)
		surface.SetDrawColor(Color(16, 16, 16, 255))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(150, 150, 150, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.panel)

	-- Loading video
	local loadingVideoPanel = self.panel:Add("EditablePanel")
	loadingVideoPanel:SetSize(self.panel:GetWide() - 2, self.panel:GetTall() - 2)
	loadingVideoPanel:SetPos(1, 1)

	local loadingVideo = loadingVideoPanel:Add("DHTML")
	loadingVideo:Dock(FILL)
	loadingVideo:OpenURL("https://willard.network/hl2rp_imgs/fruitycomp/index.html") -- Loading video url
	loadingVideo:SetScrollbars( false )
	loadingVideo:SetVisible(false)
	timer.Simple(0.5, function()
		if IsValid(self) then
			loadingVideo:SetVisible(true)
		end
	end)

	local cover = loadingVideoPanel:Add("EditablePanel") -- To avoid clicking on the DHTML
	cover:Dock(FILL)

	self.timeUntilLoaded = 8 -- 8
	timer.Create("ComputerLoadTimer", self.timeUntilLoaded, 1, function()
		if IsValid(self) then
			self.innerPanel = self.panel:Add("EditablePanel")
			self.innerPanel:SetSize(SScaleMin(722 / 3), SScaleMin(455 / 3))
			self.innerPanel:SetPos(SScaleMin(42 / 3), SScaleMin(109 / 3))
			self.innerPanel.parent = self

			self:CreateExitButton()
			self:CreateTitleLabel()
			self:CreateFunctionsPanel()

			if timer.Exists("ComputerLoadTimer") then
				timer.Remove( "ComputerLoadTimer" )
			end
		end
	end)
end

function PANEL:OnKeyCodePressed( keyCode )
	if keyCode != KEY_E then return end
	if !timer.Exists("ComputerLoadTimer") then return end

	netstream.Start("CloseMedicalComputer", LocalPlayer().activeComputer)
	timer.Simple(0.05, function()
		LocalPlayer().activeComputerUsers = nil
		LocalPlayer().activeComputer = nil
		LocalPlayer().activeComputerResultName = nil
		LocalPlayer().activeComputerRecords = nil
		LocalPlayer().activeComputerSearchName = nil
		LocalPlayer().activeComputerNotes = nil
	end)

	self:Remove()
end

function PANEL:CreateFunctionsPanel()
	if IsValid(self.functionsPanel) then
		self.functionsPanel:Remove()
	end

	self.functionsPanel = self.innerPanel:Add("MedicalComputerFunctionsPanel")
	self.functionsPanel:Dock(FILL)
	self.functionsPanel.Clear = function()
		for _, v in pairs(self.functionsPanel:GetChildren()) do
			if !v.noClear then
				v:Remove()
			end
		end
	end
end

function PANEL:CreateExitButton()
	local exitButton = self.innerPanel:Add("DButton")
	CreateButton(exitButton, "EXIT COMPUTER")
	exitButton:SetContentAlignment(6)

	exitButton.Paint = function(_, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 150))
		surface.DrawLine(0, h - 1, w, h - 1)
	end

	exitButton.DoClick = function()
		PlayClickSound()
		netstream.Start("CloseMedicalComputer", LocalPlayer().activeComputer)
		timer.Simple(0.05, function()
			LocalPlayer().activeComputerUsers = nil
			LocalPlayer().activeComputer = nil
			LocalPlayer().activeComputerResultName = nil
			LocalPlayer().activeComputerRecords = nil
			LocalPlayer().activeComputerSearchName = nil
			LocalPlayer().activeComputerNotes = nil
		end)

		self:Remove()
	end
end

function PANEL:CreateTitleLabel()
	self.innerPanel.titleLabel = self.innerPanel:Add("DLabel")
	self.innerPanel.titleLabel:Dock(TOP)
	self.innerPanel.titleLabel:SetFont("LargerTitlesFontNoClamp")
	self.innerPanel.titleLabel:SetText("FUNCTIONS")
	self.innerPanel.titleLabel:SizeToContents()
	self.innerPanel.titleLabel:DockMargin(padding - 1, padding, 0, padding)
end

function PANEL:Think()
	if IsValid(self.functionsPanel) then
		if IsValid(self.functionsPanel.searchPanel) then
			self.functionsPanel.searchPanel:MoveToFront()
		end

		if IsValid(self.functionsPanel.recordEntryPanel) then
			self.functionsPanel.recordEntryPanel:MoveToFront()
		end

		if IsValid(self.functionsPanel.noteEntryPanel) then
			self.functionsPanel.noteEntryPanel:MoveToFront()
		end
	end
end

vgui.Register("MedicalComputerBase", PANEL, "EditablePanel")

-- Login/register screen
PANEL = {}

function PANEL:Init()
	self:Dock(FILL)

	self:SearchForCID()
end

function PANEL:SearchForCID()
	local character = LocalPlayer():GetCharacter()
	local inventory = character:GetInventory()
	local invItems = inventory:GetItems()
	local users = LocalPlayer().activeComputerUsers or {}

	local parent = self:GetParent()
	local parentPanel = parent:GetParent()

	if IsValid(parentPanel.titleLabel) then
		parentPanel.titleLabel:SetText("SELECT CID TO REGISTER")
		parentPanel.titleLabel:SizeToContents()
	end

	for _, v in pairs(invItems) do
		if v.uniqueID == "id_card" then
			local cidButton = self:Add("DButton")
			local cidname = v:GetData("name") or "Fake Johnson"
			local cidid = v:GetData("cid") or "00000"
			CreateButton(cidButton, cidname)

			local id = cidButton:Add("DLabel")
			id:Dock(RIGHT)
			id:DockMargin(0, 0, padding, 0)
			id:SetContentAlignment(6)
			id:SetFont("MenuFontLargerBoldNoFix")
			id:SetText("##"..cidid)

			cidButton.DoClick = function()
				PlayClickSound()
				table.insert(users, cidid)
				netstream.Start("AddComputerUser", LocalPlayer().activeComputer, cidid)
				parentPanel.parent:CreateFunctionsPanel()
			end
		end
	end
end

vgui.Register("MedicalComputerRegisterScreen", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
	self:CreateLoginScreen()
end

function PANEL:CreateLoginScreen()
	local character = LocalPlayer():GetCharacter()
	local inventory = character:GetInventory()
	local invItems = inventory:GetItems()
	local users = LocalPlayer().activeComputerUsers or {}

	local parent = self:GetParent()
	local parentPanel = parent:GetParent()

	if IsValid(parentPanel.titleLabel) then
		parentPanel.titleLabel:SetText("SELECT CID TO LOGIN WITH")
		parentPanel.titleLabel:SizeToContents()
	end

	for _, v in pairs(invItems) do
		if v.uniqueID == "id_card" then
			local cidButton = self:Add("DButton")
			local cidname = v:GetData("name") or "Fake Johnson"
			local cidid = v:GetData("cid") or "00000"
			CreateButton(cidButton, cidname)

			local id = cidButton:Add("DLabel")
			id:Dock(RIGHT)
			id:DockMargin(0, 0, padding, 0)
			id:SetContentAlignment(6)
			id:SetFont("MenuFontLargerBoldNoFix")
			id:SetText("##"..cidid)

			self.canPress = true
			cidButton.DoClick = function()
				PlayClickSound()
				if !self.canPress then
					return
				end

				if !table.HasValue(users, cidid) then
					self.canPress = false
					surface.PlaySound("buttons/button8.wav")
					parentPanel.titleLabel:SetText("THIS CID DOES NOT HAVE ACCESS")
					parentPanel.titleLabel:SizeToContents()

					timer.Simple(2, function()
						if IsValid(parentPanel) then
							if IsValid(parentPanel.titleLabel) then
								if IsValid(cidButton) then
									self.canPress = true
									parentPanel.titleLabel:SetText("SELECT CID TO LOGIN WITH")
									parentPanel.titleLabel:SizeToContents()
								end
							end
						end
					end)

					return
				end

				self:GiveAccess(cidid, cidname)
			end
		end
	end

	if character then
		if (LocalPlayer():HasActiveCombineSuit() or ix.faction.Get(LocalPlayer():Team()).allowComputerLoginOverride or character:HasFlags("J")) then
			local bypassButton = self:Add("DButton")
			CreateButton(bypassButton, "Use Combine Master-Password")
			bypassButton.DoClick = function()
				PlayClickSound()

				self:GiveAccess("__COMBINE__", "__COMBINE__")
			end
		end
	end
end

function PANEL:GiveAccess(cidid, cidname)
	local parent = self:GetParent()
	local parentPanel = parent:GetParent()

	parent.isLoggedIn = true
	parent.activeCID = cidid
	parent.activeCIDName = cidname
	parent:Clear()

	parentPanel.titleLabel:SetText("FUNCTIONS")
	parentPanel.titleLabel:SizeToContents()
	parent.medicalButton = parent:Add("MedicalComputerDataButton")
	parent:Add("MedicalComputerNotesButton")
	parent:Add("MedicalComputerPasswordButton")
	parent:Add("ComputerGroupCommunicationButton")
	parent:Add("MedicalComputerNewspapersButton")
	if LocalPlayer().activeComputer.hasDiskInserted then
		ix.gui.medicalComputer.floppyDiskButton = parent:Add("FloppyDiskButtonComputer")
	end
end

vgui.Register("MedicalComputerLoginScreen", PANEL, "EditablePanel")

-- Only for medical computer
PANEL = {}

function PANEL:Init()
	self:CreateButtons()
end

function PANEL:CreateButtons()
	local users = LocalPlayer().activeComputerUsers or {}

	if IsValid(self.registerScreen) then
		self.registerScreen:Remove()
	end

	if table.IsEmpty(users) then
		self.registerScreen = self:Add("MedicalComputerRegisterScreen")
	elseif self.isLoggedIn then
		self.medicalButton = self:Add("MedicalComputerDataButton")
		self:Add("MedicalComputerNotesButton")
		self:Add("MedicalComputerPasswordButton")
		self:Add("ComputerGroupCommunicationButton")
		self:Add("MedicalComputerNewspapersButton")
		if LocalPlayer().activeComputer.hasDiskInserted then
			ix.gui.medicalComputer.floppyDiskButton = self:Add("FloppyDiskButtonComputer")
		end
	else
		self.loginScreen = self:Add("MedicalComputerLoginScreen")
	end
end

vgui.Register("MedicalComputerFunctionsPanel", PANEL, "EditablePanel")

-- Second screen to first screen
local function CreateBackButton(parent)
	if IsValid(parent.back) then
		parent.back:Remove()
	end

	parent.back = parent:Add("DButton")
	CreateButton(parent.back, "BACK")
	parent.back:SetContentAlignment(6)
	parent.back.noClear = true
	parent.back.DoClick = function()
		parent.back:Remove()
		PlayClickSound()
		parent:GetParent().titleLabel:SetText("FUNCTIONS")
		parent:GetParent().titleLabel:SizeToContents()
		parent:Clear()
		parent:CreateButtons()
	end
end

local function CreateDividerLine(where)
	local dividerLine = where:Add("DShape")
	dividerLine:SetWide(1)
	dividerLine:Dock(RIGHT)
	dividerLine:DockMargin(0, padding * 0.5, padding, padding * 0.5)
	dividerLine:SetType("Rect")
	dividerLine:SetColor(Color(150, 150, 150, 255))
end

-- Medical data button
PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	local parentPanel = parent:GetParent()

	CreateButton(self, "MEDICAL DATA")

	parent.CreateRowPanel = function()
		local activeComputerRecords = LocalPlayer().activeComputerRecords

		local rowPanel = parent:Add("DScrollPanel")
		rowPanel:Dock(FILL)
		rowPanel.Paint = nil

		for _, v in SortedPairs(activeComputerRecords, true) do
			local entryPanel = rowPanel:Add("EditablePanel")
			entryPanel:Dock(TOP)
			entryPanel:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
			entryPanel.Paint = function(_, w, h)
				surface.SetDrawColor(Color(150, 150, 150, 255))
				surface.DrawLine(0, h - 1, w, h - 1)
			end

			local top = entryPanel:Add("EditablePanel")
			top:Dock(TOP)
			top:SetTall(SScaleMin(50 / 3) / 2)

			local poster = top:Add("DLabel")
			poster:Dock(LEFT)
			poster:SetFont("MenuFontLargerBoldNoFix")
			poster:SetText(v.poster)
			poster:SetTextColor(Color(255, 255, 180, 255))
			poster:SizeToContents()
			poster:DockMargin(padding, 0, 0, 0)

			local date = top:Add("DLabel")
			date:Dock(RIGHT)
			date:SetFont("MenuFontLargerBoldNoFix")
			date:SetText(v.date)
			date:SetTextColor(Color(255, 255, 180, 255))
			date:SizeToContents()
			date:DockMargin(0, 0, padding, 0)

			local bottom = entryPanel:Add("EditablePanel")
			bottom:Dock(FILL)

			local text = bottom:Add("DLabel")
			text:Dock(LEFT)
			text:SetFont("MenuFontLargerNoClamp")
			text:SetText(string.len(v.text) > 65 and string.Left(v.text, 65).."..." or v.text)
			text:SizeToContents()
			text:SetContentAlignment(4)
			text:DockMargin(padding, 0, 0, 0)

			local view = bottom:Add("DButton")
			view:Dock(RIGHT)
			view:SetFont("MenuFontLargerNoClamp")
			view:SetText("VIEW")
			view:SizeToContents()
			view:SetContentAlignment(6)
			view:DockMargin(0, 0, padding, 0)
			view.Paint = nil
			view.DoClick = function()
				if parent.back then
					parent.back.DoClick = function()
						parent:Clear()
						PlayClickSound()

						CreateBackButton(parent)
						parent.PostSearch()
					end
				end

				PlayClickSound()
				parent:Clear()

				local noteTitlePanel = parent:Add("EditablePanel")
				noteTitlePanel:Dock(TOP)
				noteTitlePanel:SetTall(SScaleMin(50 / 3))

				local noteAddTitle = noteTitlePanel:Add("DLabel")
				noteAddTitle:Dock(LEFT)
				noteAddTitle:SetFont("MenuFontLargerBoldNoFix")
				noteAddTitle:DockMargin(padding, 0, padding, 0)
				noteAddTitle:SetContentAlignment(4)
				noteAddTitle:SetText("MEDICAL ENTRY:")
				noteAddTitle:SizeToContents()

				local noteEntry = parent:Add("DTextEntry")
				noteEntry:Dock(FILL)
				noteEntry:SetEnterAllowed( true )
				noteEntry:SetMultiline( true )
				noteEntry:SetEditable(true)
				noteEntry:SetVerticalScrollbarEnabled(true)
				noteEntry:MoveToFront()
				noteEntry:SetValue(v.text)
				noteEntry:DockMargin(0, 0, 0, padding)
				noteEntry:SetFont("MenuFontLargerNoClamp")
				noteEntry:DockMargin(padding - SScaleMin(2 / 3), 0, padding, 0)
				noteEntry:SetTextColor(Color(200, 200, 200, 255))
				noteEntry:SetCursorColor(Color(200, 200, 200, 255))
				noteEntry.Paint = function(this, w, h)
					this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
				end

				local cover = noteEntry:Add("Panel")
				cover:Dock(FILL)
				cover:DockMargin(0, 0, 19, 0)
			end
		end
	end

	parent.PostSearch = function()
		local resultName = LocalPlayer().activeComputerResultName or "INVALID NAME"

		if !LocalPlayer().activeComputerResultName then
			surface.PlaySound("buttons/button8.wav")
			parentPanel.titleLabel:SetText("NO RESULT")
			parentPanel.titleLabel:SizeToContents()

			timer.Simple(1, function()
				if IsValid(parentPanel) then
					if IsValid(parentPanel.titleLabel) then
						parentPanel.titleLabel:SetText("PLEASE RETURN")
						parentPanel.titleLabel:SizeToContents()
					end
				end
			end)

			return
		end

		parentPanel.titleLabel:SetText(resultName)
		parentPanel.titleLabel:SizeToContents()
		CreateBackButton(parent)

		local addRecord = parent:Add("DButton")
		CreateButton(addRecord, "ADD RECORD")

		parent.CreateRowPanel()

		addRecord.DoClick = function()
			PlayClickSound()
			parent:Clear()

			local noteTitlePanel = parent:Add("EditablePanel")
			noteTitlePanel:Dock(TOP)
			noteTitlePanel:SetTall(SScaleMin(50 / 3))

			local noteAddTitle = noteTitlePanel:Add("DLabel")
			noteAddTitle:Dock(LEFT)
			noteAddTitle:SetFont("MenuFontLargerBoldNoFix")
			noteAddTitle:DockMargin(padding, 0, padding, 0)
			noteAddTitle:SetContentAlignment(4)
			noteAddTitle:SetText("NOTE:")
			noteAddTitle:SizeToContents()

			local noteEntry = parent:Add("DTextEntry")
			noteEntry:Dock(FILL)
			noteEntry:SetEnterAllowed( true )
			noteEntry:SetMultiline( true )
			noteEntry:SetVerticalScrollbarEnabled(true)
			noteEntry:MoveToFront()
			noteEntry:SetValue("Write something here..")
			noteEntry:SetFont("MenuFontLargerNoClamp")
			noteEntry:DockMargin(padding - SScaleMin(2 / 3), 0, padding, 0)
			noteEntry:SetTextColor(Color(200, 200, 200, 255))
			noteEntry:SetCursorColor(Color(200, 200, 200, 255))
			noteEntry.Paint = function(this, w, h)
				this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
			end

			noteEntry.OnKeyCode = function()
				if NextTime < CurTime() then
					net.Start( "TypeSound" )
					net.SendToServer()
					NextTime = CurTime() + 0.2
				end
			end

			local addNote2 = parent:Add("DButton")
			addNote2:Dock(BOTTOM)
			addNote2:SetText("ADD ENTRY")
			addNote2:SetFont("MenuFontLargerBoldNoFix")
			addNote2:SetContentAlignment(5)
			addNote2:SetTall(SScaleMin(50 / 3))
			addNote2:DockMargin(0, padding, 0, 0)
			addNote2.Paint = function(this, w, h)
				surface.SetDrawColor(Color(200, 200, 200, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
			local entryClickable = true

			if parent.back then
				parent.back.DoClick = function()
					parent:Clear()
					PlayClickSound()

					CreateBackButton(parent)
					parent.PostSearch()
				end
			end

			addNote2.DoClick = function()
				if !entryClickable then
					return
				end

				parentPanel.titleLabel:SetText("ADDING ENTRY")
				parentPanel.titleLabel:SizeToContents()

				entryClickable = false
				PlayClickSound()
				netstream.Start("MedicalComputerAddRecord", LocalPlayer().activeComputerResultID, parent.activeCIDName, noteEntry:GetText(), LocalPlayer().activeComputer)

				local activeComputerRecords = istable(LocalPlayer().activeComputerRecords) and LocalPlayer().activeComputerRecords or {}

				activeComputerRecords[#activeComputerRecords + 1] = {
					text = noteEntry:GetText(),
					date = os.date("%d/%m/%Y"),
					poster = parent.activeCIDName
				}

				timer.Simple(0.5, function()
					parent.back.DoClick()
					parentPanel.titleLabel:SetText(resultName)
					parentPanel.titleLabel:SizeToContents()
				end)
			end

			CreateDividerLine(parent.searchPanel)
		end
	end

	self.DoClick = function()
		PlayClickSound()
		parent:Clear()
		parentPanel.titleLabel:SetText("MEDICAL DATA")
		parentPanel.titleLabel:SizeToContents()
		CreateBackButton(parent)

		local searchRecord = parent:Add("DButton")
		CreateButton(searchRecord, "SEARCH RECORD")
		searchRecord.DoClick = function()
			PlayClickSound()
			parent:Clear()

			parent.searchPanel = parent:Add("EditablePanel")
			parent.searchPanel:MakePopup()
			local x, y = parentPanel:GetParent():GetPos()
			local x2, y2 = parentPanel:GetPos()
			parent.searchPanel:SetPos(x + x2, y + y2 + (SScaleMin(50 / 3) * 3) + SScaleMin(15 / 3))
			parent.searchPanel:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
			parent.searchPanel.Paint = function(this, w, h)
				surface.SetDrawColor(Color(150, 150, 150, 255))
				surface.DrawLine(0, h - 1, w, h - 1)
			end

			local searchTitle = parent.searchPanel:Add("DLabel")
			searchTitle:Dock(LEFT)
			searchTitle:SetFont("MenuFontLargerBoldNoFix")
			searchTitle:DockMargin(padding, 0, padding, 0)
			searchTitle:SetContentAlignment(4)
			searchTitle:SetText("ENTER NAME/CID:")
			searchTitle:SizeToContents()

			local searchEntry = parent.searchPanel:Add("DTextEntry")
			searchEntry:Dock(FILL)
			searchEntry:SetEnterAllowed(false)
			searchEntry:SetMultiline( false )
			searchEntry:MoveToFront()
			searchEntry:SetValue("John Doe")
			searchEntry:SetFont("MenuFontLargerNoClamp")
			searchEntry:DockMargin(0, 0, padding, 0)
			searchEntry:SetTextColor(Color(200, 200, 200, 255))
			searchEntry:SetCursorColor(Color(200, 200, 200, 255))
			searchEntry.Paint = function(this, w, h)
				this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
			end

			searchEntry.OnKeyCode = function()
				if NextTime < CurTime() then
					net.Start( "TypeSound" )
					net.SendToServer()
					NextTime = CurTime() + 0.2
				end
			end

			local search = parent.searchPanel:Add("DButton")
			search:Dock(RIGHT)
			search:DockMargin(0, 0, padding, 0)
			search:SetText("SEARCH")
			search:SetFont("MenuFontLargerBoldNoFix")
			search:SetContentAlignment(6)
			search:SizeToContents()
			search.Paint = nil

			search.DoClick = function()
				parentPanel.titleLabel:SetText("SEARCHING")
				parentPanel.titleLabel:SizeToContents()
				netstream.Start("searchMedicalFile", searchEntry:GetText(), LocalPlayer().activeComputer)

				timer.Simple(0.5, function()
					parent:Clear()

					parent.PostSearch()
				end)
			end

			CreateDividerLine(parent.searchPanel)
		end
	end
end

vgui.Register("MedicalComputerDataButton", PANEL, "DButton")

-- Notes button
PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	local parentPanel = parent:GetParent()

	CreateButton(self, "NOTES")

	self.DoClick = function()
		PlayClickSound()
		parent:Clear()
		parentPanel.titleLabel:SetText("NOTES")
		parentPanel.titleLabel:SizeToContents()
		CreateBackButton(parent)

		local addNote = parent:Add("DButton")
		CreateButton(addNote, "ADD NOTE")

		local activeComputerNotes = LocalPlayer().activeComputerNotes

		local rowPanel = parent:Add("DScrollPanel")
		rowPanel:Dock(FILL)
		rowPanel.Paint = nil

		for noteKey, v in SortedPairs(activeComputerNotes, true) do
			local entryPanel = rowPanel:Add("EditablePanel")
			entryPanel:Dock(TOP)
			entryPanel:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
			entryPanel.Paint = function(_, w, h)
				surface.SetDrawColor(Color(150, 150, 150, 255))
				surface.DrawLine(0, h - 1, w, h - 1)
			end

			local top = entryPanel:Add("EditablePanel")
			top:Dock(TOP)
			top:SetTall(SScaleMin(50 / 3) / 2)

			local poster = top:Add("DLabel")
			poster:Dock(LEFT)
			poster:SetFont("MenuFontLargerBoldNoFix")
			poster:SetText(v.poster)
			poster:SetTextColor(Color(255, 255, 180, 255))
			poster:SizeToContents()
			poster:DockMargin(padding, 0, 0, 0)

			local date = top:Add("DLabel")
			date:Dock(RIGHT)
			date:SetFont("MenuFontLargerBoldNoFix")
			date:SetText(v.date)
			date:SetTextColor(Color(255, 255, 180, 255))
			date:SizeToContents()
			date:DockMargin(0, 0, padding, 0)

			local bottom = entryPanel:Add("EditablePanel")
			bottom:Dock(FILL)

			local text = bottom:Add("DLabel")
			text:Dock(LEFT)
			text:SetFont("MenuFontLargerNoClamp")
			text:SetText((v.headline and v.headline != "" and v.headline) or string.len(v.text) > 55 and string.Left(v.text, 55).."..." or v.text)
			text:SizeToContents()
			text:SetContentAlignment(4)
			text:DockMargin(padding, 0, 0, 0)

			local view = bottom:Add("DButton")
			view:Dock(RIGHT)
			view:SetFont("MenuFontLargerNoClamp")
			view:SetText("VIEW")
			view:SizeToContents()
			view:SetContentAlignment(6)
			view:DockMargin(0, 0, padding, 0)
			view.Paint = nil

			local edit = bottom:Add("DButton")
			edit:Dock(RIGHT)
			edit:SetFont("MenuFontLargerNoClamp")
			edit:SetText("EDIT")
			edit:SizeToContents()
			edit:SetContentAlignment(6)
			edit:DockMargin(0, 0, padding, 0)
			edit.Paint = nil

			local delete = bottom:Add("DButton")
			delete:Dock(RIGHT)
			delete:SetFont("MenuFontLargerNoClamp")
			delete:SetText("DELETE")
			delete:SizeToContents()
			delete:SetContentAlignment(6)
			delete:DockMargin(0, 0, padding, 0)
			delete.Paint = nil

			delete.DoClick = function()
				activeComputerNotes[noteKey] = nil

				netstream.Start("MedicalComputerUpdateNote", LocalPlayer().activeComputer, parent.activeCIDName, false, false, noteKey)
				local tempNotes = parent:Add("MedicalComputerNotesButton")
				tempNotes.DoClick()
			end

			view.DoClick = function()
				PlayClickSound()
				parent:Clear()

				local noteTitlePanel = parent:Add("EditablePanel")
				noteTitlePanel:Dock(TOP)
				noteTitlePanel:SetTall(SScaleMin(50 / 3))

				local noteAddTitle = noteTitlePanel:Add("DLabel")
				noteAddTitle:Dock(LEFT)
				noteAddTitle:SetFont("MenuFontLargerBoldNoFix")
				noteAddTitle:DockMargin(padding, 0, padding, 0)
				noteAddTitle:SetContentAlignment(4)
				noteAddTitle:SetText("NOTE HEADLINE:")
				noteAddTitle:SizeToContents()

				local headline = noteTitlePanel:Add("DTextEntry")
				headline:Dock(FILL)
				headline:SetEnterAllowed( false )
				headline:SetMultiline( false )
				headline:SetVerticalScrollbarEnabled(false)
				headline:MoveToFront()
				headline:SetValue(v.headline or "")
				headline:SetPlaceholderText("Write headline here..")
				headline:SetFont("MenuFontLargerNoClamp")
				headline:DockMargin(padding - SScaleMin(2 / 3), 0, padding, 0)
				headline:SetTextColor(Color(200, 200, 200, 255))
				headline:SetPlaceholderColor(Color(200, 200, 200, 255))
				headline:SetCursorColor(Color(200, 200, 200, 255))
			
				headline.AllowInput = function()
					local value2 = headline:GetValue()
					if (string.utf8len(value2) > 55) then
					  return true
					end
				end
	
				headline.Paint = function(this, w, h)
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
	
					this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
				end

				local noteEntry = parent:Add("DTextEntry")
				noteEntry:Dock(FILL)
				noteEntry:SetEnterAllowed( true )
				noteEntry:SetMultiline( true )
				noteEntry:SetEditable(true)
				noteEntry:SetVerticalScrollbarEnabled(true)
				noteEntry:MoveToFront()
				noteEntry:SetValue(v.text)
				noteEntry:DockMargin(0, 0, 0, padding)
				noteEntry:SetFont("MenuFontLargerNoClamp")
				noteEntry:DockMargin(padding - SScaleMin(2 / 3), 0, padding, 0)
				noteEntry:SetTextColor(Color(200, 200, 200, 255))
				noteEntry:SetCursorColor(Color(200, 200, 200, 255))
				noteEntry.Paint = function(this, w, h)
					this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
				end

				local cover = noteEntry:Add("Panel")
				cover:Dock(FILL)
				cover:DockMargin(0, 0, 19, 0)

				return cover, noteTitlePanel, noteEntry, headline
			end

			edit.DoClick = function()
				local cover, notePanel, noteEntry, headline = view.DoClick()
				if !cover or !notePanel then return end
				if cover and IsValid(cover) then cover:Remove() end

				local save = notePanel:GetParent():Add("DButton")
				CreateButton(save, "Save")
				save:Dock(BOTTOM)
				save.DoClick = function()
					PlayClickSound()
					activeComputerNotes[noteKey] = {
						text = noteEntry:GetText(),
						headline = headline:GetText(),
						date = os.date("%d/%m/%Y"),
						poster = parent.activeCIDName
					}

					netstream.Start("MedicalComputerUpdateNote", LocalPlayer().activeComputer, parent.activeCIDName, noteEntry:GetText(), headline:GetText(), noteKey)
				end
			end
		end

		addNote.DoClick = function()
			PlayClickSound()
			parent:Clear()

			local noteTitlePanel = parent:Add("EditablePanel")
			noteTitlePanel:Dock(TOP)
			noteTitlePanel:SetTall(SScaleMin(50 / 3))

			local noteAddTitle = noteTitlePanel:Add("DLabel")
			noteAddTitle:Dock(LEFT)
			noteAddTitle:SetFont("MenuFontLargerBoldNoFix")
			noteAddTitle:DockMargin(padding, 0, padding, 0)
			noteAddTitle:SetContentAlignment(4)
			noteAddTitle:SetText("NOTE HEADLINE:")
			noteAddTitle:SizeToContents()

			local headline = noteTitlePanel:Add("DTextEntry")
			headline:Dock(FILL)
			headline:SetEnterAllowed( false )
			headline:SetMultiline( false )
			headline:SetVerticalScrollbarEnabled(false)
			headline:MoveToFront()
			headline:SetPlaceholderText("Write headline here..")
			headline:SetFont("MenuFontLargerNoClamp")
			headline:DockMargin(padding - SScaleMin(2 / 3), 0, padding, 0)
			headline:SetTextColor(Color(200, 200, 200, 255))
			headline:SetPlaceholderColor(Color(200, 200, 200, 255))
			headline:SetCursorColor(Color(200, 200, 200, 255))
		
			headline.AllowInput = function()
				local value2 = headline:GetValue()
				if (string.utf8len(value2) > 55) then
				  return true
				end
			end

			headline.Paint = function(this, w, h)
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

				this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
			end

			local noteEntry = parent:Add("DTextEntry")
			noteEntry:Dock(FILL)
			noteEntry:SetEnterAllowed( true )
			noteEntry:SetMultiline( true )
			noteEntry:SetVerticalScrollbarEnabled(true)
			noteEntry:MoveToFront()
			noteEntry:SetPlaceholderText("Write something here..")
			noteEntry:SetFont("MenuFontLargerNoClamp")
			noteEntry:DockMargin(padding - SScaleMin(2 / 3), 0, padding, 0)
			noteEntry:SetTextColor(Color(200, 200, 200, 255))
			noteEntry:SetCursorColor(Color(200, 200, 200, 255))
			noteEntry:SetPlaceholderColor(Color(200, 200, 200, 255))
			noteEntry.Paint = function(this, w, h)
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

				this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
			end

			noteEntry.OnKeyCode = function()
				if NextTime < CurTime() then
					net.Start( "TypeSound" )
					net.SendToServer()
					NextTime = CurTime() + 0.2
				end
			end

			local addNote2 = parent:Add("DButton")
			addNote2:Dock(BOTTOM)
			addNote2:SetText("ADD NOTE")
			addNote2:SetFont("MenuFontLargerBoldNoFix")
			addNote2:SetContentAlignment(5)
			addNote2:SetTall(SScaleMin(50 / 3))
			addNote2:DockMargin(0, padding, 0, 0)
			addNote2.Paint = function(this, w, h)
				surface.SetDrawColor(Color(200, 200, 200, 255))
				surface.DrawOutlinedRect(0, 0, w, h)
			end
			local entryClickable = true

			addNote2.DoClick = function()
				if !entryClickable then
					return
				end

				parentPanel.titleLabel:SetText("ADDING NOTE")
				parentPanel.titleLabel:SizeToContents()

				entryClickable = false
				PlayClickSound()

				activeComputerNotes[#activeComputerNotes + 1] = {
					text = noteEntry:GetText(),
					headline = headline:GetText(),
					date = ix.date.GetFormatted("%d/%m/%Y"),
					poster = parent.activeCIDName
				}

				netstream.Start("MedicalComputerAddNote", LocalPlayer().activeComputer, parent.activeCIDName, noteEntry:GetText(), headline:GetText())

				timer.Simple(0.5, function()
					parent.back.DoClick()
					parentPanel.titleLabel:SetText("FUNCTIONS")
					parentPanel.titleLabel:SizeToContents()
				end)
			end
		end
	end
end

vgui.Register("MedicalComputerNotesButton", PANEL, "DButton")

-- Computer Group Communication Button
PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	local parentPanel = parent:GetParent()
	local groupMessages = ix.gui.medicalComputer.groupMessages or {}

	CreateButton(self, "Group Communication")

	self.DoClick = function()
		if istable(groupMessages) and table.IsEmpty(groupMessages) then
			LocalPlayer():NotifyLocalized("You are not part of a group!")
			return false
		end

		PlayClickSound()
		parent:Clear()
		parentPanel.titleLabel:SetText("GROUP COMMUNICATION")
		parentPanel.titleLabel:SizeToContents()
		CreateBackButton(parent)

		local sendMessage = parent:Add("DButton")
		CreateButton(sendMessage, "SEND MESSAGE")

		local rowPanel = parent:Add("DScrollPanel")
		rowPanel:Dock(FILL)
		rowPanel.Paint = nil

		for k, v in SortedPairs(groupMessages["messages"], true) do
			local entryPanel = rowPanel:Add("EditablePanel")
			entryPanel:Dock(TOP)
			entryPanel:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
			entryPanel.Paint = function(_, w, h)
				surface.SetDrawColor(Color(150, 150, 150, 255))
				surface.DrawLine(0, h - 1, w, h - 1)
			end

			local top = entryPanel:Add("EditablePanel")
			top:Dock(TOP)
			top:SetTall(SScaleMin(50 / 3) / 2)

			local poster = top:Add("DLabel")
			poster:Dock(LEFT)
			poster:SetFont("MenuFontLargerBoldNoFix")
			poster:SetText(v["message_poster"])
			poster:SetTextColor(Color(255, 255, 180, 255))
			poster:SizeToContents()
			poster:DockMargin(padding, 0, 0, 0)

			local date = top:Add("DLabel")
			date:Dock(RIGHT)
			date:SetFont("MenuFontLargerBoldNoFix")
			date:SetText(v["message_date"])
			date:SetTextColor(Color(255, 255, 180, 255))
			date:SizeToContents()
			date:DockMargin(0, 0, SScaleMin(30 / 3), 0)

			local bottom = entryPanel:Add("EditablePanel")
			bottom:Dock(FILL)

			local text = bottom:Add("DLabel")
			text:Dock(LEFT)
			text:SetFont("MenuFontLargerNoClamp")
			text:SetText(v["message_text"])
			text:SizeToContents()
			text:SetContentAlignment(4)
			text:DockMargin(padding, 0, 0, 0)

			local reply = bottom:Add("DButton")
			reply:Dock(RIGHT)
			reply:SetFont("MenuFontLargerNoClamp")
			reply:SetText("VIEW REPLIES/REPLY")
			reply:SizeToContents()
			reply:SetContentAlignment(6)
			reply:DockMargin(0, 0, padding, 0)
			reply.Paint = nil

			reply.DoClick = function()
				PlayClickSound()
				parent:Clear()
				parentPanel.titleLabel:SetText("VIEW REPLIES")
				parentPanel.titleLabel:SizeToContents()
				CreateBackButton(parent)

				local addReply = parent:Add("DButton")
				CreateButton(addReply, "ADD REPLY")

				local rowPanel2 = parent:Add("DScrollPanel")
				rowPanel2:Dock(FILL)
				rowPanel2.Paint = nil

				for _, v2 in SortedPairs(groupMessages["replies"], true) do
					if tonumber(v2["reply_parent"]) == tonumber(k) then
						local entryPanel2 = rowPanel2:Add("EditablePanel")
						entryPanel2:Dock(TOP)
						entryPanel2:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
						entryPanel2.Paint = function(_, w, h)
							surface.SetDrawColor(Color(150, 150, 150, 255))
							surface.DrawLine(0, h - 1, w, h - 1)
						end

						local top2 = entryPanel2:Add("EditablePanel")
						top2:Dock(TOP)
						top2:SetTall(SScaleMin(50 / 3) / 2)

						local poster2 = top2:Add("DLabel")
						poster2:Dock(LEFT)
						poster2:SetFont("MenuFontLargerBoldNoFix")
						poster2:SetText(v2["reply_poster"])
						poster2:SetTextColor(Color(255, 255, 180, 255))
						poster2:SizeToContents()
						poster2:DockMargin(padding, 0, 0, 0)

						local date2 = top2:Add("DLabel")
						date2:Dock(RIGHT)
						date2:SetFont("MenuFontLargerBoldNoFix")
						date2:SetText(v2["reply_date"])
						date2:SetTextColor(Color(255, 255, 180, 255))
						date2:SizeToContents()
						date2:DockMargin(0, 0, SScaleMin(30 / 3), 0)

						local bottom2 = entryPanel2:Add("EditablePanel")
						bottom2:Dock(FILL)

						local text2 = bottom2:Add("DLabel")
						text2:Dock(LEFT)
						text2:SetFont("MenuFontLargerNoClamp")
						text2:SetText(v2["reply_text"])
						text2:SizeToContents()
						text2:SetContentAlignment(4)
						text2:DockMargin(padding, 0, 0, 0)
					end
				end

				addReply.DoClick = function()
					PlayClickSound()
					parent:Clear()

					parent.messageEntryPanel = parent:Add("EditablePanel")
					parent.messageEntryPanel:MakePopup()
					local x, y = parentPanel:GetParent():GetPos()
					local x2, y2 = parentPanel:GetPos()
					parent.messageEntryPanel:SetPos(x + x2, y + y2 + (SScaleMin(50 / 3) * 3) + SScaleMin(15 / 3))
					parent.messageEntryPanel:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
					parent.messageEntryPanel.Paint = function(_, w, h)
						surface.SetDrawColor(Color(150, 150, 150, 255))
						surface.DrawLine(0, h - 1, w, h - 1)
					end

					local noteAddTitle = parent.messageEntryPanel:Add("DLabel")
					noteAddTitle:Dock(LEFT)
					noteAddTitle:SetFont("MenuFontLargerBoldNoFix")
					noteAddTitle:DockMargin(padding, 0, padding, 0)
					noteAddTitle:SetContentAlignment(4)
					noteAddTitle:SetText("REPLY:")
					noteAddTitle:SizeToContents()

					local noteEntry = parent.messageEntryPanel:Add("DTextEntry")
					noteEntry:Dock(FILL)
					noteEntry:SetEnterAllowed(false)
					noteEntry:SetMultiline( false )
					noteEntry:MoveToFront()
					noteEntry:SetValue("Write something here..")
					noteEntry:SetFont("MenuFontLargerNoClamp")
					noteEntry:DockMargin(0, 0, padding, 0)
					noteEntry:SetTextColor(Color(200, 200, 200, 255))
					noteEntry:SetCursorColor(Color(200, 200, 200, 255))
					noteEntry.MaxChars = 70
					noteEntry.Paint = function(this, w, h)
						this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
					end

					noteEntry.OnKeyCode = function()
						if NextTime < CurTime() then
							net.Start( "TypeSound" )
							net.SendToServer()
							NextTime = CurTime() + 0.2
						end
					end

					noteEntry.OnTextChanged = function(this)
						local txt = this:GetValue()
						local amt = string.utf8len(txt)
						if amt > this.MaxChars then
							if this.OldText then
								this:SetText(this.OldText)
								this:SetValue(this.OldText)
							end
						else
							this.OldText = txt
						end
					end

					local addNote2 = parent.messageEntryPanel:Add("DButton")
					addNote2:Dock(RIGHT)
					addNote2:DockMargin(0, 0, padding, 0)
					addNote2:SetText("SEND REPLY")
					addNote2:SetFont("MenuFontLargerBoldNoFix")
					addNote2:SetContentAlignment(6)
					addNote2:SizeToContents()
					addNote2.Paint = nil
					local entryClickable = true

					addNote2.DoClick = function()
						if !entryClickable then
							return
						end

						parentPanel.titleLabel:SetText("SENDING REPLY")
						parentPanel.titleLabel:SizeToContents()

						entryClickable = false
						PlayClickSound()

						groupMessages["replies"][#groupMessages["replies"] + 1] = {
							reply_text = noteEntry:GetText(),
							reply_date = os.date("%d/%m/%Y"),
							reply_poster = parent.activeCIDName,
							reply_parent = k,
							reply_groupid = LocalPlayer():GetCharacter():GetGroupID()
						}

						netstream.Start("AddGroupReplyComputer", noteEntry:GetText(), LocalPlayer():GetCharacter():GetGroupID(), parent.activeCIDName, k)

						timer.Simple(0.5, function()
							parent.back.DoClick()
							parentPanel.titleLabel:SetText("FUNCTIONS")
							parentPanel.titleLabel:SizeToContents()
						end)
					end

					CreateDividerLine(parent.messageEntryPanel)
				end
			end
		end

		sendMessage.DoClick = function()
			PlayClickSound()
			parent:Clear()

			parent.messageEntryPanel = parent:Add("EditablePanel")
			parent.messageEntryPanel:MakePopup()
			local x, y = parentPanel:GetParent():GetPos()
			local x2, y2 = parentPanel:GetPos()
			parent.messageEntryPanel:SetPos(x + x2, y + y2 + (SScaleMin(50 / 3) * 3) + SScaleMin(15 / 3))
			parent.messageEntryPanel:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
			parent.messageEntryPanel.Paint = function(_, w, h)
				surface.SetDrawColor(Color(150, 150, 150, 255))
				surface.DrawLine(0, h - 1, w, h - 1)
			end

			local noteAddTitle = parent.messageEntryPanel:Add("DLabel")
			noteAddTitle:Dock(LEFT)
			noteAddTitle:SetFont("MenuFontLargerBoldNoFix")
			noteAddTitle:DockMargin(padding, 0, padding, 0)
			noteAddTitle:SetContentAlignment(4)
			noteAddTitle:SetText("MESSAGE:")
			noteAddTitle:SizeToContents()

			local noteEntry = parent.messageEntryPanel:Add("DTextEntry")
			noteEntry:Dock(FILL)
			noteEntry:SetEnterAllowed(false)
			noteEntry:SetMultiline( false )
			noteEntry:MoveToFront()
			noteEntry:SetValue("Write something here..")
			noteEntry:SetFont("MenuFontLargerNoClamp")
			noteEntry:DockMargin(0, 0, padding, 0)
			noteEntry:SetTextColor(Color(200, 200, 200, 255))
			noteEntry:SetCursorColor(Color(200, 200, 200, 255))
			noteEntry.MaxChars = 70
			noteEntry.Paint = function(this, w, h)
				this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
			end

			noteEntry.OnKeyCode = function()
				if NextTime < CurTime() then
					net.Start( "TypeSound" )
					net.SendToServer()
					NextTime = CurTime() + 0.2
				end
			end

			noteEntry.OnTextChanged = function(this)
				local txt = this:GetValue()
				local amt = string.utf8len(txt)
				if amt > this.MaxChars then
					if this.OldText then
						this:SetText(this.OldText)
						this:SetValue(this.OldText)
					end
				else
					this.OldText = txt
				end
			end

			local addNote2 = parent.messageEntryPanel:Add("DButton")
			addNote2:Dock(RIGHT)
			addNote2:DockMargin(0, 0, padding, 0)
			addNote2:SetText("SEND MESSAGE")
			addNote2:SetFont("MenuFontLargerBoldNoFix")
			addNote2:SetContentAlignment(6)
			addNote2:SizeToContents()
			addNote2.Paint = nil
			local entryClickable = true

			addNote2.DoClick = function()
				if !entryClickable then
					return
				end

				parentPanel.titleLabel:SetText("SENDING MESSAGE")
				parentPanel.titleLabel:SizeToContents()

				entryClickable = false
				PlayClickSound()

				groupMessages["messages"][#groupMessages["messages"] + 1] = {
					message_text = noteEntry:GetText(),
					message_date = os.date("%d/%m/%Y"),
					message_poster = parent.activeCIDName,
					message_groupid = LocalPlayer():GetCharacter():GetGroupID()
				}

				netstream.Start("AddGroupMessageComputer", noteEntry:GetText(), LocalPlayer():GetCharacter():GetGroupID(), parent.activeCIDName)

				timer.Simple(0.5, function()
					parent.back.DoClick()
					parentPanel.titleLabel:SetText("FUNCTIONS")
					parentPanel.titleLabel:SizeToContents()
				end)
			end

			CreateDividerLine(parent.messageEntryPanel)
		end
	end
end

vgui.Register("ComputerGroupCommunicationButton", PANEL, "DButton")

-- Newspapers button
PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	local parentPanel = parent:GetParent()
	CreateButton(self, "DIGITAL NEWSPAPERS")

	self.DoClick = function()
		PlayClickSound()
		parent:Clear()
		parentPanel.titleLabel:SetText("DIGITAL NEWSPAPERS")
		parentPanel.titleLabel:SizeToContents()
		CreateBackButton(parent)

		self.rowPanel = parent:Add("DScrollPanel")
		self.rowPanel:Dock(FILL)
		self.rowPanel.Paint = nil
		self.rowPanel.CreateStoredNewspapers = function(rowPanel, newspapers)
			local canRead = LocalPlayer():GetCharacter():GetCanread()
		
			for _, data1 in SortedPairs(newspapers, true) do
				local data = util.JSONToTable(data1["unionnewspaper_data"])
				local writingID = data.unionDatabase
				local entryPanel = rowPanel:Add("EditablePanel")
				entryPanel:Dock(TOP)
				entryPanel:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
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
				title:SetTextColor(Color(255, 255, 180, 255))
				title:SizeToContents()
				title:DockMargin(padding, 0, 0, 0)
		
				local bottom = entryPanel:Add("EditablePanel")
				bottom:Dock(FILL)
		
				local subtitle = bottom:Add("DLabel")
				subtitle:Dock(LEFT)
				subtitle:SetFont("MenuFontLargerNoClamp")
				subtitle:SetText(canRead and data.subHeadline or Schema:ShuffleText(data.subHeadline))
				subtitle:SizeToContents()
				subtitle:SetContentAlignment(4)
				subtitle:DockMargin(padding, 0, 0, 0)
		
				local viewNewspaper = bottom:Add("DButton")
				viewNewspaper:Dock(RIGHT)
				viewNewspaper:SetFont("MenuFontLargerNoClamp")
				viewNewspaper:SetText("VIEW")
				viewNewspaper:SizeToContents()
				viewNewspaper:SetContentAlignment(6)
				viewNewspaper:DockMargin(0, 0, padding, 0)
				viewNewspaper.Paint = nil
		
				viewNewspaper.DoClick = function()
					PlayClickSound()
					surface.PlaySound("helix/ui/press.wav")
					netstream.Start("ixWritingGetUnionWritingData", writingID)
				end
			end
		end

		ix.gui.medicalComputer.newspaper = self.rowPanel

		netstream.Start("ixWritingGetUnionNewspapers")
	end
end

vgui.Register("MedicalComputerNewspapersButton", PANEL, "DButton")

-- Floppy Disk button
PANEL = {}

function PANEL:Init()
	CreateButton(self, "LOAD DISK DATA")
	ix.gui.medicalComputer.floppyDiskButton = self

	self.DoClick = function()
		PlayClickSound()
		netstream.Start("RequestFloppyDiskData", LocalPlayer().activeComputer)
	end
end

function PANEL:CreatePasswordEnter(parent, parentPanel)
	local passwordPanel = parent:Add("EditablePanel")
	passwordPanel:MakePopup()
	local x, y = parentPanel:GetParent():GetPos()
	local x2, y2 = parentPanel:GetPos()
	passwordPanel:SetPos(x + x2, y + y2 + (SScaleMin(50 / 3) * 3) + SScaleMin(15 / 3))
	passwordPanel:SetSize(parentPanel:GetWide(), SScaleMin(50 / 3))
	passwordPanel.Paint = function(this, w, h)
		passwordPanel:MoveToFront()
		surface.SetDrawColor(Color(150, 150, 150, 255))
		surface.DrawLine(0, h - 1, w, h - 1)
	end

	local passwordTitle = passwordPanel:Add("DLabel")
	passwordTitle:Dock(LEFT)
	passwordTitle:SetFont("MenuFontLargerBoldNoFix")
	passwordTitle:DockMargin(padding, 0, padding, 0)
	passwordTitle:SetContentAlignment(4)
	passwordTitle:SetText("ENTER PASSWORD:")
	passwordTitle:SizeToContents()

	local passwordEntry = passwordPanel:Add("DTextEntry")
	passwordEntry:Dock(FILL)
	passwordEntry:SetEnterAllowed(false)
	passwordEntry:SetMultiline( false )
	passwordEntry:MoveToFront()
	passwordEntry:SetValue("")
	passwordEntry:SetFont("MenuFontLargerNoClamp")
	passwordEntry:DockMargin(0, 0, padding, 0)
	passwordEntry:SetTextColor(Color(200, 200, 200, 255))
	passwordEntry:SetCursorColor(Color(200, 200, 200, 255))
	passwordEntry.Paint = function(this, w, h)
		this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
	end

	passwordEntry.OnKeyCode = function()
		if NextTime < CurTime() then
			net.Start( "TypeSound" )
			net.SendToServer()
			NextTime = CurTime() + 0.2
		end
	end

	local enter = passwordPanel:Add("DButton")
	enter:Dock(RIGHT)
	enter:DockMargin(0, 0, padding, 0)
	enter:SetText("ENTER")
	enter:SetFont("MenuFontLargerBoldNoFix")
	enter:SetContentAlignment(6)
	enter:SizeToContents()
	enter.Paint = nil

	enter.DoClick = function()
		PlayClickSound()
		parentPanel.titleLabel:SetText("CHECKING")
		parentPanel.titleLabel:SizeToContents()
		netstream.Start("RequestFloppyDiskData", LocalPlayer().activeComputer, passwordEntry:GetText())
	end

	CreateDividerLine(passwordPanel)
end

function PANEL:CreateDiskData(parent, parentPanel, data)
	for _, v in pairs(parent:GetChildren()) do
		if v == ix.gui.medicalComputer.floppyDiskButton then
			ix.gui.medicalComputer.floppyDiskButton:SetVisible(false)
			continue
		end

		if v != ix.gui.medicalComputer.floppyDiskButton then
			v:Remove()
		end
	end

	CreateBackButton(parent)
	parentPanel.titleLabel:SetText("DISK DATA")
	parentPanel.titleLabel:SizeToContents()

	local noteTitlePanel = parent:Add("EditablePanel")
	noteTitlePanel:Dock(TOP)
	noteTitlePanel:SetTall(SScaleMin(50 / 3))

	local noteAddTitle = noteTitlePanel:Add("DLabel")
	noteAddTitle:Dock(LEFT)
	noteAddTitle:SetFont("MenuFontLargerBoldNoFix")
	noteAddTitle:DockMargin(padding, 0, padding, 0)
	noteAddTitle:SetContentAlignment(4)
	noteAddTitle:SetText("DISK DATA:")
	noteAddTitle:SizeToContents()

	local noteEntry = parent:Add("DTextEntry")
	noteEntry:Dock(FILL)
	noteEntry:SetEnterAllowed( true )
	noteEntry:SetMultiline( true )
	noteEntry:SetEditable(true)
	noteEntry:SetVerticalScrollbarEnabled(true)
	noteEntry:MoveToFront()
	noteEntry:SetValue(data or "")
	noteEntry:DockMargin(0, 0, 0, padding)
	noteEntry:SetFont("MenuFontLargerNoClamp")
	noteEntry:DockMargin(padding - SScaleMin(2 / 3), 0, padding, 0)
	noteEntry:SetTextColor(Color(200, 200, 200, 255))
	noteEntry:SetCursorColor(Color(200, 200, 200, 255))
	noteEntry.Paint = function(this, w, h)
		this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
	end

	local setPassword = parent:Add("DButton")
	CreateButton(setPassword, "SET DISK PASSWORD")
	setPassword:Dock(BOTTOM)
	setPassword.DoClick = function()
		PlayClickSound()
		Derma_StringRequest("Enter the password you want it to change to", "", "", function(newPass)
			PlayClickSound()
			netstream.Start("FloppyDiskSetPassword", newPass, LocalPlayer().activeComputer)
		end)
	end

	local saveDiskData = parent:Add("DButton")
	CreateButton(saveDiskData, "SAVE DISK DATA")
	saveDiskData:Dock(BOTTOM)
	saveDiskData:DockMargin(0, SScaleMin(10 / 3), 0, 0)
	saveDiskData.DoClick = function()
		PlayClickSound()
		netstream.Start("FloppyDiskSetData", noteEntry:GetText(), LocalPlayer().activeComputer)
	end
end

vgui.Register("FloppyDiskButtonComputer", PANEL, "DButton")

netstream.Hook("ReplyFloppyDiskData", function(password, bErrorSound, data)
	if !ix.gui.medicalComputer.floppyDiskButton then return false end

	local parent = ix.gui.medicalComputer.floppyDiskButton:GetParent()
	if !parent then return false end

	local parentPanel = parent:GetParent()
	if !parentPanel then return false end

	if !password then
		for _, v in pairs(parent:GetChildren()) do
			if v == ix.gui.medicalComputer.floppyDiskButton then
				ix.gui.medicalComputer.floppyDiskButton:SetVisible(false)
				continue
			end
	
			if v != ix.gui.medicalComputer.floppyDiskButton then
				v:Remove()
			end
		end
		
		if bErrorSound then
			surface.PlaySound("buttons/button8.wav")
		end

		CreateBackButton(parent)
		parentPanel.titleLabel:SetText("DISK PASSWORD")
		parentPanel.titleLabel:SizeToContents()

		ix.gui.medicalComputer.floppyDiskButton:CreatePasswordEnter(parent, parentPanel)
		return
	else
		ix.gui.medicalComputer.floppyDiskButton:CreateDiskData(parent, parentPanel, data)
	end
end)

-- Password button
PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	local parentPanel = parent:GetParent()

	CreateButton(self, "ADD USER")

	self.DoClick = function()
		PlayClickSound()
		parent:Clear()
		parentPanel.titleLabel:SetText("SELECT CID TO ADD")
		parentPanel.titleLabel:SizeToContents()
		CreateBackButton(parent)

		local character = LocalPlayer():GetCharacter()
		local inventory = character:GetInventory()
		local invItems = inventory:GetItems()
		local users = LocalPlayer().activeComputerUsers or {}

		for _, v in pairs(invItems) do
			if v.uniqueID == "id_card" then
				local cidButton = parent:Add("DButton")
				local cidname = v:GetData("name") or "Fake Johnson"
				local cidid = v:GetData("cid") or "00000"
				CreateButton(cidButton, cidname)

				local id = cidButton:Add("DLabel")
				id:Dock(RIGHT)
				id:DockMargin(0, 0, padding, 0)
				id:SetContentAlignment(6)
				id:SetFont("MenuFontLargerBoldNoFix")
				id:SetText("##"..cidid)

				local canPress = true
				cidButton.DoClick = function()
					PlayClickSound()
					if !canPress then
						return
					end

					if table.HasValue(users, cidid) then
						surface.PlaySound("buttons/button8.wav")
						parentPanel.titleLabel:SetText("USER #"..cidid.." ALREADY EXISTS")
						parentPanel.titleLabel:SizeToContents()
						canPress = false

						timer.Simple(2, function()
							if IsValid(parentPanel) then
								if IsValid(parentPanel.titleLabel) then
									if IsValid(cidButton) then
										canPress = true
										parentPanel.titleLabel:SetText("SELECT CID TO ADD")
										parentPanel.titleLabel:SizeToContents()
									end
								end
							end
						end)

						return
					end

					table.insert(users, cidid)
					netstream.Start("AddComputerUser", LocalPlayer().activeComputer, cidid)
					parentPanel.titleLabel:SetText("ADDED #"..cidid.." TO COMPUTER")
					parentPanel.titleLabel:SizeToContents()
					timer.Simple(1, function()
						if IsValid(parentPanel) then
							if IsValid(parentPanel.titleLabel) then
								parentPanel.titleLabel:SetText("SELECT CID TO ADD")
								parentPanel.titleLabel:SizeToContents()
							end
						end
					end)
				end
			end
		end
	end
end

vgui.Register("MedicalComputerPasswordButton", PANEL, "DButton")
