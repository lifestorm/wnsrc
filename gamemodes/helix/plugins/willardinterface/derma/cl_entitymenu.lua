--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local animationTime = 1
local padding = 32

-- entity menu button
DEFINE_BASECLASS("ixMenuButton")
local PANEL = {}

AccessorFunc(PANEL, "callback", "Callback")

function PANEL:Init()
	self:SetTall(ScrH() * 0.1)
	self:Dock(TOP)
	self:SetFont("MenuFontBoldNoClamp")
	self.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)
		
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, h - 1, w, h - 1)
		
		if self:IsHovered() then
			self:SetTextColor(Color(230, 230, 230, 255))
		else
			self:SetTextColor(color_white)
		end	
	end
end

function PANEL:DoClick()
	local bStatus = true
	local parent = ix.menu.panel
	local entity = parent:GetEntity()

	if (parent.bClosing) then
		return
	end

	if (isfunction(self.callback)) then
		bStatus = self.callback()
	end

	if (bStatus != false) then
		ix.menu.NetworkChoice(entity, self.originalText, bStatus)
	end

	parent:Remove()
end

function PANEL:SetText(text)
	self.originalText = text
	BaseClass.SetText(self, text)
end

vgui.Register("ixEntityMenuButton", PANEL, "ixMenuButton")

-- entity menu list
DEFINE_BASECLASS("EditablePanel")
PANEL = {}

function PANEL:Init()
	self.list = {}
	self.titleBar = self:Add("Panel")
	self.titleBar:SetTall(SScaleMin(20 / 3))
	self.titleBar:Dock(TOP)
	self.titleBar.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 78, 69, 255))
		surface.DrawRect(0, 0, w, h)
	end
	
	self.title = self.titleBar:Add("DLabel")
	self.title:Dock(FILL)
	self.title:SetFont("MenuFontLargerBoldNoFix")
	self.title:SetContentAlignment(5)
	self.title:SizeToContents()
	self.title:SetText("Interactions")
	
	self.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)
		
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)
	end
end

function PANEL:AddOption(text, callback)
	local panel = self:Add("ixEntityMenuButton")
	panel:SetText(text)
	panel:SetCallback(callback)
	panel:Dock(TOP)

	self.list[#self.list + 1] = panel
end

function PANEL:SizeToContents()
	local height = 0

	for i = 1, #self.list do
		height = height + self.list[i]:GetTall()
	end
	
	height = height + self.titleBar:GetTall()

	self:SetSize(SScaleMin(200 / 3), height)
end

vgui.Register("ixEntityMenuList", PANEL, "EditablePanel")

-- entity menu
DEFINE_BASECLASS("EditablePanel")
PANEL = {}

AccessorFunc(PANEL, "entity", "Entity")
AccessorFunc(PANEL, "bClosing", "IsClosing", FORCE_BOOL)
AccessorFunc(PANEL, "desiredHeight", "DesiredHeight", FORCE_NUMBER)

function PANEL:Init()
	if (IsValid(ix.menu.panel)) then
		self:Remove()
		return
	end

	-- close entity tooltip if it's open
	if (IsValid(ix.gui.entityInfo)) then
		ix.gui.entityInfo:Remove()
	end

	ix.menu.panel = self

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)

	self.list = self:Add("ixEntityMenuList")

	self.desiredHeight = 0
	self.blur = 0
	self.alpha = 1
	self.bClosing = false
	self.lastPosition = vector_origin

	self:CreateAnimation(animationTime, {
		target = {blur = 1},
		easing = "outQuint"
	})

	self:MakePopup()
end

function PANEL:SetOptions(options)
	for k, v in SortedPairs(options) do
		self.list:AddOption(k, v)
	end

	self.list:SizeToContents()
	self.list:Center()
end

function PANEL:Think()
	local entity = self.entity
	local distance = 0

	if (IsValid(entity)) then
		local position = entity:GetPos()
		distance = LocalPlayer():GetShootPos():DistToSqr(position)

		if (distance > 65536) then
			self:Remove()
			return
		end

		self.lastPosition = position
	end
end

function PANEL:GetOverviewInfo(origin, angles)
	return angles
end

function PANEL:OnMousePressed(code)
	if (code == MOUSE_LEFT) then
		self:Remove()
	end
end

function PANEL:Remove()
	if (self.bClosing) then
		return
	end

	self.bClosing = true

	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	gui.EnableScreenClicker(false)

	self:CreateAnimation(animationTime * 0.5, {
		target = {alpha = 0},
		index = 2,
		easing = "outQuint",

		Think = function(animation, panel)
			panel:SetAlpha(panel.alpha * 255)
		end,

		OnComplete = function(animation, panel)
			ix.menu.panel = nil
			BaseClass.Remove(self)
		end
	})
end

vgui.Register("ixEntityMenu", PANEL, "EditablePanel")
