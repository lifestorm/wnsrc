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

local elegantcol, maincol, maincol_5 = Color(255,255,255,3), slib.getTheme("maincolor"), slib.getTheme("maincolor", 5)

function PANEL:Init()
    local scr = self:GetVBar()
    scr:SetHideButtons(true)

    scr.Paint = function(_, w, h)
        surface.SetDrawColor(self.scrollbg or maincol)
        surface.DrawRect(0,0,w,h)
    end    
    scr.btnUp.Paint = function(_, w, h)end
    scr.btnDown.Paint = function(_, w, h)end
    scr.btnGrip.Paint = function(_, w, h)
        draw.RoundedBoxEx(h * .5, w * 0.5 - (w * 0.45 / 2), h * 0.03, w * 0.45, h - h * 0.06, elegantcol, true, true, true, true)
    end

    slib.wrapFunction(self, "SetSize", nil, function() return self end, true)
	slib.wrapFunction(self, "Center", nil, function() return self end, true)
	slib.wrapFunction(self, "SetPos", nil, function() return self end, true)
    slib.wrapFunction(self, "Dock", nil, function() return self end, true)
    slib.wrapFunction(self, "DockMargin", nil, function() return self end, true)
    slib.wrapFunction(self, "SetTall", nil, function() return self end, true)
end

function PANEL:Paint(w,h)
    if self.bg then
        surface.SetDrawColor(self.bg)
        surface.DrawRect(0,0,w,h)
    end
end

vgui.Register("SScrollPanel", PANEL, "DScrollPanel")