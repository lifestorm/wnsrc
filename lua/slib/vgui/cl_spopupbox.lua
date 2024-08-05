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
local textcolor, textcolor_min10, margin, maincolor_10 = slib.getTheme("textcolor"), slib.getTheme("textcolor", -10), slib.getTheme("margin"), slib.getTheme("maincolor", 10)

function PANEL:Init()
    self:SetSize(slib.getScaledSize(260, "x"), self.topbarheight)
    self:Center()
    self:addCloseButton()
    self.frame:DockPadding(0,margin,0,0)

    self.bgcloser = vgui.Create("SButton")
    self.bgcloser:Dock(FILL)
    self.bgcloser:MakePopup()
    self.bgcloser.Paint = function() end
    self.bgcloser.DoClick = function()
        self:Remove()
    end

    local buttonsH = slib.getScaledSize(25, "y")
    self.choises = vgui.Create("EditablePanel", self.frame)
    self.choises:Dock(BOTTOM)
    self.choises:SetTall(slib.getScaledSize(25, "y"))
    self.choises:DockMargin(0,0,0,margin)
    self.choises:DockPadding(margin,0,margin,0)

    self.choises.ResizeChilds = function()
        local childs = self.choises:GetChildren()
        local count = table.Count(childs)
        local width = self.choises:GetWide()

        for k,v in pairs(childs) do
            v:SetWide(math.Clamp(width / count, 0, width - (margin * 2)) + (count > 1 and k < 3 and -margin*1.5 or 0))
            if count > 1 then
                v:DockMargin(k > 1 and margin * .5 or 0,0,margin * .5,0)
            end
        end
    end

    self.choises.OnSizeChanged = self.choises.ResizeChilds

    self:MakePopup()

    local realh = self.frame:GetTall() - self.choises:GetTall() - margin
    self.frame.PaintOver = function(s,w,h)
        if self.parse then
            self.parse:Draw(w * .5, (h - buttonsH) * .5, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end

function PANEL:OnRemove()
    if IsValid(self.bgcloser) then self.bgcloser:Remove() end
end

function PANEL:setText(str)
    self.parse = markup.Parse("<colour="..textcolor_min10.r..","..textcolor_min10.g..","..textcolor_min10.b..","..textcolor_min10.a.."><font="..slib.createFont("Roboto", 16)..">"..str.."</font></colour>", self.frame:GetWide() - (margin * 2))
    local height = self.parse:GetHeight()

    self:SetTall(self:GetTall() + height + (margin * 6))

    return self
end

local inputTypes = {
    ["int"] = "STextEntry",
    ["dropdown"] = "SDropDown",
    ["text"] = "STextEntry"
}

function PANEL:addInput(type, placeholder)
    placeholder = placeholder or ""
    local element = vgui.Create(inputTypes[type], self.frame)
    element:Dock(TOP)
    element:DockMargin(margin, 0, margin, margin)
    element:SetTall(slib.getScaledSize(25, "y"))
    element.placeholder = placeholder
    element.bg = maincolor_10

    if type == "int" then
        element:SetNumeric(true)
        element:SetRefreshRate(0)
    end

    element:SetPlaceholder(placeholder)

    self:SetTall(self:GetTall() + element:GetTall() + margin)

    return element
end

function PANEL:addChoise(title, func)
    if !self.addedH then
        self:SetTall(self:GetTall() + self.choises:GetTall() + margin)
    end

    self.addedH = true

    local choise = vgui.Create("SButton", self.choises)
    choise:setTitle(title)
    choise:Dock(LEFT)
    choise:DockMargin(0,margin,0,0)
    choise:SetTall(slib.getScaledSize(25, "y"))
    choise.bg = slib.getTheme("maincolor", 5)

    choise.DoClick = function() if func then func() end self:Remove() end

    self.choises.ResizeChilds()

    return self
end

vgui.Register("SPopupBox", PANEL, "SFrame")