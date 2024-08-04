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

local font = slib.createFont("Roboto", 15)
local textcolor, maincolor_7 = slib.getTheme("textcolor"), slib.getTheme("maincolor", 7)

function PANEL:Init()
    local tall = slib.getScaledSize(25, "y")
    self:SetTall(tall)
    self:Dock(TOP)

    self.playerImage = vgui.Create("AvatarImage", self)
    self.playerImage:SetSize(tall, tall)

    self:DockMargin(0, 0, 0, slib.getTheme("margin"))
    self:GetParent():DockPadding(slib.getTheme("margin"), slib.getTheme("margin"), slib.getTheme("margin"), slib.getTheme("margin"))
end

function PANEL:addButton(title, func)
    local bttn = vgui.Create("SButton", self)
    bttn:setTitle(title)
    :Dock(RIGHT)
    :DockMargin(0,slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"))

    bttn.DoClick = func

    return self
end

function PANEL:setPlayer(ply)
    self.ply = ply
    self.name = self.ply:Nick()
    self.playerImage:SetPlayer(ply, 64)

    return self
end

function PANEL:Paint(w,h)
    if !self.ply then self:Remove() end

    surface.SetDrawColor(maincolor_7)
    surface.DrawRect(0, 0, w, h)

    if self.ply then
        draw.SimpleText(self.name, font, slib.getScaledSize(25, "y") + slib.getTheme("margin"), h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end

vgui.Register("SPlayerPanel", PANEL, "EditablePanel")