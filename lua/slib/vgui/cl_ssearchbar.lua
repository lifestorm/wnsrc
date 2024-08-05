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

local maincolor_15, accentcolor, margin = slib.getTheme("maincolor", 15), slib.getTheme("accentcolor"), slib.getTheme("margin")

function PANEL:Init()
    self:Dock(TOP)
    self:SetTall(slib.getScaledSize(25, "y"))
    self.font = slib.createFont("Roboto", 15)
    self.material = Material("slib/icons/search32.png", "noclamp smooth")
    self.bg = maincolor_15

    self.entry = vgui.Create( "STextEntry", self )
    self.entry:Dock(FILL)

    slib.wrapFunction(self, "SetZPos", nil, function() return self end, true)
    slib.wrapFunction(self, "Dock", nil, function() return self end, true)
    slib.wrapFunction(self, "DockMargin", nil, function() return self end, true)
    slib.wrapFunction(self, "SetWide", nil, function() return self end, true)
end

function PANEL:addIcon()
    self.icon = true
    self.entry:DockMargin(slib.getScaledSize(25, "y") + margin,0,0,0)
    self.entry:AccentSideLine(true)
    
    return self
end

function PANEL:SetPlaceholder(str)
    self.entry:SetPlaceholder(str)
end

function PANEL:Paint(w,h)
    local size = h * .65
    local pos = h * .5 - (size * .5)

    if self.bg then
        surface.SetDrawColor(self.bg)
        surface.DrawRect(0, 0, w, h)
    end

    local wantedcolor = accentcolor
    wantedcolor.a = self.entry:HasFocus() and 120 or 20

    surface.SetDrawColor(slib.lerpColor(self, wantedcolor))
    surface.DrawRect(h - 1, margin, 1, h - (margin * 2))

    if self.icon then
        surface.SetDrawColor(color_white)
        surface.SetMaterial(self.material)
        surface.DrawTexturedRect(pos, pos, size, size)
    end
end

vgui.Register("SSearchBar", PANEL, "EditablePanel")