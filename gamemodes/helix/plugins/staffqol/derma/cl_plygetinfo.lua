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
	self.titleText:SetText(L("qolPlyInfo"))
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

function PANEL:Populate(plyInfo)
    steamworks.RequestPlayerInfo( plyInfo.player.steamID64, function( steamName )
        local miscInfo = self.innerSelf:Add("Panel")
        miscInfo:Dock(TOP)

        local characters = miscInfo:Add("DLabel")
        characters:SetFont("WNBleedingTextNoClamp")
        characters:Dock(LEFT)
        characters:SetText(steamName.."'s "..L("qolCharacters"))
        characters:DockMargin(padding, 0, 0, padding)
        characters:SetContentAlignment(4)
        characters:SizeToContents()

        local divider = miscInfo:Add("Panel")
        self:CreateDivider(divider)
        divider:Dock(LEFT)
        divider:DockMargin(padding, 0, padding, padding)

        local otherInfo = miscInfo:Add("DLabel")
        otherInfo:Dock(LEFT)
        otherInfo:SetFont("WNBleedingTextNoClamp")
        otherInfo:SetText(L("qolHP")..": "..plyInfo.player.curHp..", "..L("qolArmor")..": "..plyInfo.player.curArmor..", "..L("qolPlayerFlags")..": "..(plyInfo.player.playerFlags == "" and "N/A" or plyInfo.player.playerFlags))
        otherInfo:DockMargin(0, 0, 0, padding)
        otherInfo:SetContentAlignment(4)
        otherInfo:SizeToContents()

        miscInfo:SetTall(characters:GetTall() + SScaleMin(10 / 3))
    
        local count = 0
        for charID, charInfo in pairs(plyInfo) do
            if !isnumber(charID) then continue end
            count = count + 1
    
            self:CreateCharRow(count, charID, charInfo)
        end
        
        local bottompanel = self.content:Add("Panel")
        bottompanel:Dock(BOTTOM)
        bottompanel:SetSize(self.content:GetWide(), SScaleMin(50 / 3))

        local copySteamID = bottompanel:Add("DButton")
        copySteamID:Dock(LEFT)
        copySteamID:SetFont("MenuFontNoClamp")
        copySteamID:SetText(L("qolCopySteamID"))
        copySteamID:SizeToContents()
        copySteamID:SetWide(bottompanel:GetWide() / 2)
        copySteamID.DoClick = function()
            SetClipboardText( plyInfo.player.steamID )
            LocalPlayer():NotifyLocalized(L("qolCopiedSteamID"))
        end

        local seeWhitelists = bottompanel:Add("DButton")
        seeWhitelists:Dock(FILL)
        seeWhitelists:SetFont("MenuFontNoClamp")
        seeWhitelists:SetText(L("qolSeeWhitelists"))
        seeWhitelists.DoClick = function()
            if self.popup and IsValid(self.popup) then
                self.popup:Remove()
            end

            self.popup = vgui.Create("DFrame")
            DFrameFixer(self.popup)
            self.popup:SetTitle(L("qolSeeWhitelists").." - "..steamName)
            self.popup:MakePopup()
            self.popup:SetSize(self.content:GetWide(), self.content:GetTall() - SScaleMin(100 / 3))
            local x, y = self.content:GetPos()
            self.popup:SetPos(x, y + SScaleMin(50 / 3))

            local scrollWhitelists = self.popup:Add("DScrollPanel")
            scrollWhitelists:Dock(FILL)

            if !plyInfo.player then return end
            if !plyInfo.player.whitelists then return end
            if !plyInfo.player.whitelists.ixhl2rp then return end

            for whitelist, _ in pairs(plyInfo.player.whitelists.ixhl2rp) do
                local whitelistName = scrollWhitelists:Add("DLabel")
                whitelistName:Dock(TOP)
                whitelistName:SetContentAlignment(5)
                whitelistName:SetText(string.utf8upper(whitelist))
                whitelistName:SetFont("MenuFontBoldNoClamp")
                whitelistName:SizeToContents()
                whitelistName:DockMargin(0, SScaleMin(20 / 3), 0, 0)
            end
        end
    end )
end

function PANEL:Think()
    if self.popup and IsValid(self.popup) then
        self.popup:MoveToFront()
    end
end

function PANEL:CreateCharRow(count, charID, charInfo)
    local row = self.innerSelf:Add("Panel")
    row:DockMargin(padding, 0, padding, 0)
    row:DockPadding(padding, 0, padding, 0)
    row:SetTall(SScaleMin(90 / 3))
    row:Dock(TOP)

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

    for type, info in pairs(charInfo) do
        local part = self:CreatePart(type, info)
        rowScroll:AddPanel(part)
    end
end

function PANEL:GetName(id)
    if id == 1 then return L("qolName") end
    if id == 2 then return L("qolLanguages") end
    if id == 3 then return L("qolFlags") end
    if id == 4 then return L("qolTempFlags") end
    if id == 5 then return L("qolGroupName") end
end

function PANEL:CreatePart(name, info)
    local part = vgui.Create("Panel")
    part:Dock(LEFT)
    
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

    local content = part:Add("DLabel")
    content:Dock(BOTTOM)
    content:DockMargin(0, 0, padding, SScaleMin(20 / 3))
    content:SetFont("MenuFontBoldNoClamp")
    local text = info
    if istable(info) then
        if name == 2 then
            text = ""
            for _, langID in pairs(info) do
                local lang = ix.languages:FindByID(langID)

                if text == "" then
                    text = lang.name
                else
                    text = text..", "..lang.name
                end
            end
        elseif name == 4 then
            text = ""
            for flag, _ in pairs(info) do
                text = text..flag
            end
        end
    end

    content:SetText((text == "" and "N/A" or text))
    content:SizeToContents()

    part:SetWide(math.max(content:GetWide(), title:GetWide()) + (padding * 2))

    return part
end

vgui.Register("ixPlyGetInfo", PANEL, "EditablePanel")