--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN
local PANEL = {}

local padding = SScaleMin(10 / 3)

function PANEL:Init()
    self.titleValues = {}
    self.titleValues[1] = ix.config.Get("eventCreditsImageW", 1)
    self.titleValues[2] = ix.config.Get("eventCreditsImageH", 1)
    self.titleValues[3] = ix.config.Get("eventCreditsImageURL", "URL")

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

    self.creditsPanels = {}

	self:CreateTopBar()

    local saveOrEdit = self.content:Add("Panel")
    saveOrEdit:Dock(BOTTOM)
    saveOrEdit:SetTall(SScaleMin(50 / 3))
    
    local save = saveOrEdit:Add("DButton")
    save:Dock(LEFT)
    save:SetWide(self.content:GetWide() * 0.5)
    save:SetText("SAVE")
    save:SetFont("MenuFontBoldNoClamp")
    save.DoClick = function()
        netstream.Start("EventCreditsSaveTitleValues", self.titleValues, PLUGIN.creditsMembers)
    end

    local add = saveOrEdit:Add("DButton")
    add:Dock(FILL)
    add:SetText("ADD")
    add:SetFont("MenuFontBoldNoClamp")
    add.DoClick = function()
        Derma_StringRequest(
            "Name",
            "Input the string name of the player to appear on the credits.",
            "",
            function(text)
                PLUGIN.creditsMembers[#PLUGIN.creditsMembers + 1] = text
                self:CreateCreditsMembers()
            end
        )
    end

	self.innerSelf = self.content:Add("DScrollPanel")
	self.innerSelf:SetTall(SScaleMin(600 / 3) - SScaleMin(120 / 3))
	self.innerSelf:Dock(TOP)

    self:CreateTitleImageStuff()
    self:CreateCreditsMembers()
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
	self.titleText:SetText("Event Credits Editor")
	self.titleText:DockMargin(padding, 0, 0, 0)
	self.titleText:SetContentAlignment(4)
	self.titleText:SizeToContents()

	local exit = self.topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), padding, SScaleMin(15 / 3))
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

function PANEL:CreateTitleImageStuff()
    local title = self.innerSelf:Add("DLabel")
    title:Dock(TOP)
    title:SetFont("MenuFontLargerBoldNoFix")
    title:SetText("Title Image:")
    title:SizeToContents()
    title:SetContentAlignment(4)
    title:DockMargin(padding, 0, 0, padding)

    for i = 1, 3 do
        local textEntry = self.innerSelf:Add("DTextEntry")
        textEntry:Dock(TOP)
        textEntry:SetTall(SScaleMin(30 / 3))
        textEntry:SetFont("MenuFontNoClamp")
        textEntry:DockMargin(padding, 0, padding, padding)
        textEntry:SetText((i == 1 and ix.config.Get("eventCreditsImageW", 1) or i == 2 and ix.config.Get("eventCreditsImageH", 1) or i == 3 and ix.config.Get("eventCreditsImageURL", "URL")))
        textEntry:SetPlaceholderText((i == 1 and "Title Image Width In Pixels" or i == 2 and "Title Image Height In Pixels" or i == 3 and "Title Image URL") or "")

        textEntry.OnTextChanged = function()
            self.titleValues[i] = textEntry:GetText()
        end
    end
end

function PANEL:CreateCreditsMembers()
    for _, v in pairs(self.creditsPanels) do
        v:Remove()
    end

    self.creditsPanels = {}

    local title = self.innerSelf:Add("DLabel")
    title:Dock(TOP)
    title:SetFont("MenuFontLargerBoldNoFix")
    title:SetText("Credits Members:")
    title:SizeToContents()
    title:SetContentAlignment(4)
    title:DockMargin(padding, 0, 0, padding)
    table.insert(self.creditsPanels, title)

    for key, name in pairs(PLUGIN.creditsMembers) do
        local panel = self.innerSelf:Add("Panel")
        panel:Dock(TOP)
        panel:SetTall(SScaleMin(25 / 3))
        panel:DockMargin(padding, 0, 0, padding)

        local label = panel:Add("DLabel")
        label:Dock(LEFT)
        label:SetFont("MenuFontBoldNoClamp")
        label:SetText(name or "")
        label:SizeToContents()
        label:SetContentAlignment(4)

        local remove = panel:Add("DImageButton")
        remove:SetImage("willardnetworks/tabmenu/navicons/exit.png")
        remove:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
        remove:DockMargin(padding, SScaleMin(5 / 3) / 2, 0, SScaleMin(5 / 3) / 2)
        remove:Dock(LEFT)
        remove.DoClick = function()
            panel:Remove()
            PLUGIN.creditsMembers[key] = nil
            surface.PlaySound("helix/ui/press.wav")
        end

        table.insert(self.creditsPanels, panel)
    end
end

vgui.Register("ixEventCreditsEditor", PANEL, "Panel")