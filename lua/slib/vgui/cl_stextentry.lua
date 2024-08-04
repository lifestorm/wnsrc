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

local accentcolor, textcolor, textcolor_30, textcolor_80 = slib.getTheme("accentcolor"), slib.getTheme("textcolor"), slib.getTheme("textcolor", -30), slib.getTheme("textcolor", -80)

function PANEL:Init()
    slib.wrapFunction(self, "Dock", nil, function() return self end, true)
    slib.wrapFunction(self, "SetNumeric", nil, function() return self end, true)
    slib.wrapFunction(self, "DockMargin", nil, function() return self end, true)
    slib.wrapFunction(self, "SetTextColor", nil, function() return self end, true)
    slib.wrapFunction(self, "SetDrawLanguageID", nil, function() return self end, true)
    slib.wrapFunction(self, "SetFont", nil, function() return self end, true)
    slib.wrapFunction(self, "SetTall", nil, function() return self end, true)
    slib.wrapFunction(self, "SetValue", nil, function() return self end, true)

    self.font = slib.createFont("Roboto", 15)
    self.placeholder = "Search..."

    self:SetDrawLanguageID(false)
    :SetTall(slib.getScaledSize(25, "y"))
    :SetFont(self.font)
    :SetTextColor(textcolor_80)
    :SetValue(self.placeholder)
end

function PANEL:Paint(w,h)
    local val = self:GetValue()
    local wantedcolor = accentcolor
    wantedcolor.a = self:HasFocus() and 120 or 20

    if self.bg then
        surface.SetDrawColor(self.bg)
        surface.DrawRect(0, 0, w, h)
    end
    
    if !self.sideline then
        surface.SetDrawColor(slib.lerpColor(self, wantedcolor))
        surface.DrawRect(0, !self.accentlinetop and h - 1 or 0, w, 1)
    end

    self:DrawTextEntryText(val == self.placeholder and textcolor_30 or textcolor, accentcolor, textcolor)
end

function PANEL:OnGetFocus()
    local val = self:GetValue()
    if val == self.placeholder then
        self:SetValue("")
    end
end

function PANEL:AccentLineTop(bool)
    self.accentlinetop = bool
end

function PANEL:SetRefreshRate(rate)
    self.refreshrate = rate
end

function PANEL:AccentSideLine(bool)
    self.sideline = bool
end

function PANEL:OnTextChanged()
    local newvalue = self:GetValue()

    timer.Create(tostring(self), self.refreshrate or .3, 1, function()
        if !IsValid(self) then return end
        if isfunction(self.onValueChange) then
            self.onValueChange(newvalue)
        end
    end)
end

function PANEL:SetPlaceholder(str)
    self.placeholder = str
    self:SetValue(self.placeholder)

    return self
end

function PANEL:OnLoseFocus()
    timer.Simple(.1, function()
        if !IsValid(self) then return end
        local val = self:GetValue()
        if !val or val == "" then
            self:SetValue(self.placeholder)
        end
    end)
end

vgui.Register("STextEntry", PANEL, "DTextEntry")