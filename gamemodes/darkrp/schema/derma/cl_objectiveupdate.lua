--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

DEFINE_BASECLASS("Panel")

surface.CreateFont( "ObjectiveUpdateFont", {
    font = "Open Sans Bold",
    extended = false,
    size = math.Clamp(SScaleMin(24), 0, 72),
    weight = 550,
    antialias = true,
    scanlines = 4,
    shadow = true
} )

surface.CreateFont( "ObjectiveUpdateFontBackground", {
    font = "Open Sans Bold",
    extended = false,
    size = math.Clamp(SScaleMin(24), 0, 72),
    weight = 550,
    antialias = true,
    scanlines = 4,
    blursize = 10
} )

local redClr = Color(205, 11, 11)

local PANEL = {}

function PANEL:DrawCorners(x, y, w, h)
	local length = 12
	local thickness = 3

	surface.DrawRect(x, y, length, thickness) -- Top Left
	surface.DrawRect(x, y, thickness, length)

	surface.DrawRect(x + (w - length), y, length, thickness) -- Top Right
	surface.DrawRect(x + (w - thickness), y, thickness, length)

	surface.DrawRect(x, y + (h - length), thickness, length) -- Bottom Left
	surface.DrawRect(x, y + (h - thickness), length, thickness)

	surface.DrawRect(x + (w - thickness), y + (h - length), thickness, length) -- Bottom Right
	surface.DrawRect(x + (w - length), y + (h - thickness), length, thickness)
end

function PANEL:Init()
	self:SetSize(SScaleMin(800 / 3), 1)
    self:Center()
    self:CenterVertical(0.25)

    surface.PlaySound("ambience/3d-sounds/ota/otachatter1.mp3")
    surface.PlaySound("willardnetworks/datapad/open.wav")

    self.objectiveText = self:Add("DLabel")
    self.objectiveText:Dock(FILL)
    self.objectiveText:SetFont("ObjectiveUpdateFont")
    self.objectiveText:SetContentAlignment(5)
    self.objectiveText:SetTextColor(redClr)
    self.objectiveText:SetText("NEW OBJECTIVE RECEIVED")

    self.secondObjectiveText = self:Add("DLabel")
    self.secondObjectiveText:Dock(FILL)
    self.secondObjectiveText:SetFont("ObjectiveUpdateFontBackground")
    self.secondObjectiveText:SetContentAlignment(5)
    self.secondObjectiveText:SetTextColor(redClr)
    self.secondObjectiveText:SetText("NEW OBJECTIVE RECEIVED")

    self:SizeTo(-1, SScaleMin(80 / 3), 0.4, 0, nil, function()
        self:SizeTo(1, -1, 0.5, 2, nil, function()
            surface.PlaySound("willardnetworks/datapad/close.wav")
            self:Remove()
        end)
    end)
end

function PANEL:Paint(w, h)
	if (!LocalPlayer():HasActiveCombineMask() and !LocalPlayer():IsDispatch()) then
		return
	end

	surface.SetDrawColor(31, 30, 30, 75) -- Background
	surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(245, 138, 138, 75)
	self:DrawCorners(0, 0, w, h)
end


vgui.Register("ixObjectiveUpdate", PANEL, "Panel")