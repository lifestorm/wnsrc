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

local padding = SScaleMin(10 / 3)

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self.Paint = function(this, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( this, 1 )
	end

	self.content = self:Add("EditablePanel")
	self.content:SetSize(SScaleMin(700 / 3), SScaleMin(600 / 3))
	self.content:Center()
	self.content:MakePopup()
	self.content.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.content)

	self:CreateTopBar()

	self.innerSelf = self.content:Add("DScrollPanel")
	self.innerSelf:Dock(FILL)

    self.partWidths = {}
    self.parts = {}
    self.rows = {}
    self.excluded = {}
    self.info = false
    self.scrollers = {}
end

function PANEL:CreateTopBar()
	self.topbar = self.content:Add("Panel")
	self.topbar:SetSize(self:GetWide(), SScaleMin(50 / 3))
	self.topbar:Dock(TOP)
	self.topbar:DockMargin(0, 0, 0, padding)
	self.topbar.Paint = function( this, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.titleText = self.topbar:Add("DLabel")
	self.titleText:SetFont("CharCreationBoldTitleNoClamp")
	self.titleText:Dock(LEFT)
	self.titleText:SetText(L("qolItemsInfo"))
	self.titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	self.titleText:SetContentAlignment(4)
	self.titleText:SizeToContents()

	local exit = self.topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local divider = self.topbar:Add("Panel")
	self:CreateDivider(divider)
end

function PANEL:CreateDivider(parent)
	parent:SetSize(1, self.topbar:GetTall())
	parent:Dock(RIGHT)
	parent:DockMargin(SScaleMin(5 / 3), padding, padding + SScaleMin(5 / 3), padding)
	parent.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, 0, 0, h)
	end
end

local sortingMembers = {
    invID = true,
    name = true,
    origin = true,
    itemID = true,
    owner = true
}

function PANEL:Populate(info)
    self.info = info
    local count = 0
    for itemID, itemInfo in SortedPairsByMemberValue(info, "itemID") do
        count = count + 1

        self:CreateRow(count, itemID, itemInfo)
    end

    self:AllowMultipleScroll()

    self:CreateBring()

    local bottompanel = self.content:Add("Panel")
    bottompanel:Dock(BOTTOM)
    bottompanel:SetSize(self.content:GetWide(), SScaleMin(50 / 3))

    local itemNames = {}
    for _, v in pairs(info) do
        if !v.name then continue end
        if itemNames[v.name] then continue end
        itemNames[v.name] = true
    end

    local excludeItems = bottompanel:Add("DButton")
    excludeItems:Dock(LEFT)
    excludeItems:SetFont("MenuFontNoClamp")
    excludeItems:SetText(L("qolExcludeItems"))
    excludeItems:SizeToContents()
    excludeItems:SetWide(bottompanel:GetWide() / 2)
    excludeItems.DoClick = function()
	    local dmenu = DermaMenu()
	    dmenu:MakePopup()
	    dmenu:SetPos(input.GetCursorPos())

        for name, _ in pairs(itemNames) do
            dmenu:AddOption(name, function()
                for _, v in pairs(self.rows) do
                    if v.itemName and v.itemName == name then
                        if v:GetTall() != 0 then
                            v:SetTall(0)
                            self.excluded[name] = true
                        else
                            v:SetTall(SScaleMin(90 / 3))
                            self.excluded[name] = nil
                        end
                    end
                end
            end)
        end

        for _, v in pairs(dmenu:GetChildren()[1]:GetChildren()) do
            local tickorx = v:Add("DImage")
            tickorx:Dock(RIGHT)
            tickorx:DockMargin(0, 3, 3, 3)
            tickorx:SetWide(v:GetTall() - 6)
            v:SetWide(v:GetWide() + v:GetTall() + 3)
            if !self.excluded[v:GetText()] then
                tickorx:SetImage("materials/willardnetworks/charselect/check.png")
            else
                tickorx:SetImage("materials/willardnetworks/charselect/delete.png")
            end
        end
    end

    local sortBy = bottompanel:Add("DButton")
    sortBy:Dock(FILL)
    sortBy:SetFont("MenuFontNoClamp")
    sortBy:SetText(L("qolSorting"))
    sortBy.DoClick = function()
	    local dmenu = DermaMenu()
	    dmenu:MakePopup()
	    dmenu:SetPos(input.GetCursorPos())

        for member, _ in pairs(sortingMembers) do
            dmenu:AddOption(member, function()
                count = 0
                for _, v in pairs(self.rows) do
                    v:Remove()
                    self.partWidths = {}
                    self.parts = {}
                    self.rows = {}
                    self.scrollers = {}
                end

                for itemID, itemInfo in SortedPairsByMemberValue(info, member) do
                    count = count + 1
            
                    local row = self:CreateRow(count, itemID, itemInfo)
                    if self.excluded[itemInfo.name] then
                        if row:GetTall() != 0 then
                            row:SetTall(0)
                        end
                    end

                    self:AllowMultipleScroll()
                end

                self:CreateBring()
            end)
        end
    end
end

function PANEL:AllowMultipleScroll()
    for _, v in pairs(self.scrollers) do
        v.Think = function(this)
            local FrameRate = VGUIFrameTime() - this.FrameTime
            this.FrameTime = VGUIFrameTime()
        
            if ( this.btnRight:IsDown() ) then
                this.OffsetX = this.OffsetX + ( 800 * FrameRate )
                this:InvalidateLayout( true )

                for _, v2 in pairs(self.scrollers) do
                    if v2 == this then continue end

                    v2.OffsetX = v2.OffsetX + ( 800 * FrameRate )
                    v2:InvalidateLayout( true )
                end
            end
        
            if ( this.btnLeft:IsDown() ) then
                this.OffsetX = this.OffsetX - ( 800 * FrameRate )
                this:InvalidateLayout( true )

                for _, v2 in pairs(self.scrollers) do
                    if v2 == this then continue end

                    v2.OffsetX = v2.OffsetX - ( 800 * FrameRate )
                    v2:InvalidateLayout( true )
                end
            end
        end
    end
end

function PANEL:CreateBring()
    for _, v in pairs(self.rows) do
        if v.parts["wPosition"] then
            if tostring(self.info[v.itemID].wPosition) != "N/A" and self.info[v.itemID].entID then
                local bring = v.parts["wPosition"].bottomPart:Add("DButton")
                bring:Dock(FILL)
                bring:DockMargin(0, 0, padding, SScaleMin(20 / 3))
                bring:SetFont("MenuFontBoldNoClamp")
                bring:SetText("Bring")
                bring:SizeToContents()
                bring.DoClick = function()
                    Derma_Query("Are you sure you wish to bring the player/item/the container it is in if applicable?", "Bring player/item/container",
                    "Confirm Operation", function()
                        net.Start("ixBringItemOrContainer")
                        net.WriteVector(Vector(self.info[v.itemID].wPosition))
                        net.WriteInt(tonumber(self.info[v.itemID].entID), 17)
                        net.WriteInt(v.itemID, 17)
                        net.WriteString(self.info[v.itemID].origin)
                        net.SendToServer()
                    end, "Cancel")
                end
            end
        end
    end
end

function PANEL:CreateRow(count, itemID, itemInfo)
    local row = self.innerSelf:Add("Panel")
    row:DockMargin(padding, 0, padding, 0)
    row:DockPadding(padding, 0, padding, 0)
    row:SetTall(SScaleMin(90 / 3))
    row:Dock(TOP)
    row.itemName = itemInfo.name
    row.itemID = itemID
    self.rows[#self.rows + 1] = row
    row.parts = {}

    row.Paint = function(this, w, h)
        if (count % 2 == 0) then
            surface.SetDrawColor(0, 0, 0, 75)
            surface.DrawRect(0, 0, w, h)
        else
            surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 15)))
            surface.DrawRect(0, 0, w, h)
        end
    end

    local rowScroll = row:Add("DHorizontalScroller")
    rowScroll:Dock(FILL)
    self.scrollers[#self.scrollers + 1] = rowScroll

    for type, info in pairs(itemInfo) do
        if type == "itemID" then continue end
        if type == "entID" then continue end

        row.parts[type] = self:CreatePart(itemID, type, info)
        rowScroll:AddPanel(row.parts[type])
    end

    for _, part in pairs(self.parts) do
        part:SetWide(self.partWidths[part.type])
    end

    return row
end

function PANEL:GetName(name)
    if name == "data" then return L("qolItemsInfoData") end
    if name == "invID" then return L("qolItemsInfoInvID") end
    if name == "name" then return L("qolItemsInfoName") end
    if name == "origin" then return L("qolItemsInfoOrigin") end
    if name == "wPosition" then return L("qolItemsInfoWPosition") end
    if name == "owner" then return L("qolItemsInfoOwner") end
end

function PANEL:CreatePart(itemID, name, info)
    local part = vgui.Create("Panel")
    part:Dock(LEFT)
    part.type = name
    if name == "name" then
        part:SetZPos( 0 )
    elseif name == "owner" then
        part:SetZPos(1)
    elseif name == "invID" then
        part:SetZPos(2)
    elseif name == "origin" then
        part:SetZPos(3)
    elseif name == "wPosition" then
        part:SetZPos(4)
    elseif name == "data" then
        part:SetZPos(5)
    end
    
    local title = part:Add("DLabel")
    title:Dock(TOP)
    title:SetText(self:GetName(name))
    title:SetFont("MenuFontBoldNoClamp")
    title:SizeToContents()
    title:DockMargin(0, SScaleMin(20 / 3), 0, 0)

    local horizontalDiv = part:Add("DShape")
    horizontalDiv:Dock(TOP)
    horizontalDiv:SetType("Rect")
    horizontalDiv:SetColor(Color(111, 111, 136, (255 / 100 * 30)))
    horizontalDiv:SetTall(1)
    horizontalDiv:DockMargin(0, SScaleMin(2), 0, SScaleMin(2))

    part.bottomPart = part:Add("Panel")
    part.bottomPart:Dock(FILL)

    local content = part.bottomPart:Add(name == "wPosition" and "DButton" or "DLabel")
    content:Dock(LEFT)
    content:DockMargin(0, 0, padding, SScaleMin(20 / 3))
    content:SetFont("MenuFontBoldNoClamp")
    local text = tostring(info)..(name == "name" and " #"..itemID or "")
    if !text then text = "N/A" end
    if text == "0" and name == "invID" then text = "World Inventory" end
    if istable(info) then
        text = ""
        for key, value in pairs(info) do
            text = text..Schema:FirstToUpper(key)..": "..(!value and "N/A" or istable(value) and table.ToString(value) or tostring(value) or "N/A").." | "
        end
    end

    content:SetText((text == "" and "N/A" or name == "wPosition" and text != "N/A" and "Go to" or text))
    content:SizeToContents()
    if name == "wPosition" then
        content:SetWide(content:GetWide() + SScaleMin(10 / 3))
    end

    if name == "wPosition" then
        content.DoClick = function()
            if text == "N/A" or text == "" or !text then return end

            if isvector(Vector(text)) then
                net.Start("ixGoToItemPos")
                net.WriteVector(Vector(text))
                net.SendToServer()
            end
        end
    end

    part:SetWide(math.max(content:GetWide(), title:GetWide()) + (padding * 2))
    self.parts[#self.parts + 1] = part

    local partWidth = self.partWidths[name]

    if partWidth then
        self.partWidths[name] = math.max(part:GetWide(), self.partWidths[name])
    else
        self.partWidths[name] = part:GetWide()
    end

    return part
end

vgui.Register("ixFindItemInfo", PANEL, "EditablePanel")