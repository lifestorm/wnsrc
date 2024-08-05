--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

local PANEL = {}
local padding = SScaleMin(10 / 3)

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self.Paint = function(self, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( self, 1 )
	end

	self.content = self:Add("EditablePanel")
	self.content:SetSize(SScaleMin(700 / 3), SScaleMin(600 / 3))
	self.content:Center()
	self.content:MakePopup()
	self.content.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.content)

	self:CreateTopBar()

	self.innerSelf = self.content:Add("DScrollPanel")
	self.innerSelf:SetTall(SScaleMin(600 / 3) - SScaleMin(75 / 3))
	self.innerSelf:Dock(TOP)
end

function PANEL:CreateTopBar()
	self.topbar = self.content:Add("Panel")
	self.topbar:SetSize(self:GetWide(), SScaleMin(50 / 3))
	self.topbar:Dock(TOP)
	self.topbar:DockMargin(0, 0, 0, padding)
	self.topbar.Paint = function( self, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.titleText = self.topbar:Add("DLabel")
	self.titleText:SetFont("CharCreationBoldTitleNoClamp")
	self.titleText:Dock(LEFT)
	self.titleText:SetText("Character Information")
	self.titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	self.titleText:SetContentAlignment(4)
	self.titleText:SizeToContents()

	local exit = self.topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local divider = self.topbar:Add("Panel")
	self:CreateDivider(divider)
end

function PANEL:Update(targetPlayer, data)
	self.targetPlayer = targetPlayer
	self.data = data

	if self.data and self.targetPlayer then
		self:CreateToolButton()
	end
end

function PANEL:CreateToolButton()
	local gamemasterButton = self.topbar:Add("DButton")
	self:CreateButton(gamemasterButton, "character tool", "skills")

	gamemasterButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if !self.innerSelf:IsVisible() then
			gamemasterButton:SetText(string.utf8upper("Character Tool"))
			gamemasterButton.image = "skills"

			self.innerSelf:SetVisible(true)
			if self.gmInnerSelf then
				self.titleText:SetText("Character Information")
				self.gmInnerSelf:SetVisible(false)
				self.saveButton:SetVisible(false)
				self.saveDivider:SetVisible(false)
			end
		else
			self.titleText:SetText("Character Tool")
			self.innerSelf:SetVisible(false)
			gamemasterButton:SetText(string.utf8upper("Character Info"))
			gamemasterButton.image = "character"

			self.saveDivider = self.topbar:Add("Panel")
			self:CreateDivider(self.saveDivider)

			self.saveButton = self.topbar:Add("DButton")
			self:CreateButton(self.saveButton, "save notes", "appearances")

			self:CreateGMInnerSelf()
		end
	end

	local createTimeLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(createTimeLabel, "CREATED AT:")

	local createTimeText = self.innerSelf:Add("DTextEntry")
	local Timestamp = self.data.createInfo
	local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )
	self:CreateTextEntry(createTimeText, TimeString, 36)

	local nameLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(nameLabel, "NAME")

	local name = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(name, self.data.name, 36)

	local genderLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(genderLabel, "GENDER")

	local gender = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(gender, self:FirstUpper(self.data.gender), 36)

	local geneticLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(geneticLabel, "GENETIC DESC")

	local geneticAge = string.utf8lower(self.data.age or "N/A")
	local geneticHeight = string.utf8lower(self.data.height or "N/A")
	local geneticEyecolor = string.utf8lower(self.data.eyeColor or "N/A")
	local geneticText = self:FirstUpper(geneticAge).." | "..self:FirstUpper(geneticHeight).." | "..self:FirstUpper(geneticEyecolor).." Eyes"

	local genetics = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(genetics, geneticText, 36)

	local descLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(descLabel, "DESCRIPTION")

	local desc = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(desc, self.data.description, (40 * 2), true)

	local moneyLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(moneyLabel, "CHIPS")

	local money = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(money, self.data.money, 36)

	local attributesLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(attributesLabel, "ATTRIBUTES")

	self:CreateAttribute("willardnetworks/mainmenu/charcreation/strength.png", 45, 61, "strength", "strength")
	self:CreateAttribute("willardnetworks/mainmenu/charcreation/perception.png", 45, 30, "perception", "perception")
	self:CreateAttribute("willardnetworks/mainmenu/charcreation/agility.png", 38, 47, "agility", "agility")
	self:CreateAttribute("willardnetworks/mainmenu/charcreation/intelligence.png", 48, 29, "intelligence", "intelligence")

	local backgroundData = self.data.background

	if backgroundData != "N/A" and backgroundData != "" then
		local backgroundLabel = self.innerSelf:Add("DLabel")
		self:CreateTitleLabel(backgroundLabel, "BACKGROUND")

		if backgroundData == "Relocated Citizen" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/relocatedcitizen.png", 45, 61, "Relocated Citizen", "You have just arrived in this new, unfamiliar city. No family, no contacts, just another nobody getting off the train to start a new life.", -5, "Good for new players")
		end

		if backgroundData == "Local Citizen" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Local Citizen", "You have lived here quite a while, perhaps even since before the occupation. Now the City is falling apart, and you are left to keep yourself safe.", 0)
		end

		if backgroundData == "Supporter Citizen" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Supporter Citizen", "For one reason or another, you have accepted the Union's authority, follow their rules and try to live up to their expectations. Some citizens may not take kindly to your collaboration.", 0)
		end

		if backgroundData == "Outcast" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/outcast.png", 55, 55, "Outcast", "Always on the move, always in hiding. Avoiding the eye of the Combine. You live off your own means in the slums, for the better or for the worse.", 0)
		end

		if backgroundData == "Biotic" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Biotic", "Enslaved, freed, and enslaved once again. With a collar on your neck, and the boot of the Combine upon you, you must endure the torture. You, and thousands of others.", 13, "Choose this unless you have permission to use the other backgrounds.")
		end

		if backgroundData == "Liberated" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Liberated", "Once enslaved, free again. You have lived under the boot of the Combine, but no longer. Be wary, for the Combine have tasted your blood before, and will not show leniency should they find you again...", 13, "Hard difficulty - Do not use this unless you have permission. This background starts with a CID.")
		end

		if backgroundData == "Free" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/outcast.png", 55, 55, "Free", "You have been one of the lucky few vortigaunts to have never been captured by the Combine. The last chain around your neck was that of the Nihilanth. The Combine does not know you exist.", 15, "Do not use this unless you have permission. This background starts with no CID.")
		end

		if backgroundData == "Collaborator" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Collaborator", "A traitor to Vortkind who permitted itself the luxuries that the Combine have deceitfully offered, thus you have taken up the status of Collaborator.", 13, "Do not use this unless you have permission. This background starts with a CID and 50 Cohesion Points along with a nice pair of pants and no shackles")
		end

		if backgroundData == "Worker" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/relocatedcitizen.png", 45, 61, "Worker", "You are a worker for the Civil Workers Union under the Combine occupation. You spend your time cleaning infestation or repairing infrastructure.", -8)
		end

		if backgroundData == "Medic" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Medic", "You are a medic for Civil Medical Union. Your job is to heal the populace, or if you get lucky, operate on both Vortiguants and Civil Protection. Do your duty.", -10)
		end
	end

	if !table.IsEmpty(self.data.skillLvl) then
		local skillsLabel = self.innerSelf:Add("DLabel")
		self:CreateTitleLabel(skillsLabel, "SKILLS")
	end

	for skill, level in pairs(self.data.skillLvl) do
		local skillEntry = self.innerSelf:Add("DTextEntry")
		self:CreateTextEntry(skillEntry, ix.skill:Find(skill).name.." | Level: "..level, 36)
	end

	local ac = ""
	local points = ""
	local occupation = ""
	local designatedStatus = ""
	local bol = ""

	if self.data.genericData.socialCredits then
		if (self.data.genericData.socialCredits >= 0 or self.data.genericData.socialCredits <= 0) then
			points = "SC/LP: "..math.Clamp(tonumber(self.data.genericData.socialCredits), 0, 200).." | "
		end
	end

	if (self.data.genericData.occupation) then
		if self.data.genericData.occupation != "N/A" then
			occupation = "OCCUPATION: "..self.data.genericData.occupation.." | "
		end
	end

	if self.data.genericData.designatedStatus then
		if self.data.genericData.designatedStatus != "N/A" then
			designatedStatus = "STATUS: "..self.data.genericData.designatedStatus
		end
	end

	if self.data.genericData then
		local datafileLabel = self.innerSelf:Add("DLabel")
		self:CreateTitleLabel(datafileLabel, "DATAFILE")

		if self.data.genericData.anticitizen == true then
			ac = "ANTI-CITIZEN | "
		end

		if self.data.genericData.bol == true then
			bol = "BOL | "
		end

		local datafileEntry = self.innerSelf:Add("DTextEntry")
		self:CreateTextEntry(datafileEntry, ac..bol..points..occupation..designatedStatus, 36)
	end
end

function PANEL:CreateGMInnerSelf()
	self.gmInnerSelf = self.content:Add("EditablePanel")
	self.gmInnerSelf:SetTall(SScaleMin(600 / 3) - SScaleMin(65 / 3))
	self.gmInnerSelf:Dock(TOP)

	self.gmTextEntry = self.gmInnerSelf:Add("DTextEntry")
	self.gmTextEntry:Dock(LEFT)
	self.gmTextEntry:SetSize(SScaleMin(450 / 3), self.gmInnerSelf:GetTall())
	self.gmTextEntry:DockMargin(padding * 2, SScaleMin(5 / 3), padding * 2 + SScaleMin(20 / 3), padding)
	self.gmTextEntry:SetMultiline( true )
	self.gmTextEntry:SetVerticalScrollbarEnabled( true )
	self.gmTextEntry:SetEnterAllowed( true )
	self.gmTextEntry:SetTextColor(Color(200, 200, 200, 255))
	self.gmTextEntry:SetCursorColor(Color(200, 200, 200, 255))
	self.gmTextEntry:SetFont("MenuFontNoClamp")
	self.gmTextEntry:SetText(self.data.info)
	self.gmTextEntry.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
	end

	local buttonList = self.gmInnerSelf:Add("Panel")
	buttonList:Dock(RIGHT)
	buttonList:SetWide(SScaleMin(250 / 3))
	buttonList:DockMargin(padding, 0, padding, 0)

	self:CreateButtonListTitle(buttonList, "Genetics")

	local editGeneticAge = buttonList:Add("DButton")
	self:CreateFunctionButton(editGeneticAge, "Genetic Age", "appearances", function()
		Derma_StringRequest("Genetic Age", "Young Adult / Adult / Middle-Aged / Elderly", nil, function(text)
			netstream.Start("setAge", self.targetPlayer, text)
			LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s age to "..text)
		end)
	end)

	local editGeneticHeight = buttonList:Add("DButton")
	self:CreateFunctionButton(editGeneticHeight, "Genetic Height", "appearances", function()
		Derma_StringRequest("Genetic Height", "E.g 5'8\", 6'0\" (MAKE SURE TO INCLUDE THE ' AND \" OR THE CHARACTER WILL BREAK!!!)", nil, function(text)
			local heightft, heightin = string.match(text, "^(%d+)'(%d+)\"$")
			if (!heightft or !heightin) then
				LocalPlayer():NotifyLocalized("You did not enter a valid height")
			else
				netstream.Start("setHeight", self.targetPlayer, text)
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s height to "..text)
			end
		end)
	end)

	local editGeneticEye = buttonList:Add("DButton")
	self:CreateFunctionButton(editGeneticEye, "Genetic Eye Color", "appearances", function()
		Derma_StringRequest("Genetic Eye Color", "E.g blue / green / brown", nil, function(text)
			netstream.Start("setEyeColor", self.targetPlayer, text)
			LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s eye color to "..text)
		end)
	end)

	self:CreateButtonListDivider(buttonList)
	self:CreateButtonListTitle(buttonList, "Attributes")

	local charStrength = buttonList:Add("DButton")
	self:CreateFunctionButton(charStrength, "Strength", "attributes", function()
		Derma_StringRequest("Edit Strength", "From 0 to 10", nil, function(number)
			netstream.Start("setStrength", self.targetPlayer, number)
			LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s strength to "..number)
		end)
	end)

	local charPerception = buttonList:Add("DButton")
	self:CreateFunctionButton(charPerception, "Perception", "attributes", function()
		Derma_StringRequest("Edit Perception", "From 0 to 10", nil, function(number)
			netstream.Start("setPerception", self.targetPlayer, number)
			LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s perception to "..number)
		end)
	end)

	local charAgility = buttonList:Add("DButton")
	self:CreateFunctionButton(charAgility, "Agility", "attributes", function()
		Derma_StringRequest("Edit Agility", "From 0 to 10", nil, function(number)
			netstream.Start("setAgility", self.targetPlayer, number)
			LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s agility to "..number)
		end)
	end)

	local charInt = buttonList:Add("DButton")
	self:CreateFunctionButton(charInt, "Intelligence", "attributes", function()
		Derma_StringRequest("Edit Intelligence", "From 0 to 10", nil, function(number)
			netstream.Start("setIntelligence", self.targetPlayer, number)
			LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s intelligence to "..number)
		end)
	end)

	self:CreateButtonListDivider(buttonList)
	self:CreateButtonListTitle(buttonList, "Background")

	local charBackground = buttonList:Add("DButton")
	self:CreateFunctionButton(charBackground, "Edit Background", "background", function()
		if self.data.faction != FACTION_CITIZEN and self.data.faction != FACTION_VORT then
			LocalPlayer():NotifyLocalized("This faction does not have any backgrounds!")
			return false
		end

		if self.data.faction == FACTION_CITIZEN then
			Derma_Query( "Set Background", "Select one",
			"Relocated Citizen", function()
				netstream.Start("setBackground", self.targetPlayer, "Relocated Citizen")
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s background to Relocated Citizen.")
			end,

			"Local Citizen", function()
				netstream.Start("setBackground", self.targetPlayer, "Local Citizen")
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s background to Local Citizen.")
			end,

			"Supporter Citizen", function()
				netstream.Start("setBackground", self.targetPlayer, "Supporter Citizen")
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s background to Supporter Citizen.")
			end,

			"Outcast", function()
				netstream.Start("setBackground", self.targetPlayer, "Outcast")
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s background to Outcast.")
			end)
		end

		if self.data.faction == FACTION_VORT then
			Derma_Query( "Set Background", "Select one",
			"Biotic", function()
				netstream.Start("setBackground", self.targetPlayer, "Biotic")
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s background to Biotic.")
			end,

			"Liberated", function()
				netstream.Start("setBackground", self.targetPlayer, "Liberated")
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s background to Liberated.")
			end,

			"Free", function()
				netstream.Start("setBackground", self.targetPlayer, "Free")
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s background to Free.")
			end,

			"Collaborator", function()
				netstream.Start("setBackground", self.targetPlayer, "Collaborator")
				LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s background to Collaborator.")
			end)
		end
	end)

	self:CreateButtonListDivider(buttonList)
	self:CreateButtonListTitle(buttonList, "Admin Tools")

	local charName = buttonList:Add("DButton")
	self:CreateFunctionButton(charName, "Character Name", "character", function()
		Derma_StringRequest("Edit Name", "What do you want the name to be?", nil, function(name)
			ix.command.Send("CharSetName", self.data.name, name)
		end)
	end)

	local charMoney = buttonList:Add("DButton")
	self:CreateFunctionButton(charMoney, "Character Money", "appearances", function()
		Derma_StringRequest("Edit Money", "What do you want the money to be set to?", nil, function(money)
			ix.command.Send("CharSetTokens", self.data.name, money)
		end)
	end)

	local charDesc = buttonList:Add("DButton")
	self:CreateFunctionButton(charDesc, "Character Desc", "appearances", function()
		Derma_StringRequest("Edit Description", "What do you want the description to be set to?", nil, function(desc)
			netstream.Start("setDescription", self.targetPlayer, desc)
			LocalPlayer():NotifyLocalized("You have set "..self.data.name.."'s description to "..desc)
		end)
	end)

	self.saveButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		LocalPlayer():NotifyLocalized("Saved gamemaster data for ".. self.data.name)
		netstream.Start("SaveGMData", self.targetPlayer, self.gmTextEntry:GetText())
	end
end

function PANEL:CreateDivider(parent)
	parent:SetSize(1, self.topbar:GetTall())
	parent:Dock(RIGHT)
	parent:DockMargin(SScaleMin(5 / 3), padding, padding + SScaleMin(5 / 3), padding)
	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, 0, 0, h)
	end
end

function PANEL:CreateButton(parent, text, image)
	parent:SetText(string.utf8upper(text))
	parent:SetFont("WNMenuFontNoClamp")
	parent:SetContentAlignment(4)
	parent:SetTextInset(SScaleMin(26 / 3), 0)
	parent:SetTextColor(color_white)
	parent:Dock(RIGHT)
	parent:SizeToContents()
	local width, height = parent:GetSize()
	parent:SetSize(width, SScaleMin(50 / 3))
	parent.image = image

	parent.OnCursorEntered = function()
		surface.PlaySound("willardnetworks/charactercreation/hover.wav")
	end

	parent.Paint = function(self, w, h)
		if self:IsHovered() then
			self:SetTextColor(color_white)
			surface.SetDrawColor(color_white)
		else
			self:SetTextColor(Color(200, 200, 200, 255))
			surface.SetDrawColor(Color(200, 200, 200, 255))
		end

		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/"..parent.image..".png"))
		surface.DrawTexturedRect(0, SScaleMin(15 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3))
	end
end

function PANEL:CreateFunctionButton(parent, name, image, callback)
	parent:SetText(string.utf8upper(name))
	parent:SetFont("WNMenuFontNoClamp")
	parent:SetContentAlignment(4)
	parent:SetTextInset(SScaleMin(26 / 3), 0)
	parent:SetTextColor(color_white)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(20 / 3))
	parent:DockMargin(SScaleMin(57 / 3), SScaleMin(3 / 3), padding, SScaleMin(7 / 3))
	parent.image = image

	parent.OnCursorEntered = function()
		surface.PlaySound("willardnetworks/charactercreation/hover.wav")
	end

	parent.Paint = function(self, w, h)
		if self:IsHovered() then
			self:SetTextColor(color_white)
			surface.SetDrawColor(color_white)
		else
			self:SetTextColor(Color(200, 200, 200, 255))
			surface.SetDrawColor(Color(200, 200, 200, 255))
		end

		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/"..parent.image..".png"))
		surface.DrawTexturedRect(0, 0, SScaleMin(20 / 3), SScaleMin(20 / 3))
	end

	parent.DoClick = callback
end

function PANEL:CreateButtonListTitle(parent, title)
	local buttonListTitle = parent:Add("DLabel")
	buttonListTitle:SetText(string.utf8upper(title))
	buttonListTitle:SetFont("TitlesFontNoClamp")
	buttonListTitle:Dock(TOP)
	buttonListTitle:DockMargin(SScaleMin(57 / 3), SScaleMin(3 / 3), padding, SScaleMin(7 / 3))
end

function PANEL:CreateButtonListDivider(parent)
	local buttonListDivider = parent:Add("Panel")
	buttonListDivider:Dock(TOP)
	buttonListDivider:SetTall(1)
	buttonListDivider:DockMargin(SScaleMin(57 / 3), SScaleMin(3 / 3), padding + SScaleMin(7 / 3), SScaleMin(7 / 3))
	buttonListDivider.Paint = function(self, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, 0, w, 0)
	end
end

function PANEL:FirstUpper(str)
	if !str then return end
	if !isstring(str) then str = tostring(str) end
	return (str:gsub("^%l", string.utf8upper))
end

function PANEL:CreateTitleLabel(parent, value)
	parent:Dock(TOP)
	parent:SetContentAlignment(4)
	parent:SetText(value)
	parent:DockMargin(padding * 2, 0, padding * 2, 5)
	parent:SetFont("MenuFontNoClamp")
	parent:SetTextColor(color_white)
end

function PANEL:CreateTextEntry(parent, value, height, scrollAble)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(height / 3))
	parent:DockMargin(padding * 2, 0, padding * 2 + SScaleMin(5 / 3), padding)
	parent:SetTextColor(Color(200, 200, 200, 255))
	parent:SetCursorColor(Color(200, 200, 200, 255))
	parent:SetFont("MenuFontNoClamp")
	parent:SetText(value)
	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
	end

	if (scrollAble) then
		parent:SetMultiline( true )
		parent:SetVerticalScrollbarEnabled( true )
	end
end

function PANEL:CreateBackgroundSelectionPanels(icon, iconW, iconH, title, desc, minusMargin, difficultyText)
	iconW = SScaleMin(iconW / 3)
	iconH = SScaleMin(iconH / 3)

	local backgroundPanel = self.innerSelf:Add("DSizeToContents")
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(SScaleMin(90 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	backgroundPanel:DockMargin(padding * 2, 0, padding * 2, padding)
	backgroundPanel:SetSizeX( false )
	backgroundPanel:InvalidateLayout()
	backgroundPanel.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material(icon))
		surface.DrawTexturedRect(SScaleMin(90 / 3) * 0.5 - iconW * 0.5, h * 0.5 - iconH * 0.5, iconW, iconH)
	end

	local textPanel = backgroundPanel:Add("DSizeToContents")
	textPanel:Dock(TOP)
	textPanel:SetSizeX( false )

	local titleText = textPanel:Add("DLabel")
	titleText:SetText(title)
	titleText:SetFont("LargerTitlesFontNoClamp")
	titleText:SizeToContents()
	titleText:Dock(TOP)
	titleText:SetTextColor(Color(255, 204, 0, 255))

	local descText = textPanel:Add("DLabel")
	descText:SetText(desc)
	descText:SetFont("MenuFontNoClamp")
	descText:SetWrap(true)
	descText:SetAutoStretchVertical(true)
	descText:Dock(TOP)

	if difficultyText then
		local textDifficulty = textPanel:Add("DLabel")
		textDifficulty:Dock(TOP)
		textDifficulty:SetText(difficultyText)
		textDifficulty:SetFont("MenuFontNoClamp")
		textDifficulty:SetWrap(true)
		textDifficulty:SetAutoStretchVertical(true)
		textDifficulty:DockMargin(0, SScaleMin(10 / 3), 0, 0)

		if string.match(difficultyText, "Hard") then
			textDifficulty:SetTextColor(Color(255, 78, 69, 255))
		elseif string.match(difficultyText, "This background starts with no CID.") then
			textDifficulty:SetTextColor(Color(236, 218, 101, 255))
		else
			textDifficulty:SetTextColor(Color(101, 235, 130, 255))
		end
	end
end

function PANEL:CreateAttribute(icon, wIcon, hIcon, title, attribute)
	wIcon, hIcon = SScaleMin(wIcon / 3), SScaleMin(hIcon / 3)

	local attributePanel = self.innerSelf:Add("Panel")
	attributePanel:Dock(TOP)
	attributePanel:DockMargin(padding * 2, 0, padding * 2, padding)
	attributePanel:SetTall(SScaleMin(105 / 3))
	attributePanel.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(Material(icon))
		surface.DrawTexturedRect(SScaleMin(90 / 3) * 0.5 - wIcon * 0.5, SScaleMin(105 / 3) * 0.5 - hIcon * 0.5, wIcon, hIcon)
	end

	local textPanel = attributePanel:Add("Panel")
	textPanel:Dock(LEFT)
	textPanel:DockMargin(SScaleMin(90 / 3), 0, 0, 0)
	textPanel:SetSize(SScaleMin(460 / 3) - (SScaleMin(50 / 3) + wIcon) - (SScaleMin(15 / 3) + SScaleMin(50 / 3)), SScaleMin(105 / 3))

	local titleText = textPanel:Add("DLabel")
	titleText:SetText(string.utf8upper(title))
	titleText:SetFont("LargerTitlesFontNoClamp")
	titleText:SetPos(0, textPanel:GetTall() * 0.5 - SScaleMin(13 / 3))
	titleText:SizeToContents()
	titleText:SetContentAlignment(4)
	titleText:SetTextColor(Color(255, 204, 0, 255))

	local attributePointsPanel = attributePanel:Add("Panel")
	attributePointsPanel:Dock(RIGHT)
	attributePointsPanel:DockMargin(0, 0, SScaleMin(25 / 3), 0)
	attributePointsPanel:SetSize(SScaleMin(15 / 3), SScaleMin(105 / 3))

	local attributePoint = attributePointsPanel:Add("DLabel")
	attributePoint:SetFont("LargerTitlesFontNoClamp")
	attributePoint:SetPos(0, attributePointsPanel:GetTall() * 0.5 - SScaleMin(13 / 3))
	attributePoint:SetText(self.data.special[attribute] or "0")
	attributePoint:SetContentAlignment(6)
	attributePoint:SizeToContents()
end

vgui.Register("GamemasterTools", PANEL, "EditablePanel")