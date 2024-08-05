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

local titlePushDown = SScaleMin(85 / 3)
local fixHeight = SScaleMin(55 / 3)
local scale780 = SScaleMin(780 / 3)
local scale120 = SScaleMin(120 / 3)

function PANEL:Init()
	ix.gui.skills = self

	local margin = SScaleMin(10 / 3)
	local topPushDown = SScaleMin(150 / 3)

	self:SetWide(ScrW() - (topPushDown * 2))

	local sizeXtitle, sizeYtitle = self:GetWide(), scale120
	local sizeXcontent, sizeYcontent = self:GetWide(), (scale780) - fixHeight

	self.titlePanel = self:Add("Panel")
	self.titlePanel:SetSize(sizeXtitle, sizeYtitle)
	self.titlePanel:SetPos(self:GetWide() * 0.5 - self.titlePanel:GetWide() * 0.5)

	self.contentPanel = self:Add("Panel")
	self.contentPanel:SetSize(sizeXcontent, sizeYcontent)
	self.contentPanel:SetPos(self:GetWide() * 0.5 - self.contentPanel:GetWide() * 0.5, titlePushDown)

	self:SetTall(scale120 + scale780 - fixHeight + titlePushDown)
	self:Center()

	local skillsIcon = self.titlePanel:Add("DImage")
	skillsIcon:SetImage("willardnetworks/tabmenu/navicons/crafting.png")
	skillsIcon:SetSize(SScaleMin(18 / 3), SScaleMin(18 / 3))
	skillsIcon:SetPos(0, SScaleMin(3 / 3))

	local skillsTitle = self.titlePanel:Add("DLabel")
	skillsTitle:SetFont("TitlesFontNoClamp")
	skillsTitle:SetText(LocalPlayer():Name() .. "'s Skills")
	skillsTitle:SetPos(SScaleMin(26 / 3))
	skillsTitle:SizeToContents()

	local skillsDesc = self.titlePanel:Add("DLabel")
	skillsDesc:SetFont("MenuFontLargerNoClamp")
	skillsDesc:SetText("Remember that the maximum combined skill level is " .. ix.config.Get("MaxTotalSkill", 0) .. ".")
	skillsDesc:SetTextColor(Color(200, 200, 200, 255))
	skillsDesc:SetPos(0, SScaleMin(25 / 3) + margin * 0.7)
	skillsDesc:SizeToContents()

	local skillsDesc2 = self.titlePanel:Add("DLabel")
	skillsDesc2:SetFont("MenuFontLargerBoldNoFix")
	skillsDesc2:SetTextColor(Color(255, 78, 69, 255))
	skillsDesc2:SetText("Skill levels: " .. LocalPlayer():GetCharacter():GetTotalSkillLevel() .. "/" .. ix.config.Get("MaxTotalSkill", 0))
	skillsDesc2:SetPos(0, SScaleMin(42 / 3) + margin * 0.7)
	skillsDesc2:SizeToContents()

	self:CreateAttributesPanel()

	self.panels = {}

	hook.Run("CreateSkillPanels", self.panels) -- Create subpanels for example Crafting

	self:CreateSkills()
end

function PANEL:CreateSkills()
	if (self.skillPanels) then
		for _, v in ipairs(self.skillPanels) do
			v:Remove()
		end
	end

	self.skillPanels = {}

	local character = LocalPlayer():GetCharacter()

	self.skillGrid = self.contentPanel:Add("DGrid")
	self.skillGrid:Dock(FILL)
	self.skillGrid:SetCols( 3 )
	self.skillGrid:SetColWide( self.contentPanel:GetWide() / 3 )
	self.skillGrid:SetRowHeight( self.contentPanel:GetTall() / 3 )

	for skillID, skillInfo in SortedPairs(ix.skill.list) do
		if character:GetFaction() != FACTION_VORT and skillInfo.name == "Vortessence" then
			continue
		end

		self.skillPanels[skillID] = self:CreateSkillPanel(skillID, skillInfo)
	end
end

function PANEL:CreateSkillPanel(skillID, skillInfo)
	local bottomPanelH = SScaleMin(35 / 3)
	local character = LocalPlayer():GetCharacter()

	local skillPanel = vgui.Create("Panel")
	skillPanel:SetSize((self.contentPanel:GetWide() / 3) - SScaleMin(10 / 3), (self.contentPanel:GetTall() / 3) - SScaleMin(10 / 3))
	skillPanel:Center()
	skillPanel.Paint = function(_, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial(skillInfo.image))
		surface.DrawTexturedRect(0, 0, w, h - bottomPanelH)

		surface.SetDrawColor(ColorAlpha(color_black, 100))
		surface.DrawRect(0, h - bottomPanelH, w, bottomPanelH)

		surface.SetDrawColor(Color(116, 113, 130, 255))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.DrawLine(0, h - bottomPanelH, w, h - bottomPanelH)
	end

	-- Bottom Panel
	local dPadding = SScaleMin(5 / 3)
	local bottomPanel = skillPanel:Add("Panel")
	bottomPanel:Dock(BOTTOM)
	bottomPanel:SetTall(bottomPanelH)

	local skillName = bottomPanel:Add("DLabel")
	self:CreateSkillLabel(skillName, skillInfo.name, "TitlesFontNoClamp", dPadding * 4, dPadding * 2)

	skillPanel.skillLevel = bottomPanel:Add("DLabel")
	self:CreateSkillLabel(skillPanel.skillLevel, "Skill Level: " .. character:GetSkillLevel(skillID) .. "/" .. ix.skill.MAX_SKILL, "MenuFontLargerNoClamp", 0, 0, Color(255, 204, 0, 255))

	local experiencePanel = bottomPanel:Add("Panel")
	experiencePanel:Dock(RIGHT)
	experiencePanel:SetWide(SScaleMin(200 / 3))
	experiencePanel:DockMargin(dPadding * 2, dPadding, dPadding * 4, dPadding)
	experiencePanel:DockPadding(dPadding, dPadding, dPadding, dPadding)
	experiencePanel.Paint = function(_, w, h)
		surface.SetDrawColor(ColorAlpha(color_black, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(116, 113, 130, 255))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local skillProgress = math.Clamp(character:GetSkillStoredExp(skillID) / 1000, 0, 1)

	skillPanel.progressBar = experiencePanel:Add("Panel")
	skillPanel.progressBar:Dock(FILL)
	skillPanel.progressBar.progress = skillProgress
	skillPanel.progressBar.Paint = function(panel, w, h)
		surface.SetDrawColor(Color(255, 78, 70, 255))
		surface.DrawRect(0, 0, w * panel.progress, h)
	end

	skillPanel.processLabel = skillPanel.progressBar:Add("DLabel")
	skillPanel.processLabel.skillID = skillID
	skillPanel.processLabel.SetupText = function(panel, char)
		if (char:GetSkill(skillID) == ix.skill.MAX_SKILL) then
			panel:SetText("MAX LEVEL")
		elseif (char:GetTotalSkillLevel() == ix.config.Get("MaxTotalSkill")) then
			panel:SetText("MAX TOTAL LEVEL")
		elseif (char:CanLevelSkill(panel.skillID)) then
			panel:SetText("LEVEL UP")
		else
			local skillProg = math.Clamp(character:GetSkillStoredExp(panel.skillID) / 1000, 0, 1)
			panel:SetText((skillProg * 100) .. "%")
		end
	end

	skillPanel.processLabel:SetupText(character)
	skillPanel.processLabel:SetFont("MenuFontLargerNoClamp")
	skillPanel.processLabel:SetContentAlignment(5)
	skillPanel.processLabel:Dock(FILL)

	local levelUp = skillPanel.progressBar:Add("DButton")
	levelUp:Dock(FILL)
	levelUp:SetText("")
	levelUp.Paint = nil
	levelUp.DoClick = function()
		if character:CanLevelSkill(skillID) then
			surface.PlaySound("helix/ui/press.wav")

			net.Start("ixSkillLevelUp")
			net.WriteString(skillID)
			net.SendToServer()
		end
	end

	local imagePanel = skillPanel:Add("Panel")
	imagePanel:Dock(FILL)

	local boostPanel = imagePanel:Add("Panel")
	boostPanel:SetSize(skillPanel:GetWide(), skillPanel:GetTall() - bottomPanelH)
	boostPanel:DockPadding(dPadding * 4, dPadding * 3, dPadding * 4, dPadding * 4)
	boostPanel.Paint = self.CoolHover

	local skillButton = imagePanel:Add("DButton")
	skillButton:Dock(FILL)
	skillButton:SetText("")
	skillButton:DockPadding(dPadding * 4, dPadding * 4, dPadding * 4, dPadding * 4)
	skillButton.Paint = nil

	skillButton.OnCursorEntered = function()
		surface.PlaySound("helix/ui/rollover.wav")
		boostPanel.Paint = nil
	end

	skillButton.OnCursorExited = function()
		boostPanel.Paint = self.CoolHover
	end

	skillButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:OpenSkillPanel(skillInfo)
	end

	self:CreateBoostInfo(boostPanel, skillInfo)
	self:CheckForCurrent(skillInfo)

	local autoLevel = skillButton:Add("DButton")
	skillPanel.autoLevel = autoLevel

	autoLevel.autoLevel = character:GetSkillAutoLevel(skillID)
	autoLevel:Dock(BOTTOM)
	autoLevel:SetTall(SScaleMin(20 / 3))
	autoLevel:SetContentAlignment(4)
	autoLevel:SetText("Auto-Level")
	autoLevel:SetFont("MenuFontBoldNoClamp")
	autoLevel:SetTextInset(SScaleMin(30 / 3), 0)
	autoLevel:DockMargin(0, 0, skillPanel:GetWide() * 0.63, 0)
	autoLevel.Paint = function(panel, w, h)
		surface.SetDrawColor(color_white)
		surface.DrawOutlinedRect(0, 0, SScaleMin(20 / 3), h)

		if panel.autoLevel then
			surface.SetMaterial(ix.util.GetMaterial("willardnetworks/tabmenu/skills_v2/tick.png"))
			surface.DrawTexturedRect(SScaleMin(20 / 3) * 0.5 - SScaleMin(15 / 3) * 0.5, SScaleMin(20 / 3) * 0.5 - SScaleMin(10 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(11 / 3))
		end
	end

	autoLevel.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		net.Start("ixSkillSetAutoLevel")
		net.WriteString(skillID)
		net.SendToServer()

		autoLevel.autoLevel = !autoLevel.autoLevel
	end

	if skillInfo.name == "Bartering" then
		experiencePanel:SetVisible(false)
		skillPanel.skillLevel:SetText("You have " .. (istable(character:GetPermits()) and table.Count(character:GetPermits()) or "0") .. " permits active")
		skillPanel.skillLevel:SizeToContents()
		autoLevel:SetVisible(false)
	end

	self.skillGrid:AddItem( skillPanel )
	return skillPanel
end

function PANEL:OpenSkillPanel(skill)
	surface.PlaySound("helix/ui/press.wav")
	if self.panels[skill.uniqueID] then
		if (self.contentPanel) then
			self.contentPanelOriginX, self.contentPanelOriginY = self.contentPanel:GetPos()
			self.contentPanel:MoveTo(ScrW(), self.contentPanelOriginY, 1, 0)
		end

		for k, v in pairs(self.panels) do
			if k == skill.uniqueID then
				self:CreateNewContent(v, skill.uniqueID)
			end
		end
	end
end

function PANEL:CheckForCurrent(skill)
	if self.panels[skill.uniqueID] then
		if self.contentPanel then
			if LocalPlayer().lastSelectedSkill then
				if LocalPlayer().lastSelectedSkill == skill.uniqueID then
					self.contentPanelOriginX, self.contentPanelOriginY = self.contentPanel:GetPos()

					self.contentPanel:SetPos(ScrW(), self.contentPanelOriginY)

					for k, v in pairs(self.panels) do
						if k == skill.uniqueID then
							self:CreateNewContent(v, skill.uniqueID)
						end
					end
				end
			end
		end
	end
end

function PANEL.CoolHover(self, w, h)
	surface.SetDrawColor(Color(0, 0, 0, 150))
	surface.DrawRect(0, 0, w, h)
end

function PANEL:CreateBoostInfo(boostPanel, skill)
	local character = LocalPlayer():GetCharacter()
	local attributes = ix.special.list or {}
	local skillAttributes = {}

	-- Find the attributes that boost the skill
	for _, v in pairs(attributes) do
		if v.skills then
			if v.skills[skill.uniqueID] then
				skillAttributes[v.skills[skill.uniqueID]] = v
			end
		end
	end

	if skillAttributes[2] then
		local boostedByLabel = boostPanel:Add("DLabel")
		boostedByLabel:SetText("Major boost from " .. skillAttributes[2].name)
		boostedByLabel:SetFont("MenuFontBoldNoClamp")
		boostedByLabel:SetContentAlignment(4)
		boostedByLabel:SizeToContents()
		boostedByLabel:Dock(TOP)
	end

	if skillAttributes[1] then
		local boostedByLabel = boostPanel:Add("DLabel")
		boostedByLabel:SetText("Minor boost from " .. skillAttributes[1].name)
		boostedByLabel:SetFont("MenuFontBoldNoClamp")
		boostedByLabel:SetContentAlignment(4)
		boostedByLabel:SizeToContents()
		boostedByLabel:Dock(TOP)
	end

	local varBoostLevel = character:GetSkillBoostLevels(skill.uniqueID)
	local varNeedsLevel, reducedHunger, reducedThirst, reducedGas, reducedHealth = character:GetSkillNeedsReducing(skill.uniqueID)

	if (varBoostLevel > 0) then
		-- ATLE HAPPY
		local boostedLevels = boostPanel:Add("DLabel")
		boostedLevels:Dock(TOP)
		boostedLevels:SetContentAlignment(4)
		boostedLevels:SetFont("MenuFontLargerBoldNoFix")
		boostedLevels:SetTextColor(Color(75, 238, 75))
		boostedLevels:SetText("Boosted Levels: +" .. varBoostLevel)
		boostedLevels:SizeToContents()
	end

	if (varNeedsLevel > 0) then
		if (reducedHunger) then
			local hungerReducing = boostPanel:Add("DLabel")
			hungerReducing:Dock(TOP)
			hungerReducing:SetContentAlignment(4)
			hungerReducing:SetFont("MenuFontLargerBoldNoFix")
			hungerReducing:SetTextColor(Color(238, 75, 75))
			hungerReducing:SetText("-" .. math.Round(reducedHunger, 1) .. " levels due to Hunger")
			hungerReducing:SizeToContents()
		end
		
		if (reducedThirst) then
			local thirstReducing = boostPanel:Add("DLabel")
			thirstReducing:Dock(TOP)
			thirstReducing:SetContentAlignment(4)
			thirstReducing:SetFont("MenuFontLargerBoldNoFix")
			thirstReducing:SetTextColor(Color(238, 75, 75))
			thirstReducing:SetText("-" .. math.Round(reducedThirst, 1) .. " levels due to Thirst")
			thirstReducing:SizeToContents()
		end

		if (reducedGas) then
			local gasReducing = boostPanel:Add("DLabel")
			gasReducing:Dock(TOP)
			gasReducing:SetContentAlignment(4)
			gasReducing:SetFont("MenuFontLargerBoldNoFix")
			gasReducing:SetTextColor(Color(238, 75, 75))
			gasReducing:SetText("-" .. math.Round(reducedGas, 1) .. " levels due to Spores")
			gasReducing:SizeToContents()
		end

		if (reducedHealth) then
			local healthReducing = boostPanel:Add("DLabel")
			healthReducing:Dock(TOP)
			healthReducing:SetContentAlignment(4)
			healthReducing:SetFont("MenuFontLargerBoldNoFix")
			healthReducing:SetTextColor(Color(238, 75, 75))
			healthReducing:SetText("-" .. math.Round(reducedHealth, 1) .. " levels due to Injuries")
			healthReducing:SizeToContents()
		end

		local needsReducing = boostPanel:Add("DLabel")
		needsReducing:Dock(TOP)
		needsReducing:SetContentAlignment(4)
		needsReducing:SetFont("MenuFontLargerBoldNoFix")
		needsReducing:SetTextColor(Color(238, 75, 75))
		needsReducing:SetText("Total Reduced Levels: -" .. varNeedsLevel)
		needsReducing:SizeToContents()
	end
end

function PANEL:CreateSkillLabel(parent, text, font, leftMargin, rightMargin, color)
	parent:Dock(LEFT)
	parent:SetFont(font)
	parent:SetText(text or "")
	parent:SetContentAlignment(4)
	parent:DockMargin(leftMargin, 0, rightMargin, 0)
	parent:SizeToContents()
	parent:SetTextColor(color or color_white)
end

function PANEL:CreateNewContent(v, name)
	local newContent = self:Add("Panel")
	newContent:SetSize(self.contentPanel:GetSize())
	newContent:SetPos(self:GetWide() * 0.5 - self.contentPanel:GetWide() * 0.5, titlePushDown)
	local x, y = newContent:GetPos()

	if !LocalPlayer().lastSelectedSkill then
		newContent:SetPos(0 - ScrW(), y)
		newContent:MoveTo(x, y, 1, 0)
	else
		newContent:SetPos(x, y)
	end

	LocalPlayer().lastSelectedSkill = name

	if self.chosenSkillPanel then
		self.chosenSkillPanel:Remove()
	end

	if self.backButton then
		self.backButton:Remove()
	end

	self.chosenSkillPanel = v(newContent)

	self.attributesButton:SetVisible(false)

	self.backButton = self.titlePanel:Add("DButton")
	self.backButton:Dock(RIGHT)
	self.backButton:SetText("Return to skills menu")
	self.backButton:SetFont("TitlesFontNoClamp")
	self.backButton:SetContentAlignment(6)
	self.backButton:SetAlpha(0)
	self.backButton:AlphaTo(255, 1, 0)
	self.backButton:SizeToContents()
	self.backButton:DockMargin(0, self.titlePanel:GetTall() * 0.3 - self.backButton:GetTall(), 0, self.titlePanel:GetTall() * 0.5 - self.backButton:GetTall() * 0.5)
	self.backButton.Paint = function(_, w, h) end

	self.backButton.OnCursorEntered = function()
		self.backButton:SetTextColor(Color(200, 200, 200, 255))
		surface.PlaySound("willardnetworks/charactercreation/hover.wav")
	end

	self.backButton.OnCursorExited = function()
		self.backButton:SetTextColor(Color(255, 255, 255, 255))
	end

	self.backButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self.backButton:AlphaTo(0, 1, 0, function()
			self.attributesButton:SetVisible(true)
			self.attributesButton:SetAlpha(0)
			self.attributesButton:AlphaTo(255, 0.5, 0)
		end)
		newContent:MoveTo(0 - ScrW(), y, 1, 0)
		self.contentPanel:MoveTo(self:GetWide() * 0.5 - self.contentPanel:GetWide() * 0.5, self.contentPanelOriginY, 1, 0)
		LocalPlayer().lastSelectedSkill = nil
	end
end

function PANEL:CreateAttributesPanel()
	self.attributesButton = self.titlePanel:Add("DButton")
	self.attributesButton:Dock(RIGHT)
	self.attributesButton:DockMargin(0, SScaleMin(25 / 3), 0, SScaleMin(63 / 3))
	self.attributesButton:SetText("Attribute Boosts")
	self.attributesButton:SetFont("MenuFontBoldNoClamp")
	self.attributesButton:SetWide(SScaleMin(170 / 3))
	self.attributesButton.Paint = function(_, w, h)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 1, w - 2, h - 1)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	self.attributesButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:CreateAttributePopup()
	end
end

local attributePadding = SScaleMin(10 / 3)

function PANEL:CreateAttributeBar(parent, attributeID)
	local character = LocalPlayer():GetCharacter()
	local special = tonumber(character:GetSpecial(attributeID)) or 0
	local attribute = ix.special:Find(attributeID)
	local icon = attribute.icon or ""
	local boost = tonumber(character:GetBoostedAttribute(attributeID)) or 0
	local specialBoost = character:GetSpecialBoost()[attributeID] or {}

	parent:SetTall(SScaleMin(100 / 3))
	parent:Dock(TOP)
	parent:DockMargin(attributePadding * 2, 0, attributePadding * 2, attributePadding)

	local barPanel = parent:Add("Panel")
	barPanel:Dock(TOP)
	barPanel:SetTall(SScaleMin(27 / 3))

	-- icon
	local iconImage = barPanel:Add("DImage")
	iconImage:Dock(LEFT)
	iconImage:SetWide(SScaleMin(20 / 3))
	iconImage:SetImage(icon)
	iconImage:DockMargin(0, SScaleMin(2 / 3), attributePadding * 2, SScaleMin(2 / 3))

	local backgroundBar = barPanel:Add("Panel")
	backgroundBar:Dock(FILL)
	backgroundBar.Paint = function(_, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local positivePoints = 0
	local negativePoints = 0

	for _, v in pairs(specialBoost) do
		if v.level > 0 then
			positivePoints = positivePoints + v.level
		elseif v.level < 0 then
			negativePoints = negativePoints - v.level
		end
	end

	local green = Color(138, 200, 97, 255)
	local grey = Color(200, 200, 200, 255)
	local red = Color(200, 97, 97, 255)

	local baseBar = backgroundBar:Add("Panel")
	baseBar:SetSize(SScaleMin(360 / 3), barPanel:GetTall())
	baseBar.Paint = function(_, w, h)
		if positivePoints > 0 then
			surface.SetDrawColor(green)
			surface.DrawRect(0, 0, (positivePoints + special) * (w / 10), h)
		end

		if special > 0 then
			surface.SetDrawColor(Color(200, 200, 200, 255))
			surface.DrawRect(0, 0, (special * w) / 10, h)
		end

		if negativePoints > 0 then
			surface.SetDrawColor(red)
			surface.DrawRect(math.max((positivePoints + special) - negativePoints, 0) * (w / 10), 0, negativePoints, h)
		end
	end

	local attributeAmount = barPanel:Add("DLabel")
	attributeAmount:Dock(RIGHT)
	attributeAmount:SetText(boost .. "/10")
	attributeAmount:SetTextColor((boost > special and green) or (boost < special and red) or grey)
	attributeAmount:DockMargin(attributePadding * 2 + ((boost == 10 and SScaleMin(3 / 3)) or SScaleMin(11 / 3)), 0, 0, 0)
	attributeAmount:SetFont("MenuFontNoClamp")
	attributeAmount:SizeToContents()

	if specialBoost.long then
		local level = specialBoost.long.level
		local longBoost = parent:Add("DLabel")
		longBoost:Dock(TOP)
		if (level != 0) then
			local change = level > specialBoost.long.target and "decreasing" or "increasing"
			local sign = level > 0 and "+" or ""
			longBoost:SetText(string.format("Currently %s%d food boost, %s by 1 in %d minutes", sign, level, change, specialBoost.long.time))
		elseif (specialBoost.long.time) then
			local sign = specialBoost.long.target > 0 and "+" or "-"
			longBoost:SetText(string.format("%s1 food boost becoming active in %d minutes", sign, specialBoost.long.time))
		end
		longBoost:SetContentAlignment(5)
		longBoost:SetFont("MenuFontNoClamp")
		longBoost:DockMargin(0, attributePadding, 0, attributePadding)
		longBoost:SizeToContents()
	end

	if specialBoost.short then
		local level = specialBoost.short.level
		local shortBoost = parent:Add("DLabel")
		shortBoost:Dock(TOP)
		if (level != 0) then
			local change = level > specialBoost.short.target and "decreasing" or "increasing"
			local sign = level > 0 and "+" or ""
			shortBoost:SetText(string.format("Currently %s%d drug boost, %s by 1 in %d seconds", sign, level, change, specialBoost.short.time))
		elseif (specialBoost.short.time) then
			local sign = specialBoost.short.target > 0 and "+" or "-"
			shortBoost:SetText(string.format("%s1 drug boost becoming active in %d seconds", sign, specialBoost.short.time))
		end
		shortBoost:SetContentAlignment(5)
		shortBoost:SetFont("MenuFontNoClamp")
		shortBoost:DockMargin(0, attributePadding, 0, 0)
		shortBoost:SizeToContents()
	end

	if specialBoost.neg then
		local negativeBoost = parent:Add("DLabel")
		negativeBoost:Dock(TOP)
		negativeBoost:SetText("-" .. specialBoost.neg.level .. " from hunger and thirst")
		negativeBoost:SetContentAlignment(5)
		negativeBoost:SetFont("MenuFontNoClamp")
		negativeBoost:DockMargin(0, attributePadding, 0, 0)
		negativeBoost:SizeToContents()
	end
end

function PANEL:CreateAttributePopup()
	if ix.gui.attributeFrame then
		ix.gui.attributeFrame:Remove()
	end

	ix.gui.attributeFrame = vgui.Create("Panel")
	local attributeFrame = ix.gui.attributeFrame
	attributeFrame:SetSize(SScaleMin(500 / 3), SScaleMin(507 / 3))
	attributeFrame:SetAlpha(0)
	attributeFrame:AlphaTo(255, 0.5, 0)
	attributeFrame:Center()
	attributeFrame:MakePopup()
	attributeFrame.Paint = function(panel, w, h)
		local blur = Material("pp/blurscreen")

		local x, y = panel:LocalToScreen(0, 0)
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( blur )

		for i = 1, 6 do
			blur:SetFloat( "$blur", (i / 6 ) * ( 3 ) )
			blur:Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
		end

		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	attributeFrame.Think = function()
		if !IsValid(PLUGIN.SkillsMenu) then
			ix.gui.attributeFrame:Remove()
		end

		if ix.gui.attributeFrame then
			ix.gui.attributeFrame:MoveToFront()
		end
	end

	local topbar = attributeFrame:Add("Panel")
	topbar:SetSize(attributeFrame:GetWide(), SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar:DockMargin(0, 0, 0, attributePadding)
	topbar.Paint = function( _, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("Attribute Boosts")
	titleText:DockMargin(attributePadding, 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), attributePadding, SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		if !IsValid(self) then
			return
		end

		if attributeFrame then
			attributeFrame:Remove()
		end

		surface.PlaySound("helix/ui/press.wav")
	end

	local strength = attributeFrame:Add("Panel")
	self:CreateAttributeBar(strength, "strength")

	local intelligence = attributeFrame:Add("Panel")
	self:CreateAttributeBar(intelligence, "intelligence")

	local perception = attributeFrame:Add("Panel")
	self:CreateAttributeBar(perception, "perception")

	local agility = attributeFrame:Add("Panel")
	self:CreateAttributeBar(agility, "agility")
end

vgui.Register("WNSkillPanel", PANEL, "EditablePanel")

hook.Add("CreateMenuButtons", "WNSkillPanel", function(tabs)
	tabs["skills"] = {
		RowNumber = 2,
		Width = 18,
		Height = 18,
		Icon = "willardnetworks/tabmenu/navicons/crafting.png",
		Create = function(info, container)
			if PLUGIN.SkillsMenu then
				PLUGIN.SkillsMenu:Remove()
			end

			PLUGIN.SkillsMenu = container:Add("WNSkillPanel")
		end
	}
end)
