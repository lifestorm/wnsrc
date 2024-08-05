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
	local titlePushDown = SScaleMin(30 / 3)
	local padding = SScaleMin(30 / 3)
	local margin = SScaleMin(10 / 3)
	local iconSize = SScaleMin(18 / 3)
	local topPushDown = SScaleMin(150 / 3)
	local scale780 = SScaleMin(780 / 3)
	local scale120 = SScaleMin(120 / 3)

	self:SetWide(ScrW() - (topPushDown * 2))

	local sizeXtitle, sizeYtitle = self:GetWide(), scale120
	local sizeXcontent, sizeYcontent = self:GetWide(), scale780

	self.titlePanel = self:Add("Panel")
	self.titlePanel:SetSize(sizeXtitle, sizeYtitle)
	self.titlePanel:SetPos(self:GetWide() * 0.5 - self.titlePanel:GetWide() * 0.5)

	self:CreateTitleText()

	self.contentFrame = self:Add("Panel")
	self.contentFrame:SetSize(sizeXcontent, sizeYcontent)
	self.contentFrame:SetPos(self:GetWide() * 0.5 - self.contentFrame:GetWide() * 0.5, titlePushDown)

	self:SetTall(scale120 + scale780 + titlePushDown)
	self:Center()

	self.informationFrame = self.contentFrame:Add("Panel")
	self.informationFrame:SetSize(self.contentFrame:GetWide() * 0.5 - padding, self.contentFrame:GetTall())
	self.informationFrame:Dock(LEFT)
	self.informationFrame:DockMargin(0, 0, padding, 0)

	self.informationFrame.Paint = function( _, w, h )
		surface.SetDrawColor(Color(255, 255, 255, 30))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local informationSubframe = self.informationFrame:Add("Panel")
	informationSubframe:SetSize(self.informationFrame:GetSize())
	informationSubframe:DockMargin(padding, padding, padding, padding)
	informationSubframe:Dock(FILL)

	local function CreatePart(parent, title, text, icon, boolLast, editButton, bWrap)
		parent:Dock(TOP)
		parent:SetSize(informationSubframe:GetWide(), SScaleMin(16.666666666667))
		parent.Paint = function(_, w, h)
			if boolLast then
				return
			end

			surface.SetDrawColor(Color(255, 255, 255, 30))
			surface.DrawLine(0, h - 1, w, h - 1)
		end

		local leftSide = parent:Add("Panel")
		leftSide:Dock(LEFT)
		leftSide:SetWide(parent:GetWide() * 0.25)
		leftSide:DockMargin(0, 0, margin, 0)

		local parentIcon = leftSide:Add("DImage")
		parentIcon:SetImage("willardnetworks/tabmenu/charmenu/"..icon..".png")
		parentIcon:SetSize(iconSize, iconSize)
		parentIcon:Dock(LEFT)
		parentIcon:DockMargin(0, parent:GetTall() * 0.5 - iconSize * 0.5, 0, parent:GetTall() * 0.5 - iconSize * 0.5)

		local parentTitle = leftSide:Add("DLabel")
		parentTitle:SetText(title)
		parentTitle:SetFont("MenuFontLargerNoClamp")
		parentTitle:Dock(LEFT)
		parentTitle:DockMargin(margin, 0, 0, 0)
		parentTitle:SetTextColor(Color(255, 255, 255, 255))
		parentTitle:SizeToContents()

		local parentTextPanel = parent:Add("Panel")
		parentTextPanel:Dock(FILL)

		parent.Text = parentTextPanel:Add("DLabel")
		parent.Text:SetText(text)
		parent.Text:SetFont("MenuFontLargerNoClamp")
		parent.Text:SetTextColor(Color(220, 220, 220, 255))
		parent.Text:SetContentAlignment(4)
		if bWrap then
			parent.Text:SetWrap(true)
			parent.Text:SetWide(SScaleMin(467 / 3))
			parent.Text:SetTall(SScaleMin(50 / 3))
		else
			parent.Text:Dock(LEFT)
			parent.Text:SizeToContents()
		end

		local editButtonPanel = parent:Add("Panel")
		editButtonPanel:Dock(RIGHT)
		editButtonPanel:SetWide(iconSize)
		editButtonPanel:DockMargin(padding, 0, 0, 0)

		if editButton then
			editButton:SetParent(editButtonPanel)
			editButton:SetSize(iconSize, iconSize)
			editButton:Dock(RIGHT)
			editButton:DockMargin(0, parent:GetTall() * 0.5 - editButton:GetTall() * 0.5, 0, parent:GetTall() * 0.5 - editButton:GetTall() * 0.5)
		end
	end

	-- Name
	local namePanel = informationSubframe:Add("Panel")
	CreatePart(namePanel, "Name:", LocalPlayer():GetName(), "name")

	-- Fake name
	local fakeNamePanel = informationSubframe:Add("Panel")

	local editfakenameIcon = fakeNamePanel:Add("DImageButton")
	editfakenameIcon:SetImage("willardnetworks/tabmenu/charmenu/edit_desc.png")

	local fakeName = LocalPlayer():GetCharacter():GetFakeName()
	local displayFakeName = fakeName and (utf8.len(fakeName) <= 34 and fakeName or utf8.sub(fakeName, 1, 34).."...") or "--"

	CreatePart(fakeNamePanel, "Fake Name:", displayFakeName, "fakename", false, editfakenameIcon)

	editfakenameIcon.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")

		Derma_StringRequest(L("fakeNameTitle"), L("fakeNameText"), fakeName, function(text)
			local minLength = ix.config.Get("minNameLength", 4)
			local maxLength = ix.config.Get("maxNameLength", 32)
			local nameLength = utf8.len(text)

			if (text != "" and (nameLength > maxLength or nameLength < minLength)) then
				ix.util.NotifyLocalized("fakeNameLength", minLength, maxLength)

				return
			end

			net.Start("ixFakeName")
				net.WriteString(text)
			net.SendToServer()

			if fakeNamePanel.Text then
				fakeNamePanel.Text:SetText(text == "" and "--" or (nameLength <= 34 and text or utf8.sub(text, 1, 34).."..."))
				fakeNamePanel.Text:SizeToContents()
			end
		end)
	end

	-- Genetics
	local geneticAge = string.utf8lower(LocalPlayer():GetCharacter():GetAge())
	local geneticHeight = string.utf8lower(LocalPlayer():GetCharacter():GetHeight())
	local geneticEyecolor = string.utf8lower(LocalPlayer():GetCharacter():GetEyeColor())

	local function firstUpper(str)
		return str:gsub("^%l", string.utf8upper)
	end

	local geneticDescPanel = informationSubframe:Add("Panel")
	local geneticDesc = hook.Run("GetCharacterGeneticDescription", LocalPlayer():GetCharacter())
	if geneticDesc then
		CreatePart(geneticDescPanel, "Genetics:", geneticDesc, "genetics")
	else
		CreatePart(geneticDescPanel, "Genetics:", firstUpper(geneticAge).." | "..firstUpper(geneticHeight).." | "..firstUpper(geneticEyecolor).." Eyes", "genetics")
	end
	-- Description
	local description = LocalPlayer():GetCharacter():GetDescription()

	if string.utf8len(description) > 34 then
		description = string.utf8sub(description, 1, 34)
	end

	local descPanel = informationSubframe:Add("Panel")

	local editdescIcon = descPanel:Add("DImageButton")
	editdescIcon:SetImage("willardnetworks/tabmenu/charmenu/edit_desc.png")

	CreatePart(descPanel, "Description:", description, "description", false, editdescIcon)

	editdescIcon.DoClick = function()
		ix.command.Send("CharDesc")
	end

	local timerId = "ixCharacterTabUpdate"

	timer.Create(timerId, 0.25, 0, function()
		if (!IsValid(self) or !IsValid(descPanel)) then
			timer.Remove(timerId)
		elseif (LocalPlayer():GetCharacter()) then
			description = LocalPlayer():GetCharacter():GetDescription()

			if string.utf8len(description) > 34 then
				description = string.utf8sub(description, 1, 34)
			end

			if (descPanel.Text:GetText() != description) then
				descPanel.Text:SetText(description)
			end
		end
	end)

	-- Faction
	local faction = ix.faction.indices[LocalPlayer():GetCharacter():GetFaction()]

	local factionPanel = informationSubframe:Add("Panel")
	CreatePart(factionPanel, "Faction:", faction.name, "faction")

	hook.Run("CreateExtraCharacterTabInfo", LocalPlayer():GetCharacter(), informationSubframe, CreatePart)

	self.contentFrame:Add("CharFrame")

	local returnToMenuButton = informationSubframe:Add("DButton")
	returnToMenuButton:Dock(BOTTOM)
	returnToMenuButton:DockMargin(0, SScaleMin(25 / 5), 0, 0)
	returnToMenuButton:SetText("Unload Character & Return to Main Menu")
	returnToMenuButton:SetFont("MenuFontBoldNoClamp")
	returnToMenuButton:SetTall(SScaleMin(16.666666666667))
	returnToMenuButton.Paint = function(_, w, h)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 1, w - 2, h - 1)

		surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	returnToMenuButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")

		net.Start("ixReturnToMenu")
		net.SendToServer()
	end
end

function PANEL:CreateTitleText()
	local characterTitleIcon = self.titlePanel:Add("DImage")
	characterTitleIcon:SetImage("willardnetworks/tabmenu/charmenu/name.png")
	characterTitleIcon:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))

	local characterTitle = self.titlePanel:Add("DLabel")
	characterTitle:SetFont("TitlesFontNoClamp")
	characterTitle:SetText("Character")
	characterTitle:SizeToContents()
	characterTitle:SetPos(SScaleMin(32 / 3), SScaleMin(20 / 3) * 0.5 - characterTitle:GetTall() * 0.5)
end

vgui.Register("CharacterTab", PANEL, "Panel")

hook.Add("CreateMenuButtons", "CharacterTab", function(tabs)
	tabs["Character"] = {
		RowNumber = 1,
		Width = 17,
		Height = 19,
		Icon = "willardnetworks/tabmenu/navicons/character.png",
		Create = function(info, container)
			local panel = container:Add("CharacterTab")
			ix.gui.characterpanel = panel
		end
	}
end)
