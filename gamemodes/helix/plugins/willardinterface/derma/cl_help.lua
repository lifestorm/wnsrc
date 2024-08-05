--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local backgroundColor = Color(0, 0, 0, 66)
local titlePushDown = 30

local PANEL = {}

AccessorFunc(PANEL, "maxWidth", "MaxWidth", FORCE_NUMBER)

function PANEL:Init()

	self:SetWide(SScaleMin(180 / 3))
	self:Dock(LEFT)

	self.maxWidth = ScrW() * 0.2
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(backgroundColor)
	surface.DrawRect(0, 0, width, height)
end

function PANEL:SizeToContents()
	local width = 0

	for _, v in ipairs(self:GetChildren()) do
		width = math.max(width, v:GetWide())
	end

	self:SetSize(math.max(SScaleMin(32 / 3), math.min(width, self.maxWidth)), self:GetParent():GetTall())
end

vgui.Register("ixHelpMenuCategories", PANEL, "EditablePanel")

-- help menu
PANEL = {}

function PANEL:Init()
	local titlePushDown = SScaleMin(30 / 3)
	local topPushDown = SScaleMin(150 / 3)
	local scale780 = SScaleMin(780 / 3)
	local scale120 = SScaleMin(120 / 3)

	self:SetWide(ScrW() - (topPushDown * 2))

	local sizeXtitle, sizeYtitle = self:GetWide(), scale120
	local sizeXcontent, sizeYcontent = self:GetWide(), (scale780)

	self.titlePanel = self:Add("Panel")
	self.titlePanel:SetSize(sizeXtitle, sizeYtitle)
	self.titlePanel:SetPos(self:GetWide() * 0.5 - self.titlePanel:GetWide() * 0.5)

	self:CreateTitleText()

	self.contentFrame = self:Add("Panel")
	self.contentFrame:SetSize(sizeXcontent, sizeYcontent)
	self.contentFrame:SetPos(self:GetWide() * 0.5 - self.contentFrame:GetWide() * 0.5, titlePushDown)

	self:SetTall(scale120 + scale780 + titlePushDown)
	self:Center()

	self.categories = {}
	self.categorySubpanels = {}
	self.categoryPanel = self.contentFrame:Add("ixHelpMenuCategories")

	self.canvasPanel = self.contentFrame:Add("EditablePanel")
	self.canvasPanel:Dock(FILL)

	self.idlePanel = self.canvasPanel:Add("Panel")
	self.idlePanel:Dock(FILL)
	self.idlePanel:DockMargin(SScaleMin(8 / 3), 0, 0, 0)

	self.idlePanel.Paint = function(_, width, height)
		local curTime = CurTime()

		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, width, height)

		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/wn_logo_base.png"))
		surface.DrawTexturedRect(width * 0.5 - SScaleMin(195 / 3) * 0.5, height * 0.5 - SScaleMin(196 / 3) * 0.5, SScaleMin(195 / 3), SScaleMin(196 / 3))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/wn_logo_circle1.png"))
		surface.DrawTexturedRectRotated((width * 0.5) + 2, (height * 0.5) - 2, SScaleMin(195 / 3), SScaleMin(196 / 3), curTime * -15)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/wn_logo_circle2.png"))
		surface.DrawTexturedRectRotated((width * 0.5) - 2, (height * 0.5) + 2, SScaleMin(195 / 3), SScaleMin(196 / 3), curTime * -15)
	end

	local categories = {}
	hook.Run("PopulateHelpMenu", categories)

	for k, v in SortedPairs(categories) do
		if (!isstring(k)) then
			ErrorNoHalt("expected string for help menu key\n")
			continue
		elseif (!isfunction(v)) then
			ErrorNoHalt(string.format("expected function for help menu entry '%s'\n", k))
			continue
		end

		self:AddCategory(k)
		self.categories[k] = v
	end

	self.categoryPanel:SizeToContents()

	if (ix.gui.lastHelpMenuTab) then
		self:OnCategorySelected(ix.gui.lastHelpMenuTab)
	end
end

function PANEL:AddCategory(name)
	local button = self.categoryPanel:Add("ixMenuButton")
	button:SetText(L(name))
	if (L(name)) == "credits" then
		button:SetText("Credits")
	end
	-- @todo don't hardcode this but it's the only panel that needs docking at the bottom so it'll do for now
	button:Dock(name == "credits" and BOTTOM or TOP)
	button.DoClick = function()
		self:OnCategorySelected(name)
	end

	local panel = self.canvasPanel:Add("DScrollPanel")
	panel:SetVisible(false)
	panel:Dock(FILL)
	panel:DockMargin(SScaleMin(8 / 3), 0, 0, 0)
	panel:GetCanvas():DockPadding(SScaleMin(8 / 3), SScaleMin(8 / 3), SScaleMin(8 / 3), SScaleMin(8 / 3))

	panel.Paint = function(_, width, height)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, width, height)
	end

	-- reverts functionality back to a standard panel in the case that a category will manage its own scrolling
	panel.DisableScrolling = function()
		panel:GetCanvas():SetVisible(false)
		panel:GetVBar():SetVisible(false)
		panel.OnChildAdded = function() end
	end

	self.categorySubpanels[name] = panel
end

function PANEL:OnCategorySelected(name)
	local panel = self.categorySubpanels[name]

	if (!IsValid(panel)) then
		return
	end

	if (!panel.bPopulated) then
		self.categories[name](panel)
		panel.bPopulated = true
	end

	if (IsValid(self.activeCategory)) then
		self.activeCategory:SetVisible(false)
	end

	panel:SetVisible(true)
	self.idlePanel:SetVisible(false)

	self.activeCategory = panel
	ix.gui.lastHelpMenuTab = name
end

function PANEL:CreateTitleText()
	local informationTitleIcon = self.titlePanel:Add("DImage")
	informationTitleIcon:SetImage("willardnetworks/tabmenu/navicons/info.png")
	informationTitleIcon:SetSize(SScaleMin(17 / 3), SScaleMin(17 / 3))

	local informationTitle = self.titlePanel:Add("DLabel")
	informationTitle:SetFont("TitlesFontNoClamp")
	informationTitle:SetText("Information")
	informationTitle:SizeToContents()
	informationTitle:SetPos(SScaleMin(28 / 3), informationTitleIcon:GetTall() * 0.5 - informationTitle:GetTall() * 0.5)
end

vgui.Register("ixHelpMenu", PANEL, "EditablePanel")

hook.Add("CreateMenuButtons", "ixHelpMenu", function(tabs)
	tabs["Information"] = {

		RowNumber = 4,

		Width = 17,

		Height = 17,

		Icon = "willardnetworks/tabmenu/navicons/info.png",

		Create = function(info, container)
			local helpMenu = container:Add("ixHelpMenu")
		end
	}
end)

hook.Add("PopulateHelpMenu", "ixHelpMenu", function(tabs)
	tabs["commands"] = function(container)
		-- info text
		local info = container:Add("DLabel")
		info:SetFont("MenuFontLargerNoClamp")
		info:SetText(L("helpCommands"))
		info:SetContentAlignment(5)
		info:SetTextColor(color_white)
		info:SetExpensiveShadow(1, color_black)
		info:Dock(TOP)
		info:DockMargin(0, 0, 0, SScaleMin(8 / 3))
		info:SizeToContents()
		info:SetTall(info:GetTall() + SScaleMin(16 / 3))

		info.Paint = function(_, width, height)
			surface.SetDrawColor(Color(0, 0, 0, 50))
			surface.DrawRect(0, 0, width, height)
		end

		-- commands
		for uniqueID, command in SortedPairs(ix.command.list) do
			if (command.OnCheckAccess and !command:OnCheckAccess(LocalPlayer())) then
				continue
			end

			local bIsAlias = false
			local aliasText = ""

			-- we want to show aliases in the same entry for better readability
			if (command.alias) then
				local alias = istable(command.alias) and command.alias or {command.alias}

				for _, v in ipairs(alias) do
					if (v:utf8lower() == uniqueID) then
						bIsAlias = true
						break
					end

					aliasText = aliasText .. ", /" .. v
				end

				if (bIsAlias) then
					continue
				end
			end

			-- command name
			local title = container:Add("DLabel")
			title:SetFont("TitlesFontNoBoldNoClamp")
			title:SetText("/" .. command.name .. aliasText)
			title:Dock(TOP)
			title:SetTextColor(Color(211, 86, 89, 255))
			title:SetExpensiveShadow(1, color_black)
			title:SizeToContents()

			-- syntax
			local syntaxText = command.syntax
			local syntax

			if (syntaxText != "" and syntaxText != "[none]") then
				syntax = container:Add("DLabel")
				syntax:SetFont("TitlesFontNoBoldNoClamp")
				syntax:SetText(syntaxText)
				syntax:Dock(TOP)
				syntax:SetTextColor(color_white)
				syntax:SetExpensiveShadow(1, color_black)
				syntax:SetWrap(true)
				syntax:SetAutoStretchVertical(true)
				syntax:SizeToContents()
			end

			-- description
			local descriptionText = command:GetDescription()

			if (descriptionText != "") then
				local description = container:Add("DLabel")
				description:SetFont("MenuFontLargerNoClamp")
				description:SetText(descriptionText)
				description:Dock(TOP)
				description:SetTextColor(color_white)
				description:SetExpensiveShadow(1, color_black)
				description:SetWrap(true)
				description:SetAutoStretchVertical(true)
				description:SizeToContents()
				description:DockMargin(0, 0, 0, SScaleMin(8 / 3))
			elseif (syntax) then
				syntax:DockMargin(0, 0, 0, SScaleMin(8 / 3))
			else
				title:DockMargin(0, 0, 0, SScaleMin(8 / 3))
			end
		end
	end

	tabs["flags"] = function(container)
		-- info text
		local info = container:Add("DLabel")
		info:SetFont("MenuFontLargerNoClamp")
		info:SetText(L("helpFlags"))
		info:SetContentAlignment(5)
		info:SetTextColor(color_white)
		info:SetExpensiveShadow(1, color_black)
		info:Dock(TOP)
		info:DockMargin(0, 0, 0, SScaleMin(8 / 3))
		info:SizeToContents()
		info:SetTall(info:GetTall() + SScaleMin(16 / 3))

		info.Paint = function(_, width, height)
			surface.SetDrawColor(Color(0, 0, 0, 50))
			surface.DrawRect(0, 0, width, height)
		end

		-- flags
		for k, v in SortedPairs(ix.flag.list) do
			local background = ColorAlpha(
				LocalPlayer():GetCharacter():HasFlags(k) and derma.GetColor("Success", info) or derma.GetColor("Error", info), 88
			)

			local panel = container:Add("Panel")
			panel:Dock(TOP)
			panel:DockMargin(0, 0, 0, SScaleMin(8 / 3))
			panel:DockPadding(SScaleMin(4 / 3), SScaleMin(4 / 3), SScaleMin(4 / 3), SScaleMin(4 / 3))
			panel.Paint = function(_, width, height)
				derma.SkinFunc("DrawImportantBackground", 0, 0, width, height, background)
			end

			local flag = panel:Add("DLabel")
			flag:SetFont("TitlesFontNoBoldNoClamp")
			flag:SetText(string.format("[%s]", k))
			flag:Dock(LEFT)
			flag:SetTextColor(color_white)
			flag:SetExpensiveShadow(1, color_black)
			flag:SetTextInset(SScaleMin(4 / 3), 0)
			flag:SizeToContents()
			flag:SetTall(flag:GetTall() + SScaleMin(8 / 3))

			local description = panel:Add("DLabel")
			description:SetFont("TitlesFontNoBoldNoClamp")
			description:SetText(v.description)
			description:Dock(FILL)
			description:SetTextColor(color_white)
			description:SetExpensiveShadow(1, color_black)
			description:SetTextInset(SScaleMin(8 / 3), 0)
			description:SizeToContents()
			description:SetTall(description:GetTall() + SScaleMin(8 / 3))

			panel:SizeToChildren(false, true)
		end
	end
end)
