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

function PANEL:CreateDivider(parent, dock)
	local divider = parent:Add("Panel")
	divider:Dock(dock)
	divider:SetHeight(SScaleMin(10 / 3))
	divider.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawLine(0, h * 0.5, w, h * 0.5)
	end
end

function PANEL:AddShop(parent, shopName, shopTenants)
	local shopPnl = parent:Add("Panel")
	shopPnl:Dock(TOP)
	shopPnl:SetHeight(SScaleMin(128 / 3))
	shopPnl:DockMargin(SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
	shopPnl.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local nameLabel = shopPnl:Add("DLabel")
	nameLabel:SetContentAlignment(5)
	nameLabel:SetFont("TitlesFont")
	nameLabel:SetText(string.upper(shopName))
	nameLabel:Dock(TOP)
	nameLabel:SizeToContents()
	nameLabel:DockMargin(0, SScaleMin(6 / 3), 0, 0)

	local shopOwners = shopPnl:Add("DLabel")
	shopOwners:SetContentAlignment(5)
	shopOwners:SetFont("MenuFontLargerBoldNoFix")
	shopOwners:SetText("OWNERS")
	shopOwners:Dock(TOP)
	shopOwners:SizeToContents()

	local concatOwners = table.concat(shopTenants, ", ")

	local ownersLabel = shopPnl:Add("DLabel")
	ownersLabel:SetFont("MenuFontLargerBoldNoFix")
	ownersLabel:SetText(concatOwners)
	ownersLabel:Dock(FILL)
	ownersLabel:DockMargin(SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
	ownersLabel:SetWrap(true)
	ownersLabel:SetAutoStretchVertical(true)
	ownersLabel.PaintOver = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		DisableClipping(true)
			surface.DrawOutlinedRect(-2, 0, w, h, 1)
		DisableClipping(false)
	end

end

function PANEL:Populate(shopTbl)
	for k, v in pairs(shopTbl) do
		self:AddShop(self.shopScroller, v.shopName, !table.IsEmpty(v.tenants) and v.tenants or {"NO OWNERS"})
	end
end

function PANEL:Init()
	if (ix.gui.shopOverwiew and ix.gui.shopOverwiew != self) then
		ix.gui.shopOverwiew:Remove()
	end

	ix.gui.shopOverwiew = self

	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)

	self.innerContent = self:Add("Panel")
	self.innerContent:SetSize(SScaleMin(900 / 3), SScaleMin(640 / 3))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	self.innerContent.Paint = function(s, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.topbar = self.innerContent:Add("Panel")
	self.topbar:SetHeight(SScaleMin(40 / 3))
	self.topbar:Dock(TOP)
	self.topbar.Paint = function(s, width, height)
		surface.SetDrawColor(8, 8, 8, 130)
		surface.DrawRect(0, 0, width, height)

		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawLine(0, height * 0.95, width, height * 0.95)
	end

	local exit = self.topbar:Add("DImageButton")
	exit:SetMaterial(Material("willardnetworks/tabmenu/navicons/exit.png", "smooth"))
	exit:SetSize(SScaleMin(25 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local titleText = self.topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("Shop overview")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	self.shopScroller = self.innerContent:Add("DScrollPanel")
	self.shopScroller:Dock(FILL)
	self.shopScroller:DockMargin(SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
	self.shopScroller.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 2)
	end
	self:AlphaTo(255, 0.5)
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(63, 58, 115, 220)
	surface.DrawRect(0, 0, w, h)

	Derma_DrawBackgroundBlur(self, 1)
end

vgui.Register("ixShopOverview", PANEL, "Panel")