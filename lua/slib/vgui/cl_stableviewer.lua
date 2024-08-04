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
local neutralcolor, textcolor, successcolor_100, failcolor_100, maincolor_5, maincolor_7, maincolor_10, maincolor_15 = slib.getTheme("neutralcolor"), slib.getTheme("textcolor"), slib.getTheme("successcolor", -100), slib.getTheme("failcolor", -100), slib.getTheme("maincolor", 5), slib.getTheme("maincolor", 7), slib.getTheme("maincolor", 10), slib.getTheme("maincolor", 15)

function PANEL:Init()
    self:SetSize(slib.getScaledSize(450, "x"), slib.getScaledSize(330, "y"))
    :Center()
    :MakePopup()
    :addCloseButton()
    :setTitle("Table Viewer", slib.createFont("Roboto", 17))
    :setBlur(true)

    self.entryheight = slib.getScaledSize(20, "y")
    
    self.viewbox = vgui.Create("EditablePanel", self.frame)
    self.viewbox:Dock(RIGHT)
    self.viewbox:SetWide(self.frame:GetWide())

    self.viewer = vgui.Create("SScrollPanel", self.viewbox)
    :Dock(FILL)
end

local function createButton(self, parent, str, val)
    local istbl = istable(val)
    local selparent = parent and parent or self.viewer

    local value = vgui.Create("SButton", selparent)
    :Dock(TOP)
    :SetZPos(-10)
    :SetTall(slib.getScaledSize(25, "y"))

    value.title = str
    value.tbl = istbl and val or parent.tbl

    value.Paint = function(s,w,h)
        local wantedcolor = selparent == self.suggestions and successcolor_100 or (value.toggleable and selparent.tbl[str] and successcolor_100 or failcolor_100)

        if !value.toggleable and (!s:IsHovered() or self.viewOnly) then
            wantedcolor = table.Copy(wantedcolor)
            wantedcolor.a = 0
        end
        
        surface.SetDrawColor(slib.lerpColor(s, wantedcolor))
        surface.DrawRect(0, 0, w, h)
        local display = ""

        if !istbl and (isstring(val) or isnumber(val)) then
            display = ": "..tostring(val)
        end
        
        draw.SimpleText(str..display, font, slib.getTheme("margin"), h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    value.Think = function()
        if !value.toggleable and self:getRule("toggleables", str) then
            value.toggleable = true
        end

        if value:IsHovered() and input.IsKeyDown(KEY_LSHIFT) and input.IsMouseDown(MOUSE_RIGHT) then
            value:DoClick()
        end
    end

    value.DoClick = function()
        if self.viewOnly then return end

        self.modified = true
        
        if selparent == self.suggestions then
            local edit = IsValid(self.selected) and self.selected or self.viewer

            if self.rules and self.rules.onlymodifytable and edit:GetName() == "SScrollPanel" then return end

            if self.customvalues then
                local popup = vgui.Create("SPopupBox")
                :setTitle(value.title)
                
                local entry = popup:addInput("text", self.customvalueplaceholder)

                if self.customnumeric then
                    entry:SetNumeric(true)
                end
                
                popup:addChoise(self.customvalues, function()
                    local val = entry:GetValue()
                    self:addValue(editTbl, value.title, val, edit)
                    edit.tbl[value.title] = val

                    if edit == self.viewer then
                        self:sortValues(self.viewer)
                    end
                end)

                return
            else
                edit.tbl[value.title] = true
                self:addValue(editTbl, value.title, true, edit)
            end
            
            if edit == self.viewer then
                self:sortValues(self.viewer)
            end
        else
            if value.toggleable then
                selparent.tbl[str] = !selparent.tbl[str]
            return end

            value:Remove()
        end

        selparent.tbl[str] = nil
    end

    return value
end

function PANEL:addValue(panel, str, val, parent)
    if istable(val) then
        local selpar = parent or panel
        parent = vgui.Create("EditablePanel", selpar)
        parent:Dock(TOP)
        parent:SetTall(slib.getScaledSize(25, "y"))
        parent:DockMargin(slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"))
        parent:DockPadding(0,slib.getScaledSize(25, "y"),0,0)
        parent.isTblContainer = true
        parent.tbl = val
        parent.title = str
        parent.OnSizeChanged = function(w,h)
            parent.top:SetWide(parent:GetWide())
        end

        parent.top = vgui.Create("SButton", parent)
        parent.top:SetSize(parent:GetWide(), slib.getScaledSize(25, "y"))

        parent.top.DoClick = function()
            if self.rules and self.rules.tableDeletable and !self:getRule("undeleteableTables", str)  then
                parent:Remove()
                selpar.tbl[str] = nil
                self.modified = true
            return end

            self.selected = self.selected ~= parent and parent or nil
        end

        parent.top.Paint = function(s,w,h)
            local wantedcolor = self.rules and self.rules.tableDeletable and !self:getRule("undeleteableTables", str) and failcolor_100 or neutralcolor
            
            surface.SetDrawColor(maincolor_7)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(maincolor_5)
            surface.DrawRect(0,h-1,w,1)

            if self.rules and self.rules.tableDeletable and !self:getRule("undeleteableTables", str) then
                if !s:IsHovered() then
                    wantedcolor = table.Copy(wantedcolor)
                    wantedcolor.a = 0
                end
            elseif self.selected ~= parent then
                wantedcolor = table.Copy(wantedcolor)
                wantedcolor.a = 0
            end


            surface.SetDrawColor(slib.lerpColor(s, wantedcolor))
            surface.DrawRect(0, 0, w, h)

            draw.SimpleText(str, font, slib.getTheme("margin"), h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        parent.PaintOver = function(s, w, h)
            surface.SetDrawColor(maincolor_5)
            surface.DrawOutlinedRect(0, 0, w, h)
        end

        parent.OnChildAdded = function(child)
            local addheight = slib.getScaledSize(25, "y")
            parent:SetTall(parent:GetTall() + addheight)

            local grandparent = parent:GetParent()
            if !grandparent.isTblContainer then return end
            grandparent:SetTall(grandparent:GetTall() + addheight)
        end

        parent.OnChildRemoved = function(child)
            local addheight = slib.getScaledSize(25, "y")
            parent:SetTall(parent:GetTall() - addheight)

            local grandparent = parent:GetParent()
            if !grandparent.isTblContainer then return end
            grandparent:SetTall(grandparent:GetTall() - addheight)
        end
        
        if selpar ~= self.viewer then
            selpar:SetTall(selpar:GetTall() + (slib.getTheme("margin") * 2))
        end

        for k,v in pairs(val) do
            self:addValue(panel, k, v, parent)
        end
    return end

    return createButton(self, parent and parent or panel, str, val)
end

local function differenciate(a, b)
    if !(isstring(a) == isstring(b)) or isbool(a) or isbool(b) then
        return tostring(a), tostring(b)
    end

    return a, b
end

function PANEL:setCustomValues(bool, placeholder, numeric)
    self.customvalues = bool
    self.customvalueplaceholder = placeholder
    self.customnumeric = numeric

    return self
end

function PANEL:sortValues(panel)
    if !IsValid(panel) then return self end
    local basictable = {}
    local cleantable = {}

    for k,v in pairs(panel.tbl) do
        table.insert(basictable, k)
    end

    table.sort(basictable, function(a, b) local a, b = differenciate(a, b) return a < b end)
    
    for k,v in pairs(basictable) do
        cleantable[v] = k
    end

    for k, v in pairs(panel:GetCanvas():GetChildren()) do
        if !v.title then continue end
        v:SetZPos(cleantable[v.title])
    end

    return self
end

function PANEL:addSuggestions(tbl)
    if !tbl then return self end

    local wide, tall = self.frame:GetWide() * .5, self.frame:GetTall()
    self.viewer:SetPos(wide, 0)
    self.viewer:SetWide(wide)

    self.suggestionbox = vgui.Create("EditablePanel", self.frame)
    self.suggestionbox:Dock(LEFT)
    self.suggestionbox:SetWide(self.frame:GetWide() * .5)
    self.viewbox:SetWide(self.frame:GetWide() * .5)

    self.suggestions = vgui.Create("SScrollPanel", self.suggestionbox)
    self.suggestions:Dock(FILL)
    self.suggestions.tbl = tbl
    self.suggestions.hidden = {}

    self.suggestions.PaintOver = function(s,w,h)
        surface.SetDrawColor(maincolor_10)
        surface.DrawRect(w - 1, 0, 1, h)
    end

    self.suggestions.Think = function()
        local edit = IsValid(self.selected) and self.selected or self.viewer
        for k, value in pairs(self.suggestions:GetCanvas():GetChildren()) do
            if value:IsVisible() ~= !edit.tbl[value.title] and !value.searchHidden then
                value:SetVisible(!edit.tbl[value.title])
                self.suggestions:GetCanvas():InvalidateLayout(true)
            end
        end
    end

    for k,v in pairs(tbl) do
        self:addValue(self.suggestions, k, v)
    end

    return self
end

function PANEL:setOnlyModifyTable(bool)
    self.rules = self.rules or {}
    self.rules.onlymodifytable = bool
end

function PANEL:setToggleable(module, name, string)
    self.rules = self.rules or {}
    self.rules[module] = self.rules[module] or {}
    self.rules[module][name] = self.rules[module][name] or {}
    self.rules[module][name].toggleables = self.rules[module][name].toggleables or {}

    self.rules[module][name].toggleables[string] = true
end

function PANEL:setTableDeletable(bool)
    self.rules = self.rules or {}
    self.rules.tableDeletable = bool
end

function PANEL:setundeleteableTable(module, name, string)
    self.rules = self.rules or {}
    self.rules[module] = self.rules[module] or {}
    self.rules[module][name] = self.rules[module][name] or {}
    self.rules[module][name].undeleteableTables = self.rules[module][name].undeleteableTables or {}

    self.rules[module][name].undeleteableTables[string] = true
end

function PANEL:setAddRules(rule)
    self.rules = self.rules or {}
    self.rules.addRules = rule
end

function PANEL:getRule(type, str)
    local returnval = false

    if self.rules and self.rules[self.modulename] and self.rules[self.modulename][self.name] and self.rules[self.modulename][self.name][type] and self.rules[self.modulename][self.name][type][str] then
        returnval = true
    end
    
    return returnval
end

function PANEL:setIdentifiers(module, name)
    self.modulename, self.name = module, name
end

function PANEL:setTable(tbl)
    if !tbl or !istable(tbl) then return self end
    self.viewer.tbl = tbl
    for k,v in pairs(tbl) do
        self:addValue(self.viewer, k, v)
    end

    return self
end

function PANEL:addSearch(panel, viewer)
    if !IsValid(panel) or !IsValid(viewer) then return self end
    panel.search = vgui.Create("SSearchBar", panel)
    :addIcon()
    :SetWide(panel:GetWide())
    :Dock(TOP)
    :DockMargin(0,0,0,0)

    panel.search.entry.onValueChange = function(newvalue)
        for k,v in pairs(viewer:GetCanvas():GetChildren()) do
            if !v.title then continue end

            v:SetVisible(string.find(string.lower(v.title), string.lower(newvalue)))

            if v:IsVisible() then
                v.searchHidden = nil
            else
                v.searchHidden = true
            end
        end

        viewer:GetCanvas():InvalidateLayout(true)
    end

    return self
end

function PANEL:addEntry()
    self.addEntryFrame = vgui.Create("EditablePanel", self.viewbox)
    self.addEntryFrame:Dock(BOTTOM)

    self.addEntryButton = vgui.Create("SButton", self.addEntryFrame)
    :Dock(RIGHT)
    :setTitle("Add")

    self.addEntryButton.accentheight = 1
    self.addEntryButton.bg = maincolor_10

    self.addEntryButton.DoClick = function()
        local key, edit = self.entry:GetValue(), (IsValid(self.selected) and self.selected or self.viewer)
        if !key or key == "" or edit.tbl[key] then return end
        if self.rules and self.rules.onlymodifytable and edit:GetName() == "SScrollPanel" then return end
        
        local val

        if self.rules and self.rules.addRules and edit:GetName() == "SScrollPanel" then
            val = table.Copy(self.rules.addRules)
        end

        if !val then val = key end

        local result = !istable(val) and true or val
        edit.tbl[key] = result

        self:addValue(edit, key, result, edit)
        self:sortValues(self.viewer)
        self.modified = true
        self.entry:SetValue("")
    end

    self.entry = vgui.Create("STextEntry", self.addEntryFrame)
    :Dock(FILL)
    :SetValue("")

    self.entry.bg = maincolor_10

    self.entry.placeholder = ""

    self.addEntryFrame:SetTall(self.entry:GetTall())
    self.addEntryButton:SetTall(self.entry:GetTall())

    return self
end

vgui.Register("STableViewer", PANEL, "SFrame")