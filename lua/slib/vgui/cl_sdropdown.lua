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
local textcolor = slib.getTheme("textcolor")
local hovercolor, margin, maincolor_5, maincolor_10 = slib.getTheme("hovercolor"), slib.getTheme("margin"), slib.getTheme("maincolor", 5), slib.getTheme("maincolor", 10)
local icon = Material("slib/down-arrow.png", "smooth")

function PANEL:Init()
    self:SetTall(slib.getScaledSize(25, "y"))
    self:setTitle("Select Option", TEXT_ALIGN_LEFT)
    self.iteration = 0
    self.options = {}
    self.maxHeightChilds = 0

    self.close = vgui.Create("DButton")
    self.close:Dock(FILL)
    self.close:SetText("")
    self.close:SetVisible(false)

    self.close.Paint = function() end

    self.close.DoClick = function()
        self.close:SetVisible(false)
        if IsValid(self.droppedMenu) then
            self.droppedMenu:SetVisible(false)
        end

        if isfunction(self.onClose) then self.onClose(self) end
    end

    self.droppedMenu = vgui.Create("SScrollPanel")
    self.droppedMenu:SetWide(self:GetWide())
    self.droppedMenu:SetVisible(false)
    self.droppedMenu.scrollbg = Color(42, 42, 42)
end

function PANEL:SetPlaceholder(str)
    self:setTitle(str, TEXT_ALIGN_LEFT)
end

function PANEL:OnRemove()
    if IsValid(self.droppedMenu) then self.droppedMenu:Remove() end
end

function PANEL:popupAlone()
    self:DoClick()

    local x, y = input.GetCursorPos()
    if !IsValid(self.droppedMenu) then return end
    self.droppedMenu:SetWide(self:GetWide())
    self.droppedMenu:SetPos(x, y)
    self.droppedMenu:MakePopup()
    self:SetVisible(false)
    self.poppedOut = true

    self.onClose = function() self:Remove() end

    return self
end

function PANEL:SizeToChilds()
    local canvas = self.droppedMenu:GetCanvas()
    local childsHeight = 0

    for k,v in ipairs(canvas:GetChildren()) do
        if self.maxHeightChilds > 0 and k > self.maxHeightChilds then
            break
        end
        
        childsHeight = childsHeight + v:GetTall()
    end

    canvas:InvalidateLayout(true)
    canvas:SetTall(childsHeight)

    self.droppedMenu:SetHeight(canvas:GetTall())
end

function PANEL:addOption(val)
    local iteration = self.iteration
    self.options[iteration] = vgui.Create("SButton", self.droppedMenu)
    :Dock(TOP)
    :SetLinePos(0)
    :SetTall(slib.getScaledSize(25, "y"))

    if self.buttonfont then
        self.options[iteration].font = self.buttonfont
    end

    local is_func = isfunction(val)

    self.options[iteration]:setTitle(is_func and val() or val, TEXT_ALIGN_LEFT)

    local wide = self.options[iteration]:GetWide()

    self.options[iteration].accentheight = 1

    self:SizeToChilds()

    self.options[iteration].DoClick = function(called)
        self.close.DoClick()
        self:setTitle(is_func and val() or val, TEXT_ALIGN_LEFT, true)
        self.sel_int = iteration + 1
        
        if isfunction(self.onValueChange) then
            self.onValueChange(is_func and val() or val)
        end
    end
    local isFirst = !self.firstchild
    self.options[iteration].Paint = function(s,w,h)
        if is_func then self.options[iteration]:setTitle(val(), TEXT_ALIGN_LEFT) end

        surface.SetDrawColor(s:IsHovered() and maincolor_5 or maincolor_10)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText(is_func and val() or val, self.buttonfont or self.options[iteration].font, margin, h * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    
    if iteration == 0 then
        self.options[iteration].DoClick()
    end
    
    if wide > self:GetWide() then
        self:SetWide(wide)
    end
    
    self.iteration = self.iteration + 1

    self.firstchild = self.firstchild or self.options[iteration]
    self.lastchild = self.options[iteration]

    return self
end

function PANEL:SelectOption(int)
    self.options[int].DoClick(true)

    return self
end

function PANEL:Reposition()
    local x, y = self:LocalToScreen(0,self:GetTall())
    if !IsValid(self.droppedMenu) then return end
    self.droppedMenu:SetWide(self:GetWide())
    self.droppedMenu:SetPos(x, y)
    self.droppedMenu:MakePopup()
end

function PANEL:DoClick()
    self.close:SetVisible(!self.droppedMenu:IsVisible())
    self.close:MakePopup()

    self.droppedMenu:SetVisible(!self.droppedMenu:IsVisible())

    self:Reposition()
end

function PANEL:OnSizeChanged()
    self:Reposition()
end

function PANEL:PaintOver(w,h)
    local size = math.min(h * .7, slib.getScaledSize(12, "y"))
    local thickness = slib.getScaledSize(2, "x")

    draw.NoTexture()

    local wantedCol = self:IsHovered() and color_white or hovercolor

    surface.SetDrawColor(wantedCol)
    surface.SetMaterial(icon)
    surface.DrawTexturedRect(w - size - margin * 2, h * .5 - size * .5, size, size)
end

vgui.Register("SDropDown", PANEL, "SButton")