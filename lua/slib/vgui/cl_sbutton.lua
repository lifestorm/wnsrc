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

local font = slib.createFont("Roboto", 13)
local textcolor, accentcolor, successcolor, failcolor = slib.getTheme("textcolor"), slib.getTheme("accentcolor"), slib.getTheme("successcolor"), slib.getTheme("failcolor")

function PANEL:Init()
    self.font = font
    self:SetText("")
    self.bg = slib.getTheme("maincolor")
    self.alignment = TEXT_ALIGN_CENTER
    self.accentheight = 2
    self.selCol = accentcolor
    self.textcolor = textcolor
    slib.wrapFunction(self, "Dock", nil, function() return self end, true)
    slib.wrapFunction(self, "DockMargin", nil, function() return self end, true)
    slib.wrapFunction(self, "DockPadding", nil, function() return self end, true)
    slib.wrapFunction(self, "SetZPos", nil, function() return self end, true)
    slib.wrapFunction(self, "SetTall", nil, function() return self end, true)
    slib.wrapFunction(self, "SetWide", nil, function() return self end, true)
    slib.wrapFunction(self, "SetSize", nil, function() return self end, true)
    slib.wrapFunction(self, "SetPos", nil, function() return self end, true)
    slib.wrapFunction(self, "SetVisible", nil, function() return self end, true)
end

function PANEL:setTitle(title, alignment, noresize)
    if self.title == title then return end
    self.title = title

    if alignment then self.alignment = alignment end
    
    if !noresize then
        surface.SetFont(self.font)
        local w = select(1, surface.GetTextSize(title))

        self:SetWide(w + (slib.getTheme("margin") * 2))
    end
    
    return self
end

function PANEL:getTitle()
    return self.title
end

function PANEL:SetLinePos(h)
    self.linepos = h

    return self
end

function PANEL:setToggleable(bool)
    self.toggleable = bool

    return self
end

function PANEL:Paint(w,h)
    local wantedcolor = self.toggleable and (isfunction(self.toggleCheck) and self.toggleCheck() and istable(self.toggleCheck()) and self.toggleCheck() or self.toggleCheck() and successcolor or failcolor) or self.selCol

    if !self.toggleable then
        wantedcolor.a = (self:IsHovered() or self.forcehover) and 120 or 20
    end

    surface.SetDrawColor(self.bg)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(slib.lerpColor(self, wantedcolor))
    surface.DrawRect(0, self.linepos ~= nil and self.linepos or (h - self.accentheight), w, self.accentheight)
    local x
    if self.alignment == TEXT_ALIGN_CENTER then
        x = w * .5
    elseif self.alignment == TEXT_ALIGN_RIGHT then
        x = w - slib.getTheme("margin")
    elseif self.alignment == TEXT_ALIGN_LEFT then
        x = slib.getTheme("margin")
    end

    draw.SimpleText(self.title, self.font, x, h * .5, self.textcolor, self.alignment, TEXT_ALIGN_CENTER)
end

vgui.Register("SButton", PANEL, "DButton")