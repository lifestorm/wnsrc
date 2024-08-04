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
	ix.gui.mainMenuManager = self

    self:SetSize(SScaleMin(600 / 3), SScaleMin(500 / 3))
    self:Center()
    self:SetTitle("Main Menu Manager")
	DFrameFixer(self)

	self:CreateMain()
end

function PANEL:CreateMain()
	if !self.mainPanel or self.mainPanel and !IsValid(self.mainPanel) then
		self.mainPanel = self:Add("Panel")
		self.mainPanel:Dock(FILL)
	end

	for _, v in pairs(self.mainPanel:GetChildren()) do
		if IsValid(v) then
			v:Remove()
		end
	end

	self.backgrounds = self.mainPanel:Add("DButton")
	self:CreateButton(self.backgrounds, "Backgrounds")
	self.backgrounds.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self.buttonOptions:Remove()
		self.logoOptions:Remove()
		self.backgrounds:Remove()

		self:CreateBackgroundsPanel()
	end

	local infoText1 = "Relative to materials/willardnetworks/, must be png, only write the name of the file "
	local infoText2 = "without .png extension. e.g. 'wn_logo_base'."
	local infoText = infoText1..infoText2

	self.logoOptions = self.mainPanel:Add("DButton")
	self:CreateButton(self.logoOptions, "Logo Options")
	self.logoOptions.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")

		Derma_Query("Set Logo Options", "Width/Height/Path",
			"Use Standard WN Logo", function()
				net.Start("SetMainMenuLogo")
				net.SendToServer()
			end,

			"Set Custom Logo", function ()
				Derma_StringRequest("Set Custom Logo Path", infoText, "", function(path)
					Derma_StringRequest("Set Custom Logo Width", "In pixels.", "", function(width)
						Derma_StringRequest("Set Custom Logo Height", "In pixels.", "", function(height)
							local logoTable = { path, width, height }
							net.Start("SetMainMenuLogo")
							net.WriteTable(logoTable)
							net.SendToServer()
						end)
					end)
				end)
			end,
			"Cancel"
		)
	end

	local options = {
		"Font Color",
		"Font Hover Color",
		"Font Locked Button Color"
	}

	self.buttonOptions = self.mainPanel:Add("DButton")
	self:CreateButton(self.buttonOptions, "Button Options")
	self.buttonOptionList = {}
	self.buttonOptions.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self.buttonOptions:Remove()
		self.logoOptions:Remove()
		self.backgrounds:Remove()
		self:CreateBackButton()

		for _, v in pairs(options) do
			local buttonOption = self.mainPanel:Add("DButton")
			self:CreateButton(buttonOption, v)

			buttonOption.colorPicker = buttonOption:Add("ixSettingsRowColor")
			buttonOption.colorPicker:Dock(RIGHT)
			buttonOption.colorPicker:DockMargin(0, 0, SScaleMin(10 / 3), 0)
			buttonOption.colorPicker:SetText("")

			buttonOption.colorPicker.OnValueChanged = function(panel, color)
				self:UpdateButtonColorsToServer()
			end

			net.Start("RequestMainMenuInfo")
			net.SendToServer()

			buttonOption.DoClick = function()
				buttonOption.colorPicker:OpenPicker()
			end

			self.buttonOptionList[v] = buttonOption
		end
	end
end

function PANEL:UpdateButtonColorsToServer()
	local colorTable = {
		["Font Color"] = self.buttonOptionList["Font Color"].colorPicker:GetValue(),
		["Font Hover Color"] = self.buttonOptionList["Font Hover Color"].colorPicker:GetValue(),
		["Font Locked Button Color"] = self.buttonOptionList["Font Locked Button Color"].colorPicker:GetValue()
	}

	net.Start("SetMainMenuButtonColors")
	net.WriteTable(colorTable)
	net.SendToServer()
end

function PANEL:PopulateColors(colors)
	for type, color in pairs(colors) do
		if !self.buttonOptionList[type] then continue end
		if !self.buttonOptionList[type].colorPicker then continue end

		self.buttonOptionList[type].colorPicker:SetValue(color)
	end
end

function PANEL:CreateBackgroundsPanel()
	self:CreateBackButton()

	local addBackground = self.mainPanel:Add("DButton")
	self:CreateButton(addBackground, "Add Background")

	local infoText1 = "Relative to materials/willardnetworks/backgrounds/, must be jpg, only write the name of the file without "
	local infoText2 = ".jpg extension. e.g. 'city_bg'."
	local infoText = infoText1..infoText2

	addBackground.DoClick = function()
		Derma_StringRequest("Add background", infoText, "", function(text)
			net.Start("AddMainMenuBackground")
			net.WriteString(text)
			net.SendToServer()
		end)
	end

	self:CreateNote("Path relative to materials/willardnetworks/backgrounds/")

	self.backgroundList = self.mainPanel:Add("DListView")
	self.backgroundList:Dock(FILL)
	self.backgroundList:DockMargin(4, 4, 4, 4)
	self.backgroundList:AddColumn("Path (right click on rows for options)")
	self.backgroundList:SetHeaderHeight(SScaleMin(16 / 3))
	self.backgroundList:SetDataHeight(SScaleMin(17 / 3))

	net.Start("RequestMainMenuInfo")
	net.SendToServer()

	self.backgroundList.OnRowRightClick = function(list, lineId, line)
		local dmenu = DermaMenu()
		dmenu:MakePopup()
		dmenu:SetPos(input.GetCursorPos())

		dmenu:AddOption("Remove", function()
			net.Start("RemoveMainMenuBackground")
			net.WriteString(line:GetValue(1))
			net.SendToServer()
		end)

		for _, v in pairs(dmenu:GetChildren()[1]:GetChildren()) do
			v:SetFont("MenuFontNoClamp")
		end
	end
end

function PANEL:PopulateBackgroundList(table)
	if !self.backgroundList then return end
	if self.backgroundList and !IsValid(self.backgroundList) then return end

	self.backgroundList:Clear()

	for _, name in pairs(table) do
		self.backgroundList:AddLine(name)
	end
end

function PANEL:CreateNote(text)
	local note = self.mainPanel:Add("DLabel")

	note:SetFont("TitlesFontNoClamp")
	note:Dock(TOP)
	note:DockMargin(SScaleMin(10 / 3), SScaleMin(10 / 3), 0, SScaleMin(10 / 3))
	note:SetText(text)
	note:SetContentAlignment(4)
	note:SizeToContents()

	return note
end

function PANEL:CreateBackButton()
	self.back = self.mainPanel:Add("DButton")
	self:CreateButton(self.back, "Back")
	self.back.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:CreateMain()
	end
end

function PANEL:CreateButton(name, text)
	name:SetSize(SScaleMin(480 / 3), SScaleMin(46 / 3))
	name:SetContentAlignment(4)
	name:SetTextInset(SScaleMin(20 / 3), 0)
	name:Dock(TOP)
	name:SetFont("TitlesFontNoClamp")
	name:DockMargin(0, 0, 0, SScaleMin(9 / 3))
	name:SetText(text)
end

vgui.Register("MainMenuManager", PANEL, "DFrame")