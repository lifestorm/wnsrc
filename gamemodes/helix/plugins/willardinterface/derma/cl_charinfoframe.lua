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
	local margin = SScaleMin(10 / 3)
	local smallerIconSize = SScaleMin(16 / 3)
	local parent = self:GetParent()

	self:SetSize(parent:GetWide() * 0.5, parent:GetTall())
	self:Dock(LEFT)

	local imgBackground = self:Add("DImage")
	local invImage = LocalPlayer():GetFactionVar("inventoryImage", "materials/willardnetworks/tabmenu/inventory/backgrounds/street.png")
	imgBackground:SetImage(invImage)
	imgBackground:SetKeepAspect(true)
	imgBackground:Dock(FILL)
	imgBackground:SetWide(self:GetWide() * 0.65)

	local statusArea = self:Add("Panel")
	statusArea:Dock(RIGHT)
	statusArea:SetWide(self:GetWide() * 0.35)
	statusArea.Paint = function( this, w, h )
		surface.SetDrawColor(Color(255, 255, 255, 10))
		surface.DrawRect(0, 0, w, h )
	end

	local innerStatus = statusArea:Add("Panel")
	innerStatus:SetSize(statusArea:GetWide() - (margin * 2), statusArea:GetTall())
	innerStatus:Dock(FILL)
	innerStatus:DockMargin(margin * 2, 0, margin * 2, 0)

	local function CreateTitle(parent2, text)
		parent2:Dock(TOP)
		parent2:DockMargin(0, margin * 2 - (margin * 0.5), 0, margin * 0.5, 0)
		parent2:SetText(text)
		parent2:SetContentAlignment(4)
		parent2:SetFont("MenuFontLargerNoClamp")
		parent2:SizeToContents()
	end

	local function CreateSubBar(parent3, iconImage, title, text, iconW, iconH)
		local SScaleMin25 = SScaleMin(25 / 3)
		parent3:Dock(TOP)
		parent3:DockMargin(0, margin * 0.5, 0, 0)
		parent3:SetSize(innerStatus:GetWide(), SScaleMin25)

		local leftSideSub = parent3:Add("Panel")
		leftSideSub:Dock(LEFT)
		leftSideSub:SetSize(parent3:GetWide() * 0.65, SScaleMin25)

		local rightSideSub = parent3:Add("Panel")
		rightSideSub:Dock(FILL)
		rightSideSub:SetSize(parent3:GetWide() * 0.35, SScaleMin25)

		local iconPanel = leftSideSub:Add("Panel")
		iconPanel:Dock(LEFT)
		iconPanel:SetSize(iconW, parent3:GetTall())

		local icon = iconPanel:Add("DImage")
		icon:SetSize(iconW, iconH)
		icon:SetImage(iconImage)
		icon:SetPos(0, iconPanel:GetTall() * 0.5 - icon:GetTall() * 0.5)

		local leftTitle = leftSideSub:Add("DLabel")
		leftTitle:SetFont("MenuFontLargerNoClamp")
		leftTitle:SetText(title or "")
		leftTitle:SetContentAlignment(4)
		leftTitle:Dock(LEFT)
		leftTitle:DockMargin(margin, 0, 0, 0)
		leftTitle:SizeToContents()

		local rightText = rightSideSub:Add("DLabel")
		rightText:SetFont("MenuFontLargerNoClamp")
		rightText:SetText(text or "")
		rightText:SetContentAlignment(6)
		rightText:Dock(RIGHT)
		rightText:SizeToContents()
	end

	local statusTitle = innerStatus:Add("DLabel")
	CreateTitle(statusTitle, "STATUS")

	local hp = innerStatus:Add("Panel")
	CreateSubBar(hp, "willardnetworks/hud/cross.png", "Health", LocalPlayer():Health(), smallerIconSize, smallerIconSize)

	local armor = innerStatus:Add("Panel")
	CreateSubBar(armor, "willardnetworks/hud/shield.png", "Armor", LocalPlayer():Armor(), smallerIconSize, smallerIconSize)

	hook.Run("AdjustInnerStatusPanel", innerStatus, CreateTitle, CreateSubBar)

	self.model = imgBackground:Add("ixModelPanel")
	self.model:Dock(FILL)
	self.model:SetFOV(ScrW() > 1920 and 50 or 40)
	self.model:SetModel(LocalPlayer():GetModel(), LocalPlayer():GetSkin(), true)

	local rotatePanel = self:Add("Panel")
	rotatePanel:Dock(BOTTOM)
	rotatePanel:SetTall(SScaleMin(50 / 3))

	self.rLeft = rotatePanel:Add("DButton")
	self.rLeft:Dock(LEFT)
	self.rLeft:SetWide(imgBackground:GetWide() / 2)
	self.rLeft:SetText("")
	self:CreateArrow(self.rLeft, imgBackground, "back_arrow")

	self.rRight = rotatePanel:Add("DButton")
	self.rRight:Dock(FILL)
	self.rRight:SetText("")
	self:CreateArrow(self.rRight, imgBackground, "right-arrow")

	ix.gui.inventoryModel = self.model
end

function PANEL:CreateArrow(parent, imgBackground, path)
	local s5 = SScaleMin(5 / 3)
	local s40 = SScaleMin(40 / 3)
	local imgbgWD2 = imgBackground:GetWide() / 2
	local lrMargin = (imgbgWD2 - s40) * 0.5

	local arrow = parent:Add("DImage")
	arrow:Dock(FILL)
	arrow:DockMargin(lrMargin, s5, lrMargin, s5)
	arrow:SetImage("willardnetworks/mainmenu/"..path..".png")
end

function PANEL:Think()
	if !istable(ix.gui.inventoryModel) then
		ix.gui.inventoryModel = self.model
	end

	if !self.rLeft or self.rLeft and !IsValid(self.rLeft) then return end
	if !self.rRight or self.rRight and !IsValid(self.rRight) then return end

	if self.rLeft:IsDown() then
		if IsValid(self.model.Entity) then
			self.model.Entity:SetAngles(self.model.Entity:GetAngles() - Angle(0, 1, 0))
		end
	end

	if self.rRight:IsDown() then
		if IsValid(self.model.Entity) then
			self.model.Entity:SetAngles(self.model.Entity:GetAngles() + Angle(0, 1, 0))
		end
	end
end

vgui.Register("CharFrame", PANEL, "Panel")