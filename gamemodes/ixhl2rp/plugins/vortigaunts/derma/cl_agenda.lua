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

surface.CreateFont("VortAgendaFont", {
    font = "Norse",
    extended = false,
    size = math.Clamp(SScaleMin(24), 0, 72),
    weight = 550,
    antialias = true,
    scanlines = 0,
    shadow = true
})

local PANEL = {}

function PANEL:Init()
    self:SetSize(SScaleMin(900 / 3), -1)
    self:Center()
    self:CenterVertical(0.25)

    surface.PlaySound("ambience/3d-sounds/xen-vorts/whispertrail2.mp3")

    self.agendaText = self:Add("DLabel")
    self.agendaText:Dock(FILL)
    self.agendaText:SetFont("VortAgendaFont")
    self.agendaText:SetContentAlignment(5)
    self.agendaText:SetTextColor(Color(11, 205, 18, 157))
    self.agendaText:SetText("THE VORTIGAUNT DECREES...")

    self:SizeTo(SScaleMin(900 / 3), SScaleMin(150 / 3), 1, 0, 0.5, function()
        self:SizeTo(SScaleMin(900 / 3), 0, 1, 4, 0.5, function()
            PLUGIN.conterminousAgenda = nil
            self:Remove()
        end)
    end)
end

function PANEL:Paint(w, h)
    if (!LocalPlayer():IsVortigaunt() or LocalPlayer():IsVortigaunt() and LocalPlayer():GetNetVar("ixVortNulled")) then
		return
	end

    local mat = Material("willardnetworks/vortessence.png")

    surface.SetDrawColor(255, 255, 255, 66)
    surface.SetMaterial(mat)
    surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("ixconterminousAgenda", PANEL, "Panel")