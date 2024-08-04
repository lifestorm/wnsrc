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

function PANEL:Init()
	self:SetSize(SScaleMin(900 / 3), SScaleMin(100 / 3))
	self:Center()
	self:MakePopup()
	self.Paint = function(this, w, h)
        self:PaintStuff(this, w, h)
    end

	local topbar = self:Add("Panel")
	topbar:SetSize(self:GetWide(), SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function( this, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("Handwriting Style")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()

		surface.PlaySound("helix/ui/press.wav")
	end

	local buttonBox = self:Add("Panel")
	buttonBox:Dock(TOP)
	buttonBox:SetTall(SScaleMin(50 / 3))

	self:CreateFontButton(buttonBox, "BookSatisfy", "Satisfy")
	self:CreateFontButton(buttonBox, "BookChilanka", "Chilanka")
	self:CreateFontButton(buttonBox, "BookAmita", "Amita")
	self:CreateFontButton(buttonBox, "BookHandlee", "Handlee")
	self:CreateFontButton(buttonBox, "BookDancing", "Dancing")
	self:CreateFontButton(buttonBox, "BookTimes", "Times")
	self:CreateFontButton(buttonBox, "BookTypewriter", "Typewriter")
end

function PANEL:Think()
	if (self) then
		self:MoveToFront()
	end
end

function PANEL:CreateFontButton(buttonBox, font, text)
    local button = buttonBox:Add("DButton")
    button:Dock(LEFT)
    button:SetWide(self:GetWide() / 7)
    button:SetText(text)
    button:SetFont(font)
    button:SetContentAlignment(5)
    button.Paint = function(this, w, h)
        self:PaintStuff(this, w, h)
    end

    button.DoClick = function()
        netstream.Start("ixWritingSetHandWriting", font)
        LocalPlayer():NotifyLocalized("You've successfully chosen your handwriting to be "..text)
        self:Remove()
    end
end

function PANEL:PaintStuff(this, w, h)
    surface.SetDrawColor(Color(0, 0, 0, 100))
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
    surface.DrawOutlinedRect(0, 0, w, h)
end

vgui.Register("ixWritingHandwritingSelector", PANEL, "Panel")