--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

slib.panels = slib.panels or {}

local PANEL = {}

local font, sid_font, empty_font = slib.createFont("Roboto", 13), slib.createFont("Roboto", 11), slib.createFont("Roboto", 15)
local textcolor, textcolor_60 = slib.getTheme("textcolor"), slib.getTheme("textcolor", -60)
local hovercolor, margin, maincolor_12, maincolor_15 = slib.getTheme("hovercolor"), slib.getTheme("margin"), slib.getTheme("maincolor", 12), slib.getTheme("maincolor", 15)
local icon = Material("slib/down-arrow.png", "smooth")
local placeholder = "Select Option"

function PANEL:Init()
    self:SetTall(slib.getScaledSize(25, "y"))
    self:setTitle(placeholder, TEXT_ALIGN_LEFT)
    self.iteration = 0
    self.options = {}
    self.option_h = slib.getScaledSize(32, "y")
    self.titl = ""

    self.close = vgui.Create("DButton")
    self.close:Dock(FILL)
    self.close:SetText("")
    self.close:SetVisible(false)

    self.close.Paint = function() end

    self.close.DoClick = function()
        self.close:SetVisible(false)
        if IsValid(self.droppedFrame) then
            self.droppedFrame:SetVisible(false)
        end

        if isfunction(self.onClose) then self.onClose(self) end

        self:setTitle(self.titl, TEXT_ALIGN_LEFT, true)

        if !self.ply then
            self:setTitle(placeholder, TEXT_ALIGN_LEFT)
        end
    end

    self.droppedFrame = vgui.Create("EditablePanel")
    self.droppedFrame:SetWide(self:GetWide())
    self.droppedFrame:SetVisible(false)

    self.search = vgui.Create("STextEntry", self.droppedFrame)
    :Dock(TOP)
    :SetTall(self:GetTall())
    
    self.search.onValueChange = function(val)
        for k,v in ipairs(self.droppedMenu:GetCanvas():GetChildren()) do
            if !v.ply then continue end

            local filtered = false

            if self.filter then
                if self.filter(v.ply) == false then filtered = true end
            end

            v:SetVisible((val:Trim() == "" or string.find(v.nick:lower(), val:lower()) or val == v.sid64) and !filtered)
        end

        self.droppedMenu.SizeToChilds()
        self.droppedMenu:GetCanvas():InvalidateLayout(true)
    end

    self.closesearch = vgui.Create("SButton", self.search)
    self.closesearch:SetSize(self.option_h, self.option_h)
    self.closesearch.Paint = function(s,w,h) end
    self.closesearch.DoClick = self.close.DoClick

    self.droppedMenu = vgui.Create("SScrollPanel", self.droppedFrame)
    self.droppedMenu:SetWide(self:GetWide())
    self.droppedMenu:SetPos(0, self:GetTall())
    self.droppedMenu.Paint = function(s,w,h)
        surface.SetDrawColor(maincolor_15)
        surface.DrawRect(0,0,w,h)

        draw.SimpleText("No entries.", empty_font, w * .5, self.option_h * .5, textcolor_60, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    self.droppedMenu.SizeToChilds = function()
        local childs = self.droppedMenu:GetCanvas():GetChildren()
        local visible_childs = 0
        local childs_h = 0

        for k,v in ipairs(childs) do
            if v:IsVisible() then
                childs_h = childs_h + v:GetTall()
                visible_childs = visible_childs + 1
            end

            if visible_childs >= 5 then break end
        end
        
        self.droppedMenu:SetTall(math.max(childs_h, visible_childs <= 0 and self.option_h or 0))
        self.droppedFrame:SetTall(self.droppedMenu:GetTall() + self.search:GetTall())
    end

    self.no_player = vgui.Create("SButton", self.droppedMenu)
    :Dock(TOP)
    :SetLinePos(0)
    :SetTall(slib.getScaledSize(24, "y"))
    :SetZPos(-100)
    :SetVisible(false)

    self.no_player.skipVisible = true

    local noply_titl = "No Player"

    self.no_player.Paint = function(s,w,h)        
        surface.SetDrawColor(s:IsHovered() and maincolor_12 or maincolor_15)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText(noply_titl, self.buttonfont or s.font, margin, h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.no_player.DoClick = function()
        self.titl = noply_titl
        self.ply = nil

        self.close.DoClick()
        self:setTitle(noply_titl, TEXT_ALIGN_LEFT, true)

        if isfunction(self.onValueChange) then
            self.onValueChange(val, ply)
        end
    end

    slib.panels["SPlayerSelector"] = slib.panels["SPlayerSelector"] or {}
    table.insert(slib.panels["SPlayerSelector"], self)

    timer.Simple(0, function()
        if !IsValid(self) then return end

        for k,v in ipairs(player.GetAll()) do
            self:addOption(v)
        end
    end)
end

function PANEL:SetScrollBG(col)
    self.droppedMenu.scrollbg = col
end

function PANEL:FindSelectPlayer(ply)
    for k,v in ipairs(self.droppedMenu:GetCanvas():GetChildren()) do
        if v.ply == ply then
            v.DoClick()
            
            break
        end
    end
end

function PANEL:SetPlaceholder(str)
    self:setTitle(str, TEXT_ALIGN_LEFT)
end

function PANEL:OnRemove()
    if IsValid(self.droppedFrame) then self.droppedFrame:Remove() end
end

function PANEL:popupAlone()
    self:DoClick()

    local x, y = input.GetCursorPos()
    if !IsValid(self.droppedFrame) then return end
    self.droppedFrame:SetWide(self:GetWide())
    self.droppedFrame:SetPos(x, y)
    self.droppedFrame:MakePopup()
    self:SetVisible(false)

    self.droppedMenu:SetWide(self.droppedFrame:GetWide())

    self.onClose = function() self:Remove() end

    return self
end

function PANEL:updatedFilters()
    for k, v in ipairs(self.droppedMenu:GetCanvas():GetChildren()) do
        local result = true
        
        if v.skipVisible then continue end

        if self.filter then
            if self.filter(v.ply) == false then result = false end    
        end

        v:SetVisible(result)
    end

    self:pickFirst()
end

function PANEL:pickFirst()
    local childs = self.droppedMenu:GetCanvas():GetChildren()

    for k,v in ipairs(childs) do
        if !v:IsVisible() then continue end
        
        v.DoClick(true)

        break
    end
end

function PANEL:ScrollToFirst()
    local childs = self.droppedMenu:GetCanvas():GetChildren()

    for k,v in ipairs(childs) do
        if !v:IsVisible() then continue end
        
        self.droppedMenu:ScrollToChild(v)

        break
    end
end

function PANEL:ShowNoPlayer(bool)
    self.no_player:SetVisible(bool)

    self.droppedMenu:InvalidateLayout(true)
    self.droppedMenu:SizeToChilds()
end

function PANEL:addOption(ply)
    self.addedPlys = self.addedPlys or {}
    
    if self.addedPlys[ply] then return end
    
    self.addedPlys[ply] = true

    local iteration = self.iteration
    local nick, sid64 = ply:Nick(), ply:SteamID64()

    self.options[iteration] = vgui.Create("SButton", self.droppedMenu)
    :Dock(TOP)
    :SetLinePos(0)
    :SetTall(self.option_h)

    local visibility = !self.filter or self.filter(ply) != false
    self.options[iteration]:SetVisible(visibility)

    self.options[iteration].ply = ply
    self.options[iteration].nick = nick
    self.options[iteration].sid64 = sid64
    
    local avatar = vgui.Create("AvatarImage", self.options[iteration])
    avatar:SetPlayer(ply, 64)
    avatar:SetSize(self.option_h, self.option_h)
    avatar:SetMouseInputEnabled(false)

    local wide = self.options[iteration]:GetWide()

    self.options[iteration].accentheight = 1

    self.droppedMenu:InvalidateLayout(true)
    self.droppedMenu:SizeToChilds()

    self.options[iteration].DoClick = function()
        self.titl = nick
        self.ply = ply

        self.close.DoClick()
        self:setTitle(nick, TEXT_ALIGN_LEFT, true)

        if isfunction(self.onValueChange) then
            self.onValueChange(val, ply)
        end
    end

    self.options[iteration].Paint = function(s,w,h)
        if !IsValid(ply) then s:Remove() if IsValid(self.droppedMenu) then self.droppedMenu:InvalidateLayout(true) end end
        
        surface.SetDrawColor(s:IsHovered() and maincolor_12 or maincolor_15)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText(nick, self.buttonfont or self.options[iteration].font, self.option_h + margin, h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(sid64, sid_font, self.option_h + margin, h * .5, textcolor_60, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end
    
    if wide > self:GetWide() then
        self:SetWide(wide)
    end
    
    self.iteration = self.iteration + 1

    self.lastchild = self.options[iteration]

    return self
end

function PANEL:SelectOption(int)
    self.options[int].DoClick()

    return self
end

function PANEL:Reposition()
    local x, y = self:LocalToScreen(0,0)
    if !IsValid(self.droppedMenu) then return end
    self.droppedFrame:SetWide(self:GetWide())
    self.droppedFrame:SetPos(x, y)
    self.droppedFrame:MakePopup()

    self.droppedMenu:SetWide(self.droppedFrame:GetWide())
    self.closesearch:SetPos(self:GetWide() - self.option_h, 0)
end

function PANEL:DoClick()
    self.close:SetVisible(!self.droppedFrame:IsVisible())
    self.close:MakePopup()

    local childs = self.droppedMenu:GetCanvas():GetChildren()

    self.droppedFrame:SetVisible(!self.droppedFrame:IsVisible())
    self.search:SetValue(self.search.placeholder)

    for k, v in ipairs(childs) do
        local result = true

        if v.skipVisible then continue end

        if self.filter then
            if self.filter(v.ply) == false then result = false end    
        end

        v:SetVisible(result)
    end

    self.droppedMenu:GetCanvas():InvalidateLayout()

    self:ScrollToFirst()

    self.droppedMenu.SizeToChilds()

    self:setTitle("")

    self:Reposition()
end

function PANEL:OnSizeChanged()
    self:Reposition()
end

function PANEL:PaintOver(w,h)
    local size = math.min(h * .7, slib.getScaledSize(12, "y"))
    local thickness = slib.getScaledSize(2, "x")

    draw.NoTexture()

    local wantedCol = (self:IsHovered() or (IsValid(self.closesearch) and self.closesearch:IsHovered())) and color_white or hovercolor

    surface.SetDrawColor(wantedCol)
    surface.SetMaterial(icon)
    surface.DrawTexturedRect(w - size - margin * 2, h * .5 - size * .5, size, size)
end

hook.Add("OnEntityCreated", "slib:AddNewPlayerSelector", function(ent)
    timer.Simple(3, function()
        if IsValid(ent) and slib.panels["SPlayerSelector"] and ent:IsPlayer() then
            for k,v in ipairs(slib.panels["SPlayerSelector"]) do
                if !IsValid(v) then continue end

                v:addOption(ent)
            end
        end
    end)
end)

vgui.Register("SPlayerSelector", PANEL, "SButton")