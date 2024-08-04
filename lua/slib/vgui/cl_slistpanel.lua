--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local font = slib.createFont("Roboto", 14)
local textcolor, neutralcolor, successcolor, failcolor, maincolor_7, maincolor_10, maincolor_15, maincolor_25 = slib.getTheme("textcolor"), slib.getTheme("neutralcolor"), slib.getTheme("successcolor"), slib.getTheme("failcolor"), slib.getTheme("maincolor", 7), slib.getTheme("maincolor", 10), slib.getTheme("maincolor", 15), slib.getTheme("maincolor", 25)

local PANEL = {}

function PANEL:Init()
    self:Dock(TOP)
    self:SetTall(slib.getScaledSize(250, "y"))
    self:DockMargin(slib.getTheme("margin"),0,slib.getTheme("margin"),slib.getTheme("margin"))

    self.frame = vgui.Create("SScrollPanel", self)
    self.frame:Dock(FILL)

    self.frame.Paint = function(s,w,h)
        surface.SetDrawColor(maincolor_10)
        surface.DrawRect(0, 0, w, h)
    end

    self.selected = false

    slib.wrapFunction(self, "SetZPos", nil, function() return self end, true)
    slib.wrapFunction(self, "SetTall", nil, function() return self end, true)
    slib.wrapFunction(self, "DockMargin", nil, function() return self end, true)
    slib.wrapFunction(self, "Dock", nil, function() return self end, true)
end

function PANEL:addEntry(var, toggleable, tab)
    title = var
    if !isstring(var) and IsValid(var) and var:IsPlayer() then title = var:Nick() end

    local selectable = vgui.Create("DButton", self.frame)
    selectable:SetTall(slib.getScaledSize(25, "y"))
    selectable:Dock(TOP)
    selectable:DockMargin(slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"),0)
    selectable:SetText("")
    selectable.name = title
    selectable.tab = tab
    selectable.toggleable = toggleable

    selectable.Paint = function(s,w,h)
        if !isstring(var) and !IsValid(var) then s:Remove() return end

        local wantedcolor
        
        if s.toggleable then
            if isfunction(s.toggleCheck) then
                wantedcolor = s.toggleCheck() and successcolor or failcolor
            end
        else
            wantedcolor = neutralcolor
        end

        wantedcolor.a = 40
        if !s.toggleable and self.selected ~= var then
            wantedcolor.a = 0
        end
        
        surface.SetDrawColor(slib.lerpColor(s, wantedcolor))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(maincolor_25)
        surface.DrawOutlinedRect(0, 0, w, h)


        draw.SimpleText(selectable.name, font, 5, h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    selectable.DoClick = function()
        self.selected = (self.selected ~= var) and var or nil 
    end

    return self, selectable
end

function PANEL:setTitle(title)
    self.title = title

    if !self.topbar then
        self.topbar = vgui.Create("EditablePanel", self)
        self.topbar:SetTall(slib.getScaledSize(25, "y"))
        self.topbar:Dock(TOP)

        self.topbar.Paint = function(s,w,h)
            surface.SetDrawColor(maincolor_7)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(maincolor_25)
            surface.DrawRect(0,h-1,w,1)

            draw.SimpleText(self.title, font, slib.getTheme("margin"), h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
    end

    return self
end

function PANEL:addSearchbar()
    self.search = vgui.Create("SSearchBar", self.topbar)
    self.search:Dock(RIGHT)
    :DockMargin(slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"))

    self.search.entry.bg = maincolor_15
    self.search.entry.onValueChange = function(newval)
        for k,v in pairs(self.frame:GetCanvas():GetChildren()) do
            v:SetVisible(string.find(string.lower(v.name), string.lower(newval)))

            self.frame:GetCanvas():InvalidateLayout(true)
        end
    end

    self.topbar.OnSizeChanged = function()
        self.search:SetWide(self.topbar:GetWide() * .35)
    end

    return self
end

function PANEL:addDropdown()
    self.dropdown = vgui.Create("SDropDown", self.topbar)
    self.dropdown:Dock(RIGHT)
    :DockMargin(slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"))

    self.dropdown.bg = maincolor_15
    
    self.dropdown.onValueChange = function(newtab)
        for k,v in pairs(self.frame:GetCanvas():GetChildren()) do
            v:SetVisible(v.tab == newtab)
            self.frame:GetCanvas():InvalidateLayout(true)
        end
    end

    self.topbar.OnSizeChanged = function()
        self.dropdown:SetWide(self.topbar:GetWide() * .35)
    end

    return self.dropdown
end

function PANEL:addButton(title, func, thnk)
    if !self.bottombar then
		self.bottombar = vgui.Create("EditablePanel", self)
		self.bottombar:Dock(BOTTOM)
		self.bottombar:SetTall(slib.getScaledSize(25,"x"))

		self.bottombar.Paint = function(s,w,h)
			surface.SetDrawColor(maincolor_25)
			surface.DrawRect(0, 0, w, 1)
		end
    end

    local bttn = vgui.Create("SButton", self.bottombar)
    bttn:Dock(LEFT)
    :setTitle(title)
    :DockMargin(slib.getTheme("margin"),slib.getTheme("margin"),0,slib.getTheme("margin"))
    
    bttn.DoClick = function() func(self, bttn) end

    if thnk then
        bttn.Think = function() thnk(self, bttn) end
    end

    return self, bttn
end

function PANEL:Paint(w,h)
    surface.SetDrawColor(maincolor_10)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("SListPanel", PANEL, "EditablePanel")