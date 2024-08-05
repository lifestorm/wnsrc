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
local defClr = Color(16, 224, 207)
local redClr = Color(200, 36, 36)
local greenClr = Color(36, 200, 61)
local backgroundColor = Color(9, 9, 9, 75)

local PANEL = {}

AccessorFunc(PANEL, "terminalEntity", "TerminalEntity")

local scrwSrn, scrhSrn = 1600, 1400

PANEL.shopTerminal = true

local function CreateButton(name, text, path, font, alignment)
	name:SetContentAlignment(alignment or 4)
	name:SetTextInset(alignment and 0 or 10, 0)
	name:SetFont(font or "WNTerminalMediumText")
	name:SetText(string.utf8upper(text))
	name.Paint = function(self, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawRect(0, 0, w, h)
	end
end

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
	panel:SetAlpha(0)

	panel:AlphaTo(255, 0.75, 0, function()
		if callback then
			callback()
		end
	end)

	panel.Paint = function(s, w, h)
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

function PANEL:CreateNextPrev(parent, buttonFont, buttonAlign, prevFunc, nextFunc, bHorizontal, manualWidth)
	print(buttonFont)
	local nextButton = parent:Add("DButton")
	CreateButton(nextButton, "next", nil, buttonFont, buttonAlign)
	nextButton.DoClick = nextFunc

	local prevButton = parent:Add("DButton")
	CreateButton(prevButton, "previous", nil, buttonFont, buttonAlign)
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

function PANEL:Init()
	self:SetSize(scrwSrn, scrhSrn)
	self:SetPos(0, 0)

	self.innerContent = self:Add("Panel")
	self.innerContent:Dock(FILL)
	self.innerContent:DockMargin(107, 134, 107, 114)
	self.innerContent:InvalidateParent(true)
	self:SetPaintedManually( true )

	self.selectedPermits = 0
	self.permits = {}
	for k, permit in pairs(ix.permits.list) do
		self.permits[#self.permits + 1] = {id = k, pInfo = permit, selected = false}
	end
end

function PANEL:PurgeInnerContent()
	for _, pnl in pairs(self.innerContent:GetChildren()) do
		pnl:Remove()
	end
end

function PANEL:CreatePermitSelector(parent)
	local nextPrev = parent:Add("Panel")
	nextPrev:Dock(TOP)
	nextPrev:SetTall(parent:GetTall() / 2)
	nextPrev:InvalidateParent(true)
	nextPrev.Paint = function(s, w, h)
		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local incrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		if (self.curPermit) then
			self.curPermit:Increment()
		end
	end
	local decrementFunc = function(s)
		self:GetTerminalEntity():EmitSound("willardnetworks/datapad/back.wav", 55, 100, 1, nil, 0, 11)

		if (self.curPermit) then
			self.curPermit:Decrement()
		end
	end
	self:CreateNextPrev(nextPrev, "WNTerminalMediumText", 5, decrementFunc, incrementFunc, true)

	self.curPermit = parent:Add("DLabel")
	self.curPermit:Dock(FILL)
	self.curPermit:DockMargin(6, 6, 6, 6)
	self.curPermit:SetContentAlignment(5)
	self.curPermit:SetFont("WNTerminalLargeText")
	self.curPermit:SetText(string.utf8upper(self.permits[1].id))
	self.curPermit:SizeToContents()
	self.curPermit.pos = 1
	self.curPermit:SetTextColor(self.permits[self.curPermit.pos].selected and greenClr or redClr)

	self.curPermit.Paint = function(s, w, h)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(defClr)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	self.curPermit.Increment = function(s)
		if self.permits[s.pos + 1] then
			s.pos = s.pos + 1
			s:Update()
		end
	end

	self.curPermit.Decrement = function(s)
		if self.permits[s.pos - 1] then
			s.pos = s.pos - 1
			s:Update()
		end
	end

	self.curPermit.Update = function(s)
		s:SetText(string.utf8upper(self.permits[s.pos].id))
		s:SetTextColor(self.permits[s.pos].selected and greenClr or redClr)

		if self.sPermits then
			self.sPermits:SetText(string.utf8upper("selected permits: ").."["..self.selectedPermits.."/3]")
		end
	end
end

function PANEL:CanSelectPermit()
	return self.selectedPermits < 3
end

function PANEL:BuildShopPanel(shop)
	self:PurgeInnerContent()

	self.shopPanel = self:CreateAnimatedFrame(self.innerContent, FILL, 0, 0, 0, 0,
	defClr,
	function()
		if !IsValid(self.shopPanel) then return end

		for _, child in pairs(self.shopPanel:GetChildren()) do
			child:Remove()
		end

		local upperLabel = self.shopPanel:Add("DLabel")
		upperLabel:Dock(TOP)
		upperLabel:DockMargin(0, 32, 0, 0)
		upperLabel:SetContentAlignment(5)
		upperLabel:SetFont("WNTerminalMoreLargerText")
		upperLabel:SetText(string.utf8upper("shop terminal"))
		upperLabel:SetTextColor(defClr)
		upperLabel:SizeToContents()

		self:CreateDivider(self.shopPanel, TOP)

		if shop.shopName and shop.cost and shop.scReq and shop.rent then
			self.shopName = self.shopPanel:Add("DLabel")
			self.shopName:Dock(TOP)
			self.shopName:DockMargin(0, 8, 0, 0)
			self.shopName:SetContentAlignment(5)
			self.shopName:SetFont("WNTerminalLargeText")
			self.shopName:SetText(string.utf8upper(shop.shopName))
			self.shopName:SetTextColor(defClr)
			self.shopName:SizeToContents()

			self.shopInfo = self.shopPanel:Add("DLabel")
			self.shopInfo:Dock(TOP)
			self.shopInfo:DockMargin(0, 8, 0, 0)
			self.shopInfo:SetContentAlignment(5)
			self.shopInfo:SetFont("WNTerminalLargeText")
			self.shopInfo:SetText(string.utf8upper("sc req: ")..shop.scReq.." | "..shop.cost..string.utf8upper(" credits").." | " .. shop.rent .. string.utf8upper(" rent"))
			self.shopInfo:SetTextColor(defClr)
			self.shopInfo:SizeToContents()

			self:CreateDivider(self.shopPanel, TOP)

			local isPurchasable = self:GetTerminalEntity():GetNetVar("isPurchasable", false)
			self.isPurchasable = self.shopPanel:Add("DLabel")
			self.isPurchasable:Dock(TOP)
			self.isPurchasable:DockMargin(0, 8, 0, 0)
			self.isPurchasable:SetContentAlignment(5)
			self.isPurchasable:SetFont("WNTerminalLargeText")
			self.isPurchasable:SetText(isPurchasable and string.utf8upper("this shop is purchasable") or string.utf8upper("this shop is not purchasable"))
			self.isPurchasable:SetTextColor(isPurchasable and greenClr or redClr)
			self.isPurchasable:SizeToContents()

			self:CreateDivider(self.shopPanel, TOP)

			if isPurchasable then
				local permitSelector = self.shopPanel:Add("Panel")
				permitSelector:Dock(TOP)
				permitSelector:DockMargin(16, 8, 16, 0)
				permitSelector:SetTall(168)
				permitSelector:InvalidateParent(true)
				self:CreatePermitSelector(permitSelector)

				self.selectPermit = self.shopPanel:Add("DButton")
				CreateButton(self.selectPermit, "toggle permit", nil, "WNTerminalMediumText", 5)
				self.selectPermit:Dock(TOP)
				self.selectPermit:DockMargin(32, 0, 32, 0)
				self.selectPermit:SizeToContents()
				self.selectPermit.DoClick = function()
					if self.permits[self.curPermit.pos].selected then
						self.selectedPermits = self.selectedPermits - 1
						self.permits[self.curPermit.pos].selected = !self.permits[self.curPermit.pos].selected
						self.curPermit:Update()
						self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)
					else
						if self:CanSelectPermit() then
							self.selectedPermits = self.selectedPermits + 1
							self.permits[self.curPermit.pos].selected = !self.permits[self.curPermit.pos].selected
							self.curPermit:Update()
							self:GetTerminalEntity():EmitSound("buttons/button18.wav", 55, 100, 1, nil, 0, 11)
						else
							self:GetTerminalEntity():EmitSound("buttons/button8.wav", 55, 100, 1, nil, 0, 11)
						end
					end
				end

				self.sPermits = self.shopPanel:Add("DLabel")
				self.sPermits:Dock(TOP)
				self.sPermits:DockMargin(0, 8, 0, 0)
				self.sPermits:SetContentAlignment(5)
				self.sPermits:SetFont("WNTerminalMediumText")
				self.sPermits:SetTextColor(defClr)
				self.sPermits:SetText(string.utf8upper("selected permits: ").."["..self.selectedPermits.."/3]")
				self.sPermits:SizeToContents()

				local buttonPanel = self.shopPanel:Add("Panel")
				buttonPanel:Dock(BOTTOM)
				buttonPanel:DockMargin(12, 0, 12, 108)
				buttonPanel:SetTall(108)
				buttonPanel.Paint = function(s, w, h)
					surface.SetDrawColor(backgroundColor)
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(defClr)
					surface.DrawOutlinedRect(0, 0, w, h, 1)
				end

				self.purchaseButton = buttonPanel:Add("DButton")
				CreateButton(self.purchaseButton, "purchase shop", nil, "WNTerminalLargeText", 5)
				self.purchaseButton:Dock(FILL)
				self.purchaseButton:DockMargin(8, 8, 8, 8)
				self.purchaseButton.DoClick = function()
					local permits = {}
					for _, permit in pairs(self.permits) do
						if permit.selected then
							permits[permit.id] = true
						end
					end

					netstream.Start("BuyShopViaTerminal", self:GetTerminalEntity(), permits)
				end
			end
		end

		for _, child in pairs(self.shopPanel:GetChildren()) do
			child:SetAlpha(0)
			child:AlphaTo(255, 0.95)
		end
	end)
end

function PANEL:Destroy()
	self:AlphaTo(0, 0.5, 0, function(animData, pnl)
		self:GetTerminalEntity().terminalPanel = nil
		pnl:Remove()
	end)
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 245)
	surface.SetMaterial(screenMat)
	surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("ixShopTerminal", PANEL, "Panel")

netstream.Hook("UpdateShopScreen", function()
	local panelList = ix.factoryPanels.list

	for i = 1, #ix.factoryPanels.list do
		local panel = panelList[i]

		if panel.shopTerminal then
			local ent = panel:GetTerminalEntity()
			panel:BuildShopPanel({
				shopName = ent:GetShop(),
				cost = ent:GetShopCost(),
				scReq = ent:GetShopSocialCreditReq(),
				rent = ent:GetNetVar("Rent", 0)
			})
		end
	end
end)