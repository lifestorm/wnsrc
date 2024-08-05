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

slib.setTheme("maincolor", Color(36,36,36))
slib.setTheme("accentcolor", Color(66,179,245))
slib.setTheme("margin", slib.getScaledSize(3, "x"))
slib.setTheme("textcolor", Color(255,255,255))
slib.setTheme("neutralcolor", Color(0,0,200,40))
slib.setTheme("topbarcolor", Color(44,44,44))
slib.setTheme("sidebarcolor", Color(34,34,34))
slib.setTheme("sidebarbttncolor", Color(39,39,39))
slib.setTheme("whitecolor", Color(255,255,255))
slib.setTheme("hovercolor", Color(255,255,255,100))
slib.setTheme("orangecolor", Color(130, 92, 10))
slib.setTheme("successcolor", Color(0,200,0))
slib.setTheme("failcolor", Color(200,0,0))
slib.setTheme("bgblur", true)

local topbarcolor, topbarcolor_min10, sidebarcolor, sidebarbttncolor, textcolor, accentcolor, maincolor, maincolor_7, maincolor_15, hovercolor = slib.getTheme("topbarcolor"), slib.getTheme("topbarcolor", -10), slib.getTheme("sidebarcolor"), slib.getTheme("sidebarbttncolor"), slib.getTheme("textcolor"), slib.getTheme("accentcolor"), slib.getTheme("maincolor"), slib.getTheme("maincolor", 7), slib.getTheme("maincolor", 15), slib.getTheme("hovercolor")
local accentcol_a100 = slib.getTheme("accentcolor")
accentcol_a100.a = 100

local black_a160 = Color(0,0,0,160)
local black_a140 = Color(0,0,0,140)

function PANEL:Init()
	self.topbarheight = slib.getScaledSize(30, "y")
	self.font = slib.createFont("Roboto", 21)
	self.tab = {}
	self.iterator = 0

	self.topbar = vgui.Create("EditablePanel", self)
	self.topbar:SetCursor("sizeall")
	self.topbar:SetSize(self:GetWide(), self.topbarheight)

	self.topbar.OnSizeChanged = function()
		if IsValid(self.close) then
			self.close:SetPos(self.topbar:GetWide() - self.close:GetWide() - slib.getScaledSize(3,"x"), 0)
		end
	end

	self.topbar.Paint = function(s, w, h)
		if !s.Holding and input.IsMouseDown(MOUSE_LEFT) then
				if s:IsHovered() then
					s.Move = true
				end

				s.Holding = true
				local x, y = gui.MouseX(), gui.MouseY()
				s.startedx, s.startedy = s:ScreenToLocal(x, y)
		elseif s.Holding and !input.IsMouseDown(MOUSE_LEFT) then
			s.Holding = nil
			s.Move = nil
		end

		if s.Move then
			local x, y = gui.MouseX(), gui.MouseY()
			local offsetx, offsety =  s:ScreenToLocal(x, y)
			
			self:SetPos(x - s.startedx, y - s.startedy)
		end

		draw.RoundedBoxEx(5, 0, 0, w, h, topbarcolor, true, true)

		surface.SetDrawColor(black_a160)
		surface.DrawRect(0, h - 1, w, 1)

		surface.SetDrawColor(black_a140)
		surface.DrawRect(0, h - 2, w, 1)
		draw.SimpleText(self.title, self.font, slib.getScaledSize(3,"x"), h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	self.frame = vgui.Create("EditablePanel", self)

	self.frame.Resize = function()
		local wide = 0

		if self.tabmenu then
			wide = wide + self.tabmenu:GetWide()
		end

		self.frame:SetPos(wide,self.topbarheight)
		self.frame:SetSize(self:GetWide() - wide, self:GetTall() - self.topbarheight)
		
		for k,v in pairs(self.tab) do
			self.tab[k]:SetSize(self.frame:GetWide(), self.frame:GetTall())
		end
	end

	self.frame.Resize()

	self.MadePanel = SysTime()

	slib.wrapFunction(self, "SetSize", nil, function() return self end, true)
	slib.wrapFunction(self, "SetWide", nil, function() return self end, true)
	slib.wrapFunction(self, "Center", nil, function() return self end, true)
	slib.wrapFunction(self, "SetPos", nil, function() return self end, true)
	slib.wrapFunction(self, "MakePopup", nil, function() return self end, true)
	slib.wrapFunction(self, "DockPadding", nil, function() return self end, true)
end

function PANEL:OnRemove()
	if !IsValid(self.bgclose) then return end
	self.bgclose:Remove()
end

function PANEL:SetBG(bool, close, col, makepopup)
	if !bool and IsValid(self.bgclose) then
		self:SetParent()
		self.bgclose:Remove()
		
		return
	end

	local parent = self:GetParent()

	local w, h

	if IsValid(parent) then
		w, h = parent:GetSize() 
	else
		w, h = ScrW(), ScrH()
	end

	self.bgclose = vgui.Create("SButton", parent)
	self.bgclose:SetSize(w, h)

	if makepopup then
		self.bgclose:MakePopup()
	else
		self.bgclose:MoveToFront()
	end

	self.bgclose.DoClick = function()
		if !close then return end

		if IsValid(self.bgclose) then
			self.bgclose:Remove()
		end

		if IsValid(self) then
			self:Remove()
		end
	end

	self.bgclose.bg = col

	self.bgclose.Paint = function(s,w,h)
		if !IsValid(self) then s:Remove() end
		
		if !s.bg then return end
		surface.SetDrawColor(s.bg)
		surface.DrawRect(0,0,w,h)
	end

	self:SetParent(self.bgclose)
	self:MoveToFront()
	
	return self
end

function PANEL:SetDraggable(bool)
	if IsValid(self.topbar) then
		self.topbar:SetMouseInputEnabled(bool)
	end

	return self
end

function PANEL:setTitle(str, font)
	self.title = str

	if font then
		self.font = font
	end
	
	return self
end

function PANEL:addCloseButton()
	self.close = vgui.Create("DButton", self)
	self.close:SetSize(slib.getScaledSize(25, "y"),slib.getScaledSize(25, "y"))
	self.close:SetMouseInputEnabled(true)
	self.close:SetPos(self.topbar:GetWide() - self.close:GetWide() - slib.getScaledSize(3,"x"), self.topbarheight * .5 - self.close:GetTall() * .5)
	self.close:SetText("")

	self.close.DoClick = function()
		if isfunction(self.onClose) then
			self.onClose()
		end
		
		if self.onlyHide then
			self:SetVisible(false)
		return end

		self:Remove()
	end

	self.close.Paint = function(s,w,h)
		local width = slib.getScaledSize(2, "X")
		local height = h * .7

		draw.NoTexture()

		local wantedCol = s:IsHovered() and color_white or hovercolor

        surface.SetDrawColor(slib.lerpColor(s, wantedCol))
		surface.DrawTexturedRectRotated(w - (height * .5), h * .5 - (width * .5), width, height, 45)
		surface.DrawTexturedRectRotated(w - (height * .5), h * .5 - (width * .5), width, height, -45)
	end

	return self
end

function PANEL:OnSizeChanged()
	self.topbar:SetSize(self:GetWide(), self.topbarheight)
	self.frame.Resize()
end

function PANEL:setBlur(bool)
	self.blur = bool

	return self
end

function PANEL:setDoClick(func)
	self.DoClick = func

	return self
end

function PANEL:Paint(w, h)
	if slib.getTheme("bgblur") and self.blur then
		Derma_DrawBackgroundBlur( self, self.MadePanel )
	end
	
	draw.RoundedBox(5, 0, 0, w, h, maincolor)
end

function PANEL:addTab(name, icon)
	if !IsValid(self.tabmenu) then
		self.tabmenu = vgui.Create("DScrollPanel", self)
		self.tabmenu:SetTall(self:GetTall() - self.topbarheight)
		self.tabmenu:SetPos(0, self.topbarheight)
		self.tabmenu.font = slib.createFont("Roboto", 14)
		self.tabmenu.Paint = function(s,w,h)
			draw.RoundedBoxEx(5, 0, 0, w, h, sidebarcolor, false, false, true, false)
		end

		self.tabmenu.OnSizeChanged = function()
			self.frame.Resize()
		end

		self.frame.Resize()
	end

	self.tab[name] = vgui.Create("EditablePanel", self.frame)
	self.tab[name]:SetSize(self.frame:GetWide(), self.frame:GetTall())
	self.tab[name]:SetVisible(false)
	self.tab[name].addTab = function(tab_name)
		local w, h, tab_h = self.tab[name]:GetWide(), self.tab[name]:GetTall(), slib.getScaledSize(32, "y")
		if !IsValid(self.tab[name].topbar) then
			self.tab[name].topbar = vgui.Create("EditablePanel", self.tab[name])
			self.tab[name].topbar:Dock(TOP)
			self.tab[name].topbar:SetTall(tab_h)
			self.tab[name].topbar.Paint = function(s,w,h)
				surface.SetDrawColor(maincolor_7)
				surface.DrawRect(0,0,w,h)
			end
		end

		local frame = vgui.Create("EditablePanel", self.tab[name])
		frame:SetPos(0, tab_h)
		frame:SetSize(w, h - tab_h)
		frame:SetVisible(false)

		local tab_button = vgui.Create("SButton", self.tab[name].topbar)
		tab_button.font = slib.createFont("Roboto", 16)
		tab_button.bg = maincolor_7
		tab_button.tab = frame

		tab_button.DoClick = function()
			if IsValid(self.tab[name].selTab) and self.tab[name].selTab:IsVisible() then
				self.tab[name].selTab.tabbttn.forcehover = nil
				self.tab[name].selTab.tabbttn.bg = maincolor_7
				self.tab[name].selTab:SetVisible(false)
			end

			frame:SetVisible(true)
			self.tab[name].selTab = frame

			tab_button.bg = maincolor_15
			tab_button.forcehover = true
		end

		frame.tabbttn = tab_button

		tab_button:setTitle(tab_name)
		:Dock(LEFT)

		local childs = self.tab[name].topbar:GetChildren()
		local width = math.ceil(self.frame:GetWide() / #childs)
		for k,v in ipairs(childs) do
			v:SetWide(width)
		end

		if #childs == 1 then
			tab_button.DoClick()
		end

		return frame
	end

	local height = slib.getScaledSize(28, "y")
	self.iterator = self.iterator + 1
	local tabbttn = vgui.Create("DButton", self.tabmenu)
	tabbttn:Dock(TOP)
	tabbttn:SetZPos(self.iterator)
	tabbttn:SetTall(height)
	tabbttn:SetText("")
	tabbttn.name = name

	tabbttn.getFrame = function()
		return self.tab[name]
	end

	if icon then
		tabbttn.icon = Material(icon, "smooth")
	end

	local icosize = height * .6
	local gap = height * .20

	tabbttn.Paint = function(s,w,h)
		surface.SetDrawColor(sidebarbttncolor)
		surface.DrawRect(0, 0, w, h)

		local wantedh = self.seltab == name and h or 0
		local curH = slib.lerpNum(s, wantedh, .9, true)

		if self.seltab == name then
			surface.SetDrawColor(accentcol_a100)
			surface.DrawRect(0, h * .5 - curH * .5, w, curH)
		end

		if s.icon then
			surface.SetDrawColor(color_white)
			surface.SetMaterial(s.icon)
			surface.DrawTexturedRect(gap,gap,icosize,icosize)
		end

		draw.SimpleText(name, self.tabmenu.font, (s.icon and icosize + gap or 0) + slib.getTheme("margin"), h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	tabbttn.DoClick = function()
		self:setActiveTab(name)

		if isfunction(self.changedTab) then
			self.changedTab(name)
		end
	end

	self.tab[name].tabbttn = tabbttn
	
	surface.SetFont(self.tabmenu.font)
	local w = select(1, surface.GetTextSize(name)) + (slib.getTheme("margin") * 4) + height

	if w > self.tabmenu:GetWide() then
		self.tabmenu:SetWide(w)
	end

	return self, tabbttn
end

function PANEL:setActiveTab(name)
	if !name then
		local childs = self.tabmenu:GetCanvas():GetChildren()
		local lowest, selected = math.huge
		for k,v in ipairs(childs) do
			local zpos = v:GetZPos()
			if zpos < lowest then
				selected = v.name
				lowest = zpos
			end

		end

		if selected then
			self:setActiveTab(selected)
		end

		return
	end

	if self.seltab and IsValid(self.tab[self.seltab]) then
		self.tab[self.seltab]:SetVisible(false)
	end

	self.seltab = name

	self.tab[name]:SetVisible(true)

	return self
end

vgui.Register("SFrame", PANEL, "EditablePanel")