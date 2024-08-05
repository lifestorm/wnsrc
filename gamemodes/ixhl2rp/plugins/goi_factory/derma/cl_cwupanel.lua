--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local screenMat = Material("willardnetworks/datafile/workshifterminal.png", "smooth")
local frameMat = Material("vgui/gradient-d", "smooth")
local cmbLabel = Material("willardnetworks/datafile/licensedisabled2.png", "smooth")
local cmbLogo = Material("vgui/icons/cmb_logo.png", "smooth")
local wnLogo = Material("vgui/icons/wi_logo.png", "smooth")
local defClr = Color(16, 224, 207)
local redClr = Color(200, 36, 36)
local greenClr = Color(36, 200, 61)

local PANEL = {}

AccessorFunc(PANEL, "terminalEntity", "TerminalEntity")
AccessorFunc(PANEL, "usedBy", "UsedBy")
AccessorFunc(PANEL, "userGenData", "UserGenData")
AccessorFunc(PANEL, "paralyzed", "Paralyzed")

local scrwSrn, scrhSrn = 1729, 1284

function PANEL:CreateDivider(parent, dock, bVertical)
	local divider = parent:Add("Panel")
	divider:Dock(dock)
	divider:DockMargin(8, 8, 8, 8)
	divider:SetHeight(10)
	divider.bVertical = bVertical
	divider.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		if !bVertical then
			surface.DrawLine(0, h * 0.5, w, h * 0.5)
		else
			surface.DrawLine(w * 0.5, 0, w * 0.5, h)
		end
	end

	return divider
end

function PANEL:CreateAnimatedFrame(parent, dock, dockL, dockT, dockR, dockB, frameClr, callback)
	local panel = parent:Add("Panel")
	AccessorFunc(panel, "color", "Color")

	panel:DockMargin(dockL, dockT, dockR, dockB)
	panel:Dock(dock)
	panel:InvalidateParent(true)

	panel:SetColor(frameClr)

	local wCoef = 0
	local hCoef = 0
	local anim = self:NewAnimation( 0.75, 0, -1)
	anim.Think = function( s, pnl, fraction )
		wCoef = fraction
	end
	local anim2 = self:NewAnimation( 0.8, 0.85, -1, function( s, pnl )
		if callback then
			callback()
		end
	end )
	anim2.Think = function( s, pnl, fraction )
		hCoef = fraction
	end

	panel.Paint = function(s, w, h)
		w = w * wCoef
		h = h * hCoef

		local clr = s:GetColor()
		clr.a = 100

		surface.SetDrawColor(43, 42, 42, 200)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(clr)
		surface.SetMaterial(frameMat)
		surface.DrawTexturedRect(0, h * 0.95, w, h * 0.05)

		surface.SetDrawColor(clr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	return panel
end

function PANEL:PurgeInnerContent()
	for _, pnl in pairs(self.innerContent:GetChildren()) do
		pnl:Remove()
	end
	self.currentOption = {}
end

function PANEL:CreateLock()
	self.lockPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.lockPanel) then return end

		self.lockPanel:ColorTo(redClr, 0.5)

		self:GetTerminalEntity():EmitSound("buttons/button8.wav", 55, 100, 1, nil, 0, 11)

		self.bottomWarning = self.lockPanel:Add("DLabel")
		self.bottomWarning:SetFont("WNTerminalLargeText")
		self.bottomWarning:SetText(string.utf8upper("this terminal is occupied"))
		self.bottomWarning:SetTextColor(redClr)
		self.bottomWarning:Dock(BOTTOM)
		self.bottomWarning:DockMargin(0, 0, 0, 32)
		self.bottomWarning:SetContentAlignment(5)
		self.bottomWarning:SizeToContents()
		self.bottomWarning:SetAlpha(0)

		self.warningIcon = self.lockPanel:Add("DLabel")
		self.warningIcon:SetFont("WNTerminalVeryLargeText")
		self.warningIcon:SetTextColor(redClr)
		self.warningIcon:SetText("!")
		self.warningIcon:SetContentAlignment(5)
		self.warningIcon:Center()
		self.warningIcon:SetAlpha(0)
		self.warningIcon:SizeToContents()
		self.warningIcon.Paint = function(s, w, h)
			surface.SetDrawColor(redClr)
			surface.DrawCircle(26, 133, 75)
		end

		local alphishRedClr = redClr
		alphishRedClr.a = 50
		self.upperWarning = self.lockPanel:Add("DLabel")
		self.upperWarning:Dock(TOP)
		self.upperWarning:DockMargin(1, 64, 1, 0)
		self.upperWarning:SetHeight(self:GetParent():GetTall() * 0.1)
		self.upperWarning:SetContentAlignment(5)
		self.upperWarning:SetFont("WNTerminalMediumText")
		self.upperWarning:SetText(string.utf8upper("[PLEASE BE PATIENT // WAIT FOR YOUR TURN]"))
		self.upperWarning:SetTextColor(defClr)
		self.upperWarning.Paint = function(s, w, h)
			surface.SetDrawColor(redClr)
			surface.DrawRect(0, 0, w, h)

			surface.SetMaterial(cmbLabel)
			surface.SetDrawColor(alphishRedClr)
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.upperWarning:SetAlpha(0)

		for _, child in pairs(self.lockPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:InitializeBootupSequence()
	self.wnLogo = self.innerContent:Add("Panel")
	self.wnLogo:SetSize(500, 500)
	self.wnLogo:CenterHorizontal(0.25)
	self.wnLogo:CenterVertical(0.5)
	self.wnLogo.Paint = function(s, w, h)
		surface.SetMaterial(wnLogo)
		surface.SetDrawColor(defClr)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.wnLogo:SetAlpha(0)

	self.cmbLogo = self.innerContent:Add("Panel")
	self.cmbLogo:SetSize(400, 500)
	self.cmbLogo:CenterHorizontal(0.75)
	self.cmbLogo:CenterVertical(0.5)
	self.cmbLogo.Paint = function(s, w, h)
		surface.SetMaterial(cmbLogo)
		surface.SetDrawColor(defClr)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.cmbLogo:SetAlpha(0)

	self.indicator = self.innerContent:Add("Panel")
	self.indicator:SetWide(25)
	self.indicator:SetHeight(self.innerContent:GetTall() - 2)
	self.indicator:Center()
	self.indicator:SetAlpha(0)

	local defClrAlphish = defClr
	defClrAlphish.a = 100
	self.indicator.Paint = function(s, w, h)
		surface.SetDrawColor(defClrAlphish)
		surface.DrawRect(0, 0, w, h)
	end

	for _, child in pairs(self.innerContent:GetChildren()) do
		child:AlphaTo(255, 0.25, 0, function()
			self:GetTerminalEntity():EmitSound("wn_goi/terminal_turnon.mp3", 55, 100, 1, CHAN_VOICE, 0, 11)
		end)
	end

	self.indicator:SizeTo(-1, 0, 1, 0.25, -1, function()
		self.cmbLogo:MoveTo(self.innerContent:GetWide() / 2.72, self.cmbLogo:GetY(), 1)
		self.cmbLogo:AlphaTo(0, 0.15, 0.5)
		self.wnLogo:MoveTo(self.innerContent:GetWide() / 3, self.wnLogo:GetY(), 1, 0, -1, function()
			self.wnLogo:AlphaTo(0, 0.25, 1.5, function()
				for _, child in pairs(self.innerContent:GetChildren()) do
					child:Remove()
				end
				if !self.authError then
					self:Proceed()
				else
					self:AuthError()
				end
			end)
		end)
	end)
end

function PANEL:RequestCID()
	self:PurgeInnerContent()
	self:SetParalyzed(true)
	self.cidPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.cidPanel) then return end

		for _, child in pairs(self.cidPanel:GetChildren()) do
			child:Remove()
		end

		self:GetTerminalEntity():EmitSound("buttons/combine_button1.wav", 55, 100, 1, nil, 0, 11)

		self.bottomLabel = self.cidPanel:Add("DLabel")
		self.bottomLabel:SetFont("WNTerminalLargeText")
		self.bottomLabel:SetText(string.utf8upper("insert your cid and cwu card"))
		self.bottomLabel:SetTextColor(defClr)
		self.bottomLabel:Dock(BOTTOM)
		self.bottomLabel:DockMargin(0, 0, 0, 32)
		self.bottomLabel:SetContentAlignment(5)
		self.bottomLabel:SizeToContents()
		self.bottomLabel:SetAlpha(0)

		local defClrAlphish = defClr
		defClrAlphish.a = 100
		self.upperLabel = self.cidPanel:Add("DLabel")
		self.upperLabel:Dock(TOP)
		self.upperLabel:DockMargin(1, 64, 1, 0)
		self.upperLabel:SetHeight(self:GetParent():GetTall() * 0.1)
		self.upperLabel:SetContentAlignment(5)
		self.upperLabel:SetFont("WNTerminalMediumText")
		self.upperLabel:SetText(string.utf8upper("[CID IS REQUIRED TO PROCEED // PLEASE INSERT YOUR CARD]"))
		self.upperLabel:SetTextColor(defClr)
		self.upperLabel.Paint = function(s, w, h)
			surface.SetDrawColor(self.cidPanel:GetColor())
			surface.DrawRect(0, 0, w, h)

			surface.SetMaterial(cmbLabel)
			surface.SetDrawColor(self.cidPanel:GetColor())
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.upperLabel:SetAlpha(0)

		self.cmbLogo = self.cidPanel:Add("Panel")
		self.cmbLogo:SetSize(400, 500)
		self.cmbLogo:Center()
		self.cmbLogo.Paint = function(s, w, h)
			surface.SetMaterial(cmbLogo)
			surface.SetDrawColor(self.cidPanel:GetColor())
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.cmbLogo:SetAlpha(0)

		for _, child in pairs(self.cidPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:IsCombine()
	return self:GetUserGenData() and self:GetUserGenData().combine or self:GetUserGenData() and self:GetUserGenData().isCCA or false
end

function PANEL:OnBothCardsInserted()
	if self.cidPanel then
		if (self.bottomLabel and IsValid(self.bottomLabel)) then
			self.bottomLabel:AlphaTo(0, 0.5)
		end
		if (self.upperLabel and IsValid(self.upperLabel)) then
			self.upperLabel:AlphaTo(0, 0.5)
		end

		self.cidPanel:ColorTo(greenClr, 0.5, 0, function()
			self:GetTerminalEntity():EmitSound("buttons/combine_button5.wav", 55, 100, 1, nil, 0, 11)
			self.cidPanel:AlphaTo(0, 0.5, 1, function()
				self.cidPanel:Remove()
				self:SetParalyzed(false)
			end)
		end)
	end
end

function PANEL:OnCWUCardInserted(genData)
	self.cwuCardInserted = true

	if self.cidCardInserted and self.cwuCardInserted then
		self:OnBothCardsInserted()
	end
end

function PANEL:OnCWUCardRemoved(genData)
	self.cwuCardInserted = nil

	if !self:IsCombine() then
		self:PurgeInnerContent()
		self:RequestCID()
	end
end

function PANEL:OnCIDInserted(genData)
	self:SetUserGenData(genData)
	self.cidCardInserted = true

	if self.cidCardInserted and self.cwuCardInserted or self:IsCombine() then
		self:OnBothCardsInserted()
	end
end

function PANEL:OnCIDRemoved()
	self.cidCardInserted = nil
	self:PurgeInnerContent()
	self:RequestCID()
end

function PANEL:IsUsedByLocalPlayer()
	return self:GetUsedBy() == LocalPlayer()
end

function PANEL:Init()
	self:SetSize(scrwSrn, scrhSrn)
	self:SetPos(0, 0)
	self:SetAlpha(0)

	self.innerContent = self:Add("Panel")
	self.innerContent:Dock(FILL)
	self.innerContent:DockMargin(112, 118, 112, 104)
	self.innerContent:InvalidateParent(true)

	self:SetParalyzed(true)
	self:SetPaintedManually( true )

	self.currentOption = {}
	self:SetupOptions()

	self.cart = {}
	self.savedData = {}
	self.storedCityData = {}
	self.workshiftData = {}

	self.couponList = {
		"NONE",
		"BASIC",
		"MEDIUM",
		"PRIORITY"
	}

	self.credOperationAmount = 0
	self.budgetCreds = 0
	self.selectedBudgetInteraction = "withdraw"

	self:AlphaTo(255, 0.5, 0, function()
		self:InitializeBootupSequence()
	end)
end

local function CreateButton(name, text, path, font, alignment)
	name:SetContentAlignment(alignment or 4)
	name:SetTextInset(alignment and 0 or 10, 0)
	name:SetFont(font or "WNTerminalMediumText")
	name:SetText(string.utf8upper(text))
	name.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/" .. path))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

function PANEL:RequestStock()
	net.Start("ix.terminal.GetCityStock")
		net.WriteEntity(self:GetTerminalEntity())
	net.SendToServer()
end

local backgroundColor = Color(9, 9, 9, 75)

function PANEL:CreateItemStockPositions(itemTbl)
	self.items = {}
	for itemID, itemData in pairs(itemTbl) do
		self.items[#self.items + 1] = {
			itemID = itemID,
			itemData = itemData
		}
	end
end

function PANEL:CreateNextPrev(parent, buttonMat, buttonFont, buttonAlign, prevFunc, nextFunc, bHorizontal, manualWidth)
	local nextButton = parent:Add("DButton")
	CreateButton(nextButton, "next", buttonMat, buttonFont, buttonAlign)
	nextButton.DoClick = nextFunc

	local prevButton = parent:Add("DButton")
	CreateButton(prevButton, "previous", buttonMat, buttonFont, buttonAlign)
	prevButton.DoClick = prevFunc

	if !bHorizontal then
		nextButton:Dock(TOP)
		nextButton:SetTall(parent:GetTall() / 2.1)
		nextButton:DockMargin(2, 2, 2, 2)
		prevButton:Dock(FILL)
		prevButton:DockMargin(2, 2, 2, 2)
	else
		prevButton:Dock(LEFT)
		prevButton:DockMargin(5, 5, 5, 5)
		prevButton:SetWide(manualWidth or parent:GetWide() / 2)
		nextButton:Dock(FILL)
		nextButton:DockMargin(5, 5, 5, 5)
	end
end

function PANEL:CreateItemSwitch(pnl)
	local upperLabel = pnl:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 32, 0, 0)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText("NAVIGATION")
	upperLabel:SetTextColor(defClr)

	local nextPrev = pnl:Add("Panel")
	nextPrev:SetWide(pnl:GetWide())
	nextPrev:SetTall(pnl:GetTall() * 0.15)
	nextPrev:Center()
	nextPrev.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local incrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.curItemPanel:Increment()
	end
	local decrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.curItemPanel:Decrement()
	end
	self:CreateNextPrev(nextPrev, "smallerbuttonarrow.png", nil, nil, decrementFunc, incrementFunc)
end

function PANEL:CreateItemInteraction(pnl)
	local upperLabel = pnl:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 32, 0, 0)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText("INTERACTION")
	upperLabel:SetTextColor(defClr)

	local interact = pnl:Add("Panel")
	interact:SetWide(pnl:GetWide())
	interact:SetTall(pnl:GetTall() * 0.15)
	interact:Center()
	interact.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local take = interact:Add("DButton")
	CreateButton(take, "take from stock", "buttonnoarrow.png")
	take:Dock(TOP)
	take:SetTall(interact:GetTall() / 2)
	take:DockMargin(2, 2, 2, 2)
	take.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		local item = self.curItemPanel:GetItem()
		if item then
			net.Start("ix.city.TakeItem")
				net.WriteString(item.itemID)
				net.WriteEntity(self:GetTerminalEntity())
			net.SendToServer()
		end
	end

	local sell = interact:Add("DButton")
	CreateButton(sell, "sell", "buttonnoarrow.png")
	sell:Dock(FILL)
	sell:DockMargin(2, 2, 2, 2)
	sell.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		local item = self.curItemPanel:GetItem()
		if item then
			net.Start("ix.city.Autosell")
				net.WriteString(util.TableToJSON(item))
				net.WriteEntity(self:GetTerminalEntity())
			net.SendToServer()
		end
	end
end

function PANEL:CreateStock(items)
	if !IsValid(self.cityStock) or !IsValid(self.itemPanel) then return end

	self:CreateItemStockPositions(items)

	self.itemSwitch = self.itemPanel:Add("Panel")
	self.itemSwitch:Dock(LEFT)
	self.itemSwitch:SetWide(self.itemPanel:GetWide() * 0.25)
	self.itemSwitch:DockMargin(6, 6, 6, 6)
	self.itemSwitch:InvalidateParent(true)
	self.itemSwitch.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self:CreateItemSwitch(self.itemSwitch)

	self.itemInteraction = self.itemPanel:Add("Panel")
	self.itemInteraction:Dock(RIGHT)
	self.itemInteraction:SetWide(self.itemPanel:GetWide() * 0.25)
	self.itemInteraction:DockMargin(6, 6, 6, 6)
	self.itemInteraction:InvalidateParent(true)
	self.itemInteraction.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self:CreateItemInteraction(self.itemInteraction)

	self.curItemPanel = self:CreateItemPanel(self.itemPanel, 0, 64, 0, 64)
end

function PANEL:CreateItemPanel(parent, d1, d2, d3, d4)
	if (self.curItemPanel) then
		self.curItemPanel:Remove()
	end

	local pnl = parent:Add("Panel")
	pnl:Dock(FILL)
	pnl:DockMargin(d1, d2, d3, d4)
	pnl:InvalidateParent(true)

	local itemName = pnl:Add("DLabel")
	itemName:Dock(BOTTOM)
	itemName:DockMargin(0, 0, 0, 6)
	itemName:SetContentAlignment(5)
	itemName:SetFont("WNTerminalMediumText")
	itemName:SetText("")
	itemName:SetTextColor(defClr)

	local itemAmount = pnl:Add("DLabel")
	itemAmount:Dock(BOTTOM)
	itemAmount:DockMargin(0, 0, 0, 6)
	itemAmount:SetContentAlignment(5)
	itemAmount:SetFont("WNTerminalMediumText")
	itemAmount:SetText("")
	itemAmount:SetTextColor(defClr)

	local itemP = pnl:Add("DLabel")
	itemP:Dock(BOTTOM)
	itemP:DockMargin(0, 0, 0, 6)
	itemP:SetContentAlignment(5)
	itemP:SetFont("WNTerminalMediumText")
	itemP:SetText("")
	itemP:SetTextColor(defClr)

	local upperLabel = pnl:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 45, 0, 0)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalLargeText")
	upperLabel:SetText("CURRENT ITEM:")
	upperLabel:SetTextColor(defClr)

	local logo = pnl:Add("Panel")
	logo:SetSize(100, 125)
	logo:CenterHorizontal(0.51)
	logo:CenterVertical(0.2)
	logo.Paint = function(s, w, h)
		surface.SetMaterial(cmbLogo)
		surface.SetDrawColor(defClr)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	local itemIcon = pnl:Add("SpawnIcon")
	itemIcon:SetSize(256, 256)
	itemIcon:CenterHorizontal(0.5)
	itemIcon:CenterVertical(0.5)
	itemIcon:InvalidateParent(true)
	itemIcon.PaintOver = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	pnl.SetItem = function(s, itemID, itemData, itemPos)
		s.itemID = itemID
		s.itemData = itemData
		s.itemPos = itemPos
		s:OnItemChanged()
	end
	pnl.GetItem = function(s)
		if s.itemID then
			return {
				itemID = s.itemID,
				amount = 1
			}
		end
	end

	pnl.OnItemChanged = function(s)
		itemName:SetText(string.utf8upper(ix.item.list[pnl.itemID].name))
		itemName:SizeToContents()
		itemAmount:SetText(string.utf8upper("amount: " .. pnl.itemData.amount))
		itemAmount:SizeToContents()
		itemP:SetText("[" .. pnl.itemPos .. " / " .. #self.items .. "]")
		itemP:SizeToContents()

		itemIcon:SetModel(ix.item.list[pnl.itemID].model)
		itemIcon:InvalidateLayout()
	end

	if table.IsEmpty(self.items) then
		itemName:SetText(string.utf8upper("no items in stock"))
		itemName:SizeToContents()
		itemAmount:SetText(string.utf8upper("amount: no"))
		itemAmount:SizeToContents()
	else
		pnl:SetItem(self.items[1].itemID, self.items[1].itemData, 1)
	end

	pnl.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	pnl.Increment = function(s, w, h)
		if s.itemPos and self.items[s.itemPos + 1] then
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
			s:SetItem(self.items[s.itemPos + 1].itemID, self.items[s.itemPos + 1].itemData, s.itemPos + 1)
		else
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/deny.wav", 55, 100, 1, nil, 0, 11)
		end
	end

	pnl.Decrement = function(s, w, h)
		if s.itemPos and self.items[s.itemPos - 1] then
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
			s:SetItem(self.items[s.itemPos - 1].itemID, self.items[s.itemPos - 1].itemData, s.itemPos - 1)
		else
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/deny.wav", 55, 100, 1, nil, 0, 11)
		end
	end

	return pnl
end

function PANEL:ProceedCreditOperation(operation, parent)
	for _, child in pairs(parent:GetChildren()) do
		child:Remove()
	end

	self.credOperationAmount = 0

	local labelText = ""
	self.curOperation = operation
	if operation == "payLoan" then
		labelText = string.utf8upper("pay loan")
	elseif operation == "takeLoan" then
		labelText = string.utf8upper("take loan")
	elseif operation == "transactionWithdraw" then
		labelText = string.utf8upper("withdraw credits")
	elseif operation == "transactionDeposit" then
		labelText = string.utf8upper("deposit credits")
	end

	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 16, 0, 8)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText(labelText)
	upperLabel:SetTextColor(defClr)

	local credPanel = parent:Add("Panel")
	credPanel:Dock(LEFT)
	credPanel:DockMargin(8, 8, 8, 8)
	credPanel:SetWide(parent:GetWide() / 1.5)
	credPanel:InvalidateParent(true)

	local credAmountLabel = credPanel:Add("DLabel")
	credAmountLabel:Dock(TOP)
	credAmountLabel:DockMargin(0, 8, 8, 8)
	credAmountLabel:SetContentAlignment(5)
	credAmountLabel:SetFont("WNTerminalSmallText")
	credAmountLabel:SetText("CREDIT AMOUNT")
	credAmountLabel:SetTextColor(defClr)

	local credRegulation = credPanel:Add("Panel")
	credRegulation:Dock(LEFT)
	credRegulation:DockMargin(8, 8, 8, 8)
	credRegulation:SetWide(credPanel:GetWide() / 1.8)
	credRegulation.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawLine(w-1, h, w-1, h-h)
	end
	credRegulation:InvalidateParent(true)

	self.credAmount = credPanel:Add("DLabel")
	self.credAmount:Dock(FILL)
	self.credAmount:SetContentAlignment(4)
	self.credAmount:SetFont("WNTerminalMediumText")
	self.credAmount:SetText("0")
	self.credAmount:SetTextColor(defClr)
	self.credAmount.Update = function(s)
		s:SetText(self.credOperationAmount)
	end
	self.credAmount.PaintOver = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawLine(w-w, h-8, w / 2.25, h-8)
	end

	local pluses = credRegulation:Add("Panel")
	pluses:Dock(TOP)
	pluses:SetTall(credRegulation:GetTall() / 2)

	local minuses = credRegulation:Add("Panel")
	minuses:Dock(FILL)

	local pppp = pluses:Add("DButton")
	CreateButton(pppp, "++++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	pppp:Dock(RIGHT)
	pppp:DockMargin(2, 2, 6, 2)
	pppp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.credOperationAmount = math.Clamp(self.credOperationAmount + 1000, 0, 10000)
		self.credAmount:Update()
	end

	local ppp = pluses:Add("DButton")
	CreateButton(ppp, "+++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	ppp:Dock(RIGHT)
	ppp:DockMargin(2, 2, 2, 2)
	ppp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.credOperationAmount =  math.Clamp(self.credOperationAmount + 100, 0, 10000)
		self.credAmount:Update()
	end

	local pp = pluses:Add("DButton")
	CreateButton(pp, "++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	pp:Dock(RIGHT)
	pp:DockMargin(2, 2, 2, 2)
	pp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.credOperationAmount = math.Clamp(self.credOperationAmount + 10, 0, 10000)
		self.credAmount:Update()
	end

	local p = pluses:Add("DButton")
	CreateButton(p, "+", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	p:Dock(RIGHT)
	p:DockMargin(2, 2, 2, 2)
	p.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.credOperationAmount = math.Clamp(self.credOperationAmount + 1, 0, 10000)
		self.credAmount:Update()
	end

	local mmmm = minuses:Add("DButton")
	CreateButton(mmmm, "----", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mmmm:Dock(RIGHT)
	mmmm:DockMargin(2, 2, 6, 2)
	mmmm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.credOperationAmount = math.Clamp(self.credOperationAmount - 1000, 0, 10000)
		self.credAmount:Update()
	end

	local mmm = minuses:Add("DButton")
	CreateButton(mmm, "---", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mmm:Dock(RIGHT)
	mmm:DockMargin(2, 2, 2, 2)
	mmm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.credOperationAmount = math.Clamp(self.credOperationAmount - 100, 0, 10000)
		self.credAmount:Update()
	end

	local mm = minuses:Add("DButton")
	CreateButton(mm, "--", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mm:Dock(RIGHT)
	mm:DockMargin(2, 2, 2, 2)
	mm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.credOperationAmount = math.Clamp(self.credOperationAmount - 10, 0, 10000)
		self.credAmount:Update()
	end

	local m = minuses:Add("DButton")
	CreateButton(m, "-", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	m:Dock(RIGHT)
	m:DockMargin(2, 2, 2, 2)
	m.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.credOperationAmount = math.Clamp(self.credOperationAmount - 1, 0, 10000)
		self.credAmount:Update()
	end

	local confirm = parent:Add("Panel")
	confirm:Dock(FILL)
	confirm:DockMargin(8, 8, 8, 8)
	confirm:SetWide(parent:GetWide() / 1.5)

	local confirmLabel = confirm:Add("DLabel")
	confirmLabel:Dock(TOP)
	confirmLabel:DockMargin(0, 8, 8, 8)
	confirmLabel:SetContentAlignment(5)
	confirmLabel:SetFont("WNTerminalSmallText")
	confirmLabel:SetText("CONFIRMATION")
	confirmLabel:SetTextColor(defClr)

	local confirmButton = confirm:Add("DButton")
	CreateButton(confirmButton, "CONFIRM", "buttonnoarrow.png", nil, 5)
	confirmButton:Dock(FILL)
	confirmButton:DockMargin(8, 8, 8, 8)
	confirmButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)

		if self.credOperationAmount == 0 then
			return
		end

		if self.curOperation == "payLoan" then
			net.Start("ix.city.PayLoan")
				net.WriteInt(self.credOperationAmount, 15)
				net.WriteEntity(self:GetTerminalEntity())
			net.SendToServer()
		elseif self.curOperation == "takeLoan" then
			net.Start("ix.city.TakeLoan")
				net.WriteInt(self.credOperationAmount, 15)
				net.WriteEntity(self:GetTerminalEntity())
			net.SendToServer()
		elseif self.curOperation == "transactionWithdraw" then
			net.Start("ix.city.WithdrawCredits")
				net.WriteInt(self.credOperationAmount, 15)
				net.WriteEntity(self:GetTerminalEntity())
			net.SendToServer()
		elseif self.curOperation == "transactionDeposit" then
			net.Start("ix.city.DepositCredits")
				net.WriteInt(self.credOperationAmount, 15)
				net.WriteEntity(self:GetTerminalEntity())
			net.SendToServer()
		end

		self.credOperationAmount = 0
		self.credAmount:Update()
	end
end

function PANEL:FillCreditInteraction(parent, proceedWith)
	for _, child in pairs(parent:GetChildren()) do
		child:Remove()
	end

	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 16, 0, 0)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText("CREDIT INTERACTION")
	upperLabel:SetTextColor(defClr)

	local cInteraction = parent:Add("Panel")
	cInteraction:Dock(TOP)
	cInteraction:DockMargin(172, 32, 172, 0)
	cInteraction:SetTall(parent:GetTall() / 2.25)
	cInteraction.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	cInteraction:InvalidateParent(true)

	local transactionWithdraw = cInteraction:Add("DButton")
	CreateButton(transactionWithdraw, "withdraw credits", "buttonnoarrow.png")
	transactionWithdraw:Dock(TOP)
	transactionWithdraw:SetTall(cInteraction:GetTall() / 5)
	transactionWithdraw:DockMargin(8, 9, 8, 5)

	local transactionDeposit = cInteraction:Add("DButton")
	CreateButton(transactionDeposit, "deposit credits", "smallerbuttonarrow.png")
	transactionDeposit:Dock(TOP)
	transactionDeposit:SetTall(cInteraction:GetTall() / 5)
	transactionDeposit:DockMargin(8, 5, 8, 5)

	local loanPay = cInteraction:Add("DButton")
	CreateButton(loanPay, "pay off loan", "smallerbuttonarrow.png")
	loanPay:Dock(TOP)
	loanPay:SetTall(cInteraction:GetTall() / 5)
	loanPay:DockMargin(8, 5, 8, 5)

	local loanTake = cInteraction:Add("DButton")
	CreateButton(loanTake, "take loan", "smallerbuttonarrow.png")
	loanTake:Dock(TOP)
	loanTake:SetTall(cInteraction:GetTall() / 5)
	loanTake:DockMargin(8, 5, 8, 5)

	self:CreateDivider(parent, TOP)

	local operation = parent:Add("Panel")
	operation:Dock(FILL)
	operation:DockMargin(8, 0, 8, 8)
	operation.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	operation:InvalidateParent(true)

	transactionWithdraw.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self:ProceedCreditOperation("transactionWithdraw", operation)
	end
	transactionDeposit.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self:ProceedCreditOperation("transactionDeposit", operation)
	end
	loanPay.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self:ProceedCreditOperation("payLoan", operation)
	end
	loanTake.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self:ProceedCreditOperation("takeLoan", operation)
	end
	self:ProceedCreditOperation(proceedWith or "transactionWithdraw", operation)
end

function PANEL:ProceedBudgetOperation(parent)
	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 16, 0, 8)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText("FACTION'S CURRENT BUDGET")
	upperLabel:SetTextColor(defClr)

	local credPanel = parent:Add("Panel")
	credPanel:Dock(LEFT)
	credPanel:DockMargin(8, 8, 8, 8)
	credPanel:SetWide(parent:GetWide() / 1.5)
	credPanel:InvalidateParent(true)

	local credAmountLabel = credPanel:Add("DLabel")
	credAmountLabel:Dock(TOP)
	credAmountLabel:DockMargin(0, 8, 8, 8)
	credAmountLabel:SetContentAlignment(5)
	credAmountLabel:SetFont("WNTerminalSmallText")
	credAmountLabel:SetText("CREDIT AMOUNT")
	credAmountLabel:SetTextColor(defClr)

	local credRegulation = credPanel:Add("Panel")
	credRegulation:Dock(LEFT)
	credRegulation:DockMargin(8, 8, 8, 8)
	credRegulation:SetWide(credPanel:GetWide() / 1.8)
	credRegulation.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawLine(w-1, h, w-1, h-h)
	end
	credRegulation:InvalidateParent(true)

	self.credBudget = credPanel:Add("DLabel")
	self.credBudget:Dock(FILL)
	self.credBudget:SetContentAlignment(4)
	self.credBudget:SetFont("WNTerminalMediumText")
	self.credBudget:SetText(self.budgetCreds or "0")
	self.credBudget:SetTextColor(defClr)
	self.credBudget.Update = function(s)
		s:SetText(self.budgetCreds)
	end
	self.credBudget.PaintOver = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawLine(w-w, h-8, w / 2.25, h-8)
	end

	local pluses = credRegulation:Add("Panel")
	pluses:Dock(TOP)
	pluses:SetTall(credRegulation:GetTall() / 2)

	local minuses = credRegulation:Add("Panel")
	minuses:Dock(FILL)

	local pppp = pluses:Add("DButton")
	CreateButton(pppp, "++++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	pppp:Dock(RIGHT)
	pppp:DockMargin(2, 2, 6, 2)
	pppp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.budgetCreds = math.Clamp(self.budgetCreds + 1000, 0, 10000)
		self.credBudget:Update()
	end

	local ppp = pluses:Add("DButton")
	CreateButton(ppp, "+++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	ppp:Dock(RIGHT)
	ppp:DockMargin(2, 2, 2, 2)
	ppp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.budgetCreds =  math.Clamp(self.budgetCreds + 100, 0, 10000)
		self.credBudget:Update()
	end

	local pp = pluses:Add("DButton")
	CreateButton(pp, "++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	pp:Dock(RIGHT)
	pp:DockMargin(2, 2, 2, 2)
	pp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.budgetCreds = math.Clamp(self.budgetCreds + 10, 0, 10000)
		self.credBudget:Update()
	end

	local p = pluses:Add("DButton")
	CreateButton(p, "+", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	p:Dock(RIGHT)
	p:DockMargin(2, 2, 2, 2)
	p.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.budgetCreds = math.Clamp(self.budgetCreds + 1, 0, 10000)
		self.credBudget:Update()
	end

	local mmmm = minuses:Add("DButton")
	CreateButton(mmmm, "----", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mmmm:Dock(RIGHT)
	mmmm:DockMargin(2, 2, 6, 2)
	mmmm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.budgetCreds = math.Clamp(self.budgetCreds - 1000, 0, 10000)
		self.credBudget:Update()
	end

	local mmm = minuses:Add("DButton")
	CreateButton(mmm, "---", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mmm:Dock(RIGHT)
	mmm:DockMargin(2, 2, 2, 2)
	mmm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.budgetCreds = math.Clamp(self.budgetCreds - 100, 0, 10000)
		self.credBudget:Update()
	end

	local mm = minuses:Add("DButton")
	CreateButton(mm, "--", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mm:Dock(RIGHT)
	mm:DockMargin(2, 2, 2, 2)
	mm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.budgetCreds = math.Clamp(self.budgetCreds - 10, 0, 10000)
		self.credBudget:Update()
	end

	local m = minuses:Add("DButton")
	CreateButton(m, "-", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	m:Dock(RIGHT)
	m:DockMargin(2, 2, 2, 2)
	m.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.budgetCreds = math.Clamp(self.budgetCreds - 1, 0, 10000)
		self.credBudget:Update()
	end

	local confirm = parent:Add("Panel")
	confirm:Dock(FILL)
	confirm:DockMargin(8, 8, 8, 8)
	confirm:SetWide(parent:GetWide() / 1.5)

	local confirmLabel = confirm:Add("DLabel")
	confirmLabel:Dock(TOP)
	confirmLabel:DockMargin(0, 8, 8, 8)
	confirmLabel:SetContentAlignment(5)
	confirmLabel:SetFont("WNTerminalSmallText")
	confirmLabel:SetText("CONFIRMATION")
	confirmLabel:SetTextColor(defClr)

	local confirmButton = confirm:Add("DButton")
	CreateButton(confirmButton, "CONFIRM", "buttonnoarrow.png", nil, 5)
	confirmButton:Dock(FILL)
	confirmButton:DockMargin(8, 8, 8, 8)
	confirmButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)

		if self.budgetCreds == 0 then return end

		local budgetData = {
			budgetID = isstring(self.currentFaction.id) and string.utf8upper(self.currentFaction.id) or string.utf8upper(tostring(self.currentFaction.id)),
			newBudget = self.budgetCreds
		}

		if self:IsCombine() then
			net.Start("ix.city.SetFactionBudget")
				net.WriteString(util.TableToJSON(budgetData))
				net.WriteEntity(self:GetTerminalEntity())
			net.SendToServer()
		else
			if self.selectedBudgetInteraction == "withdraw" then
				net.Start("ix.city.WithdrawFactionBudget")
					net.WriteString(self.currentFaction.id)
					net.WriteInt(self.budgetCreds, 15)
					net.WriteEntity(self:GetTerminalEntity())
				net.SendToServer()
			elseif self.selectedBudgetInteraction == "deposit" then
				net.Start("ix.city.DepositFactionBudget")
					net.WriteString(self.currentFaction.id)
					net.WriteInt(self.budgetCreds, 15)
					net.WriteEntity(self:GetTerminalEntity())
				net.SendToServer()
			end
		end
	end

end

function PANEL:FillBudgetInteraction(parent, bData)
	self.factionList = {}

	for id, faction in pairs(bData) do
		self.factionList[#self.factionList + 1] = {
			name = faction.name,
			credits = faction.credits,
			id = id,
			pos = #self.factionList + 1
		}
	end

	if #self.factionList == 0 then
		local errorLabel = parent:Add("DLabel")
		errorLabel:Dock(TOP)
		errorLabel:DockMargin(0, 16, 0, 0)
		errorLabel:SetContentAlignment(5)
		errorLabel:SetFont("WNTerminalMediumText")
		errorLabel:SetText("NO ACTIVE FACTIONS")
		errorLabel:SetTextColor(defClr)
		return
	end

	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 16, 0, 0)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText("FACTION BUDGETS")
	upperLabel:SetTextColor(defClr)

	local operation = parent:Add("Panel")
	operation:Dock(BOTTOM)
	operation:SetHeight(179)
	operation:DockMargin(8, 0, 8, 8)
	operation.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	operation:InvalidateParent(true)
	self:ProceedBudgetOperation(operation)

	self:CreateDivider(parent, BOTTOM)

	local nextPrev = parent:Add("Panel")
	nextPrev:Dock(TOP)
	nextPrev:DockMargin(48, 36, 48, 8)
	nextPrev:SetHeight(48)
	nextPrev.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	nextPrev:InvalidateParent(true)
	local incrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if (self.pickedFaction) then
			self.pickedFaction:Increment()
		end
	end
	local decrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if (self.pickedFaction) then
			self.pickedFaction:Decrement()
		end
	end
	self:CreateNextPrev(nextPrev, "buttonnoarrow.png", nil, 5, decrementFunc, incrementFunc, true)

	self:CreateDivider(parent, TOP)

	local curFaction = parent:Add("DLabel")
	curFaction:Dock(TOP)
	curFaction:DockMargin(0, 8, 0, 8)
	curFaction:SetContentAlignment(5)
	curFaction:SetFont("WNTerminalMediumText")
	curFaction:SetText("[CURRENT FACTION]")
	curFaction:SetTextColor(defClr)

	self.currentFaction = self.factionList[1]

	if !self:IsCombine() then
		self.pickedFactionBudget = parent:Add("DLabel")
		self.pickedFactionBudget:Dock(TOP)
		self.pickedFactionBudget:DockMargin(0, 10, 0, 0)
		self.pickedFactionBudget:SetContentAlignment(5)
		self.pickedFactionBudget:SetFont("WNTerminalMediumSmallerText")
		self.pickedFactionBudget:SetText("CURRENT BUDGET: " .. self.currentFaction.credits .. " CREDITS")
		self.pickedFactionBudget:SetTextColor(defClr)
	end

	self.pickedFaction = parent:Add("DLabel")
	self.pickedFaction:Dock(FILL)
	self.pickedFaction:DockMargin(0, 8, 0, 8)
	self.pickedFaction:SetContentAlignment(5)
	self.pickedFaction:SetFont("WNTerminalMediumText")
	self.pickedFaction:SetText(self.currentFaction.name)
	self.pickedFaction:SetTextColor(defClr)
	self.pickedFaction:SizeToContents()

	self.pickedFaction.Increment = function(s)
		if self.factionList[self.currentFaction.pos + 1] then
			self.currentFaction = self.factionList[self.currentFaction.pos + 1]
			s:Update()
		end
	end

	self.pickedFaction.Decrement = function(s)
		if self.factionList[self.currentFaction.pos - 1] then
			self.currentFaction = self.factionList[self.currentFaction.pos - 1]
			s:Update()
		end
	end

	self.pickedFaction.Update = function(s)
		s:SetText(self.currentFaction.name)
		s:SizeToContents()

		if self:IsCombine() then
			self.budgetCreds = self.currentFaction.credits
			self.credBudget:Update()
		else
			self.pickedFactionBudget:SetText("CURRENT BUDGET: " .. self.currentFaction.credits .. " CREDITS")
		end
	end
	self.pickedFaction:Update()
end

function PANEL:BuildCreditInfo(parent)
	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 36, 0, 8)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalLargeText")
	upperLabel:SetText("FUND")
	upperLabel:SetTextColor(defClr)

	local bottomLabel = parent:Add("DLabel")
	bottomLabel:Dock(BOTTOM)
	bottomLabel:DockMargin(0, 0, 0, 36)
	bottomLabel:SetContentAlignment(5)
	bottomLabel:SetFont("WNTerminalMediumText")
	bottomLabel:SetText("AVAILABLE CREDITS")
	bottomLabel:SetTextColor(defClr)

	local credLabel = parent:Add("DLabel")
	credLabel:Dock(FILL)
	credLabel:DockMargin(10, 10, 10, 10)
	credLabel:SetContentAlignment(5)
	credLabel:SetFont("WNTerminalLargeText")
	credLabel:SetText("")
	credLabel:SetTextColor(defClr)

	if self.curCityData then
		credLabel:SetText(self.curCityData.credits)
		credLabel:SizeToContents()
	end
end

function PANEL:BuildStockInfo(parent)
	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 36, 0, 8)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalLargeText")
	upperLabel:SetText("STOCK")
	upperLabel:SetTextColor(defClr)

	local bottomLabel = parent:Add("DLabel")
	bottomLabel:Dock(BOTTOM)
	bottomLabel:DockMargin(0, 0, 0, 36)
	bottomLabel:SetContentAlignment(5)
	bottomLabel:SetFont("WNTerminalMediumText")
	bottomLabel:SetText("ITEMS IN CITY STOCK")
	bottomLabel:SetTextColor(defClr)

	local stockLabel = parent:Add("DLabel")
	stockLabel:Dock(FILL)
	stockLabel:DockMargin(10, 10, 10, 10)
	stockLabel:SetContentAlignment(5)
	stockLabel:SetFont("WNTerminalLargeText")
	stockLabel:SetText("")
	stockLabel:SetTextColor(defClr)

	if self.curCityData then
		local count = 0
		for _, item in pairs(self.curCityData.items) do
			count = count + item.amount
		end

		stockLabel:SetText(count)
		stockLabel:SizeToContents()
	end
end

function PANEL:BuildLoanInfo(parent)
	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 36, 0, 8)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalLargeText")
	upperLabel:SetText("LOAN")
	upperLabel:SetTextColor(defClr)

	local bottomLabel = parent:Add("DLabel")
	bottomLabel:Dock(BOTTOM)
	bottomLabel:DockMargin(0, 0, 0, 36)
	bottomLabel:SetContentAlignment(5)
	bottomLabel:SetFont("WNTerminalMediumText")
	bottomLabel:SetText("CURRENT CITY LOAN")
	bottomLabel:SetTextColor(defClr)

	local loanLabel = parent:Add("DLabel")
	loanLabel:Dock(FILL)
	loanLabel:DockMargin(10, 10, 10, 10)
	loanLabel:SetContentAlignment(5)
	loanLabel:SetFont("WNTerminalLargeText")
	loanLabel:SetText("")
	loanLabel:SetTextColor(defClr)

	if self.curCityData then
		loanLabel:SetText(self.curCityData.loan)
		loanLabel:SizeToContents()
	end
end

function PANEL:FillCityInfo(parent)
	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 36, 0, 8)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText("CITY INFO")
	upperLabel:SetTextColor(defClr)

	self:CreateDivider(parent, TOP)

	local credInfo = parent:Add("Panel")
	credInfo:Dock(LEFT)
	credInfo:DockMargin(8, 8, 8, 8)
	credInfo:SetWide(parent:GetWide() / 3.1)
	credInfo.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self:BuildCreditInfo(credInfo)

	local stockInfo = parent:Add("Panel")
	stockInfo:Dock(LEFT)
	stockInfo:DockMargin(8, 8, 8, 8)
	stockInfo:SetWide(parent:GetWide() / 3.1)
	stockInfo.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self:BuildStockInfo(stockInfo)

	local loanInfo = parent:Add("Panel")
	loanInfo:Dock(LEFT)
	loanInfo:DockMargin(8, 8, 8, 8)
	loanInfo:SetWide(parent:GetWide() / 3.1)
	loanInfo.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self:BuildLoanInfo(loanInfo)
end

function PANEL:RequestStatusInfo()
	net.Start("ix.terminal.RequestMainCityInfo")
		net.WriteEntity(self:GetTerminalEntity())
		net.WriteString("status")
	net.SendToServer()
end

function PANEL:FillBudgetTypes(parent)
	for _, child in pairs(parent:GetChildren()) do
		child:Remove()
	end

	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 16, 0, 0)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText("BUGDET INTERACTION")
	upperLabel:SetTextColor(defClr)

	local cInteraction = parent:Add("Panel")
	cInteraction:Dock(TOP)
	cInteraction:DockMargin(172, 32, 172, 0)
	cInteraction:SetTall(parent:GetTall() / 2.8)
	cInteraction.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	cInteraction:InvalidateParent(true)

	local transactionWithdraw = cInteraction:Add("DButton")
	CreateButton(transactionWithdraw, "withdraw credits", "buttonnoarrow.png")
	transactionWithdraw:Dock(TOP)
	transactionWithdraw:SetTall(cInteraction:GetTall() / 2.3)
	transactionWithdraw:DockMargin(8, 9, 8, 2)

	local transactionDeposit = cInteraction:Add("DButton")
	CreateButton(transactionDeposit, "deposit credits", "smallerbuttonarrow.png")
	transactionDeposit:Dock(FILL)
	transactionDeposit:DockMargin(8, 2, 8, 9)

	self:CreateDivider(parent, TOP)

	transactionWithdraw.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		self.selectedBudgetInteraction = "withdraw"
		self.curBudgetInteraction:SetText(string.utf8upper(self.selectedBudgetInteraction))
	end
	transactionDeposit.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		self.selectedBudgetInteraction = "deposit"
		self.curBudgetInteraction:SetText(string.utf8upper(self.selectedBudgetInteraction))
	end

	local curInteract = parent:Add("DLabel")
	curInteract:Dock(TOP)
	curInteract:DockMargin(0, 16, 0, 0)
	curInteract:SetContentAlignment(5)
	curInteract:SetFont("WNTerminalMediumText")
	curInteract:SetText("SELECTED INTERACTION")
	curInteract:SetTextColor(defClr)

	self.curBudgetInteraction = parent:Add("DLabel")
	self.curBudgetInteraction:Dock(FILL)
	self.curBudgetInteraction:SetContentAlignment(5)
	self.curBudgetInteraction:SetFont("WNTerminalLargeText")
	self.curBudgetInteraction:SetTextColor(defClr)
	self.curBudgetInteraction:SetText(string.utf8upper(self.selectedBudgetInteraction))

end

function PANEL:CreateStatusPanel(cityData, budgetData, bNoFade)
	for _, child in pairs(self.status:GetChildren()) do
		child:Remove()
	end
	self.curCityData = cityData

	local interactionPanel = self.status:Add("Panel")
	interactionPanel:Dock(TOP)
	interactionPanel:DockMargin(10, 10, 10, 10)
	interactionPanel:SetTall(self.status:GetTall() / 2.1)
	interactionPanel:SetAlpha(0)

	if self:IsCombine() then
		self.creditInteraction = interactionPanel:Add("Panel")
		self.creditInteraction:Dock(LEFT)
		self.creditInteraction:SetWide(self.status:GetWide() / 2.05)
		self.creditInteraction.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self.creditInteraction:InvalidateParent(true)
		self:FillCreditInteraction(self.creditInteraction)

		self.budgetInteraction = interactionPanel:Add("Panel")
		self.budgetInteraction:Dock(RIGHT)
		self.budgetInteraction:SetWide(self.status:GetWide() / 2.05)
		self.budgetInteraction.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self.budgetInteraction:InvalidateParent(true)
		self:FillBudgetInteraction(self.budgetInteraction, budgetData)
	else
		self.budgetTypeInteraction = interactionPanel:Add("Panel")
		self.budgetTypeInteraction:Dock(LEFT)
		self.budgetTypeInteraction:SetWide(self.status:GetWide() / 2.05)
		self.budgetTypeInteraction.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self.budgetTypeInteraction:InvalidateParent(true)
		self:FillBudgetTypes(self.budgetTypeInteraction)

		self.budgetInteraction = interactionPanel:Add("Panel")
		self.budgetInteraction:Dock(RIGHT)
		self.budgetInteraction:SetWide(self.status:GetWide() / 2.05)
		self.budgetInteraction.Paint = function(s, w, h)
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(defClr)
			surface.DrawOutlinedRect(0, 0, w, h, 1)
		end
		self.budgetInteraction:InvalidateParent(true)
		self:FillBudgetInteraction(self.budgetInteraction, budgetData)
	end

	local cityInfo = self.status:Add("Panel")
	cityInfo:Dock(FILL)
	cityInfo:DockMargin(10, 10, 10, 48)
	cityInfo.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	cityInfo:InvalidateParent(true)
	self:FillCityInfo(cityInfo)
	cityInfo:SetAlpha(0)

	if !bNoFade then
		for _, child in pairs(self.status:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	else
		for _, child in pairs(self.status:GetChildren()) do
			child:SetAlpha(255)
		end
	end
end

function PANEL:RequestMarket()
	net.Start("ix.terminal.RequestCities")
		net.WriteEntity(self:GetTerminalEntity())
	net.SendToServer()
end

function PANEL:Populate(cityTbl)
	if self.currentOption then
		if self.currentOption.id == "CITY STOCK" then
			self.savedData.itemPos = self.curItemPanel.itemPos

			self:CreateItemStockPositions(cityTbl.items)
			self.curItemPanel = self:CreateItemPanel(self.itemPanel, 0, 64, 0, 64)
			self.curItemPanel:SetItem(self.items[self.savedData.itemPos].itemID, self.items[self.savedData.itemPos].itemData, self.savedData.itemPos)

			self.savedData = {}
		elseif self.currentOption.id == "STATUS" then
			self.savedData.lastCreditOperationValue = self.credOperationAmount
			self.savedData.lastOperationType = self.curOperation
			self.savedData.lastPickedFaction = self.currentFaction

			self:CreateStatusPanel(cityTbl, cityTbl.factionBudgets, true)
			if (self.creditInteraction) then
				self:FillCreditInteraction(self.creditInteraction, self.savedData.lastOperationType)
			end

			if (self.credAmount) then
				self.credOperationAmount = self.savedData.lastCreditOperationValue
				self.credAmount:Update()
			end

			self.currentFaction = self.factionList[self.savedData.lastPickedFaction.pos]
			self.budgetCreds = self:IsCombine() and self.currentFaction.credits or self.budgetCreds
			self.pickedFaction:Update()

			self.savedData = {}
		end
	end
end

function PANEL:BuildCitySelector(parent)
	local nextPrev = parent:Add("Panel")
	nextPrev:Dock(TOP)
	nextPrev:DockMargin(48, 5, 48, 5)
	nextPrev:SetHeight(48)
	nextPrev.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local incrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if (self.sCityLabel) then
			self.sCityLabel:Increment()
		end
	end
	local decrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if (self.sCityLabel) then
			self.sCityLabel:Decrement()
		end
	end

	self:CreateNextPrev(nextPrev, "buttonnoarrow.png", nil, 5, decrementFunc, incrementFunc, true, 278)

	self.sCityLabel = parent:Add("DLabel")
	self.sCityLabel:Dock(FILL)
	self.sCityLabel:DockMargin(10, 48, 10, 48)
	self.sCityLabel:SetContentAlignment(5)
	self.sCityLabel:SetFont("WNTerminalLargeText")
	self.sCityLabel:SetTextColor(defClr)
	self.sCityLabel:SetText("CITY-" .. self.selectedCity.id)
	self.sCityLabel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawLine(0, h, w, h)
		surface.DrawLine(0, h-h, w, h-h)
	end
	self.sCityLabel.Increment = function(s)
		if self.selectorCities[self.selectedCity.pos + 1] then
			self.selectedCity = self.selectorCities[self.selectedCity.pos + 1]
			s:Update()
		end
	end
	self.sCityLabel.Decrement = function(s)
		if self.selectorCities[self.selectedCity.pos - 1] then
			self.selectedCity = self.selectorCities[self.selectedCity.pos - 1]
			s:Update()
		end
	end
	self.sCityLabel.Update = function(s)
		s:SetText("CITY-" .. self.selectedCity.id)
		self:CreateItemStockPositions(self.selectedCity.items)
		self:CreateMarketItemViewer(self.marketItemPanel, 2, 2, 2, 2)
		self:FillItemInformation(self.itemMInfo, self.marketViewer:GetItem())
	end
end

function PANEL:CreateMarketItemViewer(parent, d1, d2, d3, d4)
	if (self.marketViewer) then
		self.marketViewer:Remove()
	end

	self.marketViewer = parent:Add("Panel")
	self.marketViewer:Dock(FILL)
	self.marketViewer:DockMargin(d1, d2, d3, d4)
	self.marketViewer:InvalidateLayout(true)

	local itemName = self.marketViewer:Add("DLabel")
	itemName:Dock(BOTTOM)
	itemName:DockMargin(0, 0, 0, 6)
	itemName:SetContentAlignment(5)
	itemName:SetFont("WNTerminalMediumText")
	itemName:SetText("")
	itemName:SetTextColor(defClr)

	local itemAmount = self.marketViewer:Add("DLabel")
	itemAmount:Dock(BOTTOM)
	itemAmount:DockMargin(0, 0, 0, 6)
	itemAmount:SetContentAlignment(5)
	itemAmount:SetFont("WNTerminalMediumText")
	itemAmount:SetText("")
	itemAmount:SetTextColor(defClr)

	local itemP = self.marketViewer:Add("DLabel")
	itemP:Dock(BOTTOM)
	itemP:DockMargin(0, 0, 0, 6)
	itemP:SetContentAlignment(5)
	itemP:SetFont("WNTerminalMediumText")
	itemP:SetText("")
	itemP:SetTextColor(defClr)

	local itemIcon = self.marketViewer:Add("SpawnIcon")
	itemIcon:Dock(BOTTOM)
	itemIcon:DockMargin(260, 0, 260, 0)
	itemIcon:SetTall(128)
	itemIcon.PaintOver = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	self.marketViewer.SetItem = function(s, itemID, itemData, itemPos)
		s.itemID = itemID
		s.itemData = itemData
		s.itemPos = itemPos
		s:OnItemChanged()
	end

	self.marketViewer.GetItem = function(s)
		if !s.itemData then return false end

		local item = {}
		for k, v in pairs(s.itemData) do
			item[k] = v
		end
		item.id = s.itemID
		return item
	end

	self.marketViewer.OnItemChanged = function(s)
		itemName:SetText(string.utf8upper(ix.item.list[self.marketViewer.itemID].name))
		itemName:SizeToContents()
		itemAmount:SetText(string.utf8upper("amount: " .. self.marketViewer.itemData.amount))
		itemAmount:SizeToContents()
		itemP:SetText("[" .. self.marketViewer.itemPos .. " / " .. #self.items .. "]")
		itemP:SizeToContents()

		itemIcon:SetModel(ix.item.list[self.marketViewer.itemID].model)
		itemIcon:InvalidateLayout()

		if (self.itemMInfo) then
			self:FillItemInformation(self.itemMInfo, s:GetItem())
		end
		if (self.interaction) then
			self:FillItemInteraction(self.interaction, s:GetItem())
		end
	end

	if table.IsEmpty(self.items) then
		itemName:SetText(string.utf8upper("no items in stock"))
		itemName:SizeToContents()
		itemAmount:SetText(string.utf8upper("amount: no"))
		itemAmount:SizeToContents()
	else
		self.marketViewer:SetItem(self.items[1].itemID, self.items[1].itemData, 1)
	end

	self.marketViewer.Increment = function(s, w, h)
		if s.itemPos and s.itemPos < #self.items and s.itemPos != #self.items then
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
			s:SetItem(self.items[s.itemPos + 1].itemID, self.items[s.itemPos + 1].itemData, s.itemPos + 1)
		else
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/deny.wav", 55, 100, 1, nil, 0, 11)
		end
	end

	self.marketViewer.Decrement = function(s, w, h)
		if s.itemPos and s.itemPos != 1 then
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
			s:SetItem(self.items[s.itemPos - 1].itemID, self.items[s.itemPos - 1].itemData, s.itemPos - 1)
		else
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/deny.wav", 55, 100, 1, nil, 0, 11)
		end
	end

	local nextPrev = self.marketViewer:Add("Panel")
	nextPrev:Dock(TOP)
	nextPrev:DockMargin(48, 5, 48, 5)
	nextPrev:SetHeight(48)
	nextPrev.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local incrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if (self.marketViewer) then
			self.marketViewer:Increment()
		end
	end
	local decrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if (self.marketViewer) then
			self.marketViewer:Decrement()
		end
	end

	self:CreateNextPrev(nextPrev, "buttonnoarrow.png", nil, 5, decrementFunc, incrementFunc, true, 278)

	return self.marketViewer
end

local function GetCurrentPrice(itemData)
	if !isnumber(itemData.price) then itemData.price = tonumber(itemData.price) end

	if itemData.priceMulptiplicationTD and itemData.amount <= itemData.priceMulptiplicationTD then
		return math.ceil(itemData.price * itemData.priceMul)
	elseif itemData.priceReductionTD and itemData.amount >= itemData.priceReductionTD then
		return math.ceil(itemData.price / itemData.priceDiv)
	else
		return itemData.price
	end
end

local function GetCurrentState(itemData)
	if itemData.priceMulptiplicationTD and itemData.amount <= itemData.priceMulptiplicationTD then
		return {
			text = string.utf8upper("lacking"),
			color = redClr
		}
	elseif itemData.priceReductionTD and itemData.amount >= itemData.priceReductionTD then
		return {
			text = string.utf8upper("abundance"),
			color = greenClr
		}
	else
		return {
			text = string.utf8upper("normal"),
			color = defClr
		}
	end
end

local function CanAfford(itemPrice, mainCity)
	if itemPrice > mainCity.credits then
		return string.utf8upper("you cant afford\n this item")
	else
		return string.utf8upper("you can afford\n this item")
	end
end

function PANEL:FillItemInformation(parent, itemData)
	if (self.itemMarketInfo) then
		self.itemMarketInfo:Remove()
	end

	self.itemMarketInfo = parent:Add("Panel")
	self.itemMarketInfo:Dock(FILL)
	self.itemMarketInfo:DockMargin(2, 2, 2, 2)

	if (!itemData) then
		local errorLabel = self.itemMarketInfo:Add("DLabel")
		errorLabel:Dock(FILL)
		errorLabel:DockMargin(0, 0, 0, 0)
		errorLabel:SetContentAlignment(5)
		errorLabel:SetFont("WNTerminalMediumText")
		errorLabel:SetText("NO ITEM INFORMATION")
		errorLabel:SetTextColor(defClr)
		errorLabel:SizeToContents()
		return
	end

	local firstColumn = self.itemMarketInfo:Add("Panel")
	firstColumn:Dock(LEFT)
	firstColumn:DockMargin(6, 6, 6, 6)
	firstColumn:SetWide(803 / 2)
	firstColumn.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local selectedCityLabel = firstColumn:Add("DLabel")
	selectedCityLabel:Dock(TOP)
	selectedCityLabel:DockMargin(1, 2, 1, 2)
	selectedCityLabel:SetContentAlignment(5)
	selectedCityLabel:SetFont("WNTerminalMediumSmallerText")
	selectedCityLabel:SetText("CITY-" .. self.selectedCity.id)
	selectedCityLabel:SetTextColor(defClr)
	selectedCityLabel:SizeToContents()

	self.currentPrice = firstColumn:Add("DLabel")
	self.currentPrice:Dock(TOP)
	self.currentPrice:DockMargin(1, 2, 1, 2)
	self.currentPrice:SetContentAlignment(5)
	self.currentPrice:SetFont("WNTerminalMediumSmallerText")
	self.currentPrice:SetText(string.utf8upper("current price: ") .. GetCurrentPrice(itemData))
	self.currentPrice:SetTextColor(defClr)
	self.currentPrice:SizeToContents()

	self.defaultPrice = firstColumn:Add("DLabel")
	self.defaultPrice:Dock(TOP)
	self.defaultPrice:DockMargin(1, 2, 1, 2)
	self.defaultPrice:SetContentAlignment(5)
	self.defaultPrice:SetFont("WNTerminalMediumSmallerText")
	self.defaultPrice:SetText(string.utf8upper("default price: ") .. itemData.price)
	self.defaultPrice:SetTextColor(defClr)
	self.defaultPrice:SizeToContents()

	self.cityCredits = firstColumn:Add("DLabel")
	self.cityCredits:Dock(TOP)
	self.cityCredits:DockMargin(1, 2, 1, 2)
	self.cityCredits:SetContentAlignment(5)
	self.cityCredits:SetFont("WNTerminalMediumSmallerText")
	self.cityCredits:SetText(string.utf8upper("city credits: ") .. self.selectedCity.credits)
	self.cityCredits:SetTextColor(defClr)
	self.cityCredits:SizeToContents()

	local curState = GetCurrentState(itemData)
	self.currentState = firstColumn:Add("DLabel")
	self.currentState:Dock(TOP)
	self.currentState:DockMargin(1, 2, 1, 2)
	self.currentState:SetContentAlignment(5)
	self.currentState:SetFont("WNTerminalMediumSmallerText")
	self.currentState:SetText(string.utf8upper("current state: \n") .. curState.text)
	self.currentState:SetTextColor(curState.color)
	self.currentState:SizeToContents()

	local secondColumn = self.itemMarketInfo:Add("Panel")
	secondColumn:Dock(FILL)
	secondColumn:DockMargin(6, 6, 6, 6)
	secondColumn.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local yourCityLabel = secondColumn:Add("DLabel")
	yourCityLabel:Dock(TOP)
	yourCityLabel:DockMargin(1, 2, 1, 2)
	yourCityLabel:SetContentAlignment(5)
	yourCityLabel:SetFont("WNTerminalMediumSmallerText")
	yourCityLabel:SetText(string.utf8upper("your city"))
	yourCityLabel:SetTextColor(defClr)
	yourCityLabel:SizeToContents()

	self.mCredits = secondColumn:Add("DLabel")
	self.mCredits:Dock(TOP)
	self.mCredits:DockMargin(1, 2, 1, 2)
	self.mCredits:SetContentAlignment(5)
	self.mCredits:SetFont("WNTerminalMediumSmallerText")
	self.mCredits:SetText(string.utf8upper("city credits: ") .. self.mainCity.credits)
	self.mCredits:SetTextColor(defClr)
	self.mCredits:SizeToContents()

	self.mItemAmount = secondColumn:Add("DLabel")
	self.mItemAmount:Dock(TOP)
	self.mItemAmount:DockMargin(1, 2, 1, 2)
	self.mItemAmount:SetContentAlignment(5)
	self.mItemAmount:SetFont("WNTerminalMediumSmallerText")
	self.mItemAmount:SetText(self.mainCity.items[itemData.id] and string.utf8upper("amount: ") .. self.mainCity.items[itemData.id].amount or string.utf8upper("no such items in stock"))
	self.mItemAmount:SetTextColor(defClr)
	self.mItemAmount:SizeToContents()

	self:CreateDivider(secondColumn, TOP)

	self.canAfford = secondColumn:Add("DLabel")
	self.canAfford:Dock(TOP)
	self.canAfford:DockMargin(1, 2, 1, 2)
	self.canAfford:SetContentAlignment(5)
	self.canAfford:SetFont("WNTerminalMediumSmallerText")
	self.canAfford:SetText(CanAfford(GetCurrentPrice(itemData), self.mainCity))
	self.canAfford:SetTextColor(defClr)
	self.canAfford:SizeToContents()
end

function PANEL:ClearCart()
	self.cart = {}
end

function PANEL:SortCart()
	local newCart = {}
	for _, item in pairs(self.cart) do
		newCart[#newCart + 1] = {
			itemData = item.itemData,
			itemPos = #newCart + 1,
			amount = item.amount,
			city = item.city
		}
	end
	self.cart = newCart
end

function PANEL:RemoveItemFromCart(itemPos)
	self.cart[itemPos] = nil
	self:SortCart()
end

function PANEL:ItemAlreadyInCart(itemData, city)
	for i, item in pairs(self.cart) do
		if item.city == city and item.itemData.id == itemData.id then
			return i
		end
	end
	return false
end

function PANEL:AddItemToCart(itemData, amount, city)
	local inCart = self:ItemAlreadyInCart(itemData, city)
	if inCart then
		self.cart[inCart] = {
			itemData = itemData,
			itemPos = inCart,
			amount = amount,
			city = city
		}
		return
	end

	self.cart[#self.cart + 1] = {
		itemData = itemData,
		itemPos = #self.cart + 1,
		amount = amount,
		city = city
	}
end

function PANEL:ProceedItemOperation(operation, parent, pWide, itemData)
	for _, child in pairs(parent:GetChildren()) do
		child:Remove()
	end
	if (!itemData) then
		local errorLabel = parent:Add("DLabel")
		errorLabel:Dock(FILL)
		errorLabel:DockMargin(0, 0, 0, 0)
		errorLabel:SetContentAlignment(5)
		errorLabel:SetFont("WNTerminalMediumText")
		errorLabel:SetText("NO ITEM DATA")
		errorLabel:SetTextColor(defClr)
		errorLabel:SizeToContents()
		return
	end
	local maxValue = itemData.amount

	self.operationAmount = 0

	local labelText = ""
	if operation == "addToCart" then
		labelText = string.utf8upper("add to cart")
	elseif operation == "sellItem" then
		labelText = string.utf8upper("sell item")
	end

	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 16, 0, 8)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText(labelText)
	upperLabel:SetTextColor(defClr)

	local amountPanel = parent:Add("Panel")
	amountPanel:Dock(LEFT)
	amountPanel:DockMargin(8, 8, 8, 8)
	amountPanel:SetWide(pWide / 1.5)
	amountPanel:InvalidateParent(true)

	local itemAmountLabel = amountPanel:Add("DLabel")
	itemAmountLabel:Dock(TOP)
	itemAmountLabel:DockMargin(0, 8, 8, 8)
	itemAmountLabel:SetContentAlignment(5)
	itemAmountLabel:SetFont("WNTerminalSmallText")
	itemAmountLabel:SetText("ITEM AMOUNT")
	itemAmountLabel:SetTextColor(defClr)

	local amountRegulation = amountPanel:Add("Panel")
	amountRegulation:Dock(LEFT)
	amountRegulation:DockMargin(8, 8, 8, 8)
	amountRegulation:SetWide((pWide / 1.5) / 1.8)
	amountRegulation.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawLine(w-1, h, w-1, h-h)
	end

	local itemAmount = amountPanel:Add("DLabel")
	itemAmount:Dock(FILL)
	itemAmount:SetContentAlignment(4)
	itemAmount:SetFont("WNTerminalMediumText")
	itemAmount:SetText("0")
	itemAmount:SetTextColor(defClr)
	itemAmount.Update = function(s)
		s:SetText(self.operationAmount)
	end
	itemAmount.PaintOver = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawLine(w-w, h-8, w / 2.25, h-8)
	end

	local pluses = amountRegulation:Add("Panel")
	pluses:Dock(TOP)
	pluses:SetTall(88 / 2)

	local minuses = amountRegulation:Add("Panel")
	minuses:Dock(FILL)

	local pppp = pluses:Add("DButton")
	CreateButton(pppp, "++++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	pppp:Dock(RIGHT)
	pppp:DockMargin(2, 2, 6, 2)
	pppp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.operationAmount = math.Clamp(self.operationAmount + 1000, 0, maxValue)
		itemAmount:Update()
	end

	local ppp = pluses:Add("DButton")
	CreateButton(ppp, "+++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	ppp:Dock(RIGHT)
	ppp:DockMargin(2, 2, 2, 2)
	ppp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.operationAmount = math.Clamp(self.operationAmount + 100, 0, maxValue)
		itemAmount:Update()
	end

	local pp = pluses:Add("DButton")
	CreateButton(pp, "++", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	pp:Dock(RIGHT)
	pp:DockMargin(2, 2, 2, 2)
	pp.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.operationAmount = math.Clamp(self.operationAmount + 10, 0, maxValue)
		itemAmount:Update()
	end

	local p = pluses:Add("DButton")
	CreateButton(p, "+", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	p:Dock(RIGHT)
	p:DockMargin(2, 2, 2, 2)
	p.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.operationAmount = math.Clamp(self.operationAmount + 1, 0, maxValue)
		itemAmount:Update()
	end

	local mmmm = minuses:Add("DButton")
	CreateButton(mmmm, "----", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mmmm:Dock(RIGHT)
	mmmm:DockMargin(2, 2, 6, 2)
	mmmm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.operationAmount = math.Clamp(self.operationAmount - 1000, 0, maxValue)
		itemAmount:Update()
	end

	local mmm = minuses:Add("DButton")
	CreateButton(mmm, "---", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mmm:Dock(RIGHT)
	mmm:DockMargin(2, 2, 2, 2)
	mmm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.operationAmount = math.Clamp(self.operationAmount - 100, 0, maxValue)
		itemAmount:Update()
	end

	local mm = minuses:Add("DButton")
	CreateButton(mm, "--", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	mm:Dock(RIGHT)
	mm:DockMargin(2, 2, 2, 2)
	mm.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.operationAmount = math.Clamp(self.operationAmount - 10, 0, maxValue)
		itemAmount:Update()
	end

	local m = minuses:Add("DButton")
	CreateButton(m, "-", "buttonnoarrow.png", "WNTerminalSmallText", 5)
	m:Dock(RIGHT)
	m:DockMargin(2, 2, 2, 2)
	m.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self.operationAmount = math.Clamp(self.operationAmount - 1, 0, maxValue)
		itemAmount:Update()
	end

	local confirm = parent:Add("Panel")
	confirm:Dock(FILL)
	confirm:DockMargin(8, 8, 8, 8)
	confirm:SetWide(pWide / 1.5)

	local confirmLabel = confirm:Add("DLabel")
	confirmLabel:Dock(TOP)
	confirmLabel:DockMargin(0, 8, 8, 8)
	confirmLabel:SetContentAlignment(5)
	confirmLabel:SetFont("WNTerminalSmallText")
	confirmLabel:SetText("CONFIRMATION")
	confirmLabel:SetTextColor(defClr)

	local confirmButton = confirm:Add("DButton")
	CreateButton(confirmButton, "CONFIRM", "buttonnoarrow.png", nil, 5)
	confirmButton:Dock(FILL)
	confirmButton:DockMargin(8, 8, 8, 8)
	confirmButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		if self.operationAmount == 0 then
			return
		end

		if operation == "addToCart" then
			self:AddItemToCart(itemData, self.operationAmount, self.selectedCity.id)

			self.operationAmount = 0
			itemAmount:Update()
		elseif operation == "sellItem" then
			local sellData = {
				itemID = itemData.id,
				amount = self.operationAmount,
				cityID = self.selectedCity.id
			}

			if sellData then
				net.Start("ix.city.Sell")
					net.WriteString(util.TableToJSON(sellData))
					net.WriteEntity(self:GetTerminalEntity())
				net.SendToServer()
			end

			self.operationAmount = 0
			itemAmount:Update()
		end
	end
end

function PANEL:FillItemInteraction(parent, itemData)
	if (self.itemInt) then
		self.itemInt:Remove()
	end

	self.itemInt = parent:Add("Panel")
	self.itemInt:Dock(FILL)

	local operation = self.itemInt:Add("Panel")
	operation:Dock(BOTTOM)
	operation:DockMargin(2, 2, 2, 2)
	operation:SetTall(200)
	operation.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self:ProceedItemOperation("addToCart", operation, 803, itemData)

	local interactButtonPanel = self.itemInt:Add("Panel")
	interactButtonPanel:Dock(TOP)
	interactButtonPanel:DockMargin(64, 32, 64, 0)
	interactButtonPanel:SetTall(196)
	interactButtonPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	if !self.marketViewer:GetItem() then
		local refreshButton = interactButtonPanel:Add("DButton")
		CreateButton(refreshButton, "REFRESH CITIES", "buttonnoarrow.png", nil, 5)
		refreshButton:Dock(FILL)
		refreshButton:DockMargin(16, 4, 16, 4)
		refreshButton:SetTall(196 / 3.75)
		refreshButton.DoClick = function(s)
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
			self:RequestMarket()
		end
		return
	end

	local cartButton = interactButtonPanel:Add("DButton")
	CreateButton(cartButton, "ADD TO CART", "buttonnoarrow.png", nil, 5)
	cartButton:Dock(TOP)
	cartButton:DockMargin(16, 16, 16, 4)
	cartButton:SetTall(196 / 3.5)
	cartButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self:ProceedItemOperation("addToCart", operation, 803, itemData)
	end

	local refreshButton = interactButtonPanel:Add("DButton")
	CreateButton(refreshButton, "REFRESH CITIES", "buttonnoarrow.png", nil, 5)
	refreshButton:Dock(TOP)
	refreshButton:DockMargin(16, 4, 16, 4)
	refreshButton:SetTall(196 / 3.75)
	refreshButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self:RequestMarket()
	end

	local mainCityItem = self.mainCity.items[self.marketViewer:GetItem().id]
	if istable(mainCityItem) then
		mainCityItem.id = self.marketViewer:GetItem().id
	end

	local sellButton = interactButtonPanel:Add("DButton")
	CreateButton(sellButton, "SELL ITEM", "buttonnoarrow.png", nil, 5)
	sellButton:Dock(FILL)
	sellButton:DockMargin(16, 4, 16, 16)
	sellButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if self.mainCity.items[self.marketViewer:GetItem().id] then
			self:ProceedItemOperation("sellItem", operation, 803, mainCityItem)
		else
			LocalPlayer():NotifyLocalized("Your city dont have this item.")
		end
	end
end

function PANEL:CreateMarketPanel(cData)
	for _, child in pairs(self.marketPanel:GetChildren()) do
		child:Remove()
	end

	self.selectorCities = {}
	for _, city in pairs(cData) do
		if city.id == "1" then
			self.mainCity = city
			self.mainCity.credits = tonumber(self.mainCity.credits)
			continue
		end
		city.pos = #self.selectorCities + 1
		self.selectorCities[#self.selectorCities + 1] = city
	end

	if #self.selectorCities == 0 then
		local errorLabel = self.marketPanel:Add("DLabel")
		errorLabel:Dock(FILL)
		errorLabel:SetContentAlignment(5)
		errorLabel:SetFont("WNTerminalLargeText")
		errorLabel:SetText("NO CITIES AVAILABLE AT THIS MOMENT")
		errorLabel:SetTextColor(defClr)
		return
	end
	self.selectedCity = table.Random(self.selectorCities)
	self:CreateItemStockPositions(self.selectedCity.items)

	local upperLabel = self.marketPanel:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:DockMargin(0, 48, 0, 8)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalLargeText")
	upperLabel:SetText("[EXPORT // IMPORT]")
	upperLabel:SetTextColor(defClr)

	local left = self.marketPanel:Add("Panel")
	left:Dock(LEFT)
	left:SetWide(self.marketPanel:GetWide() / 2.25)
	left:DockMargin(2, 36, 2, 48)
	left:InvalidateParent(true)

	self.marketItemPanel = left:Add("Panel")
	self.marketItemPanel:Dock(BOTTOM)
	self.marketItemPanel:SetTall(left:GetTall() / 2)
	self.marketItemPanel:DockMargin(8, 1, 8, 1)
	self.marketItemPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local itemLabel = self.marketItemPanel:Add("DLabel")
	itemLabel:Dock(TOP)
	itemLabel:DockMargin(0, 8, 0, 2)
	itemLabel:SetContentAlignment(5)
	itemLabel:SetFont("WNTerminalMediumText")
	itemLabel:SetText("CURRENT ITEM")
	itemLabel:SetTextColor(defClr)
	itemLabel:SizeToContents()

	local cityPanel = left:Add("Panel")
	cityPanel:Dock(FILL)
	cityPanel:DockMargin(8, 1, 8, 1)
	cityPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local cityLabel = cityPanel:Add("DLabel")
	cityLabel:Dock(TOP)
	cityLabel:DockMargin(0, 8, 0, 2)
	cityLabel:SetContentAlignment(5)
	cityLabel:SetFont("WNTerminalMediumText")
	cityLabel:SetText("CURRENT CITY")
	cityLabel:SetTextColor(defClr)
	cityLabel:SizeToContents()

	self:CreateDivider(self.marketItemPanel, TOP)
	self:CreateDivider(cityPanel, TOP)

	self:CreateMarketItemViewer(self.marketItemPanel, 2, 2, 2, 2)

	self:BuildCitySelector(cityPanel, cData)

	local right = self.marketPanel:Add("Panel")
	right:Dock(FILL)
	right:DockMargin(12, 36, 12, 48)
	right:InvalidateParent(true)

	self.itemMInfo = right:Add("Panel")
	self.itemMInfo:Dock(BOTTOM)
	self.itemMInfo:DockMargin(1, 1, 1, 1)
	self.itemMInfo:SetTall(right:GetTall() / 2.5)
	self.itemMInfo.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	local infoLabel = self.itemMInfo:Add("DLabel")
	infoLabel:Dock(TOP)
	infoLabel:DockMargin(0, 8, 0, 2)
	infoLabel:SetContentAlignment(5)
	infoLabel:SetFont("WNTerminalMediumText")
	infoLabel:SetText("INFORMATION")
	infoLabel:SetTextColor(defClr)
	infoLabel:SizeToContents()

	self:CreateDivider(self.itemMInfo, TOP)

	self:FillItemInformation(self.itemMInfo, self.marketViewer:GetItem())

	self.interaction = right:Add("Panel")
	self.interaction:Dock(FILL)
	self.interaction:DockMargin(1, 1, 1, 1)
	self.interaction.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	local interactionLabel = self.interaction:Add("DLabel")
	interactionLabel:Dock(TOP)
	interactionLabel:DockMargin(0, 8, 0, 2)
	interactionLabel:SetContentAlignment(5)
	interactionLabel:SetFont("WNTerminalMediumText")
	interactionLabel:SetText("INTERACTION")
	interactionLabel:SetTextColor(defClr)
	interactionLabel:SizeToContents()

	self:CreateDivider(self.interaction, TOP)
	self:FillItemInteraction(self.interaction, self.marketViewer:GetItem())
end

function PANEL:CreateCartItemViewer(parent, d1, d2, d3, d4)
	if (self.cartViewer) then
		self.cartViewer:Remove()
	end

	self.cartViewer = parent:Add("Panel")
	self.cartViewer:Dock(FILL)
	self.cartViewer:DockMargin(d1, d2, d3, d4)
	self.cartViewer:InvalidateParent(true)

	local itemName = self.cartViewer:Add("DLabel")
	itemName:Dock(TOP)
	itemName:DockMargin(0, 0, 0, 0)
	itemName:SetContentAlignment(5)
	itemName:SetFont("WNTerminalMediumText")
	itemName:SetText("")
	itemName:SetTextColor(defClr)

	local itemAmount = self.cartViewer:Add("DLabel")
	itemAmount:Dock(TOP)
	itemAmount:DockMargin(0, 0, 0, 0)
	itemAmount:SetContentAlignment(5)
	itemAmount:SetFont("WNTerminalMediumText")
	itemAmount:SetText("")
	itemAmount:SetTextColor(defClr)

	local itemCity = self.cartViewer:Add("DLabel")
	itemCity:Dock(TOP)
	itemCity:DockMargin(0, 0, 0, 0)
	itemCity:SetContentAlignment(5)
	itemCity:SetFont("WNTerminalMediumText")
	itemCity:SetText("")
	itemCity:SetTextColor(defClr)

	local itemP = self.cartViewer:Add("DLabel")
	itemP:Dock(TOP)
	itemP:DockMargin(0, 0, 0, 0)
	itemP:SetContentAlignment(5)
	itemP:SetFont("WNTerminalMediumText")
	itemP:SetText("")
	itemP:SetTextColor(defClr)

	local itemIcon = self.cartViewer:Add("SpawnIcon")
	itemIcon:Dock(TOP)
	itemIcon:DockMargin((1469 - 64) / 2.09, 3, (1469 - 64) / 2.09, 0)
	itemIcon:SetTall(128)
	itemIcon.PaintOver = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	self.cartViewer.SetItem = function(s, itemData, iAmount, itemPos, city)
		s.itemData = itemData
		s.itemAmount = iAmount
		s.itemPos = itemPos
		s.itemCity = city
		s:OnItemChanged()
	end

	self.cartViewer.GetItem = function(s)
		return {
			itemData = s.itemData,
			itemAmount = s.ItemAmount,
			itemPos = s.itemPos
		}
	end

	self.cartViewer.OnItemChanged = function(s)
		itemName:SetText(string.utf8upper(ix.item.list[s.itemData.id].name))
		itemName:SizeToContents()
		itemAmount:SetText(string.utf8upper("cart amount: " .. s.itemAmount))
		itemAmount:SizeToContents()
		itemCity:SetText(string.utf8upper("city: " .. s.itemCity))
		itemCity:SizeToContents()
		itemP:SetText("[" .. s.itemPos .. " / " .. #self.cart .. "]")
		itemP:SizeToContents()

		itemIcon:SetModel(ix.item.list[s.itemData.id].model)
		itemIcon:InvalidateLayout()
	end

	if #self.cart == 0 then
		itemName:SetText(string.utf8upper("no items in stock"))
		itemName:SizeToContents()
		itemAmount:SetText(string.utf8upper("amount: no"))
		itemAmount:SizeToContents()
	else
		self.cartViewer:SetItem(self.cart[1].itemData, self.cart[1].amount, self.cart[1].itemPos, self.cart[1].city)
	end

	self.cartViewer.Increment = function(s, w, h)
		if s.itemPos and self.cart[s.itemPos + 1] then
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
			s:SetItem(self.cart[s.itemPos + 1].itemData, self.cart[s.itemPos + 1].amount, self.cart[s.itemPos + 1].itemPos, self.cart[s.itemPos + 1].city)
		else
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/deny.wav", 55, 100, 1, nil, 0, 11)
		end
	end

	self.cartViewer.Decrement = function(s, w, h)
		if s.itemPos and self.cart[s.itemPos - 1] then
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
			s:SetItem(self.cart[s.itemPos - 1].itemData, self.cart[s.itemPos - 1].amount, self.cart[s.itemPos - 1].itemPos, self.cart[s.itemPos - 1].city)
		else
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/deny.wav", 55, 100, 1, nil, 0, 11)
		end
	end

	local nextPrev = self.cartViewer:Add("Panel")
	nextPrev:Dock(BOTTOM)
	nextPrev:DockMargin(108, 0, 108, 4)
	nextPrev:SetHeight(78)
	nextPrev.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local incrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if (self.cartViewer) then
			self.cartViewer:Increment()
		end
	end
	local decrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if (self.cartViewer) then
			self.cartViewer:Decrement()
		end
	end

	self:CreateNextPrev(nextPrev, "buttonnoarrow.png", nil, 5, decrementFunc, incrementFunc, true, 1253 / 2)

	return self.cartViewer
end

function PANEL:GetTotalCheckout()
	local credits = 0
	for i, item in pairs(self.cart) do
		credits = credits + ((GetCurrentPrice(item.itemData)) * item.amount)
	end

	return credits
end

function PANEL:GetItemCount()
	local items = 0
	for i, item in pairs(self.cart) do
		items = items + item.amount
	end

	return items
end

function PANEL:GetCityCount()
	local cities = {}
	for i, item in pairs(self.cart) do
		cities[item.city] = true
	end

	return table.Count(cities)
end

function PANEL:GetTotalPrice()
	local tPrice = 0
	for i, item in pairs(self.cart) do
		tPrice = tPrice + (GetCurrentPrice(item.itemData) * item.amount)
	end

	return tPrice
end

local function GetCityCreditsColor(cityCredits, totalPrice)
	if !isnumber(cityCredits) then cityCredits = tonumber(cityCredits) end
	if !isnumber(totalPrice) then totalPrice = tonumber(totalPrice) end

	if cityCredits >= totalPrice then
		return greenClr
	else
		return redClr
	end
end

local function CanCityAfford(cityCredits, totalPrice)
	if !isnumber(cityCredits) then cityCredits = tonumber(cityCredits) end
	if !isnumber(totalPrice) then totalPrice = tonumber(totalPrice) end

	if cityCredits >= totalPrice then
		return true
	end
end

function PANEL:CreateCheckout(parent, cData)
	if (self.checkout) then
		self.checkout:Remove()
	end

	self.checkout = parent:Add("Panel")
	self.checkout:Dock(FILL)

	if #self.cart == 0 then
		local emptyCart = self.checkout:Add("DLabel")
		emptyCart:Dock(FILL)
		emptyCart:SetContentAlignment(5)
		emptyCart:SetFont("WNTerminalLargeText")
		emptyCart:SetText(string.utf8upper("your cart is empty"))
		emptyCart:SetTextColor(defClr)
		emptyCart:SizeToContents()

		return
	end

	local cartInteraction = self.checkout:Add("Panel")
	cartInteraction:Dock(RIGHT)
	cartInteraction:DockMargin(6, 128, 6, 128)
	cartInteraction:SetWide(parent:GetWide() / 3)
	cartInteraction.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	local intLabel = cartInteraction:Add("DLabel")
	intLabel:Dock(TOP)
	intLabel:SetContentAlignment(5)
	intLabel:SetFont("WNTerminalMediumText")
	intLabel:SetText(string.utf8upper("cart interaction"))
	intLabel:SetTextColor(defClr)
	intLabel:SizeToContents()

	local intButtonList = cartInteraction:Add("Panel")
	intButtonList:Dock(FILL)
	intButtonList:DockMargin(24, 24, 24, 24)
	intButtonList.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local bClosing = false

	local clearCart = intButtonList:Add("DButton")
	CreateButton(clearCart, "CLEAR CART", "buttonnoarrow.png", nil, 5)
	clearCart:Dock(TOP)
	clearCart:SizeToContents()
	clearCart:DockMargin(6, 16, 6, 0)
	clearCart.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/open.wav", 55, 100, 1, nil, 0, 11)
		self:ClearCart()
		if bClosing then return end
		bClosing = true
		self.cartP:AlphaTo(0, 0.5, 0, function()
			self.cartP:Remove()
			self.currentOption = {}
		end)
	end

	local removeItem = intButtonList:Add("DButton")
	CreateButton(removeItem, "REMOVE SELECTED ITEM", "buttonnoarrow.png", nil, 5)
	removeItem:Dock(BOTTOM)
	removeItem:SizeToContents()
	removeItem:DockMargin(6, 0, 6, 16)
	removeItem.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		self:RemoveItemFromCart(self.cartViewer:GetItem().itemPos)

		self:CreateCartItemViewer(self.lowerCart, 6, 6, 6, 6)
		self:CreateCheckout(self.upperCart, cData)
	end

	self:CreateDivider(intButtonList, FILL)

	local checkout = self.checkout:Add("Panel")
	checkout:Dock(FILL)
	checkout:DockMargin(6, 6, 6, 6)
	checkout.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	local checkoutLabel = checkout:Add("DLabel")
	checkoutLabel:Dock(TOP)
	checkoutLabel:SetContentAlignment(5)
	checkoutLabel:SetFont("WNTerminalMediumText")
	checkoutLabel:SetText(string.utf8upper("checkout"))
	checkoutLabel:SetTextColor(defClr)
	checkoutLabel:SizeToContents()

	local itemsInCart = checkout:Add("DLabel")
	itemsInCart:Dock(TOP)
	itemsInCart:DockMargin(12, 4, 0, 0)
	itemsInCart:SetContentAlignment(4)
	itemsInCart:SetFont("WNTerminalMediumText")
	itemsInCart:SetText(string.utf8upper("items in cart: " .. self:GetItemCount()))
	itemsInCart:SetTextColor(defClr)
	itemsInCart:SizeToContents()

	local citiesCount = checkout:Add("DLabel")
	citiesCount:Dock(TOP)
	citiesCount:DockMargin(12, 4, 0, 0)
	citiesCount:SetContentAlignment(4)
	citiesCount:SetFont("WNTerminalMediumText")
	citiesCount:SetText(self:GetCityCount() == 1 and string.utf8upper("importing from: " .. self:GetCityCount() .. " city") or string.utf8upper("importing from: " .. self:GetCityCount() .. " cities"))
	citiesCount:SetTextColor(defClr)
	citiesCount:SizeToContents()

	self:CreateDivider(checkout, TOP)

	local tPrice = self:GetTotalPrice()

	local totalPrice = checkout:Add("DLabel")
	totalPrice:Dock(TOP)
	totalPrice:DockMargin(12, 4, 0, 0)
	totalPrice:SetContentAlignment(4)
	totalPrice:SetFont("WNTerminalMediumText")
	totalPrice:SetText(string.utf8upper("total price: " .. tPrice .. " credits"))
	totalPrice:SetTextColor(defClr)
	totalPrice:SizeToContents()

	local cityCredits = checkout:Add("DLabel")
	cityCredits:Dock(TOP)
	cityCredits:DockMargin(12, 4, 0, 0)
	cityCredits:SetContentAlignment(4)
	cityCredits:SetFont("WNTerminalMediumText")
	cityCredits:SetText(string.utf8upper("current city fund: " .. cData.credits .. " credits"))
	cityCredits:SetTextColor(GetCityCreditsColor(cData.credits, tPrice))
	cityCredits:SizeToContents()

	self:CreateDivider(checkout, TOP)

	if CanCityAfford(cData.credits, tPrice) then
		local confirmationLabel = checkout:Add("DLabel")
		confirmationLabel:Dock(TOP)
		confirmationLabel:DockMargin(12, 4, 0, 0)
		confirmationLabel:SetContentAlignment(5)
		confirmationLabel:SetFont("WNTerminalLargeText")
		confirmationLabel:SetText(string.utf8upper("confirm operation?"))
		confirmationLabel:SetTextColor(GetCityCreditsColor(cData.credits, tPrice))
		confirmationLabel:SizeToContents()

		local confirmButton = checkout:Add("DButton")
		CreateButton(confirmButton, "CONFIRM", "buttonnoarrow.png", "WNTerminalMediumText", 5)
		confirmButton:Dock(FILL)
		confirmButton:DockMargin(96, 4, 96, 16)
		confirmButton:SizeToContents()
		confirmButton.DoClick = function(s)
			self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)

			net.Start("ix.city.BuyCart")
				net.WriteString(util.TableToJSON(self.cart))
				net.WriteEntity(self:GetTerminalEntity())
			net.SendToServer()

			self:ClearCart()
			if bClosing then return end
			bClosing = true
			self.cartP:AlphaTo(0, 0.5, 0, function()
				self.cartP:Remove()
				self.currentOption = {}
			end)
		end
	else
		local noCreditsLabel = checkout:Add("DLabel")
		noCreditsLabel:Dock(FILL)
		noCreditsLabel:DockMargin(12, 4, 0, 0)
		noCreditsLabel:SetContentAlignment(5)
		noCreditsLabel:SetFont("WNTerminalLargeText")
		noCreditsLabel:SetText(string.utf8upper("you cant afford this"))
		noCreditsLabel:SetTextColor(GetCityCreditsColor(cData.credits, tPrice))
		noCreditsLabel:SizeToContents()
	end
end

function PANEL:BuildCart(parent, cData)
	self.upperCart = parent:Add("Panel")
	self.upperCart:Dock(TOP)
	self.upperCart:DockMargin(12, 12, 12, 12)
	self.upperCart:SetTall(parent:GetTall() / 2)
	self.upperCart:InvalidateParent(true)
	self.upperCart.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	self.lowerCart = parent:Add("Panel")
	self.lowerCart:Dock(FILL)
	self.lowerCart:DockMargin(12, 12, 12, 48)
	self.lowerCart:SetTall(parent:GetTall() / 2)
	self.lowerCart.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self:CreateCartItemViewer(self.lowerCart, 6, 6, 6, 6)
	self:CreateCheckout(self.upperCart, cData)
end

function PANEL:RequestCartInfo()
	net.Start("ix.terminal.RequestMainCityInfo")
		net.WriteEntity(self:GetTerminalEntity())
		net.WriteString("cart")
	net.SendToServer()
end

function PANEL:PopulateWorkshift(data)
	self.workshiftData = data
	if self.workshiftData.participants and istable(self.workshiftData.participants) and !table.IsEmpty(self.workshiftData.participants) then
		self:SortParticipants()
	else
		self.workshiftData.participants = {}
	end

	if !self.workshiftData.rewards or !istable(self.workshiftData.rewards) or table.IsEmpty(self.workshiftData.rewards) then
		self.workshiftData.rewards = {}
	end

	if IsValid(self.workshiftNextPrev) then
		self.workshiftNextPrev.pos = 1
	end

	if IsValid(self.workshiftLabel) then
		self.workshiftLabel:SetText(GetNetVar("WorkshiftStarted", false) and string.utf8upper("workshift is online") or string.utf8upper("workshift is offline"))
		self.workshiftLabel:SetTextColor(GetNetVar("WorkshiftStarted", false) and greenClr or redClr)
	end

	if IsValid(self.participantLabel) then
		if #self.workshiftData.participants > 0 then
			self.participantLabel:SetText(string.utf8upper("selected participant [".. self.workshiftNextPrev.pos .."/" .. #self.workshiftData.participants .. "]:"))
		else
			self.participantLabel:SetText(string.utf8upper("selected participant [0/0]:"))
		end
	end

	if IsValid(self.participantName) then
		self.participantName:SetText(self.workshiftData.participants[self.workshiftNextPrev.pos] and self.workshiftData.participants[self.workshiftNextPrev.pos][2] or "/NO DATA/")
	end

	if IsValid(self.rewards) then
		self:BuildRewards(self.rewards)
	end
end

function PANEL:CreateDataSelector(parent, name, isInt, data, confirmFunction)
	local upperLabel = parent:Add("DLabel")
	upperLabel:Dock(TOP)
	upperLabel:SetContentAlignment(5)
	upperLabel:SetFont("WNTerminalMediumText")
	upperLabel:SetText(string.utf8upper(name))
	upperLabel:SetTextColor(defClr)
	upperLabel:SizeToContents()

	local dataDisplay = parent:Add("Panel")
	dataDisplay:Dock(LEFT)
	dataDisplay:SetWide(parent:GetWide() / 2)
	dataDisplay:DockMargin(24, 24, 24, 24)
	dataDisplay.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	dataDisplay.data = isInt and 0 or data[1]
	local curPos
	if !isInt then
		curPos = 1
	end

	local dataLabel = dataDisplay:Add("DLabel")
	dataLabel:Dock(FILL)
	dataLabel:SetContentAlignment(5)
	dataLabel:SetFont(isInt and "WNTerminalLargeText" or "WNTerminalMediumText")
	dataLabel:SetText(dataDisplay.data)
	dataLabel:SetTextColor(defClr)
	dataLabel:SizeToContents()

	dataDisplay.SetValue = function(s, value)
		s.data = value
		dataLabel:SetText(dataDisplay.data)
		dataLabel:SizeToContents()
	end

	local dataToggler = parent:Add("Panel")
	dataToggler:Dock(FILL)
	dataToggler:DockMargin(0, 24, 0, 0)
	dataToggler:InvalidateParent(true)

	local plusMinus = dataToggler:Add("Panel")
	plusMinus:Dock(TOP)
	plusMinus:SetTall(dataToggler:GetTall() / 2)
	plusMinus:InvalidateParent(true)

	local p = plusMinus:Add("DButton")
	CreateButton(p, "+", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	p:Dock(TOP)
	p:DockMargin(32, 4, 32, 2)
	p:SetTall(plusMinus:GetTall() / 2)
	p.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		if isInt then
			dataDisplay.data = math.Clamp(dataDisplay.data + 1, 0, ix.config.Get("maxWorkshiftSocialCredits", 10))
		else
			if data[curPos + 1] then
				curPos = curPos + 1
				dataDisplay.data = data[curPos]
			end
		end
		dataLabel:SetText(dataDisplay.data)
		dataLabel:SizeToContents()
	end

	local m = plusMinus:Add("DButton")
	CreateButton(m, "-", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	m:Dock(FILL)
	m:DockMargin(32, 2, 32, 0)
	m.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		if isInt then
			dataDisplay.data = math.Clamp(dataDisplay.data - 1, 0, ix.config.Get("maxWorkshiftSocialCredits", 10))
		else
			if data[curPos - 1] then
				curPos = curPos - 1
				dataDisplay.data = data[curPos]
			end
		end
		dataLabel:SetText(dataDisplay.data)
		dataLabel:SizeToContents()
	end

	local confirmButton = dataToggler:Add("DButton")
	CreateButton(confirmButton, "CONFIRM", "buttonnoarrow.png", "WNTerminalMediumSmallerText", 5)
	confirmButton:Dock(FILL)
	confirmButton:DockMargin(32, 16, 32, 16)
	confirmButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		if confirmFunction then
			confirmFunction()
		end
	end

	return dataDisplay
end

function PANEL:SortParticipants()
	local replace = {}
	for k, participant in pairs(self.workshiftData.participants) do
		local pTbl = participant
		participant.charID = k
		replace[#replace + 1] = pTbl
	end

	self.workshiftData.participants = replace
end

function PANEL:BuildRewards(parent)
	for _, child in pairs(parent:GetChildren()) do
		child:Remove()
	end

	self.coupons = parent:Add("Panel")
	self.coupons:Dock(LEFT)
	self.coupons:DockMargin(4, 4, 4, 4)
	self.coupons:SetWide(parent:GetWide() / 2)
	self.coupons:InvalidateParent(true)
	self.coupons.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self.couponSelector = self:CreateDataSelector(self.coupons, "Coupon", false, self.couponList, function()
		self:UpdateWorkshiftRewards("coupon", self.couponSelector.data == "NONE" and false or self.couponSelector.data)
	end)

	self.socialCredits = parent:Add("Panel")
	self.socialCredits:Dock(FILL)
	self.socialCredits:DockMargin(4, 4, 4, 4)
	self.socialCredits:InvalidateParent(true)
	self.socialCredits.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self.scSelector = self:CreateDataSelector(self.socialCredits, "Social Credits", true, nil, function()
		self:UpdateWorkshiftRewards("points", self.scSelector.data)
	end)

	local participant = self.workshiftData.participants[self.workshiftNextPrev.pos] and self.workshiftData.participants[self.workshiftNextPrev.pos].charID
	if participant then
		self.scSelector:SetValue(self.workshiftData.rewards[participant] and self.workshiftData.rewards[participant]["points"] and self.workshiftData.rewards[participant]["points"] or 0)
		self.couponSelector:SetValue(self.workshiftData.rewards[participant] and self.workshiftData.rewards[participant]["coupon"] and self.workshiftData.rewards[participant]["coupon"] or "NONE")
	end
end

function PANEL:BuildShift(parent)
	self.workshiftLabel = parent:Add("DLabel")
	self.workshiftLabel:Dock(TOP)
	self.workshiftLabel:SetContentAlignment(5)
	self.workshiftLabel:SetFont("WNTerminalLargeText")
	self.workshiftLabel:SetText(GetNetVar("WorkshiftStarted", false) and string.utf8upper("workshift is online") or string.utf8upper("workshift is offline"))
	self.workshiftLabel:SetTextColor(GetNetVar("WorkshiftStarted", false) and greenClr or redClr)
	self.workshiftLabel:SizeToContents()

	self:CreateDivider(parent, TOP)

	local workshiftInteraction = parent:Add("Panel")
	workshiftInteraction:Dock(TOP)
	workshiftInteraction:DockMargin(12, 12, 12, 8)
	workshiftInteraction:SetTall(128)
	workshiftInteraction:InvalidateParent(true)
	workshiftInteraction.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local beginShift = workshiftInteraction:Add("DButton")
	CreateButton(beginShift, "BEGIN SHIFT", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	beginShift:Dock(LEFT)
	beginShift:DockMargin(8, 8, 8, 8)
	beginShift:SetWide(workshiftInteraction:GetWide() / 4)
	beginShift.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)

		if GetNetVar("WorkshiftStarted", false) then return end

		net.Start("ix.terminal.CWUWorkshiftBegin")
			net.WriteEntity(self:GetTerminalEntity())
		net.SendToServer()

		self:RequestShift()
	end

	local endShift = workshiftInteraction:Add("DButton")
	CreateButton(endShift, "END SHIFT", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	endShift:Dock(LEFT)
	endShift:DockMargin(8, 8, 8, 8)
	endShift:SetWide(workshiftInteraction:GetWide() / 4)
	endShift.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)

		if !GetNetVar("WorkshiftStarted", false) then return end

		net.Start("ix.terminal.CWUWorkshiftEnd")
			net.WriteEntity(self:GetTerminalEntity())
		net.SendToServer()

		self:RequestShift()
	end

	local pauseReg = workshiftInteraction:Add("DButton")
	CreateButton(pauseReg, "PAUSE REG", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	pauseReg:Dock(LEFT)
	pauseReg:DockMargin(8, 8, 8, 8)
	pauseReg:SetWide(workshiftInteraction:GetWide() / 4)
	pauseReg.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)

		if !GetNetVar("WorkshiftStarted", false) then return end

		net.Start("ix.terminal.CWUWorkshiftPause")
			net.WriteEntity(self:GetTerminalEntity())
		net.SendToServer()
	end

	local toggleBroadcast = workshiftInteraction:Add("DButton")
	CreateButton(toggleBroadcast, "BROADCAST", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	toggleBroadcast:Dock(FILL)
	toggleBroadcast:DockMargin(8, 8, 8, 8)
	toggleBroadcast.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)

		net.Start("ix.terminal.CWUBroadcast")
			net.WriteEntity(self:GetTerminalEntity())
		net.SendToServer()
	end

	self:CreateDivider(parent, TOP)

	local participantsLabel = parent:Add("DLabel")
	participantsLabel:Dock(TOP)
	participantsLabel:SetContentAlignment(5)
	participantsLabel:SetFont("WNTerminalLargeText")
	participantsLabel:SetText(string.utf8upper("workshift participants"))
	participantsLabel:SetTextColor(defClr)
	participantsLabel:SizeToContents()

	self:CreateDivider(parent, TOP)

	self.participantsPanel = parent:Add("Panel")
	self.participantsPanel:Dock(FILL)
	self.participantsPanel:DockMargin(16, 16, 16, 16)
	self.participantsPanel:InvalidateParent(true)
	self.participantsPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local refreshButton = self.participantsPanel:Add("DButton")
	CreateButton(refreshButton, "REFRESH INFO", "buttonnoarrow.png", "WNTerminalMediumText", 5)
	refreshButton:Dock(TOP)
	refreshButton:DockMargin(8, 8, 8, 8)
	refreshButton:SizeToContents()
	refreshButton.DoClick = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)

		self:RequestShift()
	end

	self.participantLabel = self.participantsPanel:Add("DLabel")
	self.participantLabel:Dock(TOP)
	self.participantLabel:SetContentAlignment(5)
	self.participantLabel:SetFont("WNTerminalMediumText")
	self.participantLabel:SetText("")
	self.participantLabel:SetTextColor(defClr)
	self.participantLabel:SizeToContents()

	self.participantName = self.participantsPanel:Add("DLabel")
	self.participantName:Dock(TOP)
	self.participantName:SetContentAlignment(5)
	self.participantName:SetFont("WNTerminalMediumText")
	self.participantName:SetText("/NO DATA/")
	self.participantName:SetTextColor(defClr)
	self.participantName:SizeToContents()

	self.workshiftNextPrev = self.participantsPanel:Add("Panel")
	self.workshiftNextPrev:Dock(BOTTOM)
	self.workshiftNextPrev:DockMargin(8, 8, 8, 8)
	self.workshiftNextPrev:SetHeight(78)
	self.workshiftNextPrev:InvalidateParent(true)
	self.workshiftNextPrev.pos = 1
	self.workshiftNextPrev.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local incrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		if self.workshiftData.participants[self.workshiftNextPrev.pos + 1] then
			self.workshiftNextPrev.pos = self.workshiftNextPrev.pos + 1

			self.participantLabel:SetText(string.utf8upper("selected participant [".. self.workshiftNextPrev.pos .."/" .. #self.workshiftData.participants .. "]:"))
			self.participantName:SetText(self.workshiftData.participants[self.workshiftNextPrev.pos][2] or "/NO DATA/")

			self:BuildRewards(self.rewards)
		end
	end
	local decrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)
		if self.workshiftData.participants[self.workshiftNextPrev.pos - 1] then
			self.workshiftNextPrev.pos = self.workshiftNextPrev.pos - 1

			self.participantLabel:SetText(string.utf8upper("selected participant [".. self.workshiftNextPrev.pos .."/" .. #self.workshiftData.participants .. "]:"))
			self.participantName:SetText(self.workshiftData.participants[self.workshiftNextPrev.pos][2] or "/NO DATA/")

			self:BuildRewards(self.rewards)
		end
	end

	self:CreateNextPrev(self.workshiftNextPrev, "buttonnoarrow.png", nil, 5, decrementFunc, incrementFunc, true)

	if #self.workshiftData.participants > 0 then
		self.participantLabel:SetText(string.utf8upper("selected participant [".. self.workshiftNextPrev.pos .."/" .. #self.workshiftData.participants .. "]:"))
	else
		self.participantLabel:SetText(string.utf8upper("selected participant [0/0]:"))
	end

	self.participantName:SetText(self.workshiftData.participants[self.workshiftNextPrev.pos] and self.workshiftData.participants[self.workshiftNextPrev.pos][2] or "/NO DATA/")

	self.rewards = self.participantsPanel:Add("Panel")
	self.rewards:Dock(FILL)
	self.rewards:DockMargin(12, 12, 12, 12)
	self.rewards:InvalidateParent(true)

	self:BuildRewards(self.rewards)
end

function PANEL:UpdateWorkshiftRewards(reward, value)
	if (!self.workshiftData.rewards) then
		self.workshiftData.rewards = {}
	end

	local participant = self.workshiftData.participants[self.workshiftNextPrev.pos] and self.workshiftData.participants[self.workshiftNextPrev.pos].charID or false

	if !participant then return end

	if !self.workshiftData.rewards[participant] then
		self.workshiftData.rewards[participant] = {}
	end

	self.workshiftData.rewards[participant][reward] = value

	net.Start("ix.terminal.CWUWorkshiftRewardUpdate")
		net.WriteEntity(self:GetTerminalEntity())
		net.WriteString(util.TableToJSON(self.workshiftData.rewards))
	net.SendToServer()
end

function PANEL:ProceedShiftBuilding(data)
	self.workshiftData = data
	if self.workshiftData.participants and istable(self.workshiftData.participants) and !table.IsEmpty(self.workshiftData.participants) then
		self:SortParticipants()
	else
		self.workshiftData.participants = {}
	end

	if !self.workshiftData.rewards or !istable(self.workshiftData.rewards) or table.IsEmpty(self.workshiftData.rewards) then
		self.workshiftData.rewards = {}
	end

	self.shiftPanel = self.shift:Add("Panel")
	self.shiftPanel:Dock(FILL)
	self.shiftPanel:DockMargin(24, 24, 24, 48)
	self.shiftPanel:SetAlpha(0)
	self.shiftPanel:InvalidateParent(true)
	self.shiftPanel.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end
	self:BuildShift(self.shiftPanel)

	for _, child in pairs(self.shift:GetChildren()) do
		child:AlphaTo(255, 0.95)
	end
end

function PANEL:RequestShift()
	net.Start("ix.terminal.CWUWorkshiftData")
		net.WriteEntity(self:GetTerminalEntity())
	net.SendToServer()
end

function PANEL:SetupOptions()
	self.options = {
		["CITY STOCK"] = function()
			self.cityStock = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
			defClr,
			function()
				if !IsValid(self.cityStock) then return end

				self.items = {}

				self:GetTerminalEntity():EmitSound("willardnetworks/datapad/open.wav", 55, 100, 1, nil, 0, 11)

				self.stockLabel = self.cityStock:Add("DLabel")
				self.stockLabel:Dock(TOP)
				self.stockLabel:DockMargin(0, 8, 0, 0)
				self.stockLabel:SetContentAlignment(5)
				self.stockLabel:SetFont("WNTerminalLargeText")
				self.stockLabel:SetText(string.utf8upper("[city stock]"))
				self.stockLabel:SetTextColor(defClr)
				self.stockLabel:SizeToContents()
				self.stockLabel:SetAlpha(0)

				self.itemPanel = self.cityStock:Add("Panel")
				self.itemPanel:Dock(FILL)
				self.itemPanel:DockMargin(64, 4, 64, 64)
				self.itemPanel:InvalidateParent(true)
				self.itemPanel.Paint = function(s, w, h)
					surface.SetDrawColor(defClr)
					surface.DrawOutlinedRect(0, 0, w, h, 2)
				end
				self.itemPanel:SetAlpha(0)

				self:RequestStock()

				for _, child in pairs(self.cityStock:GetChildren()) do
					child:AlphaTo(255, 0.95)
				end
			end)

			return self.cityStock
		end,

		["STATUS"] = function()
			self.status = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
			defClr,
			function()
				if !IsValid(self.status) then return end

				self:RequestStatusInfo()
			end)
			return self.status
		end,

		["MARKET"] = function()
			self.market = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
			defClr,
			function()
				if !IsValid(self.market) then return end

				self.marketPanel = self.market:Add("Panel")
				self.marketPanel:Dock(FILL)
				self.marketPanel:SetAlpha(0)
				self.marketPanel:InvalidateParent(true)

				self:RequestMarket()

				for _, child in pairs(self.market:GetChildren()) do
					child:AlphaTo(255, 0.95)
				end
			end)
			return self.market
		end,

		["CART"] = function()
			self.cartP = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
			defClr,
			function()
				if !IsValid(self.cartP) then return end

				self.cartPanel = self.cartP:Add("Panel")
				self.cartPanel:Dock(FILL)
				self.cartPanel:SetAlpha(0)
				self.cartPanel:InvalidateParent(true)

				self:RequestCartInfo()

				for _, child in pairs(self.cartP:GetChildren()) do
					child:AlphaTo(255, 0.95)
				end
			end)
			return self.cartP
		end,

		["SHIFT"] = function()
			self.shift = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
			defClr,
			function()
				if !IsValid(self.shift) then return end

				self:RequestShift()
			end)
			return self.shift
		end,
	}
end

function PANEL:AuthError()
	self:PurgeInnerContent()
	self:SetParalyzed(true)
	self.authPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	redClr,
	function()
		if !IsValid(self.authPanel) then return end

		self:GetTerminalEntity():EmitSound("buttons/combine_button1.wav", 55, 100, 1, nil, 0, 11)

		self.bottomLabel = self.authPanel:Add("DLabel")
		self.bottomLabel:SetFont("WNTerminalLargeText")
		self.bottomLabel:SetText(string.utf8upper("auth error!"))
		self.bottomLabel:SetTextColor(redClr)
		self.bottomLabel:Dock(BOTTOM)
		self.bottomLabel:DockMargin(0, 0, 0, 32)
		self.bottomLabel:SetContentAlignment(5)
		self.bottomLabel:SizeToContents()
		self.bottomLabel:SetAlpha(0)

		self.upperLabel = self.authPanel:Add("DLabel")
		self.upperLabel:Dock(TOP)
		self.upperLabel:DockMargin(1, 64, 1, 0)
		self.upperLabel:SetHeight(self:GetParent():GetTall() * 0.1)
		self.upperLabel:SetContentAlignment(5)
		self.upperLabel:SetFont("WNTerminalMediumText")
		self.upperLabel:SetText(string.utf8upper("[PLEASE WAIT FOR CIVIL PROTECTION TO ARRIVE // DO NOT LEAVE]"))
		self.upperLabel:SetTextColor(redClr)
		self.upperLabel.Paint = function(s, w, h)
			surface.SetDrawColor(self.authPanel:GetColor())
			surface.DrawRect(0, 0, w, h)

			surface.SetMaterial(cmbLabel)
			surface.SetDrawColor(self.authPanel:GetColor())
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.upperLabel:SetAlpha(0)

		self.cmbLogo = self.authPanel:Add("Panel")
		self.cmbLogo:SetSize(400, 500)
		self.cmbLogo:Center()
		self.cmbLogo.Paint = function(s, w, h)
			surface.SetMaterial(cmbLogo)
			surface.SetDrawColor(self.authPanel:GetColor())
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.cmbLogo:SetAlpha(0)

		for _, child in pairs(self.authPanel:GetChildren()) do
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:Proceed()
	if (!self:IsUsedByLocalPlayer()) then
		self:CreateLock()
	else
		if (!self:GetUserGenData()) then
			self:RequestCID()
		else
			self:SetParalyzed(false)
		end
	end
end

function PANEL:CanCreateOption()
	return !self:GetParalyzed()
end

function PANEL:CreateOption(option)
	self:GetTerminalEntity():EmitSound("buttons/lightswitch2.wav", 55, 100, 1, nil, 0, 11)
	if self.options[option] and self.currentOption.id != option and self:CanCreateOption() then
		if self.currentOption and self.currentOption.pnl then
			self.currentOption.pnl:Remove()
		end

		local newOption = self.options[option]()

		self.currentOption = {id = option, pnl = newOption}
	elseif self.options[option] and self.currentOption.id == option and self:CanCreateOption() and !self.currentOption.pnl.bClosing then
		self.currentOption.pnl.bClosing = true
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/close.wav", 55, 100, 1, nil, 0, 11)
		self.currentOption.pnl:AlphaTo(0, 0.5, 0, function()
			self.currentOption.pnl:Remove()
			self.currentOption = {}
		end)
	end
end

function PANEL:Destroy()
	self:AlphaTo(0, 0.5, 0, function(animData, pnl)
		self:GetTerminalEntity().terminalPanel = nil
		pnl:Remove()
	end)
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 225)
	surface.SetMaterial(screenMat)
	surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("ixCWUTerminalMenu", PANEL, "Panel")