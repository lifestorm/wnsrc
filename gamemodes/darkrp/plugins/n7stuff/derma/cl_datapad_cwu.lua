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

local materialMainframe = ix.util.GetMaterial("willardnetworks/datafile/mainframe.png")
local materialGadgetlight = ix.util.GetMaterial("willardnetworks/datafile/gadgetlight.png")
local materialDataBackground = ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow.png")

local color_blueDark = Color(40, 88, 115, 75)
local color_blueLight = Color(41, 243, 229, 255)
local color_gray = Color(154, 169, 175, 255)

local font = "MenuFontNoClamp"

local dateFormat = "%d/%m/%Y"

local animationSpeed = {
	[true] = 1,
	[false] = 0.5
}

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:MakePopup()
	Schema:AllowMessage(self)
	self.outputHeight = 0
	self.dividerWide = 0

	local mainFrame = self:Add("EditablePanel")
	mainFrame:SetSize(SScaleMin(645 / 3), SScaleMin(850 / 3))
	mainFrame:Center()
	mainFrame.Paint = function(this, with, height)
		surface.SetDrawColor(color_white:Unpack())
		surface.SetMaterial(materialMainframe)
		surface.DrawTexturedRect(0, 0, with, height)
	end

	local close = self:Add("DButton")
	close:SetSize(SScaleMin(107 / 3), SScaleMin(105 / 3))
	close:SetPos(self:GetWide() * 0.5 + mainFrame:GetWide() * 0.5 - close:GetWide() * 0.6, self:GetTall() * 0.5 - mainFrame:GetTall() * 0.5 - close:GetTall() * 0.4)
	close:SetText("")
	close.Paint = function(this, with, height)
		if this:IsHovered() then
			surface.SetDrawColor(ColorAlpha(color_white, 50))
			surface.SetMaterial(materialGadgetlight)
			surface.DrawTexturedRect(0, 0, with, height)
		end
	end

	close.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/close.wav")
		self:Remove()
	end

	local subFrame = self:Add("EditablePanel")
	subFrame:SetSize(mainFrame:GetWide() * 0.8, mainFrame:GetTall() * 0.5)
	subFrame:Center()
	subFrame:SetPos(subFrame.x, subFrame.y - SScaleMin(105 / 3))

	self.dataSearch = subFrame:Add("ixDatapadSearchProfiles")
	self.dataSearch.sendData = function(this, text)
		self:UpdateStatus(L"pdaDatafile_search", "Warning")

		net.Start("ixDataFilePDA_CWU_RequestData")
			net.WriteString(text)
		net.SendToServer()
	end

	self.dataSearch:GetChildren()[1]:GetChildren()[3]:Clear()
	self.dataSearch:GetChildren()[3]:GetChildren()[2].OnEnter = function(this)
		if (ix.config.Get("datafileNoConnection")) then
			LocalPlayer():NotifyLocalized("Error: no connection!")
			surface.PlaySound("hl1/fvox/buzz.wav")
			self.dataSearch.noConnection2:SetVisible(true)
			return
		end
		if self.outputFrame.inProgress then return end

		surface.PlaySound("willardnetworks/datapad/navigate.wav")

		if self.outputFrame.isOpen then
			self:UpdateStatus(L"pdaDatafile_search", "Warning")

			return self:SetOutputDataHeight(0, false, function(isOpen)
				self.dataSearch:sendData(this:GetValue())
			end)
		end

		self.dataSearch:sendData(this:GetValue())
	end

	self.dividerLine = self.dataSearch:Add("DShape")
	self.dividerLine:SetType( "Rect" )
	self.dividerLine:SetSize(self.dividerWide, SScaleMin(1 / 3))
	self.dividerLine:SetPos(0, self.dataSearch:GetTall() - self.dividerLine:GetTall())
	self.dividerLine:SetColor(color_blueLight)

	self.status = self.dataSearch:GetChildren()[1]:GetChildren()[3]:Add("DLabel")
	self:UpdateStatus(L"pdaDatafile_waiting", "Info")

	self:InvalidateLayout(true)

	self.outputFrame = self:Add("EditablePanel")
	self.outputFrame:SetSize(subFrame:GetWide(), self.outputHeight)
	self.outputFrame:SetPos(subFrame.x, self.dataSearch:GetTall() + subFrame.y)
	self.outputFrame.isOpen = false
	self.outputFrame.inProgress = false
	self.outputFrame.Paint = function(this, width, height)
		surface.SetDrawColor(color_blueDark)
		surface.DrawRect(0, 0, width, height)
	end

	self.outputScroll = self.outputFrame:Add("DScrollPanel")
	self.outputScroll:Dock(FILL)
	self.outputScroll:DockMargin(SScaleMin(2 / 3), SScaleMin(2 / 3), SScaleMin(2 / 3), SScaleMin(2 / 3))
	self.outputScroll.alphaOffset = 0.125

	net.Receive("ixDataFilePDA_CWU_CheckData", function(_, client)
		local length = net.ReadUInt(32)
		local data = net.ReadData(length)
		local uncompressed = util.Decompress(data)

		if (!uncompressed) then
			return self:UpdateStatus("Unable to decompress data", "Error")
		end

		local output = util.JSONToTable(uncompressed)

		self:UpdateStatus(output.status[1], output.status[2])

		if output.id then
			output.status = nil

			self:SetOutputDataHeight(SScaleMin(48 / 3) * 8 + SScaleMin(20 / 3), true)

			self.outputScroll:Clear()
			self:OnGetData(output)
		end
	end)
end

local function AddAdditionalInfo(basePanel, title, subtitle)
	local top = basePanel:Add("DLabel")
	top:SetTextColor(color_gray)
	top:SetFont(font)
	top:SetText(title:utf8upper()..":")
	top:SizeToContents()
	top:SetPos(basePanel:GetWide() - top:GetWide() - SScaleMin(32 / 3), basePanel:GetTall() * 0.2 - top:GetTall() * 0.2)

	local bottom = basePanel:Add("DLabel")
	bottom:SetTextColor(color_blueLight)
	bottom:SetFont(font)
	bottom:SetText(subtitle:utf8upper())
	bottom:SizeToContents()
	bottom:SetPos(basePanel:GetWide() - bottom:GetWide() - SScaleMin(32 / 3), basePanel:GetTall() - bottom:GetTall() - SScaleMin(4 / 3))
end

local function addInfo(basePanel, title, subtitle, additionalTitle, additionalSubtitle)
	subtitle, additionalSubtitle = tostring(subtitle), tostring(additionalSubtitle)

	local plugin = ix.plugin.Get("combineutilities")

	local panel = basePanel:Add("EditablePanel")
	panel:SetSize(basePanel:GetWide(), SScaleMin(48 / 3))
	panel:Dock(TOP)
	panel:DockMargin(0, 1, 0, 1)
	panel:SetAlpha(0)
	panel:AlphaTo(255, 1, basePanel.alphaOffset)

	plugin:CreateRow(panel, title, subtitle)

	panel.Paint = function(this, width, height)
		surface.SetDrawColor(ColorAlpha(color_white, 50))
		surface.SetMaterial(materialDataBackground)
		surface.DrawTexturedRect(0, 0, width, height)
	end

	if additionalTitle then
		AddAdditionalInfo(panel, additionalTitle, additionalSubtitle)
	end

	basePanel.alphaOffset = basePanel.alphaOffset + 0.125

	return panel
end

function PANEL:OnGetData(data)
	self.outputScroll.alphaOffset = 0.125

	local anticitizen = addInfo(self.outputScroll, L("pdaDatafile_data_anticitizen"), data.anticitizen, L("pdaDatafile_data_bol"), data.bol)

	if data.anticitizen or data.bol then
		local color = data.anticitizen and derma.GetColor("Error", anticitizen) or derma.GetColor("Warning", anticitizen)

		local oldPaint = anticitizen.Paint
		anticitizen.Paint = function(this, width, height)
			surface.SetDrawColor(ColorAlpha(color, 69))
			surface.DrawRect(0, 0, width, height)

			oldPaint(this, width, height)
		end
	end

	local permits = addInfo(self.outputScroll, L("pdaDatafile_data_permits"), "")
	permits.oldHeight = permits:GetTall()
	permits.newHeight = 0

	local permitsButton = permits:Add("DButton")
	permitsButton:SetTextColor(color_blueLight)
	permitsButton:SetFont(font)
	permitsButton:SetText(L("pdaDatafile_data_permits_buttonShow"):utf8upper())
	permitsButton:SizeToContentsY()
	permitsButton:SetWide(permits:GetWide() - SScaleMin(24 / 3))
	permitsButton:SetPos(SScaleMin(4 / 3), permits:GetTall() - permitsButton:GetTall() - SScaleMin(4 / 3))
	permitsButton.isOpen = false
	permitsButton.inProgress = false
	permitsButton._SetHeight = function(this, height)
		this.inProgress = true

		permits:CreateAnimation(animationSpeed[this.isOpen], {
			index = 0,
			target = { newHeight = height },
			easing = "outQuint",
			Think = function(animation, panel)
				panel:SetTall(panel.newHeight)
			end,
			OnComplete = function(animation, panel)
				permitsButton.inProgress = false
			end
		})
	end

	local permitsPanel = permits:Add("EditablePanel")
	permitsPanel:SetWide(permits:GetWide())
	permitsPanel:SetTall(0)
	permitsPanel:SetPos(0, permitsButton.y + permitsButton:GetTall())

	local y = SScaleMin(8 / 3)

	for k, _ in pairs(ix.permits.list) do
		if data.permits[k] then
			local left = permitsPanel:Add("DLabel")
			left:SetTextColor(color_gray)
			left:SetFont(font)
			left:SetText(k:utf8upper())
			left:SizeToContents()
			left:SetPos(SScaleMin(20 / 3), y)

			local right = permitsPanel:Add("DLabel")
			right:SetTextColor(color_blueLight)
			right:SetFont(font)
			right:SetText(isbool(data.permits[k]) and L("pdaDatafile_data_permitsUnlimited"):utf8upper() or os.date(dateFormat, data.permits[k]))
			right:SizeToContents()
			right:SetPos(permitsPanel:GetWide() - right:GetWide() - SScaleMin(32 / 3), y)

			y = y + left:GetTall() + SScaleMin(8 / 3)
		end
	end

	permitsPanel:SetTall(y)

	permitsButton.permitsTall = permits.oldHeight + y
	permitsButton.DoClick = function(this, width, height)
		if this.inProgress then return end

		surface.PlaySound("willardnetworks/datapad/navigate2.wav")

		this.isOpen = !this.isOpen

		local translate = this.isOpen and "pdaDatafile_data_permits_buttonHide" or "pdaDatafile_data_permits_buttonShow"

		this:SetText(L(translate):utf8upper())
		this:_SetHeight(this.isOpen and this.permitsTall or permits.oldHeight)
	end

	permitsButton.Paint = function(this, width, height)
		local alpha = this:IsHovered() and 125 or 69

		surface.SetDrawColor(ColorAlpha(color_white, alpha))
		surface.SetMaterial(materialDataBackground)
		surface.DrawTexturedRect(0, 0, width, height)
	end
end

function PANEL:UpdateStatus(text, color)
	if color == "Error" then
		surface.PlaySound("willardnetworks/datapad/deny.wav")
	end

	self.status:SetFont(font)
	self.status:SetTextColor(derma.GetColor(color, self.status))
	self.status:SetText(text:utf8upper())
	self.status:SizeToContents()
	self.status:Dock(RIGHT)
	self.status:DockMargin(0, 0, SScaleMin(4 / 4), SScaleMin(6 / 3))
end

function PANEL:SetOutputDataHeight(height, boolean, callback)
	local dataSearchWide = self.dataSearch:GetWide()

	self.outputFrame.inProgress = true

	self:CreateAnimation(animationSpeed[boolean], {
		index = -1,
		target = { outputHeight = height, dividerWide = boolean and dataSearchWide or 0 },
		easing = "outQuint",
		Think = function(animation, panel)
			panel.outputFrame:SetTall(panel.outputHeight)
			panel.dividerLine:SetWide(panel.dividerWide)
		end,
		OnComplete = function(animation, panel)
			panel.outputFrame.isOpen = boolean
			panel.outputFrame.inProgress = false

			if callback then
				callback(boolean)
			end
		end
	})
end

vgui.Register("ixDatafilePDA_CWU", PANEL, "EditablePanel")

net.Receive("ixDataFilePDA_CWU_Open", function(length, client)
	local character = LocalPlayer():GetCharacter()

	if LocalPlayer():Team() == FACTION_WORKERS or character:IsVortigaunt() and character:GetBioticPDA() == "CWU" then
		if IsValid(ix.gui.menu) then
			ix.gui.menu:Remove()
		end

		surface.PlaySound("willardnetworks/datapad/open.wav")
		vgui.Create("ixDatafilePDA_CWU")
	end
end)
